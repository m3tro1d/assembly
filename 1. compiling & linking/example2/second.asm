                                                ; Message Box, 32 bit. V1.01
NULL          EQU 0                             ; Constants
MB_DEFBUTTON1 EQU 0
MB_DEFBUTTON2 EQU 100h
IDNO          EQU 7
MB_YESNO      EQU 4

extern _MessageBoxA@16                          ; Import external symbols
extern _ExitProcess@4                           ; Windows API functions, decorated

global _Start                                    ; Export symbols. The entry point

segment .data                                   ; Initialized data segment
 MessageBoxText    db "Do you want to exit?", 0
 MessageBoxCaption db "MessageBox 32", 0

segment .text                                   ; Code segment
_Start:
 push  MB_YESNO | MB_DEFBUTTON2                 ; 4th parameter. 2 constants ORed together
 push  MessageBoxCaption                        ; 3rd parameter
 push  MessageBoxText                           ; 2nd parameter
 push  NULL                                     ; 1st parameter
 call  _MessageBoxA@16

 cmp   EAX, IDNO                                ; Check the return value for "No"
 je    _Start

 push  NULL
 call  _ExitProcess@4