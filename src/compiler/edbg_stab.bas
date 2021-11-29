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
	typecnt         as uinteger

	label           as FBSYMBOL ptr
	lnum            as integer
	pos             as integer
	isnewline       as integer

	firstline       as integer                  '' first non-decl line
	lastline        as integer                  '' last  /

	filename        as zstring * FB_MAXPATHLEN+1
	incfile         as zstring ptr
end type

declare sub hDeclUDT _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimtbelements as integer _
	)

declare sub hDeclENUM _
	( _
		byval sym as FBSYMBOL ptr _
	)

declare function hDeclPointer _
	( _
		byref dtype as integer _
	) as string

declare function hGetDataType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval arraydimensions as integer = 0 _
	) as string

'' globals
	dim shared ctx as EDBGCTX

	'' same order as FB_DATATYPE
	'' Mapping dtype => stabs type tag (t*) as declared in the strings in the stabsTb()
	dim shared remapTB(0 to FB_DATATYPES-1) as integer = _
	{ _
		 7, _                                   '' void
		16, _                                   '' boolean
		 2, _                                   '' byte
		 3, _                                   '' ubyte
		 4, _                                   '' char
		 5, _                                   '' short
		 6, _                                   '' ushort
		 6, _                                   '' wchar
		 1, _                                   '' int
		 8, _                                   '' uint
		 1, _                                   '' enum
		 1, _                                   '' long
		 8, _                                   '' ulong
		 9, _                                   '' longint
		10, _                                   '' ulongint
		11, _                                   '' single
		12, _                                   '' double
		13, _                                   '' string
		14, _                                   '' fix-len string
		17  _                                   '' va_list
	}

	dim shared stabsTb(0 to ...) as const zstring ptr = _
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
		@"pchar:t15=*4;", _  '' used for the data ptr in the string:t13 declaration only
		@"boolean:t16=@s8;-16", _
		@"va_list:t17=-11" _
	}

sub edbgInit( )
	'' Remap wchar to target-specific type
	remapTB(FB_DATATYPE_WCHAR) = remapTB(env.target.wchar)

	'' The above tables assume 32bit, but that's ok because -gen gas
	'' currently only supports 32bit x86 anyways, and this stabs emitter
	'' is only used with -gen gas.
	assert( fbIs64bit( ) = FALSE )
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
private sub hSTABLABEL _
	( _
		byval label as zstring ptr _
	) static

	dim ostr as string

	ostr = *label
	ostr += ":"
	emitWriteStr( ostr )

end sub

sub edbgEmitHeader( byval filename as zstring ptr )
	dim as string lname

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	ctx.typecnt     = 1
	ctx.label       = NULL
	ctx.incfile     = NULL

	'' ctx.filename is never used
	ctx.filename   = *filename

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
	emitSetSection( IR_SECTION_CODE, 0 )
	hSTABLABEL( lname )

	'' (known) type definitions
	for i as integer = lbound( stabsTb ) to ubound( stabsTb )
		hEmitSTABS( STAB_TYPE_LSYM, stabsTb(i), 0, 0, "0" )
		ctx.typecnt += 1
	next

	emitWriteStr( "" )

end sub

'':::::
sub edbgEmitFooter( ) static
	dim as string lname

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	emitSetSection( IR_SECTION_CODE, 0 )

	'' no checkings after this
	lname = *symbUniqueLabel( )
	hEmitSTABS( STAB_TYPE_SO, "", 0, 0, lname )

	hSTABLABEL( lname )

end sub

'':::::
sub edbgLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos_ as integer, _
		ByVal filename As zstring ptr _
	)

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	if( ctx.lnum > 0 ) then
		ctx.pos = pos_ - ctx.pos
		if( ctx.pos > 0 ) then
			edbgEmitLine( proc, ctx.lnum, ctx.label )
			ctx.isnewline = TRUE
		end if
	end if

	edbgInclude( filename )

	ctx.pos = pos_
	ctx.lnum = lnum
	if( ctx.isnewline ) then
		ctx.label = symbAddLabel( NULL )
		hSTABLABEL( symbGetMangledName( ctx.label ) )
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

	if( env.clopt.debuginfo = FALSE ) then
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

	if( env.clopt.debuginfo = FALSE ) then
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

	if( env.clopt.debuginfo = FALSE ) then
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

	if( env.clopt.debuginfo = FALSE ) then
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

	if( env.clopt.debuginfo = FALSE ) then
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

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	hSTABLABEL( symbGetMangledName( s->scp.dbg.inilabel ) )

