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


'' intermediate representation - high-level, direct to "C" output
''
'' chng: dec/2006 written [v1ctor]
'' chng: apr/2008 function calling implemented / most operators implemented [sir_mud - sir_mud(at)users(dot)sourceforge(dot)net]

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\flist.bi"

'' flags that are stored in ctx to know what part of the output hWriteFile
'' should write to
enum section_e
	SECTION_HEAD
	SECTION_BODY
	SECTION_FOOT
end enum

'' Argument stack list type for function calls
type ARGLIST
	s as string ptr     ' string containing the vreg of this arg
	next as ARGLIST ptr
end type

type DTYPEINFO
	class			as integer
	size			as integer
	name			as zstring * 31+1
end type

type IRHLCCTX
	identcnt		as integer     ' how many levels of indent
	regcnt			as integer     ' temporary labels counter
	vregTB			as TFLIST

	arg_stack		as ARGLIST ptr ' local stack for args recieved
	section			as section_e   ' current section to write to
	head_txt		as string      ' buffer for header text
	body_txt		as string      ' buffer for body text
	foot_txt		as string      ' buffer for footer text
end type

enum DT2STR_OPTION
	DT2STR_OPTION_STRINGRETFIX			= &h00000001
	DT2STR_OPTION_VOIDPARAMFIX			= &h00000002
end enum

declare function hDtypeToStr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval options as DT2STR_OPTION = 0 _
	) as zstring ptr

declare function hVregToStr _
	( _
		byval vreg as IRVREG ptr _
	) as string

'' globals
dim shared as IRHLCCTX ctx

'' same order as FB_DATATYPE
dim shared dtypeTB(0 to FB_DATATYPES-1) as DTYPEINFO => _
{ _
	( FB_DATACLASS_INTEGER, 0 			    , "void"  ), _				'' void
	( FB_DATACLASS_INTEGER, 1			    , "byte"  ), _				'' byte
	( FB_DATACLASS_INTEGER, 1			    , "ubyte"  ), _				'' ubyte
	( FB_DATACLASS_INTEGER, 1               , "char"  ), _				'' char
	( FB_DATACLASS_INTEGER, 2               , "short"  ), _				'' short
	( FB_DATACLASS_INTEGER, 2               , "ushort"  ), _			'' ushort
	( FB_DATACLASS_INTEGER, 2  				, "short" ), _				'' wchar
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "integer" ), _			'' int
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "uinteger" ), _   		'' uint
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "int" ), _				'' enum
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "int" ), _				'' bitfield
	( FB_DATACLASS_INTEGER, FB_LONGSIZE  	, "long" ), _				'' long
	( FB_DATACLASS_INTEGER, FB_LONGSIZE  	, "ulong" ), _   			'' ulong
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2, "longint" ), _			'' longint
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE*2, "ulongint" ), _			'' ulongint
	( FB_DATACLASS_FPOINT , 4			    , "single" ), _				'' single
	( FB_DATACLASS_FPOINT , 8			    , "double" ), _				'' double
	( FB_DATACLASS_STRING , FB_STRDESCLEN	, "string" ), _				'' string
	( FB_DATACLASS_STRING , 1               , "fixstr"  ), _			'' fix-len string
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "" ), _					'' struct
	( FB_DATACLASS_INTEGER, 0  				, "" 		), _			'' namespace
	( FB_DATACLASS_INTEGER, FB_INTEGERSIZE  , "" ), _					'' function
	( FB_DATACLASS_INTEGER, 1			    , ""  ), _					'' fwd-ref
	( FB_DATACLASS_INTEGER, FB_POINTERSIZE  , "" ) _					'' pointer
}

'':::::
private sub hPushArg( byval vr as IRVREG ptr, byval _done_ as integer )

	dim as ARGLIST ptr node = callocate( sizeof( ARGLIST ) )

	node->s = callocate( sizeof( string ) )
	*node->s = hVregToStr( vr )
	node->next = ctx.arg_stack
	ctx.arg_stack = node

end sub

'':::::
private function hPopArg( ) as string

	if ctx.arg_stack then
		dim as ARGLIST ptr node = ctx.arg_stack
		function = *node->s
		*node->s = ""
		deallocate( node->s )
		ctx.arg_stack = node->next
		deallocate( node )
	else
		errReportEx( FB_ERRMSG_INTERNAL, "Arg stack pop failure." )
	end if

end function

'':::::
private function _init _
	( _
		byval backend as FB_BACKEND _
	) as integer

	flistNew( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )

	irSetOption( IR_OPT_HIGHLEVEL or _
				 IR_OPT_CPU_BOPSELF or _
				 IR_OPT_REUSEOPER or _
				 IR_OPT_IMMOPER or _
				 IR_OPT_FPU_IMMOPER or _
				 IR_OPT_NOINLINEOPS _
			)

	' initialize the current section
	ctx.section = SECTION_HEAD

	function = TRUE

end function

'':::::
private sub _end

	if ctx.arg_stack then
		errReportEx( FB_ERRMSG_INTERNAL, "Argument stack not empty." )
	end if

	flistFree( @ctx.vregTB )

end sub

'':::::
private sub hWriteLine _
	( _
		byval s as zstring ptr = NULL, _
		byval addcommas as integer = TRUE _
	)

	static as string ln

	if( s <> NULL ) then
		if( ctx.identcnt > 0 ) then
			ln = string( ctx.identcnt, TABCHAR )
			ln += *s
		else
			ln = *s
		end if

		if( addcommas ) then
			ln += ";"
		end if

		ln += NEWLINE

	else
		ln = NEWLINE
	end if

	' write it out to the current section
	select case as const ctx.section
		case SECTION_HEAD
			ctx.head_txt += ln
		case SECTION_BODY
			ctx.body_txt += ln
		case SECTION_FOOT
			ctx.foot_txt += ln
		case else
			errReportEx( FB_ERRMSG_INTERNAL, "Bad section." )
	end select

