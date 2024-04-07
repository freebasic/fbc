'' examples/manual/defines/fberr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ERR__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfberr
'' --------

'Example code to demonstrate a use of __FB_ERR__

Dim fb_err_value As Integer
fb_err_value = __FB_ERR__
If fb_err_value = 0 Then
	Print "no flag enabled"
Else
	If fb_err_value And 1 Then
		Print "'errorcheck' flag enabled"
	End If
	If fb_err_value And 2 Then
		Print "'resumeerr' flag enabled"
	End If
	If fb_err_value And 4 Then
		Print "'extraerrchk' flag enabled"
	End If
	If fb_err_value And 8 Then
		Print "'arrayboundchk' flag enabled"
	End If
	If fb_err_value And 16 Then
		Print "'nullptrchk' flag enabled"
	End If
	If fb_err_value And 32 Then
		Print "'assertions' flag enabled"
	End If
	If fb_err_value And 64 Then
		Print "'debuginfo' flag enabled"
	End If
	If fb_err_value And 128 Then
		Print "'debug' flag enabled"
	End If
	If fb_err_value And 256 Then
		Print "'errlocation' flag enabled"
	End If
	If fb_err_value And 512 Then
		Print "'unwindinfo' flag enabled"
	End If
End If