end sub

'':::::
sub edbgEmitScopeEND _
	( _
		byval s as FBSYMBOL ptr _
	) static

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	hSTABLABEL( symbGetMangledName( s->scp.dbg.endlabel ) )

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
			if (symbIsParamVar(s)) then
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

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	'' For procs defined in include files we must emit corresponding
	'' include file blocks, so they appear as being declared in the include
	'' file rather than the toplevel .bas file name.
	edbgInclude( symbGetProcIncFile( proc ) )

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
	ctx.lnum = 0
	ctx.pos = 0
	ctx.label = NULL

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

			'' Don't emit debug info for parameter variables (the
			'' parameters will be emitted instead), temporaries,
			'' function result variables, or fake dynamic array
			'' variables (the descriptors will be emitted instead).
			if( (symbGetAttrib( s ) and _
				(FB_SYMBATTRIB_PARAMVARBYDESC or _
				FB_SYMBATTRIB_PARAMVARBYVAL or _
				FB_SYMBATTRIB_PARAMVARBYREF or _
				FB_SYMBATTRIB_TEMP or _
				FB_SYMBATTRIB_FUNCRESULT or _
				FB_SYMBATTRIB_DYNAMIC)) = 0 ) then
				'' And nothing marked IMPLICIT either (e.g. symbAddImplicitVar(),
				'' some implicitly generated vars are not TEMPs)
				if( symbGetIsImplicit( s ) = FALSE ) then
					edbgEmitLocalVar( s, symbIsStatic( s ) )
				end if
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

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	''
	procname = *symbGetMangledName( proc )

	''
	hDeclLocalVars( proc, proc, initlabel, exitlabel )

	lname = *symbUniqueLabel( )
	hSTABLABEL( lname )

	'' emit end proc (FUN with a null string)
	hEmitSTABS( STAB_TYPE_FUN, "", 0, 0, lname + "-" + procname )

	''
	ctx.isnewline = TRUE
	ctx.lnum = 0
	ctx.pos = 0
	ctx.label = NULL

end sub

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

