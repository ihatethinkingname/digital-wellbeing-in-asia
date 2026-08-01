param(
    [switch]$Once,
    [string]$RscriptPath = "C:\Program Files\R\R-4.5.2\bin\Rscript.exe"
)

$workspace = Resolve-Path "."
$watchFiles = @(
    (Join-Path $workspace "final.rmd"),
    (Join-Path $workspace "filtered_by_topics_with_url.csv")
)

function Render-Report {
    Write-Host "[watch_render] Rendering report at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')..."
    & "$RscriptPath" -e "if (!requireNamespace('rmarkdown', quietly=TRUE)) install.packages('rmarkdown', repos='https://cloud.r-project.org'); rmarkdown::render('final.rmd', output_dir='.', clean=TRUE)" 2>&1 | Write-Host
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[watch_render] Render succeeded. Output: final.html"
    } else {
        Write-Host "[watch_render] Render failed with exit code $LASTEXITCODE" -ForegroundColor Red
    }
}

if ($Once) {
    Render-Report
    exit $LASTEXITCODE
}

if (-not (Test-Path "$RscriptPath")) {
    Write-Error "Rscript.exe not found at $RscriptPath. Please update the RscriptPath parameter in watch_render.ps1."
    exit 1
}

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $workspace
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$lastRun = [datetime]::MinValue
$delaySeconds = 2

$action = {
    $path = $Event.SourceEventArgs.FullPath
    if ($watchFiles -contains $path) {
        $now = Get-Date
        if (($now - $lastRun).TotalSeconds -ge $delaySeconds) {
            $lastRun = $now
            Render-Report
        }
    }
}

Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Created -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $action | Out-Null

Write-Host "[watch_render] Watching changes for: final.rmd, filtered_by_topics_with_url.csv"
Write-Host "[watch_render] Press Ctrl+C to stop."
Render-Report

while ($true) {
    Start-Sleep -Seconds 1
}
