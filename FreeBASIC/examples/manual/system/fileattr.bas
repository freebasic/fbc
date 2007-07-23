'' examples/manual/system/fileattr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFileattr
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
