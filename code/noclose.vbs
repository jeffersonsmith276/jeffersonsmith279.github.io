Dim objWMIService, colProcesses, objProcess, PID
Dim objShell
Dim subString
Dim position
Dim mainString
Set objShell = CreateObject("WScript.Shell")
subString = "blank.vbs"
Function IsProcessRunningByPID(targetPID)
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colProcesses = objWMIService.ExecQuery _
        ("SELECT * FROM Win32_Process WHERE ProcessID = " & targetPID)

    If colProcesses.Count > 0 Then
        IsProcessRunningByPID = True
    Else
        IsProcessRunningByPID = False
    End If

    Set objProcess = Nothing
    Set colProcesses = Nothing
    Set objWMIService = Nothing
End Function

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'wscript.exe' OR Name = 'cscript.exe'")

For Each objProcess In colProcesses
    mainString = objProcess.CommandLine
    position = InStr(mainString, subString)
    If position > 0 Then
    PID = objProcess.ProcessID
    End If
Next

Do While True
    If IsProcessRunningByPID(PID) Then
    WScript.Timeout = 1
    Else
    objShell.Run "blank.vbs"
    Exit Do
    End If
Loop
