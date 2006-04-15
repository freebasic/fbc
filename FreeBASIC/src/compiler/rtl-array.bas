''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' intrinsic runtime lib array functions (REDIM, ERASE, LBOUND, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

'' fb_ArrayRedim CDECL ( array() as ANY, byval elementlen as integer, _
''					     byval isvarlen as integer, _
''						 byval dimensions as integer, ... ) as integer
data @FB_RTL_ARRAYREDIM,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 INVALID,FB_PARAMMODE_VARARG, FALSE

'' fb_ArrayRedimPresv CDECL ( array() as ANY, byval elementlen as integer, _
''					          byval isvarlen as integer, _
''						      byval dimensions as integer, ... ) as integer
data @FB_RTL_ARRAYREDIMPRESV,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 INVALID,FB_PARAMMODE_VARARG, FALSE

'' fb_ArrayErase ( array() as ANY, byval isvarlen as integer ) as integer
data @FB_RTL_ARRAYERASE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArrayClear ( array() as ANY, byval isvarlen as integer ) as integer
data @FB_RTL_ARRAYCLEAR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArrayLBound ( array() as ANY, byval dimension as integer ) as integer
data @FB_RTL_ARRAYLBOUND,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArrayUBound ( array() as ANY, byval dimension as integer ) as integer
data @FB_RTL_ARRAYUBOUND,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArraySetDesc CDECL ( array() as ANY, byref arraydata as any, byval elementlen as integer, _
''						   byval dimensions as integer, ... ) as void
data @FB_RTL_ARRAYSETDESC,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 INVALID,FB_PARAMMODE_VARARG, FALSE

'' fb_ArrayStrErase ( array() as any ) as void
data @FB_RTL_ARRAYSTRERASE,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE

'' fb_ArrayAllocTempDesc CDECL ( byref pdesc as any ptr, arraydata as any, byval elementlen as integer, _
''						         byval dimensions as integer, ... ) as void ptr
data @FB_RTL_ARRAYALLOCTMPDESC,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 INVALID,FB_PARAMMODE_VARARG, FALSE

'' fb_ArrayFreeTempDesc ( byval pdesc as any ptr) as void
data @FB_RTL_ARRAYFREETMPDESC,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArraySngBoundChk ( byval idx as integer, byval ubound as integer, _
''						 byval linenum as integer ) as any ptr
data @FB_RTL_ARRAYSNGBOUNDCHK,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_ArrayBoundChk ( byval idx as integer, byval lbound as integer, byval ubound as integer, _
''						byval linenum as integer ) as any ptr
data @FB_RTL_ARRAYBOUNDCHK,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' EOL
data NULL


