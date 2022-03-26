%include "asm_io.inc"

segment .bss

segment .data
        hello_msg dd "Hello, world!", 0
        sign_msg  dd "Хафизов Булат, ПС-13", 0

segment .text
global  _asm_main
_asm_main:
        enter   0,0  ; create the stack
        pusha        ; save all registers in a stack on case of something
;--------------------------------------------------

        mov    eax, hello_msg   ; put hello_msg in eax
        call   print_string     ; print the message

        call   print_nl         ; print newline

        mov    eax, sign_msg    ; put sign_msg in eax
        call   print_string     ; print the message

;--------------------------------------------------
        popa        ; restore all registers
        mov eax, 0
        leave       ; free the stack
        ret         ; return
