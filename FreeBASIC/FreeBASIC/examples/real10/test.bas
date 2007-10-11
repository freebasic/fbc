#include once "real10.bi"

	Dim As ext x, y, z
	Dim As Integer i

	For i=1 To 20
	    x = i
	    y = xLog( x )
	    z = xExp( y )
	    Print Using("##"); i;
	    Print y;"   ";
	    Print z
	Next

 