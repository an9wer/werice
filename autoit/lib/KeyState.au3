Global Const $VK_NUMLOCK = 0x90
Global Const $VK_SCROLL = 0x91
Global Const $VK_CAPITAL = 0x14

ConsoleWrite(_GetNumLock() & @LF)
ConsoleWrite(_GetScrollLock() & @LF)
ConsoleWrite(_GetCaps() & @LF)

Func _GetNumLock()
    Local $ret
    $ret = DllCall("user32.dll","long","GetKeyState","long",$VK_NUMLOCK)
    Return $ret[0]
EndFunc

Func _GetScrollLock()
    Local $ret
    $ret = DllCall("user32.dll","long","GetKeyState","long",$VK_SCROLL)
    Return $ret[0]
EndFunc

Func _GetCaps()
    Local $ret
    $ret = DllCall("user32.dll","long","GetKeyState","long",$VK_CAPITAL)
    Return $ret[0]
EndFunc

