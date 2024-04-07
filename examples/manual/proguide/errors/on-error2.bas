'' examples/manual/proguide/errors/on-error2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Error Handling'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

#define Config 1
'#DEFINE Config 2
'#DEFINE Config 3
'#DEFINE Config 4



#if Config = 1 '-----------------------------------------------------------

Open "does_not_exist" For Input As #1

Print "main end"
Sleep
System

' - with compiler option 'none' :
'     console output :
'       'main end'
'
' - with compiler option '-e' or '-ex' or '-exx' :
'     console output :
'       'Aborting due to runtime error 2 (file not found) at line 10 of .....'

#endif '-------------------------------------------------------------------



#if Config = 2 '-----------------------------------------------------------

Dim As Integer Result = Open("does_not_exist" For Input As #1)
If Result <> 0 Then
	Print "error code returned: " & Result
	Print "file not found (processed by 'Result = Open(.....)')"
End If

Print "main end"
Sleep
End

' - with compiler option 'none' or '-e' or '-ex' or '-exx' :
'     console output :
'       'error code returned: 2'
'       'file not found (processed by 'Result = Open(.....)')'
'       'main end'

#endif '-------------------------------------------------------------------



#if Config = 3 '-----------------------------------------------------------

On Error Goto Error_Handler
Open "does_not_exist" For Input As #1

Print "main end"
Sleep
End

error_handler:
Print "file not found (processed by 'On Error Goto')"
On Error Goto 0
Print "QB-like error handling end"
Sleep
End

' - with compiler option 'none' :
'     console output :
'       'main end'
'
' - with compiler option '-e' or '-ex' or '-exx' :
'     console output :
'       'file not found (processed by 'On Error Goto')'
'       'QB-like error handling end'

#endif '-------------------------------------------------------------------



#if Config = 4 '-----------------------------------------------------------

On Error Goto error_handler
Dim As Integer Result = Open("does_not_exist" For Input As #1)
If Result <> 0 Then
	Print "error code returned: " & Result
	Print "file not found (processed by 'Result = Open(.....)')"
End If

Print "main end"
Sleep
End

error_handler:
Print "file not found (processed by 'On Error Goto')"
On Error Goto 0
Print "QB-like error handling end"
Sleep
End

' - with compiler option 'none' or '-e' or '-ex' or '-exx' :
'     console output :
'       'error code returned: 2'
'       'file not found (processed by 'Result = Open(.....)')'
'       'main end'

#endif '-------------------------------------------------------------------
	
