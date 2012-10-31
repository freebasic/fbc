'' debug emitter (stabs format) for GNU assembler (GAS)
''
'' chng: nov/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "ir.bi"
#include once "emit.bi"
#include once "emitdbg.bi"
#include once "stabs.bi"

type EDBGCTX
	typecnt			as uinteger

	label 			as FBSYMBOL ptr
	lnum 			as integer
	pos 			as integer
	isnewline		as integer

	firstline		as integer					'' first non-decl line
	lastline		as integer					'' last  /

	incfile			as zstring ptr
end type

declare sub 	 hDeclUDT				( _
											byval sym as FBSYMBOL ptr _
										)

declare sub 	 hDeclENUM				( _
											byval sym as FBSYMBOL ptr _
										)

declare function hDeclPointer			( _
											byref dtype as integer _
										) as string

declare function hDeclArrayDims			( _
											byval sym as FBSYMBOL ptr _
										) as string

declare function hGetDataType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval do_array_typing as integer = FALSE _
	) as string


'' globals
	dim shared ctx as EDBGCTX

	dim shared remapTB(0 to FB_DATATYPES-1) as integer = _
	{ _
		 7, _									'' void
		 2, _                                   '' byte
		 3, _                                   '' ubyte
		 4, _                                   '' char
		 5, _                                   '' short
		 6, _                                   '' ushort
		 6, _                                   '' wchar
		 1, _                                   '' int
		 8, _                                   '' uint
		 1, _                                   '' enum
		 8, _                                   '' bitfield
		 1, _                                   '' long
		 8, _                                   '' ulong
		 9, _                                   '' longint
		10, _                                   '' ulongint
		11, _                                   '' single
		12, _                                   '' double
		13, _                                   '' string
		14  _                                   '' fix-len string
	}

	dim shared stabsTB(0 to 15) as const zstring ptr = _
	{ _
		@"integer:t1=-1", _
		@"void:t7=-11", _
		@"byte:t2=-6", _
		@"ubyte:t3=-5", _
		@"char:t4=-2", _
		@"short:t5=-3", _
		@"ushort:t6=-7", _
		@"uinteger:t8=-8", _
		@"longint:t9=-31", _
		@"ulongint:t10=-32", _
		@"single:t11=-12", _
		@"double:t12=-13", _
		@"string:t13=s12data:15,0,32;len:1,32,32;size:1,64,32;;", _
		@"fixstr:t14=-2", _
		@"pchar:t15=*4;", _
		NULL _
	}

sub edbgInit( )
	'' Remap wchar to target-specific type
	remapTB(FB_DATATYPE_WCHAR) = remapTB(env.target.wchar)

	'' !!!FIXME!!! remap [u]long to [u]longint if target = 64-bit
end sub

'':::::
private sub hEmitSTABS _
	( _
		byval _type as integer, _
		byval _string as const zstring ptr, _
		byval _other as integer = 0, _
		byval _desc as integer = 0, _
		byval _value as const zstring ptr = @"0" _
	) static

	dim as string ostr

	ostr = ".stabs " + QUOTE
	ostr += *hEscape( _string )
	ostr += QUOTE + ","
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )
	ostr += ","
	ostr += *_value

	emitWriteStr( ostr, TRUE )

end sub

'':::::
private function hMakeSTABN _
	( _
		byval _type as integer, _
		byval _other as integer = 0, _
		byval _desc as integer = 0, _
		byval _value as const zstring ptr _
	) as zstring ptr static

	static as string ostr

	ostr = ".stabn "
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )
	ostr += ","
	ostr += *_value

	function = strptr( ostr )

end function

'':::::
private sub hEmitSTABN _
	( _
		byval _type as integer, _
		byval _other as integer = 0, _
		byval _desc as integer = 0, _
		byval _value as const zstring ptr = @"0" _
	) static


	emitWriteStr( hMakeSTABN( _type, _other, _desc, _value ), TRUE )

end sub

'':::::
private sub hEmitSTABD _
	( _
		byval _type as integer, _
		byval _other as integer = 0, _
		byval _desc as integer = 0 _
	) static

	dim as string ostr

	ostr = ".stabd "
	ostr += str( _type )
	ostr += ","
	ostr += str( _other )
	ostr += ","
	ostr += str( _desc )

	emitWriteStr( ostr, TRUE )

end sub

'':::::
private sub hLABEL _
	( _
		byval label as zstring ptr _
	) static

    dim ostr as string

	ostr = *label
	ostr += ":"
	emitWriteStr( ostr )

