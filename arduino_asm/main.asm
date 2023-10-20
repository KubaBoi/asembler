; Copyright 2015 Marius Ghita
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

;"C:\Program Files (x86)\Arduino\hardware\tools\avr/bin/avrdude.exe" -C"C:\Program Files (x86)\Arduino\hardware\tools\avr/etc/avrdude.conf" -v -patmega328p -carduino -PCOM6 -b115200 -D -Uflash:w:"$(ProjectDir)Debug\$(TargetName).hex":i

; Everything after a semicolon is a comment

; We specify the Atmel microprocessor. The Uno uses ATmega328P,
; older versions might use ATmega328 
.device ATmega328P

; These are all constant definitions taken from m328Pdef.inc
; and we will go in more detail of what they are, when they
; are used
.equ PORTB_ = 0x05
.equ PORTD_ = 0x0b
.equ PIND_  = 0x09
.equ DDRB_  = 0x04
.equ DDRD_  = 0x0a
.def	mask 	= r16		; mask register
.def	ledR 	= r17		; led register
.def	loopCt	= r18		; delay loop count
.def	iLoopRl = r24		; inner loop register low
.def	iLoopRh = r25		; inner loop register high

.equ	iVal 	= 39998	

; At ORiGin 0x0000 we "hook" in our call to our programm main
; we do not write our program here, as of why, we will go over
; that later
.org 0x0000
    jmp main

; DDR* are used just for specifing what will be an input
; pin, and what will be an output pin.
main:

	;ldi	r16,LOW(RAMEND)		; initialize
	;out	SPL,r16			; stack pointer
	;ldi	r16,HIGH(RAMEND)	; to RAMEND
	;out	SPH,r16			; "

    ; DDRB maps over pins 8-13.
    ; We set[1] pin 10 and 12 (starting DDRB pin is 8):
    ;  - 8 + 2 = 10
    ;  - 8 + 4 = 12
    ; [1] Set means we assign the bit value to 1 = output
    sbi DDRB_, 2
	sbi DDRB_, 3
    sbi DDRB_, 4
    ; DDRD maps over pins 0-7
    ; We set pin 5: 0 + 5 = 5
    sbi DDRD_, 5
    
    ; DDRD maps over pins 0-7
    ; We clear the 2nd bit: 0 + 2 = 2
    ; Clear means we assign the bit value to 0 = input
    ; just set register r20 to 0
    ;clr r20
	;ldi r20, 0 ; prepne r20

	loop:
		sbi PORTB_, 4 ; zapne pin 12 + 4
		
		ldi	loopCt,100		; initialize delay multiple for 0.5 sec
		rcall	delay10ms		; call delay subroutine
		
		cbi PORTB_, 4; vypne pin 12 + 4

		ldi	loopCt,100		; initialize delay multiple for 0.5 sec
		rcall	delay10ms		; call delay subroutine

		jmp loop

delay10ms:
	ldi	iLoopRl,LOW(iVal)	; intialize inner loop count in inner
	ldi	iLoopRh,HIGH(iVal)	; loop high and low registers

iLoop:	
	sbiw	iLoopRl,1		; decrement inner loop registers
	brne	iLoop			; branch to iLoop if iLoop registers != 0
	dec	loopCt			; decrement outer loop register
	brne	delay10ms		; branch to oLoop if outer loop register != 0
	nop				; no operation
	ret	

