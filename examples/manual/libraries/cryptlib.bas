'' examples/manual/libraries/cryptlib.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'cryptlib'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibcryptlib
'' --------

#include Once "cryptlib.bi"

Function calc_hash( ByVal filename As String, ByVal algo As CRYPT_ALGO_TYPE ) As String
	Const BUFFER_SIZE = 8192
	Dim As Byte buffer( 0 To BUFFER_SIZE-1 )

	'' create a new context using the wanted algorithm
	Dim As CRYPT_CONTEXT ctx
	cryptCreateContext( @ctx, CRYPT_UNUSED, algo )

	'' open input file in binary mode
	Dim As Integer f = FreeFile()
	If( Open( filename For Binary Access Read As #f ) <> 0 ) Then
		Return ""
	End If

	'' read until end-of-file
	Do Until( EOF( f ) )
		Dim As Integer oldpos = Seek( f )
		Get #f, , buffer()
		Dim As Integer readlength = Seek( f ) - oldpos
		'' encrypt
		cryptEncrypt( ctx, @buffer(0), readlength )
	Loop

	'' close input file
	Close #f

	'' finalize
	cryptEncrypt( ctx, 0, 0 )

	'' get the hash result
	Dim As Long buffersize = BUFFER_SIZE
	cryptGetAttributeString( ctx, CRYPT_CTXINFO_HASHVALUE, @buffer(0), @buffersize )

	'' convert to hexadecimal
	Dim As String result = ""
	For i As Integer = 0 To buffersize-1
		result += Hex( buffer(i) )
	Next
	
	'' free the context
	cryptDestroyContext( ctx )

	Return result
End Function

	Dim As String filename = Trim( Command(1) )
	If( Len( filename ) = 0 ) Then
		Print "Usage: hash.exe filename"
		End -1
	End If

	'' init cryptlib
	cryptInit( )

	'' calculate hashes
	Print "md5:  "; calc_hash( filename, CRYPT_ALGO_MD5 )
	Print "sha1: "; calc_hash( filename, CRYPT_ALGO_SHA1 )

	'' shutdown cryptlib
	cryptEnd( )

	Sleep
