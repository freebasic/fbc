'' examples/manual/defines/fberr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfberr
'' --------

'Example code to demonstrate a use of __FB_ERR__
Dim err_command_line As UByte
err_command_line = __FB_ERR__
Select Case err_command_line
Case 0
Print "No Error Checking enabled on the Command Line!"
Case 1
Print "Some Error Checking enabled on the Command Line!"
Case 3
Print "QBasic style Error Checking enabled on the Command Line!"
Case 7
Print "Extreme Error Checking enabled on the Command Line!"
Case Else
Print "Some Unknown Error level has been set!"
End Select

