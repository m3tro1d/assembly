nasm -f win32 second.asm

link /ENTRY:Start /SUBSYSTEM:WINDOWS /LIBPATH:"D:\Documents\Educational\MZYAP\Soft\masm32\lib" kernel32.lib user32.lib second.obj
