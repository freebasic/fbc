'' examples/manual/procs/vararg2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VA_FIRST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVaFirst
'' --------

'' Example of a simple custom printf
Sub myprintf cdecl(ByRef formatstring As String, ...)
	'' Get the pointer to the first var-arg
	Dim As Any Ptr arg = va_first()

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
				Print Str(va_arg(arg, Integer));
				'' Note, different from C: va_next() must be
				'' used as va_arg() won't update the pointer.
				arg = va_next(arg, Integer)

			'' long integer? (64-bit)
			Case Asc("l")
				Print Str(va_arg(arg, LongInt));
				arg = va_next(arg, LongInt)

			'' single or double?
			'' Note: because the C ABI, all singles passed on
			'' var-args are converted to doubles.
			Case Asc( "f" ), Asc( "d" )
				Print Str(va_arg(arg, Double));
				arg = va_next(arg, Double)

			'' string?
			Case Asc("s")
				'' Strings are passed byval, so the length is unknown
				Print *va_arg(arg, ZString Ptr);
				arg = va_next(arg, ZString Ptr)

			End Select

		'' Ordinary char, just print as-is
		Else
			Print Chr( char );
		End If
	Wend
End Sub

	Dim As String s = "bar"

	myprintf(!"integer=%i, longint=%l single=%f, double=%d, string=%s, string=%s\n", _
			 1, 1ll Shl 32, 2.2, 3.3, "foo", s)

	Sleep
