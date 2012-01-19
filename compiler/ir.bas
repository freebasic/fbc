'' intermediate representation - core module
''
'' chng: dec/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"

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
