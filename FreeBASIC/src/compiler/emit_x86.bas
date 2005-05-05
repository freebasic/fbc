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

'$include once:'inc\fb.bi'
'$include once:'inc\fbint.bi'
'$include once:'inc\reg.bi'
'$include once:'inc\ir.bi'
'$include once:'inc\rtl.bi'
'$include once:'inc\emit.bi'
'$include once:'inc\emitdbg.bi'
'$include once:'inc\hash.bi'

type EMITCTX
	inited			as integer

	outf			as integer
	pos				as integer

	procstksetup 	as integer
	procstkcleanup 	as integer

	dataend			as integer

	localptr		as integer
	argptr			as integer

	keyinited		as integer
	keyhash			as THASH

    '' header flags, TRUE= emited already
    bssheader		as integer
    conheader		as integer
    datheader		as integer
    expheader       as integer
end type

type EMITDATATYPE
	class			as integer
	size			as integer
	rnametb			as integer
	mname			as string
end type

''
const TABCHAR = "\t"
const NEWLINE = "\r\n"
const QUOTE   = "\""
const COMMA   = ", "


const EMIT.MAXRNAMES  = 8
const EMIT.MAXRTABLES = 4


''
declare sub 		outp				( byval s as string )

declare sub 		hSaveAsmHeader		( )

declare function 	hGetTypeString		( byval typ as integer ) as string

declare sub 		hPrepOperand		( byval oname as string, _
										  byval ofs as integer, _
										  byval dtype as integer, _
										  byval typ as integer, _
										  operand as string )
declare function 	hGetOfs				( byval ofs as integer ) as string


''
''globals
	dim shared ctx as EMITCTX
	dim shared regTB(0 to EMIT.REGCLASSES-1) as REGCLASS ptr
	dim shared dtypeTB(0 to IR.MAXDATATYPES-1) as EMITDATATYPE
	dim shared rnameTB(0 to EMIT.MAXRTABLES-1, 0 to EMIT.MAXRNAMES-1) as string

''
regnametbdata:
data "dl","di","si","cl","bl","al","",""
data "dx","di","si","cx","bx","ax","",""
data "edx","edi","esi","ecx","ebx","eax","",""
data "st(0)","st(1)","st(2)","st(3)","st(4)","st(5)","st(6)","st(7)"

'' class, size, regnametb, mov's ptr name, init name
datatypedata:
data IR.DATACLASS.INTEGER, 0 			 , 0, "void ptr"
data IR.DATACLASS.INTEGER, 1			 , 0, "byte ptr"
data IR.DATACLASS.INTEGER, 1			 , 0, "byte ptr"
data IR.DATACLASS.INTEGER, 1             , 0, "byte ptr"
data IR.DATACLASS.INTEGER, 2             , 1, "word ptr"
data IR.DATACLASS.INTEGER, 2             , 1, "word ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 2, "dword ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 2, "dword ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2, 2, "qword ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2, 2, "qword ptr"
data IR.DATACLASS.FPOINT , 4			 , 3, "dword ptr"
data IR.DATACLASS.FPOINT , 8			 , 3, "qword ptr"
data IR.DATACLASS.STRING , 8             , 0, ""
data IR.DATACLASS.STRING , 1             , 0, "byte ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 0, "dword ptr"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 0, "dword ptr"
data IR.DATACLASS.INTEGER, 1			 , 0, "byte ptr"

