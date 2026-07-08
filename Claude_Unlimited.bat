@echo off
:: Force command prompt to use UTF-8 encoding
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Force the script to operate in the exact folder where this .bat file is located
cd /d "%~dp0"

title RKDCoder Gateway Setup

:: 1. Check if saved configs exist in a local .env file
set "NVIDIA_KEY="
if exist .env (
    for /f "tokens=1* delims==" %%A in (.env) do (
        if "%%A"=="NVIDIA_API_KEY" set "NVIDIA_KEY=%%B"
    )
)

:: 2. Display RKDCoder Logo and Welcome Message
color 0A
echo.
echo  ██████╗ ██╗  ██╗██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
echo  ██╔══██╗██║ ██╔╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗
echo  ██████╔╝█████╔╝ ██║  ██║██║     ██║   ██║██║  ██║█████╗  ██████╔╝
echo  ██╔══██╗██╔═██╗ ██║  ██║██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗
echo  ██║  ██║██║  ██╗██████╔╝╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║
echo  ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
echo.
echo =================================================================
echo          Welcome to the RKDCoder Unlimited Claude
echo =================================================================
echo.

:: 3. If key is missing, ask for it and save it.
if "!NVIDIA_KEY!"=="" (
    set /p NVIDIA_KEY="Enter your NVIDIA API Key (nvapi-...): "
    echo NVIDIA_API_KEY=!NVIDIA_KEY!> .env
    echo.
    echo [OK] API Key received and saved securely.
    echo Press ENTER to initialize the Gateway...
    pause >nul
) else (
    echo [OK] Saved NVIDIA API Key loaded automatically!
    echo Initializing system...
    timeout /t 1 /nobreak >nul
)

echo.
echo Checking dependencies...

:: 4. Verify if LiteLLM is installed, otherwise install it
where litellm >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] LiteLLM is not installed. Installing litellm[proxy]...
    pip install "litellm[proxy]"
    if %errorlevel% neq 0 (
        echo [X] Failed to install LiteLLM. Please ensure Python and pip are in your PATH.
        pause
        exit /b
    )
    echo [OK] LiteLLM installed successfully.
) else (
    echo [OK] LiteLLM is already installed.
)

echo.
echo Building inline LiteLLM configurations...

:: 5. Generate the YAML file in the current directory (Dynamic Fetching)
(
echo litellm_settings:
echo   drop_params: true
echo   max_tokens: 4096
echo.
echo general_settings:
echo   master_key: sk-litellm-my-local-key
echo.
echo model_list:
echo   - model_name: claude-opus-4-8
echo     litellm_params:
echo       model: nvidia_nim/z-ai/glm-5.2
echo       api_key: "os.environ/NVIDIA_API_KEY"
echo       rpm: 40
echo.
echo   - model_name: claude-sonnet-5
echo     litellm_params:
echo       model: nvidia_nim/nvidia/nemotron-3-ultra-550b-a55b
echo       api_key: "os.environ/NVIDIA_API_KEY"
echo       rpm: 40
echo.
echo   - model_name: claude-sonnet-4-6
echo     litellm_params:
echo       model: nvidia_nim/deepseek-ai/deepseek-v4-pro
echo       api_key: "os.environ/NVIDIA_API_KEY"
echo       rpm: 40
echo.
echo   - model_name: claude-sonnet-4
echo     litellm_params:
echo       model: nvidia_nim/minimaxai/minimax-m3
echo       api_key: "os.environ/NVIDIA_API_KEY"
echo       rpm: 40
) > litellm_config.yaml

:: 6. Start LiteLLM in a NEW WINDOW
echo Starting LiteLLM Gateway Server on port 4000...
start "LiteLLM Server" /d "%~dp0" cmd /k litellm --config litellm_config.yaml --port 4000

timeout /t 3 /nobreak >nul

:: 7. Show Dashboard
cls
echo.
echo  ██████╗ ██╗  ██╗██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
echo  ██╔══██╗██║ ██╔╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗
echo  ██████╔╝█████╔╝ ██║  ██║██║     ██║   ██║██║  ██║█████╗  ██████╔╝
echo  ██╔══██╗██╔═██╗ ██║  ██║██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗
echo  ██║  ██║██║  ██╗██████╔╝╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║
echo  ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
echo.
echo =================================================================
echo                      GATEWAY ONLINE PANEL
echo =================================================================
echo Gateway URL : http://localhost:4000
echo Master API  : sk-litellm-my-local-key
echo NVIDIA Key  : !NVIDIA_KEY!
echo.
echo Active Local Models Mapped to NVIDIA NIM:
echo  - claude-opus-4-8   ---^> glm-5.2
echo  - claude-sonnet-5   ---^> nemotron-3-ultra-550b-a55b
echo  - claude-sonnet-4-6 ---^> deepseek-v4-pro
echo  - claude-sonnet-4   ---^> minimax-m3
echo =================================================================
echo.

:: 8. Next Steps
echo Please open your Claude app manually and follow the instructions from here:
echo https://github.com/RKD-Coder/claude-ulimited
echo.
echo Everything is running. You can close this panel anytime.
pause >nul