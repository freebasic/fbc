''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


'' fb - main interface
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"

type FB_LANG_INFO
	name		as zstring ptr
	options		as FB_LANG_OPT
end type

declare sub	parserInit ( )

declare sub	parserEnd ( )

declare sub	parserSetCtx ( )

'' globals
	dim shared infileTb( ) as FBFILE
	dim shared incpathTB( ) as zstring * FB_MAXPATHLEN+1
	dim shared pathTB(0 to FB_MAXPATHS-1) as zstring * FB_MAXPATHLEN+1
	dim shared as string fbPrefix
	dim shared as string gccLibTb(0 to GCC_LIBS - 1) 

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
    		FB_LANG_OPT_SHAREDLOCAL or _
    		FB_LANG_OPT_QUIRKFUNC _
		) _
	}

	'' filenames of gcc-libs (same order as enum GCC_LIB)
	dim shared gccLibFileNameTb( 0 to GCC_LIBS - 1 ) as zstring ptr = _
	{ _
		@"crt1.o"           , _
		@"crtbegin.o"       , _
		@"crtend.o"         , _
		@"crti.o"           , _
		@"crtn.o"           , _
		@"gcrt1.o"          , _
		@"libgcc.a"         , _
		@"libsupc++.a"      , _
		NULL                , _ '' libc.so
		@"crt0.o"           , _
		@"gcrt0.o"            _
	}

#if defined(STANDALONE)

const FB_BINPATH = FB_HOST_PATHDIV + "bin" + FB_HOST_PATHDIV
const FB_INCPATH = FB_HOST_PATHDIV + "inc" + FB_HOST_PATHDIV
const FB_LIBPATH = FB_HOST_PATHDIV + "lib" + FB_HOST_PATHDIV

#else

const FB_BINPATH = FB_HOST_PATHDIV + "bin" + FB_HOST_PATHDIV + "freebasic" + FB_HOST_PATHDIV
const FB_INCPATH = FB_HOST_PATHDIV + "include" + FB_HOST_PATHDIV + "freebasic" + FB_HOST_PATHDIV
const FB_LIBPATH = FB_HOST_PATHDIV + "lib" + FB_HOST_PATHDIV + "freebasic" + FB_HOST_PATHDIV

#endif


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' interface
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub fbAddIncPath _
	( _
		byval path as zstring ptr _
	)

	if( env.incpaths < FB_MAXINCPATHS ) then
		' test for both path dividers because a slash is also supported
		' under Win32 and DOS using DJGPP. However, the (back)slashes
		' will always be converted to the OS' preferred type of slash.
		select case right( *path, 1 )
		case "/", RSLASH
		case else
			*path += FB_HOST_PATHDIV
		end select

		incpathTB( env.incpaths ) = *path

		env.incpaths += 1
	end if

end sub

'':::::
sub fbAddDefine _
	( _
		byval dname as zstring ptr, _
		byval dtext as zstring ptr _
	)

    symbAddDefine( dname, dtext, len( *dtext ) )

end sub

'':::::
function fbAddLib _
	( _
		byval libname as zstring ptr _
	) as FBS_LIB ptr

	function = symbAddLib( libname )

end function

'':::::
function fbaddLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval libname as zstring ptr, _
		byval isdefault as integer _
	) as FBS_LIB ptr

	function = symbAddLibEx( liblist, libhash, libname, isdefault )

end function

'':::::
function fbAddLibPath _
	( _
		byval path as zstring ptr _
	) as FBS_LIB ptr

	function = symbAddLibPath( path )

end function

'':::::
function fbAddLibPathEx _
	( _
		byval pathlist as TLIST ptr, _
		byval pathhash as THASH ptr, _
		byval pathname as zstring ptr, _
		byval isdefault as integer _
	) as FBS_LIB ptr

	function = symbAddLibEx( pathlist, pathhash, pathname, isdefault )

end function

'':::::
private function hFindIncFile _
	( _
		byval incfilehash as THASH ptr, _
		byval filename as zstring ptr _
	) as zstring ptr static

	dim as string fname

	fname = ucase( *filename )

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

	fname = allocate( len( *filename ) + 1 )
	hUcase( filename, fname )

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
private sub hSetLangOptions _
	( _
		byval lang as FB_LANG _
	)

	env.lang.opt = langTb(lang).options

