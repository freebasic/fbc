#define TRUE 1
#define FALSE 0
#define NULL 0

type head_t
	index_start as integer
	names_start as integer
	pages_start as integer
	reserved as integer
end type

type item_t
	filename as string
	filesize as integer
	fileposn as integer
	nameposn as integer
end type

const fbhelp_dir = "fbhelp/"

dim shared head as head_t

dim shared files(1 to 1000) as item_t
dim shared nfiles as integer

private sub GetFiles( )
	dim d as string
	d = dir( fbhelp_dir + "*.txt" )
	while( d > "" )
		nfiles += 1
		with files(nfiles)
			.filename = left( d, instr(d, ".") - 1)
			.filesize = 0
			.fileposn = 0
			.nameposn = 0
		end with
		d = dir()
	wend
end sub

private sub KillOutfile( )
	dim as integer h
	h = freefile
	if( open( fbhelp_dir + "fbhelp.dat" for input as #h ) = 0 ) then
		close #h
		kill fbhelp_dir + "fbhelp.dat"
	end if
end sub

private function WriteHeader( byval h as integer ) as integer

	dim b as string

	b = "FreeBASIC Manual" + chr(13) + chr(10) + chr(26) + chr(0)
	put #h,,b
	put #h,,head

	return( len(b) + sizeof(head_t) )

end function

private function WriteIndex( byval h as integer ) as integer

	dim as string b
	dim as integer i
	
	b = "INDX"
	put #h,,b
	put #h,,nfiles

	for i = 1 to nfiles
		put #h,, files(i).nameposn
		put #h,, files(i).fileposn
	next

	return( nfiles * sizeof( integer ) * 2 + sizeof( integer ) * 2)

end function

private function WriteNames( byval h as integer ) as integer

	dim as string b, t
	dim as integer n, i

	n = 0
	t = ""

	for i = 1 to nfiles
		files(i).nameposn = n
		b = files(i).filename + chr(0)
		t += b
		n += len(b)
	next

	b = "NAME"
	put #h,,b
	put #h,,n

	while(( n mod 4 ) <> 0 )
		t += chr(0)
		n += 1
	wend

	put #h,,t

	return( n + sizeof( integer ) * 2)

end function

private function WritePage( byval h as integer, byval filename as zstring ptr ) as integer

	dim as integer f, n
	dim as string b, t

	f = freefile 

	if( open( *filename for binary access read as #f ) <> 0 )then
		return -1
	end if

	n = lof(f)
	if( n > 0 ) then
		t = space( n )
		get #f,,t
	else
		t = ""
	end if

	close #f

	b = "PAGE"
	put #h,,b
	put #h,,n

	while(( n mod 4 ) <> 0 )
		t += chr(0)
		n += 1
	wend

	put #h,,t

	return( n + sizeof( integer ) * 2)

end function

private function WritePages( byval h as integer ) as integer

	dim as integer n, ret, i

	n = 0	
	for i = 1 to nFiles
		files(i).fileposn = n
		ret = WritePage( h, fbhelp_dir + files(i).filename + ".txt" )
		if( ret < 0 ) then
			files(i).fileposn = ret
		else
			n += ret
		end if
	next

	return( n )

end function

private function WriteOutfile( byref filename as string ) as integer

	dim h as integer
	
	with head
		.index_start = 0
		.names_start = 0
		.pages_start = 0
		.reserved = 0
	end with

	h = freefile

	if( open( filename for binary as #h ) = 0 ) then

		WriteHeader( h )

		head.index_start = seek( h ) - 1
		WriteIndex( h )

		head.names_start = seek( h ) - 1
		WriteNames( h )

		head.pages_start = seek( h ) - 1
		WritePages( h )

		seek #h, 1

		WriteHeader( h )
		WriteIndex( h )

		close #h	

		return TRUE

	end if

	return FALSE

end function

	'' MAIN

	GetFiles

	print "Found " + str( nfiles ) + " files."

	KillOutfile
	WriteOutfile( fbhelp_dir + "fbhelp.dat" )

	end 0
