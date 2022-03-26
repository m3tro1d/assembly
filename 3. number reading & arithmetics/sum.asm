%include "asm_io.inc"

; Uninicialized data
segment .bss
        input1 resd 1
        input2 resd 1

; Inicialized data
segment .data
        prompt1    dd "Enter first number: ", 0
        prompt2    dd "Enter second number: ", 0
        plus_sign  dd " + ", 0
        equal_sign dd " = ", 0

; Program text
segment .text
global  _asm_main
_asm_main:
        enter 0,0 ; create the stack
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Input first number
        mov  eax, prompt1
        call print_string
        call read_int
        mov  dword [input1], eax

        ; Input second number
        mov  eax, prompt2
        call print_string
        call read_int
        mov  dword [input2], eax

        ; Prettify the output
        call print_nl

        ; Echoed input
        mov   eax, dword [input1]
        call  print_int
        mov   eax, plus_sign
        call  print_string
        mov   eax, dword [input2]
        call  print_int
        mov   eax, equal_sign
        call  print_string

        ; Print the result
        mov   eax, dword [input1]
        add   eax, dword [input2]
        call  print_int

        ; Prettify the output
        call  print_nl

;--------------------------------------------------
        popa         ; restore all registers
        mov   eax, 0 ; put 0 in eax
        leave        ; free the stack
        ret          ; return
