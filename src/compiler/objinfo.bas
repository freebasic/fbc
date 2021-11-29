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
''   -gfx   ditto
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
''    Note that Darwin has two different types of static libraries, both with
''    extension .a: normal 'ar' archives, and 'lipo' fat/universal binaries.
''    fbc creates ar archives, and it seems to generally be the default.
''    We only support reading 'ar' archives.
''
'' objinfoReadLib():
''    searches a libfile for the given libname in the given libpaths,
''    then calls objinfoReadLibfile().
''
'' hLoadFbctinfFromObj():
''    reads the currently loaded object file,
''    using either the COFF (Win32, DOS), ELF32/64 (Linux, *BSD) or
''    Mach-O (Darwin) format.
''    ELF32 (linux-arm) or ELF64 (linux-aarch64)
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
	p       as ubyte ptr
	size    as integer
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
	i           as integer
	filename    as string
	is_old      as integer  '' old .fbctinf format?
	old_section as integer  '' FB_INFOSEC_* or -1
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
	&h7f, _     '' '.'
	&h45, _     '' 'E'
	&h4c, _     '' 'L'
	&h46, _     '' 'F'
	&h00, _     '' 1 (32bit) or 2 (64bit)
	&h01, _     '' 1 (little endian) or 2 (big endian)
	&h01, _     '' 1 - the one and only version of ELF
	&h00, _     '' target ABI
	&h00, _     '' ABI version
	&h00, _     '' unused 0
	&h00, _     '' object file type
	&h00  _     '' target machine
}

const ET_REL = 1
const EM_386 = 3
const EM_X86_64 = &h3e
const EM_ARM32 = &h28
const EM_AARCH64 = &hb7
const EM_PPC = &h14
const EM_PPC64 = &h15

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

#macro ELFLOADINGCODE(ELF_H, ELF_SH, ELF_MAGIC_4)

'' ELF_H        - elf main header (ELF32_H or ELF64_H)
'' ELF_SH       - typename of the section header type (ELF32_SH or ELF64_SH)
'' ELF_MAGIC_4  - 1 for 32 bit, 2 for 64-bit

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

private sub hLoadFbctinfFrom##ELF_H( byval ELF_MACHINE as integer )
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

	'' set 32 or 64 bits
	elfmagic(4) = ELF_MAGIC_4

	'' set little endian or big endian
	if( fbIsHostBigEndian( ) ) then
		elfmagic(5) = 2 '' big endian
	else
		elfmagic(5) = 1 '' little endian
	end if

	'' set the target system expected
	if( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_FREEBSD ) then
		elfmagic(7) = &h09  '' FreeBSD
	else
		elfmagic(7) = 0     '' System V
	end if

	'' check that magic given is the magic needed
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

	'' x86/x86_64/arm/aarch64?
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

ELFLOADINGCODE( ELF32_H, ELF32_SH, 1 )
ELFLOADINGCODE( ELF64_H, ELF64_SH, 2 )

'' COFF main header
type COFF_H field = 1
	magic       as ushort  '' magic number (type of target machine)
	seccount    as ushort  '' number of sections/entries in section tb
			           '' (which follows behind the headers)
	timestamp   as ulong   '' creation time (time_t)
	symtboffset as ulong   '' file offset of symbol table
	symcount    as ulong   '' entries in the symtb
	optheadsize as ushort  '' size of optional headers; 0 in obj file
	flags       as ushort
end type

'' COFF section header
type COFF_SH field = 1
	name(0 to 7)    as ubyte  '' section name
	paddr       as ulong  '' physical address
	vaddr       as ulong  '' virtual address
	size        as ulong  '' section size
	dataoffset  as ulong  '' offset to section data
	reloffset   as ulong  '' offset to relocation data
	lnoffset    as ulong  '' offset to line number data
	relcount    as ushort '' number of relocation entries
	lncount     as ushort '' number of line number entries
	flags       as ulong
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


'' Mach-O implementation

'' All of these structures are defined in /usr/include/mach-o/loader.h

'' mach_header and mach_header_64 are identical aside from addition of
'' a reserved member at the end, and different magic constant.
type MACH_H
	magic       as ulong
	cputype     as ulong  ' cpu_type_t
	cpusubtype  as ulong  ' cpu_subtype_t
	filetype    as ulong
	ncmds       as ulong
	sizeofcmds  as ulong
	flags       as ulong
end type

'' Mach-O load command header
type LOAD_COMMAND_H
	cmd as ulong
	cmdsize as ulong
end type

