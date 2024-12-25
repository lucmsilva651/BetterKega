@ECHO OFF

CHCP 65001 >NUL
TITLE BetterKega Installer

IF EXIST "Fusion364" (
  GOTO INSTALL
) ELSE (
  GOTO NTFOUND
)

:NTFOUND
ECHO Warning: Kega Fusion was not found.
ECHO Please put your Fusion folder here named "Fusion364".
PAUSE >NUL

:INSTALL
cd Patcher
Patcher.cmd