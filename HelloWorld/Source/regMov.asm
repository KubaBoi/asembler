mov di, text                            ; Nastavíme adresu v registru DI na proměnnou text.

mov byte [di], 0x41                     ; Na adresu přesuneme hodnotu 0x41 ('A').
inc di                                  ; Posuneme ukazatel.
mov byte [di], 0x42                     ; Na adresu přesuneme hodnotu 0x42 ('B').
inc di                                  ; Posuneme ukazatel.
mov byte [di], 0x43                     ; Na adresu přesuneme hodnotu 0x43 ('C').
inc di                                  ; Posuneme ukazatel.
mov byte [di], 0x00                    ; Na adresu přesuneme hodnotu 0x00 (NULL).

mov si, text                            ; Nyní nastavíme registr SI na adresu proměnné text.

vypis_znak:
lodsb                                   ; Načteme hodnotu z adresy do registru AL a posuneme ukazatel.
cmp al, 0x00                            ; Pokud je hodnota v registru AL rovna hodnotě 0x00 (NULL)...
jz .konec                               ; ...skočíme na .konec.
mov ah, 0x0e                            ; Funkce BIOSu pro tisk znaku.
int 0x10                                ; A nyní, BIOSe, vytiskni znak!
jmp vypis_znak                          ; Pokračujeme v cyklu.

.konec:
ret

text resd 0x01                          ; Definujeme proměnnou text o 4 bajtech.