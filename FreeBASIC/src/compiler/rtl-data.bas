''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

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


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

''
'' fb_DataRestore ( byval labeladdrs as void ptr ) as void
data @FB_RTL_DATARESTORE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_POINTER+FB_SYMBTYPE_VOID,FB_ARGMODE_BYVAL, FALSE

'' fb_DataReadStr ( byref dst as any, byval dst_size as integer, _
''                  byval fillrem as integer = 1 ) as void
data @FB_RTL_DATAREADSTR,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_SYMBTYPE_VOID,FB_ARGMODE_BYREF, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, FALSE, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYVAL, TRUE,1

'' fb_DataReadByte ( byref dst as byte ) as void
data @FB_RTL_DATAREADBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_BYTE,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadShort ( byref dst as short ) as void
data @FB_RTL_DATAREADSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SHORT,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadInt ( byref dst as integer ) as void
data @FB_RTL_DATAREADINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_INTEGER,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadLongint ( byref dst as longint ) as void
data @FB_RTL_DATAREADLONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_LONGINT,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadUByte ( byref dst as ubyte ) as void
data @FB_RTL_DATAREADUBYTE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UBYTE,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadUShort ( byref dst as ushort ) as void
data @FB_RTL_DATAREADUSHORT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_USHORT,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadUInt ( byref dst as uinteger ) as void
data @FB_RTL_DATAREADUINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_UINT,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadULongint ( byref dst as ulongint ) as void
data @FB_RTL_DATAREADULONGINT,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_ULONGINT,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadSingle ( byref dst as single ) as void
data @FB_RTL_DATAREADSINGLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_SINGLE,FB_ARGMODE_BYREF, FALSE

'' fb_DataReadDouble ( byref dst as single ) as void
data @FB_RTL_DATAREADDOUBLE,"", _
	 FB_SYMBTYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_SYMBTYPE_DOUBLE,FB_ARGMODE_BYREF, FALSE

'' EOL
data NULL

'':::::
sub rtlDataModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

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
function rtlDataRead( byval varexpr as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, dtype, lgt

    function = FALSE

	f = NULL
	args = 1
	select case as const astGetDataType( varexpr )
	case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, IR_DATATYPE_CHAR
		f = PROCLOOKUP( DATAREADSTR )
		args = 3
	case IR_DATATYPE_WCHAR
		f = PROCLOOKUP( DATAREADWSTR )
		args = 2
	case IR_DATATYPE_BYTE
		f = PROCLOOKUP( DATAREADBYTE )
	case IR_DATATYPE_UBYTE
		f = PROCLOOKUP( DATAREADUBYTE )
	case IR_DATATYPE_SHORT
		f = PROCLOOKUP( DATAREADSHORT )
	case IR_DATATYPE_USHORT
		f = PROCLOOKUP( DATAREADUSHORT )
	case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
		f = PROCLOOKUP( DATAREADINT )
	case IR_DATATYPE_UINT
		f = PROCLOOKUP( DATAREADUINT )
	case IR_DATATYPE_LONGINT
		f = PROCLOOKUP( DATAREADLONGINT )
	case IR_DATATYPE_ULONGINT
		f = PROCLOOKUP( DATAREADULONGINT )
	case IR_DATATYPE_SINGLE
		f = PROCLOOKUP( DATAREADSINGLE )
	case IR_DATATYPE_DOUBLE
		f = PROCLOOKUP( DATAREADDOUBLE )
	case IR_DATATYPE_USERDEF
		exit function						'' illegal
	case else
		f = PROCLOOKUP( DATAREADUINT )
	end select

    if( f = NULL ) then
    	exit function
    end if

    proc = astNewFUNCT( f )

    if( args > 1 ) then
    	'' always calc len before pushing the param
		dtype = astGetDataType( varexpr )
		STRGETLEN( varexpr, dtype, lgt )
	end if

    '' byref var as any
    if( astNewPARAM( proc, varexpr ) = NULL ) then
 		exit function
 	end if

    if( args > 1 ) then
		'' byval dst_size as integer
		if( astNewPARAM( proc, astNewCONSTi( lgt, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewPARAM( proc, astNewCONSTi( dtype = IR_DATATYPE_FIXSTR, IR_DATATYPE_INTEGER ), IR_DATATYPE_INTEGER ) = NULL ) then
    			exit function
    		end if
    	end if
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlDataRestore( byval label as FBSYMBOL ptr, _
						 byval afternode as ASTNODE ptr, _
						 byval isprofiler as integer = FALSE _
					   ) as integer static

    static as zstring * FB_MAXNAMELEN+1 lname
    dim as ASTNODE ptr proc, expr
    dim as FBSYMBOL ptr s

    function = FALSE

    proc = astNewFUNCT( PROCLOOKUP( DATARESTORE ), NULL, isprofiler )

    '' begin of data or start from label?
    if( label <> NULL ) then
    	lname = FB_DATALABELPREFIX + symbGetName( label )
    else
    	lname = FB_DATALABELNAME
    end if

    '' label already declared?
    s = symbFindByNameAndClass( @lname, FB_SYMBCLASS_LABEL )
    if( s = NULL ) then
       	s = symbAddLabel( @lname, TRUE, TRUE )
    end if

    '' byval labeladdrs as void ptr
    expr = astNewADDR( IR_OP_ADDROF, astNewVAR( s, NULL, 0, IR_DATATYPE_BYTE ), s )
    if( astNewPARAM( proc, expr ) = NULL ) then
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
    dim as FBSYMBOL ptr l, label, s

	'' switch section, can't be code coz it will screw up debugging
	emitSECTION( EMIT_SECTYPE_CONST )

	'' emit default label if not yet emited
	if( not ctx.datainited ) then
		ctx.datainited = TRUE

		l = symbAddLabel( strptr( FB_DATALABELNAME ), TRUE, TRUE )
		if( l = NULL ) then
			l = symbFindByNameAndClass( strptr( FB_DATALABELNAME ), FB_SYMBCLASS_LABEL )
		end if

		lname = symbGetName( l )
		emitDATALABEL( lname )

	else
		s = symbFindByNameAndClass( strptr( FB_DATALABELNAME ), FB_SYMBCLASS_LABEL )
		lname = symbGetName( s )
	end if

	'' emit last label as a label in const section
	'' if any defined already, otherwise it will be the default
	label = symbGetLastLabel( )
	if( label <> NULL ) then
    	''
    	lname = FB_DATALABELPREFIX + symbGetName( label )
    	l = symbFindByNameAndClass( @lname, FB_SYMBCLASS_LABEL )
    	if( l = NULL ) then
       		l = symbAddLabel( @lname, TRUE, TRUE )
    	end if

    	lname = symbGetName( l )

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
    	symbSetLastLabel( symbFindByNameAndClass( strptr( FB_DATALABELNAME ), _
    											  FB_SYMBCLASS_LABEL ) )
    end if

	'' emit will link the last DATA with this one if any exists
	emitDATABEGIN( lname )

end sub

'':::::
function rtlDataStore( byval littext as string, _
					   byval litlen as integer, _
					   byval typ as integer _
					 ) as integer static

	'' emit will take care of all dirty details
	emitDATA( littext, litlen, typ )

	function = TRUE

end function

'':::::
function rtlDataStoreOFS( byval sym as FBSYMBOL ptr ) as integer static

	emitDATAOFS( symbGetName( sym ) )

	function = TRUE

end function

'':::::
sub rtlDataStoreEnd static

	'' emit end of data (will be repatched by emit if more DATA stmts follow)
	emitDATAEND( )

end sub