end sub

private function hCallConvToStr _
	( _
		byval proc as FBSYMBOL ptr _
	) as string

	function = ""

	select case as const symbGetProcMode( proc )
	case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
		if( env.target.allowstdcall ) then
			return " __stdcall "
		end if
	end select

end function

'':::::
private sub hEmitVar _
	( _
		byval s as FBSYMBOL ptr, _
		byval isInit as integer = FALSE _
	)

	var attrib = symbGetAttrib( s )

	var elements = 1
    if( symbGetArrayDimensions( s ) > 0 ) then
    	elements = symbGetArrayElements( s )
	end if

    '''''hEmitBssHeader( )

    var sign = *hDtypeToStr( symbGetType( s ), symbGetSubType( s ) ) & " " & *symbGetMangledName( s )
    if( elements > 1 ) then
    	sign += "[" & elements & "]"
    end if

    '' allocation modifier
    if( (attrib and FB_SYMBATTRIB_COMMON) = 0 ) then
      	if( (attrib and FB_SYMBATTRIB_PUBLIC) > 0 ) then
       		hWriteLine( "extern " & sign )
		end if
	else
       	hWriteLine( "extern " & sign )
    end if

	'' emit
    if( not isInit ) then
    	hWriteLine( sign )
    else
    	hWriteLine( sign & " = ", FALSE )
    end if

end sub


'':::::
private sub hDeclVariable _
	( _
		byval s as FBSYMBOL ptr _
	)

    '' already allocated?
	if( symbGetVarIsAllocated( s ) ) then
		return
	end if

	symbSetVarIsAllocated( s )

	'' literal? don't emit..
    if( symbGetIsLiteral( s ) ) then
    	return
	end if

	'' initialized?
	if( symbGetIsInitialized( s ) ) then

		'' extern or jump-tb?
    	if( symbIsExtern( s ) ) then
			return
		elseif( symbGetIsJumpTb( s ) ) then
			return
		end if

    	'' never referenced?
    	if( symbGetIsAccessed( s ) = FALSE ) then
			'' not public?
    	    if( symbIsPublic( s ) = FALSE ) then
    	    	return
    	    end if
		end if

		''''hEmitDataHeader( )
		astTypeIniFlush( s->var_.initree, _
						 s, _
						 AST_INIOPT_ISINI or AST_INIOPT_ISSTATIC )

		return
	end if

    '' extern or dynamic (for the latter, only the array descriptor is emitted)?
	if( (s->attrib and (FB_SYMBATTRIB_EXTERN or _
			   			FB_SYMBATTRIB_DYNAMIC)) <> 0 ) then
		return
	end if

    '' a string or array descriptor?
	if( symbGetLen( s ) <= 0 ) then
		return
	end if

	hEmitVar( s )

end sub

''::::
private sub hDeclProc _
	( _
		byval s as FBSYMBOL ptr _
	)


	if( not symbGetIsCalled( s ) ) then
		return
	end if

	if( symbGetMangledName( s ) = NULL ) then
		return
	end if

	'' overloaded procs pointing to the same symbol (used by the RTL)?
	if( symbGetIsDupDecl( s ) ) then
		return
	end if

	'' gcc builtin? gen a wrapper..
	if( symbGetIsGccBuiltin( s ) ) then
		var cnt = 0
		var param = symbGetProcLastParam( s )
		var params = ""
		do while( param <> NULL )
			params += "temp_ppparam$" & cnt

			param = symbGetProcPrevParam( s, param )
			if param then
				params += ", "
			end if

			cnt += 1
		loop

		hWriteLine( "#define " & *symbGetMangledName( s ) & "( " & params & " ) " & _
					"__builtin_" & *symbGetMangledName( s ) & "( " & params & " )", FALSE )

		return
	end if

	var params = ""
	if symbGetProcParams( s ) = 0 then
		params += "( void )"
	else
		params += "( "
		var param = symbGetProcLastParam( s )
		do while param
			if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
				params += "..."
			else
				params += *hDtypeToStr( symbGetType( param ), symbGetSubType( param ) )
			end if

			select case param->param.mode
			case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
				params += "*"
			end select

			param = symbGetProcPrevParam( s, param )
			if param then
				params += ", "
			end if
		loop

		params += " )"
	end if

	var str_static = ""

	if( symbIsPrivate( s ) ) then
		str_static = "static "
	end if

	var sign = str_static & _
			   *hDtypeToStr( symbGetType( s ), _
							 symbGetSubType( s ), _
							 DT2STR_OPTION_STRINGRETFIX ) & _
				" " & hCallConvToStr( s ) & *symbGetMangledName( s )

	hWriteLine( sign & params )

end sub

''::::
private sub hDeclStruct _
	( _
		byval s as FBSYMBOL ptr _
	)

	var udt_len = symbGetUDTLen( s, FALSE )
	if symbGetName( s ) <> NULL then
		hWriteLine( "typedef struct _" & *symbGetName( s ) & " { ubyte dummy[" & udt_len & "]; } " & *symbGetName( s ) & ";", FALSE )
	else
		'' TODO FIXME nameless structs???
	end if

end sub

'':::::
private sub hEmitDecls _
	( _
		byval s as FBSYMBOL ptr _
	)

	do while( s <> NULL )

		select case symbGetClass( s )
		case FB_SYMBCLASS_NAMESPACE
			hEmitDecls( symbGetNamespaceTbHead( s ) )

		case FB_SYMBCLASS_SCOPE
			hEmitDecls( symbGetScopeSymbTbHead( s ) )

		case FB_SYMBCLASS_VAR
			hDeclVariable s

		case FB_SYMBCLASS_ENUM
			hWriteLine( "typedef int " & *symbGetName( s ) & ";", FALSE )

		case FB_SYMBCLASS_STRUCT
			hDeclStruct s

		case FB_SYMBCLASS_PROC
			hDeclProc s

		end select

		s = s->next
	loop

