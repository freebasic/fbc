''
'' FB compile time information section (.fbctinf) reader
''
''
'' Old format (supported for backwards compatibility with FB <= 0.24):
''
''    The first byte of the .fbctinf section is the version number &h10.
''
''    Multiple data sections can be following behind it:
''
''    Each section starts with 1 byte holding one of the FB_INFOSEC_* values,
''    describing the content of the section.
''        FB_INFOSEC_LIB = library names, from -l or #inclib
''        FB_INFOSEC_PTH = library search paths, from -p or #libpath
''        FB_INFOSEC_CMD = -lang mode and/or -mt setting
''
''    The strings for FB_INFOSEC_LIB and FB_INFOSEC_PTH are stored like this:
''        1 byte = string length without null terminator
''        followed by <raw string with null terminator>
''
''    In FB_INFOSEC_CMD, there can be
''        -lang:
''            1 byte = 5 = len( "-lang" )
''            "-lang" with null terminator
''            "qb"|"deprecated"|"fblite"|"fb" with null terminator
''            (strings encoded much like described above, but no length byte
''             in front of the dialect name)
''        -mt:
''            1 byte = 3 = len( "-mt" )
''            "-mt" with null terminator
''            (string encoded like described above)
''
''    Each of these 3 sections is terminated with a 0 byte.
''
''    Finally, there's 1 byte holding FB_INFOSEC_EOL (= 0).
''
''
'' New format:
''
'' The .fbctinf section's content is a string similar to the fbc command line,
'' except the strings (options/arguments) are each null-terminated on their own,
'' instead of being separated with spaces and only having a null at the end.
'' This prevents us from having to worry about escaping any special chars.
''
'' For example:
''    -l\0mylib\0-p\0mylibpath\0-mt\0-lang\0qb\0
''
'' The following "entries" can be encoded:
''   -l     followed by a library name
''   -p     followed by a library search path
''   -mt    this can be included or left out (boolean)
''   -lang  followed by the -lang mode (fb/fblite/qb/...) used for this object
''
'' Technically it's ok for all entries to appear multiple times,
'' although it only makes sense for -l and -p.
''
''
'' The FB backends can add that section containing the data to the output
'' files they generate. There is no unified writer interface at the moment,
'' since it's different for each backend, that's why it's best to keep the
'' format simple.
''
''
'' The fbc frontend uses the reading interface to extract the objinfo data
'' from the .fbctinf sections of object files it's going to link together.
''
'' objinfoReadObj():
''    reads in an .o file,
''    then calls hLoadFbctinfFromObj().
''
'' objinfoReadLibfile():
''    reads in a lib*.a archive file,
''    looks for the fbctinf object file added to static libraries by fbc -lib,
''    and if found, calls hLoadFbctinfFromObj().
''
'' objinfoReadLib():
''    searches a libfile for the given libname in the given libpaths,
''    then calls objinfoReadLibfile().
''
'' hLoadFbctinfFromObj():
''    reads the currently loaded object file,
''    using either the COFF (Win32, DOS) or ELF32 (Linux, *BSD) format.
''    looks for the .fbctinf section,
''    and if found, parses its content, and tells the frontend about the
''    found libraries etc. by using the callbacks.
''

#include once "objinfo.bi"
#include once "fb.bi"
#include once "hlp.bi"

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

enum
	FB_INFOSEC_EOL = 0
	FB_INFOSEC_LIB
	FB_INFOSEC_PTH
	FB_INFOSEC_CMD
end enum

type OBJINFOPARSERCTX
	i		as integer
	filename	as string
	is_old		as integer  '' old .fbctinf format?
	old_section	as integer  '' FB_INFOSEC_* or -1
end type

dim shared as OBJINFOPARSERCTX parser

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' archive/object reading code

dim shared as zstring * 9 fbctinfname = ".fbctinf"

'' ELF main headers
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
type ELF64_H field = 1
	e_ident(0 to 15)  as ubyte
	e_type            as ushort
	e_machine         as ushort
	e_version         as ulong
	e_entry           as ulongint
	e_phoff           as ulongint
	e_shoff           as ulongint
	e_flags           as ulong
	e_ehsize          as ushort
	e_phentsize       as ushort
	e_phnum           as ushort
	e_shentsize       as ushort
	e_shnum           as ushort
	e_shstrndx        as ushort
end type

dim shared as ubyte elfmagic(0 to 15) = _
{ _
	&h7f, &h45, &h4c, &h46,    0, &h01, _  '' index 4 is set to 1 (32bit) or 2 (64bit)
	&h01, &h00, &h00, &h00, &h00, &h00 _
}

