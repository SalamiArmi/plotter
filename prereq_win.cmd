@echo off

:Ask
set INPUT=
echo You are about to be prompted to install cygwin, a unix-like interface for windows.
echo You will need to install it to C:\cygwin64\ (which should be the default directory).
echo If it doesn't end up here, there will be problems.
echo Likely, you can just hit next, next, next, etc through the whole install.
echo Don't bother with any additional packages.
set /P INPUT=Do promise not to cause problems? (Y/N) %=%
If "%INPUT%"=="y" goto yes
If "%INPUT%"=="Y" goto yes
If "%INPUT%"=="n" goto no
If "%INPUT%"=="N" goto no
goto end

:yes
start /wait setup-x86_64.exe --quiet-mode -P lynx,git
echo After cygwin has been installed, run cygwin.
echo Navigate to this directory and run prereq.sh.
echo After that is done, you should be able to run any of the sub-projects.
pause
goto end

:no
echo Thanks for being honest. Goodbye!
pause
goto end

:end
exit