private function hGetDataType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval requesteddimtbelements as integer _
	) as string

	dim as integer dtype = any, dimtbelements = any
	dim as FBSYMBOL ptr subtype = any
	dim as string desc

	if( sym = NULL ) then
		return str( remapTB(FB_DATATYPE_VOID) )
	end if

	''
	'' HACK: When emitting array descriptor types, we don't always emit the
	'' whole FBARRAYDIM dimTB, but only the actually used dimensions.
	''
	'' This makes a difference (only) for arrays declared with unknown
	'' dimension count (array()), where the descriptor will have room for
	'' FB_MAXARRAYDIMS dimensions but not necessarily all of that are
	'' actually used.
	''
	'' However, we still emit the descriptor's full length in bytes - it's
	'' just that the memory at the end won't be visible as fields when
	'' inspecting with the debugger, just like padding bytes. Basically the
	'' whole unused part of the dimTB will be treated as padding, which is
	'' what it basically is, anyways.
	''
	dimtbelements = 0

	'' Shouldn't be a dynamic array - only the descriptor is emitted
	assert( symbIsDynamic( sym ) = FALSE )

	if( symbIsParamVarBydesc( sym ) ) then
		'' Bydesc parameter, need to emit as the real descriptor type
		'' (it's really a pointer/ref, but that's already handled by edbgEmitProcArg())
		dtype = FB_DATATYPE_STRUCT
		subtype = sym->var_.array.desctype
		dimtbelements = symbGetArrayDimensions( sym )
	else
		dtype = symbGetType( sym )
		subtype = symbGetSubtype( sym )

		'' TODO: handle byref functions?

		if( symbIsVar( sym ) or symbIsField( sym ) ) then
			'' Looks like reference vars need to be emitted as pointers;
			'' at least that's how g++ -gstabs seems to do it, and the gdb docs
			'' don't mention any way to encode references in STABS.
			'' Byref parameters on the other hand have a special "v" prefix,
			'' this is handled in edbgEmitProcArg().
			if( symbIsRef( sym ) ) then
				assert( symbIsParamVar( sym ) = FALSE )
				dtype = typeAddrOf( dtype )
			end if

			'' Fixed-size array?
			if( symbGetArrayDimensions( sym ) > 0 ) then
				desc += str( ctx.typecnt ) + "="
				ctx.typecnt += 1

				'' Normally we want to emit all fixed-size arrays with
				'' their proper dimensions & bounds - the only exception
				'' is the one-dimensional dimTB in array descriptor
				'' types (also see the above HACK).
				if( requesteddimtbelements > 0 ) then
					assert( symbGetArrayDimensions( sym ) = 1 )
					desc += "ar1;"
					desc += "0;"
					desc += str( requesteddimtbelements - 1 ) + ";"
				else
					for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
						desc += "ar1;"
						desc += str( symbArrayLbound( sym, i ) ) + ";"
						desc += str( symbArrayUbound( sym, i ) ) + ";"
					next
				end if
			end if

			if( symbIsDescriptor( sym ) ) then
				dimtbelements = symbGetArrayDimensions( sym->var_.desc.array )
			end if
		end if
	end if

	'' If array dimensions still unknown, assume 1
	if( dimtbelements < 0 ) then
		dimtbelements = 1
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
		if( subtype->udt.dbg.typenum = INVALID ) then
			hDeclUDT( subtype, dimtbelements )
		end if

		desc += str( subtype->udt.dbg.typenum )

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

	'' ordinary type..
	case else
		desc += str( remapTB(dtype) )

	end select

	function = desc

end function

private sub hDeclUDT _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dimtbelements as integer _
	)

	dim as FBSYMBOL ptr fld = any
	dim as string desc

	assert( symbIsStruct( sym ) )

	sym->udt.dbg.typenum = ctx.typecnt
	ctx.typecnt += 1

	desc = *symbGetDBGName( sym )

	desc += ":Tt" + str( sym->udt.dbg.typenum ) + "=s" + str( symbGetLen( sym ) )

	fld = symbUdtGetFirstField( sym )
	while( fld )

		'' Skip fake dynamic array fields, only the descriptor is emitted
		if( symbIsDynamic( fld ) = FALSE ) then
			'' Pass dimtbelements on to hGetDataType() so that the
			'' dimTB of array descriptors will be emitted smaller than
			'' it actually is. (the dimTB is the only array field in
			'' a descriptor type, and dimtbelements will only be set
			'' if declaring a descriptor type, so we can just pass it
			'' always, to keep it simple)
			desc += *symbGetName( fld ) + ":" + hGetDataType( fld, dimtbelements )
			desc += "," + str( symbGetFieldBitOffset( fld ) )
			desc += "," + str( symbGetFieldBitLength( fld ) )
			desc += ";"
		end if

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
		desc += *symbGetName( e ) + ":" + str( symbGetConstInt( e ) ) + ","

		e = symbGetENUMNextElm( e )
	loop

	desc += ";"

	hEmitSTABS( STAB_TYPE_LSYM, desc, 0, 0, "0" )

end sub

