''
'' FB compile time information section (.fbctinf) reader
''
'' fbObjInfoReadLib():
''    reads in a lib*.a archive file,
''    looks for the fbctinf object file added to static libraries by fbc -lib,
''    and if found, calls hProcessObject().
''
'' fbObjInfoReadObj():
''    reads in an .o file,
''    then calls hProcessObject().
''
'' hProcessObject():
''    reads the currently loaded object file,
''    using either the COFF (Win32, DOS) or ELF32 (Linux, *BSD) format.
''    looks for the .fbctinf section,
''    and if found, parses its content, and tells the frontend about the
''    found libraries etc. by using the callbacks.
''

#ifndef DISABLE_OBJINFO

#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"

'#define DEBUG_OBJINFO

#ifdef DEBUG_OBJINFO
	#define INFO( s ) print "objinfo: " + s
#else
	#define INFO( s )
#endif

type DATABUFFER
	p	as ubyte ptr
	size	as integer
end type

dim shared as DATABUFFER _
	ardata, _   '' current .a file content (if any)
	objdata, _  '' current .o file content (can point into ardata)
	fbctinf     '' .fbctinf section content, points into objdata

dim shared as zstring * 9 fbctinfname = ".fbctinf"

'' ELF32 main header
type ELF32_H field = 1
	e_ident(0 to 15)  as ubyte
	e_type            as ushort
	e_machine         as ushort
	e_version         as ulong
	e_entry           as ulong
	e_phoff           as ulong
	e_shoff           as ulong
	e_flags           as ulong
	e_ehsize          as ushort
	e_phentsize       as ushort
	e_phnum           as ushort
	e_shentsize       as ushort
	e_shnum           as ushort
	e_shstrndx        as ushort
end type

dim shared as ubyte elf32magic(0 to 15) = _
{ _
	&h7f, &h45, &h4c, &h46, &h01, &h01, _
	&h01, &h00, &h00, &h00, &h00, &h00 _
}

const ET_REL = 1
const EM_386 = 3

'' ELF32 section header
type ELF32_SH field = 1
	sh_name         as ulong
	sh_type         as ulong
	sh_flags        as ulong
	sh_addr         as ulong
	sh_offset       as ulong
	sh_size         as ulong
	sh_link         as ulong
	sh_info         as ulong
	sh_addralign    as ulong
	sh_entsize      as ulong
end type

private function hCheckELF32_SH _
	( _
		byval h as ELF32_H ptr, _
		byval index as integer _
	) as ELF32_SH ptr

	dim as ELF32_SH ptr sh = any
	dim as integer headeroffset = any

	headeroffset = h->e_shoff + (index * sizeof( ELF32_SH ))

	'' Enough room for the header?
	if( (culngint( headeroffset ) + sizeof( ELF32_SH )) > objdata.size ) then
		exit function
	end if

	sh = cptr( any ptr, objdata.p ) + headeroffset

	'' Verify the sh_offset/sh_size fields
	if( (culngint( sh->sh_offset ) + sh->sh_size) > objdata.size ) then
		exit function
	end if

	function = sh
end function

private function hGetELF32SectionName _
	( _
		byval h as ELF32_H ptr, _
		byval index as integer, _
		byval nametb as integer _
	) as zstring ptr

	const MAXNAMELEN = 32
	static as zstring * MAXNAMELEN+1 sectionname

	dim as ELF32_SH ptr sh = any
	dim as integer i = any, j = any, ch = any

	sh = hCheckELF32_SH( h, index )
	if( sh = NULL ) then
		exit function
	end if

	'' null-terminated string starting at the given name offset relative to
	'' the beginning of the name tb
	i = nametb + sh->sh_name
	j = 0
	while( (i < objdata.size) and (j < MAXNAMELEN) )
		ch = objdata.p[i]
		if( ch = 0 ) then
			exit while
		end if
		sectionname[j] = ch
		i += 1
		j += 1
	wend
	sectionname[j] = 0

	function = @sectionname
end function

