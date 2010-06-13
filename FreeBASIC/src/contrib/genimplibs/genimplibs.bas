
const FALSE = 0
const TRUE  = not FALSE

type OPTIONS
    show_help as integer
    overwrite as integer
    build_all as integer
    platform  as string
end type

type OPTLIB
    desc    as zstring * 64
    dir     as zstring * 16
    killat  as integer
end type

const OPTLIBS = 9

declare function hFileExists( byval filename as string ) as integer
declare function hStripPath( byval filename as string ) as string

declare sub genlibs( byval dpath as string, byval killat as integer )

declare sub chkoptlibs( optTb() as OPTLIB, byval libs as integer )

    '':::::
    dim as OPTLIB optTb(0 to OPTLIBS-1) = _
    { _
        ( "ASpell-0.50  (Spell Checker Library, 1.51MB)", "aspell", FALSE ), _
        ( "Allegro (Game library, 0.96MB)", "alleg", FALSE ), _
        ( "Expat (XML library, 0.29MB)", "expat", FALSE ), _
        ( "GMP (Multi-precision arithmetic library, 0.29MB)", "gmp", FALSE ), _
        ( "GSL (Math library, 2.86MB)", "gsl", FALSE ), _
        ( "Gtk 2 (GUI library, 5.54MB)", "gtk", FALSE ), _
        ( "libXML (XML/XSLT library, 1.32MB)", "xml", FALSE ), _
        ( "SDL (Game library, 0.36MB)", "sdl", FALSE ), _
        ( "Wx-c (GUI library, 3.16MB)", "wx-c", FALSE ) _
    }

    dim shared opt as OPTIONS
    opt.platform = "win32"

    dim as string arg_value
    dim as integer arg_index
    arg_index = 1
    do while ( len(command(arg_index)) <> 0 )
        arg_value = command(arg_index)
        arg_index += 1
        select case arg_value
        case "-h", "--help"
            opt.show_help = TRUE
            exit do

        case "-a", "--all"
            opt.build_all = TRUE

        case "-p", "--platform"
            arg_value = command$(arg_index)
            arg_index += 1
            select case arg_value
            case "win32", "cygwin"
                opt.platform = arg_value

            case else
                print "Unknown platform"
                end 1

            end select

        case "-f", "--force"
            opt.overwrite = TRUE

        case else
	    	print "Unknown option"
            end 1

        end select
    loop

    print "Import library generator"

    if( opt.show_help ) then
        print "genimplibs [-p win32|cygwin] [-f] [-a]"
        end
    end if

	print "Generating the import libraries, please wait..."
	print

    genlibs( "\winapi\", TRUE )

	genlibs( "\", FALSE )

	chkoptlibs( optTb(), OPTLIBS )

'':::::
sub chkoptlibs( optTb() as OPTLIB, byval libs as integer )	
	dim as integer i, dogen, isall
	dim as string res
	
	isall = opt.build_all

    if( not isall ) then
		print
		print "Optional import libraries, type y or n and press Enter"
	end if
	print

	for i = 0 to libs-1
				
		print "Install "; optTb(i).desc;
		if( not isall ) then			
			print " [Yes/No/All]?";
			input res
		
			dogen = FALSE
			if( len( res ) = 0 ) then
				dogen = TRUE
			else
				select case ucase( left( res, 1 ) )
				case "Y"
					dogen = TRUE
				case "A"
					isall = TRUE
					dogen = TRUE
				end select
			end if
			
		else
			print
			dogen = TRUE
		end if
			
		if( dogen ) then
			genlibs( "\optional\" + optTb(i).dir + "\", optTb(i).killat )			
		end if
		
		print

	next

end sub
	
'':::::	
sub genlibs( byval path as string, byval killat as integer )
	dim as string filename, deffile, libfile, options
	dim as string bpath, lpath, dpath, dlltool
	
	bpath = exepath + "\..\..\..\bin\" + opt.platform + "\"
	lpath = exepath + "\..\..\..\lib\" + opt.platform + "\"
	dpath = exepath + path

	dlltool = bpath + "dlltool.exe"

	if( killat ) then
		options = "-k "
	else
		options = ""
	end if
	
	options += "-d "
	
	filename = dir( dpath + "*.def" )	
	do while( len( filename ) > 0 ) 
		
		deffile = hStripPath( filename )
		
		libfile = "lib" + left( deffile, len( deffile ) - 4 ) + ".a"
		
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
			
		filename = dir( )
	loop
	
end sub
	
'':::::
function hFileExists( byval filename as string ) as integer static
    dim f as integer

    if( opt.overwrite ) then
        return FALSE
    end if

    f = freefile

	if( open( filename, for input, as #f ) = 0 ) then
		function = TRUE
		close #f
	else
		function = FALSE
	end if

end function
	
'':::::
function hStripPath( byval filename as string ) as string static
    dim as integer p1, p2, p, lp

	lp = 0
	do
		p1 = instr( lp+1, filename, "\" )
		p2 = instr( lp+1, filename, "/" )
        p = iif( p2=0 or (p1 > 0 and p1 < p2), p1, p2 )
	    if( p = 0 ) then exit do
	    lp = p
	loop

	if( lp > 0 ) then
		function = mid( filename, lp+1 )
	else
		function = filename
	end if

end function