'' cpu_type_t constants
const MACH_CPU_ARCH_ABI64 = &h01000000
const MACH_CPU_TYPE_X86 = 7
const MACH_CPU_TYPE_X86_64 = (MACH_CPU_TYPE_X86 or MACH_CPU_ARCH_ABI64)
const MACH_CPU_TYPE_ARM = 12
const MACH_CPU_TYPE_ARM64 = (MACH_CPU_TYPE_ARM or MACH_CPU_ARCH_ABI64)
const MACH_CPU_TYPE_POWERPC = 18
const MACH_CPU_TYPE_POWERPC64 = (MACH_CPU_TYPE_POWERPC or MACH_CPU_ARCH_ABI64)

const MH_MAGIC_32 = &hfeedface
const MH_MAGIC_64 = &hfeedfacf

const MH_OBJECT = 1  ' MH_OBJECT

const LC_SEGMENT = &h1
const LC_SEGMENT_64 = &h19

#macro DEFINE_SEGMENT_COMMAND(NAME, SIZE_TYPE)
type NAME
	cmd         as ulong
	cmdsize     as ulong
	segname(15) as ubyte
	vmaddr      as SIZE_TYPE
	vmsize      as SIZE_TYPE
	fileoff     as SIZE_TYPE
	filesize    as SIZE_TYPE
	maxprot     as ulong  'vm_prot_t
	initprot    as ulong  'vm_prot_t
	nsects      as ulong
	flags       as ulong
end type
#endmacro

DEFINE_SEGMENT_COMMAND(SEGMENT_COMMAND_32, ulong)    'struct segment_command
DEFINE_SEGMENT_COMMAND(SEGMENT_COMMAND_64, ulongint) 'struct segment_command_64

#macro DEFINE_SECTION(NAME, SIZE_TYPE, RESERVED3)
'' Defined in /usr/include/mach-o/loader.h
type NAME
	sectname     as zstring * 16
	segname      as zstring * 16
	addr         as SIZE_TYPE
	size         as SIZE_TYPE
	offset       as ulong
	align        as ulong
	reloff       as ulong
	nreloc       as ulong
	flags        as ulong
	reserved1    as ulong
	reserved2    as ulong
	RESERVED3
end type
#endmacro

DEFINE_SECTION(SECTION_32, ulong, )                   'struct section
DEFINE_SECTION(SECTION_64, ulongint, reserved3 as ulong) 'struct section_64


#macro MACHO_SECTION_CODE(BITS)

