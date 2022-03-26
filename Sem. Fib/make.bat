nasm -f win32 fib.asm

nasm -f win32 -o asm_io.obj asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o fib fib.obj driver.obj asm_io.obj
