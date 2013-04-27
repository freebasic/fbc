#include once "bzlib.bi"

'' Reads in a file's content into a buffer
private sub hLoadFile _
	( _
		byref filename as string, _
		byref buffer as byte ptr, _
		byref size as integer _
	)

	dim f as integer

	print "loading file '" + filename + "'... ";

	f = freefile( )
	if( open( filename, for binary, access read, as #f ) <> 0 ) then
		print "error: could not open"
		end 1
	end if

	size = lof( f )
	buffer = callocate( size )

	get #f, , *buffer, size

	close #f

	print size & " bytes"

end sub

'' Creates a new file and writes the content of the buffer into it
private sub hWriteFile _
	( _
		byref filename as string, _
		byval p as byte ptr, _
		byval size as integer _
	)

	dim f as integer

	print "writing file '" + filename + "'... ";

	f = freefile( )
	if( open( filename, for binary, access write, as #f ) <> 0 ) then
		print "error: could not create/overwrite file"
		end 1
	end if

	put #f, , *p, size

	close #f

	print size & " bytes"

end sub

private sub hCompressWithBz2 _
	( _
		byval buffer_in as byte ptr, _
		byval size_in as integer, _
		byref buffer_out as byte ptr, _
		byref size_out as integer _
	)

	dim bz as bz_stream
	dim action as integer

	print "compressing " & size_in & " bytes... ";

	BZ2_bzCompressInit( @bz, 9, 0, 0 )

	'print "---"
	bz.next_in = buffer_in
	bz.avail_in = size_in
	do
		if( bz.avail_in > 0 ) then
			action = BZ_RUN
		else
			action = BZ_FINISH
		end if

		bz.next_out = buffer_out + bz.total_out_lo32
		bz.avail_out = size_out - bz.total_out_lo32
		if( bz.avail_out = 0 ) then
			size_out += 512
			'print "reallocating output buffer to " & size_out
			buffer_out = reallocate( buffer_out, size_out )
			bz.next_out = buffer_out + bz.total_out_lo32
			bz.avail_out = size_out - bz.total_out_lo32
		end if

		'print bz.avail_in & " avail_in, " & bz.avail_out & " avail_out, " & bz.total_out_lo32 & " total_out"

		if( BZ2_bzCompress( @bz, action ) = BZ_STREAM_END ) then
			exit do
		end if
	loop
	'print "---"

	BZ2_bzCompressEnd( @bz )

	size_out = bz.total_out_lo32
	print size_out & " bytes"

end sub

	dim as string filename

	'' File to compress
	'filename = __FILE__
	filename = "zlib.bas"

	dim as byte ptr buffer_in, buffer_out
	dim as integer size_in, size_out

	hLoadFile( filename, buffer_in, size_in )
	hCompressWithBz2( buffer_in, size_in, buffer_out, size_out )
	hWriteFile( filename + ".bz2", buffer_out, size_out )

	deallocate( buffer_in )
	deallocate( buffer_out )
