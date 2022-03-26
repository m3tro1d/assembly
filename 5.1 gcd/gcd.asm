%include "asm_io.inc"

; Uninicialized data
segment .bss
        A resd 1
        B resd 1

; Inicialized data
segment .data
        info     db "This program calculates gcd(A, B).", 0
        prompt_A db "Enter A: ", 0
        prompt_B db "Enter B: ", 0
        gcd_func db "gcd(", 0
        comma    db ", ", 0
        equals   db ") = ", 0

; Program text
segment .text
; Calculates gcd(A, B) using Euclidean algorithm and stores in eax
find_gcd:
        ; Create the stack frame
        push ebp
        mov  ebp, esp
        ; Get the arguments
        mov  eax, dword [esp+8]
        mov  ebx, dword [esp+12]

        ; Save ebx
        push ebx

  loop_start:
        cmp  eax, ebx
        je   loop_end
        jg   eax_greater
        sub  ebx, eax
        jmp  loop_start

  eax_greater:
        sub  eax, ebx
        jmp  loop_start

  loop_end:
        ; Restore ebx
        pop  ebx

        ; Restore the stack frame
        mov  esp, ebp
        pop  ebp
        ret

global  _asm_main
_asm_main:
        enter 0,0 ; create the stack frame
        pusha     ; save all registers in the stack on case of something
;--------------------------------------------------

        ; Print the information
        mov  eax, info
        call print_string
        call print_nl

        ; Input the numbers
        mov  eax, prompt_A
        call print_string
        call read_int
        mov  dword [A], eax
        mov  eax, prompt_B
        call print_string
        call read_int
        mov  dword [B], eax

        ; Find the result
        push dword [B]
        push dword [A]
        call find_gcd
        add  esp, 8

        ; Print the result
        push eax
        mov  eax, gcd_func
        call print_string
        mov  eax, dword [A]
        call print_int
        mov  eax, comma
        call print_string
        mov  eax, dword [B]
        call print_int
        mov  eax, equals
        call print_string
        ; ---
        pop  eax
        call print_int
        call print_nl

;--------------------------------------------------
        quit:
          popa          ; restore all registers
          mov   eax, 0  ; put 0 in eax
          leave         ; restore the stack frame
          ret           ; return
