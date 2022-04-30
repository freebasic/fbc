'' examples/manual/console/lineinput.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLineinput
'' --------

Dim s As String
Line Input "Enter a line"; s
Print "Full line that you entered:"
Print "'"; s; "'"
Print

Const maxlength = 11  '' max 10 characters plus 1 null terminal character
Dim pz As ZString Ptr = CAllocate(maxlength, SizeOf(ZString))
Line Input "Enter a line"; *pz, maxlength
Print "First " & maxlength - 1 & " characters that you entered:"
Print "'"; *pz; "'"
Deallocate(pz)
