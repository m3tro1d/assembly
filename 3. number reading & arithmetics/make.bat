nasm -f win32 sum.asm

nasm -f win32 asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o sum sum.obj driver.obj asm_io.obj
