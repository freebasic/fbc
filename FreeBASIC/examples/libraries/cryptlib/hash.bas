

#include once "cryptlib.bi"

declare function calc_hash( byval filename as string, byval algo as CRYPT_ALGO_TYPE ) as string

#define calc_md5(filename) calc_hash( filename, CRYPT_ALGO_MD5 )
#define calc_sha(filename) calc_hash( filename, CRYPT_ALGO_SHA )

'' main
	dim as string filename
	
	filename = trim( command(1) )
	
	if( len( filename ) = 0 ) then
		print "Usage: hash.exe filename"
		end -1
	end if
	
	'' init cryptlib
	cryptInit( )

	'' calculate hashes
	print "md5: "; calc_md5( filename )
	print "sha: "; calc_sha( filename )

	'' shutdown cryptlib
	cryptEnd( )
	
	sleep

	
'':::::	
function calc_hash( byval filename as string, byval algo as CRYPT_ALGO_TYPE ) as string
	dim as CRYPT_CONTEXT ctx
	dim as integer f, oldpos, lgt, i
	dim as string result
	dim as byte buffer( 0 to 8192-1 )
	
	'' create a new context using MD5 as the algorithm
	cryptCreateContext( @ctx, CRYPT_UNUSED, algo )
	
	'' open input file in binary mode
	f = freefile
	if( open( filename for binary access read as #f ) <> 0 ) then
		return ""
	end if
	
	'' read until end-of-file
	do until( eof( f ) )
		oldpos = seek( f )
		get #f, , buffer()
		lgt = seek( f ) - oldpos
		'' encrypt
		cryptEncrypt( ctx, @buffer(0), lgt )
	loop
	
	'' close input file
	close #f

	'' finalize
	cryptEncrypt( ctx, 0, 0 )

	'' get the hash result
	lgt = 8192
	cryptGetAttributeString( ctx, CRYPT_CTXINFO_HASHVALUE, @buffer(0), @lgt )
	
	'' convert to hexadecimal
	i = 0
	result = ""
	for i = 0 to lgt-1
		result += hex( buffer(i) )
	next
	
	'' free the context
	cryptDestroyContext( ctx )
	
	function = result
	
end function
