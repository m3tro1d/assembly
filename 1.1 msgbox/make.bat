nasm -f win32 msgbox.asm

link /ENTRY:Start /SUBSYSTEM:WINDOWS /LIBPATH:"D:\Documents\Educational\MZYAP\Soft\masm32\lib" kernel32.lib user32.lib msgbox.obj