end sub

'':::::
private sub hEmitTypedefs( )

	'' typedef's for debugging
	hWriteLine( "typedef char byte" )
	hWriteLine( "typedef unsigned char ubyte" )
	hWriteLine( "typedef unsigned short ushort" )
	hWriteLine( "typedef int integer" )
	hWriteLine( "typedef unsigned int uinteger" )
	hWriteLine( "typedef unsigned long ulong" )
	hWriteLine( "typedef long long longint" )
	hWriteLine( "typedef unsigned long long ulongint" )
	hWriteLine( "typedef float single" )
	hWriteLine( "typedef struct _string { char *data; int len; int size; } string" )
	hWriteLine( "typedef char fixstr" )

end sub

'':::::
private function hProcIsUsed _
	( _
		byval proc as FBSYMBOL ptr _
	)  as integer


	do while( proc <> NULL )
		if( symbGetIsCalled( proc ) ) then
			return TRUE
		end if

		proc = symbGetProcOvlNext( proc )
	loop

	return FALSE

end function

private sub hWriteFTOI _
	( _
		byref fname as string, _
		byval rtype as integer, _
		byval ptype as integer _
	)

	dim as string rtype_str, rtype_suffix
	select case rtype
	case FB_DATATYPE_INTEGER
		rtype_str = "int"
		rtype_suffix = "l"

	case FB_DATATYPE_LONGINT
		rtype_str = "long long int"
		rtype_suffix = "q"
	end select

	dim as string ptype_str, ptype_suffix
	select case ptype
	case FB_DATATYPE_SINGLE
		ptype_str = "float"
		ptype_suffix = "s"

	case FB_DATATYPE_DOUBLE
		ptype_str = "double"
		ptype_suffix = "l"
	end select


#ifdef TARGET_X86
	hWriteLine( "static inline " & rtype_str & " fb_" & fname &  " ( " & ptype_str & !" value ) {\n" & _
				!"\tvolatile " & rtype_str & !" result;\n" & _
				!"\t__asm__ (\n" & _
				!"\t\t\"fld" & ptype_suffix & !" %1;\"\n" & _
				!"\t\t\"fistp" & rtype_suffix & !" %0;\"\n" & _
				!"\t\t:\"=m\" (result)\n" & _
				!"\t\t:\"m\" (value)\n" & _
				!"\t);\n" & _
				!"\treturn result;\n" & _
				!"}", FALSE )
#else
	#error !!!WRITEME!!!
#endif

end sub