'':::::
sub rtlArrayModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlArrayModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlArrayRedim( byval s as FBSYMBOL ptr, _
						byval elementlen as integer, _
						byval dimensions as integer, _
				        exprTB() as ASTNODE ptr, _
				        byval dopreserve as integer _
				      ) as integer static

    dim as ASTNODE ptr proc, expr
    dim as FBSYMBOL ptr f, reslabel
    dim as integer i, dtype, isvarlen

    function = FALSE

	''
	if( dopreserve = FALSE ) then
		f = PROCLOOKUP( ARRAYREDIM )
	else
		f = PROCLOOKUP( ARRAYREDIMPRESV )
	end if
    proc = astNewCALL( f )

    '' array() as ANY
    dtype =  symbGetType( s )
	expr = astNewVAR( s, 0, dtype )
    if( astNewARG( proc, expr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONSTi( elementlen, FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	isvarlen = (dtype = FB_DATATYPE_STRING)
	if( astNewARG( proc, astNewCONSTi( isvarlen, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval dimensions as integer
	if( astNewARG( proc, astNewCONSTi( dimensions, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' ...
	for i = 0 to dimensions-1

		'' lbound
		expr = exprTB(i, 0)

    	'' convert to int
    	if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
    		expr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' ubound
		expr = exprTB(i, 1)

    	'' convert to int
    	if( astGetDataType( expr ) <> FB_DATATYPE_INTEGER ) then
    		expr = astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, expr )
    	end if

		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if
	next

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

    ''
	function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlArrayErase( byval arrayexpr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( ARRAYERASE ) )

	dtype = astGetDataType( arrayexpr )

    '' array() as ANY
    if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_STRING, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	function = proc

end function

'':::::
function rtlArrayClear( byval arrayexpr as ASTNODE ptr ) as integer static
    dim as ASTNODE ptr proc
    dim as integer dtype

    function = FALSE

	''
    proc = astNewCALL( PROCLOOKUP( ARRAYCLEAR ) )

    dtype = astGetDataType( arrayexpr )

    '' array() as ANY
    if( astNewARG( proc, arrayexpr, dtype ) = NULL ) then
    	exit function
    end if

	'' byval isvarlen as integer
	if( astNewARG( proc, astNewCONSTi( (dtype = FB_DATATYPE_STRING), FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayStrErase( byval s as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc
    dim as integer dtype

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( ARRAYSTRERASE ) )

    '' array() as ANY
    dtype = symbGetType( s )
    if( astNewARG( proc, astNewVAR( s, 0, dtype ), dtype ) = NULL ) then
    	exit function
    end if

	function = proc

end function

'':::::
function rtlArrayBound( byval sexpr as ASTNODE ptr, _
						byval dimexpr as ASTNODE ptr, _
						byval islbound as integer _
					  ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = NULL

	''
	if( islbound ) then
		f = PROCLOOKUP( ARRAYLBOUND)
	else
		f = PROCLOOKUP( ARRAYUBOUND)
	end if
    proc = astNewCALL( f )

    '' array() as ANY
    if( astNewARG( proc, sexpr ) = NULL ) then
    	exit function
    end if

	'' byval dimension as integer
	if( astNewARG( proc, dimexpr ) = NULL ) then
		exit function
	end if

    ''
    function = proc

end function

'':::::
function rtlArraySetDesc( byval s as FBSYMBOL ptr, _
						  byval elementlen as integer, _
					      byval dimensions as integer, _
					      dTB() as FBARRAYDIM ) as integer static

    dim as ASTNODE ptr proc, expr
    dim as integer dtype, i

    function = FALSE

    proc = astNewCALL( PROCLOOKUP( ARRAYSETDESC ) )

    '' array() as ANY
    dtype =  symbGetType( s )
	expr = astNewVAR( s, 0, dtype )
    if( astNewARG( proc, expr, dtype ) = NULL ) then
		exit function
	end if

	'' arraydata as any
	expr = astNewVAR( s, 0, dtype )
    if( astNewARG( proc, expr, dtype ) = NULL ) then
		exit function
	end if

	'' byval element_len as integer
	expr = astNewCONSTi( elementlen, FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' byval dimensions as integer
	expr = astNewCONSTi( dimensions, FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' ...
	for i = 0 to dimensions-1
		'' lbound
		expr = astNewCONSTi( dTB(i).lower, FB_DATATYPE_INTEGER )
		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if

		'' ubound
		expr = astNewCONSTi( dTB(i).upper, FB_DATATYPE_INTEGER )
		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	next

    ''
	astAdd( proc )

	function = TRUE

end function

'':::::
function rtlArrayAllocTmpDesc( byval arrayexpr as ASTNODE ptr, _
							   byval pdesc as FBSYMBOL ptr _
							 ) as ASTNODE ptr

    dim as ASTNODE ptr proc, expr
    dim as integer dtype, dimensions
    dim as FBSYMBOL ptr s
    dim as FBVARDIM ptr d

	function = NULL

	s = astGetSymbol( arrayexpr )

	dimensions = symbGetArrayDimensions( s )

    proc = astNewCALL( PROCLOOKUP( ARRAYALLOCTMPDESC ) )

    '' byref pdesc as any ptr
	expr = astNewVAR( pdesc, 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
    if( astNewARG( proc, expr, FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

    '' byref arraydata as any
    if( astNewARG( proc, arrayexpr, FB_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

	'' byval element_len as integer
	expr = astNewCONSTi( symbGetLen( s ), FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' byval dimensions as integer
	expr = astNewCONSTi( dimensions, FB_DATATYPE_INTEGER )
	if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

	'' ...
    d = symbGetArrayFirstDim( s )
    do while( d <> NULL )
		'' lbound
		expr = astNewCONSTi( d->lower, FB_DATATYPE_INTEGER )
		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' ubound
		expr = astNewCONSTi( d->upper, FB_DATATYPE_INTEGER )
		if( astNewARG( proc, expr, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' next
		d = d->next
	loop

	function = proc

end function

'':::::
function rtlArrayFreeTempDesc( byval pdesc as FBSYMBOL ptr ) as ASTNODE ptr
    dim as ASTNODE ptr proc, expr

	function = NULL

    proc = astNewCALL( PROCLOOKUP( ARRAYFREETMPDESC ) )

    '' byval pdesc as any ptr
	expr = astNewVAR( pdesc, 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
    if( astNewARG( proc, expr, FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlArrayBoundsCheck( byval idx as ASTNODE ptr, _
							  byval lb as ASTNODE ptr, _
							  byval rb as ASTNODE ptr, _
							  byval linenum as integer, _
							  byval module as zstring ptr _
							) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

   	function = NULL

   	'' lbound 0? do a single check
   	if( lb = NULL ) then
		f = PROCLOOKUP( ARRAYSNGBOUNDCHK )
	else
    	f = PROCLOOKUP( ARRAYBOUNDCHK )
	end if

   	proc = astNewCALL( f )

	'' idx
	if( astNewARG( proc, _
					 astNewCONV( INVALID, FB_DATATYPE_INTEGER, NULL, idx ), _
					 FB_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' lbound
	if( lb <> NULL ) then
		if( astNewARG( proc, lb, FB_DATATYPE_INTEGER ) = NULL ) then
			exit function
		end if
	end if

	'' rbound
	if( astNewARG( proc, rb, FB_DATATYPE_INTEGER ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewARG( proc, astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
    	exit function
    end if

    function = proc

end function

