;;; Constants
NULL               equ 0
; Default buttons
MB_DEFBUTTON1      equ 0
MB_DEFBUTTON2      equ 0x100
; Properties
MB_OK              equ 0
MB_YESNO           equ 4
MB_ICONQUESTION    equ 0x20
MB_ICONEXCLAMATION equ 0x30
; Selections
IDYES              equ 6
IDNO               equ 7


;;; Import external symbols
extern _MessageBoxA@16
extern _ExitProcess@4


;;; Inicialised data
segment .data
        QuestionText    db "Do you like jazz?", 0
        QuestionCaption db "Huh", 0

        YesAnswerText   db "Good for you.", 0
        NoAnswerText    db "Okay then... Bye.", 0

        AnswerCaption   db "Thanks", 0


segment .text
global _Start                         ; entry point
_Start:
        ; Display the choice messagebox
        push MB_YESNO | MB_DEFBUTTON1 | MB_ICONQUESTION
        push QuestionCaption
        push QuestionText
        push NULL
        call  _MessageBoxA@16

        ; Compare the answer with the constants
        cmp eax, IDYES
        je  YesMessage
        cmp eax, IDNO
        je  NoMessage

        ; In case of 'yes' selected
        YesMessage:
          push MB_OK | MB_DEFBUTTON1 | MB_ICONEXCLAMATION
          push AnswerCaption
          push YesAnswerText
          push NULL
          call  _MessageBoxA@16
          jmp quit

        ; In case of 'no' selected
        NoMessage:
          push MB_OK | MB_DEFBUTTON1 | MB_ICONEXCLAMATION
          push AnswerCaption
          push NoAnswerText
          push NULL
          call  _MessageBoxA@16
          jmp quit

        ; Graceful exit
        quit:
          push  NULL
          call  _ExitProcess@4