end sub

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
private sub hSetLangCtx _
	( _
		byval lang as FB_LANG _
	)

	if( lang = FB_LANG_FB ) then
		env.opt.explicit = TRUE
	else
		env.opt.explicit = FALSE
	end if

    '' data type remapping
	if( lang <> FB_LANG_QB ) then
		env.lang.typeremap.integer = FB_DATATYPE_INTEGER
		env.lang.sizeremap.integer = FB_INTEGERSIZE
		env.lang.typeremap.long = FB_DATATYPE_LONG
		env.lang.sizeremap.long = FB_LONGSIZE

		env.lang.litremap.short = FB_DATATYPE_INTEGER
		env.lang.litremap.ushort = FB_DATATYPE_UINT
		env.lang.litremap.integer = FB_DATATYPE_INTEGER
		env.lang.litremap.uint = FB_DATATYPE_UINT
		env.lang.litremap.double = FB_DATATYPE_DOUBLE

	else
		env.lang.typeremap.integer = FB_DATATYPE_SHORT
		env.lang.sizeremap.integer = 2
		env.lang.typeremap.long = FB_DATATYPE_INTEGER
		env.lang.sizeremap.long = FB_INTEGERSIZE

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

	if( lang <> FB_LANG_QB ) then
		env.opt.gosub = FALSE
	else
		env.opt.gosub = TRUE
	end if

end sub

'':::::
private sub hSetCtx( )

	env.includerec = 0
	env.main.proc = NULL

	hSetLangCtx( env.clopt.lang )

	''
	env.incpaths = 0

	fbAddIncPath( fbGetPath( FB_PATH_INC ) )

	''
	select case env.clopt.target
	case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
		env.target.wchar.type = FB_DATATYPE_USHORT
		env.target.wchar.size = 2
	case FB_COMPTARGET_DOS
		env.target.wchar.type = FB_DATATYPE_UBYTE
		env.target.wchar.size = 1
	case else
		env.target.wchar.type = FB_DATATYPE_UINT
		env.target.wchar.size = FB_INTEGERSIZE
	end select

	env.target.wchar.doconv = ( len( wstring ) = env.target.wchar.size )

	''
	parserSetCtx( )

end sub

'':::::
private sub incTbInit( )

	hashInit( )
	hashNew( @env.incfilehash, FB_INITINCFILES )
	hashNew( @env.inconcehash, FB_INITINCFILES )

end sub

'':::::
private sub incTbEnd( )

	hashFree( @env.inconcehash )
	hashFree( @env.incfilehash )

	hashEnd( )

end sub

'':::::
private sub stmtStackInit( )

	stackNew( @parser.stmt.stk, FB_INITSTMTSTACKNODES, len( FB_CMPSTMTSTK ), FALSE )

end sub

'':::::
private sub stmtStackEnd( )

	stackFree( @parser.stmt.stk )

end sub

'':::::
function fbInit _
	( _
		byval ismain as integer, _
		byval restarts as integer _
	) as integer static

	function = FALSE

	''
	env.restarts = restarts
	env.dorestart = FALSE

	''
	redim infileTb( 0 to FB_MAXINCRECLEVEL-1 )

	redim incpathTB( 0 to FB_MAXINCPATHS-1 )

	''
	hSetCtx( )

	''
	symbInit( ismain )

	hlpInit( )

	errInit( )

	astInit( )

	if( irInit( env.clopt.backend ) = FALSE ) then
		return FALSE
	end if

	incTbInit( )

	stmtStackInit( )

	lexInit( FALSE )

	parserInit( )

	rtlInit( )

	''
	function = TRUE

end function

'':::::
sub fbEnd

	''
	rtlEnd( )

	parserEnd( )

	lexEnd( )

	stmtStackEnd( )

	incTbEnd( )

	irEnd( )

	astEnd( )

	errEnd( )

	hlpEnd( )

	symbEnd( )

	''
	erase incpathTB

	erase infileTb

end sub

'':::::
sub fbSetDefaultOptions( )

	env.cloptexpl.lang		= FALSE

	env.clopt.cputype 		= FB_DEFAULT_CPUTYPE
	env.clopt.fputype		= FB_DEFAULT_FPUTYPE
	env.clopt.outtype		= FB_DEFAULT_OUTTYPE
	env.clopt.target		= FB_DEFAULT_TARGET
	env.clopt.lang			= FB_DEFAULT_LANG
	env.clopt.backend		= FB_DEFAULT_BACKEND
