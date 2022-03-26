%include "asm_io.inc"

; Uninicialized data
segment .bss
        counter resd 1
        result  resd 1

; Inicialized data
segment .data
        info    db "Enter numbers for summation. When finished, enter 0.", 0xA, 0
        prompt  db "> ", 0
        res_msg db "Sum of given numbers equals ", 0

; Program text
segment .text
global  _asm_main
_asm_main:
        enter 0,0 ; create the stack
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Print the information
        mov    eax, info
        call   print_string

        ; Input numbers until 0 is inserted
        mov    dword [counter], 0
        loop1:
          mov  eax, prompt
          call print_string
          call read_int
          push eax
          inc  dword [counter]
          cmp  eax, 0
          jne  loop1

        ; Sum the numbers
        mov    dword [result], 0
        loop2:
          pop  eax
          add  dword [result], eax
          dec  dword [counter]
          cmp  dword [counter], 0
          jg   loop2

        ; Print the result
        call   print_nl
        mov    eax, res_msg
        call   print_string
        mov    eax, dword [result]
        call   print_int
        call   print_nl

;--------------------------------------------------
        popa         ; restore all registers
        mov   eax, 0 ; put 0 in eax
        leave        ; free the stack
        ret          ; return
