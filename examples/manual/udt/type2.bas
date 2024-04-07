'' examples/manual/udt/type2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

'' Example showing the problems with fixed length string fields in UDTs
'' Suppose we have read a GIF header from a file
''                        signature         width        height
Dim As ZString*(10+1) z => "GIF89a" + MKShort(10) + MKShort(11)

Print "Using fixed-length string"

Type hdr1 Field = 1
   As String*(6-1) sig /' We have to dimension the string with 1 char
						'  less to avoid misalignments '/
   As UShort wid, hei
End Type

Dim As hdr1 Ptr h1 = CPtr(hdr1 Ptr, @z)
Print h1->sig, h1->wid, h1->hei '' Prints GIF89 (misses a char!)  10  11

'' We can do comparisons only with the 5 visible chars and creating a temporary string with LEFT

If Left(h1->sig, 5) = "GIF89" Then Print "ok" Else Print "error"


'' Using a ubyte array, we need an auxiliary function to convert it to a string
Function ub2str( ub() As UByte ) As String
	Dim As String res = Space(UBound(ub) - LBound(ub) + 1)
	For i As Integer = LBound(ub) To UBound(ub)
		res[i - LBound(ub)] = ub(i)
	Next
	Function = res
End Function


Print
Print "Using an array of ubytes"

Type hdr2 Field = 1
   sig(0 To 6-1) As UByte '' Dimension 6
   As UShort wid, hei
End Type

Dim As hdr2 Ptr h2 = CPtr(hdr2 Ptr, @z)
'' Viewing and comparing is correct but a conversion to string is required

Print ub2str(h2->sig()), h2->wid, h2->hei '' Prints GIF89a  10  11 (ok)
If ub2str(h2->sig()) = "GIF89a" Then Print "ok" Else Print "error" '' Prints ok
