nasm -f win32 helloworld.asm

nasm -f win32 asm_io.asm

gcc -m32 -c -o driver.obj driver.c

gcc -m32 -o helloworld helloworld.obj driver.obj asm_io.obj
