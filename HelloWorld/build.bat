@echo off
set file=regMov

echo Assembling %file%!...
..\Tools\nasm.exe -fbin -o Bin\output.com Source\%file%.asm
echo Assembled
echo Opening DOSBox
"C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe" Bin\output.com -noconsole %*
exit