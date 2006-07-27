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

option explicit
option private

#include once "vbcompat.bi"
#include once "file.bi"

#define NULL 0

const ZIPTOOL = "zip.exe"
const ZIPOPTIONS = "-@ -q -9 {output}"

using fb.file
	
type ctx
	root	as zstring * 256
	mask	as zstring * 16
	output	as zstring * 128
	serial	as double
	s		as search.CSearch ptr
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
	
'' globals	
	dim shared as ctx ctx

	end main( __FB_ARGC__, __FB_ARGV__ )

'':::::	
function processOptions _
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
	ctx.serial = 0

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
								 
		
		case else
			return vbFalse
		end select
			
	next
	
	if( datser = 0 ) then
		return vbFalse 
	end if
	
	ctx.serial = datser + timser
	
	function = vbTrue

end function
	
'':::::	
function collectFiles _
	( _
		_
	) as integer
	
	function = search.byDate( ctx.s, _
							  ctx.mask, _
							  ctx.serial, _
							  search.searchBy_SerialNewer )

end function	

'':::::	
sub dumpFiles _
	( _
		_
	) 
	
	dim as search.entry ptr e
	
	e = search.getFirst( ctx.s )
	do while( e <> NULL )
		print *e->path; "/"; *e->name; 
		print " ("; str( year(e->serial) ); "-"; str( month(e->serial) ); "-"; str( day(e->serial) ); ")"
		e = search.getNext( ctx.s )
	loop
	
end sub

'':::::
sub showUsage 
	print "Usage: tram -root=base_path [-mask=*.*] -date=yyyy/mm/dd [-time=hh:mm:ss] [-file=output_name]"
end sub

'':::::
sub archiveFiles

	dim as search.entry ptr e
	dim as integer o
	dim as string options, cdir
	
	cdir = curdir
	chdir ctx.root

	options = hReplace( ZIPOPTIONS, "{output}", cdir + "/" + ctx.output )
	
	print "archiving:", ZIPTOOL + " " + options
	
	o = freefile
	if( open pipe( ZIPTOOL + " " + options, for output, as #o ) <> 0 ) then
		return
	end if
	
	e = search.getFirst( ctx.s )
	do while( e <> NULL )
		
		if( e->path <> NULL ) then
			print #o, *e->path; "/";
		end if
		print #o, *e->name
		
		e = search.getNext( ctx.s )
	loop
	
	close #o
	
	chdir cdir
	
end sub

'':::::
function main _
	( _
		byval argc as integer, _
		byval argv as zstring ptr ptr _
	) as integer
	
	if( processOptions( argc, argv ) = vbFalse ) then
		showUsage( )
		return 1
	end if

	ctx.s = search.new( ctx.root )
	
	if( collectFiles( ) = vbFalse ) then
		return 1
	end if
	
	'dumpFiles( )
	
	archiveFiles( )
	
	search.delete( ctx.s )
	
	return 0
	
end function

'':::::
function hReplace _
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
