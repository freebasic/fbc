'' code generation for x86 Streaming SIMD Extensions, GNU assembler (GAS/Intel arch)
''
'' chng: june/2008 written [bryan]

#include once "fb.bi"
#include once "fbint.bi"
#include once "reg.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "emit.bi"
#include once "emitdbg.bi"
#include once "hash.bi"
#include once "symb.bi"
#include once "emit-private.bi"

dim shared _emitLOADB2F_x86 as sub( byval dvreg as IRVREG ptr, byval svreg as IRVREG ptr )

private sub hULONG2DBL _
	( _
		byval svreg as IRVREG ptr _
	) static

	dim as string label, aux, ostr

	label = *symbUniqueLabel( )

	hPrepOperand( svreg, aux, FB_DATATYPE_INTEGER, 0, TRUE )
	ostr = "cmp " + aux + ", 0"

	outp ostr
	ostr = "jns " + label
	outp ostr
	hPUSH( "0x403f" )
	hPUSH( "0x80000000" )
	hPUSH( "0" )
	outp "fldt [esp]"
	outp "add esp, 12"
	outp "faddp"
	hLABEL( label )

end sub

private sub _emitLOADB2F_SSE( byval dvreg as IRVREG ptr, byval svreg as IRVREG ptr )

	dim as string dst
	dim as integer ddsize = any

	'' load source to ST(0)
	_emitLOADB2F_x86( dvreg, svreg )

	hPrepOperand( dvreg, dst )
	ddsize = typeGetSize( dvreg->dtype )

	'' pop from FPU STACK and load to SSE register
	outp "sub esp" + COMMA + str( ddsize )
	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub

