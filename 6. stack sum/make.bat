nasm -f win32 stack_sum.asm

nasm -f win32 -o asm_io.obj asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o stack_sum stack_sum.obj driver.obj asm_io.obj