#if defined(TARGET_LINUX)
	env.clopt.findbin		= _
		FB_FINDBIN_ALLOW_ENVVAR _
		or FB_FINDBIN_ALLOW_BINDIR _
		or FB_FINDBIN_ALLOW_SYSTEM
#else
	env.clopt.findbin		= FB_DEFAULT_FINDBIN
#endif
	env.clopt.debug			= FALSE
	env.clopt.errorcheck	= FALSE
	env.clopt.resumeerr 	= FALSE
#if defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	env.clopt.nostdcall 	= FALSE
#else
	env.clopt.nostdcall 	= TRUE
#endif
	env.clopt.nounderprefix	= FALSE
	env.clopt.warninglevel 	= 0
	env.clopt.export		= FALSE
	env.clopt.nodeflibs		= FALSE
	env.clopt.showerror		= TRUE
	env.clopt.multithreaded	= FALSE
	env.clopt.profile       = FALSE
	env.clopt.extraerrchk	= FALSE
	env.clopt.msbitfields	= FALSE
	env.clopt.maxerrors		= FB_DEFAULT_MAXERRORS
	env.clopt.showsusperrors= FALSE
	env.clopt.pdcheckopt	= FB_PDCHECK_NONE
	env.clopt.extraopt      = FB_EXTRAOPT_NONE

	hSetLangOptions( env.clopt.lang )

end sub

'':::::
sub fbSetOption _
	( _
		byval opt as integer, _
		byval value as integer _
	)

	select case as const opt
	case FB_COMPOPT_DEBUG
		env.clopt.debug = value

	case FB_COMPOPT_CPUTYPE
		env.clopt.cputype = value

	case FB_COMPOPT_FPUTYPE
		env.clopt.fputype = value

	case FB_COMPOPT_ERRORCHECK
		env.clopt.errorcheck = value

	case FB_COMPOPT_NOSTDCALL
		env.clopt.nostdcall = value

	case FB_COMPOPT_NOUNDERPREFIX
		env.clopt.nounderprefix = value

	case FB_COMPOPT_OUTTYPE
		env.clopt.outtype = value

	case FB_COMPOPT_RESUMEERROR
		env.clopt.resumeerr = value

	case FB_COMPOPT_WARNINGLEVEL
		env.clopt.warninglevel = value

	case FB_COMPOPT_EXPORT
		env.clopt.export = value

	case FB_COMPOPT_NODEFLIBS
		env.clopt.nodeflibs = value

	case FB_COMPOPT_SHOWERROR
		env.clopt.showerror = value

	case FB_COMPOPT_MULTITHREADED
		env.clopt.multithreaded = value

	case FB_COMPOPT_PROFILE
		env.clopt.profile = value

	case FB_COMPOPT_TARGET
		env.clopt.target = value

	case FB_COMPOPT_EXTRAERRCHECK
		env.clopt.extraerrchk = value

	case FB_COMPOPT_MSBITFIELDS
		env.clopt.msbitfields = value

	case FB_COMPOPT_MAXERRORS
		env.clopt.maxerrors = value

	case FB_COMPOPT_SHOWSUSPERRORS
		env.clopt.showsusperrors = value

	case FB_COMPOPT_LANG
		env.clopt.lang = value
		hSetLangOptions( value )

	case FB_COMPOPT_PEDANTICCHK
		env.clopt.pdcheckopt = value

	case FB_COMPOPT_BACKEND
		env.clopt.backend = value

	case FB_COMPOPT_FINDBIN
		env.clopt.findbin = value

	case FB_COMPOPT_EXTRAOPT
		env.clopt.extraopt = value

	end select

end sub

'':::::
sub fbSetOptionIsExplicit _
	( _
		byval opt as integer _
	)

	select case as const opt
	case FB_COMPOPT_LANG
		env.cloptexpl.lang = TRUE
	end select

end sub