private sub hLoadFbctinfFromELF32( )
	dim as ELF32_H ptr h = any
	dim as ELF32_SH ptr sh = any, nametb = any
	dim as zstring ptr sectionname = any

	INFO( "reading ELF32 object" )

	fbctinf.p = NULL
	fbctinf.size = 0

	if( objdata.size < sizeof( ELF32_H ) ) then
		exit sub
	end if

	h = cptr( any ptr, objdata.p )

	for i as integer = 0 to 15
		if( h->e_ident(i) <> elf32magic(i) ) then
			exit sub
		end if
	next

	'' matching header size?
	if( h->e_ehsize <> sizeof( ELF32_H ) ) then
		exit sub
	end if

	'' relocatable .o?
	if( h->e_type <> ET_REL ) then
		exit sub
	end if

	'' x86?
	if( h->e_machine <> EM_386 ) then
		exit sub
	end if

	'' section header tb entry size
	if( h->e_shentsize <> sizeof( ELF32_SH ) ) then
		exit sub
	end if

	'' number of section headers
	if( (culngint( h->e_shnum ) * sizeof( ELF32_SH )) > objdata.size ) then
		exit sub
	end if

	'' index of .shstrtab's section header
	if( (h->e_shstrndx < 0) or (h->e_shstrndx >= h->e_shnum) ) then
		exit sub
	end if

	'' section header tb file offset
	if( (culngint( h->e_shoff ) + (h->e_shnum * sizeof( ELF32_SH ))) > objdata.size ) then
		exit sub
	end if

	'' Look up the section header for .shstrtab (index in section header tb
	'' is given as head->e_shstrndx), and find the offset to the section's content.
	nametb = hCheckELF32_SH( h, h->e_shstrndx )
	if( nametb = NULL ) then
		exit sub
	end if

	'' Look up section names (relies on knowing the .shstrtab data, the section name tb)
	'' Starting at section header 1 because 0 always is an empty (NULL) section header
	for i as integer = 1 to h->e_shnum - 1
		sectionname = hGetELF32SectionName( h, i, nametb->sh_offset )
		if( sectionname ) then
			if( *sectionname = fbctinfname ) then
				sh = hCheckELF32_SH( h, i )
				if( sh ) then
					fbctinf.p = objdata.p + sh->sh_offset
					fbctinf.size = sh->sh_size
					exit for
				end if
			end if
		end if
	next
end sub

'' COFF main header
type COFF_H field = 1
	magic		as ushort  '' magic number (type of target machine)
	seccount	as ushort  '' number of sections/entries in section tb
			           '' (which follows behind the headers)
	timestamp	as ulong   '' creation time (time_t)
	symtboffset	as ulong   '' file offset of symbol table
	symcount	as ulong   '' entries in the symtb
	optheadsize	as ushort  '' size of optional headers; 0 in obj file
	flags		as ushort
end type

'' COFF section header
type COFF_SH field = 1
	name(0 to 7)	as ubyte  '' section name
	paddr		as ulong  '' physical address
	vaddr		as ulong  '' virtual address
	size		as ulong  '' section size
	dataoffset	as ulong  '' offset to section data
	reloffset	as ulong  '' offset to relocation data
	lnoffset	as ulong  '' offset to line number data
	relcount	as ushort '' number of relocation entries
	lncount		as ushort '' number of line number entries
	flags		as ulong
end type

private sub hLoadFbctinfFromCOFF( )
	dim as COFF_H ptr h = any
	dim as COFF_SH ptr sh = any, shbase = any

	INFO( "reading COFF object" )

	fbctinf.p = NULL
	fbctinf.size = 0

	if( objdata.size < sizeof( COFF_H ) ) then
		exit sub
	end if

	h = cptr( any ptr, objdata.p )

	'' COFF i386 magic
	if( h->magic <> &h014C ) then
		exit sub
	end if

	'' Should be 0 for relocatable obj file
	if( h->optheadsize <> 0 ) then
		exit sub
	end if

	'' Enough room for whole section header table?
	if( (culngint( h->seccount ) * sizeof( COFF_SH )) > objdata.size ) then
		exit sub
	end if

	shbase = cptr( any ptr, h ) + sizeof( COFF_H )

	for i as integer = 0 to (h->seccount - 1)
		sh = shbase + i
		for j as integer = 0 to 7
			if( sh->name(j) <> fbctinfname[j] ) then
				continue for, for
			end if
		next

		if( (culngint( sh->dataoffset ) + sh->size) > objdata.size ) then
			exit sub
		end if

		fbctinf.p = objdata.p + sh->dataoffset
		fbctinf.size = sh->size
		exit for
	next