'':::::
private sub _emitSTORF2L_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer sdsize

	'' signed?
	if( typeIsSigned( dvreg->dtype ) = 0) then exit sub

	if( svreg->regFamily = IR_REG_SSE ) then

		sdsize = typeGetSize( svreg->dtype )
		outp "sub esp" + COMMA + str( sdsize )

		hPrepOperand( svreg, src )

		if( sdsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + src
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + src
			outp "fld dword ptr [esp]"
		end if

		outp "add esp" + COMMA + str( sdsize )
	end if

	hPrepOperand( dvreg, dst )

	outp "fistp " + dst

end sub



'':::::
private sub _emitSTORF2I_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer sdsize, ddsize
	dim as string ostr
	dim as string aux, aux8, aux16
	dim as integer isfree, reg, wasreg
	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' special case if the dst is uinteger
	if( (ddsize = 4) and (typeIsSigned( dvreg->dtype ) = 0) ) then
		outp "sub esp, 8"
		if( svreg->typ <> IR_VREGTYPE_REG ) then
			outp "fld " + src
		elseif( svreg->regFamily = IR_REG_SSE ) then
			if( sdsize > 4 ) then
				outp "movlpd qword ptr [esp], " + src
				outp "fld qword ptr [esp]"
			else
				outp "movss dword ptr [esp], " + src
				outp "fld dword ptr [esp]"
			end if
		end if
		outp "fistp qword ptr [esp]"
		hPOP dst
		outp "add esp, 4"
		exit sub
	end if

	'' special case if the dst is signed short
	if( ddsize = 2 ) and ( typeIsSigned( dvreg->dtype ) ) then
		outp "sub esp, 8"
		if( svreg->typ <> IR_VREGTYPE_REG ) then
			outp "fld " + src
		elseif( svreg->regFamily = IR_REG_SSE ) then
			if( sdsize > 4 ) then
				outp "movlpd qword ptr [esp], " + src
				outp "fld qword ptr [esp]"
			else
				outp "movss dword ptr [esp], " + src
				outp "fld dword ptr [esp]"
			end if
		end if
		outp "fistp " + dst
		outp "add esp, 8"
		exit sub
	end if

	if( (dvreg->typ = IR_VREGTYPE_REG) and (ddsize = 4) ) then
		'' dst is 32-bit register
		isfree = TRUE
		aux = dst
		wasreg = TRUE
	else
		'' dst is not 32-bit register
		wasreg = FALSE
		'' find a register
		reg = hFindRegNotInVreg( svreg )

		aux = *hGetRegName( FB_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( FB_DATACLASS_INTEGER, reg )
		if( isfree = FALSE ) then
			hPUSH aux
		end if
	end if

	if( svreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp, 4"
		outp "fistp dword ptr [esp]"
		outp "mov " + aux + COMMA + "dword ptr [esp]"
		outp "add esp, 4"
	else
		if( sdsize > 4 ) then
			outp "cvtsd2si " + aux + COMMA + src
		else
			outp "cvtss2si " + aux + COMMA + src
		end if
	end if

	if( wasreg = FALSE ) Then
		if( ddsize = 1 ) then
			aux8 = *hGetRegName( FB_DATATYPE_BYTE, reg )
			outp "mov " + dst + COMMA + aux8
		elseif( ddsize = 2 ) then
			aux16 = *hGetRegName( FB_DATATYPE_SHORT, reg )
			outp "mov " + dst + COMMA + aux16
		else
			outp "mov " + dst + COMMA + aux
		end if
		if( isfree = FALSE ) then
			hPOP aux
		end if
	end if

end sub



'' NOTE:    this is identical to the FPU code, which is probably
''      faster than any SSE implementation
'':::::
private sub _emitSTORL2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, aux
	dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( typeIsSigned( svreg->dtype ) ) then

			hPrepOperand64( svreg, src, aux )

			hPUSH( aux )
			hPUSH( src )

			ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr

			outp "add esp, 8"

		'' unsigned..
		else
			hPrepOperand64( svreg, src, aux )
			hPUSH aux
			hPUSH src
			outp "fild qword ptr [esp]"
			outp "add esp, 8"
			hULONG2DBL( svreg )

		end if

	'' not a reg or imm
	else
		'' signed?
		if( typeIsSigned( svreg->dtype ) ) then
			ostr = "fild " + src
			outp ostr

		'' unsigned, try a bigger type..
		else
			ostr = "fild " + src
			outp ostr
			hULONG2DBL( svreg )

		end if
	end if

	ostr = "fstp " + dst
	outp ostr

end sub




'':::::
private sub _emitSTORI2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, aux
	dim as integer ddsize, sdsize, reg, isfree
	dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = typeGetSize( dvreg->dtype )
	sdsize = typeGetSize( svreg->dtype )

	'' special case for unsigned integers
	if( (typeIsSigned( svreg->dtype ) = 0) and (sdsize = 4) ) then
		hPUSH "0"
		hPUSH src
		outp "fild qword ptr [esp]"
		outp "add esp, 8"
		outp "fstp " + dst
		exit sub
	end if

	if( (svreg->typ <> IR_VREGTYPE_IMM) and (sdsize = 4) ) then
		'' src is 32-bit reg or 32-bit mem
		aux = src
		isFree = TRUE
	else
		'' src is not 32-bit or it is immediate number
		'' find a register
		reg = hFindRegNotInVreg( svreg )
		aux = *hGetRegName( FB_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( FB_DATACLASS_INTEGER, reg )
		if( isfree = FALSE ) then
			hPUSH aux
		end if

		'' put the src into aux
		if( svreg->typ = IR_VREGTYPE_IMM ) then
			outp "mov " + aux + COMMA + src
		else
			if( typeIsSigned( svreg->dtype ) ) then
				ostr = "movsx "
			else
				ostr = "movzx "
			end if
			outp ostr + aux + COMMA + src
		end if
	end if

	if( ddsize > 4 ) then
		outp "cvtsi2sd xmm7" + COMMA + aux
		outp "movlpd " + dst + COMMA + "xmm7"
	else
		outp "cvtsi2ss xmm7" + COMMA + aux
		outp "movss " + dst + COMMA + "xmm7"
	end if

	if( isfree = FALSE ) then
		hPOP aux
	end if
end sub


private sub hEmitStoreFreg2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer ddsize

	hPrepOperand( dvreg, dst, , , , FALSE )
	hPrepOperand( svreg, src, , , , FALSE )

	ddsize = typeGetSize( dvreg->dtype )

	if( ( svreg->vector = 2 ) and ( ddsize > 4 ) ) then
		outp "movupd " + dst + COMMA + src
		exit sub
	end if

	if( svreg->vector = 2 ) then
		outp "movlps " + dst + COMMA + src
	elseif( svreg->vector = 3 ) then
		outp "movhlps xmm7" + COMMA + src
		outp "movlps " + dst + COMMA + src
		hPrepOperand( dvreg, dst, , 8, FALSE )
		outp "movss " + dst + COMMA + "xmm7"
	elseif( svreg->vector = 4 ) then
		outp "movups " + dst + COMMA + src
	end if

end sub


'':::::
private sub _emitSTORF2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer ddsize, sdsize, src_vec
	dim as string ostr

	hPrepOperand( dvreg, dst, , , , FALSE )
	hPrepOperand( svreg, src, , , , FALSE )

	ddsize = typeGetSize( dvreg->dtype )
	sdsize = typeGetSize( svreg->dtype )

	src_vec = ( svreg->vector > 0 )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		'' if the src was returned from a function, it is in st(0)
		if( svreg->regFamily = IR_REG_FPU_STACK ) then
			hPrepOperand( dvreg, dst )
			outp "fstp " + dst
			exit sub
		end if

		if( src_vec ) then
			hEmitStoreFreg2F_SSE dvreg, svreg
			exit sub
		end if

		if( ddsize > 4 ) then
			if( sdsize <= 4 ) then
				'' convert src to double, then move
				outp "cvtss2sd " + src + COMMA + src
			endif

			outp "movlpd " + dst + COMMA + src
		else
			'' dst is single
			'' if src is double, convert it to single first
			if( sdsize > 4 ) then
				outp "cvtsd2ss " + src + COMMA + src
			end if
			outp "movss " + dst + COMMA + src
		endif
	else
		'' same size? just copy..
		if( sdsize = ddsize ) then
			if( src_vec ) then
				hPrepOperand( dvreg, dst, , , , FALSE )
				hPrepOperand( svreg, src, , , , FALSE )
				if( ddsize > 4 ) then
					outp "movupd xmm7" + COMMA + src
					outp "movupd " + dst + COMMA + "xmm7"
				else
					if( svreg->vector = 2 ) then
						outp "movlps xmm7" + COMMA + src
						outp "movlps " + dst + COMMA + "xmm7"
					elseif( svreg->vector = 3 ) then
						outp "movups xmm7" + COMMA + src
						outp "movlps " + dst + COMMA + "xmm7"
						outp "unpckhps xmm7, xmm7"
						hPrepOperand( dvreg, dst, , 8, FALSE )
						outp "movss " + dst + COMMA + "xmm7"
					elseif( svreg->vector = 4 ) then
						outp "movups xmm7" + COMMA + src
						outp "movups " + dst + COMMA + "xmm7"
					end if
				end if
				exit sub
			end if

			if( ddsize > 4 ) then
				outp "movlpd xmm7" + COMMA + src
				outp "movlpd " + dst + COMMA + "xmm7"
			else
				outp "movss xmm7" + COMMA + src
				outp "movss " + dst + COMMA + "xmm7"
			end if
		'' diff sizes, convert..
		else
			if( sdsize > 4 ) then
				'' load as double, store as single
				if( src_vec ) then
					outp "cvtpd2ps xmm7" + COMMA + src
					outp "movlps " + dst + COMMA + "xmm7"
				else
					outp "cvtsd2ss xmm7" + COMMA + src
					outp "movss " + dst + COMMA + "xmm7"
				end if
			else
				'' load as single, store as double
				if( src_vec ) then
					outp "cvtps2pd xmm7" + COMMA + src
					outp "movupd " + dst + COMMA + "xmm7"
				else
					outp "cvtss2sd xmm7" + COMMA + src
					outp "movlpd " + dst + COMMA + "xmm7"
				end if
			end if
		end if
	end if
end sub



'':::::
private sub _emitLOADF2L_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, aux
	dim as string ostr
	dim as integer ddsize, sdsize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )

	if( svreg->regFamily = IR_REG_SSE ) then
		'' move float onto FPU stack
		if( svreg->typ = IR_VREGTYPE_REG ) then
			outp "sub esp, 8"
			if( sdsize > 4 ) then
				outp "movlpd qword ptr [esp]" + COMMA + src
				outp "fld qword ptr [esp]"
			else
				outp "movss dword ptr [esp]" + COMMA + src
				outp "fld dword ptr [esp]"
			end if
			outp "add esp, 8"
		else
			outp "fld " + src
		end if
	end if

	hPrepOperand64( dvreg, dst, aux )

	'' signed?
	'' (handle ULONGINT here too - workaround for #2082801)
	if( typeIsSigned( dvreg->dtype ) orelse (dvreg->dtype = FB_DATATYPE_ULONGINT) ) then

		outp "sub esp, 8"

		ostr = "fistp " + dtypeTB(dvreg->dtype).mname + " [esp]"
		outp ostr

	'' unsigned.. try a bigger type
	else
		outp "fld st(0)"
		'' UWtype hi = (UWtype)(a / Wtype_MAXp1_F)
		outp "push 0x4f800000"
		outp "fdiv dword ptr [esp]"
		outp "fistp dword ptr [esp]"
		'' UWtype lo = (UWtype)(a - ((DFtype)hi) * Wtype_MAXp1_F)
		outp "fild dword ptr [esp]"
		outp "push 0x4f800000"
		outp "fmul dword ptr [esp]"
		outp "fsubp"
		outp "fistp dword ptr [esp]"
		'' ((UDWtype) hi << W_TYPE_SIZE) | lo
	end if

	hPOP( dst )
	hPOP( aux )

end sub



'':::::
private sub _emitLOADF2I_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, suffix
	dim as string aux, aux8_16
	dim as integer sdsize, ddsize
	dim as integer isFree, reg, wasReg

	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr tempVreg

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' special case unsigned integer
	if( ( typeIsSigned( dvreg->dtype ) = FALSE ) and ( ddsize = 4 ) ) then
		outp "sub esp, 8"
		if( svreg->typ <> IR_VREGTYPE_REG ) then
			outp "fld " + src
		elseif( svreg->regFamily = IR_REG_SSE ) then
			if( sdsize > 4 ) then
				outp "movlpd qword ptr [esp]" + COMMA + src
				outp "fld qword ptr [esp]"
			else
				outp "movss dword ptr [esp]" + COMMA + src
				outp "fld dword ptr [esp]"
			end if
		end if
		outp "fistp qword ptr [esp]"
		hPOP dst
		outp "add esp, 4"
		exit sub
	end if

	if( dvreg->typ = IR_VREGTYPE_REG ) Then
		'' dst is a register
		isfree = TRUE
		'' not an integer? make it
		if( ddsize < 4 ) then
			dst = *hGetRegName( FB_DATATYPE_INTEGER, dvreg->reg )
		end if

		aux = dst
		wasreg = TRUE
	else
		'' dst is not a register
		wasReg = FALSE
		'' find a register
		reg = hFindRegNotInVreg( svreg )

		aux = *hGetRegName( FB_DATATYPE_INTEGER, reg )
		aux8_16 = *hGetRegName( dvreg->dtype, reg )

		isFree = hIsRegFree( FB_DATACLASS_INTEGER, reg )
		if( isFree = FALSE ) then
			hPUSH aux
		end if
	end if

	if( svreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp, 4"
		if( ddsize = 2 ) then
			outp "fistp word ptr [esp]"
		else
			outp "fistp dword ptr [esp]"
		end if
		hPOP aux
	else
		suffix = chr( iif( sdsize > 4 , 100, 115 ) )
		if( typeIsSigned( dvreg->dtype ) and ( ddsize = 2 ) ) then
			if( svreg->typ <> IR_VREGTYPE_REG ) then
				if( sdsize > 4 ) then
					outp "movlpd xmm7" + COMMA + src
				else
					outp "movss xmm7" + COMMA + src
				end if
				src = "xmm7"
			end if
			outp "cvtp" + suffix + "2dq xmm7" + COMMA + src
			outp "packssdw xmm7, xmm7"
			outp "movd " + aux + COMMA + "xmm7"
		else
			'' GAS doesn't like 32-bit dst and 64-bit src here... leave off the prefix
			hPrepOperand( svreg, src, , , , FALSE )
			outp "cvts" + suffix + "2si " + aux + COMMA + src
		end if
	end if

	if( wasReg = FALSE ) then
		if( ddsize = 4 ) then
			outp "mov " + dst + COMMA + aux
		else
			outp "mov " + dst + COMMA + aux8_16
		endif
		if( isFree = FALSE ) then
			hPOP aux
		end if
	end if
end sub



'':::::
private sub _emitLOADL2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, aux
	dim as string ostr
	dim as integer ddsize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( typeIsSigned( svreg->dtype ) ) then

			hPrepOperand64( svreg, src, aux )

			hPUSH( aux )
			hPUSH( src )

			ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr

			outp "add esp, 8"

		'' unsigned, try a bigger type..
		else

			hPrepOperand64( svreg, src, aux )
			hPUSH aux
			hPUSH src
			outp "fild qword ptr [esp]"
			outp "add esp, 8"
			hULONG2DBL( svreg )

		end if

	'' not a reg or imm
	else

		'' signed?
		if( typeIsSigned( svreg->dtype ) ) then
			ostr = "fild " + src
			outp ostr

		'' unsigned, try a bigger type..
		else
			ostr = "fild " + src
			outp ostr
			hULONG2DBL( svreg )
		end if

	end if

	ddsize = typeGetSize( dvreg->dtype )

	outp "sub esp" + COMMA + str( ddsize )
	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )
end sub



'':::::
private sub _emitLOADI2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer sdsize, ddsize
	dim as string suffix
	dim as string aux
	dim as integer isfree, reg
	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr tempVreg

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' special case for unsigned integers
	if( (typeIsSigned( svreg->dtype ) = 0) and (sdsize = 4) ) then
		'' find a register
		reg = hFindRegNotInVreg( svreg )
		aux = *hGetRegName( FB_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( FB_DATACLASS_INTEGER, reg )
		if( isfree = FALSE ) then
			hPUSH aux
		end if

		if( ddsize > 4 ) then
			sym = symbAllocIntConst( &h40F0000000000000, FB_DATATYPE_ULONGINT )
			tempVreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
			suffix = "sd "
		else
			sym = symbAllocIntConst( &h47800000, FB_DATATYPE_UINT )
			tempVreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
			suffix = "ss "
		end if

		sym->var_.align = 16

		outp "mov " + aux + COMMA + src
		outp "and " + aux + COMMA + "0xFFFF"
		outp "cvtsi2" + suffix + dst + COMMA + aux

		outp "mov " + aux + COMMA + src
		outp "shr " + aux + COMMA + "16"
		outp "cvtsi2" + suffix + "xmm7" + COMMA + aux

		hPrepOperand( tempVreg, src )
		outp "mul" + suffix + "xmm7" + COMMA + src
		outp "add" + suffix + dst + COMMA + "xmm7"
		if( isfree = FALSE ) then
			hPOP aux
		end if
		exit sub
	end if

	if( (svreg->typ <> IR_VREGTYPE_IMM) and (sdsize = 4) ) then
		'' src is 32-bit mem or register
		isfree = TRUE
		aux = src           '' just use it
	else
		'' src is not 32-bit mem or register
		'' find a register
		reg = hFindRegNotInVreg( svreg )

		aux = *hGetRegName( FB_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( FB_DATACLASS_INTEGER, reg )
		if( isfree = FALSE ) then
			hPUSH aux
		end if

		if( (svreg->typ = IR_VREGTYPE_IMM) or (sdsize = 4) ) then
			outp "mov " + aux + COMMA + src
		else
			if( typeIsSigned( svreg->dtype ) ) then
				outp "movsx " + aux + COMMA + src
			else
				outp "movzx " + aux + COMMA + src
			end if
		end if
	end if

	if( ddsize > 4 ) then
		outp "cvtsi2sd " + dst + COMMA + aux
	else
		outp "cvtsi2ss " + dst + COMMA + aux
	end if
	if( isfree = FALSE ) then
		hPOP aux
	end if

	if( dvreg->regFamily = IR_REG_SSE ) then exit sub

	outp "sub esp" + COMMA + str( ddsize )
	if( ddsize > 4 ) then
		outp "movlpd [esp]" + COMMA + dst
		outp "fld qword ptr [esp]"
	else
		outp "movss [esp]" + COMMA + dst
		outp "fld dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub



'':::::
private sub _emitLOADF2F_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string src, dst
	dim as integer sdsize, ddsize

	hPrepOperand( dvreg, dst, , , , FALSE )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		hPrepOperand( svreg, src )
		outp "fld " + src
		exit sub
	end if

	hPrepOperand( svreg, src, , , , FALSE )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	if( sdsize = ddsize ) then
		if( svreg->vector ) then
			hPrepOperand( svreg, src, , , , FALSE )
			if( ddsize > 4 ) then
				outp "movupd " + dst + COMMA + src
			else
				if( svreg->vector = 2 ) then
					outp "movlps " + dst + COMMA + src
				else
					outp "movups " + dst + COMMA + src
				end if
			end if
			exit sub
		end if

		if( ddsize > 4 ) then
			outp "movlpd " + dst + COMMA + src
		else
			outp "movss " + dst + COMMA + src
		end if
	elseif( sdsize > 4 ) then
		'' source is a double, dst is single
		if( svreg->vector ) then
			outp "cvtpd2ps " + dst + COMMA + src
		else
			outp "cvtsd2ss " + dst + COMMA + src
		end if
	else
		'' source is a single, dst is double
		if( svreg->vector ) then
			outp "cvtps2pd " + dst + COMMA + src
		else
			outp "cvtss2sd " + dst + COMMA + src
		end if
	end if
end sub


'':::::
private sub _emitMOVF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer sdsize, ddsize

	hPrepOperand( dvreg, dst, , , , FALSE )
	hPrepOperand( svreg, src, , , , FALSE )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	if( sdsize > 4 ) and ( ddsize <= 4 ) then
		'' source is a double
		if( svreg->vector ) then
			outp "cvtpd2ps " + dst + COMMA + src
		else
			outp "cvtsd2ss " + dst + COMMA + src
		end if
	elseif( ddsize > 4 ) and ( sdsize <= 4 ) then
		'' source is a single
		if( svreg->vector ) then
			outp "cvtps2pd " + dst + COMMA + src
		else
			outp "cvtss2sd " + dst + COMMA + src
		end if
	else
		outp "movaps " + dst + COMMA + src
	end if

end sub



'':::::
'' replicate the scalar operand
private sub _emitSWZREPF_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )

	hPrepOperand( dvreg, dst )

	if( ddsize > 4 ) then
		outp "unpcklpd " + dst + COMMA + dst
	else
		if( dvreg->vector = 2 ) then
			outp "unpcklps " + dst + COMMA + dst
		else
			outp "shufps " + dst + COMMA + dst + COMMA + "0x0"
		end if
	end if

end sub


'':::::
'' emit code to convert operands, if necessary. return TRUE if conversion occured
private function hEmitConvertOperands_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) as integer static

	dim as string dst, src, ostr
	dim As integer sdsize, ddsize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	function = FALSE

	if( ddsize > 4 ) then
		if( sdsize = 4 ) then
			'' convert src to double
			if( svreg->vector ) then
				outp "cvtps2pd xmm7" + COMMA + src
			else
				outp "cvtss2sd xmm7" + COMMA + src
			end if
			function = TRUE
		end if
	else
		if( sdsize > 4 ) then
			'' convert src to single
			if( svreg->vector ) then
				outp "cvtpd2ps xmm7" + COMMA + src
			else
				outp "cvtsd2ss xmm7" + COMMA + src
			end if
			function = TRUE
		end if
	end if

end function



'':::::
private sub _emitADDF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, ostr
	dim As integer sdsize, ddsize, returnSize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' if either operand is returned from a function, grab it from st(0)
	returnSize = 0
	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = dst
		returnSize = ddsize
	elseif( svreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = src
		returnSize = sdsize
	end if

	if( returnSize ) then
		outp "sub esp" + COMMA + str( returnSize )
	end if
	if( returnSize = 8 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + ostr + COMMA + "qword ptr [esp]"
	elseif( returnSize = 4) then
		outp "fstp dword ptr [esp]"
		outp "movss " + ostr + COMMA + "dword ptr [esp]"
	end if
	if( returnSize ) then
		outp "add esp" + COMMA + str( returnSize )
	end if

	ostr = "adds"

	if( svreg->vector ) then
		ostr = "addp"

		if( svreg->typ <> IR_VREGTYPE_REG ) then
			hPrepOperand( svreg, src, , , , FALSE )
			if( sdsize > 4 ) then
				outp "movupd xmm7" + COMMA + src
			else
				if( svreg->vector = 2 ) then
					outp "movlps xmm7" + COMMA + src
				else
					outp "movups xmm7" + COMMA + src
				end if
			end if
			src = "xmm7"
		end if
	end if

	if( hEmitConvertOperands_SSE( dvreg, svreg ) ) then
		src = "xmm7"
	end if

	if( typeGetClass( svreg->dtype ) = FB_DATACLASS_FPOINT ) then
		if( ddsize > 4 ) then
			'' add them as double-precision
			outp ostr + "d " + dst + COMMA + src
		else
			'' add them as single-precision
			outp ostr + "s " + dst + COMMA + src
		end if
	else
		'' This should never happen due to IR_OPT_FPUCONV
		outp " implement 'add integer to float'"
		assert( 0 )
	end if
end sub




'':::::
private sub _emitSUBF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, ostr
	dim As integer sdsize, ddsize, returnSize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' if either operand is returned from a function, grab it from st(0)
	returnSize = 0
	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = dst
		returnSize = ddsize
	elseif( svreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = src
		returnSize = sdsize
	end if

	if( returnSize ) then
		outp "sub esp" + COMMA + str( returnSize )
	end if
	if( returnSize = 8 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + ostr + COMMA + "qword ptr [esp]"
	elseif( returnSize = 4) then
		outp "fstp dword ptr [esp]"
		outp "movss " + ostr + COMMA + "dword ptr [esp]"
	end if
	if( returnSize ) then
		outp "add esp" + COMMA + str( returnSize )
	end if

	ostr = "subs"
	if( svreg->vector ) then
		ostr = "subp"

		if( svreg->typ <> IR_VREGTYPE_REG ) then
			hPrepOperand( svreg, src, , , , FALSE )
			if( sdsize > 4 ) then
				outp "movupd xmm7" + COMMA + src
			else
				if( svreg->vector = 2 ) then
					outp "movlps xmm7" + COMMA + src
				else
					outp "movups xmm7" + COMMA + src
				end if
			end if
			src = "xmm7"
		end if
	end if

	if( hEmitConvertOperands_SSE( dvreg, svreg ) ) then
		src = "xmm7"
	end if

	if( typeGetClass( svreg->dtype ) = FB_DATACLASS_FPOINT ) then
		if( ddsize > 4 ) then
			'' subtract them as double-precision
			outp ostr + "d " + dst + COMMA + src
		else
			'' subtract them as single-precision
			outp ostr + "s " + dst + COMMA + src
		end if
	else
		'' This should never happen due to IR_OPT_FPUCONV
		outp " implement 'subtract integer from float'"
		assert( 0 )
	end if
end sub



'':::::
private sub _emitMULF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, ostr
	dim As integer sdsize, ddsize, returnSize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' if either operand is returned from a function, grab it from st(0)
	returnSize = 0
	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = dst
		returnSize = ddsize
	elseif( svreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = src
		returnSize = sdsize
	end if

	if( returnSize ) then
		outp "sub esp" + COMMA + str( returnSize )
	end if
	if( returnSize = 8 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + ostr + COMMA + "qword ptr [esp]"
	elseif( returnSize = 4) then
		outp "fstp dword ptr [esp]"
		outp "movss " + ostr + COMMA + "dword ptr [esp]"
	end if
	if( returnSize ) then
		outp "add esp" + COMMA + str( returnSize )
	end if

	ostr = "muls"
	if( svreg->vector ) then
		ostr = "mulp"

		if( svreg->typ <> IR_VREGTYPE_REG ) then
			hPrepOperand( svreg, src, , , , FALSE )
			if( sdsize > 4 ) then
				outp "movupd xmm7" + COMMA + src
			else
				if( svreg->vector = 2 ) then
					outp "movlps xmm7" + COMMA + src
				else
					outp "movups xmm7" + COMMA + src
				end if
			end if
			src = "xmm7"
		end if
	end if

	if( hEmitConvertOperands_SSE( dvreg, svreg ) ) then
		src = "xmm7"
	end if

	if( typeGetClass( svreg->dtype ) = FB_DATACLASS_FPOINT ) then
		if( ddsize > 4 ) then
			'' multiply them as double-precision
			outp ostr + "d " + dst + COMMA + src
		else
			'' multiply them as single-precision
			outp ostr + "s " + dst + COMMA + src
		end if
	else
		'' This should never happen due to IR_OPT_FPUCONV
		outp " implement 'multiply float by integer'"
		assert( 0 )
	end if

end sub



'':::::
private sub _emitDIVF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string dst, src, ostr
	dim As integer sdsize, ddsize, returnSize

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	'' if either operand is returned from a function, grab it from st(0)
	returnSize = 0
	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = dst
		returnSize = ddsize
	elseif( svreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = src
		returnSize = sdsize
	end if

	if( returnSize ) then
		outp "sub esp" + COMMA + str( returnSize )
	end if
	if( returnSize = 8 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + ostr + COMMA + "qword ptr [esp]"
	elseif( returnSize = 4) then
		outp "fstp dword ptr [esp]"
		outp "movss " + ostr + COMMA + "dword ptr [esp]"
	end if
	if( returnSize ) then
		outp "add esp" + COMMA + str( returnSize )
	end if

	ostr = "divs"
	if( svreg->vector ) then
		ostr = "divp"

		if( svreg->typ <> IR_VREGTYPE_REG ) then
			hPrepOperand( svreg, src, , , , FALSE )
			if( sdsize > 4 ) then
				outp "movupd xmm7" + COMMA + src
			else
				if( svreg->vector = 2 ) then
					outp "movlps xmm7" + COMMA + src
				else
					outp "movups xmm7" + COMMA + src
				end if
			end if
			src = "xmm7"
		end if
	end if

	if( hEmitConvertOperands_SSE( dvreg, svreg ) ) then
		src = "xmm7"
	end if

	if( typeGetClass( svreg->dtype ) = FB_DATACLASS_FPOINT ) then
		if( ddsize > 4 ) then
			'' divide them as double-precision
			outp ostr + "d " + dst + COMMA + src
		else
			'' divide them as single-precision
			outp ostr + "s " + dst + COMMA + src
		end if
	else
		'' This should never happen due to IR_OPT_FPUCONV
		outp " implement 'divide float by integer'"
		assert( 0 )
	end if

end sub



'':::::
private sub _emitATN2_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string src, dst, ostr
	dim as integer sdsize, ddsize
	dim as integer adjustStack

	hPrepOperand( svreg, src )
	hPrepOperand( dvreg, dst )

	sdsize = typeGetSize( svreg->dtype )
	ddsize = typeGetSize( dvreg->dtype )

	adjustStack = FALSE
	if( dvreg->typ = IR_VREGTYPE_REG ) then
		outp "sub esp, 8"
		adjustStack = TRUE
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	else
		outp "fld " + dst
	end if

	if( svreg->typ = IR_VREGTYPE_REG ) then
		if( adjustStack = FALSE ) then
			outp "sub esp, 8"
			adjustStack = TRUE
		end if
		if( sdsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + src
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + src
			outp "fld dword ptr [esp]"
		end if
	else
		outp "fld " + src
	end if
	outp "fpatan"

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	if( adjustStack ) then
		outp "add esp, 8"
	end if
end sub

'':::::
private sub _emitPOW_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string src, dst, ostr
	dim as integer sdsize, ddsize
	dim as integer adjustStack

	hPrepOperand( svreg, src )
	hPrepOperand( dvreg, dst )

	adjustStack = FALSE
	if( dvreg->typ = IR_VREGTYPE_REG ) then
		outp "sub esp, 8"
		adjustStack = TRUE
		if (ddsize > 4) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	else
		outp "fld " + dst
	end if

	if( svreg->typ = IR_VREGTYPE_REG ) then
		if( adjustStack = FALSE ) then
			outp "sub esp, 8"
			adjustStack = TRUE
		end if
		if (sdsize > 4) then
			outp "movlpd qword ptr [esp]" + COMMA + src
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + src
			outp "fld dword ptr [esp]"
		end if
	else
		outp "fld " + src
	end if

	outp "fabs"
	outp "fyl2x"
	outp "fld st(0)"
	outp "frndint"
	outp "fsub st(1), st(0)"
	outp "fxch"
	outp "f2xm1"
	outp "fld1"
	outp "faddp"
	outp "fscale"
	outp "fstp st(1)"

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	if( adjustStack ) then
		outp "add esp, 8"
	end if

end sub


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' relational
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub hCMPF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval mnemonic as zstring ptr, _
		byval mask as zstring ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	dim as string rname, rname8, dst, src, ostr, lname
	dim as integer iseaxfree, isedxfree
	dim as integer sdsize, ddsize, returnSize

	ddsize = typeGetSize( dvreg->dtype )
	sdsize = typeGetSize( svreg->dtype )

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( label = NULL ) then
		lname = *symbUniqueLabel( )
	else
		lname = *symbGetMangledName( label )
	end if

	'' if either operand is returned from a function, grab it from st(0)
	returnSize = 0
	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = dst
		returnSize = ddsize
	elseif( svreg->regFamily = IR_REG_FPU_STACK ) then
		ostr = src
		returnSize = sdsize
	end if

	if( returnSize ) then
		outp "sub esp" + COMMA + str( returnSize )
	end if
	if( returnSize = 8 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + ostr + COMMA + "qword ptr [esp]"
	elseif( returnSize = 4) then
		outp "fstp dword ptr [esp]"
		outp "movss " + ostr + COMMA + "dword ptr [esp]"
	end if
	if( returnSize ) then
		outp "add esp" + COMMA + str( returnSize )
	end if

	'' src is either mem or a reg... dst is always a reg?

	'' this is set up to convert a single to a double, unless both are singles
	if( ddsize > 4 ) then
		if( sdsize > 4 ) then
			outp "comisd " + dst + COMMA + src
		else
			outp "cvtss2sd xmm7" + COMMA + src
			outp "comisd " + dst + COMMA + "xmm7"
		end if
	else
		if( sdsize > 4 ) then
			outp "cvtss2sd xmm7" + COMMA + dst
			outp "comisd xmm7" + COMMA + src
		else
			outp "comiss " + dst + COMMA + src
		end if
	end if

	'' no result to be set? just branch
	if( rvreg = NULL ) then
		ostr = "j" + *mnemonic
			hBRANCH( ostr, lname )
		exit sub
	end if

	hPrepOperand( rvreg, rname )

	'' can it be optimized?
	if( env.clopt.cputype >= FB_CPUTYPE_486 ) then
		rname8 = *hGetRegName( FB_DATATYPE_BYTE, rvreg->reg )

		'' handle EDI and ESI
		if( (rvreg->reg = EMIT_REG_ESI) or (rvreg->reg = EMIT_REG_EDI) ) then

			isedxfree = hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EDX )
			if( isedxfree = FALSE ) then
				ostr = "xchg edx, " + rname
				outp ostr
			end if

			ostr = "set" + *mnemonic + (TABCHAR + "dl")
			outp ostr

			if( isedxfree = FALSE ) then
				ostr = "xchg edx, " + rname
				outp ostr
			else
				hMOV rname, "edx"
			end if
		else
			ostr = "set" + *mnemonic + " " + rname8
			outp ostr
		end if

		'' convert 1 to -1 (TRUE in QB/FB)
		ostr = "shr " + rname + ", 1"
		outp ostr

		ostr = "sbb " + rname + COMMA + rname
		outp ostr
	else
		'' old (and slow) boolean set
			ostr = "mov " + rname + ", -1"
			outp ostr

			ostr = "j" + *mnemonic
			hBRANCH( ostr, lname )

		ostr = "xor " + rname + COMMA + rname
		outp ostr

		hLabel( lname )
	end if

end sub




'':::::
private sub _emitCGTF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "a", "", dvreg, svreg )

end sub



'':::::
private sub _emitCLTF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "b", "", dvreg, svreg )

end sub


'':::::
private sub _emitCEQF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "e", "", dvreg, svreg )

end sub


'':::::
private sub _emitCNEF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "ne", "", dvreg, svreg )

end sub


'':::::
private sub _emitCLEF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "be", "", dvreg, svreg )

end sub


'':::::
private sub _emitCGEF_SSE _
	( _
		byval rvreg as IRVREG ptr, _
		byval label as FBSYMBOL ptr, _
		byval dvreg as IRVREG ptr, _
		byval svreg as IRVREG ptr _
	) static

	hCMPF_SSE( rvreg, label, "ae", "", dvreg, svreg )

end sub



'':::::
private sub _emitNEGF_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer ddsize
	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr tempVreg

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
		outp "add esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		sym = symbAllocIntConst(&h8000000000000000, FB_DATATYPE_ULONGINT)
		tempVreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
	else
		sym = symbAllocIntConst(&h80000000, FB_DATATYPE_UINT)
		tempVreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
	end if
	sym->var_.align = 16

	hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )

	if( ddsize > 4 ) then
		outp "xorpd " + dst + COMMA + src
	else
		outp "xorps " + dst + COMMA + src
	end if

end sub


'':::::
private sub _emitHADDF_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim dst as string

	hPrepOperand( dvreg, dst )

	if( typeGetSize( dvreg->dtype ) > 4 ) then
		outp "movhlps xmm7" + COMMA + dst
		outp "addsd " + dst + COMMA + "xmm7"
	else
		if( dvreg->vector = 2 ) then
			outp "pshufd xmm7" + COMMA + dst + COMMA + "0x01"
			outp "addss " + dst + COMMA + "xmm7"
		elseif( dvreg->vector = 3 ) then
			outp "pshufd xmm7" + COMMA + dst + COMMA + "0x01"
			outp "addss " + dst + COMMA + "xmm7"
			outp "movhlps xmm7" + COMMA + dst
			outp "addss " + dst + COMMA + "xmm7"
		elseif( dvreg->vector = 4 ) then
			outp "movhlps xmm7" + COMMA + dst
			outp "addps " + dst + COMMA + "xmm7"
			outp "pshufd xmm7" + COMMA + dst + COMMA + "0x01"
			outp "addss " + dst + COMMA + "xmm7"
		else
			assert( 0 )
		end if
	end if

end sub


'':::::
private sub _emitABSF_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as integer ddsize
	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr tempVreg

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
		outp "add esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		sym = symbAllocIntConst(&h7FFFFFFFFFFFFFFF, FB_DATATYPE_ULONGINT)
		tempVreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
	else
		sym = symbAllocIntConst(&h7FFFFFFF, FB_DATATYPE_UINT)
		tempVreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
	end if
	sym->var_.align = 16

	hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )

	if( ddsize > 4 ) then
		outp "andpd " + dst + COMMA + src
	else
		outp "andps " + dst + COMMA + src
	end if

end sub



'':::::
private sub _emitSGNF_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst, src
	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr tempVreg
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
		outp "add esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "xorpd xmm7, xmm7"
		outp "cmpneqsd xmm7" + COMMA + dst

		sym = symbAllocIntConst(&h7FFFFFFFFFFFFFFF, FB_DATATYPE_ULONGINT)
		sym->var_.align = 16
		tempVreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
		hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )
		outp "orpd " + dst + COMMA + src

		sym = symbAllocIntConst(&hBFF0000000000000, FB_DATATYPE_ULONGINT)
		sym->var_.align = 16
		tempVreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
		hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )
		outp "andpd xmm7" + COMMA + src

		outp "andpd " + dst + COMMA + "xmm7"
	else
		outp "xorps xmm7, xmm7"
		outp "cmpneqss xmm7" + COMMA + dst

		sym = symbAllocIntConst(&h7FFFFFFF, FB_DATATYPE_UINT)
		sym->var_.align = 16
		tempVreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
		hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )
		outp "orps " + dst + COMMA + src        '' set bits 31-0, sign is unchanged"

		sym = symbAllocIntConst(&hBF800000, FB_DATATYPE_UINT)
		sym->var_.align = 16
		tempVreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
		hPrepOperand( tempVreg, src, FB_DATATYPE_XMMWORD )
		outp "andps xmm7" + COMMA + src         '' load -1.0f, kill if == 0.0f"

		outp "andps " + dst + COMMA + "xmm7"    '' get +/-1.0f or 0.0f"
	end if
end sub


'':::::
private sub _emitSINCOS_FAST_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval iscos as integer _
	) static

	dim as integer reg(2), isFree(2), stackSize, i, stackPointer
	dim as string dst, src, regName(2)
	dim as FBSYMBOL ptr sym_invSignBitMask, sym_one, sym_piOverTwo, sym_twoOverPI
	dim as FBSYMBOL ptr sym_sin_c0, sym_sin_c1, sym_sin_c2, sym_sin_c3
	dim as IRVREG ptr vReg_invSignBitMask, vReg_one, vReg_piOverTwo, vReg_twoOverPI
	dim as IRVREG ptr vReg_sin_c0, vReg_sin_c1, vReg_sin_c2, vReg_sin_c3

	hPrepOperand( dvreg, dst )

	stackSize = 4       '' 4 bytes always needed

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		stackSize += 4
	end if

	'' find a register
	reg(0) = EMIT_REG_ECX
	isFree(0) = FALSE

	reg(1) = EMIT_REG_EAX
	isFree(1) = FALSE
	if( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_ECX ) ) then
		reg(0) = EMIT_REG_ECX
		isFree(0) = TRUE
		if( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EDX ) ) then
			reg(1) = EMIT_REG_EDX
			isFree(1) = TRUE
		elseif( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EAX ) ) then
			reg(1) = EMIT_REG_EAX
			isFree(1) = TRUE
		end if
	elseif( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EDX ) ) then
		reg(0) = EMIT_REG_EDX
		isFree(0) = TRUE
		if( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EAX ) ) then
			reg(1) = EMIT_REG_EAX
			isFree(1) = TRUE
		end if
	else
		if( hIsRegFree( FB_DATACLASS_INTEGER, EMIT_REG_EAX ) ) then
			reg(1) = EMIT_REG_EAX
			isFree(1) = TRUE
		end if
	end if

	reg(2) = hFindFreeReg( FB_DATACLASS_FPOINT )
	if( reg(2) = INVALID ) then
		reg(2) = EMIT_REG_FP0
		isFree(2) = FALSE
	else
		isFree(2) = TRUE
	end if

	stackSize += (4 * (isFree(0) And 1))
	stackSize += (4 * (isFree(1) And 1))
	stackSize += (4 * (isFree(2) And 1))

	regName(0) = *hGetRegName( FB_DATATYPE_INTEGER, reg(0) )
	regName(1) = *hGetRegName( FB_DATATYPE_INTEGER, reg(1) )
	regName(2) = *hGetRegName( FB_DATATYPE_SINGLE, reg(2) )

	sym_invSignBitMask = symbAllocIntConst(&h7FFFFFFF, FB_DATATYPE_UINT)
	sym_invSignBitMask->var_.align = 16
	vReg_invSignBitMask = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_invSignBitMask, symbGetOfs( sym_invSignBitMask ) )

	sym_piOverTwo = symbAllocIntConst(&h3FC90FDB, FB_DATATYPE_UINT)
	sym_piOverTwo->var_.align = 16
	vReg_piOverTwo = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_piOverTwo, symbGetOfs( sym_piOverTwo ) )

	sym_twoOverPI = symbAllocIntConst(&h3F22F983, FB_DATATYPE_UINT)
	sym_twoOverPI->var_.align = 16
	vReg_twoOverPI = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_twoOverPI, symbGetOfs( sym_twoOverPI ) )

	sym_one = symbAllocIntConst(&h3F800000, FB_DATATYPE_UINT)
	sym_one->var_.align = 16
	vReg_one = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_one, symbGetOfs( sym_one ) )

	sym_sin_c0 = symbAllocIntConst(&h3FC90FDB, FB_DATATYPE_UINT)
	sym_sin_c0->var_.align = 16
	vReg_sin_c0 = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_sin_c0, symbGetOfs( sym_sin_c0 ) )

	sym_sin_c1 = symbAllocIntConst(&hBF255DE7, FB_DATATYPE_UINT)
	sym_sin_c1->var_.align = 16
	vReg_sin_c1 = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_sin_c1, symbGetOfs( sym_sin_c1 ) )

	sym_sin_c2 = symbAllocIntConst(&h3DA335E3, FB_DATATYPE_UINT)
	sym_sin_c2->var_.align = 16
	vReg_sin_c2 = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_sin_c2, symbGetOfs( sym_sin_c2 ) )

	sym_sin_c3 = symbAllocIntConst(&hBB996966, FB_DATATYPE_UINT)
	sym_sin_c3->var_.align = 16
	vReg_sin_c3 = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym_sin_c3, symbGetOfs( sym_sin_c3 ) )

	hPrepOperand( dvreg, dst )

	outp "sub esp" + COMMA + str( stackSize )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if

	stackPointer = 4
	for i = 0 to 2
		if( isFree(i) = FALSE ) then
			if( i < 2 ) then
				outp "mov [esp+" + str(stackPointer) + "]" + COMMA + regName(i)
			else
				outp "movss [esp+" + str(stackPointer) + "]" + COMMA + regName(i)
			end if
			stackPointer += 4
		end if
	next i

