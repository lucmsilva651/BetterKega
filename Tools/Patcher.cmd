@ECHO OFF

REM Closing all open instances of Fusion
TASKKILL /F /IM BETTERKEGA.exe
TASKKILL /F /IM FUSION.exe
TASKKILL /F /IM FUSION_ORIGINAL.exe

REM Checking if there are compiled resources
IF EXIST "..\Resources" (
  RMDIR /Q /S ..\Resources
  GOTO RESHACKERCHECK
) ELSE (
  GOTO RESHACKERCHECK
)

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

:MAIN
ECHO Compiling resource files...
%RESHACKER% -open ..\Patches\Menu101.rc -save ..\Resources\Menu101.res -action compile
%RESHACKER% -open ..\Patches\Menu102.rc -save ..\Resources\Menu102.res -action compile
%RESHACKER% -open ..\Patches\Menu114.rc -save ..\Resources\Menu114.res -action compile
%RESHACKER% -open ..\Patches\Dialog108.rc -save ..\Resources\Dialog108.res -action compile

ECHO.
ECHO Patching Kega Fusion to BetterKega...
%RESHACKER% -script .\FusionPatch.rhs
ECHO.
ECHO Running BetterKega...
START ..\Fusion364\BetterKega.exe

REM Writing to shortcut
>> "..\Open BetterKega.cmd" ECHO @ECHO OFF
>> "..\Open BetterKega.cmd" ECHO START Fusion364\BetterKega.exe
>> "..\Open BetterKega.cmd" ECHO EXIT
exit