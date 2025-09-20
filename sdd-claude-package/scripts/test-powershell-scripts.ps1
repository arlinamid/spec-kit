# Test script to verify PowerShell scripts work correctly
# This script tests basic functionality without making actual changes

Write-Host "Testing PowerShell script conversions..." -ForegroundColor Cyan

# Test 1: Check if common.ps1 loads correctly
Write-Host "`n1. Testing common.ps1..." -ForegroundColor Yellow
try {
    . (Join-Path $PSScriptRoot "common.ps1")
    Write-Host "✓ common.ps1 loaded successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to load common.ps1: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Test Get-RepoRoot function
Write-Host "`n2. Testing Get-RepoRoot..." -ForegroundColor Yellow
$repoRoot = $null
try {
    $repoRoot = Get-RepoRoot
} catch {
    Write-Host "✗ Get-RepoRoot failed: $($_.Exception.Message)" -ForegroundColor Red
}

if ($repoRoot -and (Test-Path $repoRoot -PathType Container)) {
    Write-Host "✓ Get-RepoRoot works: $repoRoot" -ForegroundColor Green
} else {
    Write-Host "✗ Get-RepoRoot returned invalid path: $repoRoot" -ForegroundColor Red
}

# Test 3: Test Get-CurrentBranch function
Write-Host "`n3. Testing Get-CurrentBranch..." -ForegroundColor Yellow
$currentBranch = $null
try {
    $currentBranch = Get-CurrentBranch
} catch {
    Write-Host "✗ Get-CurrentBranch failed: $($_.Exception.Message)" -ForegroundColor Red
}

if ($currentBranch) {
    Write-Host "✓ Get-CurrentBranch works: $currentBranch" -ForegroundColor Green
} else {
    Write-Host "✗ Get-CurrentBranch returned empty result" -ForegroundColor Red
}

# Test 4: Test Get-FeaturePaths function
Write-Host "`n4. Testing Get-FeaturePaths..." -ForegroundColor Yellow
$paths = $null
try {
    $paths = Get-FeaturePaths
} catch {
    Write-Host "✗ Get-FeaturePaths failed: $($_.Exception.Message)" -ForegroundColor Red
}

if ($paths -and $paths.REPO_ROOT -and $paths.CURRENT_BRANCH) {
    Write-Host "✓ Get-FeaturePaths works" -ForegroundColor Green
    Write-Host "  REPO_ROOT: $($paths.REPO_ROOT)"
    Write-Host "  CURRENT_BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Host "  FEATURE_DIR: $($paths.FEATURE_DIR)"
} else {
    Write-Host "✗ Get-FeaturePaths returned incomplete data" -ForegroundColor Red
}

# Test 5: Test get-feature-paths.ps1 script
Write-Host "`n5. Testing get-feature-paths.ps1..." -ForegroundColor Yellow
$output = $null
$exitCode = 0
try {
    $output = & (Join-Path $PSScriptRoot "get-feature-paths.ps1") 2>&1
    $exitCode = $LASTEXITCODE
} catch {
    Write-Host "✗ get-feature-paths.ps1 failed: $($_.Exception.Message)" -ForegroundColor Red
}

if ($exitCode -eq 0) {
    Write-Host "✓ get-feature-paths.ps1 executed successfully" -ForegroundColor Green
} else {
    Write-Host "✗ get-feature-paths.ps1 failed with exit code: $exitCode" -ForegroundColor Red
    Write-Host "Output: $output" -ForegroundColor Red
}

# Test 6: Test JSON output
Write-Host "`n6. Testing JSON output..." -ForegroundColor Yellow
$jsonOutput = $null
$jsonExitCode = 0
try {
    $jsonOutput = & (Join-Path $PSScriptRoot "get-feature-paths.ps1") -Json 2>&1
    $jsonExitCode = $LASTEXITCODE
} catch {
    Write-Host "✗ JSON output failed: $($_.Exception.Message)" -ForegroundColor Red
}

if ($jsonExitCode -eq 0 -and $jsonOutput -match '^{.*}$') {
    Write-Host "✓ JSON output works correctly" -ForegroundColor Green
} else {
    Write-Host "✗ JSON output failed" -ForegroundColor Red
    Write-Host "Output: $jsonOutput" -ForegroundColor Red
}

Write-Host "`nTesting completed!" -ForegroundColor Cyan
Write-Host "Note: Some tests may fail if you're not on a feature branch (001-* format)" -ForegroundColor Yellow