private sub hEmitFTOIBuiltins( )

	'' single
	if( symbGetIsCalled( PROCLOOKUP( FTOSL ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOUL ) ) ) then
		hWriteFTOI( "ftosl", FB_DATATYPE_LONGINT, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUL ) ) ) then
		hWriteLine( "#define fb_ftoul( v ) (unsigned long long int)fb_ftosl( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSI ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOUI ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOSS ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOUS ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOSB ) ) or _
		symbGetIsCalled( PROCLOOKUP( FTOUB ) ) ) then
		hWriteFTOI( "ftosi", FB_DATATYPE_INTEGER, FB_DATATYPE_SINGLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUI ) ) ) then
		hWriteLine( "#define fb_ftoui( v ) (unsigned int)fb_ftosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSS ) ) ) then
		hWriteLine( "#define fb_ftoss( v ) (short)fb_ftosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUS ) ) ) then
		hWriteLine( "#define fb_ftous( v ) (unsigned short)fb_ftosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSB ) ) ) then
		hWriteLine( "#define fb_ftosb( v ) (char)fb_ftosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUS ) ) ) then
		hWriteLine( "#define fb_ftoub( v ) (unsigned char)fb_ftosi( v )", FALSE )
	end if

	'' double
	if( symbGetIsCalled( PROCLOOKUP( DTOSL ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOUL ) ) ) then
		hWriteFTOI( "dtosl", FB_DATATYPE_LONGINT, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUL ) ) ) then
		hWriteLine( "#define fb_dtoul( v ) (unsigned long long int)fb_dtosl( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSI ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOUI ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOSS ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOUS ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOSB ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOUB ) ) ) then
		hWriteFTOI( "dtosi", FB_DATATYPE_INTEGER, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUI ) ) ) then
		hWriteLine( "#define fb_dtoui( v ) (unsigned int)fb_dtosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSS ) ) ) then
		hWriteLine( "#define fb_dtoss( v ) (short)fb_dtosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUS ) ) ) then
		hWriteLine( "#define fb_dtous( v ) (unsigned short)fb_dtosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSB ) ) ) then
		hWriteLine( "#define fb_dtosb( v ) (char)fb_dtosi( v )", FALSE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUS ) ) ) then
		hWriteLine( "#define fb_dtoub( v ) (unsigned char)fb_dtosi( v )", FALSE )
	end if

end sub

'':::::
private sub hEmitBuiltins( )

	hEmitFTOIBuiltins( )

end sub

'':::::
private function _emitBegin _
	( _
	) as integer

	if( hFileExists( env.outf.name ) ) then
		kill env.outf.name
	end if

	env.outf.num = freefile
	if( open( env.outf.name, for binary, access read write, as #env.outf.num ) <> 0 ) then
		return FALSE
	end if

	ctx.identcnt = 0
	ctx.regcnt = 0

	ctx.section = SECTION_HEAD

	hWriteLine( "/* Compilation of " & env.inf.name & " started at " & time & " on " & date & " */", FALSE )

	ctx.section = SECTION_BODY

	function = TRUE

end function

'':::::
private sub _emitEnd _
	( _
		byval tottime as double _
	)

	' Add the decls on the end of the header
	ctx.section = SECTION_HEAD

	hEmitTypedefs( )

	hEmitBuiltins( )

	hEmitDecls( symbGetGlobalTbHead( ) )

	ctx.section = SECTION_FOOT

	hWriteLine( "/* Total compilation time: " & tottime & " seconds. */", FALSE )

	' flush all sections to file
	if( put( #env.outf.num, , ctx.head_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.body_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.foot_txt ) <> 0 ) then
	end if

	''
	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if

	env.outf.num = 0

end sub

'':::::
private function _getOptionValue _
	( _
		byval opt as IR_OPTIONVALUE _
	) as integer

	select case opt
	case IR_OPTIONVALUE_MAXMEMBLOCKLEN
		return 0

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

	end select

end function

'':::::
private sub _emit _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval ex1 as FBSYMBOL ptr = NULL, _
		byval ex2 as integer = 0 _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _procBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

end sub

'':::::
private sub _procEnd _
	( _
		byval proc as FBSYMBOL ptr _
	)

end sub

''::::
private function _procAllocArg _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval lgt as integer _
	) as integer

	/' do nothing '/

	function = 0

end function

'':::::
private function procAllocLocalArray _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval lgt as integer _
	) as integer

	dim as string ln

	if symbGetArrayDimensions( sym ) > 1 then
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
	end if

	ln += *hDtypeToStr( symbGetType( sym ), symbGetSubType( sym ) ) & " "
	ln += *symbGetMangledName( sym )
	ln += "[" & symbGetArrayElements( sym ) & "]"

	hWriteLine( ln )

	function = 0

end function

'':::::
private function _procAllocLocal _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval lgt as integer _
	) as integer

	dim as string ln
	dim as integer elements = 0
	dim as integer weird = 0 ' weird ones are things like array descriptors..

	if symbIsArray( sym ) then
		return procAllocLocalArray( proc, sym, lgt )
	end if

	if( symbIsStatic( sym ) ) then
		ln = "static "
	end if

	' is it some weird typeless item?
	if *hDtypeToStr( symbGetType( sym ), symbGetSubType( sym ) ) = "" then
		weird = 1
		ln += "ubyte "
		if sym->typ = FB_DATATYPE_STRUCT then
			'ln += " /* array descriptor? */ "
		end if
	else
		ln += *hDtypeToStr( symbGetType( sym ), symbGetSubType( sym ) ) & " "
	end if

	if weird = 0 then
		ln += *symbGetMangledName( sym )
	else
		ln += *symbGetMangledName( sym )
		ln += "[" & symbGetUDTLen( sym, FALSE ) & "]" ' TODO FIXME BAD HACK, nameless memory? array descriptors use this??
	end if

	hWriteLine( ln )

	function = 0

end function

'':::::
private function _procGetFrameRegName _
	( _
	) as zstring ptr

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

	function = NULL

end function

'':::::
private sub _scopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

end sub

'':::::
private sub _scopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

end sub

'':::::
private function _procAllocStaticVars _
	( _
		byval head_sym as FBSYMBOL ptr _
	) as integer

	/' do nothing '/

	function = 0

end function

'':::::
private function _makeTmpStr _
	( _
		byval islabel as integer _
	) as zstring ptr

	static as zstring * 5 + 10 + 1 res

	res = "label$" & ctx.regcnt
	ctx.regcnt += 1

	function = @res

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hNewVR _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval vtype as integer _
	) as IRVREG ptr

	dim as IRVREG ptr v = any

	v = flistNewItem( @ctx.vregTB )

	v->typ = vtype
	v->dtype = dtype
	v->subtype = subtype
	v->sym = NULL
	v->reg = INVALID
	v->vidx	= NULL
	v->ofs = 0

	function = v

end function

'':::::
private function _allocVreg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as IRVREG ptr

	function = hNewVR( dtype, subtype, IR_VREGTYPE_REG )

end function

'':::::
private function _allocVrImm _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as integer _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.int = value

	function = vr

end function

'':::::
private function _allocVrImm64 _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.long = value

	function = vr

end function

'':::::
private function _allocVrImmF _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IMM )

	vr->value.float = value

	function = vr

end function

'':::::
private function _allocVrVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as integer _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_VAR )

	vr->sym = symbol
	vr->ofs = ofs

	function = vr

end function

'':::::
private function _allocVrIdx _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_IDX )

	vr->sym = symbol
	vr->ofs = ofs
	vr->mult = mult
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrPtr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_PTR )

	vr->ofs = ofs
	vr->mult = 1
	vr->vidx = vidx

	function = vr

end function

'':::::
private function _allocVrOfs _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as integer _
	) as IRVREG ptr

	dim as IRVREG ptr vr = hNewVR( dtype, subtype, IR_VREGTYPE_OFS )

	vr->sym = symbol
	vr->ofs = ofs

	function = vr

end function

