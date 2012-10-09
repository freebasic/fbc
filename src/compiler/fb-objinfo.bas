'' object and library info section reader and writer
''
'' chng: dec/2006 written [v1ctor]
''

#ifndef DISABLE_OBJINFO

#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ast.bi"

#ifdef ENABLE_FBBFD
	#define __BFD_VER__ ENABLE_FBBFD
	#include once "bfd.bi"
#else
	#include once "bfd-wrapper.bi"
#endif

declare function hProcessObject _
	( _
		byval objf as bfd ptr, _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

'':::::
private sub hInitialize( )
	static as integer inited = FALSE

	if( inited = FALSE ) then
		inited = TRUE
		bfd_init( )
	end if

end sub

'':::::
function fbObjInfoReadObj _
	( _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

	hInitialize( )

	'' open the object file for read
	dim as bfd ptr objf = bfd_openr( objName, NULL )

	if( objf = NULL ) then
#if defined( DEBUG_BFD )
		print "BFD couldn't open " & *objName
#endif
		return FALSE
	else
#if defined( DEBUG_BFD )
		print "BFD opened " & *objName
#endif
	end if

	'' dump it
	function = hProcessObject( objf, objName, addLib, addLibPath, addOption )

	'' close the object file
	bfd_close( objf )

end function

'':::::
function fbObjInfoReadLib _
	( _
		byval libName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpaths as TLIST ptr _
	) as integer

	hInitialize( )

	static as string libfile
	static as string filename

	'' only search for static libraries (import are named .dll.a and dynamic .so)
	filename =  "lib" + *libName + ".a"

	'' try finding it at the lib paths
	dim as TSTRSETITEM ptr path = listGetHead(libpaths)
	while (path)
		libfile = path->s + FB_HOST_PATHDIV + filename
		if( hFileExists( libfile ) ) then
#if defined( DEBUG_BFD )
			print "BFD found library """ & libfile & """"
#endif
			exit while
		end if

		path = listGetNext(path)
	wend

	'' not found?
	if( path = NULL ) then
		return FALSE
	end if

	'' open the archive file for read
	dim as bfd ptr archf = bfd_openr( libfile, NULL )

	if( archf = NULL ) then
#if defined( DEBUG_BFD )
		print "BFD couldn't open " & libfile
#endif
		return FALSE
	else
#if defined( DEBUG_BFD )
		print "BFD opened " & libfile
#endif
	end if

	'' not a valid archive file?
	if( bfd_check_format( archf, bfd_archive ) = FALSE ) then
  		bfd_close( archf )
		return FALSE
	end if

	'' for each object in the archive..
	dim as bfd ptr objf = NULL

	'' get the first (and only the first) object file
	objf = bfd_openr_next_archived_file( archf, objf )
	if( objf <> NULL ) then

		if( *bfd_get_filename( objf ) = FB_INFOSEC_OBJNAME ) then
			function = hProcessObject( objf, libname, addLib, addLibPath, addOption )
		end if

		bfd_close( objf )

	else
		function = FALSE
	end if

	'' close the archive file
	bfd_close( archf )

end function

'':::::
function hProcessLibList _
	( _
		byval buf_ini as byte ptr, _
		byval buf_end as byte ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval objName as zstring ptr _
	) as integer

	dim as byte ptr p = buf_ini

	'' for each entry..
	do while( p < buf_end )
		dim as integer lgt = *p
	  	p += 1

	  	if( lgt = 0 ) then
	  		exit do
		end if

#if defined( DEBUG_BFD )
        print "BFD added library """ & *cast( zstring ptr, p ) & """"
#endif
		addLib( cast( zstring ptr, p ), objName )

	  	p += lgt + 1
	loop

	'' return the list length
	function = p - buf_ini

end function

'':::::
function hProcessLibPathList _
	( _
		byval buf_ini as byte ptr, _
		byval buf_end as byte ptr, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval objName as zstring ptr _
	) as integer

	dim as byte ptr p = buf_ini

	'' for each entry..
	do while( p < buf_end )
		dim as integer lgt = *p
	  	p += 1

	  	if( lgt = 0 ) then
	  		exit do
		end if
        
#if defined( DEBUG_BFD )
        print "BFD added library path """ & *cast( zstring ptr, p ) & """"
#endif
		addLibPath( cast( zstring ptr, p ), objName )

	  	p += lgt + 1
	loop

	'' return the list length
	function = p - buf_ini

end function

'':::::
function hProcessCmdList _
	( _
		byval buf_ini as byte ptr, _
		byval buf_end as byte ptr, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval objName as zstring ptr _
	) as integer

	dim as byte ptr p = buf_ini

	'' for each entry..
	do while( p < buf_end )
		dim as integer lgt = *p
	  	p += 1

	  	if( lgt = 0 ) then
	  		exit do
		end if

		select case *cast( zstring ptr, p )
		case "-mt"
			addOption( FB_COMPOPT_MULTITHREADED, NULL, objName )

		case "-lang"
			dim as zstring ptr value = p + len( "-lang" ) + 1
			lgt += len( *value ) + 1
			addOption( FB_COMPOPT_LANG, value, objName )
		end select

	  	p += lgt + 1
	loop

	'' return the list length
	function = p - buf_ini

end function

'':::::
private function hProcessObject _
	( _
		byval objf as bfd ptr, _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIB, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

	'' not a valid object file?
	if( bfd_check_format_matches( objf, bfd_object, NULL ) = FALSE ) then
#if defined( DEBUG_BFD )
		print "BFD format mismatch"
#endif
		return FALSE
	end if

	'' search for our special section
	dim as asection ptr sec = bfd_get_section_by_name( objf, "." + FB_INFOSEC_NAME )
	if( sec = NULL ) then
#if defined( DEBUG_BFD )
		print "BFD couldn't find FB info"
#endif
		return FALSE
	end if

  	'' load the section to memory
  	dim as integer size = bfd_get_section_size( sec )
  	if( size = 0 ) then
#if defined( DEBUG_BFD )
		print "BFD couldn't load the section"
#endif
  		return FALSE
	end if

  	'' alloc mem
  	static as byte ptr buf_ini = NULL
  	static as integer buf_len = 0

  	if( (buf_ini = NULL) or (size > buf_len) ) then
  		buf_ini = xreallocate( buf_ini, size )
  		buf_len = size
  	end if

  	bfd_get_section_contents( objf, sec, buf_ini, 0, size )

  	dim as byte ptr buf_end = buf_ini + size, p = buf_ini

  	'' check version
  	if( *p <> FB_INFOSEC_VERSION ) then
#if defined( DEBUG_BFD )
		print "BFD couldn't match versions"
#endif
  		return FALSE
  	end if

  	p += 1

  	'' for each entry in the section..
  	do while( p < buf_end )
  		dim as integer id = *p
  		if( id = FB_INFOSEC_EOL ) then
  			exit do
  		end if

  		p += 1

      	'' dump the entries
      	select case as const id
      	case FB_INFOSEC_LIB
#if defined( DEBUG_BFD )
      		print "found libraries in " & *objName
#endif
	  		p += hProcessLibList( p, buf_end, addLib, objName )

      	case FB_INFOSEC_PTH
#if defined( DEBUG_BFD )
      		print "found paths in " & *objName
#endif
	  		p += hProcessLibPathList( p, buf_end, addLibPath, objName )

      	case FB_INFOSEC_CMD
#if defined( DEBUG_BFD )
      		print "found options in " & *objName
#endif
	  		p += hProcessCmdList( p, buf_end, addOption, objName )

	  	case else
	  		exit do
	  	end select

	loop

	function = TRUE

end function

#endif
