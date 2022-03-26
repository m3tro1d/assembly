%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
prompt db   "Enter fib position: ", 0
output db   "Fib value: ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
pos  resd 1

; Program text
segment .text
        global  _asm_main
_asm_main:
        enter   0,0               ; setup routine
        pusha

        ; Ввести позицию
        mov eax, prompt
        call print_string
        call read_int
        mov dword [pos], eax

        ; Проверить на 0
        cmp dword [pos], 0
        je zero_pos

        ; Вычислить значение
        ; eax - предыдущее число, ebx - текущее число, ecx - следующее число
        ; pos- счетчик
        mov eax, 0
        mov ebx, 1
loop_begin:
        mov ecx, eax
        add ecx, ebx ; следующее := предыдущее + текущее
        mov eax, ebx ; предыдущее := текущее
        mov ebx, ecx ; текущее := следующее
        ; проверка счетчика
        dec dword [pos]
        cmp dword [pos], 1
        jg loop_begin
        ; Вывод
        mov eax, output
        call print_string
        mov eax, ecx
        call print_int
        jmp quit

zero_pos:
        ; Вывод для pos=0
        mov eax, output
        call print_string
        mov eax, 0
        call print_int

quit:
        popa
        mov     eax, 0            ; return back to C
        leave
        ret