'':::::
function fbGetOption _
	( _
		byval opt as integer _
	) as integer

	select case as const opt
	case FB_COMPOPT_DEBUG
		function = env.clopt.debug

	case FB_COMPOPT_CPUTYPE
		function = env.clopt.cputype

	case FB_COMPOPT_FPUTYPE
		function = env.clopt.fputype

	case FB_COMPOPT_ERRORCHECK
		function = env.clopt.errorcheck

	case FB_COMPOPT_NOSTDCALL
		function = env.clopt.nostdcall

	case FB_COMPOPT_NOUNDERPREFIX
		function = env.clopt.nounderprefix

	case FB_COMPOPT_OUTTYPE
		function = env.clopt.outtype

	case FB_COMPOPT_RESUMEERROR
		function = env.clopt.resumeerr

	case FB_COMPOPT_WARNINGLEVEL
		function = env.clopt.warninglevel

	case FB_COMPOPT_EXPORT
		function = env.clopt.export

	case FB_COMPOPT_NODEFLIBS
		function = env.clopt.nodeflibs

	case FB_COMPOPT_SHOWERROR
		function = env.clopt.showerror

	case FB_COMPOPT_MULTITHREADED
		function = env.clopt.multithreaded

	case FB_COMPOPT_PROFILE
		function = env.clopt.profile

	case FB_COMPOPT_TARGET
		function = env.clopt.target

	case FB_COMPOPT_EXTRAERRCHECK
		function = env.clopt.extraerrchk

	case FB_COMPOPT_MSBITFIELDS
		function = env.clopt.msbitfields

	case FB_COMPOPT_MAXERRORS
		function = env.clopt.maxerrors

	case FB_COMPOPT_SHOWSUSPERRORS
		function = env.clopt.showsusperrors

	case FB_COMPOPT_LANG
		function = env.clopt.lang

	case FB_COMPOPT_PEDANTICCHK
		function = env.clopt.pdcheckopt

	case FB_COMPOPT_BACKEND
		function = env.clopt.backend

	case FB_COMPOPT_FINDBIN
		function = env.clopt.findbin

	case FB_COMPOPT_EXTRAOPT
		function = env.clopt.extraopt

	case else
		function = FALSE
	end select

end function

'':::::
function fbChangeOption _
	( _
		byval opt as integer, _
		byval value as integer _
	) as integer

	function = FALSE

	select case as const opt
	case FB_COMPOPT_MSBITFIELDS
		fbSetOption( opt, value )
		function = TRUE

	case FB_COMPOPT_LANG
		'' do nothing if we are already in the desired mode
		if( value = fbGetOption( opt ) ) then
			function = TRUE
		else

			'' Not module level? then error
			if( parser.scope <> FB_MAINSCOPE ) then

				if( fbIsModLevel( ) = FALSE ) then
					errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
				else
					errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
				end if
			
			'' module level
			else
				'' Explicit -lang on cmdline overrides directive
				if( env.cloptexpl.lang ) then
					errReportWarn( FB_WARNINGMSG_CMDLINEOVERRIDES )
				else

					'' First pass? Set the option and return FALSE to stop the parser
					if( env.restarts = 0 ) then
						fbSetOption( opt, value )
						env.dorestart = TRUE

					'' Second pass? Show a warning and ignore
					else
						errReportWarn( FB_WARNINGMSG_DIRECTIVEIGNORED )
						function = TRUE

					end if

				end if

			end if
						
		end if

	case else
		errReport( FB_ERRMSG_INTERNAL )

	end select

end function

'':::::
function fbIsCrossComp _
	( _
	) as integer

	function = (env.clopt.target <> FB_DEFAULT_TARGET)

end function


'':::::
sub fbSetPaths _
	( _
		byval target as integer _
	) 

	dim as string prefix = fbPrefix
	dim as integer usetargetdir = FALSE

#if defined(STANDALONE)

	if( len(prefix) = 0 ) then
		prefix = exepath()
	end if

#else

	if( len(prefix) = 0 ) then
		prefix = FB_ARCH_PREFIX
	end if

#endif

	dim as string target_dir = ""
	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		target_dir = "win32"
	case FB_COMPTARGET_CYGWIN
		target_dir = "cygwin"
	case FB_COMPTARGET_LINUX
		target_dir = "linux"
	case FB_COMPTARGET_DOS
		target_dir = "dos"
	case FB_COMPTARGET_XBOX
		target_dir = "xbox"
	case FB_COMPTARGET_FREEBSD
		target_dir = "freebsd"
	case FB_COMPTARGET_OPENBSD
		target_dir = "openbsd"
	end select

	pathTB(FB_PATH_BIN   ) = prefix + FB_BINPATH + target_dir + FB_HOST_PATHDIV
	pathTB(FB_PATH_INC   ) = prefix + FB_INCPATH
	pathTB(FB_PATH_LIB   ) = prefix + FB_LIBPATH + target_dir + FB_HOST_PATHDIV
	pathTB(FB_PATH_SCRIPT) = prefix + FB_LIBPATH + target_dir + FB_HOST_PATHDIV

