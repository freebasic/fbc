'' examples/manual/libraries/lzo.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LZO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibLzo
'' --------

#include "lzo/lzo1x.bi"

Dim inbuf As ZString Ptr = @"string to compress (or not, since it's so short)"
Dim inlen As Integer = Len(*inbuf) + 1
Dim complen As lzo_uint = 100
Dim compbuf As ZString Ptr = Allocate(complen)
Dim decomplen As lzo_uint = 100
Dim decompbuf As ZString Ptr = Allocate(decomplen)
Dim workmem As Any Ptr

Print "initializing LZO: ";
If lzo_init() = 0 Then
	Print "ok"
Else
	Print "failed!"
	End 1
End If

Print "compressing '" & *inbuf & "': ";

workmem = Allocate(LZO1X_1_15_MEM_COMPRESS)

If lzo1x_1_15_compress(inbuf, inlen, compbuf, @complen, workmem) = 0 Then
	Print "ok (" & inlen & " bytes in, " & complen & " bytes compressed)"
Else
	Print "failed!"
	End 1
End If

Deallocate(workmem)

Print "decompressing: ";

workmem = Allocate(LZO1X_MEM_DECOMPRESS)

If lzo1x_decompress(compbuf, complen, decompbuf, @decomplen, NULL) = 0 Then
	Print "ok: '" & *decompbuf & "' (" & complen & " bytes compressed, " & decomplen & " bytes decompressed)"
Else
	Print "failed!"
	End 1
End If

Deallocate(workmem)