if( iscos = FALSE ) then
	outp "movss [esp]" + COMMA + dst

	hPrepOperand( vReg_twoOverPI, src )
	outp "mulss " + dst + COMMA + src

	outp "and       dword ptr [esp], 0x80000000"
end if

	hPrepOperand( vReg_invSignBitMask, src, FB_DATATYPE_XMMWORD )
	outp "andps " + dst + COMMA + src

if( iscos = TRUE ) then
	hPrepOperand( vReg_piOverTwo, src )
	outp "addss " + dst + COMMA + src

	hPrepOperand( vReg_twoOverPI, src )
	outp "mulss " + dst + COMMA + src
end if

	outp "cvttss2si " + regName(0) + COMMA + dst

	hPrepOperand( vReg_one, src )
	outp "movss xmm7" + COMMA + src
	outp "mov       " + regName(1) + COMMA + regName(0)
	outp "cvtsi2ss  " + regName(2) + COMMA + regName(0)
	outp "shl       " + regName(1) + COMMA + "30"
	outp "not       " + regName(0)
	outp "and       " + regName(1) + COMMA + "0x80000000"
	outp "and       " + regName(0) + COMMA + "0x1"
	outp "subss " + dst + COMMA + regName(2)
	outp "dec       " + regName(0)
	outp "minss " + dst + COMMA + "xmm7"
	outp "movd      " + regName(2) + COMMA + regName(0)
	outp "subss xmm7" + COMMA + dst
	outp "andps xmm7" + COMMA + regName(2)
	outp "andnps    " + regName(2) + COMMA + dst
	outp "orps      xmm7" + COMMA + regName(2)
