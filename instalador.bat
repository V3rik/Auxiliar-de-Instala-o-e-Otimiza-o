@echo off
title Instalador de Apps e Otimizador - Windows
color 0a
:menu
cls
echo ====================================================
echo         Instalador de Aplicativos e Otimizador
echo ====================================================
echo [1] Spotify
echo [2] Google Chrome
echo [3] Mozilla Firefox
echo [4] Driver Booster
echo [5] Visual Studio Code
echo [6] Visual Studio 2022 Community
echo [7] Python 3
echo [8] Node.js
echo [9] Git
echo [10] VLC Media Player
echo [11] 7-Zip
echo [12] Discord
echo [13] Microsoft Teams
echo [14] Slack
echo [15] Opera
echo [16] Tor Browser
echo [17] Brave Browser
echo [18] Snappy Driver Installer (SDI)
echo -----------------------------
echo [30] Limpar arquivos temporarios
echo [31] Esvaziar Lixeira
echo [32] Limpar cache Windows Update
echo [33] Liberar Memoria RAM
echo -----------------------------
echo [34] Desativar Microsoft Store
echo [35] Desativar Microsoft Teams
echo [36] Desabilitar OneDrive
echo -----------------------------
echo [40] Ativar Windows com chave original
echo -----------------------------
echo [0] Sair
echo ====================================================
set /p opcao=Digite a opcao desejada: 

REM ----- Aplicativos -----
if "%opcao%"=="1"  call :instalar Spotify.Spotify
if "%opcao%"=="01" call :instalar Spotify.Spotify
if "%opcao%"=="2"  call :instalar Google.Chrome
if "%opcao%"=="02" call :instalar Google.Chrome
if "%opcao%"=="3"  call :instalar Mozilla.Firefox
if "%opcao%"=="03" call :instalar Mozilla.Firefox
if "%opcao%"=="4"  call :instalar IObit.DriverBooster
if "%opcao%"=="04" call :instalar IObit.DriverBooster
if "%opcao%"=="5"  call :instalar Microsoft.VisualStudioCode
if "%opcao%"=="05" call :instalar Microsoft.VisualStudioCode
if "%opcao%"=="6"  call :instalar Microsoft.VisualStudio.2022.Community
if "%opcao%"=="06" call :instalar Microsoft.VisualStudio.2022.Community
if "%opcao%"=="7"  call :instalar Python.Python.3
if "%opcao%"=="07" call :instalar Python.Python.3
if "%opcao%"=="8"  call :instalar OpenJS.NodeJS
if "%opcao%"=="08" call :instalar OpenJS.NodeJS
if "%opcao%"=="9"  call :instalar Git.Git
if "%opcao%"=="09" call :instalar Git.Git
if "%opcao%"=="10" call :instalar VideoLAN.VLC
if "%opcao%"=="11" call :instalar 7zip.7zip
if "%opcao%"=="12" call :instalar Discord.Discord
if "%opcao%"=="13" call :instalar Microsoft.Teams
if "%opcao%"=="14" call :instalar SlackTechnologies.Slack
if "%opcao%"=="15" call :instalar Opera.Opera
if "%opcao%"=="16" call :instalar TorProject.TorBrowser
if "%opcao%"=="17" call :instalar Brave.Brave
if "%opcao%"=="18" call :sdi

REM ----- Limpeza -----
if "%opcao%"=="30" call :limpar_temp
if "%opcao%"=="31" call :esvaziar_lixeira
if "%opcao%"=="32" call :limpar_update
if "%opcao%"=="33" call :liberar_memoria

REM ----- Desativar serviços -----
if "%opcao%"=="34" call :desativar_store
if "%opcao%"=="35" call :desativar_teams
if "%opcao%"=="36" call :desabilitar_onedrive

REM ----- Ativação Windows -----
if "%opcao%"=="40" call :ativar_windows

REM ----- Sair -----
if "%opcao%"=="0" exit
if "%opcao%"=="00" exit

goto menu

:instalar
echo Instalando %1...
winget install -e --id %1 -h
pause
goto menu

:sdi
echo Baixando Snappy Driver Installer...
set "url=https://sdi-tool.org/releases/SDI_R1909.zip"
set "dest=%temp%\sdi.zip"
powershell -command "Invoke-WebRequest '%url%' -OutFile '%dest%'"
powershell -command "Expand-Archive -Path '%dest%' -DestinationPath '%temp%\sdi' -Force"
start "" "%temp%\sdi\SDI_x64.exe"
goto menu

:limpar_temp
echo Limpando arquivos temporarios...
del /s /f /q %temp%\*.* >nul 2>&1
echo Concluido!
pause
goto menu

:esvaziar_lixeira
echo Esvaziando Lixeira...
powershell -command "Clear-RecycleBin -Force"
echo Concluido!
pause
goto menu

:limpar_update
echo Limpando cache do Windows Update...
net stop wuauserv
del /s /q C:\Windows\SoftwareDistribution\Download\*.* >nul 2>&1
net start wuauserv
echo Concluido!
pause
goto menu

:liberar_memoria
echo Liberando memoria RAM...
powershell -command "[System.GC]::Collect()"
echo Concluido!
pause
goto menu

:desativar_store
echo Desativando Microsoft Store...
powershell -command "Get-AppxPackage *WindowsStore* | Remove-AppxPackage"
echo Concluido!
pause
goto menu

:desativar_teams
echo Desativando Microsoft Teams...
taskkill /f /im Teams.exe >nul 2>&1
rd "%userprofile%\AppData\Local\Microsoft\Teams" /s /q
rd "%userprofile%\AppData\Roaming\Microsoft\Teams" /s /q
echo Concluido!
pause
goto menu

:desabilitar_onedrive
echo Desabilitando OneDrive...
taskkill /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
echo Concluido!
pause
goto menu

:ativar_windows
echo ============================================
echo     Ativacao do Windows com chave original
echo ============================================
set /p key=Digite sua chave do Windows: 
slmgr /ipk %key%
slmgr /ato
echo Windows ativado com sucesso (se a chave for valida).
pause
goto menu
