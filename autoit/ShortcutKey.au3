#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include "lib/HotString.au3"
#include "lib/KeyState.au3"

HotStringSet("DJS", "django_runserver")

While 1
    Sleep(1000)
WEnd

Func django_runserver()
    If _GetCaps() = 1 Then
        Send("{BS 3}")
        Send("python manage.py runserver 0.0.0.0:80")
    EndIf
EndFunc
