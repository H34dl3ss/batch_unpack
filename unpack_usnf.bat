REM 26.12.2020, H34dl3ss
REM 28.02.2022, H34dl3ss Update: add 7zip as extractor
REM This is a batch script to unpack archives from usenet on a local PC running Windows.
REM The directory containing the rar files should look like [directory{{password}}etc]
REM The password will be extracted and the content of the directory will be extracted to [directory].
REM The batch file shall be placed in the same directory as the directories to be unpacked.
REM Make sure to modify the path to your local WinRAR.exe in the line "set unrar=..."
REM To use 7zip, enter the path to the 7z.exe and set "use7zip" to yes.
REM If another target directory is preferred, change "set scriptdir=..." to a path of choice.
REM Processed directories are moved to the folder "!done" which can be set differently also.
REM
REM Caution! Limited errorhandling! Use at own risk!
REM

@echo off
cls
set scriptdir=%~dp0
set donedir=%~dp0\^!done
set unrar=C:\Program\WinRAR\WinRAR.exe x -p
set unzip="C:\Program Files\7zip\7z.exe" x -ba
set use7zip="yes"
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
	echo.        
	     IF !use7zip!=="yes" (
             set exec=!unzip! "!var!\*.rar" -p!pw! -o"!scriptdir!!newdir!\"
             ) ELSE (
             set exec=!unrar!!pw! "!var!\*.rar" "!scriptdir!!newdir!\"
             )
	call !exec!
        if not exist "!donedir!"\ mkdir "!donedir!"\
        move "!var!" "!donedir!"\
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