'':::::
private sub _setVregDataType _
	( _
		byval vreg as IRVREG ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	if( vreg <> NULL ) then
		vreg->dtype = dtype
		vreg->subtype = subtype
	end if

end sub

'':::::
private sub hLoadVreg _
	( _
		byval vreg as IRVREG ptr _
	)

	if( vreg = NULL ) then
		exit sub
	end if

	'' reg?
	if( vreg->typ = IR_VREGTYPE_REG ) then
		if( vreg->reg <> INVALID ) then
			exit sub
		end if

		vreg->reg = ctx.regcnt
		ctx.regcnt += 1
	end if

	'' index?
	if( vreg->vidx <> NULL ) then
		hLoadVreg( vreg->vidx )
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hDtypeToStr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval options as DT2STR_OPTION = 0 _
	) as zstring ptr

	static as string res

	dim as integer ptrcnt = 0

	dim as integer dt = typeGet( dtype )
	if( dt = FB_DATATYPE_POINTER ) then
		ptrcnt = typeGetPtrCnt( dtype )
		dtype = typeGetDtOnly( dtype )
	else
		dtype = dt
	end if

	select case as const dtype
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		res = *symbGetName( subtype )

	case FB_DATATYPE_STRING
		res = dtypeTb(dtype).name
		if( (options and DT2STR_OPTION_STRINGRETFIX) <> 0 ) then
			if( ptrcnt = 0 ) then
				ptrcnt = 1
			end if
		end if

	case FB_DATATYPE_VOID
		res = dtypeTb(dtype).name
		if( (options and DT2STR_OPTION_VOIDPARAMFIX) <> 0 ) then
			if( ptrcnt = 0 ) then
				ptrcnt = 1
			end if
		end if

	case else
		res = dtypeTb(dtype).name
	end select

	if( ptrcnt > 0 ) then
		for i as integer = 0 to ptrcnt - 1
			res += "*"
		next
	end if

	function = strptr( res )

end function

'':::::
private function hVregToStr _
	( _
		byval vreg as IRVREG ptr _
	) as string

	select case as const vreg->typ
	case IR_VREGTYPE_VAR, IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		dim as string operand

		dim as integer do_deref = any, add_plus = any

		if( vreg->sym <> NULL ) then

			'' type casting?
			if( vreg->dtype <> symbGetType( vreg->sym ) or _
				vreg->subtype <> symbGetSubType( vreg->sym ) ) then

				'' byref or import?
				dim as integer is_ptr = (symbGetAttrib( vreg->sym ) and _
										(FB_SYMBATTRIB_PARAMBYREF or _
										FB_SYMBATTRIB_IMPORT)) or _
										typeIsPtr( symbGetType( vreg->sym ) )

				if( is_ptr = FALSE ) then
					operand = "*("
				else
					operand = "("
				end if

				operand += *hDtypeToStr( vreg->dtype, vreg->subtype )

				if( is_ptr = FALSE ) then
					operand += "*)("

					'' offset or idx? pointer arith is done at the ast..
					if( vreg->ofs <> 0 or vreg->vidx <> NULL ) then
						operand += "(ubyte *)"
					end if
					operand += "&"
				else
					operand += ")("
				end if

				do_deref = TRUE

			else
				do_deref = (vreg->ofs <> 0) or (vreg->vidx <> NULL)

				var deref = "*(" + *hDtypeToStr( vreg->dtype, vreg->subtype ) + " *)"

				' no deref (&) for array access..
				if symbGetArrayDimensions( vreg->sym ) > 0 then
					do_deref = TRUE
					operand += deref
					operand += "((ubyte *)"

				elseif( do_deref ) then
					operand += deref
					operand += "((ubyte *)&"
				end if
			end if

			operand += *symbGetMangledName( vreg->sym )
			add_plus = TRUE

		else
			operand = "*(" + *hDtypeToStr( vreg->dtype, vreg->subtype ) + "*)("
			do_deref = TRUE
			add_plus = FALSE
		end if

		if( vreg->vidx <> NULL ) then
			if( add_plus ) then
				operand += " + "
			end if
			operand += hVregToStr( vreg->vidx )
			add_plus = TRUE
		end if

		'' offset?
		if( vreg->ofs <> 0 ) then
			if( add_plus ) then
				operand += " + "
			end if
			operand += str( vreg->ofs )
		end if

		if( do_deref ) then
			operand += ")"
		end if

		return operand

	case IR_VREGTYPE_OFS
		dim as string operand = "&"
		operand += *symbGetMangledName( vreg->sym )
		if( vreg->ofs <> 0 ) then
			operand += " + "
			operand += str( vreg->ofs )
		end if

		' find literal strings, and just print the text, not the label
		if symbGetIsLiteral( vreg->sym ) and (symbGetType( vreg->sym ) = FB_DATATYPE_CHAR) then
			operand =  """" & *hEscape( symbGetVarLitText( vreg->sym ) ) & """"
		end if

		return operand

	case IR_VREGTYPE_IMM
		select case as const vreg->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			return "(" & *hDtypeToStr( vreg->dtype, vreg->subtype ) & ")" & vreg->value.long

		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			return "(" & *hDtypeToStr( vreg->dtype, vreg->subtype ) & ")" & vreg->value.float

		case else
			return "(" & *hDtypeToStr( vreg->dtype, vreg->subtype ) & ")" & vreg->value.int
		end select

	case IR_VREGTYPE_REG
		return "vr$" & vreg->reg

	case else
		return "/* unknown */"

	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitLabel _
	( _
		byval label as FBSYMBOL ptr _
	)

	hWriteLine( *symbGetMangledName( label ) + ":" )

end sub

'':::::
private sub _emitLabelNF _
	( _
		byval label as FBSYMBOL ptr _
	)

	hWriteLine( *symbGetMangledName( label ) + ":" )

end sub

