# Check that implementation plan exists and find optional design documents
# Usage: .\check-task-prerequisites.ps1 [-Json]

param(
    [switch]$Json,
    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: .\check-task-prerequisites.ps1 [-Json]"
    exit 0
}

# Source common functions
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $scriptDir "common.ps1")

# Get all paths
$paths = Get-FeaturePaths

# Check if on feature branch
if (-not (Test-FeatureBranch $paths.CURRENT_BRANCH)) {
    exit 1
}

# Check if feature directory exists
if (-not (Test-Path $paths.FEATURE_DIR -PathType Container)) {
    Write-Error "ERROR: Feature directory not found: $($paths.FEATURE_DIR)"
    Write-Error "Run /specify first to create the feature structure."
    exit 1
}

# Check for implementation plan (required)
if (-not (Test-Path $paths.IMPL_PLAN -PathType Leaf)) {
    Write-Error "ERROR: plan.md not found in $($paths.FEATURE_DIR)"
    Write-Error "Run /plan first to create the plan."
    exit 1
}

if ($Json) {
    # Build JSON array of available docs that actually exist
    $docs = @()
    if (Test-Path $paths.RESEARCH -PathType Leaf) { $docs += "research.md" }
    if (Test-Path $paths.SECURITY_RESEARCH -PathType Leaf) { $docs += "security-research.md" }
    if (Test-Path $paths.DATA_MODEL -PathType Leaf) { $docs += "data-model.md" }
    if (Test-Path $paths.SECURITY_ARCHITECTURE -PathType Leaf) { $docs += "security-architecture.md" }
    if ((Test-Path $paths.CONTRACTS_DIR -PathType Container) -and ((Get-ChildItem $paths.CONTRACTS_DIR -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0)) { $docs += "contracts/" }
    if (Test-Path $paths.QUICKSTART -PathType Leaf) { $docs += "quickstart.md" }
    
    $result = @{
        FEATURE_DIR = $paths.FEATURE_DIR
        AVAILABLE_DOCS = $docs
    }
    $result | ConvertTo-Json -Compress
} else {
    # List available design documents (optional)
    Write-Host "FEATURE_DIR:$($paths.FEATURE_DIR)"
    Write-Host "AVAILABLE_DOCS:"

    # Use common check functions
    Test-File $paths.RESEARCH "research.md"
    Test-File $paths.SECURITY_RESEARCH "security-research.md"
    Test-File $paths.DATA_MODEL "data-model.md"
    Test-File $paths.SECURITY_ARCHITECTURE "security-architecture.md"
    Test-Directory $paths.CONTRACTS_DIR "contracts/"
    Test-File $paths.QUICKSTART "quickstart.md"
}

# Always succeed - task generation should work with whatever docs are available
