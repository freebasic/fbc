'' fb - main interface
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "lex.bi"
#include once "rtl.bi"
#include once "ast.bi"
#include once "ir.bi"
#include once "objinfo.bi"

type FB_LANG_INFO
	name        as const zstring ptr
	options     as FB_LANG_OPT
end type

declare sub parserInit ( )

declare sub parserEnd ( )

declare sub parserSetCtx ( )

'' globals
dim shared env as FBENV

	dim shared infileTb( ) as FBFILE

	dim shared as FB_LANG_INFO langTb(0 to FB_LANGS-1) = _
	{ _
		( _
			@"fb", _
			FB_LANG_OPT_MT or _
			FB_LANG_OPT_SCOPE or _
			FB_LANG_OPT_NAMESPC or _
			FB_LANG_OPT_EXTERN or _
			FB_LANG_OPT_FUNCOVL or _
			FB_LANG_OPT_OPEROVL or _
			FB_LANG_OPT_CLASS or _
			FB_LANG_OPT_INITIALIZER or _
			FB_LANG_OPT_AUTOVAR or _
			FB_LANG_OPT_SINGERRLINE or _
			FB_LANG_OPT_QUIRKFUNC _
		) _
		, _
		( _
			@"deprecated", _
			FB_LANG_OPT_MT or _
			FB_LANG_OPT_SCOPE or _
			FB_LANG_OPT_NAMESPC or _
			FB_LANG_OPT_EXTERN or _
			FB_LANG_OPT_FUNCOVL or _
			FB_LANG_OPT_INITIALIZER or _
			FB_LANG_OPT_CALL or _
			FB_LANG_OPT_LET or _
			FB_LANG_OPT_PERIODS or _
			FB_LANG_OPT_NUMLABEL or _
			FB_LANG_OPT_IMPLICIT or _
			FB_LANG_OPT_DEFTYPE or _
			FB_LANG_OPT_SUFFIX or _
			FB_LANG_OPT_METACMD or _
			FB_LANG_OPT_OPTION or _
			FB_LANG_OPT_ONERROR or _
			FB_LANG_OPT_QUIRKFUNC _
		) _
		, _
		( _
			@"fblite", _
			FB_LANG_OPT_MT or _
			FB_LANG_OPT_NAMESPC or _
			FB_LANG_OPT_EXTERN or _
			FB_LANG_OPT_FUNCOVL or _
			FB_LANG_OPT_INITIALIZER or _
			FB_LANG_OPT_GOSUB or _
			FB_LANG_OPT_CALL or _
			FB_LANG_OPT_LET or _
			FB_LANG_OPT_PERIODS or _
			FB_LANG_OPT_NUMLABEL or _
			FB_LANG_OPT_IMPLICIT or _
			FB_LANG_OPT_DEFTYPE or _
			FB_LANG_OPT_SUFFIX or _
			FB_LANG_OPT_METACMD or _
			FB_LANG_OPT_OPTION or _
			FB_LANG_OPT_ONERROR or _
			FB_LANG_OPT_QUIRKFUNC _
		) _
		, _
		( _
			@"qb", _
			FB_LANG_OPT_GOSUB or _
			FB_LANG_OPT_CALL or _
			FB_LANG_OPT_LET or _
			FB_LANG_OPT_PERIODS or _
			FB_LANG_OPT_NUMLABEL or _
			FB_LANG_OPT_IMPLICIT or _
			FB_LANG_OPT_DEFTYPE or _
			FB_LANG_OPT_SUFFIX or _
			FB_LANG_OPT_METACMD or _
			FB_LANG_OPT_OPTION or _
			FB_LANG_OPT_ONERROR or _
			FB_LANG_OPT_QUIRKFUNC _
		) _
	}

dim shared as FBTARGET targetinfo(0 to FB_COMPTARGETS-1) = _
{ _
	( _
		@"win32", _             '' id
		FB_DATATYPE_USHORT, _   '' wchar
		FB_FUNCMODE_STDCALL, _  '' fbcall
		FB_FUNCMODE_STDCALL, _  '' stdcall
		0   or FB_TARGETOPT_EXPORT _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_COFF _
	), _
	( _
		@"cygwin", _
		FB_DATATYPE_USHORT, _
		FB_FUNCMODE_STDCALL, _
		FB_FUNCMODE_STDCALL, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_EXPORT _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_COFF _
	), _
	( _
		@"linux", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_STACKALIGN16 _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"dos", _
		FB_DATATYPE_UBYTE, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_COFF _
	), _
	( _
		@"xbox", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_STDCALL, _
		FB_FUNCMODE_STDCALL, _
		0   or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_COFF _
	), _
	( _
		@"freebsd", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_RETURNINFLTS _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"dragonfly", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"solaris", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"openbsd", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_RETURNINFLTS _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"darwin", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_STACKALIGN16 _
			or FB_TARGETOPT_MACHO _
	), _
	( _
		@"netbsd", _
		FB_DATATYPE_ULONG, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_RETURNINFLTS _
			or FB_TARGETOPT_ELF _
	), _
	( _
		@"js", _
		FB_DATATYPE_USHORT, _   '' wchar
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		0   or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
	) _
}

type FBCPUFAMILYINFO
	id as zstring ptr
	defaultcputype as integer
end type

dim shared as FBCPUFAMILYINFO cpufamilyinfo(0 to FB_CPUFAMILY__COUNT-1) = _
{ _
	(@"x86"        , FB_DEFAULT_CPUTYPE_X86    ), _
	(@"x86_64"     , FB_DEFAULT_CPUTYPE_X86_64 ), _
	(@"arm"        , FB_DEFAULT_CPUTYPE_ARM    ), _
	(@"aarch64"    , FB_DEFAULT_CPUTYPE_AARCH64), _
	(@"powerpc"    , FB_DEFAULT_CPUTYPE_PPC    ), _
	(@"powerpc64"  , FB_DEFAULT_CPUTYPE_PPC64  ), _
	(@"powerpc64le", FB_DEFAULT_CPUTYPE_PPC64LE), _
	(@"asmjs"      , FB_DEFAULT_CPUTYPE_ASMJS  )  _
}

type FBCPUTYPEINFO
	gccarch     as zstring ptr  '' gcc -march argument (used for -gen gcc), or NULL if same as fbcarch
	fbcarch     as zstring ptr  '' fbc -arch argument
	family      as integer      '' enum FB_CPUFAMILY
	bits        as integer      '' 32 or 64
	bigendian   as integer      '' endianness - TRUE=big endian, FALSE=little endian
end type

