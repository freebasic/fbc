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


'' intrinsic runtime lib memory functions (ALLOCATE, SWAP, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 15 ) = _
	{ _
		/' fb_NullPtrChk ( byval p as any ptr, byval linenum as integer, byval fname as zstring ptr ) as any ptr '/ _
		( _
			@FB_RTL_NULLPTRCHK, NULL, _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemCopy cdecl ( dst as any, src as any, byval bytes as integer ) as void '/ _
		( _
			@FB_RTL_MEMCOPY, @"memcpy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_GCCBUILTIN, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemSwap ( dst as any, src as any, byval bytes as integer ) as void '/ _
		( _
			@FB_RTL_MEMSWAP, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemCopyClear ( dst as any, byval dstlen as integer, src as any, byval srclen as integer ) as void '/ _
		( _
			@FB_RTL_MEMCOPYCLEAR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fre ( ) as uinteger '/ _
		( _
			@"fre", @"fb_GetMemAvail", _
			FB_DATATYPE_UINT, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' allocate ( byval bytes as integer ) as any ptr '/ _
		( _
			@"allocate", @"malloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' callocate ( byval bytes as integer ) as any ptr '/ _
		( _
			@"callocate", @"calloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
 			NULL, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' reallocate ( byval p as any ptr, byval bytes as integer ) as any ptr '/ _
		( _
			@"reallocate", @"realloc", _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
 			NULL, FB_RTL_OPT_NOQB, _
			2, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' deallocate ( byval p as any ptr ) as void '/ _
		( _
			@"deallocate", @"free", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' clear ( dst as any, byval value as integer = 0, byval bytes as integer ) as void '/ _
		( _
			@"clear", @"memset", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_GCCBUILTIN, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' new ( byval bytes as uinteger ) as any ptr '/ _
		( _
			cast( zstring ptr, AST_OP_NEW ), NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_OPERATOR, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' new[] ( byval bytes as uinteger ) as any ptr '/ _
		( _
			cast( zstring ptr, AST_OP_NEW_VEC ), NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_OPERATOR, _
			1, _
			{ _
				( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' delete ( byval ptr as any ptr ) '/ _
		( _
			cast( zstring ptr, AST_OP_DEL ), NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_OPERATOR, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' delete[] ( byval ptr as any ptr ) '/ _
		( _
			cast( zstring ptr, AST_OP_DEL_VEC ), NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_OVER or FB_RTL_OPT_OPERATOR, _
			1, _
			{ _
				( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlMemModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

	'' remap the new/new[] size param, size_t can be unsigned (int | long),
	'' making the mangling incompatible..
    dim as integer dtype = symbGetCStdType( FB_CSTDTYPE_SIZET )

#macro hRemap(op, dtype)
    scope
    	dim as FBSYMBOL ptr sym = any
		sym = symbGetCompOpOvlHead( NULL, op )
    	if( sym <> NULL ) then
    		sym = symbGetProcHeadParam( sym )
    		if( sym <> NULL ) then
    			symbGetFullType( sym ) = dtype
    		end if
    	end if
    end scope
#endmacro

	'' new
	hRemap( AST_OP_NEW, dtype )

    '' new[]
    hRemap( AST_OP_NEW_VEC, dtype )

end sub

'':::::
sub rtlMemModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlNullPtrCheck _
	( _
		byval p as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

   	function = NULL

   	proc = astNewCALL( PROCLOOKUP( NULLPTRCHK ) )

	'' ptr
	if( astNewARG( proc, _
				   astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, p ), _
				   typeAddrOf( FB_DATATYPE_VOID ) ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewARG( proc, _
				   astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), _
				   FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMemCopy _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval bytes as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( MEMCOPY ) )

    '' dst as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewARG( proc, astNewCONSTi( bytes, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    function = proc

end function

'':::::
function rtlMemSwap _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr proc = any
    dim as integer bytes = any, src_dtype = any, dst_dtype = any

    function = FALSE

	src_dtype = astGetDataType( src )
	dst_dtype = astGetDataType( dst )

	select case src_dtype
	case FB_DATATYPE_STRUCT
		'' returned in registers?
		if( astIsCALL( src ) ) then
			dim as FBSYMBOL ptr subtype = src->subtype
			'' patch type
			if( symbIsUDTReturnedInRegs( subtype ) ) then
				astSetType( src, symbGetUDTRetType( subtype ), NULL )
			end if
		end if

	'case FB_DATATYPE_CLASS
		' ...
	end select

	'' simple type?
	'' !!!FIXME!!! other classes should be allowed too, but pointers??
	dim as integer l_bf = astIsBITFIELD( dst ), r_bf = astIsBITFIELD( src )
	if( (dst_dtype <> FB_DATATYPE_STRUCT) and (astIsVAR( dst ) or (l_bf or r_bf)) ) then

		dim as ASTNODE ptr d = any, s = any
		dim as FBSYMBOL ptr l_sym = any, r_sym = any, tmpvar = any

		'' left-side is bitfield...
		if( l_bf ) then

			'' allocate temp var
			dst_dtype = symbGetFullType( astGetSubtype( astGetLeft( dst ) ) )
			l_sym = symbAddTempVar( dst_dtype )

			'' left-side references temp var
			d = astNewVAR( l_sym )

			'' assign bitfield to temp var
			astAdd( astNewASSIGN( d, astCloneTree( dst ) ) )

		else
			'' left-side references tree
			d = dst
		end if

		'' high-level IR? use a temp var...
		if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
		    tmpvar = symbAddTempVar( dst_dtype, astGetSubType( d ) )
			astAdd( astNewASSIGN( astNewVAR( tmpvar, , dst_dtype, astGetSubType( d ) ), _
                                  astCloneTree( d ) ) )
		else
			'' push left-side
			astAdd( astNewSTACK( AST_OP_PUSH, astCloneTree( d ) ) )
		end if

		'' right-side is bitfield...
		if( r_bf ) then

			'' allocate temp var
			r_sym = symbAddTempVar( symbGetFullType( astGetSubtype( astGetLeft( src ) ) ) )

			'' right-side references temp var
			s = astNewVAR( r_sym )

			'' assign bitfield to temp var
			astAdd( astNewASSIGN( s, astCloneTree( src ) ) )

		else
			'' right-side references tree
			s = src
		end if

		'' left-side = right-side
		astAdd( astNewASSIGN( dst, astCloneTree( s ) ) )

		'' right-side is bitfield...
		if( r_bf ) then

			'' pop to temp var
			s = astNewVAR( r_sym )
			astAdd( astNewSTACK( AST_OP_POP, s ) )

			'' assign to right-side from temp var
			astAdd( astNewASSIGN( src, astCloneTree( s ) ) )

		else
			'' high-level IR? use a temp var...
			if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
				astAdd( astNewASSIGN( src, _
                                      astNewVAR( tmpvar, , dst_dtype, astGetSubType( d ) ) ) )
			else
				'' pop to right-side
				astAdd( astNewSTACK( AST_OP_POP, src ) )
			end if
		end if

		exit function
	end if

	''
    proc = astNewCALL( PROCLOOKUP( MEMSWAP ) )

    '' always calc len before pushing the param
    bytes = rtlCalcExprLen( dst )

    '' dst as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewARG( proc, astNewCONSTi( bytes, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlMemCopyClear _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval dstlen as integer, _
		byval srcexpr as ASTNODE ptr, _
		byval srclen as integer _
	) as integer

    dim as ASTNODE ptr proc = any

	function = FALSE

	''
    proc = astNewCALL( PROCLOOKUP( MEMCOPYCLEAR ) )

    '' dst as any
    if( astNewARG( proc, dstexpr ) = NULL ) then
    	exit function
    end if

    '' byval dstlen as integer
    if( astNewARG( proc, astNewCONSTi( dstlen, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, srcexpr ) = NULL ) then
    	exit function
    end if

    '' byval srclen as integer
    if( astNewARG( proc, astNewCONSTi( srclen, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlMemNewOp _
	( _
		byval is_vector as integer, _
		byval len_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' assumes dtype has const info stripped
    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr sym = any

    '' try to find an overloaded new()
    select case as const dtype
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    	sym = symbGetCompOpOvlHead( subtype, _
    								iif( is_vector, _
    									 AST_OP_NEW_VEC_SELF, _
    									 AST_OP_NEW_SELF ) )
    case else
    	sym = NULL
    end select

    '' if not defined, call the global one
    if( sym = NULL ) then
    	sym = symbGetCompOpOvlHead( subtype, _
    								iif( is_vector, _
    									 AST_OP_NEW_VEC, _
    									 AST_OP_NEW ) )
    end if

    proc = astNewCALL( sym )

    '' byval len as uinteger
    if( astNewARG( proc, len_expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMemDeleteOp _
	( _
		byval is_vector as integer, _
		byval ptr_expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as FBSYMBOL ptr sym = any

	'' assumes const info is stripped

    '' try to find an overloaded delete()
    select case as const dtype
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    	sym = symbGetCompOpOvlHead( subtype, _
    								iif( is_vector, _
    									 AST_OP_DEL_VEC_SELF, _
    									 AST_OP_DEL_SELF ) )
    case else
    	sym = NULL
    end select

    '' if not defined, call the global one
    if( sym = NULL ) then
    	sym = symbGetCompOpOvlHead( subtype, _
    								iif( is_vector, _
    									 AST_OP_DEL_VEC, _
    									 AST_OP_DEL ) )
    end if

    proc = astNewCALL( sym )

    '' byval ptr as any ptr
    if( astNewARG( proc, ptr_expr ) = NULL ) then
    	exit function
    end if

    function = proc

end function
