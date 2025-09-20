# Get paths for current feature branch without creating anything
# Used by commands that need to find existing feature files

param(
    [switch]$Json
)

# Source common functions
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $scriptDir "common.ps1")

# Get all paths
$paths = Get-FeaturePaths

# Check if on feature branch
if (-not (Test-FeatureBranch $paths.CURRENT_BRANCH)) {
    exit 1
}

# Output paths (don't create anything)
if ($Json) {
    $paths | ConvertTo-Json -Compress
} else {
    Write-Host "REPO_ROOT: $($paths.REPO_ROOT)"
    Write-Host "BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Host "FEATURE_DIR: $($paths.FEATURE_DIR)"
    Write-Host "FEATURE_SPEC: $($paths.FEATURE_SPEC)"
    Write-Host "IMPL_PLAN: $($paths.IMPL_PLAN)"
    Write-Host "TASKS: $($paths.TASKS)"
}
