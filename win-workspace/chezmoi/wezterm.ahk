^.::
{ ; V1toV2: Added bracket
  ApplicationBinaryName := "wezterm-gui.exe"
  ApplicationBinaryPath := "`"C:\Users\hjosu\scoop\shims\wezterm.exe`""

  ErrorLevel := ProcessExist(ApplicationBinaryName)
  if (ErrorLevel = 0)
  {
    Run(ApplicationBinaryPath, A_WorkingDir)
    ErrorLevel := !WinWait("ahk_exe " ApplicationBinaryName)
    WinActivate("ahk_exe " ApplicationBinaryName)
    Exit()
  }

  WinState := WinGetMinMax("ahk_exe " ApplicationBinaryName)
  if (WinState = -1)
  {
    WinActivate("ahk_exe " ApplicationBinaryName)
  }
  else
  {
    WinMinimize("ahk_exe " ApplicationBinaryName)
  }

  return
} ; V1toV2: Added bracket in the end
