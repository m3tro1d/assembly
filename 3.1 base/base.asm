%include "asm_io.inc"

; Uninicialized data
segment .bss
        num  resd 1
        base resd 1

; Inicialized data
segment .data
        prompt1    dd "Enter the number: ", 0
        prompt2    dd "Enter the base: ", 0
        base_sign  dd "^", 0
        equal_sign dd " = ", 0

; Program text
segment .text
global  _asm_main
_asm_main:
        enter 0,0 ; create the stack
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Input the number
        mov    eax, prompt1
        call   print_string
        call   read_int
        mov    dword [num], eax

        ; Input the base
        mov    eax, prompt2
        call   print_string
        call   read_int
        mov    dword [base], eax

        ; Calculate the base (ecx as counter, store in ebx)
        mov    ebx, 1
        mov    ecx, 1
        loop:
          imul ebx, dword [num]
          inc  ecx
        cmp    ecx, dword [base]
        jle    loop

        ; Prettify the output
        call   print_nl

        ; Print the number
        mov    eax, dword [num]
        call   print_int
        ; Print the base sign
        mov    eax, base_sign
        call   print_string
        ; Print the base
        mov    eax, dword [base]
        call   print_int
        ; Print the equality sign
        mov    eax, equal_sign
        call   print_string
        ; Print the result
        mov    eax, ebx
        call   print_int

        ; Prettify the output
        call   print_nl

;--------------------------------------------------
        popa         ; restore all registers
        mov   eax, 0 ; put 0 in eax
        leave        ; free the stack
        ret          ; return
