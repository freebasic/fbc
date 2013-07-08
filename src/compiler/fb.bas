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
	name		as const zstring ptr
	options		as FB_LANG_OPT
end type

declare sub	parserInit ( )

declare sub	parserEnd ( )

declare sub	parserSetCtx ( )

'' globals
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
		FB_DATATYPE_UINT, _     '' size_t
		FB_DATATYPE_USHORT, _   '' wchar
		FB_FUNCMODE_STDCALL, _  '' fbcall
		FB_FUNCMODE_STDCALL, _  '' stdcall
		FB_COMPTARGET_WIN64, _  '' "opposite" bits target
		0	or FB_TARGETOPT_UNDERSCORE _
			or FB_TARGETOPT_EXPORT _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"win64", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_USHORT, _
		FB_FUNCMODE_STDCALL, _
		FB_FUNCMODE_STDCALL, _
		FB_COMPTARGET_WIN32, _
		0	or FB_TARGETOPT_UNDERSCORE _
			or FB_TARGETOPT_EXPORT _
			or FB_TARGETOPT_RETURNINREGS _
			or FB_TARGETOPT_64BIT _
	), _
	( _
		@"cygwin", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_USHORT, _
		FB_FUNCMODE_STDCALL, _
		FB_FUNCMODE_STDCALL, _
		-1, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_UNDERSCORE _
			or FB_TARGETOPT_EXPORT _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"linux", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		FB_COMPTARGET_LINUX64, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
	), _
	( _
		@"linux64", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		FB_COMPTARGET_LINUX, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_64BIT _
	), _
	( _
		@"dos", _
		FB_DATATYPE_ULONG, _
		FB_DATATYPE_UBYTE, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		-1, _
		0	or FB_TARGETOPT_UNDERSCORE _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
	), _
	( _
		@"xbox", _
		FB_DATATYPE_ULONG, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_STDCALL, _
		FB_FUNCMODE_STDCALL, _
		-1, _
		0	or FB_TARGETOPT_UNDERSCORE _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"freebsd", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		-1, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"openbsd", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		-1, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"darwin", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		-1, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
	), _
	( _
		@"netbsd", _
		FB_DATATYPE_UINT, _
		FB_DATATYPE_UINT, _
		FB_FUNCMODE_CDECL, _
		FB_FUNCMODE_STDCALL_MS, _
		-1, _
		0	or FB_TARGETOPT_UNIX _
			or FB_TARGETOPT_CALLEEPOPSHIDDENPTR _
			or FB_TARGETOPT_RETURNINREGS _
	) _
}

type FBCPUTYPEINFO
	gccarch		as zstring ptr  '' gcc -mtune argument (used for -gen gcc)
	is_x86		as integer
end type