if( iscos = FALSE ) then
	outp "xor       " + regName(1) + COMMA + "[esp]"
end if
	outp "movd      " + regName(0) + COMMA + "xmm7"

	outp "mulss xmm7, xmm7"

	outp "or        " + regName(1) + COMMA + regName(0)

	outp "movss " + regName(2) + COMMA + "xmm7"

	hPrepOperand( vReg_sin_c3, src )
	outp "mulss xmm7" + COMMA + src

	hPrepOperand( vReg_sin_c2, src )
	outp "addss xmm7" + COMMA + src
	outp "mulss xmm7" + COMMA + regName(2)

	outp "movd      " + dst + COMMA + regName(1)

	hPrepOperand( vReg_sin_c1, src )
	outp "addss xmm7" + COMMA + src
	outp "mulss xmm7" + COMMA + regName(2)

	hPrepOperand( vReg_sin_c0, src )
	outp "addss xmm7" + COMMA + src
	outp "mulss " + dst + COMMA + "xmm7"

	stackPointer = 4
	for i = 0 to 2
		if( isFree(i) = FALSE ) then
			if( i < 2 ) then
				outp "mov " + regName(i) + COMMA + "[esp+" + str(stackPointer) + "]"
			else
				outp "movss " + regName(i) + COMMA + "[esp+" + str(stackPointer) + "]"
			end if
			stackPointer += 4
		end if
	next i

	outp "add esp" + COMMA + str( stackSize )