const ET_REL = 1
const EM_386 = 3
const EM_X86_64 = 62

'' ELF section headers
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
type ELF64_SH field = 1
	sh_name         as ulong
	sh_type         as ulong
	sh_flags        as ulongint
	sh_addr         as ulongint
	sh_offset       as ulongint
	sh_size         as ulongint
	sh_link         as ulong
	sh_info         as ulong
	sh_addralign    as ulongint
	sh_entsize      as ulongint
end type

'' Template for ELF32/64 loading code, which can be shared at the source level
'' with almost no differences. Only the typenames need to be re-#defined, to
'' make this code use either the 32bit or 64bit ELF headers (which have
'' different field offsets and sizes), and there are a few constant values that
'' are different too.

#macro ELFLOADINGCODE(ELF_H, ELF_SH, ELF_MAGIC_4, ELF_MACHINE)

private function hCheck##ELF_SH _
	( _
		byval h as ELF_H ptr, _
		byval index as integer _
	) as ELF_SH ptr

	dim as ELF_SH ptr sh = any
	dim as integer headeroffset = any

	headeroffset = h->e_shoff + (index * sizeof( ELF_SH ))

	'' Enough room for the header?
	if( (culngint( headeroffset ) + sizeof( ELF_SH )) > objdata.size ) then
		INFO( "elf: no room for section header" )
		exit function
	end if

	sh = cptr( any ptr, objdata.p ) + headeroffset

	'' Verify the sh_offset/sh_size fields
	if( (culngint( sh->sh_offset ) + sh->sh_size) > objdata.size ) then
		INFO( "elf: invalid sh_offset/sh_size fields" )
		exit function
	end if

	function = sh
end function

private function hGetSectionName##ELF_SH _
	( _
		byval h as ELF_H ptr, _
		byval index as integer, _
		byval nametb as integer _
	) as zstring ptr

	const MAXNAMELEN = 32
	static as zstring * MAXNAMELEN+1 sectionname

	dim as ELF_SH ptr sh = any
	dim as integer i = any, j = any, ch = any

	sh = hCheck##ELF_SH( h, index )
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

private sub hLoadFbctinfFrom##ELF_H( )
	dim as ELF_H ptr h = any
	dim as ELF_SH ptr sh = any, nametb = any
	dim as zstring ptr sectionname = any

	fbctinf.p = NULL
	fbctinf.size = 0

	if( objdata.size < sizeof( ELF_H ) ) then
		INFO( "elf: no room for main header" )
		exit sub
	end if

	h = cptr( any ptr, objdata.p )

	elfmagic(4) = ELF_MAGIC_4
	for i as integer = 0 to 15
		if( h->e_ident(i) <> elfmagic(i) ) then
			INFO( "elf: magic mismatch" )
			exit sub
		end if
	next

	'' matching header size?
	if( h->e_ehsize <> sizeof( ELF_H ) ) then
		INFO( "elf: header size mismatch" )
		exit sub
	end if

	'' relocatable .o?
	if( h->e_type <> ET_REL ) then
		INFO( "elf: not a relocatable .o" )
		exit sub
	end if

	'' x86/x86_64?
	if( h->e_machine <> ELF_MACHINE ) then
		INFO( "elf: machine mismatch" )
		exit sub
	end if

	'' section header tb entry size
	if( h->e_shentsize <> sizeof( ELF_SH ) ) then
		INFO( "elf: invalid e_shentsize" )
		exit sub
	end if

	'' number of section headers
	if( (culngint( h->e_shnum ) * sizeof( ELF_SH )) > objdata.size ) then
		INFO( "elf: invalid e_shnum" )
		exit sub
	end if

	'' index of .shstrtab's section header
	if( (h->e_shstrndx < 0) or (h->e_shstrndx >= h->e_shnum) ) then
		INFO( "elf: invalid e_shstrndx" )
		exit sub
	end if

	'' section header tb file offset
	if( (culngint( h->e_shoff ) + (h->e_shnum * sizeof( ELF_SH ))) > objdata.size ) then
		INFO( "elf: invalid e_shoff" )
		exit sub
	end if

	'' Look up the section header for .shstrtab (index in section header tb
	'' is given as head->e_shstrndx), and find the offset to the section's content.
	nametb = hCheck##ELF_SH( h, h->e_shstrndx )
	if( nametb = NULL ) then
		INFO( "elf: can't read string table" )
		exit sub
	end if

	'' Look up section names (relies on knowing the .shstrtab data, the section name tb)
	'' Starting at section header 1 because 0 always is an empty (NULL) section header
	for i as integer = 1 to h->e_shnum - 1
		sectionname = hGetSectionName##ELF_SH( h, i, nametb->sh_offset )
		if( sectionname ) then
			INFO( "elf: seeing section '" + *sectionname + "'" )
			if( *sectionname = fbctinfname ) then
				sh = hCheck##ELF_SH( h, i )
				if( sh ) then
					fbctinf.p = objdata.p + sh->sh_offset
					fbctinf.size = sh->sh_size
					exit for
				end if
			end if
		end if
	next
