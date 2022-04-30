'' examples/manual/console/input.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INPUT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInput
'' --------

Dim user_name As String, user_age As Integer

Input "Enter your name and age, separated by a comma: ", user_name, user_age

Print "Your name is " & user_name & ", and you are " & user_age & " years old."
