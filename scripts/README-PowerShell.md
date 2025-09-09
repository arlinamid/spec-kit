# PowerShell Scripts for Windows

This directory contains PowerShell equivalents of the original bash scripts, designed to work on Windows without requiring WSL (Windows Subsystem for Linux).

> **Updated**: This fork includes native Windows PowerShell support for all spec-kit operations.

## Prerequisites

- Windows PowerShell 5.1 or PowerShell Core 6.0+
- Git installed and available in PATH
- Python 3.x (for some advanced text processing in update-agent-context.ps1)

## Available Scripts

### Core Scripts

1. **common.ps1** - Shared functions and utilities
2. **get-feature-paths.ps1** - Get paths for current feature branch
3. **check-task-prerequisites.ps1** - Check implementation plan and design documents
4. **create-new-feature.ps1** - Create new feature with branch and directory structure
5. **setup-plan.ps1** - Setup implementation plan structure
6. **update-agent-context.ps1** - Update agent context files (Claude, Gemini, Copilot)

### Utility Scripts

7. **test-powershell-scripts.ps1** - Test script to verify all PowerShell scripts work correctly

## Usage Examples

### Basic Usage

```powershell
# Get feature paths
.\get-feature-paths.ps1

# Get feature paths in JSON format
.\get-feature-paths.ps1 -Json

# Create a new feature
.\create-new-feature.ps1 "user authentication system"

# Check prerequisites
.\check-task-prerequisites.ps1

# Setup plan
.\setup-plan.ps1

# Update agent context files
.\update-agent-context.ps1
```

### Advanced Usage

```powershell
# Create feature with JSON output
.\create-new-feature.ps1 -Json "payment processing"

# Update specific agent context file
.\update-agent-context.ps1 claude
.\update-agent-context.ps1 gemini
.\update-agent-context.ps1 copilot

# Check prerequisites with JSON output
.\check-task-prerequisites.ps1 -Json
```

## Key Differences from Bash Scripts

1. **File Extensions**: All scripts use `.ps1` extension
2. **Parameter Syntax**: Uses PowerShell parameter syntax (`-Json`, `-Help`)
3. **Path Handling**: Uses `Join-Path` for cross-platform path construction
4. **Error Handling**: Uses PowerShell error handling with `Write-Error`
5. **JSON Output**: Uses `ConvertTo-Json` for JSON formatting
6. **Text Processing**: Uses PowerShell regex and string operations instead of sed/awk

## Testing

Run the test script to verify all scripts work correctly:

```powershell
.\test-powershell-scripts.ps1
```

## Troubleshooting

### Common Issues

1. **Execution Policy**: If you get execution policy errors, run:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **Git Not Found**: Ensure Git is installed and available in your PATH

3. **Feature Branch Format**: Scripts expect feature branches to be named like `001-feature-name`

4. **Python Dependencies**: Some advanced text processing in `update-agent-context.ps1` may require Python 3.x

### Getting Help

All scripts support the `-Help` parameter:

```powershell
.\script-name.ps1 -Help
```

## Migration from Bash

If you're migrating from the bash scripts:

1. Replace `./script.sh` with `.\script.ps1`
2. Replace `--json` with `-Json`
3. Replace `--help` with `-Help`
4. Use PowerShell syntax for any custom modifications

## Compatibility

- **Windows**: Full support
- **PowerShell Core**: Full support on Linux/macOS
- **Git Bash**: Not tested, but should work with PowerShell Core
- **WSL**: Not required, but scripts will work in WSL if PowerShell is available