end sub


'':::::
sub edbgEmitHeader _
	( _
		byval filename as zstring ptr _
	) static

    dim as integer i
    dim as string stab, lname

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	''
	ctx.typecnt 	= 1

	ctx.label 		= NULL

	ctx.incfile 	= NULL

	'' emit source file name
	lname = *symbUniqueLabel( )
	emitWriteStr( ".file " + QUOTE + *hEscape( filename ) + QUOTE, TRUE )

	'' directory
	if( pathIsAbsolute( filename ) = FALSE ) then
		hEmitSTABS( STAB_TYPE_SO, hCurDir( ) + FB_HOST_PATHDIV, 0, 0, lname )
	end if

	'' file name
    hEmitSTABS( STAB_TYPE_SO, filename, 0, 0, lname )

	''
	emitSECTION( IR_SECTION_CODE, 0 )
	hLABEL( lname )

	'' (known) type definitions
	i = 0
	do
		if( stabsTb(i) = 0 ) then
			exit do
		end if
		hEmitSTABS( STAB_TYPE_LSYM, stabsTb(i), 0, 0, "0" )

		ctx.typecnt += 1
		i += 1
	loop

	emitWriteStr( "" )

	hEmitSTABS( STAB_TYPE_BINCL, filename, 0, 0 )

end sub

'':::::
sub edbgEmitFooter( ) static
	dim as string lname

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	emitSECTION( IR_SECTION_CODE, 0 )

	'' no checkings after this
	lname = *symbUniqueLabel( )
	hEmitSTABS( STAB_TYPE_SO, "", 0, 0, lname )

	hLABEL( lname )

end sub

'':::::
sub edbgLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos_ as integer _
	)

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	ctx.pos = pos_ - ctx.pos
    	if( ctx.pos > 0 ) then
    		edbgEmitLine( proc, ctx.lnum, ctx.label )
    		ctx.isnewline = TRUE
    	end if
    end if

    ctx.pos = pos_
    ctx.lnum = lnum
    if( ctx.isnewline ) then
    	ctx.label = symbAddLabel( NULL )
    	hLABEL( symbGetMangledName( ctx.label ) )
    	ctx.isnewline = FALSE
    end if

end sub

'':::::
sub edbgLineEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos_ as integer _
	)

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

    if( ctx.lnum > 0 ) then
    	ctx.pos = pos_ - ctx.pos
    	if( ctx.pos > 0 ) then
   			edbgEmitLine( proc, ctx.lnum, ctx.label )
   			ctx.isnewline = TRUE
   		end if
    	ctx.lnum = 0
    end if

end sub

'':::::
sub edbgEmitLine _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	) static

    dim as zstring ptr s

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	if( ctx.firstline = -1 ) then
		ctx.firstline = lnum
	end if

	ctx.lastline = lnum

	'' emit current line
	s = hMakeSTABN( STAB_TYPE_SLINE, _
					0, _
					lnum, _
					*symbGetMangledName( label ) + "-" + *symbGetMangledName( proc ) )

	emitWriteStr( s )

end sub

'':::::
sub edbgEmitLineFlush _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	) static

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	hEmitSTABN( STAB_TYPE_SLINE, _
				0, _
				lnum, _
				*symbGetMangledName( label ) + "-" + *symbGetMangledName( proc ) )

end sub

'':::::
sub edbgScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	) static

	'' called by ir->ast

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

	s->scp.dbg.iniline = lexLineNum( )
    s->scp.dbg.inilabel = symbAddLabel( NULL )

end sub

'':::::
sub edbgScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	) static

	'' called by ir->ast

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

	s->scp.dbg.endline = lexLineNum( )
    s->scp.dbg.endlabel = symbAddLabel( NULL )

end sub

'':::::
sub edbgEmitScopeINI _
	( _
		byval s as FBSYMBOL ptr _
	) static

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

    hLABEL( symbGetMangledName( s->scp.dbg.inilabel ) )

end sub

'':::::
sub edbgEmitScopeEND _
	( _
		byval s as FBSYMBOL ptr _
	) static

    if( env.clopt.debug = FALSE ) then
    	exit sub
    end if

    hLABEL( symbGetMangledName( s->scp.dbg.endlabel ) )

end sub

'':::::
sub edbgProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	'' called by ir->ast

	proc->proc.ext->dbg.iniline = lexLineNum( )

end sub

'':::::
sub edbgProcEnd _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	'' called by ir->ast

	proc->proc.ext->dbg.endline = lexLineNum( )

end sub

'':::::
sub edbgProcEmitBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	'' called by emit->ir

	ctx.firstline = -1
	ctx.lastline  = -1

end sub

private sub hDeclArgs(byval proc as FBSYMBOL ptr)
	dim as FBSYMBOL ptr s = symbGetProcSymbTbHead( proc )
	while (s)
		if (symbIsVar(s)) then
			'' Parameter?
			if (symbIsParam(s)) then
				edbgEmitProcArg(s)
			end if
		end if
		s = s->next
	wend
end sub

'':::::
sub edbgEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr _
	) static

    dim as string desc, procname
    dim as zstring ptr incfile

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	'' procs defined in include files must be declared inside the proper blocks
	incfile = symbGetProcIncFile( proc )
	if( incfile <> ctx.incfile ) then

        edbgIncludeEnd( )

		if( incfile <> NULL ) then
			edbgIncludeBegin( incfile, incfile )
		end if

		ctx.incfile = incfile

	end if

	'' main?
	if( symbGetIsMainProc( proc ) ) then
		'' main proc (the entry point)
		hEmitSTABS( STAB_TYPE_MAIN, _
					fbGetEntryPoint( ), _
					0, _
					1, _
					*symbGetMangledName( proc ) )

    	'' set the entry line
    	hEmitSTABD( STAB_TYPE_SLINE, 0, 1 )

    	'' also correct the end and start lines
    	proc->proc.ext->dbg.iniline = 1
    	proc->proc.ext->dbg.endline = lexLineNum( )

    	desc = fbGetEntryPoint( )
    else
    	desc = *symbGetDBGName( proc )
    end if

	''
	procname = *symbGetMangledName( proc )

	if( symbIsPublic( proc ) ) then
		desc += ":F"
	else
		desc += ":f"
	end if

	desc += hGetDataType( proc )

	hEmitSTABS( STAB_TYPE_FUN, desc, 0, proc->proc.ext->dbg.iniline, procname )

	hDeclArgs( proc )

	''
	ctx.isnewline = TRUE
	ctx.lnum	  = 0
	ctx.pos	  	  = 0
	ctx.label	  = NULL

end sub

'':::::
private sub hDeclLocalVars _
	( _
		byval proc as FBSYMBOL ptr, _
		byval blk as FBSYMBOL ptr, _
		byval inilabel as FBSYMBOL ptr, _
		byval endlabel as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr shead, s
	static as integer scopecnt

	'' proc?
	if( symbIsProc( blk ) ) then
		shead = symbGetProcSymbTbHead( blk )

	'' scope block..
	else
		shead = symbGetScopeSymbTbHead( blk )
	end if

	'' for each symbol..
	scopecnt = 0
	s = shead
	do while( s <> NULL )

    	select case symbGetClass( s )
    	'' variable?
    	case FB_SYMBCLASS_VAR

			'' not an argument, temporary, descriptor or func result?
    		if( (symbGetAttrib( s ) and _
    			 (FB_SYMBATTRIB_PARAMBYDESC or _
			   	  FB_SYMBATTRIB_PARAMBYVAL or _
			   	  FB_SYMBATTRIB_PARAMBYREF or _
    		   	  FB_SYMBATTRIB_TEMP or _
    		   	  FB_SYMBATTRIB_DESCRIPTOR or _
    		   	  FB_SYMBATTRIB_FUNCRESULT)) = 0 ) then

				edbgEmitLocalVar( s, symbIsStatic( s ) )

			end if

		'' scope? must be emitted later, due the GDB quirks
		case FB_SYMBCLASS_SCOPE
			scopecnt += 1
		end select

		s = s->next
	loop

	'' emit block (change the scope)
	hEmitSTABN( STAB_TYPE_LBRAC, _
				0, _
				0, _
				*symbGetMangledName( inilabel ) + "-" + *symbGetMangledName( proc ) )

	if( scopecnt > 0 ) then
		'' for each scope..
		s = shead
		do while( s <> NULL )
    		if( symbIsScope( s ) ) then
    			hDeclLocalVars( proc, s, s->scp.dbg.inilabel, s->scp.dbg.endlabel )
    		end if

			s = s->next
    	loop
    end if

	hEmitSTABN( STAB_TYPE_RBRAC, _
				0, _
				0, _
				*symbGetMangledName( endlabel ) + "-" + *symbGetMangledName( proc ) )

end sub

'':::::
sub edbgEmitProcFooter _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	) static

    dim as string procname, lname

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	''
	procname = *symbGetMangledName( proc )

    ''
    hDeclLocalVars( proc, proc, initlabel, exitlabel )

	lname = *symbUniqueLabel( )
	hLABEL( lname )

	'' emit end proc (FUN with a null string)
	hEmitSTABS( STAB_TYPE_FUN, "", 0, 0, lname + "-" + procname )

	''
	ctx.isnewline = TRUE
	ctx.lnum	  = 0
	ctx.pos	  	  = 0
	ctx.label	  = NULL

end sub

'':::::
private function hDeclUDTField _
	( _
		byval sname as zstring ptr, _
		byval stype as integer, _
		byval soffs as integer, _
		byval ssize as integer, _
		byval stypeopt as zstring ptr = NULL _
	) as string static

	dim as string desc

    desc = *sname
    desc += ":"

    if( typeIsPtr( stype ) ) then
    	desc += hDeclPointer( stype )
    end if

	if( stypeopt = NULL ) then
		desc += str( remapTB(stype) )
	else
		desc += *stypeopt
	end if

	desc += "," + str( soffs * 8 ) + "," + str( ssize * 8 ) + ";"

	function = desc

end function

'':::::
private function hDeclDynArray _
	( _
		byval sym as FBSYMBOL ptr _
	) as string static

    dim as string desc, dimdesc
    dim as FBVARDIM ptr d = any
    dim as integer ofs = any, i = any

	'' declare the array descriptor
	desc = str( ctx.typecnt ) + "=s" + _
		   str( (FB_ARRAYDESCLEN + FB_ARRAYDESC_DIMLEN * symbGetArrayDimensions( sym )) * 8 )
	ctx.typecnt += 1

	dimdesc = hDeclArrayDims( sym )

    dimdesc += hGetDataType( sym, TRUE )
    
	'' data	as any ptr
	desc += hDeclUDTField( "data", _
		    			   FB_DATATYPE_POINTER, _
		                   offsetof( FB_ARRAYDESC, data ), _
		                   FB_POINTERSIZE, _
		                   strptr( dimdesc ) )
	'' ptr as any ptr
	desc += hDeclUDTField( "ptr", _
						   FB_DATATYPE_POINTER, _
		                   offsetof( FB_ARRAYDESC, ptr ), _
		                   FB_POINTERSIZE, _
		                   strptr( dimdesc ) )
    '' size	as integer
	desc += hDeclUDTField( "size", _
						   FB_DATATYPE_INTEGER, _
						   offsetof( FB_ARRAYDESC, size ), _
						   FB_INTEGERSIZE )
    '' element_len as integer
    desc += hDeclUDTField( "elen", _
    					   FB_DATATYPE_INTEGER, _
    					   offsetof( FB_ARRAYDESC, element_len ), _
    					   FB_INTEGERSIZE )
    '' dimensions as integer
    desc += hDeclUDTField( "dims", _
    					   FB_DATATYPE_INTEGER, _
    					   offsetof( FB_ARRAYDESC, dimensions ), _
    					   FB_INTEGERSIZE )

    '' dimension fields
    ofs = FB_ARRAYDESCLEN
    i = 1
    d = symbGetArrayFirstDim( sym )
    do
    	dimdesc = "dim" + str( i )

    	'' elements as integer
    	desc += hDeclUDTField( dimdesc + "_elemns", _
    						   FB_DATATYPE_INTEGER, _
    						   ofs + offsetof( FB_ARRAYDESCDIM, elements ), _
    						   FB_INTEGERSIZE )
    	'' lbound as integer
    	desc += hDeclUDTField( dimdesc + "_lbound", _
    						   FB_DATATYPE_INTEGER, _
    						   ofs + offsetof( FB_ARRAYDESCDIM, lbound ), _
    						   FB_INTEGERSIZE )
    	'' ubound as integer
    	desc += hDeclUDTField( dimdesc + "_ubound", _
    						   FB_DATATYPE_INTEGER, _
    						   ofs + offsetof( FB_ARRAYDESCDIM, ubound ), _
    						   FB_INTEGERSIZE )

    	ofs += FB_ARRAYDESC_DIMLEN

    	if( d = NULL ) then
    		exit do
    	end if

    	d = d->next
    loop while( d <> NULL )

	desc += ";"

	function = desc

