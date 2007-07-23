'' examples/manual/system/fre.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFre
'' --------

Dim mem As Integer = Fre

Print "Free memory:"
Print
Print mem; " bytes"
Print mem  \ 1024; " kilobytes"
Print mem  \ (1024 * 1024); " megabytes"