'' Add debug info for public/shared globals, but not local statics
sub edbgEmitGlobalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval section as integer _
	)

	dim as integer t = any, attrib = any
	dim as string desc

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	'' Ignore static locals here (they are handled like other locals during
	'' edbgEmitProcFooter() -> hDeclLocalVars())
	if( symbIsLocal( sym ) ) then
		exit sub
	end if

	'' This function should only be called for "allocatable" globals
	assert( symbIsShared( sym ) or symbIsCommon( sym ) )
	'' PUBLIC (allocated EXTERNs) on a variable implies SHARED
	assert( iif( symbIsPublic( sym ), symbIsShared( sym ), TRUE ) )

	'' (unallocated EXTERNs aren't emitted in the current module)
	assert( symbIsExtern( sym ) = FALSE )

	'' (no fake dynamic array symbols - the descriptor is emitted instead)
	assert( symbIsDynamic( sym ) = FALSE )

	'' (no debug info should be emitted for temporaries - but
	'' FB_SYMBATTRIB_TEMP isn't used with globals anyways, only locals)
	assert( symbIsTemp( sym ) = FALSE )

	'' depends on section
	select case section
	case IR_SECTION_CONST
		t = STAB_TYPE_FUN
	case IR_SECTION_BSS
		t = STAB_TYPE_LCSYM
	case else
		assert( section = IR_SECTION_DATA )
		t = STAB_TYPE_STSYM
	end select

	desc = *symbGetDBGName( sym )

	'' allocation type (static, global, etc)
	if( symbIsPublic( sym ) or symbIsCommon( sym ) ) then
		desc += ":G"
	elseif( symbIsStatic( sym ) ) then
		desc += ":S"
	else
		desc += ":"
	end if

	'' data type
	desc += hGetDataType( sym )

	hEmitSTABS( t, desc, 0, 0, *symbGetMangledName( sym ) )

end sub

sub edbgEmitLocalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isstatic as integer _
	)

	dim as integer t = any
	dim as string desc, value

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	desc = *symbGetName( sym )

	'' (no fake dynamic array symbols - the descriptor is emitted instead)
	assert( symbIsDynamic( sym ) = FALSE )

	if( isstatic ) then
		'' never referenced?
		if( symbGetIsAccessed( sym ) = FALSE ) then
			'' locals can't be public, don't check
			exit sub
		end if

		if( symbGetTypeIniTree( sym ) ) then
			t = STAB_TYPE_STSYM
		else
			t = STAB_TYPE_LCSYM
		end if
		desc += ":V"

		value = *symbGetMangledName( sym )
	else
		t = STAB_TYPE_LSYM
		desc += ":"
		value = str( symbGetOfs( sym ) )
	end if

	'' data type
	desc += hGetDataType( sym )

	hEmitSTABS( t, desc, 0, 0, value )
end sub

'' should rename to param?
sub edbgEmitProcArg( byval sym as FBSYMBOL ptr )
	dim as string desc

	if( env.clopt.debuginfo = FALSE ) then
		exit sub
	end if

	desc = *symbGetName( sym ) + ":"

	if( symbIsParamVarByVal( sym ) ) then
		desc += "p"
	else
		'' It's a reference or descriptor ptr
		assert( symbIsParamVarBydescOrByref( sym ) )
		desc += "v"
	end if

	'' data type
	desc += hGetDataType( sym )

	hEmitSTABS( STAB_TYPE_PSYM, desc, 0, 0, str( symbGetOfs( sym ) ) )
end sub

sub edbgInclude( byval incfile as zstring ptr )
	dim as string lname

	'' NOTE: originally, fbc used STAB_TYPE_BINCL and STAB_TYPE_EINCL
	'' to mark the beginning and end of an include file.  The purpose
	'' for these markers is so the linker (LD) can remove duplicate
	'' debug type information from the final EXE.  However, because
	'' fbc only emits types actually used, the end result is that
	'' type information from a header (.BI) is often different from
	'' one object module to another is generally not used in the
	'' way that BINCL/EINCL/EXCL was intended.

	'' incfile is the new include file or main file name

	'' coming from _close incfile is null so no real need to change
	If( incfile = NULL )Then
		Exit Sub
	EndIf

	'' Already handling the correct name
	if( incfile = ctx.incfile ) Then
		exit sub
	end If

	emitSetSection( IR_SECTION_CODE, 0 )
	lname = *symbUniqueLabel( )
	hEmitSTABS( STAB_TYPE_SOL, incfile, 0, 0, lname )
	hSTABLABEL( lname )

	ctx.incfile = incfile
end sub
