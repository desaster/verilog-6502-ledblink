; Copyright (c) 2018 Upi Tamminen, All rights reserved.
; See the LICENSE file for more information

	*=$fc00 ; rom is at top of memory fc00-ffff

num1	= $0200		; counter, intended to be attached to leds
scountl	= $0201		; sleep counter low byte
scounth	= $0202		; sleep counter low byte

	ldx #$ff	; setup stack
	txs

	lda #$00	; start value
	sta num1	; store it to memory

loop:
	lda num1	; start by reading our value from memory
	sta $0400	; write value to gpio - if target board doesn't have
			; enough leds, just make sure at least the lowest bit
			; is assigned to led
	inc num1	; increment value in memory for the next iteration

!if SIM = 0 {
	jsr sleep	; sleep
}
	jmp loop

; software sleep, this of course depends on clock speed
sleep:
	lda #00		; reset counters
	sta scountl
	sta scounth
sleep_loop:
	inc scountl	; increase lower byte of the counter
	bne sleep_loop	; if low byte didn't loop over, keep looping

	inc scounth     ; low byte looped over, increase high byte
	bne sleep_loop	; if high byte didn't loop over, keep looping

	rts		; high byte looped over, we're done

; vim: set ft=acme sw=8 sts=8 noet:
