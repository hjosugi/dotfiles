*vk1D:: Send("{Blind}{Ctrl DownTemp}")
*vk1D Up:: Send("{Blind}{Ctrl Up}")

IMEGetstate() {
    vcurrentwindow := WinExist("A")
    vimestate := DllCall("user32.dll\SendMessageA", "Ptr", DllCall("imm32.dll\ImmGetDefaultIMEWnd", "Ptr", vcurrentwindow), "UInt", 0x0283, "Int", 0x0005, "Int", 0)
    return vimestate
}

; F13 + vk1CでIMEがオフの場合はF3を送信、それ以外はvk1Cを送信
F13 & vk1C:: SendInput("{vk1C}")

F13 & vk1D:: SendInput("{vk1D}")

; キーバインディングの設定
F13 & f:: SendInput("{Right}")     ; 次の文字
F13 & p:: SendInput("{Up}")        ; 前の行
F13 & n:: SendInput("{Down}")      ; 次の行
F13 & b:: SendInput("{Left}")      ; 前の文字
F13 & a:: SendInput("{Home}")      ; 行の先頭に移動
F13 & e:: SendInput("{End}")       ; 行の末尾に移動
F13 & d:: SendInput("{Delete}")    ; 文字を削除
F13 & h:: SendInput("{Backspace}") ; 前の文字を削除
F13 & m:: SendInput("{Enter}")     ; 改行
F13 & c::^c
F13 & v::^v
F13 & w::^w
F13 & t::^t
F13 & `;::-