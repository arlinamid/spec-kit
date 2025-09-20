# Common functions and variables for all PowerShell scripts

# Get repository root
function Get-RepoRoot {
    git rev-parse --show-toplevel
}

# Get current branch
function Get-CurrentBranch {
    git rev-parse --abbrev-ref HEAD
}

# Check if current branch is a feature branch
# Returns $true if valid, $false if not
function Test-FeatureBranch {
    param([string]$Branch)
    
    if ($Branch -notmatch '^\d{3}-') {
        Write-Error "ERROR: Not on a feature branch. Current branch: $Branch"
        Write-Error "Feature branches should be named like: 001-feature-name"
        return $false
    }
    return $true
}

# Get feature directory path
function Get-FeatureDir {
    param(
        [string]$RepoRoot,
        [string]$Branch
    )
    return Join-Path (Join-Path $RepoRoot "specs") $Branch
}

# Get all standard paths for a feature
# Returns hashtable with all paths
function Get-FeaturePaths {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    $featureDir = Get-FeatureDir $repoRoot $currentBranch
    
    return @{
        REPO_ROOT = $repoRoot
        CURRENT_BRANCH = $currentBranch
        FEATURE_DIR = $featureDir
        FEATURE_SPEC = Join-Path $featureDir "spec.md"
        IMPL_PLAN = Join-Path $featureDir "plan.md"
        TASKS = Join-Path $featureDir "tasks.md"
        RESEARCH = Join-Path $featureDir "research.md"
        SECURITY_RESEARCH = Join-Path $featureDir "security-research.md"
        DATA_MODEL = Join-Path $featureDir "data-model.md"
        SECURITY_ARCHITECTURE = Join-Path $featureDir "security-architecture.md"
        QUICKSTART = Join-Path $featureDir "quickstart.md"
        CONTRACTS_DIR = Join-Path $featureDir "contracts"
    }
}

# Check if a file exists and report
function Test-File {
    param(
        [string]$FilePath,
        [string]$Description
    )
    
    if (Test-Path $FilePath -PathType Leaf) {
        Write-Host "  ✓ $Description" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ✗ $Description" -ForegroundColor Red
        return $false
    }
}

# Check if a directory exists and has files
function Test-Directory {
    param(
        [string]$DirPath,
        [string]$Description
    )
    
    if ((Test-Path $DirPath -PathType Container) -and ((Get-ChildItem $DirPath -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0)) {
        Write-Host "  ✓ $Description" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ✗ $Description" -ForegroundColor Red
        return $false
    }
}

# Convert paths to environment variables for compatibility with bash-style scripts
function Set-FeaturePathsAsEnvVars {
    $paths = Get-FeaturePaths
    foreach ($key in $paths.Keys) {
        Set-Variable -Name $key -Value $paths[$key] -Scope Global
    }
}
