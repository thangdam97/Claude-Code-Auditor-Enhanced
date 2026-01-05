# Simple Prompt .clauderc Deployment Script
# No fancy characters, just works

param(
    [string]$TargetProject = "C:\Users\Admin\Documents\AI_MODULES\JP-EN"
)

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Prompt Engineering .clauderc Deployment" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Check source file
if (-not (Test-Path ".clauderc-prompts")) {
    Write-Host "ERROR: .clauderc-prompts not found" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Found .clauderc-prompts" -ForegroundColor Green

# Check target
if (-not (Test-Path $TargetProject)) {
    Write-Host "ERROR: Target project not found: $TargetProject" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Target project exists" -ForegroundColor Green

# Navigate to target
Set-Location $TargetProject

# Backup if exists
if (Test-Path ".clauderc") {
    $backupDir = ".clauderc-backups"
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backup = "$backupDir\.clauderc.backup.$timestamp"
    
    Copy-Item ".clauderc" $backup
    Write-Host "[OK] Backed up existing .clauderc to $backup" -ForegroundColor Yellow
}

# Copy the file
$source = Join-Path $PSScriptRoot ".clauderc-prompts"
Copy-Item $source ".clauderc" -Force

if (Test-Path ".clauderc") {
    Write-Host "[OK] Deployed .clauderc successfully" -ForegroundColor Green
} else {
    Write-Host "ERROR: Deployment failed" -ForegroundColor Red
    exit 1
}

# Verify content
$content = Get-Content ".clauderc" -Raw
if ($content -match "PROMPT ENGINEERING") {
    Write-Host "[OK] Verified: Prompt engineering protocol" -ForegroundColor Green
} else {
    Write-Host "WARNING: May not be prompt engineering version" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "DEPLOYMENT COMPLETE" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Open VSCode in this project" -ForegroundColor White
Write-Host "2. Start Claude Code (Ctrl+L)" -ForegroundColor White
Write-Host "3. Say: Read .clauderc and confirm you understand" -ForegroundColor White
Write-Host "         this is a PROMPT ENGINEERING protocol" -ForegroundColor White
Write-Host ""