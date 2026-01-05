@echo off
REM ============================================================================
REM Deploy Prompt Engineering .clauderc to JP-EN Translation Project
REM Specialized protocol for LLM instruction schemas and prompt templates
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ========================================================
echo  Prompt Engineering .clauderc Deployment
echo  Target: JP-EN Translation Project
echo ========================================================
echo.

REM Configuration
set "SOURCE_CLAUDERC=.clauderc-prompts"
set "TARGET_PROJECT=C:\Users\Admin\Documents\AI_MODULES\JP-EN"
set "BACKUP_DIR=%TARGET_PROJECT%\.clauderc-backups"

REM Colors simulation (basic)
set "COLOR_GREEN=[92m"
set "COLOR_YELLOW=[93m"
set "COLOR_RED=[91m"
set "COLOR_CYAN=[96m"
set "COLOR_RESET=[0m"

REM Step 1: Verify source file exists
echo [1] Checking source file...
if not exist "%SOURCE_CLAUDERC%" (
    echo %COLOR_RED%ERROR: %SOURCE_CLAUDERC% not found%COLOR_RESET%
    echo.
    echo This script expects .clauderc-prompts in the current directory.
    echo Please ensure the file is present and try again.
    echo.
    pause
    exit /b 1
)
echo %COLOR_GREEN%   Found: %SOURCE_CLAUDERC%%COLOR_RESET%

REM Step 2: Verify target project exists
echo.
echo [2] Checking target project...
if not exist "%TARGET_PROJECT%" (
    echo %COLOR_RED%ERROR: Target project not found: %TARGET_PROJECT%%COLOR_RESET%
    echo.
    echo Please update the TARGET_PROJECT variable in this script.
    echo.
    pause
    exit /b 1
)
echo %COLOR_GREEN%   Found: %TARGET_PROJECT%%COLOR_RESET%

REM Step 3: Backup existing .clauderc if present
echo.
echo [3] Checking for existing .clauderc...
if exist "%TARGET_PROJECT%\.clauderc" (
    echo %COLOR_YELLOW%   Existing .clauderc found - creating backup...%COLOR_RESET%
    
    REM Create backup directory
    if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
    
    REM Generate timestamp for backup (using PowerShell - more reliable than wmic)
    for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd-HHmmss'"') do set "timestamp=%%a"
    
    REM Fallback if PowerShell fails
    if "!timestamp!"=="" (
        set "timestamp=%date:~-4%%date:~-10,2%%date:~-7,2%-%time:~0,2%%time:~3,2%%time:~6,2%"
        set "timestamp=!timestamp: =0!"
    )
    
    REM Backup the file
    copy "%TARGET_PROJECT%\.clauderc" "%BACKUP_DIR%\.clauderc.backup.%timestamp%" >nul
    
    if !errorlevel! equ 0 (
        echo %COLOR_GREEN%   Backed up to: .clauderc-backups\.clauderc.backup.%timestamp%%COLOR_RESET%
    ) else (
        echo %COLOR_RED%   Backup failed!%COLOR_RESET%
        pause
        exit /b 1
    )
) else (
    echo %COLOR_CYAN%   No existing .clauderc (fresh deployment)%COLOR_RESET%
)

REM Step 4: Deploy the prompt-specific .clauderc
echo.
echo [4] Deploying prompt engineering .clauderc...
copy "%SOURCE_CLAUDERC%" "%TARGET_PROJECT%\.clauderc" >nul

if %errorlevel% equ 0 (
    echo %COLOR_GREEN%   Deployed successfully!%COLOR_RESET%
) else (
    echo %COLOR_RED%   Deployment failed!%COLOR_RESET%
    pause
    exit /b 1
)

REM Step 5: Verify deployment
echo.
echo [5] Verifying deployment...

if exist "%TARGET_PROJECT%\.clauderc" (
    for %%F in ("%TARGET_PROJECT%\.clauderc") do set "filesize=%%~zF"
    
    if !filesize! gtr 1000 (
        echo %COLOR_GREEN%   Verified: .clauderc present (!filesize! bytes)%COLOR_RESET%
    ) else (
        echo %COLOR_YELLOW%   Warning: File size suspiciously small (!filesize! bytes)%COLOR_RESET%
    )
    
    REM Check for key content
    findstr /C:"PROMPT ENGINEERING" "%TARGET_PROJECT%\.clauderc" >nul
    if !errorlevel! equ 0 (
        echo %COLOR_GREEN%   Verified: Prompt engineering protocol detected%COLOR_RESET%
    ) else (
        echo %COLOR_YELLOW%   Warning: May not be prompt-specific protocol%COLOR_RESET%
    )
) else (
    echo %COLOR_RED%   Verification failed: .clauderc not found after deployment%COLOR_RESET%
    pause
    exit /b 1
)

REM Step 6: Update VSCode settings (if needed)
echo.
echo [6] Checking VSCode settings...

if exist "%TARGET_PROJECT%\.vscode\settings.json" (
    echo %COLOR_CYAN%   VSCode settings.json exists%COLOR_RESET%
    
    findstr /C:"claude.readProjectInstructions" "%TARGET_PROJECT%\.vscode\settings.json" >nul
    if !errorlevel! equ 0 (
        echo %COLOR_GREEN%   Already configured for .clauderc%COLOR_RESET%
    ) else (
        echo %COLOR_YELLOW%   May need VSCode configuration update%COLOR_RESET%
        echo %COLOR_YELLOW%   Run: .\deploy-clauderc-universal.ps1 to configure VSCode%COLOR_RESET%
    )
) else (
    echo %COLOR_YELLOW%   No VSCode settings found%COLOR_RESET%
    echo %COLOR_YELLOW%   Run: .\deploy-clauderc-universal.ps1 to create VSCode config%COLOR_RESET%
)

