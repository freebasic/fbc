'' examples/manual/error/onerror.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ON ERROR'
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
