'' examples/manual/proguide/labels/labels_2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgLabels
'' --------

'' compile with -lang qb

'$lang: "qb"

'' Labels can be used to "bookmark" DATA blocks, allowing RESTORE to alter the READ sequence.
Read a,b,c
Restore here
Read d,e
Print a,b,c,d,e 

Data 1,2,3,4,5
here:
Data 6,7,8