end sub

#endmacro

ELFLOADINGCODE( ELF32_H, ELF32_SH, 1, EM_386 )
ELFLOADINGCODE( ELF64_H, ELF64_SH, 2, EM_X86_64 )

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

private sub hLoadFbctinfFromCOFF( byval magic as ushort )
	dim as COFF_H ptr h = any
	dim as COFF_SH ptr sh = any, shbase = any

	fbctinf.p = NULL
	fbctinf.size = 0

	if( objdata.size < sizeof( COFF_H ) ) then
		INFO( "coff: no room for main header" )
		exit sub
	end if

	h = cptr( any ptr, objdata.p )

	'' COFF magic
	if( h->magic <> magic ) then
		INFO( "coff: magic mismatch" )
		exit sub
	end if

	'' Should be 0 for relocatable obj file
	if( h->optheadsize <> 0 ) then
		INFO( "coff: optheadsize field <> 0" )
		exit sub
	end if

	'' Enough room for whole section header table?
	if( (culngint( h->seccount ) * sizeof( COFF_SH )) > objdata.size ) then
		INFO( "coff: no room for section header table" )
		exit sub
	end if

	shbase = cptr( any ptr, h ) + sizeof( COFF_H )

	for i as integer = 0 to (h->seccount - 1)
		sh = shbase + i

		#ifdef DEBUG_OBJINFO
			dim temp as zstring * 9
			for j as integer = 0 to 7
				temp[j] = sh->name(j)
			next
			INFO( "coff: seeing section '" + temp + "'" )
		#endif

		'' The section name can hold 8 chars. Unused chars should be
		'' padded with nulls. If it takes up all 8 chars, there's no
		'' null padding at the end. Since ".fbctinf" takes up all 8
		'' chars we can simply compare each char 1 by 1.
		for j as integer = 0 to 7
			if( sh->name(j) <> fbctinfname[j] ) then
				continue for, for
			end if
		next

		if( (culngint( sh->dataoffset ) + sh->size) > objdata.size ) then
			INFO( "coff: invalid section header data offset" )
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

private sub hLoadFbctinfFromObj( )
	select case as const( fbGetOption( FB_COMPOPT_TARGET ) )
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_DOS, _
	     FB_COMPTARGET_WIN32, FB_COMPTARGET_XBOX
		if( fbIs64Bit( ) ) then
			INFO( "reading x86-64 COFF: " + parser.filename )
			hLoadFbctinfFromCOFF( &h8664 )
		else
			INFO( "reading i386 COFF: " + parser.filename )
			hLoadFbctinfFromCOFF( &h014C )
		end if

	case FB_COMPTARGET_DARWIN, FB_COMPTARGET_FREEBSD, _
	     FB_COMPTARGET_LINUX, FB_COMPTARGET_NETBSD, _
	     FB_COMPTARGET_OPENBSD
		if( fbIs64Bit( ) ) then
			INFO( "reading x86-64 ELF: " + parser.filename )
			hLoadFbctinfFromELF64_H( )
		else
			INFO( "reading i386 ELF: " + parser.filename )
			hLoadFbctinfFromELF32_H( )
		end if

	end select

	if( fbctinf.size = 0 ) then
		INFO( "no .fbctinf found" )
		exit sub
	end if

	INFO( "found .fbctinf (" + str( fbctinf.size ) + " bytes)" )

	'' Check whether it's the old or new format
	if( fbctinf.p[0] = &h10 ) then
		INFO( ".fbctinf is using the old format" )
		parser.is_old = TRUE
		parser.i = 1  '' Skip the header byte
	else
		parser.is_old = FALSE
	end if
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' objinfo parsing interface

type ENTRYINFO
	text       as zstring ptr
	has_param  as integer
end type

dim shared as ENTRYINFO entries(0 to (OBJINFO__COUNT - 1)) = _
{ _
	( @"-l"   , TRUE  ), _
	( @"-p"   , TRUE  ), _
	( @"-mt"  , FALSE ), _
	( @"-lang", TRUE  )  _
}

private sub hResetBuffers( )
	ardata.p = NULL
	ardata.size = 0
	objdata.p = NULL
	objdata.size = 0
	fbctinf.p = NULL
	fbctinf.size = 0
end sub