end sub



'':::::
private sub _emitSIN_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )

	if( ( ddsize = 4 ) and ( env.clopt.fpmode = FB_FPMODE_FAST ) ) then
		_emitSINCOS_FAST_SSE dvreg, FALSE
		exit sub
	end if

	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	outp "fsin"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitASIN_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	'' asin( x ) = atn( sqr( (x*x) / (1-x*x) ) )
	outp "fld st(0)"
	outp "fmul st(0), st(0)"
	outp "fld1"
	outp "fsubrp"
	outp "fsqrt"
	outp "fpatan"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitCOS_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )

	if( ( ddsize = 4 ) and ( env.clopt.fpmode = FB_FPMODE_FAST ) ) then
		_emitSINCOS_FAST_SSE dvreg, TRUE
		exit sub
	end if

	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	outp "fcos"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub



'':::::
private sub _emitACOS_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	'' acos( x ) = atn( sqr( (1-x*x) / (x*x) ) )
	outp "fld st(0)"
	outp "fmul st(0), st(0)"
	outp "fld1"
	outp "fsubrp"
	outp "fsqrt"
	outp "fxch"
	outp "fpatan"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitTAN_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	outp "fptan"
	outp "fstp st(0)"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitATAN_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	outp "fld1"
	outp "fpatan"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitSQRT_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	hPrepOperand( dvreg, dst )
	ddsize = typeGetSize( dvreg->dtype )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
	end if

	if( ddsize > 4 ) then
		outp "sqrtsd " + dst + COMMA + dst
	else
		outp "sqrtss " + dst + COMMA + dst
	end if

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "add esp" + COMMA + str( ddsize )
	end if