dim shared as FBCPUTYPEINFO cputypeinfo(0 to FB_CPUTYPE__COUNT-1) = _
{ _
	( @"i386"    , @"386"          , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_386
	( @"i486"    , @"486"          , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_486
	( @"i586"    , @"586"          , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_586
	( @"i686"    , @"686"          , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_686
	( NULL       , @"athlon"       , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_ATHLON
	( NULL       , @"athlon-xp"    , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_ATHLONXP
	( NULL       , @"athlon-fx"    , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_ATHLONFX
	( NULL       , @"k8-sse3"      , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_ATHLONSSE3
	( NULL       , @"pentium-mmx"  , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_PENTIUMMMX
	( NULL       , @"pentium2"     , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_PENTIUM2
	( NULL       , @"pentium3"     , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_PENTIUM3
	( NULL       , @"pentium4"     , FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_PENTIUM4
	( @"prescott", @"pentium4-sse3", FB_CPUFAMILY_X86    , 32, FALSE ), _ '' FB_CPUTYPE_PENTIUMSSE3
	( NULL       , @"x86-64"       , FB_CPUFAMILY_X86_64 , 64, FALSE ), _ '' FB_CPUTYPE_X86_64
	( NULL       , @"armv6"        , FB_CPUFAMILY_ARM    , 32, FALSE ), _ '' FB_CPUTYPE_ARMV6
	( NULL       , @"armv7-a"      , FB_CPUFAMILY_ARM    , 32, FALSE ), _ '' FB_CPUTYPE_ARMV7A
	( @"armv8-a" , @"aarch64"      , FB_CPUFAMILY_AARCH64, 64, FALSE ), _ '' FB_CPUTYPE_AARCH64
	( NULL       , @"powerpc"      , FB_CPUFAMILY_PPC    , 32, TRUE  ), _ '' FB_CPUTYPE_PPC
	( NULL       , @"powerpc64"    , FB_CPUFAMILY_PPC64  , 64, TRUE  ), _ '' FB_CPUTYPE_PPC64
	( NULL       , @"powerpc64le"  , FB_CPUFAMILY_PPC64LE, 64, FALSE ), _ '' FB_CPUTYPE_PPC64LE
	( NULL       , @"asmjs"        , FB_CPUFAMILY_ASMJS  , 32, FALSE )  _ '' FB_CPUTYPE_ASMJS
}

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' interface
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hFindIncFile _
	( _
		byval incfilehash as THASH ptr, _
		byval filename as zstring ptr _
	) as zstring ptr static

	dim as string fname

#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
	fname = ucase( *filename )
#else
	fname = *filename
#endif

	function = hashLookup( incfilehash, fname )

end function

'' Add a string to filenamehash if missing, and add a copy of the filenamehash
'' entry to incfilehash if missing, unless incfilehash is NULL.
'' Invariant: incfilehash is a subset of filenamehash.
private function hAddIncFile _
	( _
		byval incfilehash as THASH ptr, _
		byval filenamehash as THASH ptr, _
		byval filename as zstring ptr _
	) as zstring ptr static

	dim as zstring ptr fname, res
	dim as uinteger index

	fname = xallocate( len( *filename ) + 1 )
#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
	hUcase( filename, fname )
#else
	*fname = *filename
#endif

	index = hashHash( fname )

	res = hashLookupEx( filenamehash, fname, index )
	if( res = NULL ) then
		hashAdd( filenamehash, fname, fname, index )
	else
		deallocate( fname )
		fname = res
	end if

	if( incfilehash ) then
		res = hashLookupEx( incfilehash, fname, index )
		if( res = NULL ) then
			hashAdd( incfilehash, fname, fname, index )
		end if
	end if

	function = fname
end function

'':::::
function fbGetLangOptions _
	( _
		byval lang as FB_LANG _
	) as FB_LANG_OPT

	function = langTb(lang).options

end function

'':::::
function fbGetLangName _
	( _
		byval lang as FB_LANG _
	) as string

	function = *langTb(lang).name

end function

'':::::
function fbGetBackendName _
	( _
		byval lang as FB_BACKEND _
	) as string

	select case env.clopt.backend
	case FB_BACKEND_GAS
		function = "gas"
	case FB_BACKEND_GCC
		function = "gcc"
	case FB_BACKEND_LLVM
		function = "llvm"
	case FB_BACKEND_GAS64
		function = "gas64"
	end select

end function

sub fbInit _
	( _
		byval ismain as integer, _
		byval entry as zstring ptr, _
		byval module_count as integer _
	)

	strsetInit( @env.libs, FB_INITLIBNODES \ 4 )
	strsetInit( @env.libpaths, FB_INITLIBNODES \ 4 )

	'' when starting a compile, reset the restart requests
	'' env.restart_status preserves state from previous runs
	''     and would have been initialized to 0 (FB_RESTART_NONE)
	''     but we need to clear the PARSER_LANG status because
	''     #lang directives should only apply to current module
	'' env.restart_count is preserved between runs (passes) so don't
	''    re-initialize it here.
	env.restart_request = FB_RESTART_NONE
	env.restart_action = FB_RESTART_NONE
	env.restart_status and= not (FB_RESTART_PARSER_LANG or FB_RESTART_PARSER_MT)

	redim infileTb( 0 to FB_MAXINCRECLEVEL-1 )

	env.includerec = 0
	env.main.proc = NULL
	env.entry = *entry
	env.module_count = module_count

	env.opt.explicit = (env.clopt.lang = FB_LANG_FB)

	'' data type remapping
	if( env.clopt.lang <> FB_LANG_QB ) then
		'' In FB, the INTEGER keyword produces FB_DATATYPE_INTEGER
		env.lang.integerkeyworddtype = FB_DATATYPE_INTEGER

		'' In FB, both 16bit/32bit number literals are made INTEGERs,
		'' and floats are DOUBLE by default.
		env.lang.int15literaldtype = FB_DATATYPE_INTEGER
		env.lang.int16literaldtype = FB_DATATYPE_UINT
		env.lang.int31literaldtype = FB_DATATYPE_INTEGER
		env.lang.int32literaldtype = FB_DATATYPE_UINT
		if( fbIs64bit( ) ) then
			env.lang.int63literaldtype = FB_DATATYPE_INTEGER
			env.lang.int64literaldtype = FB_DATATYPE_UINT
		else
			env.lang.int63literaldtype = FB_DATATYPE_LONGINT
			env.lang.int64literaldtype = FB_DATATYPE_ULONGINT
		end if
		env.lang.floatliteraldtype = FB_DATATYPE_DOUBLE
	else
		'' In QB, the INTEGER keyword produces FB_DATATYPE_SHORT
		'' (Note: FB_DATATYPE_INTEGER remains unchanged, it's just that
		'' FB_DATATYPE_SHORT is being used instead in some places)
		env.lang.integerkeyworddtype = FB_DATATYPE_SHORT

		'' In QB, 16bit number literals are made SHORTs (i.e. QB's
		'' 16bit INTEGERs), and 32bit number literals are 32bit LONGs,
		'' not FB 32bit/64bit INTEGERs. Floats are SINGLEs by default.
		env.lang.int15literaldtype = FB_DATATYPE_SHORT
		env.lang.int16literaldtype = FB_DATATYPE_USHORT
		env.lang.int31literaldtype = FB_DATATYPE_LONG
		env.lang.int32literaldtype = FB_DATATYPE_ULONG
		env.lang.int63literaldtype = FB_DATATYPE_LONGINT
		env.lang.int64literaldtype = FB_DATATYPE_ULONGINT
		env.lang.floatliteraldtype = FB_DATATYPE_SINGLE
	end if

	env.opt.parammode       = FB_PARAMMODE_BYREF
	env.opt.procpublic      = TRUE
	env.opt.escapestr       = FALSE
	env.opt.dynamic         = FALSE
	env.opt.base = 0
	env.opt.gosub = (env.clopt.lang = FB_LANG_QB)

	env.fbctinf_started = FALSE

	'' Leading underscore needed on ASM symbols?
	'' Yes for dos/cygwin-x86/win32/xbox, but not win64/cygwin-x86_64/linux-*/etc.
	env.underscoreprefix = FALSE
	select case( env.clopt.target )
	case FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX, FB_COMPTARGET_DARWIN
		env.underscoreprefix = TRUE
	case FB_COMPTARGET_CYGWIN, FB_COMPTARGET_WIN32
		env.underscoreprefix = not fbIs64bit( )
	end select

	'' set by symbDataInit()
	env.pointersize = 0

	parserSetCtx( )
	symbInit( ismain )
	errInit( )
	astInit( )
	irInit( )

	'' After symbInit(), we can use typeGetSize()
	env.wchar_doconv = (sizeof( wstring ) = typeGetSize( env.target.wchar ))

	hashInit( @env.filenamehash, FB_INITINCFILES )
	hashInit( @env.incfilehash, FB_INITINCFILES, FALSE )
	hashInit( @env.inconcehash, FB_INITINCFILES, FALSE )

	stackNew( @parser.stmt.stk, FB_INITSTMTSTACKNODES, len( FB_CMPSTMTSTK ), FALSE )
	lexInit( FALSE, FALSE )
	parserInit( )
	rtlInit( )

	'' env.inited indicates that lexer/parser/compiler/rtl is initialized
	'' intent is to help debug internal functions where we general want to
	'' ignore function calls (breakpoints) while fbc itself is starting up
	env.inited = TRUE
end sub

sub fbEnd()
	env.inited = FALSE
	rtlEnd( )
	parserEnd( )
	lexEnd( )
	stackFree( @parser.stmt.stk )

	hashEnd( @env.filenamehash )
	hashEnd( @env.inconcehash )
	hashEnd( @env.incfilehash )

	irEnd( )
	astEnd( )
	errEnd( )
	symbEnd( )

	erase infileTb
	strsetEnd(@env.libs)
	strsetEnd(@env.libpaths)
end sub

private sub hUpdateLangOptions( )
	env.lang.opt = langTb(env.clopt.lang).options
end sub

private sub hUpdateTargetOptions( )
	env.target = targetinfo(env.clopt.target)
	if( env.clopt.returninflts ) then
		env.target.options or= FB_TARGETOPT_RETURNINFLTS
	end if
end sub

sub fbGlobalInit()
	strlistInit(@env.predefines, FB_INITINCFILES)
	strlistInit(@env.preincludes, FB_INITINCFILES)
	strlistInit(@env.includepaths, FB_INITINCFILES)

	'' default settings
	env.clopt.outtype       = FB_DEFAULT_OUTTYPE
	env.clopt.pponly        = FALSE

	env.clopt.backend       = FB_DEFAULT_BACKEND
	env.clopt.target        = FB_DEFAULT_TARGET
	env.clopt.cputype       = FB_DEFAULT_CPUTYPE
	env.clopt.fputype       = FB_DEFAULT_FPUTYPE
	env.clopt.fpmode        = FB_DEFAULT_FPMODE
	env.clopt.vectorize     = FB_DEFAULT_VECTORIZELEVEL
	env.clopt.optlevel      = 0
	env.clopt.asmsyntax     = FB_ASMSYNTAX_INTEL

	env.clopt.lang          = FB_DEFAULT_LANG
	env.clopt.forcelang     = FALSE

	env.clopt.debug         = FALSE
	env.clopt.debuginfo     = FALSE
	env.clopt.assertions    = FALSE
	env.clopt.errorcheck    = FALSE
	env.clopt.extraerrchk   = FALSE
	env.clopt.errlocation   = FALSE
	env.clopt.arrayboundchk = FALSE
	env.clopt.nullptrchk    = FALSE
	env.clopt.unwindinfo    = FALSE
	env.clopt.resumeerr     = FALSE
	env.clopt.profile       = FALSE

	env.clopt.warninglevel  = FB_WARNINGMSGS_DEFAULT_LEVEL
	env.clopt.showerror     = TRUE
	env.clopt.maxerrors     = FB_DEFAULT_MAXERRORS
	env.clopt.pdcheckopt    = FB_PDCHECK_NONE

	env.clopt.gosubsetjmp   = FALSE
	env.clopt.export        = FALSE
	env.clopt.multithreaded = FALSE
	env.clopt.gfx           = FALSE
	env.clopt.pic           = FALSE
	env.clopt.msbitfields   = FALSE
	env.clopt.stacksize     = 0 '' default will be set by fbSetOption() called from hParseArgs()
	env.clopt.objinfo       = TRUE
	env.clopt.showincludes  = FALSE
	env.clopt.modeview      = FB_DEFAULT_MODEVIEW
	env.clopt.nocmdline     = FALSE
	env.clopt.returninflts  = FALSE

	env.restart_request     = FB_RESTART_NONE
	env.restart_action      = FB_RESTART_NONE
	env.restart_status      = FB_RESTART_NONE
	env.restart_lang        = FB_LANG_INVALID
	env.restart_count       = 0

	env.module_count        = 0

	hUpdateLangOptions( )
	hUpdateTargetOptions( )
end sub

sub fbAddIncludePath(byref path as string)
	strlistAppend(@env.includepaths, path)
end sub

sub fbAddPreDefine(byref def as string)
	strlistAppend(@env.predefines, def)
end sub

sub fbAddPreInclude(byref file as string)
	strlistAppend(@env.preincludes, file)
end sub

sub fbSetOption( byval opt as integer, byval value as integer )
	select case as const( opt )
	case FB_COMPOPT_OUTTYPE
		env.clopt.outtype = value
	case FB_COMPOPT_PPONLY
		env.clopt.pponly = value

	case FB_COMPOPT_BACKEND
		env.clopt.backend = value
	case FB_COMPOPT_TARGET
		env.clopt.target = value
		hUpdateTargetOptions( )
	case FB_COMPOPT_CPUTYPE
		env.clopt.cputype = value
	case FB_COMPOPT_FPUTYPE
		env.clopt.fputype = value
	case FB_COMPOPT_FPMODE
		env.clopt.fpmode = value
	case FB_COMPOPT_VECTORIZE
		env.clopt.vectorize = value
	case FB_COMPOPT_OPTIMIZELEVEL
		env.clopt.optlevel = value
	case FB_COMPOPT_ASMSYNTAX
		env.clopt.asmsyntax = value

	case FB_COMPOPT_LANG
		env.clopt.lang = value
		hUpdateLangOptions( )
	case FB_COMPOPT_FORCELANG
		env.clopt.forcelang = value
	case FB_COMPOPT_RESTART_LANG
		env.restart_lang = value

	case FB_COMPOPT_DEBUG
		env.clopt.debug = value
	case FB_COMPOPT_DEBUGINFO
		env.clopt.debuginfo = value
	case FB_COMPOPT_ASSERTIONS
		env.clopt.assertions = value
	case FB_COMPOPT_ERRORCHECK
		env.clopt.errorcheck = value
	case FB_COMPOPT_RESUMEERROR
		env.clopt.resumeerr = value
	case FB_COMPOPT_EXTRAERRCHECK
		env.clopt.extraerrchk = value
	case FB_COMPOPT_ERRLOCATION
		env.clopt.errlocation = value
	case FB_COMPOPT_ARRAYBOUNDCHECK
		env.clopt.arrayboundchk = value
	case FB_COMPOPT_NULLPTRCHECK
		env.clopt.nullptrchk = value
	case FB_COMPOPT_UNWINDINFO
		env.clopt.unwindinfo = value
	case FB_COMPOPT_PROFILE
		env.clopt.profile = value

	case FB_COMPOPT_WARNINGLEVEL
		env.clopt.warninglevel = value
	case FB_COMPOPT_SHOWERROR
		env.clopt.showerror = value
	case FB_COMPOPT_MAXERRORS
		env.clopt.maxerrors = value
	case FB_COMPOPT_PEDANTICCHK
		env.clopt.pdcheckopt = value

	case FB_COMPOPT_GOSUBSETJMP
		env.clopt.gosubsetjmp = value
	case FB_COMPOPT_VALISTASPTR
		env.clopt.valistasptr = value
	case FB_COMPOPT_NOTHISCALL
		env.clopt.nothiscall = value
	case FB_COMPOPT_NOFASTCALL
		env.clopt.nofastcall = value
	case FB_COMPOPT_FBRT
		env.clopt.fbrt = value
	case FB_COMPOPT_EXPORT
		env.clopt.export = value
	case FB_COMPOPT_MSBITFIELDS
		env.clopt.msbitfields = value
	case FB_COMPOPT_MULTITHREADED
		env.clopt.multithreaded = value
	case FB_COMPOPT_GFX
		env.clopt.gfx = value
	case FB_COMPOPT_PIC
		env.clopt.pic = value
	case FB_COMPOPT_STACKSIZE
		'' check stacksize and value was never set yet?
		if( value < 0 ) then
			if( env.clopt.stacksize = 0 ) then
				env.clopt.stacksize = iif( fbIs64bit(), FB_DEFSTACKSIZE64, FB_DEFSTACKSIZE32 )
			end if
		else
			'' ensure current stacksize is at least the minimum size
			if( fbIs64bit() ) then
				env.clopt.stacksize = iif( value < FB_MINSTACKSIZE64, FB_MINSTACKSIZE64, value )
			else
				env.clopt.stacksize = iif( value < FB_MINSTACKSIZE32, FB_MINSTACKSIZE32, value )
			end if
		end if
	case FB_COMPOPT_OBJINFO
		env.clopt.objinfo = value
	case FB_COMPOPT_SHOWINCLUDES
		env.clopt.showincludes = value
	case FB_COMPOPT_MODEVIEW
		env.clopt.modeview = value
	case FB_COMPOPT_NOCMDLINE
		env.clopt.nocmdline = value
	case FB_COMPOPT_RETURNINFLTS
		env.clopt.returninflts = value
		hUpdateTargetOptions( )
	end select
end sub

function fbGetOption( byval opt as integer ) as integer
	select case as const( opt )
	case FB_COMPOPT_OUTTYPE
		function = env.clopt.outtype
	case FB_COMPOPT_PPONLY
		function = env.clopt.pponly

	case FB_COMPOPT_BACKEND
		function = env.clopt.backend
	case FB_COMPOPT_TARGET
		function = env.clopt.target
	case FB_COMPOPT_CPUTYPE
		function = env.clopt.cputype
	case FB_COMPOPT_FPUTYPE
		function = env.clopt.fputype
	case FB_COMPOPT_FPMODE
		function = env.clopt.fpmode
	case FB_COMPOPT_VECTORIZE
		function = env.clopt.vectorize
	case FB_COMPOPT_OPTIMIZELEVEL
		function = env.clopt.optlevel
	case FB_COMPOPT_ASMSYNTAX
		function = env.clopt.asmsyntax

	case FB_COMPOPT_LANG
		function = env.clopt.lang
	case FB_COMPOPT_FORCELANG
		function = env.clopt.forcelang
	case FB_COMPOPT_RESTART_LANG
		function = env.restart_lang

	case FB_COMPOPT_DEBUG
		function = env.clopt.debug
	case FB_COMPOPT_DEBUGINFO
		function = env.clopt.debuginfo
	case FB_COMPOPT_ASSERTIONS
		function = env.clopt.assertions
	case FB_COMPOPT_ERRORCHECK
		function = env.clopt.errorcheck
	case FB_COMPOPT_RESUMEERROR
		function = env.clopt.resumeerr
	case FB_COMPOPT_EXTRAERRCHECK
		function = env.clopt.extraerrchk
	case FB_COMPOPT_ERRLOCATION
		function = env.clopt.errlocation
	case FB_COMPOPT_ARRAYBOUNDCHECK
		function = env.clopt.arrayboundchk
	case FB_COMPOPT_NULLPTRCHECK
		function = env.clopt.nullptrchk
	case FB_COMPOPT_UNWINDINFO
		function = env.clopt.unwindinfo
	case FB_COMPOPT_PROFILE
		function = env.clopt.profile

	case FB_COMPOPT_WARNINGLEVEL
		function = env.clopt.warninglevel
	case FB_COMPOPT_SHOWERROR
		function = env.clopt.showerror
	case FB_COMPOPT_MAXERRORS
		function = env.clopt.maxerrors
	case FB_COMPOPT_PEDANTICCHK
		function = env.clopt.pdcheckopt

	case FB_COMPOPT_GOSUBSETJMP
		function = env.clopt.gosubsetjmp
	case FB_COMPOPT_VALISTASPTR
		function = env.clopt.valistasptr
	case FB_COMPOPT_NOTHISCALL
		function = env.clopt.nothiscall
	case FB_COMPOPT_NOFASTCALL
		function = env.clopt.nofastcall
	case FB_COMPOPT_FBRT
		function = env.clopt.fbrt
	case FB_COMPOPT_EXPORT
		function = env.clopt.export
	case FB_COMPOPT_MSBITFIELDS
		function = env.clopt.msbitfields
	case FB_COMPOPT_MULTITHREADED
		function = env.clopt.multithreaded
	case FB_COMPOPT_GFX
		function = env.clopt.gfx
	case FB_COMPOPT_PIC
		function = env.clopt.pic
	case FB_COMPOPT_STACKSIZE
		function = env.clopt.stacksize
	case FB_COMPOPT_OBJINFO
		function = env.clopt.objinfo
	case FB_COMPOPT_SHOWINCLUDES
		function = env.clopt.showincludes
	case FB_COMPOPT_MODEVIEW
		function = env.clopt.modeview
	case FB_COMPOPT_NOCMDLINE
		function = env.clopt.nocmdline
	case FB_COMPOPT_RETURNINFLTS
		function = env.clopt.returninflts

	case else
		function = 0
	end select
end function

'':::::
sub fbChangeOption(byval opt as integer, byval value as integer)
	select case as const opt
	case FB_COMPOPT_MSBITFIELDS
		fbSetOption( opt, value )

	case FB_COMPOPT_LANG
		'' If not yet in the desired mode
		if( value <> fbGetOption( opt ) ) then
			'' Not module level? then error
			if( parser.scope <> FB_MAINSCOPE ) then

				if( fbIsModLevel( ) = FALSE ) then
					errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
				else
					errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
				end if

			'' module level
			else
				'' If -forcelang is enabled, ignore #lang directives
				if( env.clopt.forcelang ) then
					errReportWarn( FB_WARNINGMSG_CMDLINEOVERRIDES )
				else

					'' Never restarted due to #lang?
					if( ( env.restart_status and FB_RESTART_PARSER_LANG ) = 0 ) then
						fbSetOption( opt, value )

						'' Tell parser to restart as soon as possible
						fbRestartBeginRequest( FB_RESTART_PARSER_LANG )
						fbRestartAcceptRequest( FB_RESTART_PARSER_LANG )

						'' and don't show any more errors until we've restarted
						errHideFurtherErrors()

					'' Second pass? Show a warning and ignore
					else
						errReportWarn( FB_WARNINGMSG_DIRECTIVEIGNORED )
					end if

				end if

			end if

		end if

	case else
		errReport( FB_ERRMSG_INTERNAL )

	end select
end sub

'':::::
function fbIsCrossComp _
	( _
	) as integer

	function = (env.clopt.target <> FB_DEFAULT_TARGET)

end function

'' Build the FB target name for the given OS/arch combination.
private function hGetTargetId _
	( _
		byval os as integer, _      '' FB_COMPTARGET_*
		byval cputype as integer _  '' FB_CPUTYPE_*
	) as string

	'' Target names for bin/ and lib/ subdirectories, display to the user
	'' (fbc compiled for ...), FB release package names, etc.
	''
	'' Before 64bit/ARM support was added, FB simply used
	''    dos
	''    win32
	''    linux
	''    freebsd
	''    ...
	''
	'' but nowadays we want to support 64bit and ARM and potentially more,
	'' and the target names should be unique, so that the lib/ directories
	'' can co-exist for cross-compiling. These names are also useful for
	'' FB release packages, and they can be shown to the user if fbc wants
	'' to tell about host/target systems (e.g. in -v output), etc.
	''    dos
	''    win32
	''    win64
	''    xbox
	''    linux-x86
	''    linux-x86_64
	''    linux-arm
	''    linux-aarch64
	''    freebsd-x86
	''    freebsd-x86_64
	''    freebsd-powerpc | freebsd-ppc
	''    freebsd-powerpc64 | freebsd-ppc64
	''    freebsd-powerpc64le | freebsd-ppc64le
	''    ...

	var cpufamily = cputypeinfo(cputype).family
	var osid = *targetinfo(os).id

	'' win32/dos/xbox
	select case( os )
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_DOS, FB_COMPTARGET_XBOX
		if( cpufamily = FB_CPUFAMILY_X86 ) then
			return osid
		end if
	end select

	'' win64
	if( (os = FB_COMPTARGET_WIN32) and (cpufamily = FB_CPUFAMILY_X86_64) ) then
		return "win64"
	end if

	'' linux-x86, linux-x86_64, etc.
	function = osid + "-" + *cpufamilyinfo(cpufamily).id
end function

function fbGetTargetId( ) as string
	function = hGetTargetId( env.clopt.target, env.clopt.cputype )
end function

function fbGetHostId( ) as string
	function = hGetTargetId( FB_DEFAULT_TARGET, FB_DEFAULT_CPUTYPE )
end function

function fbIdentifyOs( byref osid as string ) as integer
	for i as integer = 0 to FB_COMPTARGETS-1
		if( osid = *targetinfo(i).id ) then
			return i
		end if
	next
	function = -1
end function

function fbIdentifyCpuFamily( byref cpufamilyid as string ) as integer
	for i as integer = 0 to FB_CPUFAMILY__COUNT-1
		if( cpufamilyid = *cpufamilyinfo(i).id ) then
			return i
		end if
	next
	function = -1
end function

function fbCpuTypeFromCpuFamilyId( byref cpufamilyid as string ) as integer
	var cpufamily = fbIdentifyCpuFamily( cpufamilyid )
	if( cpufamily >= 0 ) then
		return cpufamilyinfo(cpufamily).defaultcputype
	end if
	function = -1
end function

function fbGetGccArch( ) as zstring ptr
	dim as zstring ptr gccarch = any
	gccarch = cputypeinfo(env.clopt.cputype).gccarch
	if( gccarch = NULL ) then
		gccarch = cputypeinfo(env.clopt.cputype).fbcarch
	end if
	function = gccarch
end function

function fbGetFbcArch( ) as zstring ptr
	function = cputypeinfo(env.clopt.cputype).fbcarch
end function

function fbIs64Bit( ) as integer
	function = (fbGetBits( ) = 64)
end function

function fbGetBits( ) as integer
	function = cputypeinfo(env.clopt.cputype).bits
end function

function fbGetHostBits( ) as integer
	function = cputypeinfo(FB_DEFAULT_CPUTYPE).bits
end function

function fbGetCpuFamily( ) as integer
	function = cputypeinfo(env.clopt.cputype).family
end function

function fbIsHostBigEndian( ) as integer
	function = cputypeinfo(env.clopt.cputype).bigendian
end function

function fbIdentifyFbcArch( byref fbcarch as string ) as integer
	select case( fbcarch )
	case "native"
		'' On x86 we can check fb_CpuDetect(), otherwise just use the
		'' default, which is always safe for the host.
		function = FB_DEFAULT_CPUTYPE

		#if (not defined( __FB_64BIT__ )) and defined( __FB_X86__ )
			select case( fb_CpuDetect( ) shr 28 )
			case 3 : function = FB_CPUTYPE_386
			case 4 : function = FB_CPUTYPE_486
			case 5 : function = FB_CPUTYPE_586
			case 6 : function = FB_CPUTYPE_686
			end select
		#endif

		exit function

	case "32"
		return FB_DEFAULT_CPUTYPE32
	case "64"
		return FB_DEFAULT_CPUTYPE64
	end select

	for i as integer = 0 to FB_CPUTYPE__COUNT-1
		if( *cputypeinfo(i).fbcarch = fbcarch ) then
			return i
		end if
	next

	'' Extra names to be recognized by -arch to make it nicer to use
	select case( fbcarch )
	case "x86_64", "amd64"
		function = FB_CPUTYPE_X86_64
	case else
		function = -1
	end select
end function

function fbTargetSupportsELF( ) as integer
	return ((env.target.options and FB_TARGETOPT_ELF) <> 0)
end function

function fbTargetSupportsCOFF( ) as integer
	return ((env.target.options and FB_TARGETOPT_COFF) <> 0)
end function

function fbTargetSupportsMachO( ) as integer
	return ((env.target.options and FB_TARGETOPT_MACHO) <> 0)
end function

'':::::
function fbGetEntryPoint( ) as string static

	'' If overridden with -entry
	if( len(env.entry) ) then
		return env.entry
	end if

	'' All targets use main(), except for xbox...
	if (env.clopt.target = FB_COMPTARGET_XBOX) then
		function = "XBoxStartup"
	else
		function = "main"
	end if

end function

'':::::
function fbGetModuleEntry( ) as string static
	dim as string sname

	sname = hStripPath( hStripExt( env.outf.name ) )

	hClearName( sname )

	function = "fb_ctor__" + sname

end function

function fbGetInputFileParentDir( ) as string
	dim as string s

	'' Input file name is using a relative path?
	if( pathIsAbsolute( env.inf.name ) = FALSE ) then
		'' Then build the absolute path based on curdir()
		s = hCurDir( ) + FB_HOST_PATHDIV
	end if

	function = pathStripDiv( hStripFilename( s + env.inf.name ) )
end function

'' Used to add libs found during parsing (#inclib, Lib "...", rtl-* callbacks)
sub fbAddLib(byval libname as zstring ptr)

	'' gfx library?
	if( *libname = "fbgfx?" ) then
		'' Special handling for "fbgfx" and "fbgfxmt" because
		'' depending on order of modules given on the cmd line
		'' multithreading may have been set after fbgfx.bi was
		'' included, and we can't have both libs passed to the
		'' linker. We can end up linking to the non-threaded
		'' version of fbgfx when we would expect the mt versoin
		'' and the linker won't complain even when both versions
		'' are passed.

		'' Set the -gfx option to link to the gfx library
		'' and the lib will be added in hAddDefaultLibs()
		fbSetOption( FB_COMPOPT_GFX, TRUE )

		exit sub
	end if

	strsetAdd(@env.libs, *libname, FALSE)
end sub

sub fbAddLibPath(byval path as zstring ptr)
	strsetAdd(@env.libpaths, pathStripDiv(*path), FALSE)
end sub

private sub fbParsePreDefines()
	dim as string defid, deftext
	dim as string ptr def = listGetHead(@env.predefines)
	while (def)
		dim as integer idlength = instr(*def, "=") - 1
		if (idlength < 0) then
			idlength = len(*def)
		end if

		defid = left(*def, idlength)
		deftext = right(*def, len(*def) - idlength - 1)

		'' If no text was given, default to '1'
		'' (this also means that it's not possible to make
		'' empty defines with -d)
		if (len(deftext) = 0) then
			deftext = "1"
		end if

		'' TODO: Check for invalid identifier and duplicated definition
		symbAddDefine(defid, deftext, len(deftext))

		def = listGetNext(def)
	wend
end sub

private sub fbParsePreIncludes()
	dim as string ptr file = listGetHead(@env.preincludes)
	while ((file <> NULL) and fbShouldContinue())
		fbIncludeFile(*file, TRUE)
		file = listGetNext(file)
	wend
end sub

private sub hAppendFbctinf( byval value as const zstring ptr )
	if( env.fbctinf_started = FALSE ) then
		env.fbctinf_started = TRUE
		irEmitFBCTINFBEGIN( )
	end if
	irEmitFBCTINFSTRING( value )
end sub

private sub hEmitObjinfo( )
	dim as TSTRSETITEM ptr i = any

	'' This must follow the format used by objinfo.bas:objinfoRead*().
	'' We want to emit the .fbctinf section only if there is any meta data
	'' to put into it.
	assert( env.fbctinf_started = FALSE )

	'' libs
	i = listGetHead( @env.libs.list )
	while( i )
		'' Not default?
		if( i->userdata = FALSE ) then
			hAppendFbctinf( objinfoEncode( OBJINFO_LIB ) )
			hAppendFbctinf( i->s )
		end if
		i = listGetNext( i )
	wend

	'' libpaths
	i = listGetHead( @env.libpaths.list )
	while( i )
		'' Not default?
		if( i->userdata = FALSE ) then
			hAppendFbctinf( objinfoEncode( OBJINFO_LIBPATH ) )
			hAppendFbctinf( *hEscape( i->s ) )
		end if
		i = listGetNext( i )
	wend

	'' -mt
	if( env.clopt.multithreaded ) then
		hAppendFbctinf( objinfoEncode( OBJINFO_MT ) )
	end if

	'' -gfx
	if( env.clopt.gfx ) then
		hAppendFbctinf( objinfoEncode( OBJINFO_GFX ) )
	end if

	'' -lang
	'' not the default -lang mode?
	if( env.clopt.lang <> FB_LANG_FB ) then
		hAppendFbctinf( objinfoEncode( OBJINFO_LANG ) )
		hAppendFbctinf( fbGetLangName( env.clopt.lang ) )
	end if

	if( env.fbctinf_started ) then
		irEmitFBCTINFEND( )
	end if
end sub

'' Print one line of -showincludes output
private sub hShowInclude( byval includelevel as integer, byref message as string )
	'' Show message with the proper indentation
	dim ln as string
	for i as integer = 1 to includelevel
		ln += " |  "
	next
	ln += message
	print ln
end sub

private sub hOnSkippedFile( byref filename as string )
	if( env.clopt.showincludes ) then
		hShowInclude( env.includerec + 1, "(" + pathStripCurdir( filename ) + ")" )
	end if
end sub

sub fbCompile _
	( _
		byval infname as zstring ptr, _
		byval outfname as zstring ptr, _
		byref pponlyfile as string, _
		byval ismain as integer _
	)

	env.inf.name = *infname
	hReplaceSlash( env.inf.name, asc( FB_HOST_PATHDIV ) )
	env.inf.incfile = hAddIncFile( NULL, @env.filenamehash, env.inf.name )
	env.inf.ismain = ismain

	env.outf.name = *outfname
	env.outf.ismain = ismain

	'' open source file
	if( hFileExists( *infname ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, infname, -1 )
		exit sub
	end if

	env.inf.num = freefile
	if( open( *infname, for binary, access read, as #env.inf.num ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit sub
	end if

	if( env.clopt.showincludes ) then
		'' Toplevel file
		hShowInclude( 0, pathStripCurdir( *infname ) )
	end if

	env.inf.format = hCheckFileFormat( env.inf.num )

	''
	if( irEmitBegin( ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, env.outf.name, -1 )
		exit sub
	end if

	if( fbGetOption( FB_COMPOPT_PPONLY ) ) then
		env.ppfile_num = freefile( )
		if( open( pponlyfile, for output, as #env.ppfile_num ) <> 0 ) then
			errReportEx( FB_ERRMSG_FILEACCESSERROR, pponlyfile, -1 )
			exit sub
		end if
	else
		env.ppfile_num = 0
	end if

	fbMainBegin( )

	fbParsePreDefines()
	fbParsePreIncludes()
	if (fbShouldContinue()) then
		cProgram()
	end if

	fbMainEnd( )

	'' compiling only, not cross-compiling?
	if( fbGetOption( FB_COMPOPT_OBJINFO ) and _
		(not fbIsCrossComp( )) and _
		(env.clopt.outtype = FB_OUTTYPE_OBJECT) ) then
		'' store libs, paths and cmd-line options in the obj
		hEmitObjinfo( )
	end if

	'' save
	irEmitEnd( )

	if( env.ppfile_num > 0 ) then
		close #env.ppfile_num
	end if

	close #env.inf.num

	'' check if any label undefined was used
	if (fbShouldContinue()) then
		symbCheckLabels(symbGetGlobalTbHead())
	end if
end sub

function fbShouldRestart() as integer

	'' missing #cmdline "-end" ?
	'' have a request to restart due to #cmdline?
	if( (env.restart_request and FB_RESTART_CMDLINE ) <> 0 ) then

		'' but we didn't have any restart yet?
		if( (env.restart_status and FB_RESTART_CMDLINE) = 0 ) then

			'' tell parser / fbc to restart as soon as possible
			fbRestartAcceptRequest( FB_RESTART_CMDLINE )

			'' and don't show any more errors until we've restarted
			errHideFurtherErrors()

			return TRUE
		endif
	end if

	return (env.restart_action <> FB_RESTART_NONE)
end function

function fbShouldContinue() as integer
	return ((env.restart_action = FB_RESTART_NONE) and (errGetCount() < env.clopt.maxerrors))
end function

sub fbRestartBeginRequest( byval flags as FB_RESTART_FLAGS )
	env.restart_request or= flags
end sub

sub fbRestartAcceptRequest( byval filter as FB_RESTART_FLAGS )
	'' only restart if we need a restart
	if( (env.restart_request and filter) <> 0 ) then
		'' and only if we haven't already restarted
		if( (env.restart_status and env.restart_request and filter) = 0 ) then
			env.restart_action or= (env.restart_request and filter)
		end if
	end if
	'' clear the request
	env.restart_request and= not filter
end sub

sub fbRestartEndRequest( byval filter as FB_RESTART_FLAGS )
	'' update status, action is completed
	env.restart_status or= (env.restart_action and filter)

	env.restart_count += 1

	'' clear the action
	env.restart_action and= not filter
end sub

function fbRestartGetCount() as integer
	return env.restart_count
end function

sub fbSetLibs(byval libs as TSTRSET ptr, byval libpaths as TSTRSET ptr)
	strsetCopy(@env.libs, libs)
	strsetCopy(@env.libpaths, libpaths)
end sub

sub fbGetLibs(byval libs as TSTRSET ptr, byval libpaths as TSTRSET ptr)
	strsetCopy(libs, @env.libs)
	strsetCopy(libpaths, @env.libpaths)
end sub

sub fbPragmaOnce()
	if( env.inf.name > "" ) then
		if( hFindIncFile( @env.inconcehash, env.inf.name ) = NULL ) then
			hAddIncFile( @env.inconcehash, @env.filenamehash, env.inf.name )
		end if
	end if
end sub

''::::
private function is_rootpath( byref path as zstring ptr ) as integer

	function = FALSE

	if( path = NULL ) then
		exit function
	end if

#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
	if( path[1] = asc(":") ) then
		function = TRUE
	end if
	if( (path[0] = asc("/")) or (path[0] = asc(RSLASH)) ) then
		'' UNC?
		if( (path[1] = asc("/")) or (path[1] = asc(RSLASH)) ) then
			function = TRUE
		else
			'' quirky drive letters...
			*path = left( fbGetInputFileParentDir( ), 1 ) + ":" + *path
			function = TRUE
		end if
	end if
#else
	function = (path[0] = asc("/"))
#endif
end function

''::::
private function get_rootpath_len( byval path as zstring ptr ) as integer

	'' returns number of characters in the root_path
	'' assuming that 'path' is already been made a
	'' root path.

	function = 0

	if( path[0] = NULL ) then
		exit function
	end if

	'' {/}
	function = 1

#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )

	'' {d:/}
	if( path[1] = asc(":") ) then
		function = 3
	end if
	if( (path[0] = asc("/")) or (path[0] = asc(RSLASH)) ) then
		'' UNC?
		'' {//}server/share/
		if( (path[1] = asc("/")) or (path[1] = asc(RSLASH)) ) then
			function = 2
		end if

	end if

#endif

end function

''::::
private function solve_path( byval path as zstring ptr ) as integer

	'' solves a path to its lowest common denominator...
	'' c:\foo\bar\..\baz => c:\foo\baz, etc
	'' \\server\share\..\.\share2 => \\server\share2, etc

	static cidx(0 to FB_MAXPATHLEN \ 2) as integer = any
	dim as integer stk = any '' # components on the stack
	dim as integer s = any   '' starting index
	dim as integer n = any   '' # of chars in current component
	dim as integer d = any   '' # of .'s in the current component
	dim as integer r = any   '' index of char we are reading
	dim as integer w = any   '' index of char we are writing
	dim as integer c = any   '' current character

	'' set-up stack and don't touch the root path
	'' (root path is not on the stack)

	stk = 0
	s = get_rootpath_len( path )
	cidx(stk) = s
	w = s
	n = 0
	d = 0

	'' scan through the rest of the path
	for r = s to len( *path ) - 1

		c = path[r]

		'' ('/' | '\')?
		if( (c = asc("/")) or (c = asc(RSLASH)) ) then

			'' check component

			'' "//"?
			if( n = 0 ) then
				'' ignore

			'' "/./"?
			elseif( (d = 1) and (n = 1) ) then
				'' ignore
				w -= 1

			'' "/../"?
			elseif( (d = 2) and (n = 2) ) then
				'' pop a component from the stack
				if( stk ) then
					stk -= 1
				end if
				w = cidx( stk )

			else
				'' add char
				path[w] = c
				w += 1

				'' push a component on the stack
				stk += 1
				cidx(stk) = w

			end if

			'' reset counters
			n = 0
			d = 0

		else
			'' '.'?
			if( c = asc(".") ) then
				d += 1
			end if

			'' add char
			n += 1
			path[w] = c
			w += 1

		end if

	next

	path[w] = 0

	function = TRUE

end function

sub fbIncludeFile(byval filename as zstring ptr, byval isonce as integer)
	static as zstring * FB_MAXPATHLEN incfile
	dim as zstring ptr fileidx

	if( env.includerec >= FB_MAXINCRECLEVEL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
		errHideFurtherErrors()
		exit sub
	end if

	'' 1st) try finding it at same path as the current source-file
	incfile = hStripFilename( env.inf.name )
	incfile += *filename

	if( hFileExists( incfile ) = FALSE ) then

		'' 2nd) try as-is (could include an absolute or relative path)
		if( hFileExists( filename ) = FALSE ) then

			'' 3rd) try finding it at the inc paths
			dim as string ptr path = listGetHead(@env.includepaths)
			while (path)
				incfile = *path + FB_HOST_PATHDIV + *filename
				if (hFileExists(incfile)) then
					exit while
				end if
				path = listGetNext(path)
			wend

			'' not found?
			if (path = NULL) then
				if( env.clopt.showincludes ) then
					hShowInclude( env.includerec + 1, *filename + " (not found in include dirs)" )
				end if
				errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + *filename + QUOTE )
				errHideFurtherErrors()
				exit sub
			end if

		else
			incfile = *filename
		end if
	end if

	'' if this isn't a root path, make it one.
	if( is_rootpath( incfile ) = FALSE ) then
		incfile = hCurDir( ) + FB_HOST_PATHDIV + incfile
	end if

	'' now, if it isn't a root path(even possible?), we have a fatal.
	if( is_rootpath( incfile ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + incfile + QUOTE )
		errHideFurtherErrors()
		exit sub
	end if

	'' solve out the .. and .
	if( solve_path( incfile ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + incfile + QUOTE )
		errHideFurtherErrors()
		exit sub
	end if

	hReplaceSlash( incfile, asc( FB_HOST_PATHDIV ) )

	'' #include ONCE
	if( isonce ) then
		'' we should respect the path
		if( hFindIncFile( @env.incfilehash, incfile ) <> NULL ) then
			hOnSkippedFile( incfile )
			exit sub
		end if
	end if

	'' #pragma ONCE
	if( hFindIncFile( @env.inconcehash, incfile ) <> NULL ) then
		hOnSkippedFile( incfile )
		exit sub
	end if

	'' we should respect the path here too
	fileidx = hAddIncFile( @env.incfilehash, @env.filenamehash, incfile )

	'' push context
	infileTb(env.includerec) = env.inf
	env.includerec += 1

	env.inf.name  = incfile
	env.inf.incfile = fileidx

	if( env.clopt.showincludes ) then
		hShowInclude( env.includerec, pathStripCurdir( incfile ) )
	end if

	''
	env.inf.num = freefile
	if( open( incfile, for binary, access read, as #env.inf.num ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + *filename + QUOTE )
		errHideFurtherErrors()
		exit sub
	end if

	env.inf.format = hCheckFileFormat( env.inf.num )

	'' parse
	lexPushCtx( )

	lexInit( TRUE, FALSE )

	cProgram()

	lexPopCtx( )

	close #env.inf.num

	'' pop context
	env.includerec -= 1
	env.inf = infileTb( env.includerec )
end sub

'' Used by #line to change the effective filename of the current source file.
sub fbOverrideFilename(byval filename as zstring ptr)
	env.inf.name = *filename
	'' env.inf.incfile is an interned copy of env.inf.name (possibly up-cased),
	'' so must be updated too.
	env.inf.incfile = hAddIncFile( NULL, @env.filenamehash, filename )
end sub

'':::::
function fbGetLangId _
	( _
		byval txt as zstring ptr _
	) as FB_LANG

	select case lcase(*txt)
	case "fb"
		function = FB_LANG_FB
	case "deprecated"
		function = FB_LANG_FB_DEPRECATED
	case "fblite"
		function = FB_LANG_FB_FBLITE
	case "qb"
		function = FB_LANG_QB
	case else
		function = FB_LANG_INVALID
	end select

end function

'':::::
function fbGetBackendValistType _
	( _
	) as FB_CVA_LIST_TYPEDEF

	dim typedef as FB_CVA_LIST_TYPEDEF = FB_CVA_LIST_NONE

	select case env.clopt.backend
	case FB_BACKEND_GCC

		select case( fbGetCpuFamily( ) )
		case FB_CPUFAMILY_X86
			typedef = FB_CVA_LIST_BUILTIN_POINTER

		case FB_CPUFAMILY_X86_64
			select case env.clopt.target
			case FB_COMPTARGET_WIN32
				typedef = FB_CVA_LIST_BUILTIN_POINTER
			case else
				typedef = FB_CVA_LIST_BUILTIN_C_STD
			end select

		case FB_CPUFAMILY_ARM
			typedef = FB_CVA_LIST_BUILTIN_ARM

		case FB_CPUFAMILY_AARCH64
			typedef = FB_CVA_LIST_BUILTIN_AARCH64

		case FB_CPUFAMILY_PPC
			typedef = FB_CVA_LIST_BUILTIN_POINTER

		case FB_CPUFAMILY_PPC64, FB_CPUFAMILY_PPC64LE
			typedef = FB_CVA_LIST_BUILTIN_POINTER

		case else
			typedef = FB_CVA_LIST_BUILTIN_POINTER

		end select

	case FB_BACKEND_GAS
		typedef = FB_CVA_LIST_POINTER

	case FB_BACKEND_LLVM
		'' ???
		typedef = FB_CVA_LIST_POINTER

	case FB_BACKEND_GAS64
		'typedef = FB_CVA_LIST_BUILTIN_POINTER
		select case env.clopt.target
		case FB_COMPTARGET_WIN32
			typedef = FB_CVA_LIST_BUILTIN_POINTER
		case else
			typedef = FB_CVA_LIST_BUILTIN_C_STD
		end select

	case else
		typedef = FB_CVA_LIST_POINTER

	end select

	assert( typedef <> FB_CVA_LIST_NONE )

	'' on gcc backend we prefer that the cva_list type
	'' map to gcc's __builtin_va_list, which is a different
	'' type depending on platform. If the combination of
	'' target and arch support it, we can override this with
	'' -z valist-as-ptr to force use of pointer expressions
	'' instead of builtins even though gcc is backend.

	if( typedef = FB_CVA_LIST_BUILTIN_POINTER ) then
		if( fbGetOption( FB_COMPOPT_VALISTASPTR ) ) then
			typedef = FB_CVA_LIST_POINTER
		endif
	end if

	function = typedef

end function
