'' examples/manual/proguide/preprocessor.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Preprocessor'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPreprocessor
'' --------

#include "vbcompat.bi"
#define TEMPLATE "hh:mm:ss yyyy/mm/dd"

Dim As String * Len(TEMPLATE) hour_date

hour_date = Format(Now, TEMPLATE)

Print hour_date, "(" & TEMPLATE & ")"

Sleep
		
