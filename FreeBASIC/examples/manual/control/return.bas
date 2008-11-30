'' examples/manual/control/return.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReturn
'' --------

'' GOSUB & RETURN example, compile with "-lang qb" or use "$lang" as below

'$lang: "qb"

Print "Let's Gosub!"
GoSub MyGosub
Print "Back from Gosub!"
Sleep
End

MyGosub:
Print "In Gosub!"
Return