'' class,reg,name
regdata:
data IR.DATACLASS.INTEGER, EMIT.INTREG.EDX
data IR.DATACLASS.INTEGER, EMIT.INTREG.EDI
data IR.DATACLASS.INTEGER, EMIT.INTREG.ESI
data IR.DATACLASS.INTEGER, EMIT.INTREG.ECX
data IR.DATACLASS.INTEGER, EMIT.INTREG.EBX
data IR.DATACLASS.INTEGER, EMIT.INTREG.EAX
data IR.DATACLASS.FPOINT, 0: 'st(0)
data IR.DATACLASS.FPOINT, 1: 'st(1)
data IR.DATACLASS.FPOINT, 2: 'st(2)
data IR.DATACLASS.FPOINT, 3: 'st(3)
data IR.DATACLASS.FPOINT, 4: 'st(4)
data IR.DATACLASS.FPOINT, 5: 'st(5)
data IR.DATACLASS.FPOINT, 6: 'st(6)
'''' IR.DATACLASS.FPOINT, 7: 'st(7)			'' STORE/LOAD/POW/.. need a free reg to work
data -1

''
keywordata:
data "ebp", "esp", "st", "cs", "ds", "es", "fs", "gs", "ss"
data "mm0", "mm1", "mm2", "mm3", "mm4", "mm5", "mm6", "mm7"
data "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7"
data "byte", "word", "dword", "qword"
data "ptr", "offset"
''
'' IA-32 instruction set, including MMX/SSE/SSE2
''
data "aaa", "aad", "aam", "aas", "adc", "add", "addpd", "addps", "addsd", "addss", "and", "andpd", "andps"
data "andnpd", "andnps", "arpl", "bound", "bsf", "bsr", "bswap", "bt", "btc", "btr", "bts", "call", "cbw"
data "cwde", "cdq", "clc", "cld", "clflush", "cli", "clts", "cmc", "cmova", "cmovae", "cmovb", "cmovbe"
data "cmovc", "cmove", "cmovg", "cmovge", "cmovl", "cmovle", "cmovna", "cmovnae", "cmovnb", "cmovnbe"
data "cmovnc", "cmovne", "cmovng", "cmovnge", "cmovnl", "cmovnle", "cmovno", "cmovnp", "cmovns", "cmovnz"
data "cmovo", "cmovp", "cmovpe", "cmovpe", "cmovpo", "cmovs", "cmovz", "cmp", "cmppd", "cmpps", "cmps"
data "cmpsb", "cmpsw", "cmpsd", "cmpss", "cmpxchg", "cmpxchg8b", "comisd", "comiss", "cpuid", "cvtdq2pd"
data "cvtdq2ps", "cvtpd2dq", "cvtpd2pi", "cvtpd2ps", "cvtpi2pd", "cvtpi2ps", "cvtps2dq", "cvtps2pd"
data "cvtps2pi", "cvtsd2si", "cvtsd2ss", "cvtsi2sd", "cvtsi2ss", "cvtss2sd", "cvtss2si", "cvttpd2pi"
data "cvttpd2dq", "cvttps2dq", "cvttps2pi", "cvttsd2si", "cvttss2si", "cwd", "daa", "das", "dec", "div"
data "divpd", "divps", "divss", "emms", "enter", "f2xm1", "fabs", "fadd", "faddp", "fiadd", "fbld"
data "fbstp", "fchs", "fclex", "fnclex", "fcmovb", "fcmove", "fcmovbe", "fcmovu", "fcmovnb", "fcmovne"
data "fcmovnbe", "fcmovnu", "fcom", "fcomp", "fcompp", "fcomi", "fcomip", "fucomi", "fucomip", "fcos"
data "fdecstp", "fdiv", "fdivp", "fidiv", "fdivr", "fdivrp", "fidivr", "ffree", "ficom", "ficomp"
data "fild", "fincstp", "finit", "fninit", "fist", "fistp", "fld", "fld1", "fldl2t", "fldl2e", "fldpi"
data "fldlg2", "fldln2", "fldz", "fldcw", "fldenv", "fmul", "fmulp", "fimul", "fnop", "fpatan", "fprem"
data "fprem1", "fptan", "frndint", "frstor", "fsave", "fnsave", "fscale", "fsin", "fsincos", "fsqrt"
data "fst", "fstp", "fstcw", "fnstcw", "fstenv", "fnstenv", "fstsw", "fnstsw", "fsub", "fsubp", "fisub"
data "fsubr", "fsubrp", "fisubr", "ftst", "fucom", "fucomp", "fucompp", "fwait", "fxam", "fxch", "fxrstor"
data "fxsave", "fxtract", "fyl2x", "fyl2xp1", "hlt", "idiv", "imul", "in", "inc", "ins", "insb", "insw"
data "insd", "int", "into", "invd", "invlpg", "iret", "iretd", "ja", "jae", "jb", "jbe", "jc", "jcxz"
data "jecxz", "je", "jg", "jge", "jl", "jle", "jna", "jnae", "jnb", "jnbe", "jnc", "jne", "jng", "jnge"
data "jnl", "jnle", "jno", "jnp", "jns", "jnz", "jo", "jp", "jpe", "jpo", "js", "jz", "jmp", "lahf", "lar"
data "ldmxcsr", "lds", "les", "lfs", "lgs", "lss", "lea", "leave", "lfence", "lgdt", "lidt", "lldt", "lmsw"
data "lock", "lods", "lodsb", "lodsw", "lodsd", "loop", "loope", "loopz", "loopne", "loopnz", "lsl", "ltr"
data "maskmovdqu", "maskmovq", "maxpd", "maxps", "maxsd", "maxss", "mfence", "minpd", "minps", "minsd"
data "minss", "mov", "movapd", "movaps", "movd", "movdqa", "movdqu", "movdq2q", "movhlps", "movhpd"
data "movhps", "movlhps", "movlpd", "movlps", "movmskpd", "movmskps", "movntdq", "movnti", "movntpd"
data "movntps", "movntq", "movq", "movq2dq", "movs", "movsb", "movsw", "movsd", "movss", "movsx", "movupd"
data "movups", "movzx", "mul", "mulpd", "mulps", "mulsd", "mulss", "neg", "nop", "not", "or", "orpd"
data "orps", "out", "outs", "outsb", "outsw", "outsd", "packsswb", "packssdw", "packuswb", "paddb"
data "paddw", "paddd", "paddq", "paddsb", "paddsw", "paddusb", "paddusw", "pand", "pandn", "pause"
data "pavgb", "pavgw", "pcmpeqb", "pcmpeqw", "pcmpeqd", "pcmpgtb", "pcmpgtw", "pcmpgtd", "pextrw"
data "pinsrw", "pmaddwd", "pmaxsw", "pmaxub", "pminsw", "pminub", "pmovmskb", "pmulhuv", "pmulhw"
data "pmullw", "pmuludq", "pop", "popa", "popad", "popf", "popfd", "por", "prefetcht0", "prefetcht1"
data "prefetcht2", "prefetchnta", "psadbw", "pshufd", "pshufhw", "pshuflw", "pshufw", "psllw", "pslld"
data "psllq", "psraw", "psrad", "psrldq", "psrlw", "psrld", "psrlq", "psubb", "psubw", "psubd", "psubq"
data "psubsb", "psubsw", "psubusb", "psubusw", "punpckhbw", "punpckhwd", "punpckhdq", "punpckhqdq"
data "punpcklbw", "punpcklwd", "punpckldq", "punpcklqdq", "push", "pusha", "pushad", "pushf", "pushfd"
data "pxor", "rcl", "rcr", "rol", "ror", "rcpps", "rcpss", "rdmsr", "rdpmc", "rdtsc", "rep", "repe"
data "repz", "repne", "repnz", "ret", "rsm", "rsqrtps", "rsqrtss", "sahf", "sal", "sar", "shl", "shr"
data "sbb", "scas", "scasb", "scasw", "scasd", "seta", "setae", "setb", "setbe", "setc", "sete", "setg"
data "setge", "setl", "setle", "setna", "setnae", "setnb", "setnbe", "setnc", "setne", "setng", "setnge"
data "setnl", "setnle", "setno", "setnp", "setns", "setnz", "seto", "setp", "setpe", "setpo", "sets"
data "setz", "sfence", "sgdt", "sidt", "shld", "shrd", "shufpd", "shufps", "sldt", "smsw", "sqrtpd"
data "sqrtps", "sqrtsd", "sqrtss", "stc", "std", "sti", "stmxcsr", "stos", "stosb", "stosw", "stosd"
data "str", "sub", "subpd", "subps", "subsd", "subss", "sysenter", "sysexit", "test", "ucomisd"
data "ucomiss", "ud2", "unpckhpd", "unpckhps", "unpcklpd", "unpcklps", "verr", "verw", "wait", "wbinvd"
data "wrmsr", "xadd", "xchg", "xlat", "xlatb", "xor", "xorpd", "xorps"
''
'' AMD x86 additions, including 3DNow!/Ext.3DNow!
''
data "pavgusb", "pfadd", "pfsub", "pfsubr", "pfacc", "pfcmpge", "pfcmpgt", "pfcmpeq", "pfmin", "pfmax"
data "pi2fw", "pi2fd", "pf2iw", "pf2id", "pfrcp", "pfrsqrt", "pfmul", "pfrcpit1", "pfrsqit1", "pfrcpit2"
data "pmulhrw", "pswapw", "femms", "prefetch", "prefetchw", "pfnacc", "pfpnacc", "pswapd", "pmulhuw"
data ""


const EMIT_MAXKEYWORDS = 512

'':::::
private sub hInitKeywordsTB
    dim t as integer, i as integer, idx as uinteger
    dim keyword as string

	hashNew( @ctx.keyhash, EMIT_MAXKEYWORDS )

	'' add reg names
	restore regnametbdata
	for t = 0 to EMIT.MAXRTABLES-1
		for i = 0 to EMIT.MAXRNAMES-2
			read keyword
			if( len( keyword ) > 0 ) then
				hashAdd( @ctx.keyhash, keyword, @idx, idx )
			end if
		next i
	next t

	'' add asm keywords
	restore keywordata
	do
		read keyword
		if( len( keyword ) = 0 ) then
			exit do
		end if

		hashAdd( @ctx.keyhash, keyword, @idx, idx )
	loop

	ctx.keyinited = TRUE

end sub

'':::::
private sub hEndKeywordsTB

	if( ctx.keyinited ) then
		hashFree( @ctx.keyhash )
	end if

	ctx.keyinited = FALSE

end sub

'':::::
private sub hInitRegTB
	dim class as integer, lclass as integer
	dim reg as integer, regs as integer

	''
	restore regdata
	lclass = -1
	regs = 0
	do
		read class

		if( lclass <> class ) then
			if( lclass <> -1 ) then
				regTB(lclass) = regNewClass( lclass, regs, lclass = IR.DATACLASS.FPOINT )
			end if
			regs = 0
			lclass = class
		end if

		if( class = -1 ) then
			exit do
		end if

		read reg
		regs += 1
	loop

end sub

'':::::
private sub hEndRegTB
    dim i as integer

	for i = 0 to EMIT.REGCLASSES-1
		regDelClass regTB(i)
	next i

end sub

'':::::
sub emitInit
	dim i as integer, t as integer

	if( ctx.inited ) then
		exit sub
	end if

	''
	restore datatypedata
	for i = 0 to IR.MAXDATATYPES-1
		read dtypeTB(i).class
		read dtypeTB(i).size
		read dtypeTB(i).rnametb
		read dtypeTB(i).mname
	next i

	''
	restore regnametbdata
	for t = 0 to EMIT.MAXRTABLES-1
		for i = 0 to EMIT.MAXRNAMES-1
			read rnameTB(t, i)
		next i
	next t

	''
	hInitRegTB

	''
	ctx.keyinited 	= FALSE

	''
	ctx.inited 		= TRUE
	ctx.dataend 	= 0
	ctx.pos			= 0

	ctx.bssheader	= FALSE
	ctx.conheader	= FALSE
	ctx.datheader	= FALSE
	ctx.expheader	= FALSE

end sub

'':::::
sub emitEnd

	if( not ctx.inited ) then
		exit sub
	end if

	''
	hEndRegTB

    hEndKeywordsTB

	ctx.inited = FALSE

end sub

'':::::
function emitGetRegClass( byval dclass as integer ) as REGCLASS ptr

	function = regTB(dclass)

end function

'':::::
sub emitGetRegName( byval dtype as integer, _
					byval dclass as integer, _
					byval reg as integer, _
					rname as string ) static
    dim t as integer

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	if( reg = INVALID ) then
		rname = ""
	else
		t = dtypeTB(dtype).rnametb

		'' with fp, reg isn't the real reg num
		if( dclass = IR.DATACLASS.FPOINT ) then
			reg = regTB(dclass)->getRealReg( regTB(dclass), reg )
		end if

		rname = rnameTB(t, reg)
	end if

end sub

'':::::
sub emitGetIDXName( byval mult as integer, _
					sname as string, _
					idxname as string ) static
    dim tstr as string
    dim addone as integer

	if( mult > 1 ) then

		addone = FALSE
		select case mult
		case 3, 5, 9
			mult -= 1
			addone = TRUE
		end select

		tstr = "*" + str$( mult )

		if( addone ) then
			tstr += "+" + idxname
		end if

		idxname += tstr

	end if

	if( len( sname ) > 0 ) then
		tstr = sname + "+" + idxname
		idxname = tstr
	end if

end sub

'':::::
function emitGetVarName( byval s as FBSYMBOL ptr ) as string static
	dim sname as string

	if( s <> NULL ) then
		sname = symbGetName( s ) + hGetOfs( s->ofs )
		function = sname
	else
		function = ""
	end if

end function

'':::::
function emitIsRegPreserved ( byval dtype as integer, _
							  byval dclass as integer, _
							  byval reg as integer ) as integer static

    if( dtype >= IR.DATATYPE.POINTER ) then
    	dtype = IR.DATATYPE.UINT
    end if

    '' fp? fpu stack *must* be cleared before calling any function
    if( dclass = IR.DATACLASS.FPOINT ) then
    	return FALSE
    end if

    select case as const reg
    case EMIT.INTREG.EAX, EMIT.INTREG.ECX, EMIT.INTREG.EDX
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

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	if( dclass = IR.DATACLASS.INTEGER ) then
		r1 = EMIT.INTREG.EAX
		if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
			r2 = EMIT.INTREG.EDX
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

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = INVALID

	'' fp? no other regs can be used
	if( dclass = IR.DATACLASS.FPOINT ) then
		exit function
	end if

	'' try to reuse regs that are preserved between calls
	if( regTB(dclass)->isFree( regTB(dclass), EMIT.INTREG.EBX ) ) then
		function = EMIT.INTREG.EBX

	elseif( regTB(dclass)->isFree( regTB(dclass), EMIT.INTREG.ESI ) ) then
		function = EMIT.INTREG.ESI

	elseif( regTB(dclass)->isFree( regTB(dclass), EMIT.INTREG.EDI ) ) then
		function = EMIT.INTREG.EDI
	end if

end function

'':::::
function emitFindRegNotInVreg( byval vreg as IRVREG ptr, _
							   byval noSIDI as integer = FALSE ) as integer static

    dim as integer r, reg, reg2, dclass

	function = INVALID

	reg = INVALID

	select case vreg->typ
	case IR.VREGTYPE.REG
		reg = vreg->reg

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		if( vreg->vidx <> NULL ) then
			if( vreg->vidx->typ = IR.VREGTYPE.REG ) then
				reg = vreg->vidx->reg
			end if
		end if
	end select

	'' longint..
	reg2 = INVALID
	if( vreg->vaux <> NULL ) then
		if( vreg->vaux->typ = IR.VREGTYPE.REG ) then
			reg2 = vreg->vaux->reg
		end if
	end if

	dclass = irGetDataClass( vreg->dtype )

	''
	if( reg2 = INVALID ) then

		if( not noSIDI ) then

			for r = regTB(dclass)->getMaxRegs( regTB(dclass) )-1 to 0 step -1
				if( r <> reg ) then
					function = r
					if( regTB(dclass)->isFree( regTB(dclass), r ) ) then
						exit function
					end if
				end if
			next r

		'' SI/DI as byte..
		else

			for r = regTB(dclass)->getMaxRegs( regTB(dclass) )-1 to 0 step -1
				if( r <> reg ) then
					if( r <> EMIT.INTREG.ESI ) then
						if( r <> EMIT.INTREG.EDI ) then
							function = r
							if( regTB(dclass)->isFree( regTB(dclass), r ) ) then
							exit function
							end if
						end if
					end if
				end if
			next r

		end if

	'' longints..
	else

		if( not noSIDI ) then

			for r = regTB(dclass)->getMaxRegs( regTB(dclass) )-1 to 0 step -1
				if( (r <> reg) and (r <> reg2) ) then
					function = r
					if( regTB(dclass)->isFree( regTB(dclass), r ) ) then
						exit function
					end if
				end if
			next r

		'' SI/DI as byte..
		else

			for r = regTB(dclass)->getMaxRegs( regTB(dclass) )-1 to 0 step -1
				if( (r <> reg) and (r <> reg2) ) then
					if( r <> EMIT.INTREG.ESI ) then
						if( r <> EMIT.INTREG.EDI ) then
							function = r
							if( regTB(dclass)->isFree( regTB(dclass), r ) ) then
								exit function
							end if
						end if
					end if
				end if
			next r

		end if

	end if

end function

'':::::
function emitFindFreeReg( byval dclass as integer ) as integer static
    dim as integer r

	function = INVALID

	for r = regTB(dclass)->getMaxRegs( regTB(dclass) )-1 to 0 step -1
		function = r
		if( regTB(dclass)->isFree( regTB(dclass), r ) ) then
			exit function
		end if
	next r

end function

'':::::
function emitIsRegInVreg( byval vreg as IRVREG ptr, _
						  byval reg as integer ) as integer static

	function = FALSE

	select case vreg->typ
	case IR.VREGTYPE.REG
		if( vreg->reg = reg ) then
			return TRUE
		end if

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		if( vreg->vidx <> NULL ) then
			if( vreg->vidx->typ = IR.VREGTYPE.REG ) then
				if( vreg->vidx->reg = reg ) then
					return TRUE
				end if
			end if
		end if
	end select

	'' longints..
	if( vreg->vaux <> NULL ) then
		if( vreg->vaux->typ = IR.VREGTYPE.REG ) then
			if( vreg->vaux->reg = reg ) then
				return TRUE
			end if
		end if
	end if

end function

'':::::
private sub outEx( byval s as string, _
				   byval updpos as integer ) static

	if( put( #ctx.outf, , s ) = 0 ) then
		if( updpos ) then
			ctx.pos += 1
		end if
	end if

end sub

'':::::
private sub outp( byval s as string ) static
    dim p as integer
    dim ostr as string

	if( env.clopt.debug ) then
		p = instr( s, " " )
		if( p > 0 ) then
			s[p-1] = CHAR_TAB			'' unsafe with constants..
		end if

		ostr = TABCHAR + s + NEWLINE
		outEX( ostr, TRUE )

	else

		ostr = s + NEWLINE
		outEX( ostr, TRUE )

	end if

end sub

'':::::
private sub hPrepOperand( byval oname as string, _
						  byval ofs as integer, _
						  byval dtype as integer, _
						  byval typ as integer, _
						  operand as string ) static

	select case as const typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.IDX, IR.VREGTYPE.PTR, IR.VREGTYPE.TMPVAR
		operand = dtypeTB(dtype).mname
		operand += " ["
		operand += oname
		if( ofs > 0 ) then
			operand += "+"
			operand += str$( ofs )
		elseif( ofs < 0 ) then
			operand += str$( ofs )
		end if
		operand += "]"

	case IR.VREGTYPE.OFS
		operand = "offset "
		operand += oname

	case else
		operand = oname
	end select

end sub

'':::::
private sub hPrepOperand64( byval oname as string, _
							byval vreg as IRVREG ptr, _
							operand1 as string, _
							operand2 as string ) static

	select case as const vreg->typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.IDX, IR.VREGTYPE.PTR, IR.VREGTYPE.TMPVAR
		hPrepOperand( oname, vreg->ofs               , IR.DATATYPE.UINT   , vreg->typ, operand1 )
		hPrepOperand( oname, vreg->ofs+FB.INTEGERSIZE, IR.DATATYPE.INTEGER, vreg->typ, operand2 )

	case IR.VREGTYPE.REG
		operand1 = oname
		emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, vreg->vaux->reg, operand2 )

	case IR.VREGTYPE.IMM
		operand1 = oname
		operand2 = str$( vreg->vaux->value )
	end select

end sub


'':::::
private function hGetOfs( byval ofs as integer ) as string static

	if( ofs > 0 ) then
		function = "+" + str$( ofs )
	elseif( ofs < 0 ) then
		function = str$( ofs )
	else
		function = ""
	end if

end function

'':::::
function emitIsKeyword( byval text as string ) as integer static

	if( not ctx.keyinited ) then
		hInitKeywordsTB( )
	end if

	if( hashLookup( @ctx.keyhash, text ) <> NULL ) then
		function = TRUE
	else
		function = FALSE
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitGetPos as integer static

	function = ctx.pos

end function

'':::::
sub emitCOMMENT( byval s as string ) static
    dim ostr as string

    ostr = "\t\35" + s + NEWLINE
	outEX( ostr, FALSE )

end sub

'':::::
sub emitASM( byval s as string ) static
    dim ostr as string

    ostr = "\t" + s + NEWLINE
	outEX( ostr, TRUE )

end sub

'':::::
sub emitALIGN( byval bytes as integer ) static
    dim ostr as string

    ostr = ".balign " + str$( bytes )
	outp( ostr )

end sub

'':::::
sub emitSTACKALIGN( byval bytes as integer ) static
    dim ostr as string

    if( bytes > 0 ) then
    	ostr = "sub esp, " + str$( bytes )
    else
    	ostr = "add esp, " + str$( -bytes )
    end if

	outp( ostr )

end sub

'':::::
sub emitTYPE( byval typ as integer, _
			  byval text as string ) static

	outp( hGetTypeString( typ ) + " " + text )

end sub

'':::::
sub emitCALL( byval pname as string, _
			  byval bytestopop as integer ) static
    dim ostr as string

	ostr = "call " + pname
	outp( ostr )

    if( bytestopop <> 0 ) then
    	ostr = "add esp, " + str$( bytestopop )
    	outp( ostr )
    end if

end sub

'':::::
sub emitCALLPTR( byval sname as string, _
				 byval svreg as IRVREG ptr, _
				 byval bytestopop as integer ) static
    dim src as string
    dim ostr as string

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "call " + src
	outp( ostr )

    if( bytestopop <> 0 ) then
    	ostr = "add esp, " + str$( bytestopop )
    	outp( ostr )
    end if

end sub

'':::::
sub emitBRANCH( byval op as integer, _
		 		byval label as string ) static
    dim ostr as string

	select case as const op
	case IR.OP.JLE
		ostr = "jle "
	case IR.OP.JGE
		ostr = "jge "
	case IR.OP.JLT
		ostr = "jl "
	case IR.OP.JGT
		ostr = "jg "
	case IR.OP.JEQ
		ostr = "je "
	case IR.OP.JNE
		ostr = "jne "
	end select

	ostr += label
	outp( ostr )

end sub


'':::::
sub emitBRANCHPTR( byval sname as string, _
				   byval svreg as IRVREG ptr ) static
    dim src as string
    dim ostr as string

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "jmp " + src
	outp( ostr )

end sub

'':::::
sub emitPUBLIC( byval label as string ) static
    dim ostr as string

	ostr = "\r\n.globl " + label + NEWLINE
	outEx( ostr, FALSE )

end sub

'':::::
sub emitLABEL( byval label as string ) static
    dim ostr as string

	ostr = label + ":\r\n"
	outEx( ostr, FALSE )

end sub

'':::::
sub emitJMP( byval label as string ) static
    dim ostr as string

	ostr = "jmp " + label
	outp( ostr )

end sub

'':::::
sub emitRET( byval bytestopop as integer ) static
    dim ostr as string

    ostr = "ret " + str$( bytestopop )
    outp( ostr )

end sub

'':::::
private sub emithBRANCH( byval mnemonic as string, _
		 		 		 byval label as string ) static
    dim ostr as string

	ostr = mnemonic + " " + label
	outp( ostr )

end sub

'':::::
sub emithPUSH( byval rname as string ) static
    dim ostr as string

	ostr = "push " + rname
	outp( ostr )

end sub

'':::::
sub emithPOP( byval rname as string ) static
    dim ostr as string

    ostr = "pop " + rname
	outp( ostr )

end sub

'':::::
sub emithMOV( byval dname as string, _
			  byval sname as string ) static
    dim ostr as string

	ostr = "mov " + dname + ", " + sname
	outp( ostr )

end sub

'':::::
sub emithXCHG( byval dname as string, _
			   byval sname as string ) static
    dim ostr as string

	ostr = "xchg " + dname + ", " + sname
	outp( ostr )

end sub

'':::::
sub emitFXCHG( byval dname as string, byval svreg as IRVREG ptr ) static
    dim ostr as string

	ostr = "fxch " + dname
	outp( ostr )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' load & store
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitMOV64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "mov " + dst1 + COMMA + src1
	outp ostr

	ostr = "mov " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitMOV( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( dvreg->dtype = IR.DATATYPE.LONGINT or dvreg->dtype = IR.DATATYPE.ULONGINT ) then
		emitMOV64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		ostr = "mov " + dst + COMMA + src
		outp ostr
	end if

end sub

'':::::
sub emitSTORETOINT64 ( byval dname as string, _
					   byval dvreg as IRVREG ptr, _
			           byval sname as string, _
			           byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string, ext as string
    dim ostr as string
    dim sdsize as integer

	sdsize = irGetDataSize( svreg->dtype )

	hPrepOperand64( dname, dvreg, dst1, dst2 )

    '' dst size = src size
	if( sdsize = FB.INTEGERSIZE*2 ) then

		hPrepOperand64( sname, svreg, src1, src2 )

		ostr = "mov " + dst1 + COMMA + src1
		outp ostr

		ostr = "mov " + dst2 + COMMA + src2
		outp ostr

		exit sub
	end if

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src1 )

	'' immediate?
	if( svreg->typ = IR.VREGTYPE.IMM ) then
		emithMOV dst1, src1

		if( valint( src1 ) < -1 ) then
			emithMOV dst2, "-1"
		else
			emithMOV dst2, "0"
		end if

		exit sub
	end if

	''
	if( sdsize < FB.INTEGERSIZE ) then
		emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, svreg->reg, ext )

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

		emithPUSH ext

		ostr = "sar " + ext + ", 31"
		outp ostr

		ostr = "mov " + dst2 + COMMA + ext
		outp ostr

		emithPOP ext

	else
		ostr = "mov " + dst2 + ", 0"
		outp ostr
	end if

end sub

'':::::
sub emitSTORE2INT ( byval dname as string, _
					byval dvreg as IRVREG ptr, _
					byval ddclass as integer, _
			        byval sname as string, _
			        byval svreg as IRVREG ptr, _
			        byval sdclass as integer ) static
    dim as string dst, src, aux, aux8, aux16
    dim as integer ddsize, sdsize, reg, isfree
    dim as string ostr

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ddsize = irGetDataSize( dvreg->dtype )
	sdsize = irGetDataSize( svreg->dtype )

	'' fpoint source
	if( sdclass = IR.DATACLASS.FPOINT ) then

		'' byte destine? damn..
		if( ddsize = 1 ) then

			outp "sub esp, 4"
			outp "fistp dword ptr [esp]"

            '' destine is a reg?
            if( dvreg->typ = IR.VREGTYPE.REG ) then

            	'' handle DI/SI as destine
            	if( (dvreg->reg = EMIT.INTREG.ESI) or (dvreg->reg = EMIT.INTREG.EDI) ) then

            		if( irIsSigned( dvreg->dtype ) ) then
	            		ostr = "movsx "
            		else
            			ostr = "movzx "
            		end if
            		ostr += dst + ", byte ptr [esp]"
            		outp ostr

            	else
            		emithMOV dst, "byte ptr [esp]"
            	end if

            	outp "add esp, 4"

			'' destine is a var/idx/ptr
			else

				reg = emitFindRegNotInVreg( dvreg, TRUE )

				emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg, aux8 )
				emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, aux )

				isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

				if( not isfree ) then
					emithXCHG aux, "dword ptr [esp]"
				else
					emithMOV aux8, "byte ptr [esp]"
				end if

				emithMOV dst, aux8

				if( not isfree ) then
					emithPOP aux
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

				select case ddsize
				'' ulongint? handled by AST already
				case FB.INTEGERSIZE*2
                	hReportError FB.ERRMSG.INTERNAL
				'' uint..
				case FB.INTEGERSIZE
					outp "sub esp, 8"
					outp "fistp qword ptr [esp]"
					emithPOP dst
					outp  "add esp, 4"

				'' ushort..
				case else
					outp "sub esp, 4"
					outp "fistp dword ptr [esp]"
					emithPOP dst
					outp  "add esp, 2"
				end select

			end if
		end if

	'' integer source
	else

		if( ddsize = FB.INTEGERSIZE*2 ) then
			emitSTORETOINT64 dname, dvreg, sname, svreg
			exit sub
		end if

		if( ddsize = 1 ) then
			if( svreg->typ = IR.VREGTYPE.IMM ) then
				ddsize = 4
			end if
		end if

		'' dst size = src size
		if( (svreg->typ = IR.VREGTYPE.IMM) or _
			(dvreg->dtype = svreg->dtype) or _
			(irMaxDataType( dvreg->dtype, svreg->dtype ) = INVALID) ) then

			'' handle SI/DI as byte
			if( ddsize = 1 ) then
				if( (svreg->reg = EMIT.INTREG.ESI) or (svreg->reg = EMIT.INTREG.EDI) ) then
					emitGetRegName( dvreg->dtype, ddclass, svreg->reg, aux )
					goto storeSIDI
				end if
			end if

			ostr = "mov " + dst + COMMA + src
			outp ostr

		'' sizes are different..
		else

			emitGetRegName( dvreg->dtype, ddclass, svreg->reg, aux )

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
					((svreg->reg = EMIT.INTREG.ESI) or (svreg->reg = EMIT.INTREG.EDI)) ) then

storeSIDI:			reg = emitFindRegNotInVreg( dvreg, TRUE )

					emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg, aux8 )
					emitGetRegName( IR.DATATYPE.SHORT, IR.DATACLASS.INTEGER, reg, aux16 )

					isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

					if( not isfree ) then
						emithPUSH aux16
					end if

					emithMOV aux16, aux

            		'' handle DI/SI as destine
            		if( (dvreg->typ = IR.VREGTYPE.REG) and _
            			((dvreg->reg = EMIT.INTREG.ESI) or (dvreg->reg = EMIT.INTREG.EDI)) ) then
						if( irIsSigned( dvreg->dtype ) ) then
							ostr = "movsx "
						else
							ostr = "movzx "
						end if
						ostr += dst + COMMA + aux8
						outp ostr
					else
						emithMOV dst, aux8
					end if

					if( not isfree ) then
						emithPOP aux16
					end if

				else
					ostr = "mov " + dst + COMMA + aux
					outp ostr
				end if
			end if
		end if
	end if

end sub

'':::::
private sub emithULONG2DBL( byval sname as string, _
			        	    byval svreg as IRVREG ptr ) static
	dim as string label, ostr

	label = *hMakeTmpStr( )

	ostr = "cmp dword ptr [" +  sname + hGetOfs( svreg->ofs + 4 ) + "], 0"
	outp ostr
	ostr = "jns " + label
	outp ostr
	emithPUSH "16447
	emithPUSH "-2147483648"
	emithPUSH "0"
	outp "fldt [esp]"
	outp "add esp, 12"
	outp "faddp"
	emitLABEL label

end sub

'':::::
sub emitSTORE2FLT ( byval dname as string, _
					byval dvreg as IRVREG ptr, _
					byval ddclass as integer, _
			        byval sname as string, _
			        byval svreg as IRVREG ptr, _
			        byval sdclass as integer ) static
    dim as string dst, src, aux
    dim as integer ddsize, sdsize, reg, isfree
    dim as string ostr

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ddsize = irGetDataSize( dvreg->dtype )
	sdsize = irGetDataSize( svreg->dtype )

	'' byte source? damn..
	if( sdsize = 1 ) then

		reg = emitFindRegNotInVreg( svreg )

		emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, aux )

		isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

		if( not isfree ) then
			emithPUSH aux
		end if

		if( irIsSigned( svreg->dtype ) ) then
			ostr = "movsx "
		else
			ostr = "movzx "
		end if
		ostr += aux + COMMA + src
		outp ostr

		emithPUSH aux
		outp "fild dword ptr [esp]"
		outp "add esp, 4"

		if( not isfree ) then
			emithPOP aux
		end if

		ostr = "fstp " + dst
		outp ostr

	else
		'' integer source
		if( sdclass <> IR.DATACLASS.FPOINT ) then
			if( (svreg->typ = IR.VREGTYPE.REG) or (svreg->typ = IR.VREGTYPE.IMM) ) then

				'' signed?
				if( irIsSigned( svreg->dtype ) ) then

					'' longint?
					if( sdsize = FB.INTEGERSIZE*2 ) then
						hPrepOperand64( sname, svreg, src, aux )

						emithPUSH aux
						emithPUSH src

					else
						'' not an integer? make it
						if( (svreg->typ = IR.VREGTYPE.REG) and (sdsize < FB.INTEGERSIZE) ) then
							emitGetRegName( IR.DATATYPE.INTEGER, sdclass, svreg->reg, src )
						end if

						emithPUSH src

					end if

					ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
					outp ostr

					'' longint?
					if( sdsize = FB.INTEGERSIZE*2 ) then
						outp "add esp, 8"
					else
						outp "add esp, 4"
					end if

				'' unsigned..
				else

					select case sdsize
					'' ulongint? damn..
					case FB.INTEGERSIZE*2
						hPrepOperand64( sname, svreg, src, aux )
						emithPUSH aux
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"
						emithULONG2DBL sname, svreg

					'' uint..
					case FB.INTEGERSIZE
						emithPUSH "0"
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"

					'' ushort..
					case else
						if( svreg->typ <> IR.VREGTYPE.IMM ) then
							emithPUSH "0"
						end if

						emithPUSH src
						outp "fild dword ptr [esp]"

						if( svreg->typ <> IR.VREGTYPE.IMM ) then
							outp "add esp, 6"
						else
							outp "add esp, 4"
						end if
					end select

				end if

			'' not a reg or imm
			else

				'' signed?
				if( irIsSigned( svreg->dtype ) ) then
					ostr = "fild " + src
					outp ostr

				'' unsigned, try a bigger type..
				else

					select case sdsize
					'' ulongint? damn..
					case FB.INTEGERSIZE*2
						ostr = "fild " + src
						outp ostr
						emithULONG2DBL sname, svreg

					'' uint..
					case FB.INTEGERSIZE
						emithPUSH "0"
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"

					'' ushort..
					case else
						emithPUSH "0"
						emithPUSH src
						outp "fild dword ptr [esp]"
						outp "add esp, 6"
					end select

				end if
			end if

			ostr = "fstp " + dst
			outp ostr

		'' fpoint source
		else
			'' on fpu stack?
			if( svreg->typ = IR.VREGTYPE.REG ) then
				ostr = "fstp " + dst
				outp ostr

			else
				'' same size? just copy..
				if( sdsize = ddsize ) then

					ostr = "push dword ptr [" + sname + hGetOfs( svreg->ofs + 0 ) + "]"
					outp ostr

					if( sdsize > 4 ) then
						ostr = "push dword ptr [" + sname + hGetOfs( svreg->ofs + 4 ) + "]"
						outp ostr

						ostr = "pop dword ptr [" + dname + hGetOfs( dvreg->ofs + 4 ) + "]"
						outp ostr
					end if

					ostr = "pop dword ptr [" + dname + hGetOfs( dvreg->ofs + 0 ) + "]"
					outp ostr

				'' diff sizes, convert..
				else
					ostr = "fld " + src
					outp ostr

					ostr = "fstp " + dst
					outp ostr
				end if
			end if
		end if
	end if

end sub

'':::::
sub emitSTORE( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim ddclass as integer, sdclass as integer

	ddclass = irGetDataClass( dvreg->dtype )
	sdclass = irGetDataClass( svreg->dtype )

	'' integer destine
	if( ddclass = IR.DATACLASS.INTEGER ) then
		emitSTORE2INT dname, dvreg, ddclass, sname, svreg, sdclass

	'' fpoint destine
	else
		emitSTORE2FLT dname, dvreg, ddclass, sname, svreg, sdclass
	end if

end sub

'':::::
sub emitLOADTOINT64( byval dname as string, _
					 byval dvreg as IRVREG ptr, _
			         byval sname as string, _
			         byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string, ext as string
    dim sdsize as integer
    dim ostr as string

	sdsize = irGetDataSize( svreg->dtype )

	hPrepOperand64( dname, dvreg, dst1, dst2 )

    '' dst size = src size
	if( sdsize = FB.INTEGERSIZE*2 ) then

		hPrepOperand64( sname, svreg, src1, src2 )

		ostr = "mov " + dst1 + COMMA + src1
		outp ostr

		ostr = "mov " + dst2 + COMMA + src2
		outp ostr

		exit sub
	end if

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src1 )

	'' immediate?
	if( svreg->typ = IR.VREGTYPE.IMM ) then

        emithMOV dst1, src1

		if( valint( src1 ) < -1 ) then
			emithMOV dst2, "-1"
		else
			emithMOV dst2, "0"
		end if

		exit sub
	end if

	''
	if( irIsSigned( svreg->dtype ) ) then

		if( sdsize < FB.INTEGERSIZE ) then
			ostr = "movsx " + dst1 + COMMA + src1
			outp ostr
		else
			emithMOV dst1, src1
		end if

		emithMOV dst2, dst1

		ostr = "sar " + dst2 + ", 31"
		outp ostr

	else

		if( sdsize < FB.INTEGERSIZE ) then
			ostr = "movzx " + dst1 + COMMA + src1
			outp ostr
		else
			emithMOV dst1, src1
		end if

		emithMOV dst2, "0"

	end if

end sub

'':::::
sub emitLOAD2INT( byval dname as string, _
				  byval dvreg as IRVREG ptr, _
				  byval ddclass as integer, _
			      byval sname as string, _
			      byval svreg as IRVREG ptr, _
			      byval sdclass as integer ) static
    dim as string dst, src, aux, aux8, aux16
    dim as integer ddsize, sdsize, reg, isfree
    dim as string ostr

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

    sdsize = irGetDataSize( svreg->dtype )
	ddsize = irGetDataSize( dvreg->dtype )

	'' integer source
	if( sdclass = IR.DATACLASS.INTEGER ) then

		if( ddsize = FB.INTEGERSIZE*2 ) then
			emitLOADTOINT64 dname, dvreg, sname, svreg
			exit sub
		end if

		if( ddsize = 1 ) then
			if( svreg->typ = IR.VREGTYPE.IMM ) then
				ddsize = 4
			end if
		end if

		'' dst size = src size
		if( (dvreg->dtype = svreg->dtype) or _
			(irMaxDataType( dvreg->dtype, svreg->dtype ) = INVALID) ) then

			'' handle SI/DI as byte destine and source
			if( ddsize = 1 ) then
				if( (dvreg->reg = EMIT.INTREG.ESI) or (dvreg->reg = EMIT.INTREG.EDI) ) then
					goto loadSIDI
				elseif( (svreg->reg = EMIT.INTREG.ESI) or (svreg->reg = EMIT.INTREG.EDI) ) then
					goto loadSIDI
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
				if( svreg->typ = IR.VREGTYPE.REG ) then
					if( svreg->reg <> dvreg->reg ) then
						emitGetRegName( dvreg->dtype, ddclass, svreg->reg, aux )
						ostr = "mov " + dst + COMMA + aux
						outp ostr
					end if

				'' src is not a reg
				else
					'' handle DI/SI as byte
					if( (ddsize = 1) and _
						((dvreg->reg = EMIT.INTREG.ESI) or (dvreg->reg = EMIT.INTREG.EDI)) ) then

loadSIDI:				reg = emitFindRegNotInVreg( dvreg, TRUE )

						emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg, aux8 )
						emitGetRegName( IR.DATATYPE.SHORT, IR.DATACLASS.INTEGER, reg, aux16 )

						isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

						if( not isfree ) then
							emithPUSH aux16
						end if

						hPrepOperand( sname, svreg->ofs, dvreg->dtype, svreg->typ, src )

						'' handle SI/DI as source
						if( (svreg->typ = IR.VREGTYPE.REG) and _
            				((svreg->reg = EMIT.INTREG.ESI) or (svreg->reg = EMIT.INTREG.EDI)) ) then
							emithMOV aux16, src
						else
							emithMOV aux8, src
						end if

						if( irIsSigned( svreg->dtype ) ) then
							ostr = "movsx "
						else
							ostr = "movzx "
						end if
						ostr += dst + COMMA + aux8
						outp ostr

						if( not isfree ) then
							emithPOP aux16
						end if

					'' SI/DI not used as byte
					else
						hPrepOperand( sname, svreg->ofs, dvreg->dtype, svreg->typ, src )
						ostr = "mov " + dst + COMMA + src
						outp ostr
					end if
				end if
			end if
		end if

	'' fpoint source
	else
		if( svreg->typ <> IR.VREGTYPE.REG ) then
			ostr = "fld " + src
			outp ostr
		end if

		'' byte destine? damn..
		if( ddsize = 1 ) then

			outp "sub esp, 4"
            outp "fistp dword ptr [esp]"

            '' destine is a reg
            if( dvreg->typ = IR.VREGTYPE.REG ) then
            	'' handle DI/SI as destine
            	if( (dvreg->reg = EMIT.INTREG.ESI) or (dvreg->reg = EMIT.INTREG.EDI) ) then
					if( irIsSigned( dvreg->dtype ) ) then
						ostr = "movsx "
					else
						ostr = "movzx "
					end if
					ostr += dst + ", byte ptr [esp]"
					outp ostr

				else
					emithMOV dst, "byte ptr [esp]"
				end if

				outp "add esp, 4"

            '' destine is a var/idx/ptr
            else

				reg = emitFindRegNotInVreg( dvreg, TRUE )

				emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg, aux8 )
				emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, aux )

				isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

				if( not isfree ) then
					emithXCHG aux, "dword ptr [esp]"
				else
					emithMOV aux8, "byte ptr [esp]"
				end if

				emithMOV dst, aux8

				if( not isfree ) then
					emithPOP aux
				else
					outp "add esp, 4"
				end if

            end if

		else

			'' signed?
			if( irIsSigned( dvreg->dtype ) ) then

				'' longint?
				if( ddsize = FB.INTEGERSIZE*2 ) then
					outp "sub esp, 8"
				else
					outp "sub esp, 4"
				end if

				ostr = "fistp " + dtypeTB(dvreg->dtype).mname + " [esp]"
				outp ostr

				'' longint?
				if( ddsize = FB.INTEGERSIZE*2 ) then
			    	hPrepOperand64 dname, dvreg, dst, aux

					emithPOP dst
					emithPOP aux

				else
					'' not an integer? make it
					if( ddsize < FB.INTEGERSIZE ) then
						emitGetRegName( IR.DATATYPE.INTEGER, ddclass, dvreg->reg, dst )
					end if

					emithPOP dst
				end if

			'' unsigned.. try a bigger type
			else

				select case ddsize
				'' ulongint? handled by AST already..
				case FB.INTEGERSIZE*2
                    hReportError FB.ERRMSG.INTERNAL
				'' uint..
				case FB.INTEGERSIZE
					outp "sub esp, 8"
					outp "fistp qword ptr [esp]"
					emithPOP dst
					outp  "add esp, 4"

				'' ushort..
				case else
					outp "sub esp, 4"
					outp "fistp dword ptr [esp]"
					emithPOP dst
					outp  "add esp, 2"
				end select

			end if

		end if
	end if

end sub

'':::::
sub emitLOAD2FLT( byval dname as string, _
				  byval dvreg as IRVREG ptr, _
				  byval ddclass as integer, _
			      byval sname as string, _
			      byval svreg as IRVREG ptr, _
			      byval sdclass as integer ) static
    dim as string dst, src, aux
    dim as integer ddsize, sdsize, reg, isfree
    dim as string ostr

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

    sdsize = irGetDataSize( svreg->dtype )
	ddsize = irGetDataSize( dvreg->dtype )

	'' byte source? damn..
	if( sdsize = 1 ) then

		reg = emitFindRegNotInVreg( svreg )

		emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, aux )

		isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

		if( not isfree ) then
			emithPUSH aux
		end if

		if( irIsSigned( svreg->dtype ) ) then
			ostr = "movsx " + aux + COMMA + src
			outp ostr
		else
			ostr = "movzx " + aux + COMMA + src
			outp ostr
		end if

		emithPUSH aux
		outp "fild dword ptr [esp]"
		outp "add esp, 4"

		if( not isfree ) then
			emithPOP aux
		end if

	else
		'' fpoint source
		if( sdclass = IR.DATACLASS.FPOINT ) then
			ostr = "fld " + src
			outp ostr

		'' integer source
		else
			if( (svreg->typ = IR.VREGTYPE.REG) or (svreg->typ = IR.VREGTYPE.IMM) ) then

				'' signed?
				if( irIsSigned( svreg->dtype ) ) then

					'' longint?
					if( sdsize = FB.INTEGERSIZE*2 ) then
						hPrepOperand64( sname, svreg, src, aux )

						emithPUSH aux
						emithPUSH src

					else
						'' not an integer? make it
						if( (svreg->typ = IR.VREGTYPE.REG) and (sdsize < FB.INTEGERSIZE) ) then
							emitGetRegName( IR.DATATYPE.INTEGER, sdclass, svreg->reg, src )
						end if

						emithPUSH src
					end if

					ostr = "fild " + dtypeTB(svreg->dtype).mname + " [esp]"
					outp ostr

					'' longint?
					if( sdsize = FB.INTEGERSIZE*2 ) then
						outp "add esp, 8"
					else
						outp "add esp, 4"
					end if

				'' unsigned, try a bigger type..
				else

					select case sdsize
					'' ulongint? damn..
					case FB.INTEGERSIZE*2
						hPrepOperand64( sname, svreg, src, aux )
						emithPUSH aux
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"
						emithULONG2DBL sname, svreg

					'' uint..
					case FB.INTEGERSIZE
						emithPUSH "0"
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"

					'' ushort..
					case else
						if( svreg->typ <> IR.VREGTYPE.IMM ) then
							emithPUSH "0"
						end if

						emithPUSH src
						outp "fild dword ptr [esp]"

						if( svreg->typ <> IR.VREGTYPE.IMM ) then
							outp "add esp, 6"
						else
							outp "add esp, 4"
						end if
					end select

				end if

			'' not a reg or imm
			else

				'' signed?
				if( irIsSigned( svreg->dtype ) ) then
					ostr = "fild " + src
					outp ostr

				'' unsigned, try a bigger type..
				else
					select case sdsize
					'' ulongint? damn..
					case FB.INTEGERSIZE*2
						ostr = "fild " + src
						outp ostr
						emithULONG2DBL sname, svreg

					'' uint..
					case FB.INTEGERSIZE
						emithPUSH "0"
						emithPUSH src
						outp "fild qword ptr [esp]"
						outp "add esp, 8"

					'' ushort..
					case else
						emithPUSH "0"
						emithPUSH src
						outp "fild dword ptr [esp]"
						outp "add esp, 6"
					end select
				end if

			end if
		end if
	end if

end sub

'':::::
sub emitLOAD( byval dname as string, _
			  byval dvreg as IRVREG ptr, _
			  byval sname as string, _
			  byval svreg as IRVREG ptr ) static
    dim ddclass as integer, sdclass as integer

	ddclass = irGetDataClass( dvreg->dtype )
	sdclass = irGetDataClass( svreg->dtype )

	'' integer destine
	if( ddclass = IR.DATACLASS.INTEGER ) then
		emitLOAD2INT dname, dvreg, ddclass, sname, svreg, sdclass

	'' fpoint destine
	else
	    emitLOAD2FLT dname, dvreg, ddclass, sname, svreg, sdclass

	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitADD64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "add " + dst1 + COMMA + src1
	outp ostr

	ostr = "adc " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitADD( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitADD64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	select case irGetDataClass( dvreg->dtype )
	case IR.DATACLASS.INTEGER
		doinc = FALSE
		dodec = FALSE
		if( svreg->typ = IR.VREGTYPE.IMM ) then
			select case valint( src )
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

	case IR.DATACLASS.FPOINT
		if( svreg->typ = IR.VREGTYPE.REG ) then
			ostr = "faddp"
			outp ostr
		else
			if( irGetDataClass( svreg->dtype ) = IR.DATACLASS.FPOINT ) then
				ostr = "fadd " + src
				outp ostr
			else
				ostr = "fiadd " + src
				outp ostr
			end if
		end if
	end select

end sub

'':::::
sub emitSUB64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "sub " + dst1 + COMMA + src1
	outp ostr

	ostr = "sbb " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitSUB( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitSUB64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	select case irGetDataClass( dvreg->dtype )
	case IR.DATACLASS.INTEGER
		doinc = FALSE
		dodec = FALSE
		if( svreg->typ = IR.VREGTYPE.IMM ) then
			select case valint( src )
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

	case IR.DATACLASS.FPOINT
		if( svreg->typ = IR.VREGTYPE.REG ) then
			outp "fsubrp"
		else
			if( irGetDataClass( svreg->dtype ) = IR.DATACLASS.FPOINT ) then
				ostr = "fsub " + src
				outp ostr
			else
				ostr = "fisub " + src
				outp ostr
			end if
		end if
	end select

end sub

'':::::
sub emithINTMUL( byval dname as string, _
				 byval dst as string, _
				 byval dvreg as IRVREG ptr, _
			     byval src as string, _
			     byval svreg as IRVREG ptr ) static
    dim eaxfree as integer, edxfree as integer
    dim edxtrashed as integer
    dim eaxinsource as integer, eaxindest as integer, edxindest as integer
    dim eax as string, edx as string
    dim ostr as string

	eaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
	edxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )

	eaxinsource  = emitIsRegInVreg( svreg, EMIT.INTREG.EAX )
	eaxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EAX )
	edxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EDX )

    if( dtypeTB(dvreg->dtype).size = 4 ) then
    	eax = "eax"
    	edx = "edx"
    else
    	eax = "ax"
    	edx = "dx"
    end if

	if( (eaxinsource) or (svreg->typ = IR.VREGTYPE.IMM) ) then
		edxtrashed = TRUE
		if( edxindest ) then
			emithPUSH "edx"
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				ostr = "dword ptr [" + dname + hGetOfs( dvreg->ofs ) + "]"
				emithPUSH ostr
			end if
		elseif( not edxfree ) then
			emithPUSH "edx"
		end if

		emithMOV edx, src
		src = edx
	else
		edxtrashed = FALSE
	end if

	if( (not eaxindest) or (dvreg->typ <> IR.VREGTYPE.REG) ) then
		if( (edxindest) and (edxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				emithPOP "eax"
			end if
		else
			if( not eaxfree ) then
				emithPUSH "eax"
			end if
			emithMOV eax, dst
		end if
	end if

	ostr = "mul " + src
	outp ostr

	if( not eaxindest ) then
		if( edxindest and dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "edx"					'' edx= tos (eax)
			outp "xchg edx, [esp]"			'' tos= edx; edx= dst
		end if

		emithMOV dst, eax

		if( not eaxfree ) then
			emithPOP eax
		end if
	else
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithMOV "edx", "eax"			'' edx= eax
			emithPOP "eax"					'' restore eax
			emithMOV dst, edx				'' [eax+...] = edx
		end if
	end if

	if( edxtrashed ) then
		if( (not edxfree) and (not edxindest) ) then
			emithPOP edx
		end if
	end if

end sub

'':::::
sub emitINTMUL64( byval dname as string, _
				  byval dvreg as IRVREG ptr, _
			      byval sname as string, _
			      byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim iseaxfree as integer, isedxfree as integer
    dim eaxindest as integer, edxindest as integer
    dim ofs as integer

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	iseaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
	isedxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )

	eaxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EAX )

	edxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EDX )

	emithPUSH src2
	emithPUSH src1
	emithPUSH dst2
	emithPUSH dst1

	ofs = 0

	if( edxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			ofs += 4
			emithPUSH "edx"
		end if
	else
		if( not isedxfree ) then
			ofs += 4
			emithPUSH "edx"
		end if
	end if

	if( eaxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			ofs += 4
			emithPUSH "eax"
		end if
	else
		if( not iseaxfree ) then
			ofs += 4
			emithPUSH "eax"
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
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "eax"
		end if
	else
		if( not iseaxfree ) then
			emithPOP "eax"
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "edx"
		end if
	else
		if( not isedxfree ) then
			emithPOP "edx"
		end if
	end if

	'' low(dst) = low(res)
	emithPOP dst1
	'' high(dst) = hres
	emithPOP dst2

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
sub emithINTIMUL( byval dst as string, _
				  byval dvreg as IRVREG ptr, _
			      byval src as string, _
			      byval svreg as IRVREG ptr ) static
    dim reg as integer, isfree as integer, rname as string
    dim ostr as string

	if( dvreg->typ <> IR.VREGTYPE.REG ) then

		reg = emitFindRegNotInVreg( svreg )
		emitGetRegName( svreg->dtype, IR.DATACLASS.INTEGER, reg, rname )

		isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

		if( not isfree ) then
			emithPUSH rname
		end if

		emithMOV rname, dst
		ostr = "imul " + rname + COMMA + src
		outp ostr
		emithMOV dst, rname

		if( not isfree ) then
			emithPOP rname
		end if

	else
		ostr = "imul " + dst + COMMA + src
		outp ostr
	end if

end sub

'':::::
sub emitMUL( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
		     byval sname as string, _
		     byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitINTMUL64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	select case irGetDataClass( dvreg->dtype )
	case IR.DATACLASS.INTEGER
		if( irIsSigned( dvreg->dtype ) ) then
        	emithINTIMUL dst, dvreg, src, svreg
		else
			emithINTMUL dname, dst, dvreg, src, svreg
		end if

	case IR.DATACLASS.FPOINT
		if( svreg->typ = IR.VREGTYPE.REG ) then
			outp "fmulp"
		else
			if( irGetDataClass( svreg->dtype ) = IR.DATACLASS.FPOINT ) then
				ostr = "fmul " + src
				outp ostr
			else
				ostr = "fimul " + src
				outp ostr
			end if
		end if
	end select

end sub

'':::::
sub emitDIV( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
		     byval sname as string, _
		     byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	if( svreg->typ = IR.VREGTYPE.REG ) then
		outp "fdivrp"
	else
		if( irGetDataClass( svreg->dtype ) = IR.DATACLASS.FPOINT ) then
			ostr = "fdiv " + src
			outp ostr
		else
			ostr = "fidiv " + src
			outp ostr
		end if
	end if

end sub

'':::::
sub emitINTDIV( byval dname as string, _
				byval dvreg as IRVREG ptr, _
		        byval sname as string, _
		        byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ecxtrashed as integer
    dim eaxfree as integer, ecxfree as integer, edxfree as integer
    dim eaxindest as integer, ecxindest as integer, edxindest as integer
    dim eaxinsource as integer, edxinsource as integer
    dim eax as string, ecx as string, edx as string
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

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

	eaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
	ecxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.ECX )
	edxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )

	eaxinsource  = emitIsRegInVreg( svreg, EMIT.INTREG.EAX )
	edxinsource  = emitIsRegInVreg( svreg, EMIT.INTREG.EDX )
	eaxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EAX )
	edxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EDX )
	ecxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.ECX )

	if( (eaxinsource) or (edxinsource) or (svreg->typ = IR.VREGTYPE.IMM) ) then
		ecxtrashed = TRUE
		if( ecxindest ) then
			emithPUSH "ecx"
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				ostr = "dword ptr [" + dname + hGetOfs( dvreg->ofs ) + "]"
				emithPUSH ostr
			end if
		elseif( not ecxfree ) then
			emithPUSH "ecx"
		end if
		emithMOV ecx, src
		src = ecx
	end if

	if( not eaxindest ) then
		if( (ecxindest) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				emithPOP "eax"
			end if
		else
			if( not eaxfree ) then
				emithPUSH "eax"
			end if
			emithMOV eax, dst
		end if

	else
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPUSH "eax"
			emithMOV eax, dst
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPUSH "edx"
		end if
	elseif( not edxfree ) then
		emithPUSH "edx"
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
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "edx"
		end if
	elseif( not edxfree ) then
		emithPOP "edx"
	end if

	if( not eaxindest ) then
		if( ecxindest ) then
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				emithPOP "ecx"					'' ecx= tos (eax)
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
			end if
		end if

		emithMOV dst, eax

		if( not eaxfree ) then
			emithPOP "eax"
		end if

	else
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			if( (not ecxfree) and (not ecxtrashed) ) then
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
				outp "xchg ecx, eax"			'' ecx= res; eax= dst
			else
				emithMOV "ecx", "eax"			'' ecx= eax
				emithPOP "eax"					'' restore eax
			end if

			emithMOV dst, ecx					'' [eax+...] = ecx

			if( (not ecxfree) and (not ecxtrashed) ) then
				emithPOP "ecx"
			end if
		end if
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (not ecxindest) ) then
			emithPOP "ecx"
		end if
	end if

end sub

'':::::
sub emitMOD( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
		     byval sname as string, _
		     byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ecxtrashed as integer
    dim eaxfree as integer, ecxfree as integer, edxfree as integer
    dim eaxindest as integer, ecxindest as integer, edxindest as integer
    dim eaxinsource as integer, edxinsource as integer
    dim eax as string, ecx as string, edx as string
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

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

	eaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
	ecxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.ECX )
	edxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )

	eaxinsource  = emitIsRegInVreg( svreg, EMIT.INTREG.EAX )
	edxinsource  = emitIsRegInVreg( svreg, EMIT.INTREG.EDX )
	eaxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EAX )
	edxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EDX )
	ecxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.ECX )

	if( (eaxinsource) or (edxinsource) or (svreg->typ = IR.VREGTYPE.IMM) ) then
		ecxtrashed = TRUE
		if( ecxindest ) then
			emithPUSH "ecx"
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				ostr = "dword ptr [" + dname + hGetOfs( dvreg->ofs ) + "]"
				emithPUSH ostr
			end if
		elseif( not ecxfree ) then
			emithPUSH "ecx"
		end if
		emithMOV ecx, src
		src = ecx
	end if

	if( not eaxindest ) then
		if( (ecxindest) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg eax, [esp]"
			else
				emithPOP "eax"
			end if
		else
			if( not eaxfree ) then
				emithPUSH "eax"
			end if
			emithMOV eax, dst
		end if

	else
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPUSH "eax"
			emithMOV eax, dst
		end if
	end if

	if( edxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPUSH "edx"
		end if
	elseif( not edxfree ) then
		emithPUSH "edx"
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

	emithMOV eax, edx

	if( edxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "edx"
		end if
	elseif( not edxfree ) then
		emithPOP "edx"
	end if

	if( not eaxindest ) then
		if( ecxindest ) then
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				emithPOP "ecx"					'' ecx= tos (eax)
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
			end if
		end if

		emithMOV dst, eax

		if( not eaxfree ) then
			emithPOP "eax"
		end if

	else
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			if( (not ecxfree) and (not ecxtrashed) ) then
				outp "xchg ecx, [esp]"			'' tos= ecx; ecx= dst
				outp "xchg ecx, eax"			'' ecx= res; eax= dst
			else
				emithMOV "ecx", "eax"			'' ecx= eax
				emithPOP "eax"					'' restore eax
			end if

			emithMOV dst, ecx					'' [eax+...] = ecx

			if( (not ecxfree) and (not ecxtrashed) ) then
				emithPOP "ecx"
			end if
		end if
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (not ecxindest) ) then
			emithPOP "ecx"
		end if
	end if

end sub

'':::::
sub emitSHIFT64( byval op as integer, mnemonic as string, _
				 byval dname as string, _
				 byval dvreg as IRVREG ptr, _
			     byval sname as string, _
			     byval svreg as IRVREG ptr ) static
    dim as string dst1, dst2, src, ostr, label
    dim as integer iseaxfree, isedxfree, isecxfree
    dim as integer eaxindest, edxindest, ecxindest
    dim as integer ofs

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand( sname, svreg->ofs, IR.DATATYPE.INTEGER, svreg->typ, src )

	iseaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
	isedxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )
	isecxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.ECX )

	eaxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EAX )
	edxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.EDX )
	ecxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.ECX )

	emithPUSH dst2
	emithPUSH dst1
	ofs = 0

	'' load src to cl
	if( svreg->typ <> IR.VREGTYPE.IMM ) then
		if( (svreg->typ <> IR.VREGTYPE.REG) or (svreg->reg <> EMIT.INTREG.ECX) ) then
			'' handle src < dword
			if( irGetDataSize( svreg->dtype ) <> FB.INTEGERSIZE ) then
				'' if it's not a reg, the right size was already set at the hPrepOperand() above
				if( svreg->typ = IR.VREGTYPE.REG ) then
					emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, svreg->reg, src )
				end if
			end if

			if( not isecxfree ) then
				if( ecxindest and dvreg->typ = IR.VREGTYPE.REG ) then
					emithMOV "ecx", src
					isecxfree = TRUE
				else
					emithPUSH src
					outp "xchg ecx, [esp]"
					ofs += 4
				end if
			else
				emithMOV "ecx", src
			end if
		else
			isecxfree = TRUE
		end if
	end if

	'' load dst1 to eax
	if( eaxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
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
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
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
	if( svreg->typ <> IR.VREGTYPE.IMM ) then
		label = *hMakeTmpStr( )

		if( op = IR.OP.SHL ) then
			outp "shld edx, eax, cl"
			outp mnemonic + " eax, cl"
		else
			outp "shrd eax, edx, cl"
			outp mnemonic + " edx, cl"
		end if

		outp "test cl, 32"
		emithBRANCH "jz", label

		if( op = IR.OP.SHL ) then
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

		emitLABEL label

		if( not isecxfree ) then
			emithPOP "ecx"
		end if

	'' immediate
	else

		if( valint( src ) <> 32 ) then
			if( op = IR.OP.SHL ) then
				outp "shld edx, eax, " + src
				outp mnemonic + " eax, " + src
			else
				outp "shrd eax, edx, " + src
				outp mnemonic + " edx, " + src
			end if
		'' src = 32, just swap
		else
			if( op = IR.OP.SHL ) then
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
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
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
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
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

	emithPOP dst1
	emithPOP dst2

end sub

'':::::
sub emitSHIFT( byval mnemonic as string, _
			   byval dname as string, _
			   byval dvreg as IRVREG ptr, _
		       byval sname as string, _
		       byval svreg as IRVREG ptr ) static
    dim dst as string, src as string, tmp as string
    dim eaxpreserved as integer, ecxpreserved as integer
    dim eaxfree as integer, ecxfree as integer
    dim reg as integer
    dim ecxindest as integer
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )

	ecxindest = FALSE
	eaxpreserved = FALSE
	ecxpreserved = FALSE

	if( svreg->typ = IR.VREGTYPE.IMM ) then
		src = sname
		tmp = dst

	else
		eaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
		ecxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.ECX )

		if( svreg->typ = IR.VREGTYPE.REG ) then
			reg = svreg->reg
		else
			reg = INVALID
		end if

        ecxindest = emitIsRegInVreg( dvreg, EMIT.INTREG.ECX )

		'' ecx in destine?
		if( ecxindest ) then
			'' preserve
			emithPUSH "ecx"
			'' not a reg?
			if( dvreg->typ <> IR.VREGTYPE.REG ) then
				ostr = "dword ptr [" + dname + hGetOfs( dvreg->ofs ) + "]"
				emithPUSH ostr
			end if

		'' ecx not free?
		elseif( (reg <> EMIT.INTREG.ECX) and (not ecxfree) ) then
			ecxpreserved = TRUE
			emithPUSH "ecx"
		end if

		'' source not a reg?
		if( svreg->typ <> IR.VREGTYPE.REG ) then
			ostr = "byte ptr [" + sname + hGetOfs( svreg->ofs ) + "]"
			emithMOV "cl", ostr
		else
			'' source not ecx?
			if( reg <> EMIT.INTREG.ECX ) then
				emithMOV "ecx", rnameTB(dtypeTB(IR.DATATYPE.INTEGER).rnametb, reg)
			end if
		end if

		'' load ecx to a tmp?
		if( ecxindest ) then
			'' tmp not free?
			if( not eaxfree ) then
				eaxpreserved = TRUE
				outp "xchg eax, [esp]"		'' eax= dst; push eax
			else
				emithPOP "eax"				'' eax= dst; pop tos
			end if

			tmp = rnameTB(dtypeTB(dvreg->dtype).rnametb, EMIT.INTREG.EAX )

		else
			tmp = dst
		end if

		src = "cl"

	end if

	ostr = mnemonic + " " + tmp + COMMA + src
	outp ostr

	if( ecxindest ) then
		if( dvreg->typ <> IR.VREGTYPE.REG ) then
			emithPOP "ecx"
			if( eaxpreserved ) then
				outp "xchg ecx, [esp]"		'' ecx= tos; tos= eax
			end if
		end if
		emithMOV dst, rnameTB(dtypeTB(dvreg->dtype).rnametb, EMIT.INTREG.EAX)
	end if

	if( eaxpreserved ) then
		emithPOP "eax"
	end if

	if( ecxpreserved ) then
		emithPOP "ecx"
	end if

end sub

'':::::
sub emitSHL( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
		     byval sname as string, _
		     byval svreg as IRVREG ptr ) static
    dim inst as string

	if( irIsSigned( dvreg->dtype ) ) then
		inst = "sal"
	else
		inst = "shl"
	end if

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitSHIFT64 IR.OP.SHL, inst, dname, dvreg, sname, svreg
	else
		emitSHIFT inst, dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitSHR( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
		     byval sname as string, _
		     byval svreg as IRVREG ptr ) static
    dim inst as string

	if( irIsSigned( dvreg->dtype ) ) then
		inst = "sar"
	else
		inst = "shr"
	end if

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitSHIFT64 IR.OP.SHR, inst, dname, dvreg, sname, svreg
	else
		emitSHIFT inst, dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitAND64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "and " + dst1 + COMMA + src1
	outp ostr

	ostr = "and " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitAND( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitAND64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "and " + dst + COMMA + src
	outp ostr

end sub

'':::::
sub emitOR64( byval dname as string, _
			  byval dvreg as IRVREG ptr, _
			  byval sname as string, _
			  byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "or " + dst1 + COMMA + src1
	outp ostr

	ostr = "or " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitOR( byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitOR64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "or " + dst + COMMA + src
	outp ostr

end sub

'':::::
sub emitXOR64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "xor " + dst1 + COMMA + src1
	outp ostr

	ostr = "xor " + dst2 + COMMA + src2
	outp ostr

end sub

'':::::
sub emitXOR( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitXOR64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "xor " + dst + COMMA + src
	outp ostr

end sub

'':::::
sub emitEQV64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

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
sub emitEQV( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitEQV64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "xor " + dst + COMMA + src
	outp ostr

	ostr = "not " + dst
	outp ostr

end sub

'':::::
sub emitIMP64( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

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
sub emitIMP( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitIMP64 dname, dvreg, sname, svreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	ostr = "not " + dst
	outp ostr

	ostr = "or " + dst + COMMA + src
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' comps
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitICMP64( byval rname as string, _
				byval rvreg as IRVREG ptr, _
			    byval label as string, _
			    byval mnemonic as string, _
			    byval rev_mnemonic as string, _
			    byval usg_mnemonic as string, _
			    byval dname as string, _
			    byval dvreg as IRVREG ptr, _
			    byval sname as string, _
			    byval svreg as IRVREG ptr, _
			    byval isinverse as integer = FALSE ) static
    dim dst1 as string, dst2 as string, src1 as string, src2 as string
    dim ostr as string
    dim falselabel as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )
	hPrepOperand64( sname, svreg, src1, src2 )

	'' check high
	ostr = "cmp " + dst2 + COMMA + src2
	outp ostr

	falselabel = *hMakeTmpStr( )

	'' set the boolean result?
	if( len( rname ) > 0 ) then
		ostr = "mov " + rname + ", -1"
		outp ostr
	end if

	ostr = "j" + mnemonic
	if( not isinverse ) then
		emithBRANCH ostr, label
	else
		emithBRANCH ostr, falselabel
	end if

	if( len( rev_mnemonic ) > 0 ) then
		ostr = "j" + rev_mnemonic
		emithBRANCH ostr, falselabel
	end if

	'' check low
	ostr = "cmp " + dst1 + COMMA + src1
	outp ostr

	ostr = "j" + usg_mnemonic
	emithBRANCH ostr, label

	emitLabel falselabel

	if( len( rname ) > 0 ) then
		ostr = "xor " + rname + COMMA + rname
		outp ostr

		emitLabel label
	end if

end sub

'':::::
sub emithICMP( byval rname as string, _
			   byval rvreg as IRVREG ptr, _
			   byval label as string, _
			   byval mnemonic as string, _
			   byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim dotest as integer
    dim rname8 as string
    dim isedxfree as integer
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	'' optimize "cmp" to "test"
	dotest = FALSE
	if( len( src ) = 0 ) then
		dotest = TRUE
	elseif( (svreg->typ = IR.VREGTYPE.IMM) and (dvreg->typ = IR.VREGTYPE.REG) ) then
		if( valint( src ) = 0 ) then
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
	if( len( rname ) = 0 ) then
		ostr = "j" + mnemonic
		emithBRANCH ostr, label

	'' can it be optimized?
	elseif( (env.clopt.cputype >= FB.CPUTYPE.486) and (rvreg->typ = IR.VREGTYPE.REG) ) then

		emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, rvreg->reg, rname8 )

		'' handle EDI and ESI
		if( (rvreg->reg = EMIT.INTREG.ESI) or (rvreg->reg = EMIT.INTREG.EDI) ) then

			isedxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )
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
				emithMOV rname, "edx"
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
		emithBRANCH ostr, label

		ostr = "xor " + rname + COMMA + rname
		outp ostr

		emitLabel label
	end if

end sub

'':::::
sub emithFCMP( byval rname as string, _
			   byval rvreg as IRVREG ptr, _
			   byval label as string, _
			   byval mnemonic as string, _
			   byval mask as string, _
			   byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
	dim dst as string, src as string
    dim rname8 as string
    dim iseaxfree as integer, isedxfree as integer
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	'' do comp
	if( svreg->typ = IR.VREGTYPE.REG ) then
		outp "fcompp"
	else
		'' can it be optimized to ftst?
		if( len( src ) > 0 ) then
			if( irGetDataClass( svreg->dtype ) = IR.DATACLASS.FPOINT ) then
				ostr = "fcomp " + src
				outp ostr
			else
				ostr = "ficomp " + src
				outp ostr
			end if
		else
			outp "ftst"
		end if
	end if

    if( rvreg->reg <> EMIT.INTREG.EAX ) then
    	iseaxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX )
    	if( not iseaxfree ) then
    		emithPUSH "eax"
    	end if
    else
    	iseaxfree = TRUE
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
		emithPOP "eax"
	end if

    '' no result to be set? just branch
    if( len( rname ) = 0 ) then
    	ostr = "j" + mnemonic
    	emithBRANCH ostr, label

	'' can it be optimized?
	elseif( env.clopt.cputype >= FB.CPUTYPE.486 ) then
		emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, rvreg->reg, rname8 )

		'' handle EDI and ESI
		if( (rvreg->reg = EMIT.INTREG.ESI) or (rvreg->reg = EMIT.INTREG.EDI) ) then

			isedxfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EDX )
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
				emithMOV rname, "edx"
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
    	emithBRANCH ostr, label

		ostr = "xor " + rname + COMMA + rname
		outp ostr

		emitLabel label
	end if

end sub

'':::::
sub emitGT( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "g"
		else
			jmp = "a"
		end if

		'' longint?
		if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
			if( irIsSigned( dvreg->dtype ) ) then
				rjmp = "l"
			else
				rjmp = "b"
			end if
			emitICMP64 rname, rvreg, label, jmp, rjmp, "a", dname, dvreg, sname, svreg

		else
			emithICMP rname, rvreg, label, jmp, dname, dvreg, sname, svreg
		end if

	else
		emithFCMP rname, rvreg, label, "z", "0b01000001", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitLT( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "l"
		else
			jmp = "b"
		end if

		'' longint?
		if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
			if( irIsSigned( dvreg->dtype ) ) then
				rjmp = "g"
			else
				rjmp = "a"
			end if
			emitICMP64 rname, rvreg, label, jmp, rjmp, "b", dname, dvreg, sname, svreg

    	else
			emithICMP rname, rvreg, label, jmp, dname, dvreg, sname, svreg
		end if

	else
		emithFCMP rname, rvreg, label, "nz", "0b00000001", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitEQ( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitICMP64 rname, rvreg, label, "ne", "", "e", dname, dvreg, sname, svreg, TRUE
		exit sub
	end if

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		emithICMP rname, rvreg, label, "e", dname, dvreg, sname, svreg
	else
		emithFCMP rname, rvreg, label, "nz", "0b01000000", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitNE( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitICMP64 rname, rvreg, label, "ne", "", "ne", dname, dvreg, sname, svreg
		exit sub
	end if

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		emithICMP rname, rvreg, label, "ne", dname, dvreg, sname, svreg
	else
		emithFCMP rname, rvreg, label, "z", "0b01000000", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitLE( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "l"
			rjmp = "g"
		else
			jmp = "b"
			rjmp = "a"
		end if
		emitICMP64 rname, rvreg, label, jmp, rjmp, "be", dname, dvreg, sname, svreg
		exit sub
	end if

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "le"
		else
			jmp = "be"
		end if
		emithICMP rname, rvreg, label, jmp, dname, dvreg, sname, svreg
	else
		emithFCMP rname, rvreg, label, "nz", "0b01000001", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitGE( byval rname as string, _
			byval rvreg as IRVREG ptr, _
			byval label as string, _
			byval dname as string, _
			byval dvreg as IRVREG ptr, _
			byval sname as string, _
			byval svreg as IRVREG ptr ) static
	dim jmp as string, rjmp as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "g"
			rjmp = "l"
		else
			jmp = "a"
			rjmp = "b"
		end if
		emitICMP64 rname, rvreg, label, jmp, rjmp, "ae", dname, dvreg, sname, svreg
		exit sub
	end if

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( dvreg->dtype ) ) then
			jmp = "ge"
		else
			jmp = "ae"
		end if
		emithICMP rname, rvreg, label, jmp, dname, dvreg, sname, svreg
	else
		emithFCMP rname, rvreg, label, "ae", "", dname, dvreg, sname, svreg
	end if

end sub

'':::::
sub emitATAN2( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static

    dim src as string
    dim ostr as string

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	if( svreg->typ <> IR.VREGTYPE.REG ) then
		ostr = "fld " + src
		outp ostr
	else
		outp "fxch"
	end if
	outp "fpatan"

end sub

'':::::
sub emitPOW( byval dname as string, _
			 byval dvreg as IRVREG ptr, _
			 byval sname as string, _
			 byval svreg as IRVREG ptr ) static

	dim src as string
	dim ostr as string

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	if( svreg->typ <> IR.VREGTYPE.REG ) then
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
'' unary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitNEG64( byval dname as string, _
			   byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )

	ostr = "neg " + dst1
	outp ostr

	ostr = "adc " + dst2 + ", 0"
	outp ostr

	ostr = "neg " + dst2
	outp ostr

end sub

'':::::
sub emitNEG( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitNEG64 dname, dvreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )

	select case irGetDataClass( dvreg->dtype )
	case IR.DATACLASS.INTEGER
		ostr = "neg " + dst
		outp ostr

	case IR.DATACLASS.FPOINT
		outp "fchs"
	end select

end sub

'':::::
sub emitNOT64( byval dname as string, _
			   byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )

	ostr = "not " + dst1
	outp ostr

	ostr = "not " + dst2
	outp ostr

end sub

'':::::
sub emitNOT( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitNOT64 dname, dvreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )

	ostr = "not " + dst
	outp ostr

end sub

'':::::
sub emitABS64( byval dname as string, _
			   byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim reg as integer, isfree as integer, rname as string
    dim ostr as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )

	reg = emitFindRegNotInVreg( dvreg )
	emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, rname )

	isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

	if( not isfree ) then
		emithPUSH rname
	end if

	emithMOV rname, dst2

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
		emithPOP rname
	end if

end sub

'':::::
sub emitABS( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim reg as integer, isfree as integer, rname as string, bits as integer
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitABS64 dname, dvreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )

	select case irGetDataClass( dvreg->dtype )
	case IR.DATACLASS.INTEGER

		reg = emitFindRegNotInVreg( dvreg )
		emitGetRegName( dvreg->dtype, IR.DATACLASS.INTEGER, reg, rname )

		isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

		if( not isfree ) then
			emithPUSH rname
		end if

		bits = (dtypeTB(dvreg->dtype).size * 8)-1

		emithMOV rname, dst

		ostr = "sar " + rname + COMMA + str$( bits )
		outp ostr

		ostr = "xor " + dst + COMMA + rname
		outp ostr

		ostr = "sub " + dst + COMMA + rname
		outp ostr

		if( not isfree ) then
			emithPOP rname
		end if

	case IR.DATACLASS.FPOINT
		outp "fabs"
	end select

end sub

'':::::
sub emitSGN64( byval dname as string, _
			   byval dvreg as IRVREG ptr ) static
    dim dst1 as string, dst2 as string
    dim ostr as string
    dim label1 as string, label2 as string

	hPrepOperand64( dname, dvreg, dst1, dst2 )

	label1 = *hMakeTmpStr( )
	label2 = *hMakeTmpStr( )

	ostr = "cmp " + dst2 + ", 0"
	outp ostr
	emithBRANCH "jne", label1

	ostr = "cmp " + dst1 + ", 0"
	outp ostr
	emithBRANCH "je", label2

	emitLABEL label1
	emithMOV dst1, "1"
	emithMOV dst2, "0"
	emithBRANCH "jg", label2
	emithMOV dst1, "-1"
	emithMOV dst2, "-1"

	emitLABEL label2

end sub

'':::::
sub emitSGN( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static
    dim dst as string
    dim label as string
    dim ostr as string

	'' longint?
	if( (dvreg->dtype = IR.DATATYPE.LONGINT) or (dvreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitSGN64 dname, dvreg
		exit sub
	end if

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )

	if( irGetDataClass( dvreg->dtype ) = IR.DATACLASS.INTEGER ) then

		label = *hMakeTmpStr( )

		ostr = "cmp " + dst + ", 0"
		outp ostr

		emithBRANCH "je", label
		emithMOV dst, "1"
		emithBRANCH "jg", label
		emithMOV dst, "-1"

		emitLABEL label

	end if

	'' hack! floating-point SGN is done by a rtlib function, called by AST

end sub

'':::::
sub emitSIN( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static

	outp "fsin"

end sub

'':::::
sub emitASIN( byval dname as string, _
			  byval dvreg as IRVREG ptr ) static

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
sub emitCOS( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static

	outp "fcos"

end sub

'':::::
sub emitACOS( byval dname as string, _
			  byval dvreg as IRVREG ptr ) static

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
sub emitTAN( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static

	outp "fptan"
	outp "fstp st(0)"

end sub

'':::::
sub emitATAN( byval dname as string, _
			  byval dvreg as IRVREG ptr ) static

	outp "fld1"
	outp "fpatan"

end sub

'':::::
sub emitSQRT( byval dname as string, _
			  byval dvreg as IRVREG ptr ) static

	outp "fsqrt"

end sub

'':::::
sub emitLOG( byval dname as string, _
			 byval dvreg as IRVREG ptr ) static

	'' log( x ) = log2( x ) / log2( e ).

	outp "fld1"
	outp "fxch"
	outp "fyl2x"
	outp "fldl2e"
	outp "fdivp"

end sub

'':::::
sub emitFLOOR( byval dname as string, _
			   byval dvreg as IRVREG ptr ) static

	dim as integer reg, isfree
	dim as string rname, ostr

	reg = emitFindFreeReg( IR.DATACLASS.INTEGER )
	emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, reg, rname )

	isfree = regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), reg )

	if( not isfree ) then
		emithPUSH rname
	end if

	outp "sub esp, 4"
	outp "fnstcw [esp]"
	emithMOV rname, "[esp]"
	ostr = "and " + rname + ", 0b1111001111111111"
	outp ostr
	ostr = "or " + rname +  ", 0b0000010000000000"
	outp ostr
	emithPUSH rname
	outp "fldcw [esp]"
	outp "add esp, 4"
	outp "frndint"
	outp "fldcw [esp]"
	outp "add esp, 4"

	if( not isfree ) then
		emithPOP rname
	end if

end sub

'':::::
sub emitPUSH64( byval sname as string, _
				byval svreg as IRVREG ptr ) static
    dim src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "push " + src2
	outp ostr

	ostr = "push " + src1
	outp ostr

end sub

'':::::
sub emitPUSH( byval sname as string, _
			  byval svreg as IRVREG ptr ) static
    dim src as string, sdsize as integer
    dim ostr as string

	'' longint?
	if( (svreg->dtype = IR.DATATYPE.LONGINT) or (svreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitPUSH64 sname, svreg
		exit sub
	end if

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	sdsize = irGetDataSize( svreg->dtype )

	select case irGetDataClass( svreg->dtype )
	case IR.DATACLASS.INTEGER
		if( svreg->typ = IR.VREGTYPE.REG ) then
			if( sdsize < FB.INTEGERSIZE ) then
				emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, svreg->reg, src )
			end if
		else
			if( sdsize < FB.INTEGERSIZE ) then
				'' !!!FIXME!!! assuming it's okay to push over the var if's not dword aligned
				hPrepOperand( sname, svreg->ofs, IR.DATATYPE.INTEGER, svreg->typ, src )
			end if
		end if

		ostr = "push " + src
		outp ostr

	case IR.DATACLASS.FPOINT
		if( svreg->typ <> IR.VREGTYPE.REG ) then
			if( svreg->dtype = IR.DATATYPE.SINGLE ) then
				ostr = "push " + src
				outp ostr
			else
				ostr = "push dword ptr [" + sname + hGetOfs( svreg->ofs + 4 ) + "]"
				outp ostr

				ostr = "push dword ptr [" + sname + hGetOfs( svreg->ofs + 0 ) + "]"
				outp ostr
			end if
		else
			ostr = "sub esp," + str$( sdsize )
			outp ostr

			ostr = "fstp " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr
		end if
	end select

end sub

'':::::
sub emitPUSHUDT( byval sname as string, _
				 byval svreg as IRVREG ptr, _
				 byval sdsize as integer ) static
    dim i as integer
    dim ostr as string

	'' !!!FIXME!!! assuming it's okay to push over the UDT if's not dword aligned
	for i = 0 to sdsize-1 step 4
		ostr = "push dword ptr [" + sname + hGetOfs( svreg->ofs + i ) + "]"
		outp ostr
	next i

end sub

'':::::
sub emitPOP64( byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim src1 as string, src2 as string
    dim ostr as string

	hPrepOperand64( sname, svreg, src1, src2 )

	ostr = "pop " + src1
	outp ostr

	ostr = "pop " + src2
	outp ostr

end sub

'':::::
sub emitPOP( byval sname as string, _
			 byval svreg as IRVREG ptr ) static
    dim src as string
    dim ostr as string

	'' longint?
	if( (svreg->dtype = IR.DATATYPE.LONGINT) or (svreg->dtype = IR.DATATYPE.ULONGINT) ) then
		emitPOP64 sname, svreg
		exit sub
	end if

	hPrepOperand( sname, svreg->ofs, svreg->dtype, svreg->typ, src )

	select case irGetDataClass( svreg->dtype )
	case IR.DATACLASS.INTEGER
		if( irGetDataSize( svreg->dtype ) > 1  ) then
			ostr = "pop " + src
			outp ostr

		else
			if( svreg->typ = IR.VREGTYPE.REG ) then
				emitGetRegName( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, svreg->reg, src )
				ostr = "pop " + src
				outp ostr
			else

				outp "xchg eax, [esp]"
				emithMOV src, "al"
				if( not regTB(IR.DATACLASS.INTEGER)->isFree( regTB(IR.DATACLASS.INTEGER), EMIT.INTREG.EAX ) ) then
					emithPOP "eax"
				else
					outp "add esp, 4"
				end if
			end if

		end if

	case IR.DATACLASS.FPOINT
		if( svreg->typ <> IR.VREGTYPE.REG ) then
			if( svreg->dtype = IR.DATATYPE.SINGLE ) then
				ostr = "pop " + src
				outp ostr
			else
				ostr = "pop dword ptr [" + sname + hGetOfs( svreg->ofs + 0 ) + "]"
				outp ostr

				ostr = "pop dword ptr [" + sname + hGetOfs( svreg->ofs + 4 ) + "]"
				outp ostr
			end if
		else
			ostr = "fld " + dtypeTB(svreg->dtype).mname + " [esp]"
			outp ostr

			ostr = "add esp," + str$( irGetDataSize( svreg->dtype ) )
			outp ostr
		end if
	end select

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitADDROF( byval dname as string, _
				byval dvreg as IRVREG ptr, _
			    byval sname as string, _
			    byval svreg as IRVREG ptr ) static
	dim ostr as string

	ostr = "lea " + dname + ", [" + sname + hGetOfs( svreg->ofs ) + "]"
	outp ostr

end sub

'':::::
sub emitDEREF( byval dname as string, _
			   byval dvreg as IRVREG ptr, _
			   byval sname as string, _
			   byval svreg as IRVREG ptr ) static
    dim dst as string, src as string
    dim ostr as string

	hPrepOperand( dname, dvreg->ofs, dvreg->dtype, dvreg->typ, dst )
	hPrepOperand( sname, svreg->ofs, IR.DATATYPE.UINT, svreg->typ, src )

	ostr = "mov " + dst + COMMA + src
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitPROCBEGIN( byval proc as FBSYMBOL ptr, _
				   byval initlabel as FBSYMBOL ptr, _
				   byval ispublic as integer ) static
	dim lname as string
	dim id as string

	id = symbGetName( proc )
#ifdef TARGET_LINUX
	outp ".type " + id + ", @function"
#endif

    emithPUSH "ebp"
    outp "mov ebp, esp"

    ctx.procstksetup = seek( ctx.outf )
    outp space$( 32 )

    emithPUSH "ebx"
    emithPUSH "esi"
    emithPUSH "edi"

    ctx.procstkcleanup = seek( ctx.outf )
   	outp space$( 180 )

    lname = symbGetName( initlabel )
    emitLABEL lname

    ''
    ctx.localptr = 0
    ctx.argptr	 = FB.POINTERSIZE + 4			'' skip return address + pushed ebp

end sub

'':::::
sub emitPROCEND( byval proc as FBSYMBOL ptr, _
				 byval bytestopop as integer, _
				 byval initlabel as FBSYMBOL ptr, _
				 byval exitlabel as FBSYMBOL ptr ) static
    dim currpos as integer
    dim bytestoalloc as integer
    dim i as integer
	dim id as string
	dim lname as string

	id = symbGetName( proc )

    bytestoalloc = (-ctx.localptr + 3) and (not 3)

    emithPOP "edi"
    emithPOP "esi"
    emithPOP "ebx"
    outp "mov esp, ebp"
    emithPOP "ebp"
    outp "ret " + ltrim$( str$( bytestopop ) )
#ifdef TARGET_LINUX
    outp ".size " + id + ", .-" + id
#endif

    edbgProcEnd proc, initlabel, exitlabel

	''
	if( bytestoalloc > 0 ) then
		currpos = seek( ctx.outf )

		seek #ctx.outf, ctx.procstksetup
		outEx TABCHAR + "sub" + TABCHAR + "esp," + str$( bytestoalloc ), TRUE

		seek #ctx.outf, ctx.procstkcleanup

		if( env.clopt.cputype >= FB.CPUTYPE.686 ) then
			if( bytestoalloc \ 8 > 7 ) then
				outp "lea edi, [ebp-" + ltrim$( str$( bytestoalloc ) ) + "]"
				outp "mov ecx," + str$( bytestoalloc \ 8 )
				outp "pxor mm0, mm0"
			    lname = symbGetName( initlabel ) + "_init"
			    emitLABEL lname
				outp "movq [edi], mm0"
				outp "add edi, 8"
				outp "dec ecx"
				outp "jnz " + lname
				outp "emms"
			elseif( bytestoalloc \ 8 > 0 ) then
				outp "pxor mm0, mm0"
				for i = bytestoalloc\8 to 1 step -1
					outp "movq [ebp-" + ltrim$( str$( i*8 ) ) + "], mm0"
				next i
				outp "emms"
			end if
			if( bytestoalloc and 4 ) then
				outp "mov dword ptr [ebp-" + ltrim$( str$( bytestoalloc ) ) + "], 0"
			end if
		else
			if( bytestoalloc \ 4 > 4 ) then
				outp "lea edi, [ebp-" + ltrim$( str$( bytestoalloc ) ) + "]"
				outp "mov ecx," + str$( bytestoalloc \ 4 )
				outp "xor eax, eax"
				outEx TABCHAR + "rep stosd", TRUE
			else
				for i = bytestoalloc\4 to 1 step -1
					 outp "mov dword ptr [ebp-" + ltrim$( str$( i*4 ) ) + "], 0"
				next i
			end if
		end if

		seek #ctx.outf, currpos
	end if

end sub

'':::::
function emitAllocLocal( byval lgt as integer, _
						 ofs as integer ) as zstring ptr static

    static as zstring * 3+1 sname = "ebp"

    ctx.localptr -= ((lgt + 3) and not 3)

	ofs = ctx.localptr

	function = @sname

end function

'':::::
sub emitFreeLocal( byval lgt as integer ) static

    ctx.localptr += ((lgt + 3) and not 3)

end sub

'':::::
function emitAllocArg( byval lgt as integer, _
					   ofs as integer ) as zstring ptr static

    static as zstring * 3+1 sname = "ebp"

	ofs = ctx.argptr

    ctx.argptr += ((lgt + 3) and not 3)

	function = @sname

end function

'':::::
sub emitFreeArg( byval lgt as integer ) static

    ctx.argptr -= ((lgt + 3) and not 3)

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitSECTION( byval section as integer ) static
    dim as string ostr

	ostr = NEWLINE + ".section ."

	select case as const section
	case EMIT.SECTYPE.CONST
		ostr += "rodata" + NEWLINE
	case EMIT.SECTYPE.DATA
		ostr += "data" + NEWLINE
	case EMIT.SECTYPE.BSS
		ostr += "bss" + NEWLINE
	case EMIT.SECTYPE.CODE
		ostr += "text" + NEWLINE
	case EMIT.SECTYPE.DIRECTIVE
		ostr += "drectve" + NEWLINE
	end select

	outEx ostr, TRUE

end sub

'':::::
sub emitDATABEGIN( byval lname as string ) static
    dim currpos as integer

	if( ctx.dataend <> 0 ) then
		currpos = seek( ctx.outf )

		seek #ctx.outf, ctx.dataend
		outp ".int " + lname
		seek #ctx.outf, currpos

    end if

end sub

'':::::
sub emitDATAEND static

    '' link + NULL
    outp ".short 0xffff"
    ctx.dataend = seek( ctx.outf )
    outp ".int 0" + space$( FB.MAXNAMELEN )

end sub

'':::::
sub emitDATA ( byval litext as string, _
			   byval litlen as integer, _
			   byval typ as integer ) static

    static as zstring * FB.MAXLITLEN*2+1 esctext
    dim as string ostr

    esctext = hScapeStr( litext )

	'' len + asciiz
	if( typ <> INVALID ) then
		ostr = ".short 0x" + hex$( litlen )
		outp ostr

		ostr = ".ascii \"" + esctext + "\\0\"
		outp ostr
	else
		outp ".short 0x0000"
	end if

end sub

'':::::
sub emitDATAOFS ( byval sname as string ) static
    dim ostr as string

	outp ".short 0xfffe"

	ostr = ".int " + sname
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' initializers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitVARINIBEGIN( byval sym as FBSYMBOL ptr ) static

	emitSECTION EMIT.SECTYPE.DATA

   	if( sym->typ = FB.SYMBTYPE.DOUBLE ) then
    	outEx ".balign 8\n", TRUE
	else
    	outEx ".balign 4\n", TRUE
	end if

	emitLABEL sym->alias

end sub

'':::::
sub emitVARINIEND( byval sym as FBSYMBOL ptr ) static

	emitSECTION EMIT.SECTYPE.CODE

end sub

'':::::
sub emitVARINIi( byval dtype as integer, _
				 byval value as integer ) static

	outp hGetTypeString( dtype ) + " " + str$( value )

end sub

'':::::
sub emitVARINIf( byval dtype as integer, _
				 byval value as double ) static

	outp hGetTypeString( dtype ) + " " + str$( value )

end sub

'':::::
sub emitVARINI64( byval dtype as integer, _
				  byval value as longint ) static

	outp hGetTypeString( dtype ) + " " + str$( value )

end sub

'':::::
sub emitVARINIOFS( byval sname as string ) static
	dim ostr as string

	ostr = ".int " + sname
	outp ostr

end sub

'':::::
sub emitVARINISTR( byval lgt as integer, _
				   byval s as string ) static
    dim ostr as string

	ostr = ".ascii \"" + s + "\\0\""
	outp ostr

end sub

'':::::
sub emitVARINIPAD( byval bytes as integer ) static
    dim ostr as string

	ostr = ".skip " + str$( bytes ) + ",0"
	outp ostr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' high-level
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub hSaveAsmHeader( )
    dim as string entryname, modulename
    dim maininitlabel as FBSYMBOL ptr

   	modulename = hStripPath( hStripExt( env.infile ) )
   	hClearName( modulename )
   	entryname = hMakeEntryPointName( modulename )

	edbgHeader( ctx.outf, env.infile, modulename, entryname )

	hWriteStr( ctx.outf, TRUE,  ".intel_syntax noprefix" )
	select case as const env.clopt.cputype
	case FB.CPUTYPE.386
		hWriteStr( ctx.outf, TRUE,  ".arch i386" )
	case FB.CPUTYPE.486
		hWriteStr( ctx.outf, TRUE,  ".arch i486" )
	case FB.CPUTYPE.586
		hWriteStr( ctx.outf, TRUE,  ".arch i586" )
	case FB.CPUTYPE.686
		hWriteStr( ctx.outf, TRUE,  ".arch i686" )
	end select

    hWriteStr( ctx.outf, FALSE, "" )
    hWriteStr( ctx.outf, TRUE, "#'" + env.infile + "' compilation started at " + time$ + " (" + FB.SIGN + ")" )

    emitSECTION( EMIT.SECTYPE.CODE )

   	hWriteStr( ctx.outf, FALSE, NEWLINE + "#entry point" )
   	hWriteStr( ctx.outf, TRUE,  ".balign 16" + NEWLINE )

   	hWriteStr( ctx.outf, FALSE, ".globl " + entryname )
   	hWriteStr( ctx.outf, FALSE, entryname + ":" )

	if( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE ) then
   		hWriteStr( ctx.outf, TRUE, "call" + TABCHAR + "fb_moduleinit" )
   		hWriteStr( ctx.outf, TRUE, "call" + TABCHAR + EMIT_MAINPROC )
   	end if

    ''
    maininitlabel =  symbAddLabel( "" )
    edbgMainBegin( maininitlabel )

 	hWriteStr( ctx.outf, FALSE, NEWLINE + "#user code" )
   	hWriteStr( ctx.outf, FALSE, EMIT_MAINPROC + ":" )
   	if( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE ) then
   		hWriteStr( ctx.outf, TRUE, "push" + TABCHAR + "ebp" )
   		hWriteStr( ctx.outf, TRUE, "mov" + TABCHAR + "ebp, esp" )
   		hWriteStr( ctx.outf, FALSE, "" )
   	end if

   	emitLABEL( symbGetName( maininitlabel ) )

end sub

'':::::
private sub hEmitInitProc( ) static
    dim as zstring ptr id

    if( env.clopt.outtype <> FB_OUTTYPE_EXECUTABLE ) then
    	exit sub
    end if

    emitSECTION( EMIT.SECTYPE.CODE )

    hWriteStr( ctx.outf, FALSE, "#initialization" )
    hWriteStr( ctx.outf, FALSE, "fb_moduleinit:" )

    hWriteStr( ctx.outf, TRUE,  "finit" )

	select case env.clopt.target
	case FB_COMPTARGET_WIN32
		hWriteStr( ctx.outf, TRUE, "push 0			#argv" )
		hWriteStr( ctx.outf, TRUE, "push 0			#argc" )
	case FB_COMPTARGET_DOS
		hWriteStr( ctx.outf, TRUE, "push [esp+12]	#argv" )
		hWriteStr( ctx.outf, TRUE, "push [esp+12]	#argc" )
	case FB_COMPTARGET_LINUX
		hWriteStr( ctx.outf, TRUE, "lea  eax, [esp+8] " )
		hWriteStr( ctx.outf, TRUE, "push eax	    #argv" )
		hWriteStr( ctx.outf, TRUE, "push [esp+8]	#argc" )
	end select

    id = hCreateProcAlias( "fb_Init", 8, FB.FUNCMODE.STDCALL )
    hWriteStr( ctx.outf, TRUE,  "call" + TABCHAR + *id )
    if( env.clopt.nostdcall ) then
    	hWriteStr( ctx.outf, TRUE,  "add esp, 8" )
    end if

    '' start profiling if requested
    if( env.clopt.profile ) then
	    id = hCreateProcAlias( "fb_ProfileInit", 0, FB.FUNCMODE.CDECL )
	    hWriteStr( ctx.outf, TRUE,  "call" + TABCHAR + *id )
    end if

    '' set default data label (def label isn't global as it could clash with other
    '' modules, so DataRestore alone can't figure out where to start)
    if( symbFindByNameAndClass( FB.DATALABELNAME, FB.SYMBCLASS.LABEL ) <> NULL ) then
    	rtlDataRestore( NULL )
    	irFlush( )
    end if

    hWriteStr( ctx.outf, TRUE,  "ret" )

end sub

'':::::
private sub hEmitFooter( byval tottime as double )

    hWriteStr ctx.outf, FALSE, ""

    '' end( 0 )
    rtlExit( NULL )
    irFlush( )

    '' end() will never return but..
    if( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE ) then
    	hWriteStr ctx.outf, TRUE,  "mov" + TABCHAR + "esp, ebp"
    	hWriteStr ctx.outf, TRUE,  "pop" + TABCHAR + "ebp"
    	hWriteStr ctx.outf, TRUE,  "ret"
    end if

    hWriteStr ctx.outf, FALSE, NEWLINE + TABCHAR + "#'" + env.infile + "' compilation took " + _
    						   str$( tottime ) + " secs"

end sub


'':::::
private function hGetTypeString( byval typ as integer ) as string static
	dim tstr as string

	select case as const typ
    case FB.SYMBTYPE.UBYTE, FB.SYMBTYPE.BYTE, FB.SYMBTYPE.CHAR
    	tstr = ".byte"
    case FB.SYMBTYPE.USHORT, FB.SYMBTYPE.SHORT
    	tstr = ".short"
    case FB.SYMBTYPE.INTEGER, FB.SYMBTYPE.UINT
    	tstr = ".int"
    case FB.SYMBTYPE.LONGINT, FB.SYMBTYPE.ULONGINT
    	tstr = ".quad"
    case FB.SYMBTYPE.SINGLE
		tstr = ".float"
	case FB.SYMBTYPE.DOUBLE
    	tstr = ".double"
	case FB.SYMBTYPE.FIXSTR
    	tstr = ".ascii"
    case FB.SYMBTYPE.STRING
    	tstr = ".int"
	case FB.SYMBTYPE.USERDEF
		tstr = "INVALID"
    case else
    	if( typ >= FB.SYMBTYPE.POINTER ) then
    		tstr = ".int"
    	end if
	end select

	function = tstr

end function

'':::::
private sub hEmitBssHeader( )

    if( ctx.bssheader ) then
    	exit sub
    end if

    hWriteStr ctx.outf, FALSE, NEWLINE + "#global non-initialized vars"
    emitSECTION EMIT.SECTYPE.BSS
    hWriteStr ctx.outf, TRUE,  ".balign 16" + NEWLINE

    ctx.bssheader = TRUE

end sub


'':::::
private sub hEmitBss( ) static
    dim as string alloc, ostr
    dim as FBSYMBOL ptr s
    dim as integer alloctype, elements, doemit

    s = symbGetFirstNode
    do while( s <> NULL )

		doemit = FALSE

		'' var?
		if( s->class = FB.SYMBCLASS.VAR ) then
			'' not initialized?
			if( not s->var.initialized ) then
				'' not emited alreayd?
				if( not s->var.emited ) then
    				'' not extern?
    				if( (s->alloctype and FB.ALLOCTYPE.EXTERN) = 0 ) then
    	    			'' not a string or array descriptor?
    	    			if( s->lgt > 0 ) then
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
    	    alloctype = s->alloctype

	    	elements = 1
    	    if( s->var.array.dims > 0 ) then
    	    	elements = hCalcElements( s )
    	    end if

    	    hEmitBssHeader( )

    	    if( (alloctype and FB.ALLOCTYPE.COMMON) = 0 ) then
    	    	if( (alloctype and FB.ALLOCTYPE.PUBLIC) <> 0 ) then
    	    		emitPUBLIC s->alias
				end if
    	    	alloc = ".lcomm"
			else
    	    	emitPUBLIC s->alias
    	    	alloc = ".comm"
    	    end if

    	    if( s->typ = FB.SYMBTYPE.DOUBLE ) then
    	    	hWriteStr ctx.outf, TRUE, ".balign 8"
    	    else
    	    	hWriteStr ctx.outf, TRUE, ".balign 4"
    	    end if

    	    ostr = alloc + TABCHAR + s->alias + "," + str$( s->lgt * elements )
    	    hWriteStr ctx.outf, TRUE, ostr

    	    edbgGlobalVar( s, EMIT.SECTYPE.BSS )

    	end if

    	s = s->nxt
    loop

end sub

'':::::
private sub hEmitConstHeader( )

    if( ctx.conheader ) then
    	exit sub
    end if

    hWriteStr ctx.outf, FALSE, NEWLINE + "#global initialized constants"
	emitSECTION EMIT.SECTYPE.DATA
    hWriteStr ctx.outf, TRUE,  ".balign 16" + NEWLINE

    ctx.conheader = TRUE

end sub

'':::::
private sub hEmitConst( ) static
    dim as string stext, stype, ostr
    dim as FBSYMBOL ptr s
    dim as integer typ, doemit

    s = symbGetFirstNode
    do while( s <> NULL )

    	doemit = FALSE

    	'' var?
    	if( s->class = FB.SYMBCLASS.VAR ) then
    		'' initialized?
    		if( s->var.initialized ) then
    	    	typ = s->typ
    	    	'' not an udt?
    	    	if( typ <> FB.SYMBTYPE.USERDEF ) then
					'' not string or array descriptors (fix-len's can be 0-len too)
					if( (s->lgt > 0) or (typ = FB.SYMBTYPE.FIXSTR) ) then
                    	doemit = TRUE
    	    		end if
    	    	end if
    	    end if
		end if

    	if( doemit ) then
    		stype = hGetTypeString( typ )
    	    if( typ = FB.SYMBTYPE.FIXSTR ) then
    	    	stext = "\"" + hScapeStr( s->var.inittext ) + "\\0\""
    	    else
    	    	stext = s->var.inittext
    	    end if

    	    hEmitConstHeader

    	    if( typ = FB.SYMBTYPE.DOUBLE ) then
    	    	hWriteStr ctx.outf, TRUE, ".balign 8"
    	    else
    	    	hWriteStr ctx.outf, TRUE, ".balign 4"
    	    end if

    	    ostr = s->alias + ":\t" + stype + TABCHAR + stext
    	    hWriteStr ctx.outf, FALSE, ostr

    	    'edbgGlobalVar( s, EMIT.SECTYPE.CONST )

    	end if

    	s = s->nxt
    loop

end sub

'':::::
private sub hWriteArrayDesc( byval s as FBSYMBOL ptr ) static
	dim as FBVARDIM ptr d
    dim as integer dims, diff, i
    dim as string sname, dname

    '' extern?
    if( (s->alloctype and FB.ALLOCTYPE.EXTERN) > 0 ) then
    	exit sub
    end if

    dims = s->var.array.dims
    diff = s->var.array.dif
    if( dims = 0 ) then
    	exit sub
    end if

    if( symbGetIsDynamic( s ) ) then
    	sname = "0"
	else
    	sname = s->alias
	end if
	dname = symbGetVarDscName( s )

    edbgGlobalVar( symbGetArrayDescriptor( s ), EMIT.SECTYPE.DATA )

    '' COMMON?
    if( (s->alloctype and FB.ALLOCTYPE.COMMON) > 0 ) then
    	if( dims = -1 ) then
    		dims = 1
    	end if

    	emitPUBLIC dname

    	hWriteStr ctx.outf, TRUE, ".balign 4"
    	hWriteStr ctx.outf, TRUE,  ".comm" + TABCHAR + dname + "," + _
    							   str$( FB.ARRAYDESCSIZE + dims * FB.INTEGERSIZE*2 )

    	exit sub
    end if

    '' non COMMON arrays..

    '' public?
    if( (s->alloctype and FB.ALLOCTYPE.PUBLIC) > 0 ) then
    	emitPUBLIC dname
    end if

    hWriteStr ctx.outf, TRUE, ".balign 4"
    hWriteStr ctx.outf, FALSE, dname + ":"

	''	void		*data 	// ptr + diff
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + sname + " +" + str$( diff )
	''	void		*ptr
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + sname
	''	uint		size
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( s->lgt * hCalcElements( s ) )
	''	uint		element_len
    hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( s->lgt )
	''	uint		dimensions
	if( dims = -1 ) then dims = 1
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( dims )

    if( not symbGetIsDynamic( s ) ) then
    	d = s->var.array.dimhead
    	do while( d <> NULL )
			''	uint	dim_elemts
			hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( d->upper - d->lower + 1 )
			''	int		dim_first
			hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( d->lower )
            '' next
			d = d->r
    	loop

    else
        for i = 0 to dims-1
			''	uint	dim_elemts
			hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + "0"
			''	int		dim_first
			hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + "0"
        next i
    end if

end sub

'':::::
private sub hWriteStringDesc( byval s as FBSYMBOL ptr ) static
    dim as string dname

	dname = symbGetVarDscName( s )

    hWriteStr ctx.outf, TRUE, ".balign 4"
    hWriteStr ctx.outf, FALSE, dname + ":"

	''	void		*data
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + s->alias
	''	int			len
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( s->lgt )
	''	int			size
	hWriteStr ctx.outf, TRUE,  ".int" + TABCHAR + str$( s->lgt )

end sub

'':::::
private sub hEmitDataHeader( )

    if( ctx.datheader ) then
    	exit sub
    end if

    hWriteStr ctx.outf, FALSE, NEWLINE + "#global initialized vars"
    emitSECTION EMIT.SECTYPE.DATA
    hWriteStr ctx.outf, TRUE,  ".balign 16" + NEWLINE

    ctx.datheader = TRUE

end sub

'':::::
private sub hEmitData( ) static
    dim as FBSYMBOL ptr s, d

    s = symbGetFirstNode
    do while( s <> NULL )

    	'' var?
    	if( s->class = FB.SYMBCLASS.VAR ) then
    	    '' with descriptor?
    	    d = s->var.array.desc
    	    if( d <> NULL ) then
    	    	'' subtype is an array or string descriptor?
    	    	select case d->subtype
    	    	case FB.DESCTYPE.ARRAY
    	    		hEmitDataHeader
    	    		hWriteArrayDesc s

    	    	case FB.DESCTYPE.STR
    	    		hEmitDataHeader
    	    		hWriteStringDesc s
    	    	end select
    	    end if
    	end if

    	s = s->nxt
    loop

end sub

'':::::
private sub hEmitExportHeader( )

    if( ctx.expheader ) then
    	exit sub
    end if

    hWriteStr ctx.outf, FALSE, NEWLINE + "#exported functions"
    emitSECTION EMIT.SECTYPE.DIRECTIVE

    ctx.expheader = TRUE

end sub

'':::::
private sub hEmitExport( ) static
    dim s as FBSYMBOL ptr
    dim sname as string

    s = symbGetFirstNode
    do while( s <> NULL )

    	if( symbGetClass( s ) = FB.SYMBCLASS.PROC ) then
    		if( symbGetProcIsDeclared( s ) ) then
    			if( (symbGetAllocType( s ) and FB.ALLOCTYPE.EXPORT) > 0 ) then
    				hEmitExportHeader
    				sname = hStripUnderscore( symbGetName( s ) )
    				hWriteStr ctx.outf, TRUE, ".ascii \" -export:" + sname + "\"" + NEWLINE
    			end if
    		end if
    	end if

    	s = symbGetNextNode( s )
    loop

end sub


'':::::
function emitOpen( ) as integer

	if( hFileExists( env.outfile ) ) then
		kill env.outfile
	end if

	ctx.outf = freefile
	if( open( env.outfile, for binary, access read write, as #ctx.outf ) <> 0 ) then
		return FALSE
	end if

	'' header
	hSaveAsmHeader( )

	function = TRUE

end function

'':::::
sub emitClose( byval tottime as double )

    '' footer
    hEmitFooter( tottime )

    ''
    edgbMainEnd( )

	'' const
	hEmitConst( )

	'' data
	hEmitData( )

	'' bss
	hEmitBss( )

	''
	if( env.clopt.export ) then
		hEmitExport( )
	end if

	''
	edbgFooter( )

    '' init proc must be the lastest or GDB will get confused
    hEmitInitProc( )

	''
	if( close( #ctx.outf ) <> 0 ) then
		'' ...
	end if

end sub

'':::::
sub emitDbgLine( byval lnum as integer, byval lname as string )

	edbgLine( lnum, lname )

end sub

'':::::
sub hWriteStr( byval f as integer, byval addtab as integer, byval s as string ) static
    dim as string ostr

	if( addtab ) then
		ostr = TABCHAR + s
	else
		ostr = s
	end if

	ostr += NEWLINE

	if( put( #f, , ostr ) <> 0 ) then
		'' ...
	end if

end sub


