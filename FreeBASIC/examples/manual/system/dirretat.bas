'' examples/manual/system/dirretat.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

'' Example of using DIR function and retrieving attributes

Dim As Integer GRRR '' Signed because x?x?x?x?x

Dim As UByte VNATTR, VBISDIR
Dim As UInteger VNFILES=0, VNDIRS=0
Dim As String VSQQ

? "DIR" : ?

VSQQ=Dir("*.*",55,@GRRR) '' 55 - Input ATTR mask - all files and subdirs

Do
	If Len(VSQQ) = 0 Then Exit Do '' Empty string breaks Wiki parsing 
	If (VSQQ<>".") And (VSQQ<>"..") Then '' Not interested in dots
		VNATTR=Cast(UByte,GRRR) : VBISDIR=(VNATTR And 16) Shr 4
		VNDIRS=VNDIRS+VBISDIR : VNFILES=VNFILES+1-VBISDIR
		Do
	  		If Len (VSQQ) >= 10 Then Exit Do '' Pad to at least 10 chars
	  		VSQQ=VSQQ + " " 
		Loop  
		? VSQQ ; " A" ; VNATTR ; " D" ; VBISDIR
	End If
	VSQQ=Dir(@GRRR)
Loop

? : ? "Found " ; VNFILES ; " files and " ; VNDIRS ; " subdirs" : ?
End
