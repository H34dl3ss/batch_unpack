# batch_unpack
Unpack content of subdirectories that are matching a certain scheme.\
Created specifically to unpack usenet downloads.\
\
A batch script to unpack archives from usenet on a local PC running Windows.\
The directory containing the rar files should look like [directory{{password}}etc]\
The password will be extracted and the content of the directory will be extracted to [directory].\
The batch file shall be placed in the same directory as the directories to be unpacked.\
Make sure to modify the path to your local WinRAR.exe in the line "set unrar=..."\
If another target directory is preferred, change "set scriptdir=..." to a path of choice.\
Processed directories will be moved to a new directory called "done".\
\
REM Caution! Limited errorhandling! Use at own risk!
