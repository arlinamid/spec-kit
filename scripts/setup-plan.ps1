# Setup implementation plan structure for current branch
# Returns paths needed for implementation plan generation
# Usage: .\setup-plan.ps1 [-Json]

param(
    [switch]$Json,
    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: .\setup-plan.ps1 [-Json]"
    exit 0
}

# Source common functions
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $scriptDir "common.ps1")

# Get all paths
$paths = Get-FeaturePaths

# Validate paths
if ([string]::IsNullOrWhiteSpace($paths.REPO_ROOT)) {
    Write-Error "ERROR: Not in a git repository"
    exit 1
}

# Check if on feature branch
if (-not (Test-FeatureBranch $paths.CURRENT_BRANCH)) {
    exit 1
}

# Create specs directory if it doesn't exist
if (-not (Test-Path $paths.FEATURE_DIR -PathType Container)) {
    New-Item -ItemType Directory -Path $paths.FEATURE_DIR -Force | Out-Null
}

# Copy plan template if it exists
$template = Join-Path (Join-Path $paths.REPO_ROOT "templates") "plan-template.md"
if (Test-Path $template -PathType Leaf) {
    Copy-Item $template $paths.IMPL_PLAN
}

if ($Json) {
    $result = @{
        FEATURE_SPEC = $paths.FEATURE_SPEC
        IMPL_PLAN = $paths.IMPL_PLAN
        SPECS_DIR = $paths.FEATURE_DIR
        BRANCH = $paths.CURRENT_BRANCH
    }
    $result | ConvertTo-Json -Compress
} else {
    # Output all paths for LLM use
    Write-Host "FEATURE_SPEC: $($paths.FEATURE_SPEC)"
    Write-Host "IMPL_PLAN: $($paths.IMPL_PLAN)"
    Write-Host "SPECS_DIR: $($paths.FEATURE_DIR)"
    Write-Host "BRANCH: $($paths.CURRENT_BRANCH)"
}
