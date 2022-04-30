'' examples/manual/procs/cva_arg1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVA_ARG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvaArg
'' --------

'' Example of a simple custom printf
Sub myprintf cdecl(ByRef formatstring As String, ...)
	Dim As Cva_List args

	'' Initialize the cva_list object to first var-arg
	Cva_Start( args, formatstring )

	'' For each char in format string...
	Dim As UByte Ptr p = StrPtr(formatstring)
	Dim As Integer todo = Len(formatstring)
	While (todo > 0)
		Dim As Integer char = *p
		p += 1
		todo -= 1

		'' Is it a format char?
		If (char = Asc("%")) Then
			If (todo = 0) Then
				'' % at the end
				Print "%";
				Exit While
			End If

			'' The next char should tell the type
			char = *p
			p += 1
			todo -= 1

			'' Print var-arg, depending on the type
			Select Case char
			'' integer?
			Case Asc("i")
				Print Str(Cva_Arg(args, Integer));

			'' long integer? (64-bit)
			Case Asc("l")
				Print Str(Cva_Arg(args, LongInt));

			'' single or double?
			'' Note: because the C ABI, all singles passed on
			'' var-args are converted to doubles.
			Case Asc( "f" ), Asc( "d" )
				Print Str(Cva_Arg(args, Double));

			'' string?
			Case Asc("s")
				'' Strings are passed byval, so the length is unknown
				Print *Cva_Arg(args, ZString Ptr);

			End Select

		'' Ordinary char, just print as-is
		Else
			Print Chr( char );
		End If
	Wend

	Cva_End( args )

End Sub

Dim As String s = "bar"

myprintf(!"integer=%i, longint=%l single=%f, double=%d, string=%s, string=%s\n", _
		 1, 1ll Shl 32, 2.2, 3.3, "foo", s)
