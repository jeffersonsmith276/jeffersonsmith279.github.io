Dim msgResult
Dim objShell
Set objShell = CreateObject("WScript.Shell")
objShell.Run "noclose.vbs"
Function loopFunction()
msgResult = MsgBox("Bubble or Gum" ,2 + 32, "Marmalade")
If msgResult = vbAbort Then
    objShell.Run "speak.vbs"
    Call loopFunction()
ElseIf msgResult = vbIgnore Then
    objShell.Run "speak.vbs"
    Call loopFunction()
ElseIf msgResult = vbRetry Then
    objShell.Run "speak.vbs"
    Call loopFunction()
End If
End Function
Call loopFunction()
