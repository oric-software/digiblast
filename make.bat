
@echo off
SET ORICUTRON="..\..\..\oricutron\"

SET ORIGIN_PATH=%CD%
rem SET PATH=%PATH%;%cc65%
del build\*.* /Q


rem %OSDK%\bin\xa.exe -v -R -cc src\mymDbug.s -o src\mymplayer.o -DTARGET_FILEFORMAT_O65 -DTARGET_ORIX

rem %OSDK%\bin\xa.exe -R -cc src\rs232.asm -o build\rs232.o
%OSDK%\bin\xa.exe  src\playdig.asm -DWITH_ORIX -o playdig
rem co65  build\rs232.o -o build\rs232.s
rem cl65 -ttelestrat src\orixdbg.c build\rs232.s -o build\usr\bin\orixdbg

mkdir build\usr\
mkdir build\bin\
mkdir build\usr\share\
mkdir build\usr\share\digibst\

copy data\bigguns8.wav build\usr\share\digibst\
echo yo
copy playdig build\bin\
echo yo


IF "%1"=="NORUN" GOTO End
mkdir %ORICUTRON%\usbdrive\usr\share\digibst\
copy data\bigguns8.wav %ORICUTRON%\usbdrive\usr\share\digibst\bigguns8.wav
copy playdig %ORICUTRON%\usbdrive\bin\a

cd %ORICUTRON%
OricutronV11 -mt 

cd %ORIGIN_PATH%
:End