REM Step 7: Create quick reference
echo.
echo [7] Creating quick reference card...

set "QUICK_REF=%TARGET_PROJECT%\PROMPT-CLAUDERC-QUICKREF.md"

(
echo # Prompt Engineering .clauderc - Quick Reference
echo.
echo ## Protocol Type: PROMPT ENGINEERING
echo.
echo This .clauderc is specialized for LLM instruction schemas, NOT traditional code.
echo.
echo ## Risk Levels for Prompts
echo.
echo - **Type A - SAFE**: Adding ICL examples, new documentation
echo - **Type B - RISKY**: Modifying LLM instructions, changing parameters
echo - **Type C - DANGEROUS**: Breaking prompt contracts, major schema changes
echo.
echo ## Key Differences from Code .clauderc
echo.
echo ^| Aspect ^| Code Protocol ^| Prompt Protocol ^|
echo ^|-----^|-----^|-----^|
echo ^| Validation ^| Syntax ^(compiles?^) ^| Semantics ^(coherent?^) ^|
echo ^| Modules ^| Must be invoked ^| Can be declarative ^|
echo ^| Breaking ^| API signatures ^| Instruction contracts ^|
echo ^| Testing ^| Unit tests ^| LLM behavior ^|
echo.
echo ## Starting a Session
echo.
echo ```
echo Read .clauderc and confirm you understand this is a PROMPT ENGINEERING protocol
echo ```
echo.
echo ## Example Commands
echo.
echo **Add ICL examples ^(Type A^):**
echo ```
echo Read .clauderc, then add examples for KANSAI archetype in master_prompt.xml
echo ```
echo.
echo **Modify instructions ^(Type B^):**
echo ```
echo Read .clauderc, then clarify the ARCH format definition in master_prompt.xml
echo ```
echo.
echo **Breaking change ^(Type C^):**
echo ```
echo Read .clauderc, then restructure ARCH to use JSON format
echo ```
echo.
echo ## What Claude Will Do
echo.
echo 1. Understand modules are DECLARATIVE ^(not "orphaned"^)
echo 2. Focus on SEMANTIC issues ^(not syntax errors^)
echo 3. Analyze LLM BEHAVIOR impact ^(not execution flow^)
echo 4. Validate INSTRUCTION coherence ^(not compilation^)
echo.
echo ## Common Audits
echo.
echo **Semantic Coherence:**
echo - Contradictory instructions?
echo - Ambiguous trigger conditions?
echo - Circular dependencies?
echo.
echo **Schema Completeness:**
echo - All referenced elements defined?
echo - ICL examples for all archetypes?
echo - Clear parameter definitions?
echo.
echo **LLM Instruction Quality:**
echo - Can an LLM follow this unambiguously?
echo - Are examples representative?
echo - Do examples match rules?
echo.
echo ---
echo **Deployed:** %date% %time%  
echo **Protocol:** Prompt Engineering v1.0  
echo **Project:** JP-EN Translation
) > "%QUICK_REF%"

if %errorlevel% equ 0 (
    echo %COLOR_GREEN%   Created: PROMPT-CLAUDERC-QUICKREF.md%COLOR_RESET%
) else (
    echo %COLOR_YELLOW%   Failed to create quick reference%COLOR_RESET%
)

REM ============================================================================
REM FINAL SUMMARY
REM ============================================================================

echo.
echo ========================================================
echo  DEPLOYMENT COMPLETE
echo ========================================================
echo.

echo %COLOR_GREEN%Deployment Summary:%COLOR_RESET%
echo   Project:    %TARGET_PROJECT%
echo   Protocol:   Prompt Engineering (specialized)
echo   Backup:     %BACKUP_DIR%
echo.

echo %COLOR_CYAN%Files Deployed:%COLOR_RESET%
echo   - .clauderc (prompt engineering protocol)
echo   - PROMPT-CLAUDERC-QUICKREF.md
echo.

echo %COLOR_YELLOW%Next Steps:%COLOR_RESET%
echo.
echo   1. Open project in VSCode:
echo      code "%TARGET_PROJECT%"
echo.
echo   2. Start Claude Code (Ctrl+L)
echo.
echo   3. Initialize protocol:
echo      "Read .clauderc and confirm you understand this is a 
echo       PROMPT ENGINEERING protocol, not a code protocol"
echo.
echo   4. Test with master_prompt.xml audit:
echo      "Read .clauderc, then audit master_prompt.xml for 
echo       semantic coherence and schema completeness"
echo.

echo %COLOR_GREEN%Expected Claude Behavior:%COLOR_RESET%
echo   - Understands modules are DECLARATIVE libraries
echo   - Focuses on SEMANTIC issues (not syntax)
echo   - Analyzes LLM BEHAVIOR impact
echo   - Validates INSTRUCTION coherence
echo   - No false positives about "orphaned modules"
echo.

echo %COLOR_CYAN%Documentation:%COLOR_RESET%
echo   - Full protocol:  .clauderc
echo   - Quick ref:      PROMPT-CLAUDERC-QUICKREF.md
echo   - Backups:        .clauderc-backups\
echo.

echo ========================================================
echo Deployment completed successfully!
echo ========================================================
echo.

pause
