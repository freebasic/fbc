#include once "real10.bi"

Dim As ext x, y, z

For i as integer =1 To 20
	x = i
	y = xLog( x )
	z = xExp( y )
	Print Using("##"); i;
	Print y;"   ";
	Print z
Next