end sub

'':::::
private sub _emitRSQRT_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	hPrepOperand( dvreg, dst )
	ddsize = typeGetSize( dvreg->dtype )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
	end if

	if( ddsize > 4 ) then
		outp "rsqrtsd " + dst + COMMA + dst
	else
		outp "rsqrtss " + dst + COMMA + dst
	end if

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "add esp" + COMMA + str( ddsize )
	end if

end sub

'':::::
private sub _emitRCP_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	hPrepOperand( dvreg, dst )
	ddsize = typeGetSize( dvreg->dtype )

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "fstp qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fstp dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
	end if

	if( ddsize > 4 ) then
		outp "rcpsd " + dst + COMMA + dst
	else
		outp "rcpss " + dst + COMMA + dst
	end if

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "add esp" + COMMA + str( ddsize )
	end if

end sub


'':::::
private sub _emitLOG_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	'' log( x ) = log2( x ) / log2( e ).

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if


	outp "fldln2"
	outp "fxch"
	outp "fyl2x"

	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub

'':::::
private sub _emitEXP_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst
	dim as integer ddsize

	ddsize = typeGetSize( dvreg->dtype )
	hPrepOperand( dvreg, dst )

	if( dvreg->regFamily = IR_REG_SSE ) then
		outp "sub esp" + COMMA + str( ddsize )
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	end if

	outp "fldl2e"
	outp "fmulp st(1), st"
	outp "fld st"
	outp "frndint"
	outp "fsub st(1), st"
	outp "fxch"
	outp "f2xm1"
	'' can't use fld1 because max 2 fp regs can be used
	hPUSH( "0x3f800000" )
	outp "fadd dword ptr [esp]"
	outp "add esp, 4"
	outp "fscale"
	outp "fstp st(1)"


	if( dvreg->regFamily = IR_REG_FPU_STACK ) then
		outp "sub esp" + COMMA + str( ddsize )
	end if

	if( ddsize > 4 ) then
		outp "fstp qword ptr [esp]"
		outp "movlpd " + dst + COMMA + "qword ptr [esp]"
	else
		outp "fstp dword ptr [esp]"
		outp "movss " + dst + COMMA + "dword ptr [esp]"
	end if
	outp "add esp" + COMMA + str( ddsize )

