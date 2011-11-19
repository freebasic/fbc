'' intermediate representation - core module
''
'' chng: dec/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"

'' globals
	dim shared ir as IRCTX

sub irInit(byval backend as FB_BACKEND)
	if (backend = FB_BACKEND_GCC) then
		irHLC_ctor()
	else
		assert(backend = FB_BACKEND_GAS)
		irTAC_ctor()
	end if

	ir.vtbl.init(backend)
end sub

sub irEnd()
	ir.vtbl.end( )
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
