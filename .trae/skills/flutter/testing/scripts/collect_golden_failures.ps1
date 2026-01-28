param(
  [Parameter(Mandatory = $true)]
  [ValidateSet("1", "2", "3")]
  [string]$Attempt,

  [Parameter(Mandatory = $true)]
  [string]$Page,

  [string]$FailureSource = "assets/base_image_testing/golden/failures",
  [string]$AttemptRoot = ".trae/skills/flutter/testing",

  [switch]$SkipClear
)

$ErrorActionPreference = "Stop"

$attemptDir = Join-Path $AttemptRoot "attempt_${Attempt}"
$destDir = Join-Path $attemptDir "failured/$Page"

New-Item -ItemType Directory -Force -Path $destDir | Out-Null

if (-not (Test-Path $FailureSource)) {
  Write-Host "No failure folder found at: $FailureSource"
  exit 0
}

$items = Get-ChildItem -Force -Path $FailureSource -ErrorAction SilentlyContinue
if ($null -eq $items -or $items.Count -eq 0) {
  Write-Host "No failures to collect for attempt $Attempt."
  exit 0
}

Copy-Item -Recurse -Force -Path (Join-Path $FailureSource "*") -Destination $destDir

if (-not $SkipClear) {
  Remove-Item -Recurse -Force -Path (Join-Path $FailureSource "*")
}

Write-Host "Collected failures into: $destDir"
