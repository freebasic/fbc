''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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
#include once "inc\lex.bi"

'' flags that are stored in ctx to know what part of the output hWriteFile
'' should write to
enum section_e
	SECTION_HEAD
	SECTION_BODY
	SECTION_FOOT
end enum

type IRCALLARG
    vr as IRVREG ptr
    level as integer
end type

type IRHLCCTX
	identcnt			as integer     ' how many levels of indent
	regcnt				as integer     ' temporary labels counter
	lblcnt				as integer
	tmpcnt				as integer
	vregTB				as TFLIST
	forwardlist			as TFLIST
	callargs			as TLIST        '' IRCALLARG's during emitPushArg/emitCall[Ptr]
	jmptbsym			as FBSYMBOL ptr
	linenum				as integer

	ini_isfixstrarray	as integer
	ini_strdata			as string
	ini_iswstr			as integer

	section				as section_e   ' current section to write to
	head_txt			as string      ' buffer for header text
	body_txt			as string      ' buffer for body text
	foot_txt			as string      ' buffer for footer text
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
		byval vreg as IRVREG ptr, _
		byval addcast as integer = TRUE _
	) as string

declare sub hEmitStruct _
	( _
		byval s as FBSYMBOL ptr, _
        byval is_ptr as integer _
	)

declare sub hEmitFuncPtrProto _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)


'' globals
dim shared as IRHLCCTX ctx

'' same order as FB_DATATYPE
dim shared as zstring ptr dtypeName(0 to FB_DATATYPES-1) = _
{ _
    @"void"     , _ '' void
    @"byte"     , _ '' byte
    @"ubyte"    , _ '' ubyte
    @"char"     , _ '' char
    @"short"    , _ '' short
    @"ushort"   , _ '' ushort
    @"wchar"    , _ '' wchar
    @"integer"  , _ '' int
    @"uinteger" , _ '' uint
    @"integer"  , _ '' enum
    @"integer"  , _ '' bitfield
    @"long"     , _ '' long
    @"ulong"    , _ '' ulong
    @"longint"  , _ '' longint
    @"ulongint" , _ '' ulongint
    @"single"   , _ '' single
    @"double"   , _ '' double
    @"string"   , _ '' string
    @"fixstr"   , _ '' fix-len string
    @""         , _ '' struct
    @""         , _ '' namespace
    @""         , _ '' function
    @"void"     , _ '' fwd-ref
    @"void *"     _ '' pointer
}

'':::::
private function _init _
	( _
		byval backend as FB_BACKEND _
	) as integer

	flistNew( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )
	flistNew( @ctx.forwardlist, 32, len( FBSYMBOL ptr ) )
	listNew( @ctx.callargs, 32, sizeof(IRCALLARG), LIST_FLAGS_NOCLEAR )

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

	listFree( @ctx.callargs )
	flistFree( @ctx.forwardlist )
	flistFree( @ctx.vregTB )

end sub

'':::::
private sub hWriteLine _
	( _
		byval s as zstring ptr = NULL, _
		byval addcommas as integer = TRUE, _
		byval noline as integer = FALSE _
	)

	static as string ln, idstr, dbgln

#macro writeToSection(ln)
	' write it out to the current section
	select case as const ctx.section
	case SECTION_HEAD
		ctx.head_txt += ln
	case SECTION_BODY
		ctx.body_txt += ln
	case SECTION_FOOT
		ctx.foot_txt += ln
	end select
