/'

fbhelp.dat uncompressed file format

General format of the file is the following sections, one after the other:
	1) Header (offsets to other sections)
	2) Index  (offsets to names and pages)
	3) Names  (a list of names)
	4) Pages  (a list of pages)

All offsets written to file are expected to be 32-bit integers.


1) HEADER - always at starts of file offset 0

	offset  length   description

	 0       20      magic header = "FreeBASIC Manual" + chr(13) + chr(10) + chr(26) + chr(0)
	20        4      offset to start of index relative to start of file
	24        4      offset to start of names list relative to start of file
	28        4      offset to start of pages relative to start of file
	32        4      reserved = 0

2) INDEX - typically starting at file offset 36, but need not be

	offset  length   description

	0         4      index id field = "INDX"
	4         4      number of entries in the index
	8       varies   index entries, see following

	INDEX ENTRY

	0         4      offset to start of name relative to first name in the list
	4         4      offset to start of page data relative to start of first page entry

3) NAMES LIST

	offset  length   description

	0         4      name list id field = "NAME"
	4         4      length in bytes of the names list, not including the id field and this field
	8       varies   name entries - index offsets are relative to this position
	varies  varies   padding at the end of the data to make length of the names list a multiple of 4

	NAME ENTRY

	0       varies   null terminated string

4) PAGE ENTRIES

	offset  length   description

	0         4      page id field = "PAGE" - index offsets are relative to this position of the first entry
	4         4      length in bytes of the page data, not including the id field and this field
	8       varies   page data 
	varies  varies   padding at the end of the data to make length a multiple of 4

	Next page entry immediately follows the last in the file.

'/


type INTEGER32 as long

type head_t field=1
    index_start as INTEGER32
    names_start as INTEGER32
    pages_start as INTEGER32
    reserved as INTEGER32
end type

type item_t field=1
    filename as string
    filesize as INTEGER32
    fileposn as INTEGER32
    nameposn as INTEGER32
end type

const MANUAL_DIR = "../manual/"
const FBHELP_DIR = MANUAL_DIR + "fbhelp/"
const FBHELP_FILE = FBHELP_DIR + "fbhelp.dat"

dim shared head as head_t
dim shared files(1 to 2000) as item_t
dim shared nfiles as INTEGER32

private sub getFiles( )
    dim as string d = dir( FBHELP_DIR + "*.txt" )
    while( d > "" )
        nfiles += 1
        with files(nfiles)
            .filename = left( d, instr(d, ".") - 1)
            .filesize = 0
            .fileposn = 0
            .nameposn = 0
        end with
        d = dir( )
    wend
end sub

private sub killOutfile( )
    dim as integer h = freefile( )
    if( open( FBHELP_FILE for input as #h ) = 0 ) then
        close #h
        kill FBHELP_FILE
    end if
end sub

private function writeHeader( byval h as integer ) as integer
    dim as string b = "FreeBASIC Manual" + chr(13) + chr(10) + chr(26) + chr(0)
    put #h, , b
    put #h, , head
    return( len(b) + sizeof(head_t) )
end function

private function writeIndex( byval h as integer ) as integer
    dim as string b = "INDX"

    put #h, , b
    put #h, , nfiles

    for i as integer = 1 to nfiles
        put #h, , files(i).nameposn
        put #h, , files(i).fileposn
    next

    return ( nfiles * sizeof( INTEGER32 ) * 2 + sizeof( INTEGER32 ) * 2 )
end function

private function emitPadded _
    ( _
        byref b as string, _
        byref dat as string, _
        byval n as INTEGER32, _
        byval h as integer _
    ) as integer

    put #h, , b
    put #h, , n

    '' Pad with 0's
    while( ( n mod 4 ) <> 0 )
        dat += chr(0)
        n += 1
    wend

    put #h, , dat

    return ( n + sizeof( INTEGER32 ) * 2 )
end function

private function writeNames( byval h as integer ) as integer
    dim as integer n = 0
    dim as string dat = "", filename

    for i as integer = 1 to nfiles
        files(i).nameposn = n
        filename = files(i).filename + chr(0)
        dat += filename
        n += len(filename)
    next

    return emitPadded( "NAME", dat, n, h )
end function

private function writePage( byval h as integer, byref filename as string ) as integer
    dim as integer f = freefile 

    if( open( filename for binary access read as #f ) <> 0 )then
        return -1
    end if

    dim as string dat = ""
    dim as integer n = lof(f)
    if( n > 0 ) then
        dat = space( n )
        get #f, , dat
    end if

    close #f

    return emitPadded( "PAGE", dat, n, h )
end function

private function writePages( byval h as integer ) as integer
    dim as integer n = 0	

    for i as integer = 1 to nFiles
        files(i).fileposn = n
        dim as integer ret = writePage( h, FBHELP_DIR + files(i).filename + ".txt" )
        if( ret < 0 ) then
            files(i).fileposn = ret
        else
            n += ret
        end if
    next

    return n
end function

private sub writeOutfile()
    with head
        .index_start = 0
        .names_start = 0
        .pages_start = 0
        .reserved = 0
    end with

    dim as integer h = freefile()

    if( open( FBHELP_FILE for binary as #h ) <> 0 ) then
        print "Couldn't open " + FBHELP_FILE
        return
    end if

    writeHeader( h )

    head.index_start = seek( h ) - 1
    writeIndex( h )

    head.names_start = seek( h ) - 1
    writeNames( h )

    head.pages_start = seek( h ) - 1
    writePages( h )

    seek #h, 1

    writeHeader( h )
    writeIndex( h )

    close #h
end sub

    getFiles()
    print "Found " + str( nfiles ) + " files."
    killOutfile()
    writeOutfile()
