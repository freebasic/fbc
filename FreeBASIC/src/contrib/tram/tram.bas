''
''  TRAM - Testing Release Archive Maker
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.
''

#include once "vbcompat.bi"
#include once "file.bi"
#include once "list.bi"
#include once "zstr.bi"

#define NULL 0

const TRAM_FILELIST = "tram_filelist.txt"

#ifndef __FB_LINUX__
#define TRAM_USE_STDOUT
const TRAM_ARCH_TOOL = "zip.exe"
const TRAM_ARCH_OPTIONS = "-@ -q -9 {output}"
const TRAM_NEWLINE = chr( 13, 10 )
#else
const TRAM_ARCH_TOOL = "tar"
const TRAM_ARCH_OPTIONS = "-czf {output} -T {listing}"
const TRAM_NEWLINE = chr( 10 )
#endif

using fb
using file
	
type excListNode
	name	as zstring ptr
end type	
	
type ctx
	root	as zstring * 256
	mask	as zstring * 16
	output	as zstring * 128
	serial	as double
	exclist	as CList ptr
	search	as CSearch ptr
end type

declare function main _
	( _
		byval argc as integer, _
		byval argv as zstring ptr ptr _
	) as integer

declare function hReplace _
	( _
		byval orgtext as zstring ptr, _
		byval oldtext as zstring ptr, _
		byval newtext as zstring ptr _
	) as string

declare function hRevertSlash _
	( _
		byval src as zstring ptr _
	) as string
	

'' globals	
	dim shared as ctx ctx

	end main( __FB_ARGC__, __FB_ARGV__ )


'':::::	
private function processOptions _
	( _
		byval argc as integer, _
		byval argv as zstring ptr ptr _
	) as integer
	
	dim as integer i, datser = 0, timser = 0
	dim as string arg
	
	'' defaults
	ctx.root = "."
	ctx.mask = "*.*"
	ctx.output = "zip.zip"
	ctx.exclist = NULL
	ctx.serial = 0
	ctx.exclist = new CList( 48, len( excListNode ) )
	
	for i = 1 to argc-1
		arg = *argv[i]
		select case left( arg, 6 )
		case "-root="
			ctx.root = mid( arg, 7 )

		case "-mask="
			ctx.mask = mid( arg, 7 )

		case "-file="
			ctx.output = mid( arg, 7 )
		
		case "-date="
			dim as string d = mid( arg, 7 )
			if( len( d ) = 4+1+2+1+2 ) then
				if( d[4] = asc( "/" ) and d[4+2+1] = asc( "/" ) ) then

					datser = dateserial( cint( left( d, 4 ) ), _
								 	 	 cint( mid( d, 1+4+1, 2 ) ), _
								 	 	 cint( mid( d, 1+4+1+2+1, 2 ) ) )
				end if
			end if

		case "-time="
			dim as string d = mid( arg, 7 )

			if( len( d ) = 2+1+2+1+2 ) then
				if( d[2] = asc( ":" ) and _
					d[2+2+1] = asc( ":" ) ) then
				
					timser = timeserial( cint( left( d, 2 ) ), _
								 	 	 cint( mid( d, 1+2+1, 2 ) ), _
								 	 	 cint( mid( d, 1+2+1+2+1, 2 ) ) )
				end if
			end if
								 

		case "-excl="
			dim as string d = ucase( mid( arg, 7 ) )
			
			dim as excListNode ptr n = ctx.exclist->insert( )
			
			n->name = zStr.dup( d )
		
		case else
			return vbFalse
		end select
			
	next
	
	dim as excListNode ptr n = any
#if defined( TARGET_WIN32 )	
	dim as string exclude_list(0)
#elseif defined( TARGET_LINUX )	
	dim as string exclude_list(9) => _
	{ "caca", "cairo", "disphelper", "Windows", "win", _
	  "bass.bi", "bassmod.bi", "jni.bi", "windows.bi" }
#elseif defined( TARGET_DOS )
	dim as string exclude_list(50) => _
	{ "caca", "cairo", "cryptlib", "CUnit", "Curl", _ 
	  "disphelper", "dll", "freetype", "GL", "GMP", _ 
	  "GSL", "Gtk", "IUP", "libxml", "mini", _ 
	  "networking", "sound", "SDL", "spidermonkey", "unicode", _ 
	  "Windows", "wx-c", "al", "fastcgi", "freetype2", _
	  "gdsl", "IL", "libxslt", "postgresql", "win", _
	  "bass.bi", "bassmod.bi", "caca.bi", "cryptlib.bi", "curl.bi", _
	  "expat.bi", "fmod.bi", "FreeImage.bi", "giflib.bi", "gmp.bi", _
	  "japi.bi", "jni.bi", "jpeglib.bi", "jpgalleg.bi", "mini.bi", _
	  "mxml.bi", "Newton.bi", "pdflib.bi", "png.bi", "windows.bi", _
	  "gif_read.bas", "jpeg_read.bas", "png_read.bas" }
#endif
	for i as integer = 0 to ubound(exclude_list)-1
		n = ctx.exclist->insert( )
		exclude_list(i) = ucase(exclude_list(i))
		n->name = zStr.dup( exclude_list(i) )
	next
	
	if( datser = 0 ) then
		return vbFalse 
	end if
	
	ctx.serial = datser + timser
	
	function = vbTrue

