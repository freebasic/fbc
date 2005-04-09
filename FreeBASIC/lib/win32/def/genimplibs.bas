''
'' compile with -ex
''

option explicit

declare function hFileExists	( byval filename as string ) as integer
declare function hStripPath		( byval filename as string ) as string

declare sub genlibs( byval dpath as string, byval killat as integer )

	print "Generating the import libraries, please wait..."
	print
	
	genlibs( "\winapi\", -1 )
	
	genlibs( "\", 0 )
	
	
'':::::	
sub genlibs( byval dpath as string, byval killat as integer )
	dim as string filename, deffile, libfile, options
	dim as string bpath, lpath, dlltool
	
	bpath = exepath$ + "\..\..\..\bin\win32\"
	lpath = exepath$ + "\..\"

	dlltool = bpath + "dlltool.exe"

	if( killat ) then
		options = "-k "
	else
		options = ""
	end if
	
	options += "-d "
	
	filename = dir$( exepath$ + dpath + "*.def" )	
	do while( len( filename ) > 0 ) 
		
		deffile = hStripPath( filename )
		
		libfile = "lib" + left$( deffile, len( deffile ) - 4 ) + ".a"
		
		if( not hFileExists( lpath + libfile ) ) then
			print "creating " + libfile + "...";
		
			if( exec( dlltool, options + """" + dpath + deffile + """ -l """ + lpath + libfile + """" ) = 0 ) then
				print "ok"
			else
				print "error"
			end if
		
		else
			print "skipping " + libfile
		
		end if
			
		filename = dir$( )
	loop
	
end sub
	
'':::::
function hFileExists( byval filename as string ) as integer static
    dim f as integer

	function = 0

	on local error goto exitfunction

	f = freefile
	open filename for input as #f
	close #f

	function = -1

exitfunction:
    exit function
end function
	
'':::::
function hStripPath( byval filename as string ) as string static
    dim p as integer, lp as integer

	lp = 0
	do
		p = instr( lp+1, filename, "\" )
	    if( p = 0 ) then
	    	p = instr( lp+1, filename, "/" )
	    	if( p = 0 ) then
	    		exit do
	    	end if
	    end if
	    lp = p
	loop

	if( lp > 0 ) then
		hStripPath = mid$( filename, lp+1 )
	else
		hStripPath = filename
	end if

end function	