'' examples/manual/udt/type3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

'example showing the problems with fixed length string fields in UDT's

'a gif header definition 
Type hdr Field=1
   sig As String *5   'must dimension it one char less than the actual length of 6!!!
   As UShort wid,hei  'or the rest of fields will be unaligned
End Type


'suppose we have read a gif header from a file
'(we simulate it here by filling a buffer)
'                     signature  width     height     
Dim As ZString *20 z=>"GIF89a"+MKShort(10)+MKShort(11)
Dim As hdr Ptr h=@z

Print h->sig, h->wid,h->hei  'prints GIF89 (misses a char!!!)  10, 11 (ok) 

Print "no way to check for the complete signature !!!!"

Print "This fails"
If h->sig ="GIF89" Then Print "ok" Else Print "error"  'prints error
If h->sig ="GIF89a" Then Print "ok" Else Print "error" 'prints error

Print "A way somewhat complicated...and can't check for the last char"
If Left(h->sig,5)="GIF89" Then Print "ok" Else Print "error"  'prints ok

Sleep

