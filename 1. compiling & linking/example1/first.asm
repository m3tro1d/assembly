%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt db    "Enter a number: ", 0       ; don't forget nul terminator
outmsg db    "You entered ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input  resd 1 

;
; code is put in the .text segment
;
segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input], eax     ; store into input

        dump_regs 1               ; dump out register values
;
; next print out result message as series of steps
;
        mov     eax, outmsg
        call    print_string      ; print out message
        mov     eax, [input]     
        call    print_int         ; print out input
        call    print_nl          ; print new-line

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