end sub

'' .a archive entry header
type AR_H field = 1
	'' (all values right-padded with ASCII spaces)
	name(0 to 15)		as ubyte '' ASCII
	modifytime(0 to 11)	as ubyte '' decimal
	ownerid(0 to 5)		as ubyte '' decimal
	groupid(0 to 5)		as ubyte '' decimal
	mode(0 to 7)		as ubyte '' octal
	size(0 to 9)		as ubyte '' decimal
	magic(0 to 1)		as ubyte '' &h60 &h0A
end type

dim shared as ubyte armagic(0 to 7) = _
{ _
	asc( "!" ), asc( "<" ), asc( "a" ), asc( "r" ), _
	asc( "c" ), asc( "h") , asc( ">" ), asc( !"\n" ) _
}

private function hLoadArString _
	( _
		byval p as ubyte ptr, _
		byval length as integer _
	) as zstring ptr

	'' Biggest field in the ar header is 16 bytes
	const MAXLEN = 16
	static as zstring * MAXLEN+1 s
	dim as integer last = any, i = any

	assert( length <= MAXLEN )

	'' Find last char (skipping right-padding spaces)
	last = length - 1
	while( last >= 0 )
		if( p[last] <> asc( " " ) ) then
			exit while
		end if
		last -= 1
	wend

	'' Copy into string
	i = 0
	while( i <= last )
		s[i] = p[i]
		i += 1
	wend
	s[i] = 0 '' null terminator

	function = @s
end function

private sub hLoadObjFromAr( )
	dim as AR_H ptr h = any
	dim as string filename
	dim as integer i = any, filesize = any

	objdata.p = NULL
	objdata.size = 0

	'' 8 magic bytes
	if( ardata.size < 8 ) then
		exit sub
	end if

	for i = 0 to 7
		if( ardata.p[i] <> armagic(i) ) then
			exit sub
		end if
	next

	i = 8
	do
		'' Enough room for header?
		if( ((i + sizeof( AR_H )) > ardata.size) ) then
			exit sub
		end if

		h = cptr( any ptr, ardata.p ) + i
		filename = *hLoadArString( @h->name(0), 16 )
		filesize = val( *hLoadArString( @h->size(0), 10 ) )

		INFO( "ar: found " + filename + ", " + str( filesize ) + " bytes" )

		if( filesize < 0 ) then
			filesize = 0
		elseif( (filesize > ardata.size) or _
			(filesize > (ardata.size - i)) ) then
			filesize = ardata.size - i
		end if

		'' Skip over header
		i += sizeof( AR_H )

		select case( filename )
		case "__fb_ct.inf", "__fb_ct.inf/"
			if( filesize > 0 ) then
				objdata.p = cptr( any ptr, ardata.p ) + i
				objdata.size = filesize
			end if
			exit do

		case "/", "//", "__.SYMDEF"
			'' Special long filename support/symbol table entries
			'' These will typically appear before any real entries,
			'' so we need to skip them.
			'' ("__fb_ct.inf" is short enough, so we don't need to
			'' worry about supporting long filenames)

		case else
			exit do
		end select

		'' Skip over file data
		i += filesize

		'' Archive headers are 2-byte aligned
		i += i and 1
	loop
end sub

