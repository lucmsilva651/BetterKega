@ECHO OFF
REM Put ResourceHacker on your PATH to %RESHACKER%

ECHO Checking if ResourceHacker is on PATH...
ECHO.

IF EXIST "..\Resources" (
  RMDIR /Q /S ..\Resources
) ELSE (
  GOTO RESHACKERCHECK
)

:RESHACKERCHECK
IF "%RESHACKER%" NEQ "" (
  GOTO MAIN
) ELSE (
  ECHO ResourceHacker is not on path. Exiting...
  PAUSE >NUL
  EXIT 
)

:MAIN
ECHO Compiling resource files...
%RESHACKER% -open ..\Patches\Menu101.rc -save ..\Resources\Menu101.res -action compile >NUL
%RESHACKER% -open ..\Patches\Menu102.rc -save ..\Resources\Menu102.res -action compile >NUL
%RESHACKER% -open ..\Patches\Menu114.rc -save ..\Resources\Menu114.res -action compile >NUL
CLS
ECHO.
ECHO Patching Kega Fusion to BetterKega...
%RESHACKER% -script .\FusionPatch.rhs >NUL
ECHO.
ECHO Running BetterKega...
..\Fusion364\BetterKega.exe

PAUSE