#endmacro

	if( s <> NULL ) then
		'' the redundancy here is needed to keep string allocated and speed up concatenation, DON'T CHANGE!

		if( ctx.identcnt > 0 ) then
			idstr = string( ctx.identcnt, TABCHAR )
		end if

		if( env.clopt.debug and noline = FALSE ) then
			if( ctx.identcnt > 0 ) then
				dbgln = idstr
				dbgln += "#line "
			else
				dbgln = "#line "
			end if

			dbgln += ctx.linenum & " """ & hReplace( env.inf.name, "\", "\\" ) & """" & NEWLINE

			writeToSection( dbgln )
		end if

		if( ctx.identcnt > 0 ) then
			ln = idstr
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

	writeToSection( ln )

end sub

private function hCallConvToStr _
	( _
		byval proc as FBSYMBOL ptr _
	) as string

	function = ""

	select case as const symbGetProcMode( proc )
	case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
        return " __attribute__((__stdcall__)) "
	end select

end function

private function hGetUDTName _
	( _
        byval s as FBSYMBOL ptr, _
        byval need_original_name as integer = FALSE _
    ) as string

    dim as FBSYMBOL ptr ns = symbGetNamespace( s )

    var sig = ""
    do until( ns = @symbGetGlobalNamespc( ) )
    	sig += *symbGetName( ns )
    	sig += "$"
    	ns = symbGetNamespace( ns )
    loop

    sig += *symbGetName( s )

    if( need_original_name = FALSE ) then
        '' see the HACK in hEmitStruct()
        if( symbGetIsAccessed( s ) ) then
            sig += "$type"
        end if
    end if

    function = sig

end function

'':::::
private sub hEmitUDT _
	( _
		byval s as FBSYMBOL ptr, _
        byval is_ptr as integer _
	)

    if( s = NULL ) then
        return
    end if

	if( symbGetIsEmitted( s ) ) then
		return
	end if

	var oldsection = ctx.section
	if( symbIsLocal( s ) = false ) then
		ctx.section = SECTION_HEAD
	end if

 	select case as const symbGetClass( s )
 	case FB_SYMBCLASS_ENUM
        symbSetIsEmitted( s )
 		hWriteLine( "typedef int " & hGetUDTName( s ) & ";", FALSE, FALSE )

 	case FB_SYMBCLASS_STRUCT
 		hEmitStruct( s, is_ptr )

 	case FB_SYMBCLASS_PROC
 		if( symbGetIsFuncPtr( s ) ) then
 			hEmitFuncPtrProto( s )
 		end if

 	end select

 	ctx.section = oldsection
end sub

'' Returns "[N]" (N = array size) if the symbol is an array or a fixlen string.
private function hEmitArrayDecl( byval s as FBSYMBOL ptr ) as string

    dim as integer n = 0

    if( symbIsArray( s ) ) then
        '' Count of *all* elements in the whole array (not just one dimension)
        n = symbGetArrayElements( s )
        assert( n > 0 )
    end if

    '' Emit fixlen strings as arrays
    '' Note: these may or may not be arrays of fixlen strings
    select case as const symbGetType( s )
    case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
        if( n > 0 ) then
            n *= symbGetStrLen( s )
        else
            n = symbGetStrLen( s )
        end if

    case FB_DATATYPE_WCHAR
        if( n > 0 ) then
            n *= symbGetWstrLen( s )
        else
            n = symbGetWstrLen( s )
        end if

    end select

    if( n > 0 ) then
        return "[" & n & "]"
    end if

    return ""

end function

'':::::
private sub hEmitVar _
	( _
		byval s as FBSYMBOL ptr, _
		byval isInit as integer = FALSE _
	)

    hEmitUDT( symbGetSubType( s ), typeIsPtr( symbGetType( s ) ) )

	var attrib = symbGetAttrib( s )

    var is_extern = (attrib and (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) <> 0

    var sign = ""
    if( is_extern = FALSE ) then
    	if( symbIsLocal( s ) = FALSE or symbIsStatic( s ) ) then
    		sign = "static "
    	end if
    end if

    sign += *hDtypeToStr( symbGetType( s ), symbGetSubType( s ) ) & " " & *symbGetMangledName( s )

    sign += hEmitArrayDecl( s )

    ''
    if( symbIsImport( s ) ) then
    	sign += " __attribute__((dllimport))"
    end if

    '' allocation modifier
    if( (attrib and FB_SYMBATTRIB_COMMON) = 0 ) then
      	if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) > 0 ) then
       		hWriteLine( "extern " & sign, TRUE )

			'' just an extern that was never allocated? exit..
			if( symbIsExtern( s ) ) then
				return
			end if

		end if
	else
       	hWriteLine( "extern " & sign, TRUE )
    	sign += " __attribute__((common))"
    end if

	'' emit
    if( not isInit ) then
    	hWriteLine( sign, TRUE )
    else
    	hWriteLine( sign & " = ", FALSE )
    end if

end sub


'':::::
private sub hEmitVariable _
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

	'' initialized? only if not local or local and static
	if( symbGetIsInitialized( s ) and (symbIsLocal( s ) = FALSE or symbIsStatic( s ))  ) then

		'' extern or jump-tb?
    	if( symbIsExtern( s ) ) then
			return
		elseif( symbGetIsJumpTb( s ) ) then
			return
		end if

    	'' never referenced?
    	if( symbIsLocal( s ) = FALSE ) then
    		if( symbGetIsAccessed( s ) = FALSE ) then
				'' not public?
    	    	if( symbIsPublic( s ) = FALSE ) then
    	    		return
    	    	end if
			end if
		end if

        hEmitUDT( symbGetSubType( s ), typeIsPtr( symbGetType( s ) ) )

		astTypeIniFlush( s->var_.initree, _
						 s, _
						 AST_INIOPT_ISINI or AST_INIOPT_ISSTATIC )

		s->var_.initree = NULL
		return
	end if

    '' dynamic? only the array descriptor is emitted
	if( symbGetIsDynamic( s ) ) then
		return
	end if

    '' a string or array descriptor?
	if( symbGetLen( s ) <= 0 ) then
		return
	end if

	hEmitVar( s )

end sub

''::::
private function hEmitFuncParams _
	( _
		byval proc as FBSYMBOL ptr, _
		byval isproto as integer = TRUE _
	) as string

	''
	dim as FBSYMBOL ptr hidden_param = NULL
	select case symbGetType( proc )
	case FB_DATATYPE_STRUCT
		if( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ) = typeAddrOf( symbGetType( proc ) ) ) then
        	if( isproto = FALSE ) then
        		hidden_param = proc->proc.ext->res
        	else
        		hidden_param = symbGetSubType( proc )
        	end if
		end if
	end select

	''
	if( symbGetProcParams( proc ) = 0 and hidden_param = NULL ) then
		return "( void )"
	end if

	var params = "( "
	var param = symbGetProcLastParam( proc )
	do while param

    	var is_byref = FALSE

		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
			params += "..."

    	else
    		var pvar = iif( isproto, param, symbGetParamVar( param ) )

    		var dtype = symbGetType( pvar )
    		var subtype = symbGetSubType( pvar )

			select case param->param.mode
			case FB_PARAMMODE_BYVAL
    			select case symbGetType( param )
    			'' byval string? it's actually an pointer to a zstring
    			case FB_DATATYPE_STRING
    				is_byref = TRUE
    				dtype = typeJoin( dtype, FB_DATATYPE_CHAR )

    			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    				'' has a dtor, copy ctor or virtual methods? it's a copy..
    				if( symbIsTrivial( symbGetSubtype( param ) ) = FALSE ) then
    					is_byref = TRUE
    				end if
    			end select

			case FB_PARAMMODE_BYREF
				is_byref = TRUE

			case FB_PARAMMODE_BYDESC
				dtype = FB_DATATYPE_STRUCT
				subtype = symb.arrdesctype
				is_byref = TRUE
			end select

            hEmitUDT( subtype, typeIsPtr( symbGetType( pvar ) ) or is_byref )

			params += *hDtypeToStr( dtype, subtype )

			if( is_byref ) then
				params += " *"
			end if

			if( isproto = FALSE ) then
				if( is_byref = FALSE ) then
					params += " "
				end if
				params += *symbGetMangledName( pvar )
			end if

		end if

		param = symbGetProcPrevParam( proc, param )
		if param then
			params += ", "
		end if

	loop

	''
	if( hidden_param ) then
        if( proc->proc.params > 0 ) then
           	params += ", "
        end if

    	params += *hDtypeToStr( typeAddrOf( symbGetType( hidden_param ) ), iif( isproto = FALSE, symbGetSubtype( hidden_param ), hidden_param ) )

		if( isproto = FALSE ) then
        	params += " " & *symbGetMangledName( hidden_param )
		end if
	end if

	params += " )"

	function = params

end function

''::::
private sub hEmitFuncProto _
	( _
		byval s as FBSYMBOL ptr, _
		byval checkcalled as integer = TRUE _
	)


	if( checkcalled and not symbGetIsCalled( s ) ) then
		return
	end if

	if( symbGetMangledName( s ) = NULL ) then
		return
	end if

	'' overloaded procs pointing to the same symbol (used by the RTL)?
	if( symbGetIsDupDecl( s ) ) then
		return
	end if

	var oldsection = ctx.section
	ctx.section = SECTION_HEAD

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
					"__builtin_" & *symbGetMangledName( s ) & "( " & params & " )", FALSE, TRUE )

	else

		var str_static = ""

		if( symbIsPrivate( s ) ) then
			str_static = "static "
		end if

        hEmitUDT( symbGetSubType( s ), typeIsPtr( symbGetType( s ) ) )

		var ln = str_static & _
			   	 *hDtypeToStr( typeGetDtAndPtrOnly( symbGetProcRealType( s ) ), _
					 		   symbGetSubType( s ), _
							   DT2STR_OPTION_STRINGRETFIX ) & _
				 " " & hCallConvToStr( s ) & *symbGetMangledName( s )


		ln += hEmitFuncParams( s )

		if( symbGetIsGlobalCtor( s ) ) then
			ln += " __attribute__ ((constructor)) "
		elseif( symbGetIsGlobalDtor( s ) ) then
			ln += " __attribute__ ((destructor)) "
		end if

		hWriteLine( ln, TRUE )
	end if

	ctx.section = oldsection

end sub

''::::
private sub hEmitFuncPtrProto _
	( _
		byval s as FBSYMBOL ptr _
	)

    hEmitUDT( symbGetSubType( s ), typeIsPtr( symbGetType( s ) ) )
    var params = hEmitFuncParams( s )

    '' Emitted in the meantime?
    if( symbGetIsEmitted( s ) ) then
        return
    end if

	hWriteLine( "typedef " & _
			    *hDtypeToStr( typeGetDtAndPtrOnly( symbGetProcRealType( s ) ), _
				 			  symbGetSubType( s ), _
				 			  DT2STR_OPTION_STRINGRETFIX ) & _
				" " & hCallConvToStr( s ) & "(*" & *symbGetMangledName( s ) & ") " & _
				params, TRUE )

    symbSetIsEmitted( s )

end sub

''::::
private sub hEmitStruct _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_ptr as integer _
	)

	var tname = "struct"
	if( symbGetUDTIsUnion( s ) ) then
		tname = "union"
	end if

    '' Already emitting this UDT currently? This means there is a circular
    '' dependency between this UDT and one (or multiple) other UDT(s).
    if( symbGetIsBeingEmitted( s ) ) then
        '' Is this struct referenced through only a pointer? Then we can create a
        '' forward reference.
        if( is_ptr ) then

            '' Emit a forward reference to this struct (if not yet done),
            '' and remember it for emitting later.
            '' HACK: reusing the accessed flag (that's used by variables only)
            if( symbGetIsAccessed( s ) = FALSE ) then
                symbSetIsAccessed( s )
                hWriteLine( "typedef " & tname  &  " _" & hGetUDTName( s, TRUE ) & " " & hGetUDTName( s, FALSE ), TRUE )
                *cast( FBSYMBOL ptr ptr, flistNewItem( @ctx.forwardlist ) ) = s
            end if

            return
        end if

        '' No forward reference can be created, because the struct is used
        '' directly (not through a pointer). It must be declared before its
        '' parent is.
    end if

    symbSetIsBeingEmitted( s )

	'' check every field, for non-emitted subtypes
	var e = symbGetUDTFirstElm( s )
	do while( e <> NULL )
        hEmitUDT( symbGetSubtype( e ), typeIsPtr( symbGetType( e ) ) )
		e = symbGetUDTNextElm( e )
	loop

    '' Has this UDT been emitted in the mean time? (maybe one of the fields
    '' did that)
    if( symbGetIsEmitted( s ) ) then
        return
    end if

    '' We'll emit it now.
    symbSetIsEmitted( s )

	'' UDT name
	dim as string id
	if( symbGetName( s ) = NULL ) then
		id = *hMakeTmpStrNL( )
	else
		id = hGetUDTName( s, TRUE )
	end if

	hWriteLine( "typedef " + tname + " _" + id + " {", FALSE )

	'' Alignment (field = N)
	var attrib = ""
	if( s->udt.align > 0 ) then
		if( s->udt.align = 1 ) then
			attrib = " __attribute__((packed))"
		else
			attrib = " __attribute__((aligned (" & s->udt.align & ")))"
		end if
	end if

	'' Write out the elements
	ctx.identcnt += 1

	e = symbGetUDTFirstElm( s )
	do while( e <> NULL )
        var subtype = symbGetSubtype( e )

        var ln = ""
        if( subtype <> s ) then
        	ln = *hDtypeToStr( symbGetType( e ), subtype ) + " "
        else
        	ln = tname + " _" + id + " *"
        end if

        ln += *symbGetName( e )

        ln += hEmitArrayDecl( e )

        /' the bitfield calcs are done by FB
        if( symbGetType( e ) = FB_DATATYPE_BITFIELD ) then
        	ln += " :" & subtype->bitfld.bits
        end if
        '/

        ln += attrib

        hWriteLine( ln, TRUE )

		e = symbGetUDTNextElm( e )
	loop

	ctx.identcnt -= 1

    '' Close UDT body
	hWriteLine( "} " & id, TRUE )

	symbResetIsBeingEmitted( s )

	'' Emit methods (not part of the struct anymore, but they will include
    '' references to self (this))
	e = symbGetCompSymbTb( s ).head
	do while( e <> NULL )
    	'' method?
    	if( symbGetClass( e ) = FB_SYMBCLASS_PROC ) then
			if( symbGetIsFuncPtr( e ) = FALSE ) then
				hEmitFuncProto( e, FALSE )
			end if
    	end if

    	e = e->next
    loop

end sub

'':::::
private sub hEmitDecls _
	( _
		byval s as FBSYMBOL ptr, _
		byval procs as integer = FALSE _
	)

	do while( s <> NULL )

 		select case as const symbGetClass( s )
 		case FB_SYMBCLASS_NAMESPACE
			hEmitDecls( symbGetNamespaceTbHead( s ) )

 		case FB_SYMBCLASS_SCOPE
			hEmitDecls( symbGetScopeSymbTbHead( s ) )

 		case FB_SYMBCLASS_VAR
			if( procs = FALSE ) then
				hEmitVariable( s )
			end if

 		case FB_SYMBCLASS_PROC
			if( procs ) then
				if( symbGetIsFuncPtr( s ) = FALSE ) then
					hEmitFuncProto( s )
				end if
			end if

 		end select

		s = s->next
	loop

end sub

'':::::
private sub hEmitDataStmt _
	( _
		_
	)

	var s = astGetLastDataStmtSymbol( )
	do while( s <> NULL )
 		hEmitVariable( s )
		s = s->var_.data.prev
	loop

end sub

'':::::
private sub hEmitForwardDecls( )

	if( ctx.forwardlist.lastitem = NULL ) then
		return
	end if

	dim as FBSYMBOL ptr s = flistGetHead( @ctx.forwardlist )
	do while( s <> NULL )
        hEmitUDT( s, FALSE )
		s = flistGetNext( s )
	loop

	flistReset( @ctx.forwardlist )

end sub

'':::::
private sub hEmitTypedefs( )

	'' typedef's for debugging
	hWriteLine( "typedef char byte", TRUE )
	hWriteLine( "typedef unsigned char ubyte", TRUE )
	hWriteLine( "typedef unsigned short ushort", TRUE )
	hWriteLine( "typedef int integer", TRUE )
	hWriteLine( "typedef unsigned int uinteger", TRUE )
	hWriteLine( "typedef unsigned long ulong", TRUE )
	hWriteLine( "typedef long long longint", TRUE )
	hWriteLine( "typedef unsigned long long ulongint", TRUE )
	hWriteLine( "typedef float single", TRUE )
	hWriteLine( "typedef struct _string { char *data; int len; int size; } string", TRUE )
	hWriteLine( "typedef char fixstr", TRUE )

    '' Target-dependant wchar type
    dim as string wchartype

    select case as const env.target.wchar.type
    case FB_DATATYPE_UBYTE      '' DOS
        wchartype = "ubyte"
    case FB_DATATYPE_USHORT     '' Windows, cygwin
        wchartype = "ushort"
    case FB_DATATYPE_UINT       '' Linux & co
        wchartype = "uinteger"
    case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    end select

    hWriteLine( "typedef " + wchartype + " wchar", TRUE )

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
		hWriteLine( "#define fb_ftoul( v ) (unsigned long long int)fb_ftosl( v )", FALSE, TRUE )
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
		hWriteLine( "#define fb_ftoui( v ) (unsigned int)fb_ftosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSS ) ) ) then
		hWriteLine( "#define fb_ftoss( v ) (short)fb_ftosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUS ) ) ) then
		hWriteLine( "#define fb_ftous( v ) (unsigned short)fb_ftosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOSB ) ) ) then
		hWriteLine( "#define fb_ftosb( v ) (char)fb_ftosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( FTOUB ) ) ) then
		hWriteLine( "#define fb_ftoub( v ) (unsigned char)fb_ftosi( v )", FALSE, TRUE )
	end if

	'' double
	if( symbGetIsCalled( PROCLOOKUP( DTOSL ) ) or _
		symbGetIsCalled( PROCLOOKUP( DTOUL ) ) ) then
		hWriteFTOI( "dtosl", FB_DATATYPE_LONGINT, FB_DATATYPE_DOUBLE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUL ) ) ) then
		hWriteLine( "#define fb_dtoul( v ) (unsigned long long int)fb_dtosl( v )", FALSE, TRUE )
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
		hWriteLine( "#define fb_dtoui( v ) (unsigned int)fb_dtosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSS ) ) ) then
		hWriteLine( "#define fb_dtoss( v ) (short)fb_dtosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUS ) ) ) then
		hWriteLine( "#define fb_dtous( v ) (unsigned short)fb_dtosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOSB ) ) ) then
		hWriteLine( "#define fb_dtosb( v ) (char)fb_dtosi( v )", FALSE, TRUE )
	end if

	if( symbGetIsCalled( PROCLOOKUP( DTOUB ) ) ) then
		hWriteLine( "#define fb_dtoub( v ) (unsigned char)fb_dtosi( v )", FALSE, TRUE )
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
	ctx.lblcnt = 0
	ctx.tmpcnt = 0
	ctx.head_txt = ""
	ctx.body_txt = ""
	ctx.foot_txt = ""
	ctx.linenum = 0
	ctx.ini_isfixstrarray = FALSE
	ctx.ini_iswstr = FALSE

	ctx.section = SECTION_HEAD

	if( env.clopt.debug ) then
		_emitDBG( AST_OP_DBG_LINEINI, NULL, 0 )
	end if

	hWriteLine( "// Compilation of " & env.inf.name & " started at " & time & " on " & date, FALSE, TRUE )

	hEmitTypedefs( )

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

	hEmitBuiltins( )

	hEmitDataStmt( )

	'' Emit proc decls first (because of function pointer initializers referencing procs)
	hEmitDecls( symbGetGlobalTbHead( ), TRUE )

	'' Then the variables
	hEmitDecls( symbGetGlobalTbHead( ), FALSE )

	hEmitForwardDecls( )

	ctx.section = SECTION_FOOT

	hWriteLine( "// Total compilation time: " & tottime & " seconds. ", FALSE, TRUE )

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

	proc->proc.ext->dbg.iniline = lexLineNum( )

end sub

'':::::
private sub _procEnd _
	( _
		byval proc as FBSYMBOL ptr _
	)

	proc->proc.ext->dbg.endline = lexLineNum( )

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
private function _procAllocLocal _
	( _
		byval proc as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval lgt as integer _
	) as integer

	hEmitVariable( sym )

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

	static as zstring * 6 + 10 + 1 res

	if( islabel ) then
		res = "label$" & ctx.lblcnt
		ctx.lblcnt += 1
	else
		res = "tmp$" & ctx.tmpcnt
		ctx.tmpcnt += 1
	end if

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
	case FB_DATATYPE_STRUCT
		if( subtype = NULL ) then
			res = "void"
		else
            hEmitUDT( subtype, (ptrcnt > 0) )
			res = hGetUDTName( subtype )
		end if

	case FB_DATATYPE_ENUM
		if( subtype = NULL ) then
			res = *dtypeName(FB_DATATYPE_INTEGER)
		else
            hEmitUDT( subtype, (ptrcnt > 0) )
			res = hGetUDTName( subtype )
		end if

	case FB_DATATYPE_FUNCTION
        assert( subtype <> NULL )
		res = *symbGetMangledName( subtype )
		ptrcnt -= 1

	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		res = *dtypeName(dtype)
		if( (options and DT2STR_OPTION_STRINGRETFIX) <> 0 ) then
			if( ptrcnt = 0 ) then
				ptrcnt = 1
			end if
		end if

	case FB_DATATYPE_VOID
		res = *dtypeName(dtype)
		if( (options and DT2STR_OPTION_VOIDPARAMFIX) <> 0 ) then
			if( ptrcnt = 0 ) then
				ptrcnt = 1
			end if
		end if

	case FB_DATATYPE_BITFIELD
        if( subtype <> NULL ) then
        	res = *dtypeName(symbGetType( subtype ))
        else
        	res = "integer"
        end if

	case else
		res = *dtypeName(dtype)
	end select

	if( ptrcnt > 0 ) then
		for i as integer = 0 to ptrcnt - 1
			res += "*"
		next
	end if

	function = strptr( res )

end function

'':::::
private function hEmitInt( byval value as integer ) as string

    if( value < 0 ) then
        '' Convert -5 to '((-4)-1)', to prevent GCC warnings for INT_MIN
        return "((-" & (abs(value) - 1) & ") - 1)"
    end if

    return str( value )

end function

'':::::
private function hEmitUint( byval value as uinteger ) as string

    return str( value ) + "u"

end function

'':::::
private function hEmitLong( byval value as longint ) as string

    if( value < 0 ) then
        '' Ditto, prevent warnings for LLONG_MIN
        return "((-" & (abs(value) - 1) & "ll) - 1)"
    end if

    return str( value ) + "ll"

end function

'':::::
private function hEmitUlong( byval value as ulongint ) as string

    return str( value ) + "ull"

end function

'':::::
private function hEmitSingle( byval value as single ) as string

    dim as string s = str( value )

    if( instr( s, "." ) = 0 ) then
        s += ".0"
    end if

    s += "f"

    return s

end function

'':::::
private function hEmitDouble( byval value as double ) as string

    dim as string s = str( value )

    if( instr( s, "." ) = 0 ) then
        s += ".0"
    end if

    return s

end function

'':::::
private function hEmitOffset( byval sym as FBSYMBOL ptr, byval ofs as integer ) as string

	dim as string expr

	'' For literal strings, just print the text, not the label
	if( symbGetIsLiteral( sym ) ) then
		select case symbGetType( sym )
		case FB_DATATYPE_CHAR
			expr += """" + *hEscape( symbGetVarLitText( sym ) ) + """"
		case FB_DATATYPE_WCHAR
            '' wstr("a") becomes (wchar *)"\141\0\0"
            '' (The last \0 and the implicit NULL terminator form the wchar NULL terminator)
			expr += "(" + *dtypeName(FB_DATATYPE_WCHAR) + " *)""" + *hEscapeW( symbGetVarLitTextW( sym ) ) + "\0"""
		case else
			errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
		end select
	else
        expr += "&"
        '' Name of the array that's being accessed, or the function in @func, etc
		expr += *symbGetMangledName( sym )
	end if

    assert( iif( symbIsProc( sym ), (ofs = 0), TRUE ) )

    '' Cast to actual data type (always a pointer), but not for function pointers
    if( symbIsProc( sym ) = FALSE ) then
        '' Offset (in bytes)
        if( ofs <> 0 ) then
            expr = "((ubyte *)" + expr + " + " + str( ofs ) + ")"
        end if

        expr = "(" + *hDtypeToStr( symbGetType( sym ), symbGetSubtype( sym ) ) + " *)" + expr
    end if

    return expr

end function

'':::::
private function hVregToStr _
	( _
		byval vreg as IRVREG ptr, _
		byval addcast as integer = TRUE _
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
					if( addcast ) then
						operand = "("
					end if
				end if

				if( is_ptr = FALSE or addcast ) then
					operand += *hDtypeToStr( vreg->dtype, vreg->subtype )
				end if

				if( is_ptr = FALSE ) then
					operand += "*)("

					'' offset or idx? pointer arith is done at the ast..
					if( vreg->ofs <> 0 or vreg->vidx <> NULL ) then
						operand += "(ubyte *)"
					end if

                    '' Emit && to get the address value of labels (used by -exx code)
                    if( symbIsLabel( vreg->sym ) ) then
                        operand += "&"
                    end if

                    operand += "&"
				else
					if( addcast ) then
						operand += ")("
					else
						operand += "("
					end if
				end if

				do_deref = TRUE

			else
				do_deref = (vreg->ofs <> 0) or (vreg->vidx <> NULL)

				var deref = "*(" + *hDtypeToStr( vreg->dtype, vreg->subtype ) + " *)"

				'' No addrof (&) for array access
				if( symbGetArrayDimensions( vreg->sym ) ) then
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

		'' ptr?
		else
			operand = "*(" + *hDtypeToStr( vreg->dtype, vreg->subtype ) + "*)((ubyte *)"
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
		return hEmitOffset( vreg->sym, vreg->ofs )

	case IR_VREGTYPE_IMM
        var s = "(" & *hDtypeToStr( vreg->dtype, vreg->subtype ) & ")"

		select case as const vreg->dtype
		case FB_DATATYPE_LONGINT
            s += hEmitLong( vreg->value.long )

        case FB_DATATYPE_ULONGINT
            s += hEmitUlong( vreg->value.long )

		case FB_DATATYPE_SINGLE
            s += hEmitSingle( vreg->value.float )

        case FB_DATATYPE_DOUBLE
			s += hEmitDouble( vreg->value.float )

  		case FB_DATATYPE_LONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
                s += hEmitInt( vreg->value.int )
  	    	else
                s += hEmitLong( vreg->value.long )
  	    	end if

        case FB_DATATYPE_ULONG
  	    	if( FB_LONGSIZE = len( integer ) ) then
                s += hEmitUint( vreg->value.int )
  	    	else
                s += hEmitUlong( vreg->value.long )
  	    	end if

		case FB_DATATYPE_UINT
            s += hEmitUint( vreg->value.int )

        case else
            s += hEmitInt( vreg->value.int )

		end select

        return s

	case IR_VREGTYPE_REG
		return "vr$" & vreg->reg

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
		return "__unknown__"

	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitLabel _
	( _
		byval label as FBSYMBOL ptr _
	)

	hWriteLine( *symbGetMangledName( label ) + ":", TRUE )

end sub

'':::::
private sub _emitLabelNF _
	( _
		byval label as FBSYMBOL ptr _
	)

	hWriteLine( *symbGetMangledName( label ) + ":", TRUE )

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
		byval op as AST_JMPTB_OP, _
		byval dtype as integer, _
		byval label as FBSYMBOL ptr _
	)

	select case op
	case AST_JMPTB_BEGIN
		ctx.jmptbsym = label
		hWriteLine( "static const void * " & *symbGetMangledName( label ) & "[] = {", FALSE )
		ctx.identcnt += 1

	case AST_JMPTB_END
		ctx.identcnt -= 1
		hWriteLine( "(void *)0 }", TRUE )

	case AST_JMPTB_LABEL
		hWriteLine( "&&" & *symbGetMangledName( label ) & ",", FALSE )
	end select

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
private sub hEmitVregExpr _
	( _
		byval vr as IRVREG ptr, _
		byref expr as string, _
		byval is_call as integer = FALSE _
	)

	if( irIsREG( vr ) ) then
		var ln = ""
		var typ = *hDtypeToStr( vr->dtype, vr->subtype )
		var id = hVregToStr( vr )

		if( is_call ) then
			ln = typ & " " & id & " = (" & typ & ")(" & expr & ");"
		else
			ln = "#define " & id & " ((" & typ & ")(" & expr & "))"
		end if

		hWriteLine( ln, FALSE, TRUE )
	else
		hWriteLine( hVregToStr( vr ) & " = (" & expr & ")" )
	end if

end sub

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
private function hEmitBOP _
    ( _
		byval op as integer, _
		byref l as string, _
		byref r as string _
    ) as string

    dim as string bop = l + hBOPToStr( op ) + r

    select case as const op
    case AST_OP_EQ, AST_OP_GT, AST_OP_LT, AST_OP_NE, AST_OP_GE, AST_OP_LE
        '' Add a negation in order to convert the "boolean" 1 to -1 (0 stays 0)
        bop = "(-(" + bop + "))"
    end select

    return bop

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

	'' look for /, floating point divide
	if( op = AST_OP_DIV ) then
		lcast += "(double)"
		rcast += "(double)"
	end if

	hEmitVregExpr( vr, hEmitBOP( op, _
                                 lcast + hVregToStr( v1 ), _
                                 rcast + hVregToStr( v2 ) ) )

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
        hEmitVregExpr( vr, "~(" & hVregToStr( v1 ) & "^" & hVregToStr( v2 ) & ")" )

	case AST_OP_IMP
		if( vr = NULL ) then
			vr = v1
		end if

		'' vr = ~v1 | v2
        hEmitVregExpr( vr, "~" & hVregToStr( v1 ) & "|" & hVregToStr( v2 ) )

	case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
		if( vr <> NULL ) then
			hWriteBOP( op, vr, v1, v2 )
		else
			hWriteLine( "if (" + hEmitBOP( op, _
                                           hVregToStr( v1 ), _
                                           hVregToStr( v2 ) ) + _
                        ") goto " + _
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

    hEmitVregExpr( vr, op & "(" & hVregToStr( v1 ) & ")" )

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
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval v1 as IRVREG ptr, _
		byval v2 as IRVREG ptr _
	)

	hLoadVreg( v1 )
	hLoadVreg( v2 )

    hEmitUDT( to_subtype, typeIsPtr( to_dtype ) )

    hEmitVregExpr( v1, hVregToStr( v2 ) )

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
			_emitConvert( v1->dtype, v1->subtype, v1, v2 )
		else
			hLoadVreg( v1 )
			hLoadVreg( v2 )

            hEmitVregExpr( v1, hVregToStr( v2 ) )
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
        byval plen as integer, _
        byval level as integer _
    )

    '' Remember for later, so during _emitCall[Ptr] we can emit the whole
    '' call in one go
    dim as IRCALLARG ptr arg = listNewNode( @ctx.callargs )
    arg->vr = vr
    arg->level = level

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
        hEmitVregExpr( vr, "&" + hVregToStr( v1, FALSE ) )

	case AST_OP_DEREF
        hEmitVregExpr( vr, hVregToStr( v1 ) )

	end select

