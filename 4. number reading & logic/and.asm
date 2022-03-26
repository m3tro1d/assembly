%include "asm_io.inc"

; Uninicialized data
segment .bss
        A   resd 1
        B   resd 1
        res resd 1

; Inicialized data
segment .data
        info       db "This program computes bytewise logical AND (A & B).", 0xA, 0
        prompt1    db "Enter first number (A): ", 0
        prompt2    db "Enter second number (B): ", 0
        dec_res    db "Result in decimal: ", 0xA, 0
        bin_res    db "Result in binary: ", 0xA, 0
        and_sign   db " & ", 0
        equal_sign db " = ", 0

; Program text
segment .text
extern _print_int_bin
global _asm_main
_asm_main:
        enter 0,0 ; create the stack
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Greeting
        mov  eax, info
        call print_string

        ; Input A
        mov  eax, prompt1
        call print_string
        call read_int
        mov  dword [A], eax

        ; Input B
        mov  eax, prompt2
        call print_string
        call read_int
        mov  dword [B], eax

        ; Prettify the output
        call print_nl

        ; Calculate the result
        mov  eax, dword [A]
        mov  ebx, dword [B]
        and  eax, ebx
        mov  dword [res], eax

        ; Print the result in decimal
        mov  eax, dec_res
        call print_string
        mov  eax, dword [A]
        call print_int
        mov  eax, and_sign
        call print_string
        mov  eax, dword [B]
        call print_int
        mov  eax, equal_sign
        call print_string
        mov  eax, dword [res]
        call print_int

        ; Prettify the output
        call print_nl
        call print_nl

        ; Print the result in binary
        mov  eax, bin_res
        call print_string
        push dword [A]
        call _print_int_bin
        call print_nl
        mov  eax, and_sign
        call print_string
        call print_nl
        push dword [B]
        call _print_int_bin
        call print_nl
        mov  eax, equal_sign
        call print_string
        call print_nl
        push dword [res]
        call _print_int_bin

        ; Prettify the output
        call print_nl

;--------------------------------------------------
        popa         ; restore all registers
        mov   eax, 0 ; put 0 in eax
        leave        ; free the stack
        ret          ; return
