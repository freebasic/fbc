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


'' intermediate representation - core module
''
'' chng: dec/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"

declare function irTAC_ctor _
	( _
	) as integer

declare function irHLC_ctor _
	( _
	) as integer

'' globals
	dim shared ir as IRCTX

'':::::
private function hCallCtor _
	( _
		byval backend as FB_BACKEND _
	) as integer

	select case backend
	case FB_BACKEND_GAS
		function = irTAC_ctor( )

	case FB_BACKEND_GCC
		function = irHLC_ctor( )

	case else
		function = FALSE
	end select

end function

'':::::
function irInit _
	( _
		byval backend as FB_BACKEND _
	) as integer

	if( ir.inited ) then
		return TRUE
	end if

	''
	if( hCallCtor( backend ) = FALSE ) then
		return FALSE
	end if

	if( ir.vtbl.init( backend ) ) then
		ir.inited = TRUE

		listNew( @ir.arglist, 32*4, len( IR_CALL_ARG ), LIST_FLAGS_NOCLEAR )
	end if

	function = ir.inited

end function

'':::::
sub irEnd _
	( _
	)

	if( ir.inited = FALSE ) then
		exit sub
	end if

	ir.vtbl.end( )


	listFree( @ir.arglist )

	ir.inited = FALSE

end sub

'':::::
function irGetVRDataClass _
	( _
		byval vreg as IRVREG ptr _
	) as integer

	function = symb_dtypeTB(typeGet( vreg->dtype )).class

end function

'':::::
function irGetVRDataSize _
	( _
		byval vreg as IRVREG ptr _
	) as integer

	function = symb_dtypeTB(typeGet( vreg->dtype )).size

end function

'':::::
function irNewCallArg _
	( _
		byval arg_list as IR_CALL_ARG_LIST ptr, _
		byval vreg as IRVREG ptr, _
		byval lgt as integer _
	) as IR_CALL_ARG ptr

	dim as IR_CALL_ARG ptr arg = listNewNode( arg_list->list )

	if( arg_list->head = NULL ) then
		arg_list->head = arg
	else
		arg_list->tail->next = arg
	end if

	arg->prev =	arg_list->tail
	arg->next = NULL
	arg_list->tail = arg

	arg_list->args += 1

	arg->vr = vreg
	arg->lgt = lgt

	function = arg

end function

''::::::
sub irDelCallArg _
	( _
		byval arg_list as IR_CALL_ARG_LIST ptr, _
		byval arg as IR_CALL_ARG ptr _
	)

	listDelNode( arg_list->list, arg )

end sub


'':::::
sub irDelCallArgs _
	( _
		byval arg_list as IR_CALL_ARG_LIST ptr _
	)

	dim as IR_CALL_ARG ptr arg, nxt

	'' WARNING: the arg list is not updated

	arg = arg_list->head
	do while( arg <> NULL )
		nxt = arg->next
		irDelCallArg( arg_list, arg )
		arg = nxt
	loop

end sub

