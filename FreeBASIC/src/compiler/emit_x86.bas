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


'' code generation for x86, GNU assembler (GAS/Intel arch)
''
'' chng: sep/2004 written [v1ctor]
''  	 mar/2005 longint support added [v1ctor]

defint a-z
option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\reg.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"
#include once "inc\hash.bi"
#include once "inc\symb.bi"


type EMITDATATYPE
	class			as integer
	size			as integer
	rnametb			as integer
	mname			as zstring * 11+1
end type

''
const QUOTE   = "\""
const COMMA   = ", "


const EMIT_MAXRNAMES  = REG_MAXREGS
const EMIT_MAXRTABLES = 4				'' 8-bit, 16-bit, 32-bit, fpoint


''
declare sub 		outp				( byval s as string )

declare sub 		hSaveAsmHeader		( )

declare function 	hGetTypeString		( byval typ as integer ) as string


''
''globals

	'' same order as EMITREG_ENUM
	dim shared rnameTB(0 to EMIT_MAXRTABLES-1, 0 to EMIT_MAXRNAMES-1) as zstring * 7+1 => _
	{ _
		{    "dl",   "di",   "si",   "cl",   "bl",   "al",   "bp",   "sp" }, _
		{    "dx",   "di",   "si",   "cx",   "bx",   "ax",   "bp",   "sp" }, _
		{   "edx",  "edi",  "esi",  "ecx",  "ebx",  "eax",  "ebp",  "esp" }, _
		{ "st(0)","st(1)","st(2)","st(3)","st(4)","st(5)","st(6)","st(7)" } _
	}

	'' same order as IRDATATYPE_ENUM
	dim shared dtypeTB(0 to IR_MAXDATATYPES-1) as EMITDATATYPE => _
	{ _
		( IR_DATACLASS_INTEGER, 0 			    , 0, "void ptr"  ), _
		( IR_DATACLASS_INTEGER, 1			    , 0, "byte ptr"  ), _
		( IR_DATACLASS_INTEGER, 1			    , 0, "byte ptr"  ), _
		( IR_DATACLASS_INTEGER, 1               , 0, "byte ptr"  ), _
		( IR_DATACLASS_INTEGER, 2               , 1, "word ptr"  ), _
		( IR_DATACLASS_INTEGER, 2               , 1, "word ptr"  ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE*2, 2, "qword ptr" ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE*2, 2, "qword ptr" ), _
		( IR_DATACLASS_FPOINT , 4			    , 3, "dword ptr" ), _
		( IR_DATACLASS_FPOINT , 8			    , 3, "qword ptr" ), _
		( IR_DATACLASS_STRING , 8               , 0, ""          ), _
		( IR_DATACLASS_STRING , 1               , 0, "byte ptr"  ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ), _
		( IR_DATACLASS_INTEGER, 1			    , 0, "byte ptr"  ), _
		( IR_DATACLASS_INTEGER, FB_INTEGERSIZE  , 2, "dword ptr" ) _
	}

const EMIT_MAXKEYWORDS = 600

	dim shared keywordTb(0 to EMIT_MAXKEYWORDS-1) as zstring * 15+1 => _
	{ _
		"st", "cs", "ds", "es", "fs", "gs", "ss", _
		"mm0", "mm1", "mm2", "mm3", "mm4", "mm5", "mm6", "mm7", _
		"xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7", _
		"byte", "word", "dword", "qword", _
		"ptr", "offset", _
		"aaa", "aad", "aam", "aas", "adc", "add", "addpd", "addps", "addsd", "addss", "and", "andpd", "andps", _
		"andnpd", "andnps", "arpl", "bound", "bsf", "bsr", "bswap", "bt", "btc", "btr", "bts", "call", "cbw", _
		"cwde", "cdq", "clc", "cld", "clflush", "cli", "clts", "cmc", "cmova", "cmovae", "cmovb", "cmovbe", _
		"cmovc", "cmove", "cmovg", "cmovge", "cmovl", "cmovle", "cmovna", "cmovnae", "cmovnb", "cmovnbe", _
		"cmovnc", "cmovne", "cmovng", "cmovnge", "cmovnl", "cmovnle", "cmovno", "cmovnp", "cmovns", "cmovnz", _
		"cmovo", "cmovp", "cmovpe", "cmovpe", "cmovpo", "cmovs", "cmovz", "cmp", "cmppd", "cmpps", "cmps", _
		"cmpsb", "cmpsw", "cmpsd", "cmpss", "cmpxchg", "cmpxchg8b", "comisd", "comiss", "cpuid", "cvtdq2pd", _
		"cvtdq2ps", "cvtpd2dq", "cvtpd2pi", "cvtpd2ps", "cvtpi2pd", "cvtpi2ps", "cvtps2dq", "cvtps2pd", _
		"cvtps2pi", "cvtsd2si", "cvtsd2ss", "cvtsi2sd", "cvtsi2ss", "cvtss2sd", "cvtss2si", "cvttpd2pi", _
		"cvttpd2dq", "cvttps2dq", "cvttps2pi", "cvttsd2si", "cvttss2si", "cwd", "daa", "das", "dec", "div", _
		"divpd", "divps", "divss", "emms", "enter", "f2xm1", "fabs", "fadd", "faddp", "fiadd", "fbld", _
		"fbstp", "fchs", "fclex", "fnclex", "fcmovb", "fcmove", "fcmovbe", "fcmovu", "fcmovnb", "fcmovne", _
		"fcmovnbe", "fcmovnu", "fcom", "fcomp", "fcompp", "fcomi", "fcomip", "fucomi", "fucomip", "fcos", _
		"fdecstp", "fdiv", "fdivp", "fidiv", "fdivr", "fdivrp", "fidivr", "ffree", "ficom", "ficomp", _
		"fild", "fincstp", "finit", "fninit", "fist", "fistp", "fld", "fld1", "fldl2t", "fldl2e", "fldpi", _
		"fldlg2", "fldln2", "fldz", "fldcw", "fldenv", "fmul", "fmulp", "fimul", "fnop", "fpatan", "fprem", _
		"fprem1", "fptan", "frndint", "frstor", "fsave", "fnsave", "fscale", "fsin", "fsincos", "fsqrt", _
		"fst", "fstp", "fstcw", "fnstcw", "fstenv", "fnstenv", "fstsw", "fnstsw", "fsub", "fsubp", "fisub", _
		"fsubr", "fsubrp", "fisubr", "ftst", "fucom", "fucomp", "fucompp", "fwait", "fxam", "fxch", "fxrstor", _
		"fxsave", "fxtract", "fyl2x", "fyl2xp1", "hlt", "idiv", "imul", "in", "inc", "ins", "insb", "insw", _
		"insd", "int", "into", "invd", "invlpg", "iret", "iretd", "ja", "jae", "jb", "jbe", "jc", "jcxz", _
		"jecxz", "je", "jg", "jge", "jl", "jle", "jna", "jnae", "jnb", "jnbe", "jnc", "jne", "jng", "jnge", _
		"jnl", "jnle", "jno", "jnp", "jns", "jnz", "jo", "jp", "jpe", "jpo", "js", "jz", "jmp", "lahf", "lar", _
		"ldmxcsr", "lds", "les", "lfs", "lgs", "lss", "lea", "leave", "lfence", "lgdt", "lidt", "lldt", "lmsw", _
		"lock", "lods", "lodsb", "lodsw", "lodsd", "loop", "loope", "loopz", "loopne", "loopnz", "lsl", "ltr", _
		"maskmovdqu", "maskmovq", "maxpd", "maxps", "maxsd", "maxss", "mfence", "minpd", "minps", "minsd", _
		"minss", "mov", "movapd", "movaps", "movd", "movdqa", "movdqu", "movdq2q", "movhlps", "movhpd", _
		"movhps", "movlhps", "movlpd", "movlps", "movmskpd", "movmskps", "movntdq", "movnti", "movntpd", _
		"movntps", "movntq", "movq", "movq2dq", "movs", "movsb", "movsw", "movsd", "movss", "movsx", "movupd", _
		"movups", "movzx", "mul", "mulpd", "mulps", "mulsd", "mulss", "neg", "nop", "not", "or", "orpd", _
		"orps", "out", "outs", "outsb", "outsw", "outsd", "packsswb", "packssdw", "packuswb", "paddb", _
		"paddw", "paddd", "paddq", "paddsb", "paddsw", "paddusb", "paddusw", "pand", "pandn", "pause", _
		"pavgb", "pavgw", "pcmpeqb", "pcmpeqw", "pcmpeqd", "pcmpgtb", "pcmpgtw", "pcmpgtd", "pextrw", _
		"pinsrw", "pmaddwd", "pmaxsw", "pmaxub", "pminsw", "pminub", "pmovmskb", "pmulhuv", "pmulhw", _
		"pmullw", "pmuludq", "pop", "popa", "popad", "popf", "popfd", "por", "prefetcht0", "prefetcht1", _
		"prefetcht2", "prefetchnta", "psadbw", "pshufd", "pshufhw", "pshuflw", "pshufw", "psllw", "pslld", _
		"psllq", "psraw", "psrad", "psrldq", "psrlw", "psrld", "psrlq", "psubb", "psubw", "psubd", "psubq", _
		"psubsb", "psubsw", "psubusb", "psubusw", "punpckhbw", "punpckhwd", "punpckhdq", "punpckhqdq", _
		"punpcklbw", "punpcklwd", "punpckldq", "punpcklqdq", "push", "pusha", "pushad", "pushf", "pushfd", _
		"pxor", "rcl", "rcr", "rol", "ror", "rcpps", "rcpss", "rdmsr", "rdpmc", "rdtsc", "rep", "repe", _
		"repz", "repne", "repnz", "ret", "rsm", "rsqrtps", "rsqrtss", "sahf", "sal", "sar", "shl", "shr", _
		"sbb", "scas", "scasb", "scasw", "scasd", "seta", "setae", "setb", "setbe", "setc", "sete", "setg", _
		"setge", "setl", "setle", "setna", "setnae", "setnb", "setnbe", "setnc", "setne", "setng", "setnge", _
		"setnl", "setnle", "setno", "setnp", "setns", "setnz", "seto", "setp", "setpe", "setpo", "sets", _
		"setz", "sfence", "sgdt", "sidt", "shld", "shrd", "shufpd", "shufps", "sldt", "smsw", "sqrtpd", _
		"sqrtps", "sqrtsd", "sqrtss", "stc", "std", "sti", "stmxcsr", "stos", "stosb", "stosw", "stosd", _
		"str", "sub", "subpd", "subps", "subsd", "subss", "sysenter", "sysexit", "test", "ucomisd", _
		"ucomiss", "ud2", "unpckhpd", "unpckhps", "unpcklpd", "unpcklps", "verr", "verw", "wait", "wbinvd", _
		"wrmsr", "xadd", "xchg", "xlat", "xlatb", "xor", "xorpd", "xorps", _
		"pavgusb", "pfadd", "pfsub", "pfsubr", "pfacc", "pfcmpge", "pfcmpgt", "pfcmpeq", "pfmin", "pfmax", _
		"pi2fw", "pi2fd", "pf2iw", "pf2id", "pfrcp", "pfrsqrt", "pfmul", "pfrcpit1", "pfrsqit1", "pfrcpit2", _
		"pmulhrw", "pswapw", "femms", "prefetch", "prefetchw", "pfnacc", "pfpnacc", "pswapd", "pmulhuw", _
		"" _
	}


'':::::
private sub hInitKeywordsTB
    dim t as integer, i as integer, idx as uinteger
    dim keyword as string

	hashNew( @emit.keyhash, EMIT_MAXKEYWORDS )

	'' add reg names
	for t = 0 to EMIT_MAXRTABLES-1
		for i = 0 to EMIT_MAXRNAMES-1
			if( len( rnameTB(t,i) ) > 0 ) then
				hashAdd( @emit.keyhash, @rnameTB(t,i), @idx, idx )
			end if
		next i
	next t

	'' add asm keywords
	for i = 0 to EMIT_MAXKEYWORDS-1
		if( len( keywordTb(i) ) = 0 ) then
			exit for
		end if

		hashAdd( @emit.keyhash, @keywordTb(i), @idx, idx )
	next

	emit.keyinited = TRUE

end sub

'':::::
private sub hEndKeywordsTB

	if( emit.keyinited ) then
		hashFree( @emit.keyhash )
	end if

	emit.keyinited = FALSE

end sub

'':::::
private sub hInitRegTB
	dim as integer lastclass, regs, i

	static as integer regclass( 0 to (EMIT_REGCLASSES*EMIT_MAXRNAMES)-1 ) = _
	{ _
		IR_DATACLASS_INTEGER, _ '' edx
		IR_DATACLASS_INTEGER, _ '' edi
		IR_DATACLASS_INTEGER, _ '' esi
		IR_DATACLASS_INTEGER, _ '' ecx
		IR_DATACLASS_INTEGER, _ '' ebx
		IR_DATACLASS_INTEGER, _ '' eax
							  _ '' ebp and esp are reserved
		IR_DATACLASS_FPOINT , _ '' st(0)
		IR_DATACLASS_FPOINT , _ '' st(1)
		IR_DATACLASS_FPOINT , _ '' st(2)
		IR_DATACLASS_FPOINT , _ '' st(3)
		IR_DATACLASS_FPOINT , _ '' st(4)
		IR_DATACLASS_FPOINT , _ '' st(5)
		IR_DATACLASS_FPOINT , _ '' st(6)
		INVALID 			  _ '' no st(7) as STORE/LOAD/POW/.. need a free reg to work
	}

	''
	lastclass = INVALID
	regs = 0
	i = 0
	do
		if( lastclass <> regclass(i) ) then
			if( lastclass <> INVALID ) then
				emit.regTB(lastclass) = regNewClass( lastclass, regs, lastclass = IR_DATACLASS_FPOINT )
			end if
			regs = 0
			lastclass = regclass(i)
		end if

		if( regclass(i) = INVALID ) then
			exit do
		end if

		regs += 1
		i += 1
	loop

end sub

'':::::
private sub hEndRegTB
    dim i as integer

	for i = 0 to EMIT_REGCLASSES-1
		regDelClass( emit.regTB(i) )
	next i

end sub

'':::::
sub emitSubInit

	''
	hInitRegTB( )

	''
	emit.keyinited 	= FALSE

	''
	emit.dataend 	= 0
	emit.lastsection = INVALID

	emit.bssheader	= FALSE
	emit.conheader	= FALSE
	emit.datheader	= FALSE
	emit.expheader	= FALSE

end sub

'':::::
sub emitSubEnd

	''
	hEndRegTB( )

    hEndKeywordsTB( )

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitGetVarName( byval s as FBSYMBOL ptr ) as string static
	dim sname as string

	if( s <> NULL ) then
		sname = symbGetName( s )

		if( s->ofs > 0 ) then
			sname += "+" + str( s->ofs )
		elseif( s->ofs < 0 ) then
			sname += str( s->ofs )
		end if

		function = sname

	else
		function = ""
	end if

end function

'':::::
function emitIsRegPreserved ( byval dtype as integer, _
							  byval dclass as integer, _
							  byval reg as integer ) as integer static

    if( dtype >= IR_DATATYPE_POINTER ) then
    	dtype = IR_DATATYPE_UINT
    end if

    '' fp? fpu stack *must* be cleared before calling any function
    if( dclass = IR_DATACLASS_FPOINT ) then
    	return FALSE
    end if

    select case as const reg
    case EMIT_REG_EAX, EMIT_REG_ECX, EMIT_REG_EDX
    	return FALSE
    case else
    	return TRUE
	end select

end function