dim shared as FBCPUTYPEINFO cputypeinfo(0 to FB_CPUTYPE__COUNT-1) = _
{ _
	( @"i386"       , TRUE  ), _ '' FB_CPUTYPE_386
	( @"i486"       , TRUE  ), _ '' FB_CPUTYPE_486
	( @"i586"       , TRUE  ), _ '' FB_CPUTYPE_586
	( @"i686"       , TRUE  ), _ '' FB_CPUTYPE_686
	( @"athlon"     , TRUE  ), _ '' FB_CPUTYPE_ATHLON
	( @"athlon-xp"  , TRUE  ), _ '' FB_CPUTYPE_ATHLONXP
	( @"athlon-fx"  , TRUE  ), _ '' FB_CPUTYPE_ATHLONFX
	( @"k8-sse3"    , TRUE  ), _ '' FB_CPUTYPE_ATHLONSSE3
	( @"pentium-mmx", TRUE  ), _ '' FB_CPUTYPE_PENTIUMMMX
	( @"pentium2"   , TRUE  ), _ '' FB_CPUTYPE_PENTIUM2
	( @"pentium3"   , TRUE  ), _ '' FB_CPUTYPE_PENTIUM3
	( @"pentium4"   , TRUE  ), _ '' FB_CPUTYPE_PENTIUM4
	( @"prescott"   , TRUE  ), _ '' FB_CPUTYPE_PENTIUMSSE3
	( @"k8"         , FALSE ), _ '' FB_CPUTYPE_X86_64
	( NULL          , FALSE ), _ '' FB_CPUTYPE_32
	( NULL          , FALSE ), _ '' FB_CPUTYPE_64
	( NULL          , FALSE )  _ '' FB_CPUTYPE_NATIVE
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

'':::::
private function hAddIncFile _
	( _
		byval incfilehash as THASH ptr, _
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

	res = hashLookupEx( incfilehash, fname, index )
	if( res = NULL ) then
		hashAdd( incfilehash, fname, fname, index )
	else
		deallocate( fname )
		fname = res
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

sub fbInit( byval ismain as integer, byval restarts as integer )
	strsetInit( @env.libs, FB_INITLIBNODES \ 4 )
	strsetInit( @env.libpaths, FB_INITLIBNODES \ 4 )

	env.restarts = restarts
	env.dorestart = FALSE

	redim infileTb( 0 to FB_MAXINCRECLEVEL-1 )

	env.includerec = 0
	env.main.proc = NULL

	env.opt.explicit = (env.clopt.lang = FB_LANG_FB)

	'' data type remapping
	if( env.clopt.lang <> FB_LANG_QB ) then
		env.lang.typeremap.integer = FB_DATATYPE_INTEGER
		env.lang.typeremap.long = FB_DATATYPE_LONG

		env.lang.litremap.short = FB_DATATYPE_INTEGER
		env.lang.litremap.ushort = FB_DATATYPE_UINT
		env.lang.litremap.integer = FB_DATATYPE_INTEGER
		env.lang.litremap.uint = FB_DATATYPE_UINT
		env.lang.litremap.double = FB_DATATYPE_DOUBLE
	else
		env.lang.typeremap.integer = FB_DATATYPE_SHORT
		env.lang.typeremap.long = FB_DATATYPE_INTEGER

		env.lang.litremap.short = FB_DATATYPE_SHORT
		env.lang.litremap.ushort = FB_DATATYPE_USHORT
		env.lang.litremap.integer = FB_DATATYPE_INTEGER
		env.lang.litremap.uint = FB_DATATYPE_UINT
		env.lang.litremap.double = FB_DATATYPE_SINGLE
	end if

	env.opt.parammode       = FB_PARAMMODE_BYREF
	env.opt.procpublic		= TRUE
	env.opt.escapestr		= FALSE
	env.opt.dynamic			= FALSE
	env.opt.base = 0
	env.opt.gosub = (env.clopt.lang = FB_LANG_QB)

	env.fbctinf_started = FALSE

	parserSetCtx( )
	symbInit( ismain )
	errInit( )
	astInit( )
	irInit( )

	'' After symbInit(), we can use typeGetSize()
	env.wchar_doconv = (sizeof( wstring ) = typeGetSize( env.target.wchar ))
	env.pointersize = typeGetSize( typeAddrOf( FB_DATATYPE_VOID ) )

	hashInit( @env.incfilehash, FB_INITINCFILES )
	hashInit( @env.inconcehash, FB_INITINCFILES )

	stackNew( @parser.stmt.stk, FB_INITSTMTSTACKNODES, len( FB_CMPSTMTSTK ), FALSE )
	lexInit( FALSE )
	parserInit( )
	rtlInit( )
end sub

sub fbEnd()
	rtlEnd( )
	parserEnd( )
	lexEnd( )
	stackFree( @parser.stmt.stk )

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

	'' When setting the target, also set the default backend
	if( env.target.options and FB_TARGETOPT_64BIT ) then
		env.clopt.backend = FB_BACKEND_GCC
	else
		env.clopt.backend = FB_BACKEND_GAS
	end if

	'' Same for default arch
	if( env.target.options and FB_TARGETOPT_64BIT ) then
		env.clopt.cputype = FB_CPUTYPE_X86_64
	else
		env.clopt.cputype = FB_CPUTYPE_486
	end if
end sub

sub fbGlobalInit()
	strlistInit(@env.predefines, FB_INITINCFILES)
	strlistInit(@env.preincludes, FB_INITINCFILES)
	strlistInit(@env.includepaths, FB_INITINCFILES)

	'' default settings
	env.clopt.outtype       = FB_DEFAULT_OUTTYPE
	env.clopt.pponly        = FALSE

	env.clopt.target        = FB_DEFAULT_TARGET
	env.clopt.fputype       = FB_DEFAULT_FPUTYPE
	env.clopt.fpmode        = FB_DEFAULT_FPMODE
	env.clopt.vectorize     = FB_DEFAULT_VECTORIZELEVEL
	env.clopt.optlevel      = 0
	env.clopt.asmsyntax     = FB_ASMSYNTAX_ATT '' Note: does not affect -gen gas

	env.clopt.lang          = FB_DEFAULT_LANG
	env.clopt.forcelang     = FALSE

	env.clopt.debug         = FALSE
	env.clopt.errorcheck    = FALSE
	env.clopt.extraerrchk   = FALSE
	env.clopt.resumeerr     = FALSE
	env.clopt.profile       = FALSE

	env.clopt.warninglevel  = 0
	env.clopt.showerror     = TRUE
	env.clopt.maxerrors     = FB_DEFAULT_MAXERRORS
	env.clopt.pdcheckopt    = FB_PDCHECK_NONE

	env.clopt.gosubsetjmp   = FALSE
	env.clopt.export        = FALSE
	env.clopt.multithreaded = FALSE
	env.clopt.msbitfields   = FALSE
	env.clopt.stacksize     = FB_DEFSTACKSIZE

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

	case FB_COMPOPT_DEBUG
		env.clopt.debug = value
	case FB_COMPOPT_ERRORCHECK
		env.clopt.errorcheck = value
	case FB_COMPOPT_RESUMEERROR
		env.clopt.resumeerr = value
	case FB_COMPOPT_EXTRAERRCHECK
		env.clopt.extraerrchk = value
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
	case FB_COMPOPT_EXPORT
		env.clopt.export = value
	case FB_COMPOPT_MSBITFIELDS
		env.clopt.msbitfields = value
	case FB_COMPOPT_MULTITHREADED
		env.clopt.multithreaded = value
	case FB_COMPOPT_STACKSIZE
		env.clopt.stacksize = value
		if (env.clopt.stacksize < FB_MINSTACKSIZE) then
			env.clopt.stacksize = FB_MINSTACKSIZE
		end if
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

	case FB_COMPOPT_DEBUG
		function = env.clopt.debug
	case FB_COMPOPT_ERRORCHECK
		function = env.clopt.errorcheck
	case FB_COMPOPT_RESUMEERROR
		function = env.clopt.resumeerr
	case FB_COMPOPT_EXTRAERRCHECK
		function = env.clopt.extraerrchk
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
	case FB_COMPOPT_EXPORT
		function = env.clopt.export
	case FB_COMPOPT_MSBITFIELDS
		function = env.clopt.msbitfields
	case FB_COMPOPT_MULTITHREADED
		function = env.clopt.multithreaded
	case FB_COMPOPT_STACKSIZE
		function = env.clopt.stacksize

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

					'' First pass?
					if( env.restarts = 0 ) then
						fbSetOption( opt, value )

						'' Tell parser to restart as soon as possible
						env.dorestart = TRUE

						'' and don't show any more errors
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

function fbGetTargetId( ) as zstring ptr
	function = env.target.id
end function

function fbIsTarget64bit( ) as integer
	function = ((env.target.options and FB_TARGETOPT_64BIT) <> 0)
end function

function fbGetOppositeBitsTarget( ) as integer
	function = env.target.oppositebits
end function

function fbGetGccArch( ) as zstring ptr
	function = cputypeinfo(env.clopt.cputype).gccarch
end function

function fbIsTargetX86( ) as integer
	function = cputypeinfo(env.clopt.cputype).is_x86
end function

'':::::
function fbGetEntryPoint( ) as string static

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

private sub hAppendFbctinf( byval value as zstring ptr )
	static as string s

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

sub fbCompile _
	( _
		byval infname as zstring ptr, _
		byval outfname as zstring ptr, _
		byref pponlyfile as string, _
		byval ismain as integer _
	)

	dim as double tmr

	env.inf.name = *infname
	hReplaceSlash( env.inf.name, asc( FB_HOST_PATHDIV ) )
	env.inf.incfile	= NULL
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

	tmr = timer( )

	fbParsePreDefines()
	fbParsePreIncludes()
	if (fbShouldContinue()) then
		cProgram()
	end if

	tmr = timer( ) - tmr

	fbMainEnd( )

	'' not cross-compiling?
	if( fbIsCrossComp( ) = FALSE ) then
		'' compiling only?
		if( env.clopt.outtype = FB_OUTTYPE_OBJECT ) then
			'' store libs, paths and cmd-line options in the obj
			hEmitObjinfo( )
		end if
	end if

	'' save
	irEmitEnd( tmr )

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
	return env.dorestart
end function

function fbShouldContinue() as integer
	return ((env.dorestart = FALSE) and (errGetCount() < env.clopt.maxerrors))
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
			hAddIncFile( @env.inconcehash, env.inf.name )
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
			exit sub
		end if
	end if

	'' #pragma ONCE
	if( hFindIncFile( @env.inconcehash, incfile ) <> NULL ) then
		exit sub
	end if

    '' we should respect the path here too
	fileidx = hAddIncFile( @env.incfilehash, incfile )

	'' push context
	infileTb(env.includerec) = env.inf
   	env.includerec += 1

	env.inf.name  = incfile
	env.inf.incfile = fileidx

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

	lexInit( TRUE )

	cProgram()

	lexPopCtx( )

	close #env.inf.num

	'' pop context
	env.includerec -= 1
	env.inf = infileTb( env.includerec )
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
