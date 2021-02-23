REM 26.12.2020, H34dl3ss
REM A script to unpack Archives from usenet on a local PC running Windows.
REM The directory containing the rar files should look like [directory{{password}}etc]
REM The password will be extracted and the content of the directory will be extracted
REM to [directory].
REM The batch file shall be placed in the same directory as the directories to be unpacked.
REM Make sure to modify the path to your local WinRAR.exe in the line "set unrar=..."
REM If another target directory is preferred, change "set scriptdir=..." to a path of choice.
REM
REM Caution! Limited errorhandling! Use at own risk!
REM

@echo off
cls
set scriptdir=%~dp0
set unrar=C:\Program\WinRAR\WinRAR.exe x -p
setlocal enabledelayedexpansion

for /D %%i IN (*) DO (
		set var=%%i
		set pw=""
		for /f "tokens=1,2* delims={{" %%G in ("!var!") do (
		set newdir=%%G
		set pw=%%H
			for /f "tokens=1,2* delims=}}" %%P in ("!pw!") DO (
			set pw=%%P
			)
		)

	IF NOT "!pw!"=="" (
	echo Extracting... 
	echo Source: 	!var! 
	echo Password: 	!pw!
	echo Target: 	!scriptdir!!newdir!
	set exec=!unrar!!pw! "!var!\*1.rar" "!scriptdir!!newdir!\"
	call !exec!
        if not exist "!scriptdir!"\done\ mkdir "!scriptdir!"\done\
        move "!var!" "!scriptdir!"\done\
        echo done
	echo.
	echo.

)	ELSE (
	echo Skipping... 
	echo Source: 	!var! 
	echo Password: 	!pw!	
	echo 		Cannot extract password from directory name.
	echo skipped
	echo.
	echo.
	)

)

goto END

:END