'':::::
private sub _emitReturn _
	( _
		byval bytestopop as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

''::::
private sub _emitJmpTb _
	( _
		byval dtype as integer, _
		byval label as FBSYMBOL ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitInfoSection _
	( _
		byval liblist as TLIST ptr, _
		byval libpathlist as TLIST ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private function hPrepDefine _
	( _
		byval vreg as IRVREG ptr _
	) as string


	function = "#define " & _
				hVregToStr( vreg ) & _
				" ((" & _
				*hDtypeToStr( vreg->dtype, vreg->subtype ) & _
				")("

end function

''::::
private function hBOPToStr _
	( _
		byval op as integer _
	) as string

	select case as const op
		case AST_OP_ADD
			return " + "
		case AST_OP_SUB
			return " - "
		case AST_OP_MUL
			return " * "
		case AST_OP_DIV
			return " / "
		case AST_OP_INTDIV
			return " / "
		case AST_OP_MOD
			return " % "
		case AST_OP_SHL
			return " << "
		case AST_OP_SHR
			return " >> "
		case AST_OP_AND
			return " & "
		case AST_OP_OR
			return " | "
		case AST_OP_XOR
			return " ^ "
		case AST_OP_EQ
			return " == "
		case AST_OP_GT
			return " > "
		case AST_OP_LT
			return " < "
		case AST_OP_NE
			return " != "
		case AST_OP_GE
			return " >= "
		case AST_OP_LE
			return " <= "
		case else
			return "unknown_op"
	end select

end function

'':::::
private sub hWriteBOP _
	( _
		byval op as integer, _
		byval vr as IRVREG ptr, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	dim as string lcast, rcast

	if( vr = NULL ) then
		vr = v1
	end if

	' look for pointer artithmatic, as FB expects it all to be 1 based
	if typeGetPtrCnt( v1->dtype ) > 0 then
		lcast += "(ubyte *)"
	end if
	if typeGetPtrCnt( v2->dtype ) > 0 then
		rcast += "(ubyte *)"
	end if

	' look for /, floating point divide
	if op = AST_OP_DIV then
		lcast += "(double)"
		rcast += "(double)"
	end if

	if( irIsREG( vr ) ) then
		hWriteLine( hPrepDefine( vr ) & lcast & hVregToStr( v1 ) & hBOPToStr( op ) & rcast & hVregToStr( v2 ) & "))", FALSE )
	else
		hWriteLine( hVregToStr( vr ) & " = " & hVregToStr( v1 ) & hBOPToStr( op ) & hVregToStr( v2 ) )
	end if

end sub

'':::::
private sub _emitBopEx _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval ex as FBSYMBOL ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )
	hLoadVreg( vr )

	select case as const op
	case AST_OP_ADD, AST_OP_SUB, AST_OP_MUL, AST_OP_DIV, AST_OP_INTDIV, _
		AST_OP_MOD, AST_OP_SHL, AST_OP_SHR, AST_OP_AND, AST_OP_OR, _
		AST_OP_XOR
		hWriteBOP( op, vr, v1, v2 )

	case AST_OP_EQV
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~(v1 ^ v2)
		if( irIsREG( vr ) ) then
			hWriteLine( hPrepDefine( vr ) & "~(" & _
						hVregToStr( v1 ) & "^" & hVregToStr( v2 ) & ")))", FALSE )
		else
			hWriteLine( hVregToStr( vr ) & " = ~(" & _
						hVregToStr( v1 ) & "^" & hVregToStr( v2 ) & ")" )
		end if

	case AST_OP_IMP
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~v1 | v2
		if( irIsREG( vr ) ) then
			hWriteLine( hPrepDefine( vr ) & "~" & _
						hVregToStr( v1 ) & "^" & hVregToStr( v2 ) & "))", FALSE )
		else
			hWriteLine( hVregToStr( vr ) & " = ~" & _
						hVregToStr( v1 ) & "^" & hVregToStr( v2 ) )
		end if

	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( vr <> NULL ) then
			hWriteBOP( op, vr, v1, v2 )
		else
			hWriteLine( "if (" & _
						hVregToStr( v1 ) & _
						hBOPToStr( op ) & _
						hVregToStr( v2 ) & _
						") goto " & _
						*symbGetMangledName( ex ) _
					)
		end if
	case else
		errReportEx( FB_ERRMSG_INTERNAL, "Unhandled bop." )
	end select

end sub

'':::::
private sub _emitBop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emitBopEx( op, v1, v2, vr, NULL )

end sub

'':::::
private sub hWriteUOP _
	( _
		byref op as string, _
		byval vr as IRVREG ptr, _
		byval v1 as IRVREG ptr _
	)

	if( vr = NULL ) then
		vr = v1
	end if

	if( irIsREG( vr ) ) then
		hWriteLine( hPrepDefine( vr ) & op & "( " & hVregToStr( v1 ) & " )))", FALSE )
	else
		hWriteLine( hVregToStr( vr ) & " = " & op & "( " & hVregToStr( v1 ) & " )" )
	end if

end sub

'':::::
private sub _emitUop _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( vr )

	select case as const op
	case AST_OP_NEG
		hWriteUOP( "-", vr, v1 )

	case AST_OP_NOT
		hWriteUOP( "~", vr, v1 )

	case else
		errReportEx( FB_ERRMSG_INTERNAL, "Unhandled uop." )

	end select

end sub

'':::::
private sub _emitConvert _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )

	if( irIsREG( v1 ) ) then
		hWriteLine( hPrepDefine( v1 ) & hVregToStr( v2 ) & "))", FALSE )
	else
		hWriteLine( hVregToStr( v1 ) & _
					" = (" & *hDtypeToStr( v1->dtype, v1->subtype ) & ")" & _
					hVregToStr( v2 ) )
	end if

end sub

'':::::
private sub _emitStore _
	( _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	if( v1 <> v2 ) then
		'' casting needed?
		if( (v1->dtype <> v2->dtype) or (v1->subtype <> v2->subtype) ) then
			_emitConvert( FB_DATATYPE_VOID, NULL, v1, v2 )

		else
			hLoadVreg( v1 )
			hLoadVreg( v2 )

			if( irIsREG( v1 ) ) then
				hWriteLine( hPrepDefine( v1 ) & hVregToStr( v2 ) & "))", FALSE )
			else
				hWriteLine( hVregToStr( v1 ) & " = " & hVregToStr( v2 ) )
			end if
		end if
	end if

end sub

'':::::
private sub _emitSpillRegs _
	( _
	)

	/' do nothing '/

end sub

'':::::
private sub _emitLoad _
	( _
		byval v1 as IRVREG ptr _
	)

	/' do nothing '/

end sub

'':::::
private sub _emitLoadRes _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	_emitStore( vr, v1 )
	hWriteLine( "return " & hVregToStr( vr ) )

end sub

'':::::
private sub _emitStack _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitPushUDT _
	( _
		byval v1 as IRVREG ptr, _
		byval lgt as integer _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitPushArg _
	( _
		byval vr as IRVREG ptr, _
		byval plen as integer _
	)

	hPushArg( vr, FALSE )

end sub

'':::::
private sub _emitAddr _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( vr )

	select case op
	case AST_OP_ADDROF
		if( irIsREG( vr ) ) then
			hWriteLine( hPrepDefine( vr ) & "&" & hVregToStr( v1 ) & "))", FALSE )
		else
			hWriteLine( hVregToStr( vr ) & " = &" & hVregToStr( v1 ) )
		end if

	case AST_OP_DEREF
		if( irIsREG( vr ) ) then
			hWriteLine( hPrepDefine( vr ) & hVregToStr( v1 ) & "))", FALSE )
		else
			hWriteLine( hVregToStr( vr ) & " = *" & hVregToStr( v1 ) )
		end if
	end select

end sub

'':::::
private function hPopParamListNames( byval proc as FBSYMBOL ptr ) as string

	var ln = ""


	if proc->proc.params = 0 then

		ln += "( )"

	else
		ln += "( "
		var temp_proc_param = symbGetProcLastParam( proc )
		while temp_proc_param
			' cast the arg to the right type
			ln += "("
			ln += *hDtypeToStr( symbGetType( temp_proc_param ), symbGetSubType( temp_proc_param ) )
			if temp_proc_param->param.mode = FB_PARAMMODE_BYREF then
				' TODO FIXME how should byref be done?
				ln += " *"
			end if
			ln += ")"
			ln += hPopArg( )
			temp_proc_param = symbGetProcPrevParam( proc, temp_proc_param )
			if temp_proc_param then
				ln += ", "
			end if
		wend
		ln += " )"
	end if

	return ln

end function


'':::::
private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr _
	)

	if( vr = NULL ) then

		var ln = hPopParamListNames( proc )

		hWriteLine( *symbGetMangledName( proc ) & ln )
	else
		hLoadVreg( vr )

		if( irIsREG( vr ) ) then

			var ln = hPopParamListNames( proc )

			hWriteLine( hPrepDefine( vr ) & *symbGetMangledName( proc ) & ln & "))", FALSE )
		else

			var ln = hPopParamListNames( proc )

			hWriteLine( hVregToStr( vr ) & " = " & *symbGetMangledName( proc ) & ln )

		end if
	end if

end sub

'':::::
private sub _emitCallPtr _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitStackAlign _
	( _
		byval bytes as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitJumpPtr _
	( _
		byval v1 as IRVREG ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitBranch _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr _
	)

	select case op
	case AST_OP_JMP
		hWriteLine( "goto " & *symbGetMangledName( label ) )
	case else
		errReportEx( FB_ERRMSG_INTERNAL, "Unhandled branch type." )
	end select

end sub

'':::::
private sub _emitMem _
	( _
		byval op as integer, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr, _
		byval bytes as integer _
	)


	select case op
	case AST_OP_MEMCLEAR
		hWriteLine("__builtin_memset( " & hVregToStr( v1 ) & ", 0, " & hVregToStr( v2 ) & " )" )

	case AST_OP_MEMMOVE
		hWriteLine("__builtin_memcpy( " & hVregToStr( v1 ) & ", " & hVregToStr( v2 ) & ", " & bytes & " )" )

	end select


end sub

'':::::
private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

'	Encase the line number in a comment so the c compiler doesn't freak out.
' 	if( op = AST_OP_DBG_LINEINI ) then
' 		hWriteLine( "/* #line " & ex & " """ & env.inf.name & """ */", FALSE )
'	end if

end sub

'':::::
private sub _emitComment _
	( _
		byval text as zstring ptr _
	)

	/' use old C style comments for greater compatibility '/
	if len(trim(*text)) > 0 then hWriteLine( "/* " & *text & " */", FALSE ) 'no point in writing blank comments.

end sub

'':::::
private sub _emitASM _
	( _
		byval text as zstring ptr _
	)

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _emitVarIniBegin _
	( _
		byval sym as FBSYMBOL ptr _
	)


	hEmitVar( sym, TRUE )

	ctx.identcnt += 1

end sub

'':::::
private sub _emitVarIniEnd _
	( _
		byval sym as FBSYMBOL ptr _
	)


	ctx.identcnt -= 1

	hWriteLine( "" )


end sub

'':::::
private sub _emitVarIniI _
	( _
		byval dtype as integer, _
		byval value as integer _
	)

	hWriteLine( str( value ), FALSE )

end sub

'':::::
private sub _emitVarIniF _
	( _
		byval dtype as integer, _
		byval value as double _
	)

	hWriteLine( str( value ), FALSE )

end sub

'':::::
private sub _emitVarIniI64 _
	( _
		byval dtype as integer, _
		byval value as longint _
	)

	hWriteLine( str( value ), FALSE )

end sub

'':::::
private sub _emitVarIniOfs _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer _
	)

	hWriteLine( "(ubyte *)&" & *symbGetMangledName( sym ) & " + " & ofs, FALSE )

end sub

'':::::
private sub _emitVarIniStr _
	( _
		byval totlgt as integer, _
		byval litstr as zstring ptr, _
		byval litlgt as integer _
	)

	'' zstring * 1?
	if( totlgt = 0 ) then
		hWriteLine( """""", FALSE )
		exit sub
	end if

	hWriteLine( """" & *hEscape( litstr ) & """", FALSE )

end sub

'':::::
private sub _emitVarIniWstr _
	( _
		byval totlgt as integer, _
		byval litstr as wstring ptr, _
		byval litlgt as integer _
	)

	'' wstring * 1?
	if( totlgt = 0 ) then
		hWriteLine( """""", FALSE )
		exit sub
	end if

	hWriteLine( """" & *hEscapeW( litstr ) & """", FALSE )

end sub

'':::::
private sub _emitVarIniPad _
	( _
		byval bytes as integer _
	)

	'' do nothing..

end sub

'':::::
private sub _emitVarIniScopeBegin _
	( _
		_
	)

	hWriteLine( "{", FALSE )

end sub

'':::::
private sub _emitVarIniScopeEnd _
	( _
		_
	)

	hWriteLine( "}", FALSE )

end sub

'':::::
private sub _emitVarIniSeparator _
	( _
		_
	)

	hWriteLine( ", ", FALSE )

end sub

'':::::
private sub _emitProcBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr _
	)

	dim as string ln

	hWriteLine( )

	if( env.clopt.debug ) then
		_emitDBG( AST_OP_DBG_LINEINI, proc, proc->proc.ext->dbg.iniline )
	end if

	if( symbIsPublic( proc ) = FALSE ) then
		ln = "static "
	end if

	ln += *hDtypeToStr( symbGetType( proc ), symbGetSubType( proc ) )
	ln += hCallConvToStr( proc ) & " "
	ln += *symbGetMangledName( proc )

	if proc->proc.params = 0 then

		ln += "( void )" 'This is just to prevent warnings from some C compilers.

	else

		ln += "( "
		var temp_proc_param = symbGetProcLastParam( proc )
		while temp_proc_param
			ln += *hDtypeToStr( symbGetType( temp_proc_param ), symbGetSubType( temp_proc_param ) )
			if temp_proc_param->param.mode = FB_PARAMMODE_BYREF then
				' TODO FIXME how should byref be done?
				ln += " *" &  ucase( *symbGetName( temp_proc_param ) )
			else
				ln += " " &  ucase( *symbGetName( temp_proc_param ) )
			end if
			temp_proc_param = symbGetProcPrevParam( proc, temp_proc_param )
			if temp_proc_param then
				ln += ", "
			end if
		wend
		ln += " )"

	end if

	hWriteLine( ln, FALSE )

	hWriteLine( "{", FALSE )
	ctx.identcnt += 1

end sub

'':::::
private sub _emitProcEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

	ctx.identcnt -= 1
	hWriteLine( "}", FALSE )

end sub

'':::::
private sub _emitScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

	hWriteLine( "{", FALSE )
	ctx.identcnt += 1

end sub

'':::::
private sub _emitScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

	ctx.identcnt -= 1
	hWriteLine( "}" )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _flush

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private function _GetDistance _
	( _
		byval vreg as IRVREG ptr _
	) as uinteger

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

	function = 0

end function

'':::::
private sub _loadVR _
	( _
		byval reg as integer, _
		byval vreg as IRVREG ptr, _
		byval doload as integer _
	)

/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _storeVR _
	( _
		byval vreg as IRVREG ptr, _
		byval reg as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
private sub _xchgTOS _
	( _
		byval reg as integer _
	)

	/' do nothing '/

	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )

end sub

'':::::
function irHLC_ctor _
	( _
	) as integer

	static as IR_VTBL _vtbl = _
	( _
		@_init, _
		@_end, _
		@_flush, _
		@_emitBegin, _
		@_emitEnd, _
		@_getOptionValue, _
		@_procBegin, _
		@_procEnd, _
		@_procAllocArg, _
		@_procAllocLocal, _
		@_procGetFrameRegName, _
		@_scopeBegin, _
		@_scopeEnd, _
		@_procAllocStaticVars, _
		@_emit, _
		@_emitConvert, _
		@_emitLabel, _
		@_emitLabelNF, _
		@_emitReturn, _
		@_emitProcBegin, _
		@_emitProcEnd, _
		@_emitPushArg, _
		@_emitASM, _
		@_emitComment, _
		@_emitJmpTb, _
		@_emitInfoSection, _
		@_emitBop, _
		@_emitBopEx, _
		@_emitUop, _
		@_emitStore, _
		@_emitSpillRegs, _
		@_emitLoad, _
		@_emitLoadRes, _
		@_emitStack, _
		@_emitPushUDT, _
		@_emitAddr, _
		@_emitCall, _
		@_emitCallPtr, _
		@_emitStackAlign, _
		@_emitJumpPtr, _
		@_emitBranch, _
		@_emitMem, _
		@_emitScopeBegin, _
		@_emitScopeEnd, _
		@_emitDBG, _
		@_emitVarIniBegin, _
		@_emitVarIniEnd, _
		@_emitVarIniI, _
		@_emitVarIniF, _
		@_emitVarIniI64, _
		@_emitVarIniOfs, _
		@_emitVarIniStr, _
		@_emitVarIniWstr, _
		@_emitVarIniPad, _
		@_emitVarIniScopeBegin, _
		@_emitVarIniScopeEnd, _
		@_emitVarIniSeparator, _
		@_allocVreg, _
		@_allocVrImm, _
		@_allocVrImm64, _
		@_allocVrImmF, _
		@_allocVrVar, _
		@_allocVrIdx, _
		@_allocVrPtr, _
		@_allocVrOfs, _
		@_setVregDataType, _
		@_getDistance, _
		@_loadVr, _
		@_storeVr, _
		@_xchgTOS, _
		@_makeTmpStr _
	)

	ir.vtbl = _vtbl

	'errReportEx( FB_ERRMSG_INTERNAL, "the ir module for -gen gcc isn't implemented yet" )

	function = TRUE

end function
