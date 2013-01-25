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
#include once "reg.bi"
#include once "emit-private.bi"

function vregDump( byval v as IRVREG ptr ) as string
	dim as string s
	dim as zstring ptr regname = any

	if( v = NULL ) then
		return "<NULL>"
	end if

	static as zstring ptr vregtypes(IR_VREGTYPE_IMM to IR_VREGTYPE_OFS) = _
	{ _
		@"imm", @"var", @"idx", @"ptr", @"reg", @"ofs" _
	}

	#if 0
		s += "[" + hex( v, 8 ) + "] "
	#endif

	s += *vregtypes(v->typ)

	select case( v->typ )
	case IR_VREGTYPE_IMM
		s += " "
		select case as const( v->dtype )
		case FB_DATATYPE_LONGINT
			s += str( v->value.long )
		case FB_DATATYPE_ULONGINT
			s += str( v->value.long )
		case FB_DATATYPE_SINGLE
			s += str( v->value.float )
		case FB_DATATYPE_DOUBLE
			s += str( v->value.float )
		case FB_DATATYPE_LONG
			if( FB_LONGSIZE = len( integer ) ) then
				s += str( v->value.int )
			else
				s += str( v->value.long )
			end if
		case FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				s += str( v->value.int )
			else
				s += str( v->value.long )
			end if
		case FB_DATATYPE_UINT
			s += str( v->value.int )
		case else
			s += str( v->value.int )
		end select

	case IR_VREGTYPE_REG
		if( env.clopt.backend = FB_BACKEND_GAS ) then
			regname = hGetRegName( v->dtype, v->reg )
			if( len( *regname ) > 0 ) then
				s += " " + ucase( *regname )
			else
				s += " " + str( v->reg )
			end if
		else
			''s += " reg="
			s += " " + str( v->reg )
		end if
	end select

	if( v->typ <> IR_VREGTYPE_REG ) then
		if( v->ofs ) then
			if( (env.clopt.backend = FB_BACKEND_GAS) and (v->sym <> NULL) ) then
				s += " """ + *symbGetName( v->sym ) + """ [" + *symbGetMangledName( v->sym ) + str( v->ofs ) + "]"
			else
				s += " ofs=" + str( v->ofs )
			end if
		end if
		if( v->mult ) then
			s += " mult=" + str( v->mult )
		end if
	end if

	s += " " + typeDump( v->dtype, v->subtype )

	if( v->typ <> IR_VREGTYPE_REG ) then
		if( v->vidx ) then
			s += " vidx=<" + vregDump( v->vidx ) + ">"
		end if
	end if

	if( ISLONGINT( v->dtype ) ) then
		s += " vaux=<" + vregDump( v->vaux ) + ">"
	end if

	function = s
end function
#endif