'' Iterate over the sections of a segment load command. Returns non-zero on error.
private function hProcessMachOSegment##BITS( byval loadcmd as LOAD_COMMAND_H ptr ) as integer
	dim segmentp as SEGMENT_COMMAND_##BITS ptr
	dim sectionp as SECTION_##BITS ptr

	segmentp = cptr( SEGMENT_COMMAND_##BITS ptr, loadcmd )
	if( segmentp + 1 > objdata.p + objdata.size ) then
		INFO( "mach-o: segment load_command past end of file" )
		return 1
	end if

	'' Section headers follow immediately after the segment header
	sectionp = cptr( SECTION_##BITS ptr, segmentp + 1 )
	for sectionidx as integer = 0 to segmentp->nsects - 1
		if( sectionp + 1 > objdata.p + objdata.size ) then
			INFO( "mach-o: section header past end of file" )
			return 1
		end if

		INFO( "mach-o: found segment=" & sectionp->segname & " section=" & sectionp->sectname )
		if( sectionp->sectname = FB_INFOSEC_NAME ) then
			if( sectionp->offset + sectionp->size > objdata.size ) then
				INFO( "mach-o: fbctinf section data past end of file" )
				return 1
			end if

			fbctinf.p = objdata.p + sectionp->offset
			fbctinf.size = sectionp->size
			exit for
		end if

		sectionp += 1
	next
end function

#endmacro

MACHO_SECTION_CODE(32)
MACHO_SECTION_CODE(64)

private sub hLoadFbctinfFromMachO( )
	dim header as MACH_H ptr = any
	dim loadcmd as LOAD_COMMAND_H ptr = any
	dim dataptr as ubyte ptr = any

	fbctinf.p = NULL
	fbctinf.size = 0

	if( objdata.size < sizeof( MACH_H ) ) then
		INFO( "mach-o: no room for header" )
		exit sub
	end if

	header = cptr( any ptr, objdata.p )

	'' Check magic
	if( header->magic <> MH_MAGIC_32 and header->magic <> MH_MAGIC_64 ) then
		INFO( "mach-o: magic constant mismatch" )
		exit sub
	end if

	'' Check cpu type matches
	select case( fbGetCpuFamily( ) )
	case FB_CPUFAMILY_X86
		if( header->cputype <> MACH_CPU_TYPE_X86 ) then
			INFO( "mach-o: CPU type is not x86" )
			exit sub
		end if
	case FB_CPUFAMILY_X86_64
		if( header->cputype <> MACH_CPU_TYPE_X86_64 ) then
			INFO( "mach-o: CPU type is not x86_64" )
			exit sub
		end if
	case FB_CPUFAMILY_ARM
		if( header->cputype <> MACH_CPU_TYPE_ARM ) then
			INFO( "mach-o: CPU type is not 32bit ARM" )
			exit sub
		end if
	case FB_CPUFAMILY_AARCH64
		if( header->cputype <> MACH_CPU_TYPE_ARM64 ) then
			INFO( "mach-o: CPU type is not ARM64" )
			exit sub
		end if
	end select

	'' Check file type
	if( header->filetype <> MH_OBJECT ) then
		INFO( "mach-o: Not an object file" )
		exit sub
	end if

	'' 64 bit mach-o files have 4 bytes padding after header so load commands are 8-byte aligned
	dataptr = objdata.p + sizeof( MACH_H )
	if( header->magic = MH_MAGIC_64 ) then
		dataptr += 4
	end if

	'' Iterate over load commands. Note: 'segment' load commands are not the same
	'' thing as the memory segments the sections belong to. Instead, to reduce space overhead
	'' of .o files, all sections are stored under a single segment load command regardless of
	'' their actual segment.
	for cmdidx as integer = 0 to header->ncmds - 1
		loadcmd = cptr( LOAD_COMMAND_H ptr, dataptr )

		if( loadcmd + 1 > objdata.p + objdata.size ) then
			INFO( "mach-o: load_command past end of file" )
			exit sub
		end if

		INFO( "mach-o: load command " & loadcmd->cmd )
		if( loadcmd->cmd = LC_SEGMENT ) then
			if( hProcessMachOSegment32( loadcmd ) ) then
				exit sub
			end if
		elseif( loadcmd->cmd = LC_SEGMENT_64 ) then
			if( hProcessMachOSegment64( loadcmd ) ) then
				exit sub
			end if
		end if

		dataptr += loadcmd->cmdsize
	next
end sub


'' .a archive entry header
type AR_H field = 1
	'' (all values right-padded with ASCII spaces)
	name(0 to 15)       as ubyte '' ASCII
	modifytime(0 to 11) as ubyte '' decimal
	ownerid(0 to 5)     as ubyte '' decimal
	groupid(0 to 5)     as ubyte '' decimal
	mode(0 to 7)        as ubyte '' octal
	size(0 to 9)        as ubyte '' decimal
	magic(0 to 1)       as ubyte '' &h60 &h0A
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
	if( fbTargetSupportsCOFF( ) ) then
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86_64
			INFO( "reading x86-64 COFF: " + parser.filename )
			hLoadFbctinfFromCOFF( &h8664 )
		case FB_CPUFAMILY_X86
			INFO( "reading i386 COFF: " + parser.filename )
			hLoadFbctinfFromCOFF( &h014C )
		end select
	elseif( fbTargetSupportsELF( ) ) then
		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86_64
			INFO( "reading x86-64 ELF: " + parser.filename )
			hLoadFbctinfFromELF64_H( EM_X86_64 )
		case FB_CPUFAMILY_X86
			INFO( "reading i386 ELF: " + parser.filename )
			hLoadFbctinfFromELF32_H( EM_386 )
		case FB_CPUFAMILY_AARCH64
			INFO( "reading aarch64 ELF: " + parser.filename )
			hLoadFbctinfFromELF64_H( EM_AARCH64 )
		case FB_CPUFAMILY_ARM
			INFO( "reading arm32 ELF: " + parser.filename )
			hLoadFbctinfFromELF32_H( EM_ARM32 )
		case FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
			INFO( "reading powerpc64 ELF: " + parser.filename )
			hLoadFbctinfFromELF64_H( EM_PPC64 )
		case FB_CPUFAMILY_PPC
			INFO( "reading powerpc32 ELF: " + parser.filename )
			hLoadFbctinfFromELF32_H( EM_PPC )
		end select
	elseif( fbTargetSupportsMachO( ) ) then
		INFO( "reading Mach-O: " + parser.filename )
		hLoadFbctinfFromMachO( )
	end if

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
	( @"-gfx" , FALSE ), _
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
