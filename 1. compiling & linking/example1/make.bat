nasm -fwin32 first.asm

nasm -fwin32 asm_io.asm

gcc -m32 -c driver.c -o driver.obj

gcc -m32 -o first first.obj asm_io.obj driver.obj