end function
	
'':::::	
private function collectFiles _
	( _
		_
	) as integer
	
	function = ctx.search->byDate( ctx.mask, _
							       ctx.serial, _
							       CSearch.searchBy_SerialNewer )

end function	

'':::::	
private sub dumpFiles _
	( _
		_
	) 
	
	dim as CSearchEntry ptr e
	
	e = ctx.search->getFirst( )
	do while( e <> NULL )
		print *e->path; "/"; *e->name; 
		print " ("; str( year(e->serial) ); "-"; str( month(e->serial) ); "-"; str( day(e->serial) ); ")"
		e = ctx.search->getNext( )
	loop
	
end sub

'':::::
private sub showUsage 
	print "Usage: tram -root=base_path [-mask=*.*]"
	print "            -date=yyyy/mm/dd [-time=hh:mm:ss]"
	print "            [-file=output_name] [-excl=dir_name]*"
end sub

'':::::
private sub archiveFiles

	dim as CSearchEntry ptr e
	dim as integer o
	dim as string options, cdir, listfile
	
	cdir = hRevertSlash( curdir )
	chdir ctx.root

	options = hReplace( TRAM_ARCH_OPTIONS, "{output}", cdir + "/" + ctx.output )
	
	o = freefile

#ifdef TRAM_USE_STDOUT
	if( open pipe( TRAM_ARCH_TOOL + " " + options, for output, as #o ) <> 0 ) then
		print "error: archiver not found"
		return
	end if

#else
	listfile = cdir + "/" + TRAM_FILELIST
	
	options = hReplace( options, "{listing}", listfile )
	
	if( open ( listfile, for binary, access write, as #o ) <> 0 ) then
		print "error: cannot create the file list"
		return
	end if
#endif
	
	print "archiving:", TRAM_ARCH_TOOL + " " + options
	
	e = ctx.search->getFirst( )
	do while( e <> NULL )
		if( e->path <> NULL ) then
			print #o, *e->path + "/";
		end if
		print #o, *e->name + TRAM_NEWLINE;
		
		e = ctx.search->getNext( )
	loop
	
	close #o

#ifndef TRAM_USE_STDOUT
	o = freefile
	if( open pipe( TRAM_ARCH_TOOL + " " + options, for output, as #o ) <> 0 ) then
		if( exec( TRAM_ARCH_TOOL, options ) <> 0 ) then
			print "error: archiver not found"
			return
		end if
	else
		close #o
	end if
	
	kill listfile
#endif
	
	chdir cdir
	
end sub

'':::::
private function topDir_cb _
	( _
		byval path as zstring ptr, _
		byval fname as zstring ptr _
	) as integer
	
	'' don't include the CVS meta-data
	if( ucase( *fname ) = "CVS" ) then
		return FALSE
	end if

	'' not at root? don't check..
	if( path <> NULL ) then
		return TRUE
	end if
	
	'' exclude /tests and /src
	select case *fname	
	case "tests", "src"
		return FALSE
	end select
	
	function = TRUE
	
end function

'':::::
private function excList_cb _
	( _
		byval path as zstring ptr, _
		byval fname as zstring ptr _
	) as integer
	
	'' check top dir first
	if( topDir_cb( path, fname ) = FALSE ) then
		return FALSE
	end if
	
	dim as string uc_fname = ucase( *fname )
	
	dim as excListNode ptr n = ctx.exclist->getHead( )
	
	do until( n = NULL )
		
		if( *n->name = uc_fname ) then
			return FALSE
		end if
		
		n = ctx.exclist->getNext( n )
	loop
	
	function = TRUE
	
end function

'':::::
private function main _
	( _
		byval argc as integer, _
		byval argv as zstring ptr ptr _
	) as integer
	
	if( processOptions( argc, argv ) = vbFalse ) then
		showUsage( )
		return 1
	end if

	dim as CSearchDirCallback cb = iif( ctx.exclist <> NULL, @excList_cb, @topDir_cb )
	
	ctx.search = new CSearch( ctx.root, cb )
	
	if( collectFiles( ) = vbFalse ) then
		return 1
	end if
	
	'dumpFiles( )
	
	archiveFiles( )
	
	delete ctx.search
	
	return 0
	
end function

'':::::
private function hReplace _
	( _
		byval orgtext as zstring ptr, _
		byval oldtext as zstring ptr, _
		byval newtext as zstring ptr _
	) as string static

    dim as integer oldlen, newlen, p
    static as string text, remtext

	oldlen = len( *oldtext )
	newlen = len( *newtext )

	text = *orgtext
	p = 0
	do
		p = instr( p+1, text, *oldtext )
	    if( p = 0 ) then
	    	exit do
	    end if

		remtext = mid( text, p + oldlen )
		text = left( text, p-1 )
		text += *newtext
		text += remtext
		p += newlen
	loop

	function = text

end function

'':::::
private function hRevertSlash _
	( _
		byval src as zstring ptr _
	) as string static

    dim as string res
    dim as integer i

	res = *src

	for i = 0 to len( *src )-1
		if( src[i] = asc( "\" ) ) then
			res[i] = asc( "/" )
		end if		
	next

	function = res

end function
