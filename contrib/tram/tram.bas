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

#include once "../../compiler/inc/fb.bi"

#define NULL 0

const TRAM_FILELIST = "tram_filelist.txt"

#ifndef TARGET_LINUX
#define TRAM_USE_STDOUT
const TRAM_ARCH_TOOL = "zip.exe"
const TRAM_ARCH_OPTIONS = "-@ -q -9 {output}"
const TRAM_NEWLINE = chr( 13, 10 )
#else
const TRAM_ARCH_TOOL = "tar"
const TRAM_ARCH_OPTIONS = "-hczf {output} -T {listing}"
const TRAM_NEWLINE = chr( 10 )
#endif

using fb
using file
	
type ctx
	root	as zstring * 256
	output	as zstring * 128
	serial	as double
	search	as CSearch ptr
	distro  as FB_DISTRO
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
	ctx.root = "../../.."
	ctx.output = ""
	ctx.serial = 0
	
	for i = 1 to argc-1
		arg = *argv[i]
		select case left( arg, 6 )
		case "-dist="
			select case ucase(mid( arg, 7 ))
				case "WIN32"
					ctx.distro = FB_WIN32
				case "LINUX"
					ctx.distro = FB_LINUX
				case "DOS"
					ctx.distro = FB_DOS
				case else
					return vbFalse
			end select
			
		case "-root="
			ctx.root = mid( arg, 7 )

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
			else
				datser = 0
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
								 

		case else
			return vbFalse
		end select
			
	next
	
	if( timser <> 0 ) then
		if( datser = 0 ) then
			return vbFalse
		end if
	end if
	
	ctx.serial = datser + timser
	
	if( ctx.output = "" ) then
		ctx.output &= "FB-v"
		ctx.output &= FB_VER_MAJOR
		ctx.output &= "."
		ctx.output &= FB_VER_MINOR
		ctx.output &= "-"
		ctx.output &= monthname( month( now ), -1 )
		ctx.output &= "-"
		ctx.output &= day( now )
		ctx.output &= "-"
		ctx.output &= year( now )
		ctx.output &= "-"
		if( ctx.serial <> 0 ) then
			ctx.output &= "testing-"
		end if
		select case as const ctx.distro
			case FB_WIN32
				ctx.output &= "win32"
			case FB_LINUX
				ctx.output &= "linux"
			case FB_DOS
				ctx.output &= "dos"
		end select
	end if

	function = vbTrue

end function
	
'':::::	
private function collectFiles _
	( _
		_
	) as integer
	
	function = ctx.search->byDate( "*.*", _
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
	? "Usage: tram [-root=base_path  ]"
	? "            [-date=yyyy/mm/dd ] [-time=hh:mm:ss]"
	? "            [-file=output_name] [-dist=win32|linux|dos]"
end sub

'':::::
private sub archiveFiles

	dim as CSearchEntry ptr e
	dim as integer o
	dim as string options, cdir, listfile, file_ext
	
	cdir = hRevertSlash( curdir )
	
	'' hack
	cdir = mid( cdir, instr(cdir, "FreeBASIC") )
	
	chdir ctx.root & "/.."
	
#ifdef TRAM_USE_STDOUT
	file_ext = "zip"
#else
	file_ext = "tar.gz"
#endif

	options = hReplace( TRAM_ARCH_OPTIONS, "{output}", cdir + "/" + ctx.output + "." + file_ext )
	
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
		print #o, "FreeBASIC/";
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
private function main _
	( _
		byval argc as integer, _
		byval argv as zstring ptr ptr _
	) as integer
	
	if( processOptions( argc, argv ) = vbFalse ) then
		showUsage( )
		return 1
	end if

	ctx.search = new CSearch( ctx.root, ctx.distro )
	
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