#if not( defined( __FB_WIN32__ ) or defined( __FB_DOS__ ) )
	hRevertSlash( pathTB(FB_PATH_BIN), FALSE )
	hRevertSlash( pathTB(FB_PATH_INC), FALSE )
	hRevertSlash( pathTB(FB_PATH_LIB), FALSE )
	hRevertSlash( pathTB(FB_PATH_SCRIPT), FALSE )
#endif

end sub

'':::::
function fbGetPath _
	( _
		byval path as integer _
	) as string static
	
	function = pathTB( path )
	
end function

'':::::
sub fbSetPrefix _
	( _
		byref prefix as string _
	)
	
	fbPrefix = prefix
	
	'' trim trailing slash
	if( right( fbPrefix, 1 )  = "/" ) then
		fbPrefix = left( fbPrefix, len( fbPrefix ) - 1 )
	end if

#if defined( __FB_WIN32__ ) or defined( __FB_DOS__ )
	if( right( fbPrefix, 1 ) = RSLASH ) then
		fbPrefix = left( fbPrefix, len( fbPrefix ) - 1 )
	end if
#endif

end sub

'':::::
function fbGetEntryPoint( ) as string static

	select case env.clopt.target
	case FB_COMPTARGET_XBOX
		return "XBoxStartup"

	case else
		return "main"

	end select

end function

'':::::
function fbGetModuleEntry( ) as string static
    dim as string sname

   	sname = hStripPath( hStripExt( env.outf.name ) )

   	hClearName( sname )

	function = "fb_ctor__" + sname

end function

'':::::
function fbPreInclude _
	( _
		byval preinclist as TLIST ptr _
	) as integer

	if( preinclist <> NULL ) then
		dim as string ptr incf = listGetHead( preinclist )
		do while( incf <> NULL )
			if( fbIncludeFile( *incf, TRUE ) = FALSE ) then
				return FALSE
			end if

			incf = listGetNext( incf )
		loop
	end if

	function = TRUE

end function

