'' examples/manual/proguide/embed-access-data-in-executable.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Embed and Access binary Data in Executable'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDataExecutable
'' --------

Extern "C"
	#if defined(__FB_WIN32__) And Not defined(__FB_64BIT__)
		Extern hello_txt_start Alias "binary_hello_txt_start" As Const Byte
		Extern hello_txt_end Alias "binary_hello_txt_end" As Const Byte
	#else
		Extern hello_txt_start Alias "_binary_hello_txt_start" As Const Byte
		Extern hello_txt_end Alias "_binary_hello_txt_end" As Const Byte
	#endif
End Extern

Dim hello_ptr As Const Byte Const Ptr = @hello_txt_start
Dim hello_length As Const UInteger = @hello_txt_end - @hello_txt_start

For i As UInteger = 0 To hello_length - 1
	Print Chr(hello_ptr[i]);
Next
Print

Sleep
			