private sub objinfoInit( byref filename as string )
	hResetBuffers( )
	parser.i = 0
	parser.filename = filename
	parser.is_old = FALSE
	parser.old_section = -1
end sub

sub objinfoReadObj( byref objfile as string )
	objinfoInit( objfile )

	hLoadFile( objfile, @objdata )
	if( objdata.size = 0 ) then
		exit sub
	end if

	hLoadFbctinfFromObj( )
end sub

sub objinfoReadLibfile( byref libfile as string )
	objinfoInit( libfile )

	hLoadFile( libfile, @ardata )
	if( ardata.size = 0 ) then
		exit sub
	end if

	hLoadObjFromAr( )
	if( objdata.size = 0 ) then
		exit sub
	end if

	hLoadFbctinfFromObj( )
end sub

sub objinfoReadLib( byref libname as string, byval libpaths as TLIST ptr )
	static as string libfile, filename
	dim as TSTRSETITEM ptr path = any

	'' only search for static libraries (import are named .dll.a and dynamic .so)
	filename =  "lib" + libname + ".a"

	'' try finding it at the lib paths
	path = listGetHead( libpaths )
	while( path )
		libfile = path->s + FB_HOST_PATHDIV + filename
		if( hFileExists( libfile ) ) then
			exit while
		end if

		path = listGetNext( path )
	wend

	'' not found?
	if( path = NULL ) then
		INFO( "could not find library: " + libname )
		exit sub
	end if

	objinfoReadLibfile( libfile )
end sub

private function hGetNextString( ) as zstring ptr
	dim as integer begin = any

	function = @""

	begin = parser.i

	'' Skip over the next null-terminated string, if any
	while( parser.i < fbctinf.size )
		parser.i += 1

		'' Was it a null terminator?
		if( fbctinf.p[parser.i-1] = 0 ) then
			return fbctinf.p + begin
		end if
	wend
end function

function objinfoReadNext( byref dat as string ) as integer
	if( fbctinf.size <= 0 ) then
		return -1
	end if

	if( parser.is_old ) then
		while( parser.i < fbctinf.size )
			'' Not inside any section currently?
			if( parser.old_section < 0 ) then
				'' Read next section id byte
				parser.old_section = fbctinf.p[parser.i]
				parser.i += 1

				'' Validate the section id, and also stop on EOL
				if( (parser.old_section <= FB_INFOSEC_EOL) or _
				    (parser.old_section >  FB_INFOSEC_CMD) ) then
					parser.old_section = -1
					parser.i = fbctinf.size
					return -1
				end if
			end if

			'' Read next entry

			'' Entry string length byte, or 0 section end byte
			if( parser.i >= fbctinf.size ) then
				return -1
			end if
			parser.i += 1

			'' If it was a 0 byte, continue on to the next section
			if( fbctinf.p[parser.i-1] = 0 ) then
				parser.old_section = -1
				continue while
			end if

			'' Otherwise it's an entry. Parse the null-terminated
			'' string following behind the length byte, if any.
			dat = *hGetNextString( )

			select case( parser.old_section )
			case FB_INFOSEC_LIB
				INFO( "lib: " + dat )
				return OBJINFO_LIB
			case FB_INFOSEC_PTH
				INFO( "libpath: " + dat )
				return OBJINFO_LIBPATH
			case FB_INFOSEC_CMD
				select case( dat )
				case "-lang"
					'' Read another string, the dialect id
					dat = *hGetNextString( )
					if( len( dat ) > 0 ) then
						INFO( "-lang " + dat )
						return OBJINFO_LANG
					end if
				case "-mt"
					INFO( "-mt" )
					return OBJINFO_MT
				end select
			end select
		wend
	else
		'' Parse the objinfo data (multiple null-terminated strings)
		dat = *hGetNextString( )

		for i as integer = 0 to (OBJINFO__COUNT - 1)
			if( dat = *entries(i).text ) then
				if( entries(i).has_param ) then
					dat = *hGetNextString( )
					INFO( *entries(i).text + " " + dat )
				else
					INFO( dat )
				end if
				return i
			end if
		next
	end if

	function = -1
end function

function objinfoGetFilename( ) as zstring ptr
	function = strptr( parser.filename )
end function

sub objinfoReadEnd( )
	if( ardata.p ) then
		'' Archive buffer was allocated, the others point into it
		deallocate( ardata.p )
	elseif( objdata.p ) then
		'' Object buffer was allocated, fbctinf points into it,
		'' archive buffer is unused
		deallocate( objdata.p )
	end if

	hResetBuffers( )
end sub

function objinfoEncode( byval entry as integer ) as zstring ptr
	function = entries(entry).text
end function