'':::::
function fbCompile _
	( _
		byval infname as zstring ptr, _
		byval outfname as zstring ptr, _
		byval ismain as integer, _
		byval preinclist as TLIST ptr _
	) as integer

    dim as integer res
	dim as double tmr

	function = FALSE

	''
	env.inf.name = *hRevertSlash( infname, FALSE )
	env.inf.incfile	= NULL
	env.inf.ismain = ismain

	env.outf.name = *outfname
	env.outf.ismain = ismain

	'' open source file
	if( hFileExists( *infname ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, infname, -1 )
		exit function
	end if

	env.inf.num = freefile
	if( open( *infname, for binary, access read, as #env.inf.num ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit function
	end if

	env.inf.format = hCheckFileFormat( env.inf.num )

	''
	if( irEmitBegin( ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILEACCESSERROR, infname, -1 )
		exit function
	end if

	fbMainBegin( )

	tmr = timer( )

	res = fbPreInclude( preinclist )

	if( res = TRUE ) then
		'' parse
		res = cProgram( )
	end if

	tmr = timer( ) - tmr

	fbMainEnd( )

	'' save
	irEmitEnd( tmr )

	'' close src
	if( close( #env.inf.num ) <> 0 ) then
		'' ...
	end if

	'' check if any label undefined was used
	if( res = TRUE ) then
		symbCheckLabels( )
		function = (errGetCount( ) = 0)
	else
		function = FALSE
	end if

end function

'':::::
function fbCheckRestartCompile _
	( _
	) as integer

	function = env.dorestart

end function

'':::::
sub fbListLibs _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

	'' note: list of FBS_LIB

	symbListLibs( dstlist, dsthash, delnodes )

end sub

'':::::
sub fbListLibsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

	'' note: both lists of FBS_LIB

	symbListLibsEx( srclist, srchash, dstlist, dsthash, delnodes )

end sub

'':::::
sub fbListLibPaths _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

	'' note: list of FBS_LIB

	symbListLibPaths( dstlist, dsthash, delnodes )

end sub

'':::::
sub fbListLibPathsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

	'' note: both lists of FBS_LIB

	symbListLibsEx( srclist, srchash, dstlist, dsthash, delnodes )

end sub

'':::::
function fbGetGccLib _
	( _
		byval lib_id as GCC_LIB _
	) as string

	if( len( gccLibTb( lib_id ) ) = 0 ) then
		function = *gccLibFileNameTb( lib_id )
	else
		function = gccLibTb( lib_id )
	end if

end function

'':::::
sub fbSetGccLib _
	( _
		byval lib_id as GCC_LIB, _
		byref lib_name as string _
	)

	gccLibTb( lib_id ) = lib_name

end sub

'' :::::
function fbFindGccLib _
	( _
		byval lib_id as GCC_LIB _
	) as string

	dim as string file_loc

	if gccLibFileNameTb( lib_id ) = NULL then return ""

	file_loc = fbGetPath( FB_PATH_LIB ) + *gccLibFileNameTb( lib_id )

	'' Cross compiling? then expect that the needed file will be in the target directory
	if( fbIsCrossComp() ) then
		return file_loc
	end if

	'' let the ones in lib override if necessary
	if( hFileExists( file_loc ) ) then
		return file_loc
	end if
    
'' only query gcc if the host is linux or freebsd
#if defined(__FB_LINUX__) or defined(__FB_FREEBSD__)

	dim as string path
	dim as integer ff = any 

	function = ""

	path = fbFindBinFile( "gcc" )
	if( len( path ) = 0 ) then
		exit function
	end if		

	path += " -m32 -print-file-name=" 
	path += *gccLibFileNameTb( lib_id )
	
	ff = freefile
	if( open pipe( path, for input, as ff ) <> 0 ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, *gccLibFileNameTb( lib_id ), -1 )
		exit function
	end if
	
	input #ff, file_loc
	
	close ff
	
	dim as string short_loc = hStripPath( file_loc )
	
	if( file_loc = short_loc ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, *gccLibFileNameTb( lib_id ), -1 )
		exit function
	end if

#endif
	
	function = file_loc
	
end function

'':::::
sub fbGetDefaultLibs _
	( _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr _
	)

	'' note: list of FBS_LIB

#macro hAddLib( libname )
	symbAddLibEx( dstlist, dsthash, libname, TRUE )
#endmacro	

	'' don't add default libs?
	if( env.clopt.nodeflibs ) then
		exit sub
    end if

	'' select the right FB rtlib
	if( env.clopt.multithreaded ) then
		hAddLib( "fbmt" )
	else
		hAddLib( "fb" )
	end if

	hAddLib( "gcc" )

	select case as const env.clopt.target
	case FB_COMPTARGET_WIN32
		hAddLib( "msvcrt" )
		hAddLib( "kernel32" )
		hAddLib( "mingw32" )
		hAddLib( "mingwex" )
		hAddLib( "moldname" )
		hAddLib( "supc++" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	case FB_COMPTARGET_CYGWIN
		hAddLib( "cygwin" )
		hAddLib( "kernel32" )
		hAddLib( "supc++" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	case FB_COMPTARGET_LINUX
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "pthread" )
		hAddLib( "dl" )
		hAddLib( "ncurses" )
		hAddLib( "supc++" )
		hAddLib( "gcc_eh" )

	case FB_COMPTARGET_DOS
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "supcx" )

	case FB_COMPTARGET_XBOX
		hAddLib( "fbgfx" )
		hAddLib( "openxdk" )
		hAddLib( "hal" )
		hAddLib( "c" )
		hAddLib( "usb" )
		hAddLib( "xboxkrnl" )
		hAddLib( "m" )
		hAddLib( "supc++" )

		'' profiling?
		if( fbGetOption( FB_COMPOPT_PROFILE ) ) then
			hAddLib( "gmon" )
		end if

	case FB_COMPTARGET_FREEBSD
		hAddLib( "c" )
		hAddLib( "m" )
		hAddLib( "pthread" )
		hAddLib( "ncurses" )
		hAddLib( "supc++" )

	end select



end sub

''::::
function fbPragmaOnce _
	( _
	) as integer

    dim as zstring ptr fileidx

	function = FALSE

	if( env.inf.name > "" ) then
       	if( hFindIncFile( @env.inconcehash, env.inf.name ) = NULL ) then
			fileidx = hAddIncFile( @env.inconcehash, env.inf.name )
		end if
 		function = TRUE
	end if

end function

''::::
function is_rootpath( byref path as zstring ptr ) as integer

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
			*path = left( hEnvDir( ), 1 ) + ":" + *path
			function = TRUE
		end if
	end if
#else
	function = (path[0] = asc("/"))
#endif
end function

''::::
function get_rootpath_len( byval path as zstring ptr ) as integer

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
function solve_path( byval path as zstring ptr ) as integer

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

''::::
function fbIncludeFile _
	( _
		byval filename as zstring ptr, _
		byval isonce as integer _
	) as integer

    static as zstring * FB_MAXPATHLEN incfile
    dim as zstring ptr fileidx
    dim as integer i

	function = FALSE

	if( env.includerec >= FB_MAXINCRECLEVEL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
		return errFatal( )
	end if

	'' 1st) try finding it at same path as the current source-file
	incfile = hStripFilename( env.inf.name )
	incfile += *filename

	if( hFileExists( incfile ) = FALSE ) then

		'' 2nd) try as-is (could include an absolute or relative path)
		if( hFileExists( filename ) = FALSE ) then

			'' 3rd) try finding it at the inc paths
			for i = env.incpaths-1 to 0 step -1
				incfile = incpathTB(i)
				incfile += *filename
				if( hFileExists( incfile ) ) then
					exit for
				end if
			next

			'' not found?
			if( i < 0 ) then
				errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + *filename + QUOTE )
				return errFatal( )
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
		return errFatal( )
	end if

 	'' solve out the .. and .
	if( solve_path( incfile ) = FALSE ) then
		errReportEx( FB_ERRMSG_FILENOTFOUND, QUOTE + incfile + QUOTE )
		return errFatal( )
	end if
	
	hRevertSlash( incfile, FALSE )

	'' #include ONCE
	if( isonce ) then
        '' we should respect the path
       	if( hFindIncFile( @env.incfilehash, incfile ) <> NULL ) then
       		return TRUE
       	end if
	end if

	'' #pragma ONCE
    if( hFindIncFile( @env.inconcehash, incfile ) <> NULL ) then
       	return TRUE
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
		return errFatal( )
	end if

	env.inf.format = hCheckFileFormat( env.inf.num )

	'' parse
	lexPushCtx( )

	lexInit( TRUE )

	function = cProgram( )

	lexPopCtx( )

	'' close it
	if( close( #env.inf.num ) <> 0 ) then
		'' ...
	end if

	'' pop context
	env.includerec -= 1
	env.inf = infileTb( env.includerec )

end function

'':::::
sub fbReportRtError _
	( _
		byval modname as zstring ptr, _
		byval funname as zstring ptr, _
		byval errnum as integer _
	) static

	print

	print "Internal compiler error"; errnum;
	if( modname <> NULL ) then
		print " at "; *modname; "::";
		if( funname <> NULL ) then
			print *funname;
		end if
	end if
	print " while parsing "; env.inf.name;
	if( parser.currproc <> NULL ) then
		print ":"; *symbGetName( parser.currproc );
	end if
	print "("; cuint( lexLineNum( ) ); ")"

	print

end sub


'':::::
function fbFindBinFile _
	( _
		byval filename as zstring ptr, _
		byval findopts as FB_FINDBIN _
	) as string

	dim path as string
	dim isenv as integer = FALSE
	dim as FB_FINDBIN opts = any

	function = ""

	if( findopts = FB_FINDBIN_USE_DEFAULT ) then
		opts = fbGetOption( FB_COMPOPT_FINDBIN )
	else
		opts = findopts
	end if

	'' get from environment variable if allowed
	if( (opts and FB_FINDBIN_ALLOW_ENVVAR) <> 0 ) then
		path = environ( ucase(*filename) )
		if( len(path) ) then
			isenv = TRUE
		end if
	end if

	'' if not set, get a default value
	if( len(path) = 0 ) then
		path = fbGetPath( FB_PATH_BIN )
		path += *filename 
		path += FB_HOST_EXEEXT 
	end if

	'' Found it?
	if( hFileExists( path ) ) then
		return path
	end if

	if( isenv = FALSE ) then

		'' system default allowed?
		if( (opts and FB_FINDBIN_ALLOW_SYSTEM) <> 0 ) then
			path = *filename + FB_HOST_EXEEXT
			return path
		end if

	end if

	errReportEx( FB_ERRMSG_EXEMISSING, path, -1 )

end function

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