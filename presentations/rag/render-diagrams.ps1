$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceDir = Join-Path $root "assets\diagrams\source"
$diagramDir = Join-Path $root "assets\diagrams"

Get-ChildItem -LiteralPath $sourceDir -Filter "*.mmd" | ForEach-Object {
  $source = $_
  $output = Join-Path $diagramDir ($source.BaseName + ".svg")

  & mmdc -i $source.FullName -o $output -b transparent
  if ($LASTEXITCODE -ne 0) {
    throw "Mermaid rendering failed for $($source.Name)."
  }

  $svg = Get-Content -LiteralPath $output -Raw
  $viewBox = [regex]::Match($svg, 'viewBox="(-?[\d.]+)\s+(-?[\d.]+)\s+([\d.]+)\s+([\d.]+)"')
  $rootTag = [regex]::Match($svg, '<svg\b[^>]*>')
  $id = [regex]::Match($rootTag.Value, '\bid="([^"]+)"')

  if (-not $viewBox.Success -or -not $rootTag.Success -or -not $id.Success) {
    throw "Mermaid produced an SVG with missing dimensions or ID for $($source.Name)."
  }

  $height = [math]::Round(1200 * [double]$viewBox.Groups[4].Value / [double]$viewBox.Groups[3].Value)
  $tag = $rootTag.Value -replace '\sstyle="max-width:[^"]+"', ''
  if ($tag -match '\bwidth="[^"]+"') {
    $tag = [regex]::Replace($tag, '\bwidth="[^"]+"', 'width="1200"')
  } else {
    $tag = $tag -replace '<svg\b', '<svg width="1200"'
  }
  if ($tag -match '\bheight="[^"]+"') {
    $tag = [regex]::Replace($tag, '\bheight="[^"]+"', "height=`"$height`"")
  } else {
    $tag = $tag -replace '<svg\b', "<svg height=`"$height`""
  }
  $svg = $svg.Replace($rootTag.Value, $tag)
  $svg = [regex]::Replace(
    $svg,
    '(<div xmlns="http://www.w3.org/1999/xhtml" style=")',
    '${1}font-family:Segoe UI,Arial,sans-serif;'
  )

  $extraStyle = "<style>#$($id.Groups[1].Value){font-family:'Segoe UI',Arial,sans-serif!important;} #$($id.Groups[1].Value) foreignObject div,#$($id.Groups[1].Value) foreignObject span,#$($id.Groups[1].Value) .mindmap-node-label{font-family:'Segoe UI',Arial,sans-serif!important;}</style>"
  if ($source.BaseName -in @("slide-08", "slide-09")) {
    $extraStyle = "<style>#$($id.Groups[1].Value) [class*='section-edge-']{stroke:#78D7FF!important;} #$($id.Groups[1].Value) [data-look='neo'].mindmap-node rect,#$($id.Groups[1].Value) [data-look='neo'].mindmap-node path,#$($id.Groups[1].Value) [data-look='neo'].mindmap-node circle,#$($id.Groups[1].Value) [data-look='neo'].mindmap-node polygon{fill:#173451!important;stroke:#78D7FF!important;} #$($id.Groups[1].Value) .mindmap-node-label{font-family:'Segoe UI',Arial,sans-serif!important;fill:#F5F7FB!important;}</style>"
  }

  $styleEnd = $svg.IndexOf("</style>", [StringComparison]::Ordinal)
  if ($styleEnd -lt 0) {
    throw "Mermaid produced an SVG without an embedded style block for $($source.Name)."
  }
  $svg = $svg.Insert($styleEnd + 8, $extraStyle)

  $utf8NoBom = New-Object System.Text.UTF8Encoding $false
  [System.IO.File]::WriteAllText($output, $svg, $utf8NoBom)
}