private sub hLoadFile _
	( _
		byref filename as string, _
		byval buf as DATABUFFER ptr _
	)

	dim as integer f = any, size = any
	dim as ubyte ptr p = any

	buf->p = NULL
	buf->size = 0

	f = freefile( )
	if( open( filename, for binary, access read, as #f ) <> 0 ) then
		INFO( "file not found: " + filename )
		exit sub
	end if

	size = lof( f )

	if( size > 0 ) then
		p = allocate( size )
		if( get( #f, , *p, size, size ) <> 0 ) then
			exit sub
		end if
		buf->p = p
		buf->size = size
	end if

	close #f
end sub

declare sub hProcessObject _
	( _
		byref objName as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

sub fbObjInfoReadObj _
	( _
		byref objfile as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

	INFO( "reading object: " + objfile )
	hLoadFile( objfile, @objdata )
	if( objdata.size = 0 ) then
		exit sub
	end if

	hProcessObject( objfile, addLib, addLibPath, addOption )

	deallocate( objdata.p )
	objdata.p = NULL
	objdata.size = 0

end sub

sub fbObjInfoReadLibfile _
	( _
		byref libfile as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

	INFO( "reading archive: " + libfile )
	hLoadFile( libfile, @ardata )
	if( ardata.size = 0 ) then
		exit sub
	end if

	hLoadObjFromAr( )
	if( objdata.size = 0 ) then
		INFO( "fbctinf object not found" )
		exit sub
	end if

	hProcessObject( libfile, addLib, addLibPath, addOption )

	deallocate( ardata.p )
	ardata.p = NULL
	ardata.size = 0

end sub

sub fbObjInfoReadLib _
	( _
		byref libname as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpaths as TLIST ptr _
	)

	static as string libfile
	static as string filename

	'' only search for static libraries (import are named .dll.a and dynamic .so)
	filename =  "lib" + libname + ".a"

	'' try finding it at the lib paths
	dim as TSTRSETITEM ptr path = listGetHead(libpaths)
	while (path)
		libfile = path->s + FB_HOST_PATHDIV + filename
		if( hFileExists( libfile ) ) then
			exit while
		end if

		path = listGetNext(path)
	wend

	'' not found?
	if( path = NULL ) then
		INFO( "could not find library: " + libname )
		exit sub
	end if

	fbObjInfoReadLibfile( libfile, addLib, addLibPath, addOption )
end sub

'':::::
function hProcessLibList _
	( _
		byval buf_ini as byte ptr, _
		byval buf_end as byte ptr, _
		byval addLib as FB_CALLBACK_ADDLIB _
	) as integer

	dim as byte ptr p = buf_ini

	'' for each entry..
	do while( p < buf_end )
		dim as integer lgt = *p
	  	p += 1

	  	if( lgt = 0 ) then
	  		exit do
		end if

		INFO( "fbctinf: found lib '" + *cast( zstring ptr, p ) + "'" )
		addLib( cast( zstring ptr, p ) )

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
		byval addLibPath as FB_CALLBACK_ADDLIBPATH _
	) as integer

	dim as byte ptr p = buf_ini

	'' for each entry..
	do while( p < buf_end )
		dim as integer lgt = *p
	  	p += 1

	  	if( lgt = 0 ) then
	  		exit do
		end if
        
		INFO( "fbctinf: found libpath '" + *cast( zstring ptr, p ) + "'" )
		addLibPath( cast( zstring ptr, p ) )

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
		byref objName as string _
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
			INFO( "fbctinf: found -mt" )
			addOption( FB_COMPOPT_MULTITHREADED, NULL, objName )

		case "-lang"
			INFO( "fbctinf: found -lang" )
			dim as zstring ptr value = p + len( "-lang" ) + 1
			lgt += len( *value ) + 1
			addOption( FB_COMPOPT_LANG, value, objName )
		end select

	  	p += lgt + 1
	loop

	'' return the list length
	function = p - buf_ini

end function

private sub hProcessObject _
	( _
		byref objName as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIB, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

	select case as const( fbGetOption( FB_COMPOPT_TARGET ) )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_DOS, _
	     FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
		hLoadFbctinfFromCOFF( )

	case FB_COMPTARGET_DARWIN, FB_COMPTARGET_FREEBSD, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD
		hLoadFbctinfFromELF32( )

	end select

	if( fbctinf.size = 0 ) then
		INFO( "failed to extract .fbctinf section" )
		exit sub
	end if

	INFO( "found .fbctinf section, " + str( fbctinf.size ) + " bytes" )

	dim as byte ptr buf_end = fbctinf.p + fbctinf.size
	dim as byte ptr p = fbctinf.p

  	'' check version
  	if( *p <> FB_INFOSEC_VERSION ) then
		exit sub
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
			p += hProcessLibList( p, buf_end, addLib )

      	case FB_INFOSEC_PTH
			p += hProcessLibPathList( p, buf_end, addLibPath )

      	case FB_INFOSEC_CMD
	  		p += hProcessCmdList( p, buf_end, addOption, objName )

	  	case else
	  		exit do
	  	end select

	loop
end sub

#endif
