'' examples/manual/error/onerror.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOnerror
'' --------

'' Compile with QB (-lang qb) dialect

'$lang: "qb"

On Error Goto errorhandler
Error 24 '' simulate an error
Print "this message will not be seen"

errorhandler:
n = Err
Print "Error #"; n; "!"
End
