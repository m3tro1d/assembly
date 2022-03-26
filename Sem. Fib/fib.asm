%include "asm_io.inc"

; Uninicialized data
segment .bss
        index      resd 1

; Inicialized data
segment .data
        prompt     db "Enter a fibonacci index: ", 0
        index_msg  db "Fibonacci number at index ", 0
        equals_msg db " equals ", 0

; Program text
segment .text
; Prints the result in a nice form
print_result:
        ; Save eax
        push eax
        ; Echo the input
        mov  eax, index_msg
        call print_string
        mov  eax, dword [index]
        call print_int
        mov  eax, equals_msg
        call print_string
        ; Print the result
        pop eax
        call print_int
        ; Prettify the output
        call print_nl
        ret

; Calculates the fib numbers recursively & stores the result in eax
; Maximum valid value of n = 46
; fib(n)
fib:
        ; Create stack frame
        push   ebp
        mov    ebp, esp
        mov    eax, dword [ebp+8] ; Get the n

        ; Check n's value
        cmp    eax, 2
        jg     recurse
        mov    eax, 1
        jmp    done

        ; Recursive section
        recurse:
          dec  eax      ; n - 1
          push eax      ; Save n - 1 and provide argument for fib(n - 1)
          call fib      ; Call fib(n - 1)
          pop  ebx      ; Pop n - 1
          push eax      ; Save fib(n - 1)
          dec  ebx      ; n - 2
          push ebx      ; Argument for fib(n - 2)
          call fib      ; Call fib(n - 2)
          add  esp, 4   ; Clear the stack from the parameter n - 2
          pop  ecx      ; Pop fib(n - 1)
          add  eax, ecx ; Calculate the actual value in eax (fib(n - 2) + fib(n - 1))

        done:
          ; Clear the stack frame
          mov  esp, ebp
          pop  ebp
          ret

global  _asm_main
; Program entry point
_asm_main:
        enter 0,0 ; create the stack frame
        pusha     ; save all registers in a stack on case of something
;--------------------------------------------------

        ; Input the index
        mov    eax, prompt
        call   print_string
        call   read_int
        mov    dword [index], eax

        ; Check if index = 0
        cmp    dword [index], 0
        je     zero_index

        ; Do the job
        push   dword [index]
        call   fib
        add    esp, 4

        ; Print the result (assume that it's in eax)
        call   print_result
        jmp    quit

        ; Special message if index = 0
        zero_index:
          mov  eax, 0
          call print_result

;--------------------------------------------------
        quit:
          popa         ; restore all registers
          mov   eax, 0 ; put 0 in eax
          leave        ; free the stack frame
          ret          ; return