'':::::
sub emitGetResultReg( byval dtype as integer, _
					  byval dclass as integer, _
					  r1 as integer, _
					  r2 as integer ) static

	if( dtype >= IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_UINT
	end if

	if( dclass = IR_DATACLASS_INTEGER ) then
		r1 = EMIT_REG_EAX
		if( ISLONGINT( dtype ) ) then
			r2 = EMIT_REG_EDX
		else
			r2 = INVALID
		end if
	else
		r1 = 0							'' st(0)
		r2 = INVALID
	end if

end sub

'':::::
function emitGetFreePreservedReg( byval dtype as integer, _
								  byval dclass as integer ) as integer static

	if( dtype >= IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_UINT
	end if

	function = INVALID

	'' fp? no other regs can be used
	if( dclass = IR_DATACLASS_FPOINT ) then
		exit function
	end if

	'' try to reuse regs that are preserved between calls
	if( emit.regTB(dclass)->isFree( emit.regTB(dclass), EMIT_REG_EBX ) ) then
		function = EMIT_REG_EBX

	elseif( emit.regTB(dclass)->isFree( emit.regTB(dclass), EMIT_REG_ESI ) ) then
		function = EMIT_REG_ESI

	elseif( emit.regTB(dclass)->isFree( emit.regTB(dclass), EMIT_REG_EDI ) ) then
		function = EMIT_REG_EDI
	end if

end function

'':::::
function emitIsKeyword( byval text as string ) as integer static

	if( not emit.keyinited ) then
		hInitKeywordsTB( )
	end if

	if( hashLookup( @emit.keyhash, strptr( text ) ) <> NULL ) then
		function = TRUE
	else
		function = FALSE
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hIsRegFree( byval dclass as integer, _
							 byval reg as integer ) as integer static

	'' if EBX, EDI or ESI and if they weren't ever used, return false,
	'' because hCreateFrame didn't preserve them
	if( dclass = IR_DATACLASS_INTEGER ) then
		select case reg
		case EMIT_REG_EBX, EMIT_REG_ESI, EMIT_REG_EDI
			if( not EMIT_REGISUSED( IR_DATACLASS_INTEGER, reg ) ) then
				return FALSE
			end if
		end select
	end if

	'' assume it will be trashed
	EMIT_REGSETUSED( dclass, reg )

	function = REG_ISFREE( emit.curnode->regFreeTB(dclass), reg )

end function

'':::::
private function hFindRegNotInVreg( byval vreg as IRVREG ptr, _
							   		byval noSIDI as integer = FALSE ) as integer static

    dim as integer r, reg, reg2, regs

	function = INVALID

	reg = INVALID

	select case vreg->typ
	case IR_VREGTYPE_REG
		reg = vreg->reg

	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		if( vreg->vidx <> NULL ) then
			if( vreg->vidx->typ = IR_VREGTYPE_REG ) then
				reg = vreg->vidx->reg
			end if
		end if
	end select

	'' longint..
	reg2 = INVALID
	if( vreg->vaux <> NULL ) then
		if( vreg->vaux->typ = IR_VREGTYPE_REG ) then
			reg2 = vreg->vaux->reg
		end if
	end if

	regs = emit.regTB(IR_DATACLASS_INTEGER)->getMaxRegs( emit.regTB(IR_DATACLASS_INTEGER) )

	''
	if( reg2 = INVALID ) then

		if( not noSIDI ) then

			for r = regs-1 to 0 step -1
				if( r <> reg ) then
					function = r
					if( hIsRegFree( IR_DATACLASS_INTEGER, r ) ) then
						exit function
					end if
				end if
			next

		'' SI/DI as byte..
		else

			for r = regs-1 to 0 step -1
				if( r <> reg ) then
					if( r <> EMIT_REG_ESI ) then
						if( r <> EMIT_REG_EDI ) then
							function = r
							if( hIsRegFree( IR_DATACLASS_INTEGER, r ) ) then
								exit function
							end if
						end if
					end if
				end if
			next

		end if

	'' longints..
	else

		if( not noSIDI ) then

			for r = regs-1 to 0 step -1
				if( (r <> reg) and (r <> reg2) ) then
					function = r
					if( hIsRegFree( IR_DATACLASS_INTEGER, r ) ) then
						exit function
					end if
				end if
			next

		'' SI/DI as byte..
		else

			for r = regs-1 to 0 step -1
				if( (r <> reg) and (r <> reg2) ) then
					if( r <> EMIT_REG_ESI ) then
						if( r <> EMIT_REG_EDI ) then
							function = r
							if( hIsRegFree( IR_DATACLASS_INTEGER, r ) ) then
								exit function
							end if
						end if
					end if
				end if
			next

		end if

	end if

end function

'':::::
private function hFindFreeReg( byval dclass as integer ) as integer static
    dim as integer r

	function = INVALID

	for r = emit.regTB(dclass)->getMaxRegs( emit.regTB(dclass) )-1 to 0 step -1
		function = r
		if( hIsRegFree( dclass, r ) ) then
			exit function
		end if
	next

end function

'':::::
private function hIsRegInVreg( byval vreg as IRVREG ptr, _
						  	   byval reg as integer ) as integer static

	function = FALSE

	select case vreg->typ
	case IR_VREGTYPE_REG
		if( vreg->reg = reg ) then
			return TRUE
		end if

	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		if( vreg->vidx <> NULL ) then
			if( vreg->vidx->typ = IR_VREGTYPE_REG ) then
				if( vreg->vidx->reg = reg ) then
					return TRUE
				end if
			end if
		end if
	end select

	'' longints..
	if( vreg->vaux <> NULL ) then
		if( vreg->vaux->typ = IR_VREGTYPE_REG ) then
			if( vreg->vaux->reg = reg ) then
				return TRUE
			end if
		end if
	end if

end function

'':::::
private function hGetRegName( byval dtype as integer, _
						 	  byval reg as integer ) as zstring ptr static

    dim as integer tb

	if( dtype >= IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_UINT
	end if

	if( reg = INVALID ) then
		function = NULL
	else
		tb = dtypeTB(dtype).rnametb

		function = @rnameTB(tb, reg)
	end if

end function

'':::::
private function hGetIdxName( byval vreg as IRVREG ptr ) as zstring ptr static
    static as zstring * FB_MAXINTNAMELEN+1+8+1+1+1+8+1 iname
    dim as FBSYMBOL ptr sym
    dim as IRVREG ptr vi
    dim as integer addone, mult
    dim as zstring ptr rname

	sym = vreg->sym
	vi  = vreg->vidx

	if( sym <> NULL ) then
		iname = symbGetName( sym )
		if( vi <> NULL ) then
			iname += "+"
		end if
	else
		iname = ""
	end if

	if( vi <> NULL ) then
		rname = hGetRegName( vi->dtype, vi->reg )

		iname += *rname

    	mult = vreg->mult
		if( mult > 1 ) then
			addone = FALSE
			select case mult
			case 3, 5, 9
				mult -= 1
				addone = TRUE
			end select

			iname += "*"
			iname += str( mult )

			if( addone ) then
				iname += "+"
				iname += *rname
			end if
		end if

	end if

	function = @iname

end function

'':::::
private sub hPrepOperand( byval vreg as IRVREG ptr, _
						  operand as string, _
						  byval dtype as IRDATATYPE_ENUM = INVALID, _
						  byval ofs as integer = 0, _
						  byval isaux as integer = FALSE, _
						  byval addprefix as integer = TRUE ) static

    if( vreg = NULL ) then
    	operand = ""
    	exit sub
    end if

    if( dtype = INVALID ) then
    	dtype = vreg->dtype
    end if

	select case as const vreg->typ
	case IR_VREGTYPE_VAR, IR_VREGTYPE_IDX, IR_VREGTYPE_PTR

		if( addprefix ) then
			operand = dtypeTB(dtype).mname
			operand += " ["
		else
			operand = "["
		end if

		if( vreg->typ = IR_VREGTYPE_VAR ) then
			operand += symbGetName( vreg->sym )
		else
        	operand += *hGetIdxName( vreg )
		end if

		ofs += vreg->ofs
		if( isaux ) then
			ofs += FB_INTEGERSIZE
		end if

		if( ofs > 0 ) then
			operand += "+"
			operand += str( ofs )
		elseif( ofs < 0 ) then
			operand += str( ofs )
		end if

		operand += "]"

	case IR_VREGTYPE_OFS
		operand = "offset "
		operand += symbGetName( vreg->sym )

	case IR_VREGTYPE_REG
		if( not isaux ) then
			operand = *hGetRegName( dtype, vreg->reg )
		else
			operand = *hGetRegName( dtype, vreg->vaux->reg )
		end if

	case IR_VREGTYPE_IMM
		if( not isaux ) then
			operand = str( vreg->value )
		else
			operand = str( vreg->vaux->value )
		end if

	case else
    	operand = ""
	end select

end sub

'':::::
private sub hPrepOperand64( byval vreg as IRVREG ptr, _
							operand1 as string, _
							operand2 as string ) static

	hPrepOperand( vreg, operand1, IR_DATATYPE_UINT   , 0, FALSE )
	hPrepOperand( vreg, operand2, IR_DATATYPE_INTEGER, 0, TRUE )

end sub

'':::::
private sub outEx( byval s as string, _
				   byval updpos as integer ) static

	if( put( #env.outf.num, , s ) = 0 ) then
	end if

end sub

'':::::
private sub outp( byval s as string ) static
    dim as integer p, char
    dim as string ostr

	if( env.clopt.debug ) then
		p = instr( s, " " )
		if( p > 0 ) then
			char = s[p-1]
			s[p-1] = CHAR_TAB			'' unsafe with constants..
		end if

		ostr = "\t" + s + NEWLINE
		outEX( ostr, TRUE )

		if( p > 0 ) then
			s[p-1] = char
		end if

	else

		ostr = s + NEWLINE
		outEX( ostr, TRUE )

	end if

end sub

'':::::
private sub hBRANCH( byval mnemonic as string, _
			 		 byval label as string ) static
    dim ostr as string

	ostr = mnemonic + " " + label
	outp( ostr )

end sub

'':::::
private sub hPUSH( byval rname as string ) static
    dim ostr as string

	ostr = "push " + rname
	outp( ostr )

end sub

'':::::
private sub hPOP( byval rname as string ) static
    dim ostr as string

    ostr = "pop " + rname
	outp( ostr )

end sub

'':::::
private sub hMOV( byval dname as string, _
		  		  byval sname as string ) static
    dim ostr as string

	ostr = "mov " + dname + ", " + sname
	outp( ostr )

end sub

'':::::
private sub hXCHG( byval dname as string, _
		   		   byval sname as string ) static
    dim ostr as string

	ostr = "xchg " + dname + ", " + sname
	outp( ostr )

end sub

'':::::
private sub hCOMMENT( byval s as string ) static
    dim ostr as string

    ostr = "\t\35" + s + NEWLINE
	outEX( ostr, FALSE )

end sub

'':::::
private sub hPUBLIC( byval label as string ) static
    dim ostr as string

	ostr = "\r\n.globl " + label + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
private sub hLABEL( byval label as string ) static
    dim ostr as string

	ostr = label + ":\r\n"
	outEx( ostr, FALSE )

end sub

'':::::
private sub hALIGN( byval bytes as integer ) static
    dim ostr as string

    ostr = ".balign " + str( bytes ) +  "\r\n"
	outEx( ostr, FALSE )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' implementation
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitLIT( byval s as string )
    dim ostr as string

    ostr = s + NEWLINE
	outEX( ostr, FALSE )

end sub

'':::::
private sub _emitALIGN( byval vreg as IRVREG ptr ) static
    dim ostr as string

    ostr = ".balign " + str( vreg->value )
	outp( ostr )

end sub

'':::::
private sub _emitSTKALIGN( byval vreg as IRVREG ptr ) static
    dim ostr as string

    if( vreg->value > 0 ) then
    	ostr = "sub esp, " + str( vreg->value )
    else
    	ostr = "add esp, " + str( -vreg->value )
    end if

	outp( ostr )

end sub

'':::::
private sub _emitJMPTB( byval dtype as integer, _
			  		    byval text as string ) static
    dim ostr as string

	ostr = hGetTypeString( dtype ) + " " + text
	outp( ostr )

end sub

'':::::
private sub _emitCALL( byval unused as IRVREG ptr, _
			  		   byval label as FBSYMBOL ptr, _
			  		   byval bytestopop as integer ) static
    dim ostr as string

	ostr = "call " + symbGetName( label )
	outp( ostr )

    if( bytestopop <> 0 ) then
    	ostr = "add esp, " + str( bytestopop )
    	outp( ostr )
    end if

end sub

'':::::
private sub _emitCALLPTR( byval svreg as IRVREG ptr, _
				 		  byval unused as FBSYMBOL ptr, _
				 		  byval bytestopop as integer ) static
    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	ostr = "call " + src
	outp( ostr )

    if( bytestopop <> 0 ) then
    	ostr = "add esp, " + str( bytestopop )
    	outp( ostr )
    end if

end sub

'':::::
private sub _emitBRANCH( byval unused as IRVREG ptr, _
						 byval label as FBSYMBOL ptr, _
						 byval op as integer ) static
    dim ostr as string

	select case as const op
	case IR_OP_JLE
		ostr = "jle "
	case IR_OP_JGE
		ostr = "jge "
	case IR_OP_JLT
		ostr = "jl "
	case IR_OP_JGT
		ostr = "jg "
	case IR_OP_JEQ
		ostr = "je "
	case IR_OP_JNE
		ostr = "jne "
	end select

	ostr += symbGetName( label )
	outp( ostr )

end sub

'':::::
private sub _emitJUMP( byval unused1 as IRVREG ptr, _
				 	   byval label as FBSYMBOL ptr, _
				 	   byval unused2 as integer ) static
    dim ostr as string

	ostr = "jmp " + symbGetName( label )
	outp( ostr )

end sub

'':::::
private sub _emitJUMPPTR( byval svreg as IRVREG ptr, _
				 		  byval unused1 as FBSYMBOL ptr, _
				 		  byval unused2 as integer ) static
    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	ostr = "jmp " + src
	outp( ostr )

end sub

'':::::
private sub _emitRET( byval vreg as IRVREG ptr ) static
    dim ostr as string

    ostr = "ret " + str( vreg->value )
    outp( ostr )

end sub

'':::::
private sub _emitPUBLIC( byval label as FBSYMBOL ptr ) static
    dim ostr as string

	ostr = "\r\n.globl " + symbGetName( label ) + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
private sub _emitLABEL( byval label as FBSYMBOL ptr ) static
    dim ostr as string

	ostr = symbGetName( label ) + ":\r\n"
	outEx( ostr, FALSE )

end sub

'':::::
sub emitSECTION( byval section as integer ) static
    dim as string ostr

    if( section = emit.lastsection ) then
    	exit sub
    end if

	ostr = NEWLINE + ".section ."

	select case as const section
	case EMIT_SECTYPE_CONST
		ostr += "rodata" + NEWLINE
	case EMIT_SECTYPE_DATA
		ostr += "data" + NEWLINE
	case EMIT_SECTYPE_BSS
		ostr += "bss" + NEWLINE
	case EMIT_SECTYPE_CODE
		ostr += "text" + NEWLINE
	case EMIT_SECTYPE_DIRECTIVE
		ostr += "drectve" + NEWLINE
	end select

	outEx( ostr, FALSE )

	emit.lastsection = section

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' store
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hULONG2DBL( byval svreg as IRVREG ptr ) static
	dim as string label, src, ostr

	label = *hMakeTmpStr( )

	hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, 4 )
	ostr = "cmp " +  src + ", 0"

	outp ostr
	ostr = "jns " + label
	outp ostr
	hPUSH( "16447" )
	hPUSH( "-2147483648" )
	hPUSH( "0" )
	outp "fldt [esp]"
	outp "add esp, 12"
	outp "faddp"
	hLABEL( label )

end sub

'':::::
private sub _emitSTORL2L( byval dvreg as IRVREG ptr, _
			           	  byval svreg as IRVREG ptr ) static
    dim as string dst1, dst2, src1, src2, ostr

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "mov " + dst1 + COMMA + src1
	outp ostr

	ostr = "mov " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitSTORI2L( byval dvreg as IRVREG ptr, _
			           	  byval svreg as IRVREG ptr ) static
    dim as string dst1, dst2, src1, ext, ostr
    dim sdsize as integer

	sdsize = irGetDataSize( svreg->dtype )

	hPrepOperand64( dvreg, dst1, dst2 )

	hPrepOperand( svreg, src1 )

	'' immediate?
	if( svreg->typ = IR_VREGTYPE_IMM ) then
		hMOV dst1, src1

		if( svreg->value < -1 ) then
			hMOV dst2, "-1"
		else
			hMOV dst2, "0"
		end if

		exit sub
	end if

	''
	if( sdsize < FB_INTEGERSIZE ) then
		ext = *hGetRegName( IR_DATATYPE_INTEGER, svreg->reg )

		if( irIsSigned( svreg->dtype ) ) then
			ostr = "movsx "
		else
			ostr = "movzx "
		end if
		ostr += ext + COMMA + src1
		outp ostr

	else
		ext = src1
	end if

	ostr = "mov " + dst1 + COMMA + ext
	outp ostr

	if( irIsSigned( svreg->dtype ) ) then

		hPUSH ext

		ostr = "sar " + ext + ", 31"
		outp ostr

		ostr = "mov " + dst2 + COMMA + ext
		outp ostr

		hPOP ext

	else
		ostr = "mov " + dst2 + ", 0"
		outp ostr
	end if

end sub

'':::::
private sub _emitSTORF2L( byval dvreg as IRVREG ptr, _
						  byval svreg as IRVREG ptr ) static
    dim as string dst
    dim as string ostr

	hPrepOperand( dvreg, dst )

	'' signed?
	if( irIsSigned( dvreg->dtype ) ) then
		ostr = "fistp " + dst
		outp ostr

	'' unsigned.. try a bigger type
	else

		'' handled by AST already

	end if

end sub

'':::::
private sub _emitSTORI2I( byval dvreg as IRVREG ptr, _
						  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux, aux8, aux16
    dim as integer ddsize, reg, isfree
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )

	if( ddsize = 1 ) then
		if( svreg->typ = IR_VREGTYPE_IMM ) then
			ddsize = 4
		end if
	end if

	'' dst size = src size
	if( (svreg->typ = IR_VREGTYPE_IMM) or _
		(dvreg->dtype = svreg->dtype) or _
		(irMaxDataType( dvreg->dtype, svreg->dtype ) = INVALID) ) then

		'' handle SI/DI as byte
		if( ddsize = 1 ) then
			if( svreg->typ = IR_VREGTYPE_REG ) then
				if( (svreg->reg = EMIT_REG_ESI) or (svreg->reg = EMIT_REG_EDI) ) then
					aux = *hGetRegName( dvreg->dtype, svreg->reg )
					goto storeSIDI
				end if
			end if
		end if

		ostr = "mov " + dst + COMMA + src
		outp ostr

	'' sizes are different..
	else

		aux = *hGetRegName( dvreg->dtype, svreg->reg )

		'' dst size > src size
		if( dvreg->dtype > svreg->dtype ) then
			if( irIsSigned( svreg->dtype ) ) then
				ostr = "movsx "
			else
				ostr = "movzx "
			end if
			ostr += aux + COMMA + src
			outp ostr

			ostr = "mov " + dst + COMMA + aux
			outp ostr

		'' dst size < src size
		else
			'' handle DI/SI as byte
			if( (ddsize = 1) and _
				((svreg->reg = EMIT_REG_ESI) or (svreg->reg = EMIT_REG_EDI)) ) then

storeSIDI:		reg = hFindRegNotInVreg( dvreg, TRUE )

				aux8  = *hGetRegName( IR_DATATYPE_BYTE, reg )
				aux16 = *hGetRegName( IR_DATATYPE_SHORT, reg )

				isfree = hIsRegFree(IR_DATACLASS_INTEGER, reg )

				if( not isfree ) then
					hPUSH aux16
				end if

				hMOV aux16, aux

            	'' handle DI/SI as destine
            	if( (dvreg->typ = IR_VREGTYPE_REG) and _
            		((dvreg->reg = EMIT_REG_ESI) or (dvreg->reg = EMIT_REG_EDI)) ) then
					if( irIsSigned( dvreg->dtype ) ) then
						ostr = "movsx "
					else
						ostr = "movzx "
					end if
					ostr += dst + COMMA + aux8
					outp ostr
				else
					hMOV dst, aux8
				end if

				if( not isfree ) then
					hPOP aux16
				end if

			else
				ostr = "mov " + dst + COMMA + aux
				outp ostr
			end if
		end if
	end if

end sub

'':::::
private sub _emitSTORL2I( byval dvreg as IRVREG ptr, _
						  byval svreg as IRVREG ptr ) static

	'' been too complex due the SI/DI crap, leave it to I2I
	_emitSTORL2I( dvreg, svreg )

end sub

'':::::
private sub _emitSTORF2I( byval dvreg as IRVREG ptr, _
						  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux, aux8, aux16
    dim as integer ddsize, reg, isfree
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )

	'' byte destine? damn..
	if( ddsize = 1 ) then

		outp "sub esp, 4"
		outp "fistp dword ptr [esp]"

        '' destine is a reg?
        if( dvreg->typ = IR_VREGTYPE_REG ) then

           	'' handle DI/SI as destine
           	if( (dvreg->reg = EMIT_REG_ESI) or (dvreg->reg = EMIT_REG_EDI) ) then

           		if( irIsSigned( dvreg->dtype ) ) then
	           		ostr = "movsx "
           		else
           			ostr = "movzx "
           		end if
           		ostr += dst + ", byte ptr [esp]"
           		outp ostr

           	else
           		hMOV dst, "byte ptr [esp]"
           	end if

           	outp "add esp, 4"

		'' destine is a var/idx/ptr
		else

			reg = hFindRegNotInVreg( dvreg, TRUE )

			aux8 = *hGetRegName( IR_DATATYPE_BYTE, reg )
			aux  = *hGetRegName( IR_DATATYPE_INTEGER, reg )

			isfree = hIsRegFree( IR_DATATYPE_INTEGER, reg )

			if( not isfree ) then
				hXCHG aux, "dword ptr [esp]"
			else
				hMOV aux8, "byte ptr [esp]"
			end if

			hMOV dst, aux8

			if( not isfree ) then
				hPOP aux
			else
				outp "add esp, 4"
			end if

		end if

	else
		'' signed?
		if( irIsSigned( dvreg->dtype ) ) then
			ostr = "fistp " + dst
			outp ostr

		'' unsigned.. try a bigger type
		else
			'' uint?
			if( ddsize = FB_INTEGERSIZE ) then
				outp "sub esp, 8"
				outp "fistp qword ptr [esp]"
				hPOP dst
				outp  "add esp, 4"

			'' ushort..
			else
				outp "sub esp, 4"
				outp "fistp dword ptr [esp]"
				hPOP dst
				outp  "add esp, 2"
			end if
		end if

	end if

end sub

'':::::
private sub _emitSTORL2F( byval dvreg as IRVREG ptr, _
			        	  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then

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
		if( irIsSigned( svreg->dtype ) ) then
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
private sub _emitSTORI2F( byval dvreg as IRVREG ptr, _
			        	  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux
    dim as integer ddsize, sdsize, reg, isfree
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )
	sdsize = irGetDataSize( svreg->dtype )

	'' byte source? damn..
	if( sdsize = 1 ) then

		reg = hFindRegNotInVreg( svreg )

		aux = *hGetRegName( IR_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

		if( not isfree ) then
			hPUSH aux
		end if

		if( irIsSigned( svreg->dtype ) ) then
			ostr = "movsx "
		else
			ostr = "movzx "
		end if
		ostr += aux + COMMA + src
		outp ostr

		hPUSH aux
		outp "fild dword ptr [esp]"
		outp "add esp, 4"

		if( not isfree ) then
			hPOP aux
		end if

		ostr = "fstp " + dst
		outp ostr

		exit sub
	end if

	''
	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then

			'' not an integer? make it
			if( (svreg->typ = IR_VREGTYPE_REG) and (sdsize < FB_INTEGERSIZE) ) then
				src = *hGetRegName( IR_DATATYPE_INTEGER, svreg->reg )
			end if

			hPUSH src

			ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr

			outp "add esp, 4"

		'' unsigned..
		else

			'' uint..
			if( sdsize = FB_INTEGERSIZE ) then
				hPUSH "0"
				hPUSH src
				outp "fild qword ptr [esp]"
				outp "add esp, 8"

			'' ushort..
			else
				if( svreg->typ <> IR_VREGTYPE_IMM ) then
					hPUSH "0"
				end if

				hPUSH src
				outp "fild dword ptr [esp]"

				if( svreg->typ <> IR_VREGTYPE_IMM ) then
					outp "add esp, 6"
				else
					outp "add esp, 4"
				end if
			end if

		end if

	'' not a reg or imm
	else

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then
			ostr = "fild " + src
			outp ostr

		'' unsigned, try a bigger type..
		else
			'' uint..
			if( sdsize = FB_INTEGERSIZE ) then
				hPUSH "0"
				hPUSH src
				outp "fild qword ptr [esp]"
				outp "add esp, 8"

			'' ushort..
			else
				hPUSH "0"
				hPUSH src
				outp "fild dword ptr [esp]"
				outp "add esp, 6"
			end if

		end if
	end if

	ostr = "fstp " + dst
	outp ostr

end sub

'':::::
private sub _emitSTORF2F( byval dvreg as IRVREG ptr, _
			        	  byval svreg as IRVREG ptr ) static
    dim as string dst, src
    dim as integer ddsize, sdsize
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )
	sdsize = irGetDataSize( svreg->dtype )

	'' on fpu stack?
	if( svreg->typ = IR_VREGTYPE_REG ) then
		ostr = "fstp " + dst
		outp ostr

	else
		'' same size? just copy..
		if( sdsize = ddsize ) then

			hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, 0 )
			ostr = "push " + src
			outp ostr

			if( sdsize > 4 ) then
				hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, 4 )
				ostr = "push " + src
				outp ostr

				hPrepOperand( dvreg, dst, IR_DATATYPE_INTEGER, 4 )
				ostr = "pop " + dst
				outp ostr
			end if

			hPrepOperand( dvreg, dst, IR_DATATYPE_INTEGER, 0 )
			ostr = "pop " + dst
			outp ostr

		'' diff sizes, convert..
		else
			ostr = "fld " + src
			outp ostr

			ostr = "fstp " + dst
			outp ostr
		end if
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' load
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitLOADL2L( byval dvreg as IRVREG ptr, _
			              byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "mov " + dst1 + COMMA + src1
	outp ostr

	ostr = "mov " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitLOADI2L( byval dvreg as IRVREG ptr, _
			              byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string
    dim sdsize as integer
    dim ostr as string

	sdsize = irGetDataSize( svreg->dtype )

	hPrepOperand64( dvreg, dst1, dst2 )

	hPrepOperand( svreg, src1 )

	'' immediate?
	if( svreg->typ = IR_VREGTYPE_IMM ) then

        hMOV dst1, src1

		if( svreg->value < -1 ) then
			hMOV dst2, "-1"
		else
			hMOV dst2, "0"
		end if

		exit sub
	end if

	''
	if( irIsSigned( svreg->dtype ) ) then

		if( sdsize < FB_INTEGERSIZE ) then
			ostr = "movsx " + dst1 + COMMA + src1
			outp ostr
		else
			hMOV dst1, src1
		end if

		hMOV dst2, dst1

		ostr = "sar " + dst2 + ", 31"
		outp ostr

	else

		if( sdsize < FB_INTEGERSIZE ) then
			ostr = "movzx " + dst1 + COMMA + src1
			outp ostr
		else
			hMOV dst1, src1
		end if

		hMOV dst2, "0"

	end if

end sub

'':::::
private sub _emitLOADF2L( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static

    dim as string dst, src, aux
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		ostr = "fld " + src
		outp ostr
	end if

	'' signed?
	if( irIsSigned( dvreg->dtype ) ) then

		outp "sub esp, 8"

		ostr = "fistp " + dtypeTB(dvreg->dtype).mname + " [esp]"
		outp ostr

		hPrepOperand64( dvreg, dst, aux )

		hPOP( dst )
		hPOP( aux )


	'' unsigned.. try a bigger type
	else

		'' handled by AST already..

	end if

end sub

'':::::
private sub _emitLOADI2I( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static

    dim as string dst, src, aux, aux8, aux16
    dim as integer ddsize, reg, isfree
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )

	if( ddsize = 1 ) then
		if( svreg->typ = IR_VREGTYPE_IMM ) then
			ddsize = 4
		end if
	end if

	'' dst size = src size
	if( (dvreg->dtype = svreg->dtype) or _
		(irMaxDataType( dvreg->dtype, svreg->dtype ) = INVALID) ) then

		'' handle SI/DI as byte destine and source
		if( ddsize = 1 ) then
			if( (dvreg->reg = EMIT_REG_ESI) or (dvreg->reg = EMIT_REG_EDI) ) then
				goto loadSIDI
			elseif( svreg->typ = IR_VREGTYPE_REG ) then
				if( (svreg->reg = EMIT_REG_ESI) or (svreg->reg = EMIT_REG_EDI) ) then
					goto loadSIDI
				end if
			end if
		end if

		ostr = "mov " + dst + COMMA + src
		outp ostr

	else
		'' dst size > src size
		if( dvreg->dtype > svreg->dtype ) then
			if( irIsSigned( svreg->dtype ) ) then
				ostr = "movsx "
			else
				ostr = "movzx "
			end if
			ostr += dst + COMMA + src
			outp ostr

		'' dst dize < src size
		else
			'' is src a reg too?
			if( svreg->typ = IR_VREGTYPE_REG ) then
				if( svreg->reg <> dvreg->reg ) then
					aux = *hGetRegName( dvreg->dtype, svreg->reg )
					ostr = "mov " + dst + COMMA + aux
					outp ostr
				end if

			'' src is not a reg
			else
				'' handle DI/SI as byte
				if( (ddsize = 1) and _
					((dvreg->reg = EMIT_REG_ESI) or (dvreg->reg = EMIT_REG_EDI)) ) then

loadSIDI:			reg = hFindRegNotInVreg( dvreg, TRUE )

					aux8  = *hGetRegName( IR_DATATYPE_BYTE, reg )
					aux16 = *hGetRegName( IR_DATATYPE_SHORT, reg )

					isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

					if( not isfree ) then
						hPUSH aux16
					end if

					hPrepOperand( svreg, src, dvreg->dtype )

					'' handle SI/DI as source
					if( (svreg->typ = IR_VREGTYPE_REG) and _
           				((svreg->reg = EMIT_REG_ESI) or (svreg->reg = EMIT_REG_EDI)) ) then
						hMOV aux16, src
					else
						hMOV aux8, src
					end if

					if( irIsSigned( svreg->dtype ) ) then
						ostr = "movsx "
					else
						ostr = "movzx "
					end if
					ostr += dst + COMMA + aux8
					outp ostr

					if( not isfree ) then
						hPOP aux16
					end if

				'' SI/DI not used as byte
				else
					hPrepOperand( svreg, src, dvreg->dtype )
					ostr = "mov " + dst + COMMA + src
					outp ostr
				end if
			end if
		end if
	end if

end sub

'':::::
private sub _emitLOADL2I( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static

	'' been too complex due the SI/DI crap, leave it to I2I
	_emitLOADI2I( dvreg, svreg )

end sub

'':::::
private sub _emitLOADF2I( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static

    dim as string dst, src, aux, aux8
    dim as integer ddsize, reg, isfree
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ddsize = irGetDataSize( dvreg->dtype )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		ostr = "fld " + src
		outp ostr
	end if

	'' byte destine? damn..
	if( ddsize = 1 ) then

		outp "sub esp, 4"
        outp "fistp dword ptr [esp]"

    	'' destine is a reg
    	if( dvreg->typ = IR_VREGTYPE_REG ) then
    		'' handle DI/SI as destine
        	if( (dvreg->reg = EMIT_REG_ESI) or (dvreg->reg = EMIT_REG_EDI) ) then
				if( irIsSigned( dvreg->dtype ) ) then
					ostr = "movsx "
				else
					ostr = "movzx "
				end if
				ostr += dst + ", byte ptr [esp]"
				outp ostr

			else
				hMOV dst, "byte ptr [esp]"
			end if

			outp "add esp, 4"

		'' destine is a var/idx/ptr
        else

			reg = hFindRegNotInVreg( dvreg, TRUE )

			aux8 = *hGetRegName( IR_DATATYPE_BYTE, reg )
			aux  = *hGetRegName( IR_DATATYPE_INTEGER, reg )

			isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

			if( not isfree ) then
				hXCHG aux, "dword ptr [esp]"
			else
				hMOV aux8, "byte ptr [esp]"
			end if

			hMOV dst, aux8

			if( not isfree ) then
				hPOP aux
			else
				outp "add esp, 4"
			end if

        end if

	else

		'' signed?
		if( irIsSigned( dvreg->dtype ) ) then

			outp "sub esp, 4"

			ostr = "fistp " + dtypeTB(dvreg->dtype).mname + " [esp]"
			outp ostr

			'' not an integer? make it
			if( ddsize < FB_INTEGERSIZE ) then
				dst = *hGetRegName( IR_DATATYPE_INTEGER, dvreg->reg )
			end if

			hPOP dst

		'' unsigned.. try a bigger type
		else

			'' uint?
			if( ddsize = FB_INTEGERSIZE ) then
				outp "sub esp, 8"
				outp "fistp qword ptr [esp]"
				hPOP dst
				outp  "add esp, 4"

			'' ushort..
			else
				outp "sub esp, 4"
				outp "fistp dword ptr [esp]"
				hPOP dst
				outp  "add esp, 2"
			end if

		end if

	end if

end sub

'':::::
private sub _emitLOADL2F( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then

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
		if( irIsSigned( svreg->dtype ) ) then
			ostr = "fild " + src
			outp ostr

		'' unsigned, try a bigger type..
		else
			ostr = "fild " + src
			outp ostr
			hULONG2DBL( svreg )

		end if

	end if

end sub

'':::::
private sub _emitLOADI2F( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static
    dim as string dst, src, aux
    dim as integer sdsize, isfree, reg
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

    sdsize = irGetDataSize( svreg->dtype )

	'' byte source? damn..
	if( sdsize = 1 ) then

		reg = hFindRegNotInVreg( svreg )

		aux = *hGetRegName( IR_DATATYPE_INTEGER, reg )

		isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

		if( not isfree ) then
			hPUSH aux
		end if

		if( irIsSigned( svreg->dtype ) ) then
			ostr = "movsx " + aux + COMMA + src
			outp ostr
		else
			ostr = "movzx " + aux + COMMA + src
			outp ostr
		end if

		hPUSH aux
		outp "fild dword ptr [esp]"
		outp "add esp, 4"

		if( not isfree ) then
			hPOP aux
		end if

		exit sub
	end if

	''
	if( (svreg->typ = IR_VREGTYPE_REG) or (svreg->typ = IR_VREGTYPE_IMM) ) then

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then

			'' not an integer? make it
			if( (svreg->typ = IR_VREGTYPE_REG) and (sdsize < FB_INTEGERSIZE) ) then
				src = *hGetRegName( IR_DATATYPE_INTEGER, svreg->reg )
			end if

			hPUSH src

			ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr

			outp "add esp, 4"

		'' unsigned, try a bigger type..
		else

			'' uint?
			if( sdsize = FB_INTEGERSIZE ) then
				hPUSH "0"
				hPUSH src
				outp "fild qword ptr [esp]"
				outp "add esp, 8"

			'' ushort..
			else
				if( svreg->typ <> IR_VREGTYPE_IMM ) then
					hPUSH "0"
				end if

				hPUSH src
				outp "fild dword ptr [esp]"

				if( svreg->typ <> IR_VREGTYPE_IMM ) then
					outp "add esp, 6"
				else
					outp "add esp, 4"
				end if
			end if

		end if

	'' not a reg or imm
	else

		'' signed?
		if( irIsSigned( svreg->dtype ) ) then
			ostr = "fild " + src
			outp ostr

		'' unsigned, try a bigger type..
		else
			'' uint..
			if( sdsize = FB_INTEGERSIZE ) then
				hPUSH "0"
				hPUSH src
				outp "fild qword ptr [esp]"
				outp "add esp, 8"

			'' ushort..
			else
				hPUSH "0"
				hPUSH src
				outp "fild dword ptr [esp]"
				outp "add esp, 6"
			end if
		end if

	end if

end sub

'':::::
private sub _emitLOADF2F( byval dvreg as IRVREG ptr, _
			      		  byval svreg as IRVREG ptr ) static
    dim as string src
    dim as string ostr

	hPrepOperand( svreg, src )

	ostr = "fld " + src
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitMOVL( byval dvreg as IRVREG ptr, _
			   		   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "mov " + dst1 + COMMA + src1
	outp ostr

	ostr = "mov " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitMOVI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "mov " + dst + COMMA + src
	outp ostr

end sub

'':::::
private sub _emitMOVF( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static

	'' do nothing, both are regs

end sub

'':::::
private sub _emitADDL( byval dvreg as IRVREG ptr, _
			    	   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "add " + dst1 + COMMA + src1
	outp ostr

	ostr = "adc " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitADDI( byval dvreg as IRVREG ptr, _
			  		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	doinc = FALSE
	dodec = FALSE
	if( svreg->typ = IR_VREGTYPE_IMM ) then
		select case svreg->value
		case 1
			doinc = TRUE
		case -1
			dodec = TRUE
		end select
	end if

	if( doinc ) then
		ostr = "inc " + dst
		outp ostr
	elseif( dodec ) then
		ostr = "dec " + dst
		outp ostr
	else
		ostr = "add " + dst + COMMA + src
		outp ostr
	end if

end sub

'':::::
private sub _emitADDF( byval dvreg as IRVREG ptr, _
			  		   byval svreg as IRVREG ptr ) static
    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		ostr = "faddp"
		outp ostr
	else
		if( irGetDataClass( svreg->dtype ) = IR_DATACLASS_FPOINT ) then
			ostr = "fadd " + src
			outp ostr
		else
			ostr = "fiadd " + src
			outp ostr
		end if
	end if

end sub

'':::::
private sub _emitSUBL( byval dvreg as IRVREG ptr, _
			   		   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "sub " + dst1 + COMMA + src1
	outp ostr

	ostr = "sbb " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitSUBI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	doinc = FALSE
	dodec = FALSE
	if( svreg->typ = IR_VREGTYPE_IMM ) then
		select case svreg->value
		case 1
			dodec = TRUE
		case -1
			doinc = TRUE
		end select
	end if

	if( dodec ) then
		ostr = "dec " + dst
		outp ostr
	elseif( doinc ) then
		ostr = "inc " + dst
		outp ostr
	else
		ostr = "sub " + dst + COMMA + src
		outp ostr
	end if

end sub

'':::::
private sub _emitSUBF( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim src as string
    dim doinc as integer, dodec as integer
    dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		outp "fsubrp"
	else
		if( irGetDataClass( svreg->dtype ) = IR_DATACLASS_FPOINT ) then
			ostr = "fsub " + src
			outp ostr
		else
			ostr = "fisub " + src
			outp ostr
		end if
	end if

end sub

'':::::
private sub _emitMULI( byval dvreg as IRVREG ptr, _
			      	   byval svreg as IRVREG ptr ) static
    dim eaxfree as integer, edxfree as integer
    dim edxtrashed as integer
    dim eaxinsource as integer, eaxindest as integer, edxindest as integer
    dim eax as string, edx as string
    dim ostr as string
    dim dst as string, src as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	eaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
	edxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )

	eaxinsource = hIsRegInVreg( svreg, EMIT_REG_EAX )
	eaxindest = hIsRegInVreg( dvreg, EMIT_REG_EAX )
	edxindest = hIsRegInVreg( dvreg, EMIT_REG_EDX )

    if( dtypeTB(dvreg->dtype).size = 4 ) then
    	eax = "eax"
    	edx = "edx"
    else
    	eax = "ax"
    	edx = "dx"
    end if

	if( (eaxinsource) or (svreg->typ = IR_VREGTYPE_IMM) ) then
		edxtrashed = TRUE
		if( edxindest ) then
			hPUSH( "edx" )
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPrepOperand( dvreg, ostr, IR_DATATYPE_INTEGER )
				hPUSH( ostr )
			end if
		elseif( not edxfree ) then
			hPUSH( "edx" )
		end if

		hMOV( edx, src )
		src = edx
	else
		edxtrashed = FALSE
	end if

	if( (not eaxindest) or (dvreg->typ <> IR_VREGTYPE_REG) ) then
		if( (edxindest) and (edxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				hPOP "eax"
			end if
		else
			if( not eaxfree ) then
				hPUSH "eax"
			end if
			hMOV eax, dst
		end if
	end if

	ostr = "mul " + src
	outp ostr

	if( not eaxindest ) then
		if( edxindest and dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "edx"					'' edx= tos (eax)
			outp "xchg edx, [esp]"			'' tos= edx; edx= dst
		end if

		hMOV dst, eax

		if( not eaxfree ) then
			hPOP eax
		end if
	else
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hMOV "edx", "eax"			'' edx= eax
			hPOP "eax"					'' restore eax
			hMOV dst, edx				'' [eax+...] = edx
		end if
	end if

	if( edxtrashed ) then
		if( (not edxfree) and (not edxindest) ) then
			hPOP edx
		end if
	end if

end sub

'':::::
private sub _emitMULL( byval dvreg as IRVREG ptr, _
			      	   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim iseaxfree as integer, isedxfree as integer
    dim eaxindest as integer, edxindest as integer
    dim ofs as integer

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	iseaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
	isedxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )

	eaxindest = hIsRegInVreg( dvreg, EMIT_REG_EAX )
	edxindest = hIsRegInVreg( dvreg, EMIT_REG_EDX )

	hPUSH( src2 )
	hPUSH( src1 )
	hPUSH( dst2 )
	hPUSH( dst1 )

	ofs = 0

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			ofs += 4
			hPUSH( "edx" )
		end if
	else
		if( not isedxfree ) then
			ofs += 4
			hPUSH( "edx" )
		end if
	end if

	if( eaxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			ofs += 4
			hPUSH "eax"
		end if
	else
		if( not iseaxfree ) then
			ofs += 4
			hPUSH "eax"
		end if
	end if

	'' res = low(dst) * low(src)
	outp "mov eax, [esp+" + str$(0+ofs) + "]"
	outp "mul dword ptr [esp+" + str$(8+ofs) + "]"

	'' hres= low(dst) * high(src) + high(res)
	outp "xchg eax, [esp+" + str$(0+ofs) + "]"

	outp "imul eax, [esp+" + str$(12+ofs) + "]"
	outp "add eax, edx"

	'' hres += high(dst) * low(src)
	outp "mov edx, [esp+" + str$(4+ofs) + "]"
	outp "imul edx, [esp+" + str$(8+ofs) + "]"
	outp "add edx, eax"
	outp "mov [esp+" + str$(4+ofs) + "], edx"

	if( eaxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "eax"
		end if
	else
		if( not iseaxfree ) then
			hPOP "eax"
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "edx"
		end if
	else
		if( not isedxfree ) then
			hPOP "edx"
		end if
	end if

	'' low(dst) = low(res)
	hPOP dst1
	'' high(dst) = hres
	hPOP dst2

	outp "add esp, 8"

	'' code:
	'' mov	eax, low(dst)
	'' mul	low(src)
	'' mov	ebx, low(dst)
	'' imul	ebx, high(src)
	'' add	ebx, edx
	'' mov	edx, high(dst)
	'' imul	edx, low(src)
	'' add	edx, ebx
	'' mov	low(dst), eax
	'' mov	high(dst), edx

end sub

'':::::
private sub _emitSMULI( byval dvreg as IRVREG ptr, _
			      		byval svreg as IRVREG ptr ) static

    dim reg as integer, isfree as integer, rname as string
    dim ostr as string
    dim dst as string, src as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( dvreg->typ <> IR_VREGTYPE_REG ) then

		reg = hFindRegNotInVreg( svreg )
		rname = *hGetRegName( svreg->dtype, reg )

		isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

		if( not isfree ) then
			hPUSH rname
		end if

		hMOV rname, dst
		ostr = "imul " + rname + COMMA + src
		outp ostr
		hMOV dst, rname

		if( not isfree ) then
			hPOP rname
		end if

	else
		ostr = "imul " + dst + COMMA + src
		outp ostr
	end if

end sub

'':::::
private sub _emitMULF( byval dvreg as IRVREG ptr, _
		     		   byval svreg as IRVREG ptr ) static
    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		outp "fmulp"
	else
		if( irGetDataClass( svreg->dtype ) = IR_DATACLASS_FPOINT ) then
			ostr = "fmul " + src
			outp ostr
		else
			ostr = "fimul " + src
			outp ostr
		end if
	end if

end sub


'':::::
private sub _emitDIVF( byval dvreg as IRVREG ptr, _
		     		   byval svreg as IRVREG ptr ) static
    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		outp "fdivrp"
	else
		if( irGetDataClass( svreg->dtype ) = IR_DATACLASS_FPOINT ) then
			ostr = "fdiv " + src
			outp ostr
		else
			ostr = "fidiv " + src
			outp ostr
		end if
	end if

end sub

'':::::
private sub _emitDIVI( byval dvreg as IRVREG ptr, _
		               byval svreg as IRVREG ptr ) static
    dim as string dst, src
    dim as integer ecxtrashed
    dim as integer eaxfree, ecxfree, edxfree
    dim as integer eaxindest, ecxindest, edxindest
    dim as integer eaxinsource, edxinsource
    dim as string eax, ecx, edx
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

    if( dtypeTB(dvreg->dtype).size = 4 ) then
    	eax = "eax"
    	ecx = "ecx"
    	edx = "edx"
    else
    	eax = "ax"
    	ecx = "cx"
    	edx = "dx"
    end if

	ecxtrashed = FALSE

	eaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
	ecxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ECX )
	edxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )

	eaxinsource = hIsRegInVreg( svreg, EMIT_REG_EAX )
	edxinsource = hIsRegInVreg( svreg, EMIT_REG_EDX )
	eaxindest = hIsRegInVreg( dvreg, EMIT_REG_EAX )
	edxindest = hIsRegInVreg( dvreg, EMIT_REG_EDX )
	ecxindest = hIsRegInVreg( dvreg, EMIT_REG_ECX )

	if( (eaxinsource) or (edxinsource) or (svreg->typ = IR_VREGTYPE_IMM) ) then
		ecxtrashed = TRUE
		if( ecxindest ) then
			hPUSH( "ecx" )
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPrepOperand( dvreg, ostr, IR_DATATYPE_INTEGER )
				hPUSH( ostr )
			end if
		elseif( not ecxfree ) then
			hPUSH( "ecx" )
		end if
		hMOV( ecx, src )
		src = ecx
	end if

	if( not eaxindest ) then
		if( (ecxindest) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				hPOP "eax"
			end if
		else
			if( not eaxfree ) then
				hPUSH "eax"
			end if
			hMOV eax, dst
		end if

	else
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPUSH "eax"
			hMOV eax, dst
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPUSH "edx"
		end if
	elseif( not edxfree ) then
		hPUSH "edx"
	end if

	if( irIsSigned( dvreg->dtype ) ) then
		if( dtypeTB(dvreg->dtype).size = 4 ) then
			outp "cdq"
		else
			outp "cwd"
		end if

		ostr = "idiv " + src
		outp ostr

	else
		ostr = "xor " + edx + ", " + edx
		outp ostr

		ostr = "div " + src
		outp ostr
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "edx"
		end if
	elseif( not edxfree ) then
		hPOP "edx"
	end if

	if( not eaxindest ) then
		if( ecxindest ) then
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPOP "ecx"					'' ecx= tos (eax)
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
			end if
		end if

		hMOV dst, eax

		if( not eaxfree ) then
			hPOP "eax"
		end if

	else
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			if( (not ecxfree) and (not ecxtrashed) ) then
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
				outp "xchg ecx, eax"			'' ecx= res; eax= dst
			else
				hMOV "ecx", "eax"			'' ecx= eax
				hPOP "eax"					'' restore eax
			end if

			hMOV dst, ecx					'' [eax+...] = ecx

			if( (not ecxfree) and (not ecxtrashed) ) then
				hPOP "ecx"
			end if
		end if
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (not ecxindest) ) then
			hPOP "ecx"
		end if
	end if

end sub

'':::::
private sub _emitMODI( byval dvreg as IRVREG ptr, _
		     		   byval svreg as IRVREG ptr ) static
    dim as string dst, src
    dim as integer ecxtrashed
    dim as integer eaxfree, ecxfree, edxfree
    dim as integer eaxindest, ecxindest, edxindest
    dim as integer eaxinsource, edxinsource
    dim as string eax, ecx, edx
    dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

    if( dtypeTB(dvreg->dtype).size = 4 ) then
    	eax = "eax"
    	ecx = "ecx"
    	edx = "edx"
    else
    	eax = "ax"
    	ecx = "cx"
    	edx = "dx"
    end if

	ecxtrashed = FALSE

	eaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
	ecxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ECX )
	edxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )

	eaxinsource = hIsRegInVreg( svreg, EMIT_REG_EAX )
	edxinsource = hIsRegInVreg( svreg, EMIT_REG_EDX )
	eaxindest = hIsRegInVreg( dvreg, EMIT_REG_EAX )
	edxindest = hIsRegInVreg( dvreg, EMIT_REG_EDX )
	ecxindest = hIsRegInVreg( dvreg, EMIT_REG_ECX )

	if( (eaxinsource) or (edxinsource) or (svreg->typ = IR_VREGTYPE_IMM) ) then
		ecxtrashed = TRUE
		if( ecxindest ) then
			hPUSH( "ecx" )
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPrepOperand( dvreg, ostr, IR_DATATYPE_INTEGER )
				hPUSH( ostr )
			end if
		elseif( not ecxfree ) then
			hPUSH( "ecx" )
		end if
		hMOV( ecx, src )
		src = ecx
	end if

	if( not eaxindest ) then
		if( (ecxindest) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				hPOP "eax"
			end if
		else
			if( not eaxfree ) then
				hPUSH "eax"
			end if
			hMOV eax, dst
		end if

	else
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPUSH "eax"
			hMOV eax, dst
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPUSH "edx"
		end if
	elseif( not edxfree ) then
		hPUSH "edx"
	end if

	if( irIsSigned( dvreg->dtype ) ) then
		if( dtypeTB(dvreg->dtype).size = 4 ) then
			outp "cdq"
		else
			outp "cwd"
		end if

		ostr = "idiv " + src
		outp ostr

	else
		ostr = "xor " + edx + ", " + edx
		outp ostr

		ostr = "div " + src
		outp ostr
	end if

	hMOV eax, edx

	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "edx"
		end if
	elseif( not edxfree ) then
		hPOP "edx"
	end if

	if( not eaxindest ) then
		if( ecxindest ) then
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPOP "ecx"					'' ecx= tos (eax)
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
			end if
		end if

		hMOV dst, eax

		if( not eaxfree ) then
			hPOP "eax"
		end if

	else
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			if( (not ecxfree) and (not ecxtrashed) ) then
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
				outp "xchg ecx, eax"			'' ecx= res; eax= dst
			else
				hMOV "ecx", "eax"			'' ecx= eax
				hPOP "eax"					'' restore eax
			end if

			hMOV dst, ecx					'' [eax+...] = ecx

			if( (not ecxfree) and (not ecxtrashed) ) then
				hPOP "ecx"
			end if
		end if
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (not ecxindest) ) then
			hPOP "ecx"
		end if
	end if

end sub

'':::::
private sub hSHIFTL( byval op as integer, _
				 	 byval dvreg as IRVREG ptr, _
			     	 byval svreg as IRVREG ptr ) static
    dim as string dst1, dst2, src, ostr, label, mnemonic
    dim as integer iseaxfree, isedxfree, isecxfree
    dim as integer eaxindest, edxindest, ecxindest
    dim as integer ofs

	''
	if( irIsSigned( dvreg->dtype ) ) then
		if( op = IR_OP_SHL ) then
			mnemonic = "sal"
		else
			mnemonic = "sar"
		end if
	else
		if( op = IR_OP_SHL ) then
			mnemonic = "shl"
		else
			mnemonic = "shr"
		end if
	end if

    ''
	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand( svreg, src, IR_DATATYPE_INTEGER )

	iseaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
	isedxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )
	isecxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ECX )

	eaxindest = hIsRegInVreg( dvreg, EMIT_REG_EAX )
	edxindest = hIsRegInVreg( dvreg, EMIT_REG_EDX )
	ecxindest = hIsRegInVreg( dvreg, EMIT_REG_ECX )

	hPUSH( dst2 )
	hPUSH( dst1 )
	ofs = 0

	'' load src to cl
	if( svreg->typ <> IR_VREGTYPE_IMM ) then
		if( (svreg->typ <> IR_VREGTYPE_REG) or (svreg->reg <> EMIT_REG_ECX) ) then
			'' handle src < dword
			if( irGetDataSize( svreg->dtype ) <> FB_INTEGERSIZE ) then
				'' if it's not a reg, the right size was already set at the hPrepOperand() above
				if( svreg->typ = IR_VREGTYPE_REG ) then
					src = *hGetRegName( IR_DATATYPE_INTEGER, svreg->reg )
				end if
			end if

			if( not isecxfree ) then
				if( ecxindest and dvreg->typ = IR_VREGTYPE_REG ) then
					hMOV( "ecx", src )
					isecxfree = TRUE
				else
					hPUSH( src )
					outp "xchg ecx, [esp]"
					ofs += 4
				end if
			else
				hMOV( "ecx", src )
			end if
		else
			isecxfree = TRUE
		end if
	end if

	'' load dst1 to eax
	if( eaxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			outp "xchg eax, [esp+" + str$(ofs+0) + "]"
		else
			outp "mov eax, [esp+" + str$(ofs+0) + "]"
		end if
	else
		if( not iseaxfree ) then
			outp "xchg eax, [esp+" + str$(ofs+0) + "]"
		else
			outp "mov eax, [esp+" + str$(ofs+0) + "]"
		end if
	end if

	'' load dst2 to edx
	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			outp "xchg edx, [esp+" + str$(ofs+4) + "]"
		else
			outp "mov edx, [esp+" + str$(ofs+4) + "]"
		end if
	else
		if( not isedxfree ) then
			outp "xchg edx, [esp+" + str$(ofs+4) + "]"
		else
			outp "mov edx, [esp+" + str$(ofs+4) + "]"
		end if
	end if

	'' if src is not an imm, use cl and check for the x86 glitches
	if( svreg->typ <> IR_VREGTYPE_IMM ) then
		label = *hMakeTmpStr( )

		if( op = IR_OP_SHL ) then
			outp "shld edx, eax, cl"
			outp mnemonic + " eax, cl"
		else
			outp "shrd eax, edx, cl"
			outp mnemonic + " edx, cl"
		end if

		outp "test cl, 32"
		hBRANCH( "jz", label )

		if( op = IR_OP_SHL ) then
			outp "mov edx, eax"
			outp "xor eax, eax"
		else
			outp "mov eax, edx"
			if( irIsSigned( dvreg->dtype ) ) then
				outp "sar edx, 31"
			else
				outp "xor edx, edx"
			end if
		end if

		hLABEL( label )

		if( not isecxfree ) then
			hPOP "ecx"
		end if

	'' immediate
	else

		if( valint( src ) <> 32 ) then
			if( op = IR_OP_SHL ) then
				outp "shld edx, eax, " + src
				outp mnemonic + " eax, " + src
			else
				outp "shrd eax, edx, " + src
				outp mnemonic + " edx, " + src
			end if
		'' src = 32, just swap
		else
			if( op = IR_OP_SHL ) then
				outp "mov edx, eax"
				outp "xor eax, eax"
			else
				outp "mov eax, edx"
				if( irIsSigned( dvreg->dtype ) ) then
					outp "sar edx, 31"
				else
					outp "xor edx, edx"
				end if
			end if
		end if
	end if

	'' save dst2
	if( edxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			outp "xchg edx, [esp+4]"
		else
			outp "mov [esp+4], edx"
		end if
	else
		if( not isedxfree ) then
			outp "xchg edx, [esp+4]"
		else
			outp "mov [esp+4], edx"
		end if
	end if

	'' save dst1
	if( eaxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			outp "xchg eax, [esp+0]"
		else
			outp "mov [esp+0], eax"
		end if
	else
		if( not iseaxfree ) then
			outp "xchg eax, [esp+0]"
		else
			outp "mov [esp+0], eax"
		end if
	end if

	hPOP( dst1 )
	hPOP( dst2 )

end sub

'':::::
private sub hSHIFTI( byval op as integer, _
			   		 byval dvreg as IRVREG ptr, _
		       		 byval svreg as IRVREG ptr ) static

    dim eaxpreserved as integer, ecxpreserved as integer
    dim eaxfree as integer, ecxfree as integer
    dim reg as integer
    dim ecxindest as integer
    dim as string ostr, dst, src, tmp, mnemonic

	''
	if( irIsSigned( dvreg->dtype ) ) then
		if( op = IR_OP_SHL ) then
			mnemonic = "sal"
		else
			mnemonic = "sar"
		end if
	else
		if( op = IR_OP_SHL ) then
			mnemonic = "shl"
		else
			mnemonic = "shr"
		end if
	end if

    ''
	hPrepOperand( dvreg, dst )

	ecxindest = FALSE
	eaxpreserved = FALSE
	ecxpreserved = FALSE

	if( svreg->typ = IR_VREGTYPE_IMM ) then
		hPrepOperand( svreg, src )
		tmp = dst

	else
		eaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
		ecxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ECX )

		if( svreg->typ = IR_VREGTYPE_REG ) then
			reg = svreg->reg
		else
			reg = INVALID
		end if

        ecxindest = hIsRegInVreg( dvreg, EMIT_REG_ECX )

		'' ecx in destine?
		if( ecxindest ) then
			'' preserve
			hPUSH "ecx"
			'' not a reg?
			if( dvreg->typ <> IR_VREGTYPE_REG ) then
				hPrepOperand( dvreg, ostr, IR_DATATYPE_INTEGER )
				hPUSH ostr
			end if

		'' ecx not free?
		elseif( (reg <> EMIT_REG_ECX) and (not ecxfree) ) then
			ecxpreserved = TRUE
			hPUSH "ecx"
		end if

		'' source not a reg?
		if( svreg->typ <> IR_VREGTYPE_REG ) then
			hPrepOperand( svreg, ostr, IR_DATATYPE_BYTE )
			hMOV "cl", ostr
		else
			'' source not ecx?
			if( reg <> EMIT_REG_ECX ) then
				hMOV "ecx", rnameTB(dtypeTB(IR_DATATYPE_INTEGER).rnametb, reg)
			end if
		end if

		'' load ecx to a tmp?
		if( ecxindest ) then
			'' tmp not free?
			if( not eaxfree ) then
				eaxpreserved = TRUE
				outp "xchg eax, [esp]"		'' eax= dst; push eax
			else
				hPOP "eax"				'' eax= dst; pop tos
			end if

			tmp = rnameTB(dtypeTB(dvreg->dtype).rnametb, EMIT_REG_EAX )

		else
			tmp = dst
		end if

		src = "cl"

	end if

	ostr = mnemonic + " " + tmp + COMMA + src
	outp ostr

	if( ecxindest ) then
		if( dvreg->typ <> IR_VREGTYPE_REG ) then
			hPOP "ecx"
			if( eaxpreserved ) then
				outp "xchg ecx, [esp]"		'' ecx= tos; tos= eax
			end if
		end if
		hMOV dst, rnameTB(dtypeTB(dvreg->dtype).rnametb, EMIT_REG_EAX)
	end if

	if( eaxpreserved ) then
		hPOP "eax"
	end if

	if( ecxpreserved ) then
		hPOP "ecx"
	end if

end sub

'':::::
private sub _emitSHLL( byval dvreg as IRVREG ptr, _
		       		   byval svreg as IRVREG ptr ) static

	hSHIFTL( IR_OP_SHL, dvreg, svreg )

end sub

'':::::
private sub _emitSHLI( byval dvreg as IRVREG ptr, _
		       		   byval svreg as IRVREG ptr ) static

	hSHIFTI( IR_OP_SHL, dvreg, svreg )

end sub

'':::::
private sub _emitSHRL( byval dvreg as IRVREG ptr, _
		       		   byval svreg as IRVREG ptr ) static

	hSHIFTL( IR_OP_SHR, dvreg, svreg )

end sub

'':::::
private sub _emitSHRI( byval dvreg as IRVREG ptr, _
		       		   byval svreg as IRVREG ptr ) static

	hSHIFTI( IR_OP_SHR, dvreg, svreg )

end sub

'':::::
private sub _emitANDL( byval dvreg as IRVREG ptr, _
			   			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "and " + dst1 + COMMA + src1
	outp ostr

	ostr = "and " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitANDI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "and " + dst + COMMA + src
	outp ostr

end sub

'':::::
private sub _emitORL( byval dvreg as IRVREG ptr, _
			  		  byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "or " + dst1 + COMMA + src1
	outp ostr

	ostr = "or " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitORI( byval dvreg as IRVREG ptr, _
					  byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "or " + dst + COMMA + src
	outp ostr

end sub

'':::::
private sub _emitXORL( byval dvreg as IRVREG ptr, _
			   			byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "xor " + dst1 + COMMA + src1
	outp ostr

	ostr = "xor " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitXORI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "xor " + dst + COMMA + src
	outp ostr

end sub

'':::::
private sub _emitEQVL( byval dvreg as IRVREG ptr, _
			   		   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "xor " + dst1 + COMMA + src1
	outp ostr

	ostr = "xor " + dst2 + COMMA + src2
	outp ostr

	ostr = "not " + dst1
	outp ostr

	ostr = "not " + dst2
	outp ostr

end sub

'':::::
private sub _emitEQVI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "xor " + dst + COMMA + src
	outp ostr

	ostr = "not " + dst
	outp ostr

end sub

'':::::
private sub _emitIMPL( byval dvreg as IRVREG ptr, _
			   		   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	ostr = "not " + dst1
	outp ostr

	ostr = "not " + dst2
	outp ostr

	ostr = "or " + dst1 + COMMA + src1
	outp ostr

	ostr = "or " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
private sub _emitIMPI( byval dvreg as IRVREG ptr, _
			 		   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	ostr = "not " + dst
	outp ostr

	ostr = "or " + dst + COMMA + src
	outp ostr

end sub

'':::::
private sub _emitATN2( byval dvreg as IRVREG ptr, _
			    	   byval svreg as IRVREG ptr ) static

    dim src as string
    dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		ostr = "fld " + src
		outp ostr
	else
		outp "fxch"
	end if
	outp "fpatan"

end sub

'':::::
private sub _emitPOW( byval dvreg as IRVREG ptr, _
			  		  byval svreg as IRVREG ptr ) static

	dim src as string
	dim ostr as string

	hPrepOperand( svreg, src )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		ostr = "fld " + src
		outp ostr
		outp "fxch"
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

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' relational
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCMPL( byval rvreg as IRVREG ptr, _
			       byval label as FBSYMBOL ptr, _
			       byval mnemonic as string, _
			       byval rev_mnemonic as string, _
			       byval usg_mnemonic as string, _
			       byval dvreg as IRVREG ptr, _
			       byval svreg as IRVREG ptr, _
			       byval isinverse as integer = FALSE ) static

    dim as string dst1, dst2, src1, src2, rname, ostr, lname, falselabel

	hPrepOperand64( dvreg, dst1, dst2 )
	hPrepOperand64( svreg, src1, src2 )

	if( label = NULL ) then
		lname = *hMakeTmpStr( )
	else
		lname = symbGetName( label )
	end if

	'' check high
	ostr = "cmp " + dst2 + COMMA + src2
	outp ostr

	falselabel = *hMakeTmpStr( )

	'' set the boolean result?
	if( rvreg <> NULL ) then
		hPrepOperand( rvreg, rname )
		hMOV( rname, "-1" )
	end if

	ostr = "j" + mnemonic
	if( not isinverse ) then
		hBRANCH( ostr, lname )
	else
		hBRANCH( ostr, falselabel )
	end if

	if( len( rev_mnemonic ) > 0 ) then
		ostr = "j" + rev_mnemonic
		hBRANCH( ostr, falselabel )
	end if

	'' check low
	ostr = "cmp " + dst1 + COMMA + src1
	outp ostr

	ostr = "j" + usg_mnemonic
	hBRANCH( ostr, lname )

	hLabel( falselabel )

	if( rvreg <> NULL ) then
		ostr = "xor " + rname + COMMA + rname
		outp ostr

		hLabel( lname )
	end if

end sub

'':::::
private sub hCMPI( byval rvreg as IRVREG ptr, _
		   		   byval label as FBSYMBOL ptr, _
		   		   byval mnemonic as string, _
		   		   byval dvreg as IRVREG ptr, _
		   		   byval svreg as IRVREG ptr ) static

    dim as string rname, rname8, dst, src, ostr, lname
    dim as integer isedxfree, dotest

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( label = NULL ) then
		lname = *hMakeTmpStr( )
	else
		lname = symbGetName( label )
	end if

	'' optimize "cmp" to "test"
	dotest = FALSE
	if( (svreg->typ = IR_VREGTYPE_IMM) and (dvreg->typ = IR_VREGTYPE_REG) ) then
		if( svreg->value = 0 ) then
			dotest = TRUE
		end if
	end if

	if( dotest ) then
		ostr = "test " + dst + COMMA + dst
		outp ostr
	else
		ostr = "cmp " + dst + COMMA + src
		outp ostr
	end if

	'' no result to be set? just branch
	if( rvreg = NULL ) then
		ostr = "j" + mnemonic
		hBRANCH( ostr, lname )
		exit sub
	end if

	hPrepOperand( rvreg, rname )

	'' can it be optimized?
	if( (env.clopt.cputype >= FB_CPUTYPE_486) and (rvreg->typ = IR_VREGTYPE_REG) ) then

		rname8 = *hGetRegName( IR_DATATYPE_BYTE, rvreg->reg )

		'' handle EDI and ESI
		if( (rvreg->reg = EMIT_REG_ESI) or (rvreg->reg = EMIT_REG_EDI) ) then

			isedxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )
			if( not isedxfree ) then
				ostr = "xchg edx, " + rname
				outp ostr
			end if

			ostr = "set" + mnemonic + " dl"
			outp ostr

			if( not isedxfree ) then
				ostr = "xchg edx, " + rname
				outp ostr
			else
				hMOV rname, "edx"
			end if

		else
			ostr = "set" + mnemonic + " " + rname8
			outp ostr
		end if

		'' convert 1 to -1 (TRUE in QB/FB)
		ostr = "shr " + rname + ", 1"
		outp ostr

		ostr = "sbb " + rname + COMMA + rname
		outp ostr

	'' old (and slow) boolean set
	else

		ostr = "mov " + rname + ", -1"
		outp ostr

		ostr = "j" + mnemonic
		hBRANCH( ostr, lname )

		ostr = "xor " + rname + COMMA + rname
		outp ostr

		hLabel( lname )
	end if

end sub

'':::::
private sub hCMPF( byval rvreg as IRVREG ptr, _
		   		   byval label as FBSYMBOL ptr, _
		   		   byval mnemonic as string, _
		   		   byval mask as string, _
		   		   byval dvreg as IRVREG ptr, _
		   		   byval svreg as IRVREG ptr ) static

	dim as string rname, rname8, dst, src, ostr, lname
    dim as integer iseaxfree, isedxfree

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src )

	if( label = NULL ) then
		lname = *hMakeTmpStr( )
	else
		lname = symbGetName( label )
	end if

	'' do comp
	if( svreg->typ = IR_VREGTYPE_REG ) then
		outp "fcompp"
	else
		'' can it be optimized to ftst?
		if( irGetDataClass( svreg->dtype ) = IR_DATACLASS_FPOINT ) then
			ostr = "fcomp " + src
			outp ostr
		else
			ostr = "ficomp " + src
			outp ostr
		end if
	end if

    iseaxfree = TRUE
    if( rvreg <> NULL ) then
    	if( rvreg->reg <> EMIT_REG_EAX ) then
    		iseaxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX )
    		if( not iseaxfree ) then
    			hPUSH( "eax" )
    		end if
    	end if
	end if

    '' load fpu flags
    outp "fnstsw ax"
	if( len( mask ) > 0 ) then
		ostr = "test ah, " + mask
		outp ostr
	else
		outp "sahf"
	end if

	if( not iseaxfree ) then
		hPOP( "eax" )
	end if

    '' no result to be set? just branch
    if( rvreg = NULL ) then
    	ostr = "j" + mnemonic
    	hBRANCH( ostr, lname )
    	exit sub
    end if

    hPrepOperand( rvreg, rname )

	'' can it be optimized?
	if( env.clopt.cputype >= FB_CPUTYPE_486 ) then
		rname8 = *hGetRegName( IR_DATATYPE_BYTE, rvreg->reg )

		'' handle EDI and ESI
		if( (rvreg->reg = EMIT_REG_ESI) or (rvreg->reg = EMIT_REG_EDI) ) then

			isedxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDX )
			if( not isedxfree ) then
				ostr = "xchg edx, " + rname
				outp ostr
			end if

			ostr = "set" + mnemonic + "\tdl"
			outp ostr

			if( not isedxfree ) then
				ostr = "xchg edx, " + rname
				outp ostr
			else
				hMOV rname, "edx"
			end if
		else
			ostr = "set" + mnemonic + " " + rname8
			outp ostr
		end if

		'' convert 1 to -1 (TRUE in QB/FB)
		ostr = "shr " + rname + ", 1"
		outp ostr

		ostr = "sbb " + rname + COMMA + rname
		outp ostr

	'' old (and slow) boolean set
	else
    	ostr = "mov " + rname + ", -1"
    	outp ostr

    	ostr = "j" + mnemonic
    	hBRANCH( ostr, lname )

		ostr = "xor " + rname + COMMA + rname
		outp ostr

		hLabel( lname )
	end if

end sub

'':::::
private sub _emitCGTL( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "g"
		rjmp = "l"
	else
		jmp = "a"
		rjmp = "b"
	end if

	hCMPL( rvreg, label, jmp, rjmp, "a", dvreg, svreg )

end sub

'':::::
private sub _emitCGTI( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static
	dim jmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "g"
	else
		jmp = "a"
	end if

	hCMPI( rvreg, label, jmp, dvreg, svreg )

end sub

'':::::
private sub _emitCGTF( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "z", "0b01000001", dvreg, svreg )

end sub

'':::::
private sub _emitCLTL( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "l"
		rjmp = "g"
	else
		jmp = "b"
		rjmp = "a"
	end if

	hCMPL( rvreg, label, jmp, rjmp, "b", dvreg, svreg )

end sub

'':::::
private sub _emitCLTI( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static
	dim jmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "l"
	else
		jmp = "b"
	end if

	hCMPI( rvreg, label, jmp, dvreg, svreg )

end sub

'':::::
private sub _emitCLTF( byval rvreg as IRVREG ptr, _
		      		   byval label as FBSYMBOL ptr, _
		      		   byval dvreg as IRVREG ptr, _
		      		   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "nz", "0b00000001", dvreg, svreg )

end sub

'':::::
private sub _emitCEQL( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPL( rvreg, label, "ne", "", "e", dvreg, svreg, TRUE )

end sub

'':::::
private sub _emitCEQI( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPI( rvreg, label, "e", dvreg, svreg )

end sub

'':::::
private sub _emitCEQF( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "nz", "0b01000000", dvreg, svreg )

end sub

'':::::
private sub _emitCNEL( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPL( rvreg, label, "ne", "", "ne", dvreg, svreg )

end sub

'':::::
private sub _emitCNEI( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPI( rvreg, label, "ne", dvreg, svreg )

end sub

'':::::
private sub _emitCNEF( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "z", "0b01000000", dvreg, svreg )

end sub

'':::::
private sub _emitCLEL( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "l"
		rjmp = "g"
	else
		jmp = "b"
		rjmp = "a"
	end if

	hCMPL( rvreg, label, jmp, rjmp, "be", dvreg, svreg )

end sub

'':::::
private sub _emitCLEI( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static
	dim jmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "le"
	else
		jmp = "be"
	end if

	hCMPI( rvreg, label, jmp, dvreg, svreg )

end sub


'':::::
private sub _emitCLEF( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "nz", "0b01000001", dvreg, svreg )

end sub


'':::::
private sub _emitCGEL( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "g"
		rjmp = "l"
	else
		jmp = "a"
		rjmp = "b"
	end if

	hCMPL( rvreg, label, jmp, rjmp, "ae", dvreg, svreg )

end sub

'':::::
private sub _emitCGEI( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static
	dim jmp as string

	if( irIsSigned( dvreg->dtype ) ) then
		jmp = "ge"
	else
		jmp = "ae"
	end if

	hCMPI( rvreg, label, jmp, dvreg, svreg )

end sub

'':::::
private sub _emitCGEF( byval rvreg as IRVREG ptr, _
					   byval label as FBSYMBOL ptr, _
					   byval dvreg as IRVREG ptr, _
					   byval svreg as IRVREG ptr ) static

	hCMPF( rvreg, label, "ae", "", dvreg, svreg )

end sub


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitNEGL( byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )

	ostr = "neg " + dst1
	outp ostr

	ostr = "adc " + dst2 + ", 0"
	outp ostr

	ostr = "neg " + dst2
	outp ostr

end sub

'':::::
private sub _emitNEGI( byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim ostr as string

	hPrepOperand( dvreg, dst )

	ostr = "neg " + dst
	outp ostr

end sub

'':::::
private sub _emitNEGF( byval dvreg as IRVREG ptr ) static

	outp "fchs"

end sub

'':::::
private sub _emitNOTL( byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )

	ostr = "not " + dst1
	outp ostr

	ostr = "not " + dst2
	outp ostr

end sub

'':::::
private sub _emitNOTI( byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim ostr as string

	hPrepOperand( dvreg, dst )

	ostr = "not " + dst
	outp ostr

end sub

'':::::
private sub _emitABSL( byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim reg as integer, isfree as integer, rname as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )

	reg = hFindRegNotInVreg( dvreg )
	rname = *hGetRegName( IR_DATATYPE_INTEGER, reg )

	isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

	if( not isfree ) then
		hPUSH( rname )
	end if

	hMOV( rname, dst2 )

	ostr = "sar " + rname + ", 31"
	outp ostr

	ostr = "xor " + dst1 + COMMA + rname
	outp ostr

	ostr = "xor " + dst2 + COMMA + rname
	outp ostr

	ostr = "sub " + dst1 + COMMA + rname
	outp ostr

	ostr = "sbb " + dst2 + COMMA + rname
	outp ostr

	if( not isfree ) then
		hPOP( rname )
	end if

end sub

'':::::
private sub _emitABSI( byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim reg as integer, isfree as integer, rname as string, bits as integer
    dim ostr as string

	hPrepOperand( dvreg, dst )

	reg = hFindRegNotInVreg( dvreg )
	rname = *hGetRegName( dvreg->dtype, reg )

	isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

	if( not isfree ) then
		hPUSH( rname )
	end if

	bits = (dtypeTB(dvreg->dtype).size * 8)-1

	hMOV( rname, dst )

	ostr = "sar " + rname + COMMA + str( bits )
	outp ostr

	ostr = "xor " + dst + COMMA + rname
	outp ostr

	ostr = "sub " + dst + COMMA + rname
	outp ostr

	if( not isfree ) then
		hPOP( rname )
	end if

end sub

'':::::
private sub _emitABSF( byval dvreg as IRVREG ptr ) static

	outp "fabs"

end sub

'':::::
private sub _emitSGNL( byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string
    dim label1 as string, label2 as string

	hPrepOperand64( dvreg, dst1, dst2 )

	label1 = *hMakeTmpStr( )
	label2 = *hMakeTmpStr( )

	ostr = "cmp " + dst2 + ", 0"
	outp ostr
	hBRANCH( "jne", label1 )

	ostr = "cmp " + dst1 + ", 0"
	outp ostr
	hBRANCH( "je", label2 )

	hLABEL( label1 )
	hMOV( dst1, "1" )
	hMOV( dst2, "0" )
	hBRANCH( "jg", label2 )
	hMOV( dst1, "-1" )
	hMOV( dst2, "-1" )

	hLABEL( label2 )

end sub

'':::::
private sub _emitSGNI( byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim label as string
    dim ostr as string

	hPrepOperand( dvreg, dst )

	label = *hMakeTmpStr( )

	ostr = "cmp " + dst + ", 0"
	outp ostr

	hBRANCH( "je", label )
	hMOV( dst, "1" )
	hBRANCH( "jg", label )
	hMOV( dst, "-1" )

	hLABEL( label )

end sub

'':::::
private sub _emitSGNF( byval dvreg as IRVREG ptr ) static

	'' hack! floating-point SGN is done by a rtlib function, called by AST

end sub

'':::::
private sub _emitSIN( byval dvreg as IRVREG ptr ) static

	outp "fsin"

end sub

'':::::
private sub _emitASIN( byval dvreg as IRVREG ptr ) static

	'' asin( x ) = atn( sqr( (x*x) / (1-x*x) ) )
	outp "fld st(0)"
	outp "fmulp"
	outp "fld st(0)"
	outp "fld1"
	outp "fsubrp"
    outp "fdivp"
    outp "fsqrt"
    outp "fld1"
    outp "fpatan"

end sub

'':::::
private sub _emitCOS( byval dvreg as IRVREG ptr ) static

	outp "fcos"

end sub

'':::::
private sub _emitACOS( byval dvreg as IRVREG ptr ) static

	'' acos( x ) = atn( sqr( (1-x*x) / (x*x) ) )
	outp "fld st(0)"
    outp "fmulp"
	outp "fld st(0)"
    outp "fld1"
	outp "fsubrp"
	outp "fdivrp"
	outp "fsqrt"
	outp "fld1"
	outp "fpatan"

end sub

'':::::
private sub _emitTAN( byval dvreg as IRVREG ptr ) static

	outp "fptan"
	outp "fstp st(0)"

end sub

'':::::
private sub _emitATAN( byval dvreg as IRVREG ptr ) static

	outp "fld1"
	outp "fpatan"

end sub

'':::::
private sub _emitSQRT( byval dvreg as IRVREG ptr ) static

	outp "fsqrt"

end sub

'':::::
private sub _emitLOG( byval dvreg as IRVREG ptr ) static

	'' log( x ) = log2( x ) / log2( e ).

	outp "fld1"
	outp "fxch"
	outp "fyl2x"
	outp "fldl2e"
	outp "fdivp"

end sub

'':::::
private sub _emitFLOOR( byval dvreg as IRVREG ptr ) static

	dim as integer reg, isfree
	dim as string rname, ostr

	reg = hFindFreeReg( IR_DATACLASS_INTEGER )
	rname = *hGetRegName( IR_DATATYPE_INTEGER, reg )

	isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )

	if( not isfree ) then
		hPUSH( rname )
	end if

	outp "sub esp, 4"
	outp "fnstcw [esp]"
	hMOV rname, "[esp]"
	ostr = "and " + rname + ", 0b1111001111111111"
	outp ostr
	ostr = "or " + rname +  ", 0b0000010000000000"
	outp ostr
	hPUSH rname
	outp "fldcw [esp]"
	outp "add esp, 4"
	outp "frndint"
	outp "fldcw [esp]"
	outp "add esp, 4"

	if( not isfree ) then
		hPOP( rname )
	end if

end sub

'':::::
private sub _emitXchgTOS( byval svreg as IRVREG ptr ) static
    dim as string src
    dim as string ostr

	hPrepOperand( svreg, src )

	ostr = "fxch " + src
	outp( ostr )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' stack
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitPUSHL( byval svreg as IRVREG ptr, _
						byval unused as integer ) static
    dim src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( svreg, src1, src2 )

	ostr = "push " + src2
	outp ostr

	ostr = "push " + src1
	outp ostr

end sub

'':::::
private sub _emitPUSHI( byval svreg as IRVREG ptr, _
						byval unused as integer ) static
    dim src as string, sdsize as integer
    dim ostr as string

	hPrepOperand( svreg, src )

	sdsize = irGetDataSize( svreg->dtype )

	if( svreg->typ = IR_VREGTYPE_REG ) then
		if( sdsize < FB_INTEGERSIZE ) then
			src = *hGetRegName( IR_DATATYPE_INTEGER, svreg->reg )
		end if
	else
		if( sdsize < FB_INTEGERSIZE ) then
			'' !!!FIXME!!! assuming it's okay to push over the var if's not dword aligned
			hPrepOperand( svreg, src, IR_DATATYPE_INTEGER )
		end if
	end if

	ostr = "push " + src
	outp ostr

end sub

'':::::
private sub _emitPUSHF( byval svreg as IRVREG ptr, _
						byval unused as integer ) static
    dim src as string, sdsize as integer
    dim ostr as string

	hPrepOperand( svreg, src )

	sdsize = irGetDataSize( svreg->dtype )

	if( svreg->typ <> IR_VREGTYPE_REG ) then
		if( svreg->dtype = IR_DATATYPE_SINGLE ) then
			ostr = "push " + src
			outp ostr
		else
			hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, 4 )
			ostr = "push " + src
			outp ostr

    		hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, 0 )
			ostr = "push " + src
			outp ostr
		end if
	else
		ostr = "sub esp," + str( sdsize )
		outp ostr

		ostr = "fstp " + dtypeTB(svreg->dtype).mname + " [esp]"
		outp ostr
	end if

end sub

'':::::
private sub _emitPUSHUDT( byval svreg as IRVREG ptr, _
				 		  byval sdsize as integer ) static
    dim i as integer
    dim ostr as string
    dim src as string

	'' !!!FIXME!!! assuming it's okay to push over the UDT if's not dword aligned
	for i = 0 to sdsize-1 step 4
		hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, i )
		ostr = "push " + src
		outp ostr
	next i

end sub

'':::::
private sub _emitPOPL( byval dvreg as IRVREG ptr, _
					   byval unused as integer ) static
    dim dst1 as string, dst2 as string
    dim ostr as string

	hPrepOperand64( dvreg, dst1, dst2 )

	ostr = "pop " + dst1
	outp ostr

	ostr = "pop " + dst2
	outp ostr

end sub

'':::::
private sub _emitPOPI( byval dvreg as IRVREG ptr, _
					   byval unused as integer ) static
    dim as string dst, ostr
    dim as integer dsize

	hPrepOperand( dvreg, dst )

	dsize = irGetDataSize( dvreg->dtype )

	if( dsize = FB_INTEGERSIZE ) then
		ostr = "pop " + dst
		outp ostr

	else
		if( dvreg->typ = IR_VREGTYPE_REG ) then
			dst = *hGetRegName( IR_DATATYPE_INTEGER, dvreg->reg )
			ostr = "pop " + dst
			outp ostr
		else

			outp "xchg eax, [esp]"

			if( dsize = 1 ) then
				hMOV dst, "al"
			else
				hMOV dst, "ax"
			end if

			if( not hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EAX ) ) then
				hPOP "eax"
			else
				outp "add esp, 4"
			end if
		end if

	end if

end sub

'':::::
private sub _emitPOPF( byval dvreg as IRVREG ptr, _
					   byval unused as integer ) static
    dim as string dst, ostr
    dim as integer dsize

	hPrepOperand( dvreg, dst )

	dsize = irGetDataSize( dvreg->dtype )

	if( dvreg->typ <> IR_VREGTYPE_REG ) then
		if( dvreg->dtype = IR_DATATYPE_SINGLE ) then
			ostr = "pop " + dst
			outp ostr
		else
			hPrepOperand( dvreg, dst, IR_DATATYPE_INTEGER, 0 )
			ostr = "pop " + dst
			outp ostr

			hPrepOperand( dvreg, dst, IR_DATATYPE_INTEGER, 4 )
			ostr = "pop " + dst
			outp ostr
		end if
	else
		ostr = "fld " + dtypeTB(dvreg->dtype).mname + " [esp]"
		outp ostr

		ostr = "add esp," + str$( dsize )
		outp ostr
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub _emitADDROF( byval dvreg as IRVREG ptr, _
			    		 byval svreg as IRVREG ptr ) static

	dim as string dst, src
	dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src, , , , FALSE )

	ostr = "lea " + dst + ", " + src
	outp ostr

end sub

'':::::
private sub _emitDEREF( byval dvreg as IRVREG ptr, _
			   			byval svreg as IRVREG ptr ) static

	dim as string dst, src
	dim as string ostr

	hPrepOperand( dvreg, dst )
	hPrepOperand( svreg, src, IR_DATATYPE_UINT )

	ostr = "mov " + dst + COMMA + src
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' memory
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hMemMoveRep( byval dvreg as IRVREG ptr, _
			   		     byval svreg as IRVREG ptr, _
			   		     byval bytes as integer ) static

	dim as string dst, src
	dim as string ostr
	dim as integer ecxfree, edifree, esifree
	dim as integer ediinsrc, ecxinsrc

	hPrepOperand( dvreg, dst, , , , FALSE )
	hPrepOperand( svreg, src, , , , FALSE )

	ecxfree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ECX )
	edifree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_ESI )
	esifree = hIsRegFree( IR_DATACLASS_INTEGER, EMIT_REG_EDI )

	ediinsrc = hIsRegInVreg( svreg, EMIT_REG_EDI )
	ecxinsrc = hIsRegInVreg( svreg, EMIT_REG_ECX )

	if( not ecxfree ) then
		hPUSH( "ecx" )
	end if
	if( not edifree ) then
		hPUSH( "edi" )
	end if
	if( not esifree ) then
		hPUSH( "esi" )
	end if

	if( not ediinsrc ) then
		ostr = "lea edi, " + dst
		outp ostr
	else
		if( ecxinsrc ) then
			hPUSH( "ecx" )
		end if
		ostr = "lea ecx, " + dst
		outp ostr
		if( ecxinsrc ) then
			outp "xchg ecx, [esp]"
		end if
	end if

	ostr = "lea esi, " + src
	outp ostr

	if( ediinsrc ) then
		if( not ecxinsrc ) then
			hMOV( "edi", "ecx" )
		else
			hPOP( "edi" )
		end if
	end if

	if( bytes > 4 ) then
		ostr = "mov ecx, " + str( bytes \ 4 )
		outp ostr
		outp "rep movsd"

	elseif( bytes = 4 ) then
		outp "mov ecx, [esi]"
		outp "mov [edi], ecx"
		if( (bytes and 3) > 0 ) then
			outp "add esi, 4"
			outp "add edi, 4"
		end if
	end if

	bytes and= 3
	if( bytes > 0 ) then
		if( bytes >= 2 ) then
			outp "mov cx, [esi]"
			outp "mov [edi], cx"
			if( bytes = 3 ) then
				outp "add esi, 2"
				outp "add edi, 2"
			end if
		end if

		if( (bytes and 1) <> 0 ) then
			outp "mov cl, [esi]"
			outp "mov [edi], cl"
		end if
	end if

	if( not esifree ) then
		hPOP( "esi" )
	end if
	if( not edifree ) then
		hPOP( "edi" )
	end if
	if( not ecxfree ) then
		hPOP( "ecx" )
	end if

end sub

'':::::
private sub hMemMoveBlk( byval dvreg as IRVREG ptr, _
			   		     byval svreg as IRVREG ptr, _
			   		     byval bytes as integer ) static

	dim as string dst, src, aux
	dim as integer i, ofs, reg, isfree

	reg = hFindRegNotInVreg( dvreg )

	'' no free regs left?
	if( hIsRegInVreg( svreg, reg ) ) then
		hMemMoveRep( dvreg, svreg, bytes )
		exit sub
	end if

	aux = *hGetRegName( IR_DATATYPE_INTEGER, reg )

	isfree = hIsRegFree( IR_DATACLASS_INTEGER, reg )
	if( not isfree ) then
		hPUSH( aux )
	end if

	ofs = 0
	'' move dwords
	for i = 1 to bytes \ 4
		hPrepOperand( svreg, src, IR_DATATYPE_INTEGER, ofs )
		hMOV( aux, src )
		hPrepOperand( dvreg, dst, IR_DATATYPE_INTEGER, ofs )
		hMOV( dst, aux )
		ofs += 4
	next

	'' a word left?
	if( (bytes and 2) <> 0 ) then
		aux = *hGetRegName( IR_DATATYPE_SHORT, reg )
		hPrepOperand( svreg, src, IR_DATATYPE_SHORT, ofs )
		hMOV( aux, src )
		hPrepOperand( dvreg, dst, IR_DATATYPE_SHORT, ofs )
		hMOV( dst, aux )
		ofs += 2
	end if

	'' a byte left?
	if( (bytes and 1) <> 0 ) then
		aux = *hGetRegName( IR_DATATYPE_BYTE, reg )
		hPrepOperand( svreg, src, IR_DATATYPE_BYTE, ofs )
		hMOV( aux, src )
		hPrepOperand( dvreg, dst, IR_DATATYPE_BYTE, ofs )
		hMOV( dst, aux )
	end if

	if( not isfree ) then
		hPOP( aux )
	end if

end sub

'':::::
private sub _emitMEMMOVE( byval dvreg as IRVREG ptr, _
			   			  byval svreg as IRVREG ptr, _
			   			  byval bytes as integer ) static

	if( bytes > 16 ) then
		hMemMoveRep( dvreg, svreg, bytes )
	else
		hMemMoveBlk( dvreg, svreg, bytes )
	end if

end sub

'':::::
private sub _emitMEMSWAP( byval dvreg as IRVREG ptr, _
			   			  byval svreg as IRVREG ptr, _
			   			  byval bytes as integer ) static

	'' implemented as function

end sub

'':::::
private sub _emitMEMCLEAR( byval dvreg as IRVREG ptr, _
			   			   byval svreg as IRVREG ptr, _
			   			   byval bytes as integer ) static

	'' implemented as function

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hCreateFrame( byval proc as FBSYMBOL ptr ) static
    dim as string lname
    dim as integer i, bytestoalloc

    bytestoalloc = (-proc->proc.stk.localptr + 3) and (not 3)

    if( (proc->proc.stk.localptr <> EMIT_LOCSTART) or _
    	(proc->proc.stk.argptr <> EMIT_ARGSTART) ) then

    	hPUSH( "ebp" )
    	outp( "mov ebp, esp" )

    	if( bytestoalloc > 0 ) then
    		outp( "sub esp, " + str( bytestoalloc ) )
    	end if
    end if

    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EBX ) ) then
    	hPUSH( "ebx" )
    end if
    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_ESI ) ) then
    	hPUSH( "esi" )
    end if
    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    	hPUSH( "edi" )
    end if

	''
	if( bytestoalloc > 0 ) then
		if( env.clopt.cputype >= FB_CPUTYPE_686 ) then
			if( bytestoalloc \ 8 > 7 ) then

		    	if( not EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    				hPUSH( "edi" )
    			end if

				outp( "lea edi, [ebp-" + str( bytestoalloc ) + "]" )
				outp( "mov ecx," + str( bytestoalloc \ 8 ) )
				outp( "pxor mm0, mm0" )
			    lname = *hMakeTmpStr( )
			    hLABEL( lname )
				outp( "movq [edi], mm0" )
				outp( "add edi, 8" )
				outp( "dec ecx" )
				outp( "jnz " + lname )
				outp( "emms" )

    			if( not EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    				hPOP( "edi" )
    			end if

			elseif( bytestoalloc \ 8 > 0 ) then
				outp( "pxor mm0, mm0" )
				for i = bytestoalloc\8 to 1 step -1
					outp( "movq [ebp-" + str( i*8 ) + "], mm0" )
				next
				outp( "emms" )

			end if

			if( bytestoalloc and 4 ) then
				outp( "mov dword ptr [ebp-" + str( bytestoalloc ) + "], 0" )
			end if

		else
			if( bytestoalloc \ 4 > 6 ) then
		    	if( not EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    				hPUSH( "edi" )
    			end if

				outp( "lea edi, [ebp-" + str( bytestoalloc ) + "]" )
				outp( "mov ecx," + str( bytestoalloc \ 4 ) )
				outp( "xor eax, eax" )
				outp( "rep stosd" )

    			if( not EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    				hPOP( "edi" )
    			end if

			else
				for i = bytestoalloc \ 4 to 1 step -1
					 outp( "mov dword ptr [ebp-" + str( i*4 ) + "], 0" )
				next
			end if
		end if

	end if

end sub

''::::
private sub hDestroyFrame( byval proc as FBSYMBOL ptr, _
						   byval bytestopop as integer ) static

    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EDI ) ) then
    	hPOP( "edi" )
    end if
    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_ESI ) ) then
    	hPOP( "esi" )
    end if
    if( EMIT_REGISUSED( IR_DATACLASS_INTEGER, EMIT_REG_EBX ) ) then
    	hPOP( "ebx" )
    end if

    if( (proc->proc.stk.localptr <> EMIT_LOCSTART) or _
    	(proc->proc.stk.argptr <> EMIT_ARGSTART) ) then
    	outp( "mov esp, ebp" )
    	hPOP( "ebp" )
    end if

    outp( "ret " + str( bytestopop ) )
#ifdef TARGET_LINUX
    outEx( ".size " + symbGetName( proc ) + ", .-" + id + NEWLINE, FALSE )
#endif

end sub

'':::::
sub emitPROCHEADER( byval proc as FBSYMBOL ptr, _
				   	byval initlabel as FBSYMBOL ptr ) static

	'' do nothing, proc will be only emitted at PROCEND

	emitReset( )

	edbgProcEmitBegin( proc )

end sub

'':::::
sub emitPROCFOOTER( byval proc as FBSYMBOL ptr, _
			      	byval bytestopop as integer, _
			      	byval initlabel as FBSYMBOL ptr, _
			      	byval exitlabel as FBSYMBOL ptr ) static

    dim as integer oldpos, ispublic

    ispublic = symbIsPublic( proc )

	emitSECTION( EMIT_SECTYPE_CODE )

	''
	edbgEmitProcHeader( proc )

	''
	hALIGN( 16 )

	if( ispublic ) then
		hPUBLIC( symbGetName( proc ) )
	end if

	hLABEL( symbGetName( proc ) )

#ifdef TARGET_LINUX
	outEx( ".type " + symbGetName( proc ) + ", @function" + NEWLINE, FALSE )
#endif

	'' frame
	hCreateFrame( proc )

    edbgEmitLineFlush( proc, proc->proc.dbg.iniline, proc )

    ''
    emitFlush( )

	''
	hDestroyFrame( proc, bytestopop )

    edbgEmitLineFlush( proc, proc->proc.dbg.endline, exitlabel )

    edbgEmitProcFooter( proc, initlabel, exitlabel )

end sub

'':::::
function emitAllocLocal( byval proc as FBSYMBOL ptr, _
						 byval lgt as integer, _
						 ofs as integer ) as zstring ptr static

    static as zstring * 3+1 sname = "ebp"

    proc->proc.stk.localptr -= ((lgt + 3) and not 3)

	ofs = proc->proc.stk.localptr

	function = @sname

end function

'':::::
sub emitFreeLocal( byval proc as FBSYMBOL ptr, _
				   byval lgt as integer ) static

    proc->proc.stk.localptr += ((lgt + 3) and not 3)

end sub

'':::::
function emitAllocArg( byval proc as FBSYMBOL ptr, _
					   byval lgt as integer, _
					   ofs as integer ) as zstring ptr static

    static as zstring * 3+1 sname = "ebp"

	ofs = proc->proc.stk.argptr

    proc->proc.stk.argptr += ((lgt + 3) and not 3)

	function = @sname

end function

'':::::
sub emitFreeArg( byval proc as FBSYMBOL ptr, _
				 byval lgt as integer ) static

    proc->proc.stk.argptr -= ((lgt + 3) and not 3)

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitDATALABEL( byval label as string ) static
    dim ostr as string

	ostr = label + ":\r\n"
	outEx( ostr, FALSE )

end sub

'':::::
sub emitDATABEGIN( byval lname as string ) static
    dim as string ostr
    dim as integer currpos

	if( emit.dataend <> 0 ) then
		currpos = seek( env.outf.num )

		seek #env.outf.num, emit.dataend

		ostr = ".int " + lname + NEWLINE
		outEx( ostr, FALSE )

		seek #env.outf.num, currpos

    end if

end sub

'':::::
sub emitDATAEND static
    dim as string ostr

    '' link + NULL
    outEx( ".short 0xffff" + NEWLINE, FALSE )

    emit.dataend = seek( env.outf.num )

    ostr = ".int 0" + space$( FB_MAXNAMELEN ) + NEWLINE
    outEx( ostr, FALSE )

end sub

'':::::
sub emitDATA ( byval litext as string, _
			   byval litlen as integer, _
			   byval typ as integer ) static

    static as zstring * FB_MAXLITLEN*2+1 esctext
    dim as string ostr

    esctext = hEscapeStr( litext )

	'' len + asciiz
	if( typ <> INVALID ) then
		ostr = ".short 0x" + hex$( litlen ) + NEWLINE
		outEx( ostr, FALSE )

		ostr = ".ascii \"" + esctext + "\\0\"" + NEWLINE
		outEx( ostr, FALSE )
	else
		outEx( ".short 0x0000" + NEWLINE, FALSE )
	end if

end sub

'':::::
sub emitDATAOFS ( byval sname as string ) static
    dim ostr as string

	outEx( ".short 0xfffe" + NEWLINE, FALSE )

	ostr = ".int " + sname + NEWLINE
	outEx( ostr, FALSE )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' initializers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitVARINIBEGIN( byval sym as FBSYMBOL ptr ) static

	emitSECTION( EMIT_SECTYPE_DATA )

   	edbgEmitGlobalVar( sym, EMIT_SECTYPE_DATA )

   	if( sym->typ = FB_SYMBTYPE_DOUBLE ) then
    	hALIGN( 8 )
	else
    	hALIGN( 4 )
	end if

	'' public?
	if( symbIsPublic( sym ) ) then
		hPUBLIC( sym->alias )
	end if

	hLABEL( sym->alias )

end sub

'':::::
sub emitVARINIEND( byval sym as FBSYMBOL ptr ) static

end sub

'':::::
sub emitVARINIi( byval dtype as integer, _
				 byval value as integer ) static
	dim ostr as string

	ostr = hGetTypeString( dtype ) + " " + str$( value ) + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitVARINIf( byval dtype as integer, _
				 byval value as double ) static
	dim ostr as string

	ostr = hGetTypeString( dtype ) + " " + str$( value ) + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitVARINI64( byval dtype as integer, _
				  byval value as longint ) static
	dim ostr as string

	ostr = hGetTypeString( dtype ) + " " + str$( value ) + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitVARINIOFS( byval sname as string ) static
	dim ostr as string

	ostr = ".int " + sname + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitVARINISTR( byval lgt as integer, _
				   byval s as string ) static
    dim ostr as string

	ostr = ".ascii \"" + s + "\\0\"" + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitVARINIPAD( byval bytes as integer ) static
    dim ostr as string

	ostr = ".skip " + str$( bytes ) + ",0" + NEWLINE
	outEx( ostr, FALSE )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' high-level
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitWriteHeader( ) static

   	emit.modulename = hStripPath( hStripExt( env.inf.name ) )
   	hClearName( emit.modulename )
   	emit.entryname = hCreateMainAlias( emit.modulename )

	''
	edbgEmitHeader( env.outf.num, env.inf.name, emit.modulename, emit.entryname )

	''
	hWriteStr( TRUE,  ".intel_syntax noprefix" )
    hWriteStr( FALSE, "" )
    hCOMMENT( env.inf.name + "' compilation started at " + time + " (" + FB_SIGN + ")" )

end sub

'':::::
sub emitWriteFooter( byval tottime as double ) static

	hCOMMENT( env.inf.name + "' compilation took " + str( tottime ) + " secs" )

	''
	edbgIncludeEnd( )

end sub

'':::::
sub emitWriteRtInit( ) static
    dim as zstring ptr id
    dim as ASTNODE ptr argc, argv

    '' finit
    astAdd( astNewLIT( "finit", TRUE ) )

	'' call fb_Init
	argc = NULL
	argv = NULL

	select case env.clopt.target
	case FB_COMPTARGET_DOS
		argc = astNewVAR( emit.main.argc, NULL, 0, symbGetType( emit.main.argc ) )
		argv = astNewVAR( emit.main.argv, NULL, 0, symbGetType( emit.main.argv ) )

	case FB_COMPTARGET_LINUX
		argc = astNewVAR( emit.main.argc, NULL, 0, symbGetType( emit.main.argc ) )
		argv = astNewADDR( IR_OP_ADDROF, _
						   astNewVAR( emit.main.argv, NULL, 0, symbGetType( emit.main.argv ) ) )
	end select

    '' init( argc, argv )
    emit.main.proc = rtlInitRt( argc, argv )

end sub

'':::::
private function hGetTypeString( byval typ as integer ) as string static

	select case as const typ
    case FB_SYMBTYPE_UBYTE, FB_SYMBTYPE_BYTE, FB_SYMBTYPE_CHAR
    	function = ".byte"
    case FB_SYMBTYPE_USHORT, FB_SYMBTYPE_SHORT
    	function = ".short"
    case FB_SYMBTYPE_INTEGER, FB_SYMBTYPE_UINT
    	function = ".int"
    case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
    	function = ".quad"
    case FB_SYMBTYPE_SINGLE
		function = ".float"
	case FB_SYMBTYPE_DOUBLE
    	function = ".double"
	case FB_SYMBTYPE_FIXSTR
    	function = ".ascii"
    case FB_SYMBTYPE_STRING
    	function = ".int"
	case FB_SYMBTYPE_USERDEF
		function = "INVALID"
    case else
    	if( typ >= FB_SYMBTYPE_POINTER ) then
    		function = ".int"
    	end if
	end select

end function

'':::::
private sub hEmitBssHeader( )

    if( emit.bssheader ) then
    	exit sub
    end if

    hCOMMENT( "global non-initialized vars" )
    emitSECTION( EMIT_SECTYPE_BSS )
    hALIGN( 16 )

    emit.bssheader = TRUE

end sub


'':::::
sub emitWriteBss( ) static
    dim as string alloc, ostr
    dim as FBSYMBOL ptr s
    dim as integer alloctype, elements, doemit

    s = symbGetGlobalHead( )
    do while( s <> NULL )

		doemit = FALSE

		'' var?
		if( symbIsVAR( s ) ) then
			'' not initialized?
			if( not symbGetVarInitialized( s ) ) then
				'' not emited already?
				if( not symbGetVarEmited( s ) ) then
    				'' not extern?
    				if( not symbIsExtern( s ) ) then
    	    			'' not a string or array descriptor?
    	    			if( symbGetLen( s ) > 0 ) then
    						'' not dynamic?
    						if( not symbGetIsDynamic( s ) ) then
    							doemit = TRUE
    						end if
    					end if
    				end if
    			end if
    		end if
    	end if

    	if( doemit ) then
    	    alloctype = symbGetAllocType( s )

	    	elements = 1
    	    if( symbGetArrayDimensions( s ) > 0 ) then
    	    	elements = hCalcElements( s )
    	    end if

    	    hEmitBssHeader( )

    	    '' allocation modifier
    	    if( (alloctype and FB_ALLOCTYPE_COMMON) = 0 ) then
    	    	if( (alloctype and FB_ALLOCTYPE_PUBLIC) > 0 ) then
    	    		hPUBLIC( symbGetName( s ) )
				end if
    	    	alloc = ".lcomm"
			else
    	    	hPUBLIC( symbGetName( s ) )
    	    	alloc = ".comm"
    	    end if

    	    '' align
    	    if( symbGetType( s ) = FB_SYMBTYPE_DOUBLE ) then
    	    	hALIGN( 8 )
    	    	hWriteStr( TRUE, ".balign 8" )
    	    else
    	    	hALIGN( 4 )
    	    end if

    	    '' emit
    	    ostr = alloc + "\t" + symbGetName( s ) + "," + str( s->lgt * elements )
    	    hWriteStr( TRUE, ostr )

    	    '' add dbg info
    	    edbgEmitGlobalVar( s, EMIT_SECTYPE_BSS )

    	end if

    	s = s->next
    loop

end sub

'':::::
private sub hEmitConstHeader( )

    if( emit.conheader ) then
    	exit sub
    end if

    hCOMMENT( "global initialized constants" )
	emitSECTION( EMIT_SECTYPE_DATA )
    hALIGN( 16 )

    emit.conheader = TRUE

end sub

'':::::
sub emitWriteConst( ) static
    dim as string stext, stype, ostr
    dim as FBSYMBOL ptr s
    dim as integer dtype, doemit

    s = symbGetGlobalHead( )
    do while( s <> NULL )

    	doemit = FALSE

    	'' var?
    	if( symbIsVAR( s ) ) then
    		'' initialized?
    		if( symbGetVarInitialized( s ) ) then
    	    	dtype = symbGetType( s )
    	    	'' not an udt?
    	    	if( dtype <> FB_SYMBTYPE_USERDEF ) then
					'' not string or array descriptors (fix-len's can be 0-len too)
					if( (symbGetLen( s ) > 0) or (dtype = FB_SYMBTYPE_FIXSTR) ) then
                    	doemit = TRUE
    	    		end if
    	    	end if
    	    end if
		end if

    	if( doemit ) then
    		stype = hGetTypeString( dtype )
    	    if( dtype = FB_SYMBTYPE_FIXSTR ) then
    	    	stext = "\"" + hEscapeStr( s->var.inittext ) + "\\0\""
    	    else
    	    	stext = s->var.inittext
    	    end if

    	    hEmitConstHeader( )

    	    if( dtype = FB_SYMBTYPE_DOUBLE ) then
    	    	hALIGN( 8 )
    	    else
    	    	hALIGN( 4 )
    	    end if

    	    ostr = symbGetName( s ) + ":\t" + stype + "\t" + stext
    	    hWriteStr( FALSE, ostr )

    	    'edbgEmitGlobalVar( s, EMIT_SECTYPE_CONST )

    	end if

    	s = s->next
    loop

end sub

'':::::
private sub hWriteArrayDesc( byval s as FBSYMBOL ptr ) static
	dim as FBVARDIM ptr d
    dim as integer dims, diff, i
    dim as string sname, dname

    '' extern?
    if( symbIsExtern( s ) ) then
    	'' not static? (even if extern, the descriptor will be needed with
    	'' a static array, if it get passed by descriptor to some function)
    	if( symbGetIsDynamic( s ) ) then
    		exit sub
    	end if
    end if

    dims = symbGetArrayDimensions( s )
    diff = symbGetArrayOffset( s )
    if( dims = 0 ) then
    	exit sub
    end if

    if( symbGetIsDynamic( s ) ) then
    	sname = "0"
	else
    	sname = symbGetName( s )
	end if

	dname = symbGetVarDescName( s )

    edbgEmitGlobalVar( s, EMIT_SECTYPE_DATA )

    '' COMMON?
    if( symbIsCommon( s ) ) then
    	if( dims = -1 ) then
    		dims = 1
    	end if

    	hPUBLIC( dname )

    	hALIGN( 4 )
    	hWriteStr( TRUE,  ".comm\t" + dname + "," + _
    			   str( FB_ARRAYDESCSIZE + dims * FB_INTEGERSIZE*2 ) )

    	exit sub
    end if

    '' non COMMON arrays..

    '' public?
    if( symbIsPublic( s ) ) then
    	'' don't make the descriptor global if it's a static array
    	if( symbGetIsDynamic( s ) ) then
    		hPUBLIC( dname )
    	end if
    end if

    hALIGN( 4 )
    hWriteStr( FALSE, dname + ":" )

	''	void		*data 	// ptr + diff
	hWriteStr( TRUE,  ".int\t" + sname + " +" + str( diff ) )
	''	void		*ptr
	hWriteStr( TRUE,  ".int\t" + sname )
	''	uint		size
	hWriteStr( TRUE,  ".int\t" + str( s->lgt * hCalcElements( s ) ) )
	''	uint		element_len
    hWriteStr( TRUE,  ".int\t" + str( s->lgt ) )
	''	uint		dimensions
	if( dims = -1 ) then dims = 1
	hWriteStr( TRUE,  ".int\t" + str( dims ) )

    if( not symbGetIsDynamic( s ) ) then
    	d = symbGetArrayFirstDim( s )
    	do while( d <> NULL )
			''	uint	dim_elemts
			hWriteStr( TRUE,  ".int\t" + str( d->upper - d->lower + 1 ) )
			''	int		dim_first
			hWriteStr( TRUE,  ".int\t" + str( d->lower ) )
            '' next
			d = d->next
    	loop

    else
        for i = 0 to dims-1
			''	uint	dim_elemts
			hWriteStr( TRUE,  ".int\t0"  )
			''	int		dim_first
			hWriteStr( TRUE,  ".int\t0" )
        next i
    end if

end sub

'':::::
private sub hWriteStringDesc( byval s as FBSYMBOL ptr ) static
    dim as string dname

	dname = symbGetVarDescName( s )

    hALIGN( 4 )
    hWriteStr( FALSE, dname + ":" )

	''	void		*data
	hWriteStr( TRUE,  ".int\t" + s->alias )
	''	int			len
	hWriteStr( TRUE,  ".int\t" + str( s->lgt ) )
	''	int			size
	hWriteStr( TRUE,  ".int\t" + str( s->lgt ) )

end sub

'':::::
private sub hEmitDataHeader( )

    if( emit.datheader ) then
    	exit sub
    end if

    hCOMMENT( "global initialized vars" )
    emitSECTION( EMIT_SECTYPE_DATA )
    hALIGN( 16 )

    emit.datheader = TRUE

end sub

'':::::
sub emitWriteData( ) static
    dim as FBSYMBOL ptr s, d

    s = symbGetGlobalHead( )
    do while( s <> NULL )

    	'' var?
    	if( symbIsVAR( s ) ) then
    	    '' with descriptor?
    	    d = symbGetArrayDescriptor( s )
    	    if( d <> NULL ) then
    	    	'' subtype is an array or string descriptor?
    	    	select case d->subtype
    	    	case FB_DESCTYPE_ARRAY
    	    		hEmitDataHeader( )
    	    		hWriteArrayDesc( s )

    	    	case FB_DESCTYPE_STR
    	    		hEmitDataHeader( )
    	    		hWriteStringDesc( s )
    	    	end select
    	    end if
    	end if

    	s = s->next
    loop

end sub

'':::::
private sub hEmitExportHeader( )

    if( emit.expheader ) then
    	exit sub
    end if

    hWriteStr( FALSE, NEWLINE + "#exported functions" )
    emitSECTION( EMIT_SECTYPE_DIRECTIVE )

    emit.expheader = TRUE

end sub

'':::::
sub emitWriteExport( ) static
    dim s as FBSYMBOL ptr
    dim sname as string

    s = symbGetGlobalHead( )
    do while( s <> NULL )

    	if( symbIsPROC( s ) ) then
    		if( symbGetProcIsDeclared( s ) ) then
    			if( symbIsExport( s ) ) then
    				hEmitExportHeader( )
    				sname = hStripUnderscore( symbGetName( s ) )
    				hWriteStr( TRUE, ".ascii \" -export:" + sname + "\"" + NEWLINE )
    			end if
    		end if
    	end if

    	s = s->next
    loop

end sub


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' functions table
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#define EMIT_CBENTRY(op) @_emit##op##

	'' same order as EMIT_NODEOP_ENUM
	dim shared emit_opfTB(0 to EMIT_MAXOPS-1) as any ptr => _
	{ _
		EMIT_CBENTRY(LOADI2I), EMIT_CBENTRY(LOADF2I), EMIT_CBENTRY(LOADL2I), _
		EMIT_CBENTRY(LOADI2F), EMIT_CBENTRY(LOADF2F), EMIT_CBENTRY(LOADL2F), _
		EMIT_CBENTRY(LOADI2L), EMIT_CBENTRY(LOADF2L), EMIT_CBENTRY(LOADL2L), _
        _
		EMIT_CBENTRY(STORI2I), EMIT_CBENTRY(STORF2I), EMIT_CBENTRY(STORL2I), _
		EMIT_CBENTRY(STORI2F), EMIT_CBENTRY(STORF2F), EMIT_CBENTRY(STORL2F), _
		EMIT_CBENTRY(STORI2L), EMIT_CBENTRY(STORF2L), EMIT_CBENTRY(STORL2L), _
        _
		EMIT_CBENTRY(MOVI), EMIT_CBENTRY(MOVF), EMIT_CBENTRY(MOVL), _
		EMIT_CBENTRY(ADDI), EMIT_CBENTRY(ADDF), EMIT_CBENTRY(ADDL), _
		EMIT_CBENTRY(SUBI), EMIT_CBENTRY(SUBF), EMIT_CBENTRY(SUBL), _
		EMIT_CBENTRY(MULI), EMIT_CBENTRY(MULF), EMIT_CBENTRY(MULL), EMIT_CBENTRY(SMULI), _
		EMIT_CBENTRY(DIVI), EMIT_CBENTRY(DIVF), NULL              , _
		EMIT_CBENTRY(MODI), NULL              , NULL              , _
		EMIT_CBENTRY(SHLI), EMIT_CBENTRY(SHLL), _
		EMIT_CBENTRY(SHRI), EMIT_CBENTRY(SHRL), _
		EMIT_CBENTRY(ANDI), EMIT_CBENTRY(ANDL), _
		EMIT_CBENTRY(ORI) , EMIT_CBENTRY(ORL) , _
		EMIT_CBENTRY(XORI), EMIT_CBENTRY(XORL), _
		EMIT_CBENTRY(EQVI), EMIT_CBENTRY(EQVL), _
		EMIT_CBENTRY(IMPI), EMIT_CBENTRY(IMPL), _
		EMIT_CBENTRY(ATN2), _
		EMIT_CBENTRY(POW), _
		EMIT_CBENTRY(ADDROF), _
		EMIT_CBENTRY(DEREF), _
        _
		EMIT_CBENTRY(CGTI), EMIT_CBENTRY(CGTF), EMIT_CBENTRY(CGTL), _
		EMIT_CBENTRY(CLTI), EMIT_CBENTRY(CLTF), EMIT_CBENTRY(CLTL), _
		EMIT_CBENTRY(CEQI), EMIT_CBENTRY(CEQF), EMIT_CBENTRY(CEQL), _
		EMIT_CBENTRY(CNEI), EMIT_CBENTRY(CNEF), EMIT_CBENTRY(CNEL), _
		EMIT_CBENTRY(CGEI), EMIT_CBENTRY(CGEF), EMIT_CBENTRY(CGEL), _
		EMIT_CBENTRY(CLEI), EMIT_CBENTRY(CLEF), EMIT_CBENTRY(CLEL), _
        _
		EMIT_CBENTRY(NEGI), EMIT_CBENTRY(NEGF), EMIT_CBENTRY(NEGL), _
		EMIT_CBENTRY(NOTI), EMIT_CBENTRY(NOTL), _
		EMIT_CBENTRY(ABSI), EMIT_CBENTRY(ABSF), EMIT_CBENTRY(ABSL), _
		EMIT_CBENTRY(SGNI), EMIT_CBENTRY(SGNF), EMIT_CBENTRY(SGNL), _
        _
		EMIT_CBENTRY(SIN), EMIT_CBENTRY(ASIN), _
		EMIT_CBENTRY(COS), EMIT_CBENTRY(ACOS), _
		EMIT_CBENTRY(TAN), EMIT_CBENTRY(ATAN), _
		EMIT_CBENTRY(SQRT), _
		EMIT_CBENTRY(LOG), _
		EMIT_CBENTRY(FLOOR), _
		EMIT_CBENTRY(XCHGTOS), _
        _
		EMIT_CBENTRY(ALIGN), _
		EMIT_CBENTRY(STKALIGN), _
        _
		EMIT_CBENTRY(PUSHI), EMIT_CBENTRY(PUSHF), EMIT_CBENTRY(PUSHL), _
		EMIT_CBENTRY(POPI), EMIT_CBENTRY(POPF), EMIT_CBENTRY(POPL), _
		EMIT_CBENTRY(PUSHUDT), _
        _
		EMIT_CBENTRY(CALL), _
		EMIT_CBENTRY(CALLPTR), _
		EMIT_CBENTRY(BRANCH), _
		EMIT_CBENTRY(JUMP), _
		EMIT_CBENTRY(JUMPPTR), _
		EMIT_CBENTRY(RET), _
        _
		EMIT_CBENTRY(LABEL), _
		EMIT_CBENTRY(PUBLIC), _
		EMIT_CBENTRY(LIT), _
		EMIT_CBENTRY(JMPTB), _
        _
		EMIT_CBENTRY(MEMMOVE), _
		EMIT_CBENTRY(MEMSWAP), _
		EMIT_CBENTRY(MEMCLEAR) _
	}