end function

'':::::
private function hDeclPointer _
	( _
		byref dtype as integer _
	) as string static

    dim as string desc

    desc = ""
    do while( typeIsPtr( dtype ) )
    	dtype = typeDeref( dtype )
    	desc += str( ctx.typecnt ) + "=*"
    	ctx.typecnt += 1
    loop

    function = desc

end function

'':::::
private function hDeclArrayDims _
	( _
		byval sym as FBSYMBOL ptr _
	) as string static

	dim as FBVARDIM ptr d
    dim as string desc

    desc = str( ctx.typecnt ) + "="
    ctx.typecnt += 1

    d = symbGetArrayFirstDim( sym )
    do while( d <> NULL )
    	desc += "ar1;"
    	desc += str( d->lower ) + ";"
    	desc += str( d->upper ) + ";"
    	d = d->next
    loop

    function = desc

end function

'':::::
private function hGetDataType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval do_array_typing as integer _
	) as string

	dim as integer dtype
	dim as FBSYMBOL ptr subtype
	dim as string desc

    if( sym = NULL ) then
    	return str( remapTB(FB_DATATYPE_VOID) )
    end if

    '' array?
    if( do_array_typing = FALSE ) then
	    if( symbIsArray( sym ) ) then
	    	'' dynamic?
	    	if( symbIsDynamic( sym ) or symbIsParamByDesc( sym ) ) then
	    		desc = hDeclDynArray( sym )
	    	else
	    		desc = hDeclArrayDims( sym )
			end if
	    else
	    	desc = ""
	    end if
	else
   		desc = ""
	end if

    dtype = symbGetType( sym )
    subtype = symbGetSubtype( sym )
    
    if( do_array_typing ) then
    	dtype = typeAddrOf( dtype )
    end if

    '' pointer?
    if( typeIsPtr( dtype ) ) then
    	desc += hDeclPointer( dtype )
    end if

    '' the const qualifier isn't taken into account
    dtype = typeUnsetIsConst( dtype )

    select case as const dtype
    '' UDT?
    case FB_DATATYPE_STRUCT
    	if( symbIsDescriptor( sym ) = FALSE ) then
    		if( subtype->udt.dbg.typenum = INVALID ) then
    			hDeclUDT( subtype )
    		end if

    		desc += str( subtype->udt.dbg.typenum )
    	end if

    '' ENUM?
    case FB_DATATYPE_ENUM
    	if( subtype->enum_.dbg.typenum = INVALID ) then
    		hDeclENUM( subtype )
    	end if

    	desc += str( subtype->enum_.dbg.typenum )

    '' function pointer?
    case FB_DATATYPE_FUNCTION
    	desc += str( ctx.typecnt ) + "=f"
    	ctx.typecnt += 1
    	desc += hGetDataType( subtype )

    '' forward reference?
    case FB_DATATYPE_FWDREF
    	desc += str( remapTB(FB_DATATYPE_VOID) )

    '' bitfield?
    case FB_DATATYPE_BITFIELD
    	desc += hGetDataType( subtype )

    '' ordinary type..
    case else
    	desc += str( remapTB(dtype) )

    end select

    function = desc

end function

private sub hDeclUDT( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr fld = any
	dim as string desc

	sym->udt.dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

	desc = *symbGetDBGName( sym )

	desc += ":Tt" + str( sym->udt.dbg.typenum ) + "=s" + str( symbGetUDTUnpadLen( sym ) )

	fld = symbUdtGetFirstField( sym )
	while( fld )
		desc += *symbGetName( fld ) + ":" + hGetDataType( fld )
		desc += "," + str( symbGetUDTElmBitOfs( fld ) )
		desc += "," + str( symbGetUDTElmBitLen( fld ) )
		desc += ";"
		fld = symbUdtGetNextField( fld )
	wend

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )
end sub

'':::::
private sub hDeclENUM _
	( _
		byval sym as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr e
    dim as string desc

	sym->enum_.dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

	desc = *symbGetDBGName( sym )

	desc += ":T" + str( sym->enum_.dbg.typenum ) + "=e"

	e = symbGetENUMFirstElm( sym )
	do while( e <> NULL )
        desc += *symbGetName( e ) + ":" + str( symbGetConstValInt( e ) ) + ","

		e = symbGetENUMNextElm( e )
	loop

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )

end sub

