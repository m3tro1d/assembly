nasm -f win32 calc.asm

nasm -f win32 asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o calc calc.obj driver.obj asm_io.obj
