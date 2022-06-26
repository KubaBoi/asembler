echo off
echo Assembling Hello, World!...
..\Tools\nasm.exe -fbin -o Bin\hlwrld.com Source\hlwrld.asm
echo Assembled
echo Opening DOSBox
"C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe" Bin\hlwrld.com -noconsole %*
exit