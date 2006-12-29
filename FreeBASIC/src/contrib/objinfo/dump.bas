#include once "bfd.bi"
#include once "objinfo.bi"

declare function hOpenObject( byref filename as string )  as integer
declare function hOpenArchive( byref filename as string )  as integer
declare function hPrintList( byval buf as byte ptr )  as integer
declare function hDumpObject( byval f as bfd ptr ) as integer
	
'' main	
	
	'' init BFD
	bfd_init( )
	
	'' process cmd-line
	dim as string filename = command( 1 )
	if( len( filename ) = 0 ) then
		print "usage: xxx.o or xxx.a"
		end 1
	end if
	
	'' check extension
	dim as integer res
	
	dim as double init = timer
	select case right( filename, 2 )
	case ".o"
		res = hOpenObject( filename )
	case ".a"
		res = hOpenArchive( filename )
	case else
		res = FALSE
	end select
		
	if( res = FALSE ) then	
		end 1
	else
		print using "##.###"; timer - init
	end if
	
'':::::
function hOpenObject( byref filename as string ) as integer
	
	'' open the object file for read
	dim as bfd ptr objf = bfd_openr( filename, 0 )
	
	if( objf = 0 ) then
		print "error: File not found"
		return FALSE
	end if
	
	'' dump it
	function = hDumpObject( objf )
	
	'' close the object file
	bfd_close( objf )
	
end function

'':::::
function hOpenArchive( byref filename as string ) as integer

	'' open the archive file for read
	dim as bfd ptr archf = bfd_openr( filename, 0 )
	
	if( archf = 0 ) then
		print "error: File not found"
		return FALSE
	end if
	
	'' not a valid archive file?
	if( bfd_check_format( archf, bfd_archive ) = FALSE ) then
		print "error: "; *bfd_errmsg( bfd_get_error( ) )
  		bfd_close( archf )
		return FALSE
	end if
	
	'' for each object in the archive..
	dim as bfd ptr objf, last_objf = 0
	dim as integer res = TRUE
	
	do
		'' get the next (or the first) object file
		objf = bfd_openr_next_archived_file( archf, objf )
		if( objf = 0 ) then
			exit do
		end if
		
		'' only dump our special object file
		if( *bfd_get_filename( objf ) = FB_INFOSEC_OBJNAME ) then
			res = hDumpObject( objf )
			exit do
		end if

		'' close the last (not the current) object file
		if( last_objf ) then
			bfd_close( last_objf )
		end if
      
		last_objf = objf
	loop while( res )

    if( last_objf ) then
	 	bfd_close( last_objf )
	end if
	
	'' close the archive file
	bfd_close( archf )
	
	return res

end function
	
'':::::
function hDumpObject( byval objf as bfd ptr ) as integer
	
	'' not a valid object file?
	if( bfd_check_format_matches( objf, bfd_object, 0 ) = FALSE ) then
		print "error: "; *bfd_errmsg( bfd_get_error( ) )
		return FALSE
	end if
			
	'' search for our special section
	dim as asection ptr sec = bfd_get_section_by_name( objf, FB_INFOSEC_NAME )
	if( sec = 0 ) then
		print "error: "; *bfd_errmsg( bfd_get_error( ) )
		return FALSE
	end if
  				
  	'' load the section to memory
  	dim as integer size = bfd_get_section_size( sec )
  	if( size = 0 ) then
  		print "error: "; *bfd_errmsg( bfd_get_error( ) )
  		return FALSE
	end if
  	
  	dim as byte ptr buf = allocate( size )
  			
  	bfd_get_section_contents( objf, sec, buf, 0, size )

  	'' for each entry in the section..
  	dim as byte ptr p = buf
  	
	'' check version
	if( *p <> FB_INFOSEC_VERSION ) then
		print -4
		return FALSE
	end if
  					
	p += 1
  	
  	do 
  		dim as integer id = *p
  		if( id = FB_INFOSEC_EOL ) then
  			exit do
  		end if
  					
  		p += 1
  					
      	'' dump the entries
      	select case id
      	case FB_INFOSEC_LIB
	  		print "libraries: "; 
	  		p += hPrintList( p )

      	case FB_INFOSEC_PTH
	  		print "paths: "; 
	  		p += hPrintList( p )

      	case FB_INFOSEC_CMD
	  		print "options: "; 
	  		p += hPrintList( p )
	  		
	  	case else
	  		exit do
	  	end select
	
	loop
				
	deallocate( buf )

	return TRUE
	
end function

'':::::	
function hPrintList( byval buf as byte ptr ) as integer
	
	dim as byte ptr p = buf
	
	'' for each entry..
	do
		dim as integer lgt = *p
	  	p += 1
	  	
	  	if( lgt = 0 ) then
	  		exit do
		end if
	  	
	  	print *cast( zstring ptr, p ); " ";
	  	
	  	p += lgt + 1
	loop
	
	if( p <> buf ) then
		print
	end if
	
	'' return the list length
	function = p - buf

end function