'' examples/manual/fileio/openerr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenErr
'' --------

Dim a As String
Open Err For Input  As #1
Print #1,"Please write something and press ENTER"
Line Input #1, a 
Print #1, "You wrote"; a
Close
Sleep
