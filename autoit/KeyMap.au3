#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include "lib/HotString.au3"
#include "lib/KeyState.au3"

HotStringSet("H", "move_left")
HotStringSet("J", "move_down")
HotStringSet("K", "move_up")
HotStringSet("L", "move_right")

While 1
    Sleep(1000)
WEnd

Func move_left()
    If _GetCaps() = 1 Then
        Send("{BS}")
        Send("{LEFT}")
    EndIf
EndFunc
        
Func move_down()
    If _GetCaps() = 1 Then
        Send("{BS}")
        Send("{DOWN}")
    EndIf
EndFunc

Func move_up()
    If _GetCaps() = 1 Then
        Send("{BS}")
        Send("{UP}")
    EndIf
EndFunc

Func move_right()
    If _GetCaps() = 1 Then
        Send("{BS}")
        Send("{RIGHT}")
    EndIf
EndFunc