end sub


'':::::
private sub _emitFLOOR_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	dim as string dst, neg1, suffix
	dim as integer ddsize
	dim as FBSYMBOL ptr sym
	dim as IRVREG ptr vreg

	ddsize = typeGetSize( dvreg->dtype )
	if( ddsize > 4 ) then
		sym = symbAllocIntConst(&hBFF0000000000000, FB_DATATYPE_ULONGINT)
		vreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, sym, symbGetOfs( sym ) )
		suffix = "d "
	else
		sym = symbAllocIntConst(&hBF800000, FB_DATATYPE_UINT)
		vreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, sym, symbGetOfs( sym ) )
		suffix = "s "
	end if
	sym->var_.align = 16

	hPrepOperand( dvreg, dst )
	hPrepOperand( vreg, neg1, FB_DATATYPE_XMMWORD )

	outp "sub esp, 8"

	if( dvreg->regFamily = IR_REG_SSE ) then
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
		outp "movap" + suffix + "xmm7" + COMMA + dst
	else
		if( ddsize > 4 ) then
			outp "fst qword ptr [esp]"
			outp "movlpd xmm7, qword ptr [esp]"
		else
			outp "fst dword ptr [esp]"
			outp "movss xmm7, dword ptr [esp]"
		end if
	end if

	outp "fistp qword ptr [esp]"
	outp "fild qword ptr [esp]"
	outp "fstp " + dtypeTB(dvreg->dtype).mname + " [esp]"   '' round(f)
	outp "xorp" + suffix + dst + COMMA + dst
	outp "subs" + suffix + "xmm7" + COMMA + "[esp]" '' f - round(f)
	outp "cmpnles" + suffix + dst + COMMA + "xmm7"  '' 0 > f - round(f) ? 1 : 0
	outp "andp" + suffix + dst + COMMA + neg1       '' F > I ? -1.0 : 0.0
	outp "adds" + suffix + dst + COMMA + "[esp]"

	outp "add esp, 8"

end sub


'':::::
private sub _emitFIX_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	'' dst = floor( abs( dst ) ) * sng( dst )

	dim as string dst, suffix, absval, neg1
	dim as integer ddsize
	dim as FBSYMBOL ptr neg1_sym, absval_sym
	dim as IRVREG ptr neg1_vreg, absval_vreg

	ddsize = typeGetSize( dvreg->dtype )
	if( ddsize > 4 ) then
		neg1_sym = symbAllocIntConst(&hBFF0000000000000, FB_DATATYPE_ULONGINT)
		neg1_vreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, neg1_sym, symbGetOfs( neg1_sym ) )

		absval_sym = symbAllocIntConst(&h8000000000000000, FB_DATATYPE_ULONGINT)
		absval_vreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, absval_sym, symbGetOfs( absval_sym ) )

		suffix = "d "
	else
		neg1_sym = symbAllocIntConst(&hBF800000, FB_DATATYPE_UINT)
		neg1_vreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, neg1_sym, symbGetOfs( neg1_sym ) )

		absval_sym = symbAllocIntConst(&h80000000, FB_DATATYPE_UINT)
		absval_vreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, absval_sym, symbGetOfs( absval_sym ) )

		suffix = "s "
	end if

	neg1_sym->var_.align = 16
	absval_sym->var_.align = 16

	hPrepOperand( dvreg, dst )
	hPrepOperand( neg1_vreg, neg1, FB_DATATYPE_XMMWORD )
	hPrepOperand( absval_vreg, absval, FB_DATATYPE_XMMWORD )

	outp "sub esp" + COMMA + str( ddsize + 8 )

	if( dvreg->regFamily = IR_REG_SSE ) then
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	else
		if( ddsize > 4 ) then
			outp "fst qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fst dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
	end if

	outp "xorp" + suffix + "xmm7, xmm7"
	if( ddsize > 4 ) then
		outp "movlpd [esp+8], xmm7"                         '' 0.0
	else
		outp "movss [esp+8], xmm7"                          '' 0.0
	end if

	outp "fistp qword ptr [esp]"
	outp "cmpnles" + suffix + "xmm7" + COMMA + dst          '' f < 0 ? 1 : 0
	outp "fild qword ptr [esp]"
	outp "andp" + suffix + "xmm7" + COMMA + absval          '' f < 0 ? -/+ : 0
	outp "fstp " + dtypeTB(dvreg->dtype).mname + " [esp]"       '' round(f)
	outp "subs" + suffix + dst + COMMA + "[esp]"                '' difference = (f - round(f))
	outp "xorp" + suffix + dst + COMMA + "xmm7"             '' f < 0 ? -difference : difference
	outp "xorp" + suffix + "xmm7" + COMMA + neg1                '' f < 0 ? 1.0 : -1.0
	'' difference < 0 ? 1 : 0
	outp "cmplts" + suffix + dst + COMMA + "[esp+8]"
	outp "andp" + suffix + dst + COMMA + "xmm7"             '' difference < 0 ? +/- 1.0 : 0.0
	outp "adds" + suffix + dst + COMMA + "[esp]"                '' round(f) +/- 1
	outp "add esp" + COMMA + str( ddsize + 8 )

end sub

'':::::
private sub _emitFRAC_SSE _
	( _
		byval dvreg as IRVREG ptr _
	) static

	'' dst = dst - fix( dst )

	dim as string dst, suffix, absval, neg1
	dim as integer ddsize
	dim as FBSYMBOL ptr neg1_sym, absval_sym
	dim as IRVREG ptr neg1_vreg, absval_vreg

	ddsize = typeGetSize( dvreg->dtype )
	if( ddsize > 4 ) then
		neg1_sym = symbAllocIntConst(&hBFF0000000000000, FB_DATATYPE_ULONGINT)
		neg1_vreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, neg1_sym, symbGetOfs( neg1_sym ) )

		absval_sym = symbAllocIntConst(&h8000000000000000, FB_DATATYPE_ULONGINT)
		absval_vreg = irAllocVRVAR( FB_DATATYPE_ULONGINT, NULL, absval_sym, symbGetOfs( absval_sym ) )

		suffix = "d "
	else
		neg1_sym = symbAllocIntConst(&hBF800000, FB_DATATYPE_UINT)
		neg1_vreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, neg1_sym, symbGetOfs( neg1_sym ) )

		absval_sym = symbAllocIntConst(&h80000000, FB_DATATYPE_UINT)
		absval_vreg = irAllocVRVAR( FB_DATATYPE_UINT, NULL, absval_sym, symbGetOfs( absval_sym ) )

		suffix = "s "
	end if
	neg1_sym->var_.align = 16
	absval_sym->var_.align = 16

	hPrepOperand( dvreg, dst )
	hPrepOperand( neg1_vreg, neg1, FB_DATATYPE_XMMWORD )
	hPrepOperand( absval_vreg, absval, FB_DATATYPE_XMMWORD )

	outp "sub esp" + COMMA + str( ddsize+8 )

	if( dvreg->regFamily = IR_REG_SSE ) then
		if( ddsize > 4 ) then
			outp "movlpd qword ptr [esp]" + COMMA + dst
			outp "fld qword ptr [esp]"
		else
			outp "movss dword ptr [esp]" + COMMA + dst
			outp "fld dword ptr [esp]"
		end if
	else
		if( ddsize > 4 ) then
			outp "fst qword ptr [esp]"
			outp "movlpd " + dst + COMMA + "qword ptr [esp]"
		else
			outp "fst dword ptr [esp]"
			outp "movss " + dst + COMMA + "dword ptr [esp]"
		end if
	end if

	outp "xorp" + suffix + "xmm7, xmm7"
	if( ddsize > 4 ) then
		outp "shufpd " + dst + COMMA + dst + COMMA + "0"
		outp "movlpd [esp+8], xmm7"                         '' 0.0
	else
		outp "movlhps " + dst + COMMA + dst
		outp "movss [esp+8], xmm7"                          '' 0.0
	end if

	outp "fistp qword ptr [esp]"
	outp "cmpnles" + suffix + "xmm7" + COMMA + dst          '' f < 0 ? 1 : 0
	outp "fild qword ptr [esp]"
	outp "andp" + suffix + "xmm7" + COMMA + absval          '' f < 0 ? - : +
	outp "fstp " + dtypeTB(dvreg->dtype).mname + " [esp]"   '' round(f)
	outp "subs" + suffix + dst + COMMA + "[esp]"            '' difference = (f - round(f))
	outp "xorp" + suffix + dst + COMMA + "xmm7"             '' f < 0 ? -difference : difference
	outp "xorp" + suffix + "xmm7" + COMMA + neg1            '' f < 0 ? 1.0 : -1.0
	'' difference < 0 ? 1 : 0
	outp "cmplts" + suffix + dst + COMMA + "[esp+8]"
	outp "andp" + suffix + "xmm7" + COMMA + dst             '' difference < 0 ? +/- 1.0 : 0.0
	if( ddsize > 4 ) then
		outp "shufpd " + dst + COMMA + dst + COMMA + "1"    '' restore dst
	else
		outp "movhlps " + dst + COMMA + dst                 '' restore dst
	end if
	outp "adds" + suffix + "xmm7" + COMMA + "[esp]"         '' round(f) +/- 1
	outp "subs" + suffix + dst + COMMA + "xmm7"             '' dst - fix(dst)
	outp "add esp" + COMMA + str( ddsize+8 )

