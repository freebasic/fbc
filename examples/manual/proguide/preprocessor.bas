'' examples/manual/proguide/preprocessor.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPreprocessor
'' --------

#include "vbcompat.bi"
#define TEMPLATE "hh:mm:ss yyyy/mm/dd"

Dim As String * Len(TEMPLATE) hour_date

hour_date = Format(Now, TEMPLATE)

Print hour_date, "(" & TEMPLATE & ")"

Sleep
		
