'' intermediate representation - core module
''
'' chng: dec/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"

dim shared ir as IRCTX

sub irInit( )
	select case( env.clopt.backend )
	case FB_BACKEND_GCC
		ir.vtbl = irhlc_vtbl
	case FB_BACKEND_LLVM
		ir.vtbl = irllvm_vtbl
	case else
		assert( env.clopt.backend = FB_BACKEND_GAS )
		ir.vtbl = irtac_vtbl
	end select
	ir.vtbl.init( )
end sub

sub irEnd( )
	ir.vtbl.end( )
end sub
