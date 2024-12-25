REM Simple solution to a dumb design choice of mine
set RESHACKER=ResourceHacker.exe

REM Put ResourceHacker on your PATH to %RESHACKER%
:RESHACKERCHECK
ECHO Checking if ResourceHacker is on PATH...
ECHO.
IF "%RESHACKER%" NEQ "" (
  GOTO MAIN
) ELSE (
  ECHO ResourceHacker is not on path. Exiting...
  PAUSE >NUL
  EXIT 
)

REM Closing all open instances of Fusion
TASKKILL /F /IM BETTERKEGA.exe
TASKKILL /F /IM FUSION.exe
TASKKILL /F /IM FUSION_ORIGINAL.exe

REM Checking if there are compiled resources
IF EXIST "Resources" (
  RMDIR /Q /S Resources
  GOTO RESHACKERCHECK
) ELSE (
  GOTO RESHACKERCHECK
)

:MAIN
ECHO Compiling resource files...
%RESHACKER% -open ..\Patches\Menu101.rc -save ..\Resources\Menu101.res -action compile
%RESHACKER% -open ..\Patches\Menu102.rc -save ..\Resources\Menu102.res -action compile
%RESHACKER% -open ..\Patches\Menu114.rc -save ..\Resources\Menu114.res -action compile
%RESHACKER% -open ..\Patches\Dialog108.rc -save ..\Resources\Dialog108.res -action compile

ECHO.
ECHO Patching Kega Fusion to BetterKega...
%RESHACKER% -script .\FusionPatch.rhs
REM https://github.com/lucmsilva651/BK_binmod - Binary editing
binmod
REM Delete original Fusion and replace with patched one
del /f ..\Fusion364\Fusion.exe
rename ..\Fusion364\BetterKega.exe Fusion.exe
ECHO.
ECHO Running BetterKega...
START ..\Fusion364\Fusion.exe

REM Writing to shortcut
ECHO @ECHO OFF > "..\Open BetterKega.cmd"
ECHO START Fusion364\Fusion.exe > "..\Open BetterKega.cmd"
ECHO EXIT > "..\Open BetterKega.cmd"

EXIT