end sub



''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


'':::::
private sub _emitPUSHF_SSE _
	( _
		byval svreg as IRVREG ptr, _
		byval unused as integer _
	) static

	dim src as string, sdsize as integer
	dim ostr as string

	hPrepOperand( svreg, src )

	sdsize = typeGetSize( svreg->dtype )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		if( svreg->dtype = FB_DATATYPE_SINGLE ) then
			ostr = "push " + src
			outp ostr
		else
			hPrepOperand( svreg, src, FB_DATATYPE_INTEGER, 4 )
			ostr = "push " + src
			outp ostr

				hPrepOperand( svreg, src, FB_DATATYPE_INTEGER, 0 )
			ostr = "push " + src
			outp ostr
		end if
	else
		ostr = "sub esp" + COMMA + str( sdsize )
		outp ostr

		'' floats are returned in st(0)
		if( svreg->regFamily = IR_REG_FPU_STACK ) then
			ostr = "fstp " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr
			exit sub
		end if

		if( sdsize > 4 ) then
			ostr = "movlpd "
		else
			ostr = "movss "
		end if
		outp ostr + "[esp]" + COMMA + src

	end if

end sub


'':::::
private sub _emitPOPF_SSE _
	( _
		byval dvreg as IRVREG ptr, _
		byval unused as integer _
	) static

	dim as string dst, ostr
	dim as integer dsize

	hPrepOperand( dvreg, dst )

	dsize = typeGetSize( dvreg->dtype )

	if( dvreg->typ <> IR_VREGTYPE_REG ) then
		if( dvreg->dtype = FB_DATATYPE_SINGLE ) then
			ostr = "pop " + dst
			outp ostr
		else
			hPrepOperand( dvreg, dst, FB_DATATYPE_INTEGER, 0 )
			ostr = "pop " + dst
			outp ostr

			hPrepOperand( dvreg, dst, FB_DATATYPE_INTEGER, 4 )
			ostr = "pop " + dst
			outp ostr
		end if
	else
		if( dsize > 4 ) then
			ostr = "movlpd "
		else
			ostr = "movss "
		end if
		outp ostr + dst + COMMA + dtypeTB(dvreg->dtype).mname + " [esp]"

		outp "add esp, " + str( dsize )
	end if

end sub


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions table
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#define EMIT_CBENTRY(op) @_emit##op##


function _init_opFnTB_SSE _
	( _
		byval _opFnTB_SSE as any ptr ptr _
	) as integer

	'' load
	_emitLOADB2F_x86 = _opFnTB_SSE[EMIT_OP_LOADB2F]
	_opFnTB_SSE[EMIT_OP_LOADF2I] = EMIT_CBENTRY(LOADF2I_SSE)
	_opFnTB_SSE[EMIT_OP_LOADI2F] = EMIT_CBENTRY(LOADI2F_SSE)
	_opFnTB_SSE[EMIT_OP_LOADF2L] = EMIT_CBENTRY(LOADF2L_SSE)
	_opFnTB_SSE[EMIT_OP_LOADL2F] = EMIT_CBENTRY(LOADL2F_SSE)
	_opFnTB_SSE[EMIT_OP_LOADF2F] = EMIT_CBENTRY(LOADF2F_SSE)
	_opFnTB_SSE[EMIT_OP_LOADB2F] = EMIT_CBENTRY(LOADB2F_SSE)

	'' store
	_opFnTB_SSE[EMIT_OP_STORF2I] = EMIT_CBENTRY(STORF2I_SSE)
	_opFnTB_SSE[EMIT_OP_STORI2F] = EMIT_CBENTRY(STORI2F_SSE)
	_opFnTB_SSE[EMIT_OP_STORF2L] = EMIT_CBENTRY(STORF2L_SSE)
	_opFnTB_SSE[EMIT_OP_STORL2F] = EMIT_CBENTRY(STORL2F_SSE)
	_opFnTB_SSE[EMIT_OP_STORF2F] = EMIT_CBENTRY(STORF2F_SSE)

	'' binary ops
	_opFnTB_SSE[EMIT_OP_MOVF] = EMIT_CBENTRY(MOVF_SSE)
	_opFnTB_SSE[EMIT_OP_ADDF] = EMIT_CBENTRY(ADDF_SSE)
	_opFnTB_SSE[EMIT_OP_SUBF] = EMIT_CBENTRY(SUBF_SSE)
	_opFnTB_SSE[EMIT_OP_MULF] = EMIT_CBENTRY(MULF_SSE)
	_opFnTB_SSE[EMIT_OP_DIVF] = EMIT_CBENTRY(DIVF_SSE)

	_opFnTB_SSE[EMIT_OP_ATN2] = EMIT_CBENTRY(ATN2_SSE)
	_opFnTB_SSE[EMIT_OP_POW] = EMIT_CBENTRY(POW_SSE)

	'' relational
	_opFnTB_SSE[EMIT_OP_CGTF] = EMIT_CBENTRY(CGTF_SSE)
	_opFnTB_SSE[EMIT_OP_CLTF] = EMIT_CBENTRY(CLTF_SSE)
	_opFnTB_SSE[EMIT_OP_CEQF] = EMIT_CBENTRY(CEQF_SSE)
	_opFnTB_SSE[EMIT_OP_CNEF] = EMIT_CBENTRY(CNEF_SSE)
	_opFnTB_SSE[EMIT_OP_CGEF] = EMIT_CBENTRY(CGEF_SSE)
	_opFnTB_SSE[EMIT_OP_CLEF] = EMIT_CBENTRY(CLEF_SSE)

	'' unary ops
	_opFnTB_SSE[EMIT_OP_NEGF] = EMIT_CBENTRY(NEGF_SSE)
	_opFnTB_SSE[EMIT_OP_HADDF] = EMIT_CBENTRY(HADDF_SSE)
	_opFnTB_SSE[EMIT_OP_ABSF] = EMIT_CBENTRY(ABSF_SSE)
	_opFnTB_SSE[EMIT_OP_SGNF] = EMIT_CBENTRY(SGNF_SSE)

	_opFnTB_SSE[EMIT_OP_FIX] = EMIT_CBENTRY(FIX_SSE)
	_opFnTB_SSE[EMIT_OP_FRAC] = EMIT_CBENTRY(FRAC_SSE)

	_opFnTB_SSE[EMIT_OP_SIN] = EMIT_CBENTRY(SIN_SSE)
	_opFnTB_SSE[EMIT_OP_ASIN] = EMIT_CBENTRY(ASIN_SSE)
	_opFnTB_SSE[EMIT_OP_COS] = EMIT_CBENTRY(COS_SSE)
	_opFnTB_SSE[EMIT_OP_ACOS] = EMIT_CBENTRY(ACOS_SSE)
	_opFnTB_SSE[EMIT_OP_TAN] = EMIT_CBENTRY(TAN_SSE)
	_opFnTB_SSE[EMIT_OP_ATAN] = EMIT_CBENTRY(ATAN_SSE)

	_opFnTB_SSE[EMIT_OP_SQRT] = EMIT_CBENTRY(SQRT_SSE)
	_opFnTB_SSE[EMIT_OP_RSQRT] = EMIT_CBENTRY(RSQRT_SSE)
	_opFnTB_SSE[EMIT_OP_RCP] = EMIT_CBENTRY(RCP_SSE)

	_opFnTB_SSE[EMIT_OP_LOG] = EMIT_CBENTRY(LOG_SSE)
	_opFnTB_SSE[EMIT_OP_EXP] = EMIT_CBENTRY(EXP_SSE)

	_opFnTB_SSE[EMIT_OP_FLOOR] = EMIT_CBENTRY(FLOOR_SSE)
	_opFnTB_SSE[EMIT_OP_SWZREP] = EMIT_CBENTRY(SWZREPF_SSE)

	_opFnTB_SSE[EMIT_OP_PUSHF] = EMIT_CBENTRY(PUSHF_SSE)
	_opFnTB_SSE[EMIT_OP_POPF] = EMIT_CBENTRY(POPF_SSE)

	function = TRUE
end function


