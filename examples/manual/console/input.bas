'' examples/manual/console/input.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInput
'' --------

Dim user_name As String, user_age As Integer

Input "Enter your name and age, separated by a comma: ", user_name, user_age

Print "Your name is " & user_name & ", and you are " & user_age & " years old."
