# Incrementally update agent context files based on new feature plan
# Supports: CLAUDE.md, GEMINI.md, and .github/copilot-instructions.md
# O(1) operation - only reads current context file and new plan.md

param(
    [string]$AgentType = ""
)

$repoRoot = git rev-parse --show-toplevel
$currentBranch = git rev-parse --abbrev-ref HEAD
$featureDir = Join-Path $repoRoot "specs" $currentBranch
$newPlan = Join-Path $featureDir "plan.md"

# Determine which agent context files to update
$claudeFile = Join-Path $repoRoot "CLAUDE.md"
$geminiFile = Join-Path $repoRoot "GEMINI.md"
$copilotFile = Join-Path $repoRoot ".github" "copilot-instructions.md"

if (-not (Test-Path $newPlan -PathType Leaf)) {
    Write-Error "ERROR: No plan.md found at $newPlan"
    exit 1
}

Write-Host "=== Updating agent context files for feature $currentBranch ==="

# Extract tech from new plan
$newLang = ""
$newFramework = ""
$newTesting = ""
$newDb = ""
$newProjectType = ""

if (Test-Path $newPlan -PathType Leaf) {
    $planContent = Get-Content $newPlan -Raw
    
    # Extract language/version
    if ($planContent -match '\*\*Language/Version\*\*: (.+)') {
        $newLang = $matches[1].Trim()
        if ($newLang -eq "NEEDS CLARIFICATION") { $newLang = "" }
    }
    
    # Extract primary dependencies
    if ($planContent -match '\*\*Primary Dependencies\*\*: (.+)') {
        $newFramework = $matches[1].Trim()
        if ($newFramework -eq "NEEDS CLARIFICATION") { $newFramework = "" }
    }
    
    # Extract testing
    if ($planContent -match '\*\*Testing\*\*: (.+)') {
        $newTesting = $matches[1].Trim()
        if ($newTesting -eq "NEEDS CLARIFICATION") { $newTesting = "" }
    }
    
    # Extract storage
    if ($planContent -match '\*\*Storage\*\*: (.+)') {
        $newDb = $matches[1].Trim()
        if ($newDb -eq "N/A" -or $newDb -eq "NEEDS CLARIFICATION") { $newDb = "" }
    }
    
    # Extract project type
    if ($planContent -match '\*\*Project Type\*\*: (.+)') {
        $newProjectType = $matches[1].Trim()
    }
}