'':::::
sub edbgEmitGlobalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval section as integer _
	) static

	dim as integer t, attrib
	dim as string desc
	dim as zstring ptr sname

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	'' temporary?
	if( symbIsTemp( sym ) ) then
		exit sub
	end if

	'' really global? (because the static local vars)
	if( symbIsLocal( sym ) ) then
		exit sub
	end if

	'' depends on section
	select case section
	case IR_SECTION_CONST
		t = STAB_TYPE_FUN
	case IR_SECTION_DATA
		t = STAB_TYPE_STSYM
	case IR_SECTION_BSS
		t = STAB_TYPE_LCSYM
	end select

    '' allocation type (static, global, etc)
    desc = *symbGetDBGName( sym )

    attrib = symbGetAttrib( sym )
    if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_COMMON)) > 0 ) then
    	desc += ":G"
    elseif( (attrib and FB_SYMBATTRIB_STATIC) > 0 ) then
        desc += ":S"
    else
    	desc += ":"
    end if

    '' data type
    desc += hGetDataType( sym )

	'' hack to fix the stabs data for global redim-arrays
	'' see: http://www.freebasic.net/forum/viewtopic.php?p=117584#117584
	#if 1 ''SARG BEGIN
	'' workaround in case redim shared : use of back link !!!
	if( right(desc, 2) = ":S" ) then
		desc = *symbGetDBGName( sym->var_.desc.array ) + ":S" + hGetDataType( sym->var_.desc.array )
	end if
	#endif ''SARG END

    ''
    if( symbIsDynamic( sym ) ) then
    	sname = symbGetMangledName( symbGetArrayDescriptor( sym ) )
    else
    	sname = symbGetMangledName( sym )
    end if

    ''
    hEmitSTABS( t, desc, 0, 0, *sname )

end sub

'':::::
sub edbgEmitLocalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isstatic as integer _
	) static

	dim as integer t
	dim as string desc, value

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

    desc = *symbGetName( sym )

    ''
    if( isstatic ) then
    	'' never referenced?
    	if( symbGetIsAccessed( sym ) = FALSE ) then
    		'' locals can't be public, don't check
    		exit sub
    	end if

		if( symbGetIsInitialized( sym ) ) then
			t = STAB_TYPE_STSYM
		else
			t = STAB_TYPE_LCSYM
		end if
		desc += ":V"

    	'' dynamic array? use the descriptor
    	if( symbIsDynamic( sym ) ) then
    		value = *symbGetMangledName( symbGetArrayDescriptor( sym ) )
    	else
			value = *symbGetMangledName( sym )
		end if

    else
    	t = STAB_TYPE_LSYM
    	desc += ":"
    	'' dynamic array? use the descriptor
    	if( symbIsDynamic( sym ) ) then
    		value = str( symbGetOfs( symbGetArrayDescriptor( sym ) ) )
    	else
    		value = str( symbGetOfs( sym ) )
    	end if
    end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( t, desc, 0, 0, value )

end sub

'':::::
sub edbgEmitProcArg _
	( _
		byval sym as FBSYMBOL ptr _
	) static

	dim as string desc

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

    desc = *symbGetName( sym ) + ":"

    if( symbIsParamByVal( sym ) ) then
	    desc += "p"

	elseif( symbIsParamByRef( sym ) ) then
		desc += "v"

	elseif( symbIsParamByDesc( sym ) ) then
    	desc += "v"
	end if

    '' data type
    desc += hGetDataType( sym )

    ''
    hEmitSTABS( STAB_TYPE_PSYM, desc, 0, 0, str( symbGetOfs( sym ) ) )

end sub

'':::::
sub edbgIncludeBegin _
	( _
		byval filename as zstring ptr, _
		byval incfile as zstring ptr _
	) static

	dim as string lname

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	ctx.incfile = incfile

	hEmitSTABS( STAB_TYPE_BINCL, filename, 0, 0 )

	emitSECTION( IR_SECTION_CODE, 0 )

	lname = *symbUniqueLabel( )

	hEmitSTABS( STAB_TYPE_SOL, filename, 0, 0, lname )

	hLABEL( lname )

end sub

'':::::
sub edbgIncludeEnd ( ) static

	if( env.clopt.debug = FALSE ) then
		exit sub
	end if

	if( ctx.incfile = NULL ) then
		exit sub
	end if

	hEmitSTABS( STAB_TYPE_EINCL, "", 0, 0 )

	ctx.incfile = NULL

end sub


