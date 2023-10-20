; Náš první program - Hello, World!

bits 16
org 0x0100

main:
mov ax, cs
mov ds, ax

mov si, zprava
call print_string

ret

print_string:
mov ah, 0x0e
xor bh, bh

.print_char:
lodsb
or al, al
jz short .return
int 0x10
hlt
jmp short .print_char

.return:
ret

zprava db "Hello, ", 10, 13, "World!", 0x00