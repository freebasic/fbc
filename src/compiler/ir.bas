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

#if __FB_DEBUG__
function vregDump( byval v as IRVREG ptr ) as string
	dim as string s

	static as zstring ptr vregtypes(IR_VREGTYPE_IMM to IR_VREGTYPE_OFS) = _
	{ _
		@"imm", @"var", @"idx", @"ptr", @"reg", @"ofs" _
	}

	s += *vregtypes(v->typ)
	if( v->ofs ) then
		s += " offset=" + str( v->ofs )
	end if
	if( v->mult ) then
		s += " multiplier=" + str( v->mult )
	end if
	s += " " + typeDump( v->dtype, v->subtype )

	if( v->vidx ) then
		s += " vidx=<" + vregDump( v->vidx ) + ">"
	end if

	function = s
end function
#endif
