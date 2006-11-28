''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' intrinsic runtime lib data functions (DATA, RESTORE, READ)
''
'' chng: oct/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"


type RTLDATA_CTX
	datainited		as integer
	lastlabel		as FBSYMBOL ptr
    labelcnt 		as integer
end type

'' globals
	dim shared ctx as RTLDATA_CTX

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 15 ) = _
	{ _
		/' fb_DataRestore ( byval labeladdrs as void ptr ) as void '/ _
		( _
			@FB_RTL_DATARESTORE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadStr ( byref dst as any, byval dst_size as integer, _
							byval fillrem as integer = 1 ) as void '/ _
		( _
			@FB_RTL_DATAREADSTR, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_DataReadWstr ( byval dst as wstring ptr, _
							 byval dst_size as integer ) as void '/ _
		( _
			@FB_RTL_DATAREADWSTR, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadByte ( byref dst as byte ) as void '/ _
		( _
			@FB_RTL_DATAREADBYTE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_BYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadShort ( byref dst as short ) as void '/ _
		( _
			@FB_RTL_DATAREADSHORT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_SHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadInt ( byref dst as integer ) as void '/ _
		( _
			@FB_RTL_DATAREADINT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadLongint ( byref dst as longint ) as void '/ _
		( _
			@FB_RTL_DATAREADLONGINT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUByte ( byref dst as ubyte ) as void '/ _
		( _
			@FB_RTL_DATAREADUBYTE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_UBYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUShort ( byref dst as ushort ) as void '/ _
		( _
			@FB_RTL_DATAREADUSHORT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_USHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUInt ( byref dst as uinteger ) as void '/ _
		( _
			@FB_RTL_DATAREADUINT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUInt ( byref dst as uinteger ) as void '/ _
		( _
			@FB_RTL_DATAREADPTR, @FB_RTL_DATAREADUINT, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadULongint ( byref dst as ulongint ) as void '/ _
		( _
			@FB_RTL_DATAREADULONGINT, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadSingle ( byref dst as single ) as void '/ _
		( _
			@FB_RTL_DATAREADSINGLE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadDouble ( byref dst as single ) as void '/ _
		( _
			@FB_RTL_DATAREADDOUBLE, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlDataModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

	''
	ctx.datainited	= FALSE
	ctx.lastlabel	= NULL
    ctx.labelcnt 	= 0

end sub

'':::::
sub rtlDataModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlDataRead _
	( _
		byval varexpr as ASTNODE ptr _
	) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, dtype, lgt

    function = FALSE

	f = NULL
	args = 1
	dtype = astGetDataType( varexpr )

	select case as const dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		f = PROCLOOKUP( DATAREADSTR )
		args = 3

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( DATAREADWSTR )
		args = 2

	case FB_DATATYPE_BYTE
		f = PROCLOOKUP( DATAREADBYTE )

	case FB_DATATYPE_UBYTE
		f = PROCLOOKUP( DATAREADUBYTE )

	case FB_DATATYPE_SHORT
		f = PROCLOOKUP( DATAREADSHORT )

	case FB_DATATYPE_USHORT
		f = PROCLOOKUP( DATAREADUSHORT )

	case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		f = PROCLOOKUP( DATAREADINT )

	case FB_DATATYPE_UINT
		f = PROCLOOKUP( DATAREADUINT )

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			f = PROCLOOKUP( DATAREADINT )
		else
			f = PROCLOOKUP( DATAREADLONGINT )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			f = PROCLOOKUP( DATAREADUINT )
		else
			f = PROCLOOKUP( DATAREADULONGINT )
		end if

	case FB_DATATYPE_LONGINT
		f = PROCLOOKUP( DATAREADLONGINT )

	case FB_DATATYPE_ULONGINT
		f = PROCLOOKUP( DATAREADULONGINT )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( DATAREADSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( DATAREADDOUBLE )

	case FB_DATATYPE_STRUCT
		exit function						'' illegal

	case else
		if( dtype >= FB_DATATYPE_POINTER ) then
			f = PROCLOOKUP( DATAREADPTR )
		else
			exit function
		end if
	end select

    if( f = NULL ) then
    	exit function
    end if

    proc = astNewCALL( f )

    if( args > 1 ) then
    	'' always calc len before pushing the param
		lgt = rtlCalcStrLen( varexpr, dtype )
	end if

    '' byref var as any
    if( astNewARG( proc, varexpr ) = NULL ) then
 		exit function
 	end if

    if( args > 1 ) then
		'' byval dst_size as integer
		if( astNewARG( proc, _
					   astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewARG( proc, _
						   astNewCONSTi( dtype = FB_DATATYPE_FIXSTR, _
										 FB_DATATYPE_INTEGER ), _
						   FB_DATATYPE_INTEGER ) = NULL ) then
    			exit function
    		end if
    	end if
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlDataRestore _
	( _
		byval label as FBSYMBOL ptr, _
		byval afternode as ASTNODE ptr, _
		byval isprofiler as integer = FALSE _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 lname
    dim as ASTNODE ptr proc, expr
    dim as FBSYMBOL ptr s

    function = FALSE

    proc = astNewCALL( PROCLOOKUP( DATARESTORE ), NULL, isprofiler )

    '' begin of data or start from label?
    if( label <> NULL ) then
    	lname = FB_DATALABELPREFIX + *symbGetMangledName( label )
    else
    	lname = FB_DATALABELNAME
    end if

    '' label already declared?
    s = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
    							  @lname, FB_SYMBCLASS_LABEL )
    if( s = NULL ) then
       	s = symbAddLabel( @lname, TRUE, TRUE )
    end if

    '' byval labeladdrs as void ptr
    expr = astNewADDR( AST_OP_ADDROF, astNewVAR( s, 0, FB_DATATYPE_BYTE ) )
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

	''
	if( afternode = NULL ) then
		astAdd( proc )
	else
		astAddAfter( proc, afternode )
	end if

	function = TRUE

end function

'':::::
sub rtlDataStoreBegin static
    static as zstring * FB_MAXNAMELEN+1 lname
    dim as FBSYMBOL ptr l, label

	'' switch section, can't be code coz it will screw up debugging
	emitSECTION( EMIT_SECTYPE_CONST, 0 )

	'' emit default label if not yet emited (also if DATA's are
	'' been used inside procs, the label will get removed)
	l = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
								  @FB_DATALABELNAME, FB_SYMBCLASS_LABEL )

	if( (l = NULL) or (ctx.datainited = FALSE) ) then
		ctx.datainited = TRUE

		l = symbAddLabel( strptr( FB_DATALABELNAME ), TRUE, TRUE )
		if( l = NULL ) then
			l = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
										  @FB_DATALABELNAME, FB_SYMBCLASS_LABEL )
		end if

		lname = *symbGetMangledName( l )
		emitDATALABEL( lname )
	end if

	'' emit last label as a label in const section
	'' if any defined already, otherwise it will be the default
	label = symbGetLastLabel( )
	if( label <> NULL ) then
    	''
    	lname = FB_DATALABELPREFIX + *symbGetMangledName( label )
    	l = symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
    								  @lname, FB_SYMBCLASS_LABEL )
    	if( l = NULL ) then
       		l = symbAddLabel( @lname, TRUE, TRUE )
    	end if

    	lname = *symbGetMangledName( l )

    	'' stills the same label as before? incrase counter to link DATA's
    	if( ctx.lastlabel = label ) then
    		ctx.labelcnt = ctx.labelcnt + 1
    		lname += "_" + str( ctx.labelcnt )
    	else
    		ctx.lastlabel = label
    		ctx.labelcnt = 0
    	end if

    	emitDATALABEL( lname )

    else
    	symbSetLastLabel( symbLookupByNameAndClass( @symbGetGlobalNamespc( ), _
    												@FB_DATALABELNAME, _
    											  	FB_SYMBCLASS_LABEL ) )
    end if

	'' emit will link the last DATA with this one if any exists
	emitDATABEGIN( lname )

end sub

'':::::
function rtlDataStore _
	( _
		byval littext as zstring ptr, _
		byval litlen as integer, _
		byval typ as integer _
	) as integer static

	'' emit will take care of all dirty details
	emitDATA( littext, litlen, typ )

	function = TRUE

end function

'':::::
function rtlDataStoreW _
	( _
		byval littext as wstring ptr, _
		byval litlen as integer, _
		byval typ as integer _
	) as integer static

	'' emit will take care of all dirty details
	emitDATAW( littext, litlen, typ )

	function = TRUE

end function

'':::::
function rtlDataStoreOFS _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer static

	emitDATAOFS( symbGetMangledName( sym ) )

	function = TRUE

end function

'':::::
sub rtlDataStoreEnd static

	'' emit end of data (will be repatched by emit if more DATA stmts follow)
	emitDATAEND( )

end sub

