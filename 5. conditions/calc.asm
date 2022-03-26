%include "asm_io.inc"

; Uninicialized data
segment .bss
        a   resd 1
        b   resd 1
        op  resd 1
        res resd 1

; Inicialized data
segment .data
        prompt_op  db "Enter operation number (1 - addition, 2 - multiplication): ", 0
        prompt1    db "Enter first number: ", 0
        prompt2    db "Enter second number: ", 0
        error_msg  db "Invalid operation selected.", 0xA, 0
        plus_sign  db " + ", 0
        mul_sign   db " * ", 0
        equal_sign db " = ", 0

; Program text
segment .text
global  _asm_main
_asm_main:
        enter 0,0 ; create the stack
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Input operation
        mov    eax, prompt_op
        call   print_string
        call   read_int
        mov    dword [op], eax

        ; Input first number
        mov    eax, prompt1
        call   print_string
        call   read_int
        mov    dword [a], eax

        ; Input second number
        mov    eax, prompt2
        call   print_string
        call   read_int
        mov    dword [b], eax

        ; Prettify the output
        call   print_nl

        ; Check the operation
        cmp    dword [op], 1
        je     add_numbers
        cmp    dword [op], 2
        je     mul_numbers

        ; Fallback for invalid operation
        invalid_op:
          ; Print the error message
          mov  eax, error_msg
          call print_string
          jmp  quit

        add_numbers:
          ; Add numbers
          mov  eax, dword [a]
          add  eax, dword [b]
          mov  dword [res], eax

          ; Echo the input
          mov  eax, dword [a]
          call print_int
          mov  eax, plus_sign
          call print_string
          mov  eax, dword [b]
          call print_int
          mov  eax, equal_sign
          call print_string
          ; Print the result
          mov  eax, dword [res]
          call print_int
          ; Prettify the output
          call print_nl

          ; Exit
          jmp  quit

        mul_numbers:
          ; Multiplicate the numbers
          mov  eax, dword [a]
          imul eax, dword [b]
          mov  dword [res], eax

          ; Echo the input
          mov  eax, dword [a]
          call print_int
          mov  eax, mul_sign
          call print_string
          mov  eax, dword [b]
          call print_int
          mov  eax, equal_sign
          call print_string
          ; Print the result
          mov  eax, dword [res]
          call print_int
          ; Prettify the output
          call print_nl

          ; Exit
          jmp  quit

;--------------------------------------------------
        quit:
          popa         ; restore all registers
          mov   eax, 0 ; put 0 in eax
          leave        ; free the stack
          ret          ; return
