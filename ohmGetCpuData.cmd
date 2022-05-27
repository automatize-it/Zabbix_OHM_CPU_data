@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION

IF [%1] EQU [] ECHO Usage script cpud or script tc id && exit /b 1

IF "%1" EQU "cpud" GOTO :DSCVR

IF "%1" EQU "tc" (
	IF [%2] EQU [] (
		ECHO Usage script cpud or script tc id && exit /b 1
	) ELSE (
		GOTO :GETT
	)
)
ECHO parameter error && EXIT /B 1

:DSCVR
SET JSDATA={"data":[

:: CPUMAN CPUID COREID
for /f "tokens=1-4 delims=/ " %%I in ('wmic /namespace:\\root\OpenHardwareMonitor PATH Sensor ^| find "cpu" ^| find "Temperature"') DO (

	REM echo %%I , %%J , %%L
	REM for /f "tokens=2 delims=/" %%Z in ('echo %%I') DO (
		REM SET JSDATA=!JSDATA!{"{#HDD.ID}":"%%Z"},
	REM )
	SET JSDATA=!JSDATA!{"{#CPU.MAN}":"%%I","{#CPU.MAN.ID}":"%%J","{#CPU.MAN.ID.COREID}":"%%L"},
)

SET JSDATA=!JSDATA:~0,-1!
SET JSDATA=%JSDATA%]}

ECHO %JSDATA%
ENDLOCAL
EXIT /B 0

:GETT
SET TC=0
for /f "tokens=* skip=1 delims=" %%F in ('wmic /namespace:\\root\OpenHardwareMonitor PATH Sensor WHERE Identifier^="/%2/%3/temperature/%4" get Value') DO (
	SET TC=%%F && GOTO :GETTNXT
)
:GETTNXT
SET TC=!!TC:,=.!!
ECHO %TC%
ENDLOCAL 
EXIT /B 0