end sub

'':::::
private function hEmitCallArgs _
    ( _
        byval level as integer _
    ) as string

    var ln = "( "

    dim as IRCALLARG ptr arg = listGetTail( @ctx.callargs )
    while( arg andalso (arg->level = level) )
        dim as IRCALLARG ptr prev = listGetPrev( arg )

        ln += hVregToStr( arg->vr )

        listDelNode( @ctx.callargs, arg )

        if( prev ) then
            if( prev->level = level ) then
                ln += ", "
            end if
        end if

        arg = prev
    wend

    ln += " )"

    return ln

end function

'':::::
private sub hDoCall _
	( _
		byval pname as zstring ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	var ln = hEmitCallArgs( level )

	if( vr = NULL ) then
		hWriteLine( *pname & ln )
	else
		hLoadVreg( vr )
        hEmitVregExpr( vr, *pname & ln, TRUE )
	end if

end sub

'':::::
private sub _emitCall _
	( _
		byval proc as FBSYMBOL ptr, _
		byval bytestopop as integer, _
		byval vr as IRVREG ptr, _
		byval level as integer _
	)

	hDoCall( symbGetMangledName( proc ), bytestopop, vr, level )

end sub

'':::::
private sub _emitCallPtr _
	( _
		byval v1 as IRVREG ptr, _
		byval vr as IRVREG ptr, _
		byval bytestopop as integer, _
		byval level as integer _
	)

	hDoCall( "(" & hVregToStr( v1 ) & ")", bytestopop, vr, level )

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

	hWriteLine( "goto *" & hVregToStr( v1 ) )

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
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
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
		hWriteLine("__builtin_memset( " & hVregToStr( v1 ) & ", 0, " & hVregToStr( v2 ) & " )", TRUE )

	case AST_OP_MEMMOVE
		hWriteLine("__builtin_memcpy( " & hVregToStr( v1 ) & ", " & hVregToStr( v2 ) & ", " & bytes & " )", TRUE )

	end select


end sub

'':::::
private sub _emitDBG _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval ex as integer _
	)

 	if( op = AST_OP_DBG_LINEINI ) then
 		hWriteLine( "#line " & ex & " """ & hReplace( env.inf.name, "\", "\\" ) & """", FALSE, TRUE )
 		ctx.linenum = ex
	end if

end sub

'':::::
private sub _emitComment _
	( _
		byval text as zstring ptr _
	)

    static as string s

    s = *text
    s = trim(s)

	if( len( s ) > 0 ) then
        if( right( s, 1 ) = "\" ) then
            s += "not_an_escape"
        end if
		hWriteLine( "// " & s, FALSE, TRUE )
	end if

end sub

'':::::
private sub _emitASM _
	( _
		byval text as zstring ptr _
	)

	hWriteLine( "__asm__ ( " + *text + " )" )

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

	hWriteLine( "", TRUE, TRUE )

end sub

'':::::
private sub _emitVarIniI _
	( _
		byval dtype as integer, _
		byval value as integer _
	)

    dim as string s

    select case as const dtype
    case FB_DATATYPE_UINT, FB_DATATYPE_ULONG
        '' Treat as unsigned
        s = hEmitUint( value )

    case else
        s = hEmitInt( value )

    end select

	hWriteLine( s, FALSE, TRUE )

end sub

'':::::
private sub _emitVarIniF _
	( _
		byval dtype as integer, _
		byval value as double _
	)

    dim as string s

    select case as const dtype
    case FB_DATATYPE_SINGLE
        s = hEmitSingle( value )

    case else
        s = hEmitDouble( value )

    end select

	hWriteLine( s, FALSE, TRUE )

end sub

'':::::
private sub _emitVarIniI64 _
	( _
		byval dtype as integer, _
		byval value as longint _
	)

    dim as string s

    select case as const dtype
    case FB_DATATYPE_ULONGINT, FB_DATATYPE_ULONG
        '' Treat as unsigned
        s = hEmitUlong( value )

    case else
        s = hEmitLong( value )

    end select

	hWriteLine( s, FALSE, TRUE )

end sub

'':::::
private sub _emitVarIniOfs _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer _
	)

	hWriteLine( hEmitOffset( sym, ofs ), FALSE, TRUE )

end sub

private sub hEmitVarIniStr _
	( _
		byval totlgt as integer, _
		byref s as string, _
		byval litlgt as integer, _
        byval is_wstr as integer _
	)

    '' String literal too long? (GCC would show a warning)
    if( totlgt < litlgt ) then
        '' Cut off; may be empty afterwards
        s = left( s, totlgt )
    ''elseif( totlgt > litlgt ) then
        '' Too short, remaining space will be filled with 0's by GCC
    end if

	if( ctx.ini_isfixstrarray ) then
        '' Fixed-length string arrays are just emitted as a simple [w]char array,
        '' not as a 2D array, so the whole initializer needs to be merged into
        '' one string, which then has to contain terminating/padding \0's.

        s = """" + s
        if( is_wstr ) then
            s = "L" + s
        end if

        '' NULL terminator
        s += "\0"

        '' If too short, add padding 0's, to fill this one element of the
        '' fixed-length string array.
        for i as integer = litlgt to totlgt - 1
            s += "\0"
        next

        s += """"

		ctx.ini_strdata += s
    else
        '' Simple fixed-length string initialized from string literal
        s = """" + s + """"
        if( is_wstr ) then
            s = "L" + s
        end if

		hWriteLine( s, FALSE, TRUE )
	end if

end sub

'':::::
private sub _emitVarIniStr _
	( _
		byval totlgt as integer, _
		byval litstr as zstring ptr, _
		byval litlgt as integer _
	)

    static as string s

    s = *hEscape( litstr )

    hEmitVarIniStr( totlgt, s, litlgt, FALSE )

end sub

'':::::
private sub _emitVarIniWstr _
	( _
		byval totlgt as integer, _
		byval litstr as wstring ptr, _
		byval litlgt as integer _
	)

    static as string s

    s = *hEscapeUCN( litstr )

    hEmitVarIniStr( totlgt, s, litlgt, TRUE )

end sub

'':::::
private sub _emitVarIniPad _
	( _
		byval bytes as integer _
	)

	if( ctx.ini_isfixstrarray = FALSE ) then
		return
	end if

	if( ctx.ini_iswstr ) then
		bytes \= symbGetDataSize( FB_DATATYPE_WCHAR )
	end if

	if( bytes <= 0 ) then
		return
	end if

    static as string pad

    pad = """"

	do while( bytes > 0 )
		pad += "\0"
		bytes -= 1
	loop

    pad += """"

	ctx.ini_strdata += pad

end sub

'':::::
private function hIsFixStrArray _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	if( sym <> NULL andalso symbGetArrayDimensions( sym ) > 0 ) then
		select case symbGetType( sym )
		case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return TRUE
		end select
	end if

	return FALSE

end function

'':::::
private sub _emitVarIniScopeBegin _
	( _
		byval basesym as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	ctx.ini_isfixstrarray = hIsFixStrArray( sym )

	if( ctx.ini_isfixstrarray ) then
		ctx.ini_iswstr = (symbGetType( sym ) = FB_DATATYPE_WCHAR)
		ctx.ini_strdata = ""
    else
		hWriteLine( "{", FALSE )
	end if

end sub

'':::::
private sub _emitVarIniScopeEnd _
	( _
		byval basesym as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	if( ctx.ini_isfixstrarray ) then
		ctx.ini_isfixstrarray = FALSE

        '' Cut off last \0, since there is an implicit NULL already...
		if( len( ctx.ini_strdata ) >= 4 ) then
			ctx.ini_strdata = left( ctx.ini_strdata, len( ctx.ini_strdata ) - 3 ) + """"
		end if

		hWriteLine( ctx.ini_strdata )
    else
		hWriteLine( "}", FALSE )
	end if

end sub

'':::::
private sub _emitVarIniSeparator _
	( _
		byval basesym as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

	if( hIsFixStrArray( sym ) = FALSE ) then
		hWriteLine( ", ", FALSE, TRUE )
	end if

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
		ctx.linenum = 0
	end if


	if( symbIsExport( proc ) ) then
		ln += "__declspec(dllexport) "
	end if


	if( symbIsPublic( proc ) = FALSE ) then
		ln += "static "
	end if

	''
    hEmitUDT( symbGetSubType( proc ), typeIsPtr( symbGetType( proc ) ) )

	ln += *hDtypeToStr( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), symbGetSubType( proc ), DT2STR_OPTION_STRINGRETFIX )
	ln += hCallConvToStr( proc ) & " "

	if( (proc->attrib and FB_SYMBATTRIB_NAKED) <> 0 ) then
		ln += "__attribute__ ((naked)) "
	end if

	ln += *symbGetMangledName( proc )

	ln += hEmitFuncParams( proc, FALSE )

	hWriteLine( ln, FALSE, TRUE )

	hWriteLine( "{", FALSE, TRUE )
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
	hWriteLine( "}", FALSE, TRUE )

end sub

'':::::
private sub _emitScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

	hWriteLine( "{", FALSE, TRUE )
	ctx.identcnt += 1

end sub

'':::::
private sub _emitScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

	ctx.identcnt -= 1
	hWriteLine( "}", TRUE, TRUE )

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
