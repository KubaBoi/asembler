; Náš první program - Hello, World!

org 0x0100

mov di, pismenka                         ; Nastavíme adresu v registru DI na proměnnou pismenka.
mov si, veta                             ; Nastavíme adresu v registru SI na proměnnou veta.

nacti_znak:
lodsb                                    ; Načteme znak z proměnné veta do registru AL.
cmp al, 'a'                              ; Pokud hodnota odpovídá znaku 'a' (pouze malému)...
jz .pridej_znak                          ; ...skoč na .pridej_znak
cmp al, 'A'                              ; Varianta pro 'A'...
jz .pridej_znak                          ; ...skoč na .pridej_znak
cmp al, 0x00                             ; Pokud je číslo znaku 0x00 (NULL)...
jz .prokracuj                            ; ...skoč na .pokracuj.
jmp nacti_znak                           ; Pokud se jedná o jinou hodnotu, pokračujeme v cyklu.

.pridej_znak:
mov byte [di], al                        ; Přesuneme hodnotu na adresu v registru DI (do proměnné pismenka).
inc di                                   ; Posuneme se na další adresu (nastavíme ukazatel na další bajt v proměnné pismenka).
jmp nacti_znak

.pokracuj:
mov byte [di], 0x00                      ; Nyní zakončíme řetězec přesunutím hodnoty 0x00 do proměnné pismenka.

mov si, pismenka                         ; Nastavíme adresu v registru SI na proměnnou pismenka.

vypis_znak:
lodsb                                    ; Načteme znak z proměnné pismenka do registru AL.
cmp al, 0x00                             ; Pokud je číslo znaku 0x00 (NULL)...
jz .konec                                ; ...skoč na .konec.
mov ah, 0x0e                             ; Funkce BIOSu pro tisk znaku.
int 0x10                                 ; A nyní, BIOSe, vytiskni znak!
jmp vypis_znak                           ; Pokračujeme v cyklu.

.konec:
ret                                      ; Vrať kontrolu operačnímu systému.

veta db "Ahoj, jak se mas, Karle?", 0x00 ; Definujeme proměnnou veta.
pismenka resw 0x05                       ; Definujeme proměnnou pismenka o 10 bajtech.