# Function to update a single agent context file
function Update-AgentFile {
    param(
        [string]$TargetFile,
        [string]$AgentName
    )
    
    Write-Host "Updating $AgentName context file: $TargetFile"
    
    # Create temp file for new context
    $tempFile = [System.IO.Path]::GetTempFileName()
    
    # If file doesn't exist, create from template
    if (-not (Test-Path $TargetFile -PathType Leaf)) {
        Write-Host "Creating new $AgentName context file..."
        
        # Check if this is the SDD repo itself
        $template = Join-Path $repoRoot "templates" "agent-file-template.md"
        if (Test-Path $template -PathType Leaf) {
            Copy-Item $template $tempFile
        } else {
            Write-Error "ERROR: Template not found at $template"
            return $false
        }
        
        # Replace placeholders
        $content = Get-Content $tempFile -Raw
        $content = $content -replace '\[PROJECT NAME\]', (Split-Path $repoRoot -Leaf)
        $content = $content -replace '\[DATE\]', (Get-Date -Format "yyyy-MM-dd")
        $content = $content -replace '\[EXTRACTED FROM ALL PLAN\.MD FILES\]', "- $newLang + $newFramework ($currentBranch)"
        
        # Add project structure based on type
        if ($newProjectType -like "*web*") {
            $content = $content -replace '\[ACTUAL STRUCTURE FROM PLANS\]', "backend/`nfrontend/`ntests/"
        } else {
            $content = $content -replace '\[ACTUAL STRUCTURE FROM PLANS\]', "src/`ntests/"
        }
        
        # Add minimal commands
        $commands = ""
        if ($newLang -like "*Python*") {
            $commands = "cd src && pytest && ruff check ."
        } elseif ($newLang -like "*Rust*") {
            $commands = "cargo test && cargo clippy"
        } elseif ($newLang -like "*JavaScript*" -or $newLang -like "*TypeScript*") {
            $commands = "npm test && npm run lint"
        } else {
            $commands = "# Add commands for $newLang"
        }
        $content = $content -replace '\[ONLY COMMANDS FOR ACTIVE TECHNOLOGIES\]', $commands
        
        # Add code style
        $content = $content -replace '\[LANGUAGE-SPECIFIC, ONLY FOR LANGUAGES IN USE\]', "$newLang : Follow standard conventions"
        
        # Add recent changes
        $content = $content -replace '\[LAST 3 FEATURES AND WHAT THEY ADDED\]', "- $currentBranch : Added $newLang + $newFramework"
        
        Set-Content $tempFile $content
    } else {
        Write-Host "Updating existing $AgentName context file..."
        
        # For complex updates, we'll use a simplified approach
        # In a real implementation, you might want to use Python or a more sophisticated text processing
        $content = Get-Content $TargetFile -Raw
        
        # Simple updates - add new tech if not present
        if ($newLang -and $content -notlike "*$newLang*") {
            # Find the Active Technologies section and add new tech
            $techPattern = '## Active Technologies\s*\n(.*?)(\n\n|\n$)'
            if ($content -match $techPattern) {
                $existingTech = $matches[1]
                $newTechLine = "- $newLang + $newFramework ($currentBranch)"
                $updatedTech = $existingTech + "`n" + $newTechLine
                $content = $content -replace $techPattern, "## Active Technologies`n$updatedTech`n`n"
            }
        }
        
        # Update recent changes (keep only last 3)
        $changesPattern = '## Recent Changes\s*\n(.*?)(\n\n|\n$)'
        if ($content -match $changesPattern) {
            $existingChanges = $matches[1].Trim()
            $changes = $existingChanges -split "`n" | Where-Object { $_ -ne "" }
            $newChange = "- $currentBranch : Added $newLang + $newFramework"
            $allChanges = @($newChange) + $changes | Select-Object -First 3
            $updatedChanges = $allChanges -join "`n"
            $content = $content -replace $changesPattern, "## Recent Changes`n$updatedChanges`n`n"
        }
        
        # Update date
        $content = $content -replace 'Last updated: \d{4}-\d{2}-\d{2}', "Last updated: $(Get-Date -Format 'yyyy-MM-dd')"
        
        Set-Content $tempFile $content
    }
    
    # Move temp file to final location
    Move-Item $tempFile $TargetFile
    Write-Host "✅ $AgentName context file updated successfully" -ForegroundColor Green
    return $true
}

# Update files based on argument or detect existing files
switch ($AgentType.ToLower()) {
    "claude" {
        Update-AgentFile $claudeFile "Claude Code"
    }
    "gemini" {
        Update-AgentFile $geminiFile "Gemini CLI"
    }
    "copilot" {
        Update-AgentFile $copilotFile "GitHub Copilot"
    }
    "" {
        # Update all existing files
        if (Test-Path $claudeFile -PathType Leaf) { Update-AgentFile $claudeFile "Claude Code" }
        if (Test-Path $geminiFile -PathType Leaf) { Update-AgentFile $geminiFile "Gemini CLI" }
        if (Test-Path $copilotFile -PathType Leaf) { Update-AgentFile $copilotFile "GitHub Copilot" }
        
        # If no files exist, create based on current directory or ask user
        if (-not (Test-Path $claudeFile -PathType Leaf) -and 
            -not (Test-Path $geminiFile -PathType Leaf) -and 
            -not (Test-Path $copilotFile -PathType Leaf)) {
            Write-Host "No agent context files found. Creating Claude Code context file by default."
            Update-AgentFile $claudeFile "Claude Code"
        }
    }
    default {
        Write-Error "ERROR: Unknown agent type '$AgentType'. Use: claude, gemini, copilot, or leave empty for all."
        exit 1
    }
}

Write-Host ""
Write-Host "Summary of changes:"
if ($newLang) {
    Write-Host "- Added language: $newLang"
}
if ($newFramework) {
    Write-Host "- Added framework: $newFramework"
}
if ($newDb -and $newDb -ne "N/A") {
    Write-Host "- Added database: $newDb"
}

Write-Host ""
Write-Host "Usage: .\update-agent-context.ps1 [claude|gemini|copilot]"
Write-Host "  - No argument: Update all existing agent context files"
Write-Host "  - claude: Update only CLAUDE.md"
Write-Host "  - gemini: Update only GEMINI.md"
Write-Host "  - copilot: Update only .github/copilot-instructions.md"
