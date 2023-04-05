@ECHO OFF 

TITLE Start FOS Container

ECHO Please wait... Setting up FOS container.

:: Section 1: Download FOS Container from DockerHub (if not exists locally)
ECHO ======================================
ECHO Downloading and Starting FOS Container
ECHO ======================================

FOR /F "tokens=* USEBACKQ" %%i IN (`docker container ls -aqf "name=^fos-container"`) DO SET containerId=%%i
IF "%containerId%" == "" (
  FOR /F %%i IN ('docker image ls -q mohamedraafat/fos') DO IF "%%i" == "" (
    ECHO [Make sure you have a stable internet connetion.]
    ECHO.
  )
  ECHO Creating FOS container...
  docker container run -it -d --name fos-container -e DISPLAY=host.docker.internal:0.0 mohamedraafat/fos:latest
  ECHO Created and started successfully!
) ELSE (
  ECHO Starting FOS Container... 
  docker container start %ContainerId% > NUL
  ECHO Started successfully with ID: %ContainerId%
)

:: Section 2: VcXsrv.
ECHO =============================
ECHO Start VcXsrv Windows X Server
ECHO =============================
TASKLIST | FIND /I "vcxsrv.exe" > NUL
IF NOT %errorlevel% == 0 (
  ECHO Starting VcXsrv...
  START "VcXserv" "C:\Program Files\VcXsrv\vcxsrv.exe" -multiwindow -clipboard -wgl
  TIMEOUT /T 2 > NUL    
)
ECHO VcXsrv started!

:: Section 3: Setup VS Code.
ECHO ============================
ECHO Starting Visual Studio Code.
ECHO ============================
SET extentionsList="ms-azuretools.vscode-docker" "ms-vscode-remote.remote-containers"

FOR %%i IN (%extentionsList%) DO (
  FOR /F "delims=" %%j IN ('code --list-extensions ^| FIND /C %%i') DO IF %%j == 0 (
    START /B "" code --install-extension %%i
    TIMEOUT /T 5 > NUL
  )
)

ECHO VS Code is starting...
START C:\Users\%username%\AppData\Local\Programs\"Microsoft VS Code"\Code.exe