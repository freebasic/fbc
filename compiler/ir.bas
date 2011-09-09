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
