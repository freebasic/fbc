'' examples/manual/system/fileattr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FILEATTR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFileattr
'' --------

#include "vbcompat.bi"
#include "crt.bi"

Dim f As FILE Ptr, i As Integer

'' Open a file and write some text to it

Open "test.txt" For Output As #1
f = Cast( FILE Ptr, FileAttr( 1, fbFileAttrHandle ))
For i = 1 To 10
  fprintf( f, !"Line %i\n", i )
Next i
Close #1

'' re-open the file and read the text back

Open "test.txt" For Input As #1
f = Cast( FILE Ptr, FileAttr( 1, fbFileAttrHandle ))
While feof(f) = 0
  i = fgetc(f)
  Print Chr(i);
Wend
Close #1
