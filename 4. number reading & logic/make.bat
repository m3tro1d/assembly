nasm -f win32 and.asm

nasm -f win32 asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o and and.obj driver.obj asm_io.obj
