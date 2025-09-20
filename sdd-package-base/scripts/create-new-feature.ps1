# Create a new feature with branch, directory structure, and template
# Usage: .\create-new-feature.ps1 "feature description"
#        .\create-new-feature.ps1 -Json "feature description"

param(
    [switch]$Json,
    [switch]$Help,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$FeatureDescription
)

if ($Help) {
    Write-Host "Usage: .\create-new-feature.ps1 [-Json] <feature_description>"
    exit 0
}

$description = $FeatureDescription -join " "
if ([string]::IsNullOrWhiteSpace($description)) {
    Write-Error "Usage: .\create-new-feature.ps1 [-Json] <feature_description>"
    exit 1
}

# Get repository root
$repoRoot = git rev-parse --show-toplevel
$specsDir = Join-Path $repoRoot "specs"

# Create specs directory if it doesn't exist
if (-not (Test-Path $specsDir -PathType Container)) {
    New-Item -ItemType Directory -Path $specsDir -Force | Out-Null
}

# Find the highest numbered feature directory
$highest = 0
if (Test-Path $specsDir -PathType Container) {
    $dirs = Get-ChildItem $specsDir -Directory
    foreach ($dir in $dirs) {
        $dirname = $dir.Name
        if ($dirname -match '^(\d+)') {
            $number = [int]$matches[1]
            if ($number -gt $highest) {
                $highest = $number
            }
        }
    }
}

# Generate next feature number with zero padding
$next = $highest + 1
$featureNum = "{0:D3}" -f $next

# Create branch name from description
$branchName = $description.ToLower()
$branchName = $branchName -replace '[^a-z0-9]', '-'
$branchName = $branchName -replace '-+', '-'
$branchName = $branchName -replace '^-', ''
$branchName = $branchName -replace '-$', ''

# Extract 2-3 meaningful words
$words = $branchName -split '-' | Where-Object { $_ -ne '' } | Select-Object -First 3
$wordsString = $words -join '-'

# Final branch name
$branchName = "$featureNum-$wordsString"

# Create and switch to new branch
git checkout -b $branchName

# Create feature directory
$featureDir = Join-Path $specsDir $branchName
New-Item -ItemType Directory -Path $featureDir -Force | Out-Null

# Copy template if it exists
$template = Join-Path $repoRoot "templates" "spec-template.md"
$specFile = Join-Path $featureDir "spec.md"

if (Test-Path $template -PathType Leaf) {
    Copy-Item $template $specFile
} else {
    Write-Warning "Template not found at $template"
    New-Item -ItemType File -Path $specFile -Force | Out-Null
}

if ($Json) {
    $result = @{
        BRANCH_NAME = $branchName
        SPEC_FILE = $specFile
        FEATURE_NUM = $featureNum
    }
    $result | ConvertTo-Json -Compress
} else {
    # Output results for the LLM to use (legacy key: value format)
    Write-Host "BRANCH_NAME: $branchName"
    Write-Host "SPEC_FILE: $specFile"
    Write-Host "FEATURE_NUM: $featureNum"
}
