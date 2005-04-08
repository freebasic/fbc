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


'' intermediate representation - virtual registers and three-address-codes management
''
'' obs: 1) the 3-addr-codes are optimized to 2-address, what helps generating better
''         code for CISC, but that will make porting to other CPUs (r-i-g-h-t) hard to do
''		2) operand 2 is never loaded if it's an immediate or variable, again
''         'cause the CISC arch, where every (almost) operation accepts an imm/var src
''      3) stream is flushed on any LABEL, JUMP or CALL emited, as there's no CFG
''         (Control-Flow-Graph), so the optimizations are only done inside each block
''      4) when the 3-addr-code stream is flushed, it's first sent to DAG, where
''         common sub-expressions inside the basic block are eliminated and virtual regs
''         are re-assigned; when the DAG returns, the code is converted to machine-code
''		5) current getDistance function takes too long to execute; to it speed up, a chain
''         for every vreg is needed, but w/o pointers and linked-lists, that's too hard
''
'' chng: sep/2004 written [v1ctor]

defint a-z
option explicit
option escape

'$include once:'inc\fb.bi'
'$include once:'inc\fbint.bi'
'$include once:'inc\reg.bi'
'$include once:'inc\emit.bi'
'$include once:'inc\emitdbg.bi'
'$include once:'inc\ir.bi'
'$include once:'inc\dag.bi'

type IRCTX
	nodes			as integer
	codes			as integer
	currc			as integer					'' current code

	vrnodes			as integer
	vregs			as integer
end type

type IROPCODE
	typ			as integer
	cummutative as integer
	name		as string * 3
end type

type IRTAC
	op			as integer						'' opcode
	vr			as integer						'' result
	v1			as integer						'' operand 1
	v2			as integer						'' operand 2
	ex1			as FBSYMBOL ptr					'' extra field, used by call/jmp
	ex2			as integer						'' /
end type


declare sub 		irCreateTMPVAR		( byval vreg as integer, _
										  vname as string )

declare sub 		irFlushUOP			( byval op as integer, _
										  byval v1 as integer, _
										  byval vr as integer )

declare sub 		irFlushBOP			( byval op as integer, _
										  byval v1 as integer, _
										  byval v2 as integer, _
										  byval vr as integer )

declare sub 		irFlushCOMP			( byval op as integer, _
										  byval v1 as integer, _
										  byval v2 as integer, _
										  byval vr as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		irFlushSTORE		( byval op as integer, _
										  byval v1 as integer, _
										  byval v2 as integer )

declare sub 		irFlushLOAD			( byval op as integer, _
										  byval v1 as integer )

declare sub 		irFlushCONVERT		( byval op as integer, _
										  byval v1 as integer, _
										  byval v2 as integer )

declare sub 		irFlushCALL			( byval op as integer, _
										  byval proc as FBSYMBOL ptr, _
										  byval bytestopop as integer, _
										  byval v1 as integer, _
										  byval vr as integer )

declare sub 		irFlushBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		irFlushSTACK		( byval op as integer, _
										  byval v1 as integer, _
										  byval ex as integer )

declare sub 		irFlushADDR			( byval op as integer, _
										  byval v1 as integer, _
										  byval vr as integer )

declare sub 		irhFreeIDX			( byval vreg as integer, _
										  byval force as integer = FALSE )

declare sub 		irhFreeREG			( byval vreg as integer, _
										  byval force as integer = FALSE )

declare sub 		irOptimize			( )

declare sub 		irDump				( byval op as integer, _
										  byval v1 as integer, _
										  byval v2 as integer, _
										  byval vr as integer )

'' globals
	dim shared ctx as IRCTX

	dim shared regTB(0 to EMIT.REGCLASSES-1) as REGCLASS ptr

	dim shared dtypeTB( 0 to IR.MAXDATATYPES-1 ) as IRDATATYPE
	dim shared opTB( 0 to 255 ) as IROPCODE
	dim shared tacTB( ) as IRTAC
	dim shared vregTB( ) as IRVREG


'' class, size, bits, signed?, name
datatypedata:
data IR.DATACLASS.INTEGER, 0			 	, 0					, FALSE, "void"
data IR.DATACLASS.INTEGER, 1			 	, 8*1				, TRUE , "byte"
data IR.DATACLASS.INTEGER, 1			 	, 8*1				, FALSE, "ubyte"
data IR.DATACLASS.INTEGER, 1			 	, 8*1				, FALSE, "char"
data IR.DATACLASS.INTEGER, 2			 	, 8*2				, TRUE , "short"
data IR.DATACLASS.INTEGER, 2			 	, 8*2				, FALSE, "ushort"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE	, 8*FB.INTEGERSIZE	, TRUE , "integer"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE	, 8*FB.INTEGERSIZE	, FALSE, "uint"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2	, 8*FB.INTEGERSIZE*2, TRUE , "quad"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2	, 8*FB.INTEGERSIZE*2, FALSE, "uquad"
data IR.DATACLASS.FPOINT , 4             	, 8*4				, TRUE , "single"
data IR.DATACLASS.FPOINT , 8			 	, 8*8				, TRUE , "double"
data IR.DATACLASS.STRING , FB.STRSTRUCTSIZE	, 0					, FALSE, "string"
data IR.DATACLASS.STRING , 1			 	, 8*1				, FALSE, "fixstr"
data IR.DATACLASS.INTEGER, 0			 	, 0					, FALSE, "udt"
data IR.DATACLASS.INTEGER, 0			 	, 0					, FALSE, "func"
data IR.DATACLASS.INTEGER, 1			 	, 0					, FALSE, "typedef"

''op, type(binary=0,unary=1,...), cummutative, name
opcodedata:
data IR.OP.LOAD		, IR.OPTYPE.LOAD	, FALSE, "ld"
data IR.OP.STORE	, IR.OPTYPE.STORE	, FALSE, ":="
data IR.OP.ADD		, IR.OPTYPE.BINARY	, TRUE , "+"
data IR.OP.SUB		, IR.OPTYPE.BINARY	, FALSE, "-"
data IR.OP.MUL		, IR.OPTYPE.BINARY	, TRUE , "*"
data IR.OP.DIV		, IR.OPTYPE.BINARY	, FALSE, "/"
data IR.OP.MOD		, IR.OPTYPE.BINARY	, FALSE, "%"
data IR.OP.AND		, IR.OPTYPE.BINARY	, TRUE , "&"
data IR.OP.OR		, IR.OPTYPE.BINARY	, TRUE , "|"
data IR.OP.XOR		, IR.OPTYPE.BINARY	, TRUE , "~"
data IR.OP.EQ		, IR.OPTYPE.COMP	, TRUE , "=="
data IR.OP.GT		, IR.OPTYPE.COMP	, FALSE, ">"
data IR.OP.LT		, IR.OPTYPE.COMP	, FALSE, "<"
data IR.OP.NE		, IR.OPTYPE.COMP	, TRUE , "<>"
data IR.OP.LE		, IR.OPTYPE.COMP	, FALSE, "<="
data IR.OP.GE		, IR.OPTYPE.COMP	, FALSE, ">="
data IR.OP.PUSH		, IR.OPTYPE.STACK	, FALSE, "psh"
data IR.OP.POP		, IR.OPTYPE.STACK	, FALSE, "pop"
data IR.OP.NOT		, IR.OPTYPE.UNARY 	, FALSE, "!"
data IR.OP.NEG		, IR.OPTYPE.UNARY	, FALSE, "-"
data IR.OP.CALLFUNCT, IR.OPTYPE.CALL	, FALSE, "caf"
data IR.OP.JMP		, IR.OPTYPE.BRANCH	, FALSE, "jmp"
data IR.OP.CALL		, IR.OPTYPE.BRANCH	, FALSE, "cal"
data IR.OP.JEQ		, IR.OPTYPE.BRANCH	, FALSE, "jeq"
data IR.OP.JGT		, IR.OPTYPE.BRANCH	, FALSE, "jgt"
data IR.OP.JLT		, IR.OPTYPE.BRANCH	, FALSE, "jlt"
data IR.OP.JNE		, IR.OPTYPE.BRANCH	, FALSE, "jne"
data IR.OP.JLE		, IR.OPTYPE.BRANCH	, FALSE, "jle"
data IR.OP.JGE		, IR.OPTYPE.BRANCH	, FALSE, "jge"
data IR.OP.INTDIV	, IR.OPTYPE.BINARY	, FALSE, "\\"
data IR.OP.TOINT	, IR.OPTYPE.CONVERT	, FALSE, "2i"
data IR.OP.TOFLT	, IR.OPTYPE.CONVERT	, FALSE, "2f"
data IR.OP.LABEL	, IR.OPTYPE.BRANCH	, FALSE, "lbl"
data IR.OP.MOV		, IR.OPTYPE.BINARY	, FALSE, "mov"
data IR.OP.ADDROF	, IR.OPTYPE.ADDRESSING, FALSE, "@"
data IR.OP.DEREF	, IR.OPTYPE.ADDRESSING, FALSE, "*"
data IR.OP.SHL		, IR.OPTYPE.BINARY	, FALSE, "<<"
data IR.OP.SHR		, IR.OPTYPE.BINARY	, FALSE, ">>"
data IR.OP.POW		, IR.OPTYPE.BINARY	, FALSE, "^"
data IR.OP.EQV		, IR.OPTYPE.BINARY	, FALSE, "eqv"
data IR.OP.IMP		, IR.OPTYPE.BINARY	, FALSE, "imp"
data IR.OP.LDFUNCRESULT, IR.OPTYPE.LOAD	, FALSE, "ldr"
data IR.OP.ABS		, IR.OPTYPE.UNARY	, FALSE, "abs"
data IR.OP.SGN		, IR.OPTYPE.UNARY	, FALSE, "sgn"
data IR.OP.CALLPTR	, IR.OPTYPE.CALL	, FALSE, "ca@"
data IR.OP.JUMPPTR	, IR.OPTYPE.CALL	, FALSE, "jm@"
data IR.OP.PUSHUDT	, IR.OPTYPE.STACK	, FALSE, "psh"
data IR.OP.STACKALIGN, IR.OPTYPE.STACK	, FALSE, "alg"

data -1

'':::::
sub irReallocAddrTB( byval nodes as integer ) static
	dim lb as integer, ub as integer

	lb = ctx.nodes
	ub = ctx.nodes + (nodes - 1)

	redim preserve tacTB(0 to ub) as IRTAC

	''
	ctx.nodes = ctx.nodes + nodes

end sub

'':::::
sub irReallocVregTB( byval nodes as integer ) static
	dim lb as integer, ub as integer
	dim i as integer

	lb = ctx.vrnodes
	ub = ctx.vrnodes + (nodes - 1)

	redim preserve vregTB(0 to ub) as IRVREG

	for i = lb to ub
		vregTB(i).typ   = INVALID
		vregTB(i).dtype = INVALID
	next i

	''
	ctx.vrnodes = ctx.vrnodes + nodes

end sub

'':::::
sub irInit
	dim i as integer, op as integer

	''
	restore datatypedata
	for i = 0 to IR.MAXDATATYPES-1
		read dtypeTB(i).class
		read dtypeTB(i).size
		read dtypeTB(i).bits
		read dtypeTB(i).signed
		read dtypeTB(i).dname
	next i


	''
	ctx.nodes	= 0
	ctx.codes	= 0
	ctx.currc	= 0

	irReallocAddrTB IR.INITADDRNODES

	''
	restore opcodedata
	do
		read op
		if( op = -1 ) then exit do
		read opTB(op).typ
		read opTB(op).cummutative
		read opTB(op).name
	loop

	''
	ctx.vrnodes = 0
	ctx.vregs	= 0

	irReallocVregTB IR.INITVREGNODES

	''
	emitInit

	for i = 0 to EMIT.REGCLASSES-1
		regTB(i) = emitGetRegClass( i )
	next i


end sub

'':::::
sub irEnd

	erase vregTB

	erase tacTB

	''
	ctx.codes	= 0
	ctx.currc	= 0
	ctx.vregs	= 0

end sub

'':::::
function irGetDataClass( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	return dtypeTB(dtype).class

end function

'':::::
function irMaxDataType( byval dtype1 as integer, _
						byval dtype2 as integer ) as integer static

    irMaxDataType = -1

    if( dtype1 >= IR.DATATYPE.POINTER ) then
    	dtype1 = IR.DATATYPE.UINT
    end if

    if( dtype2 >= IR.DATATYPE.POINTER ) then
    	dtype2 = IR.DATATYPE.UINT
    end if

    ''
    if( dtype2 = IR.DATATYPE.CHAR ) then
 		select case dtype1
 		case IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
 			exit function
    	end select
    elseif( dtype1 = IR.DATATYPE.CHAR ) then
 		select case dtype2
 		case IR.DATATYPE.BYTE, IR.DATATYPE.UBYTE
 			exit function
    	end select
    end if

    '' don't convert byte <-> char, word <-> short, dword <-> integer, single <-> double
    select case as const dtype1
    case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT, IR.DATATYPE.ULONGINT, IR.DATATYPE.DOUBLE
    	if( dtype1 - dtype2 = 1 ) then
    		exit function
    	end if

    case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR
    	return IR.DATATYPE.STRING

    case else
    	if( dtype1 - dtype2 = -1 ) then
    		exit function
    	end if
    end select

    '' assuming DATATYPE's are in order of precision
    if( dtype1 >= dtype2 ) then
    	return dtype1
    else
    	return dtype2
    end if

end function

'':::::
function irIsSigned( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	return dtypeTB(dtype).signed

end function

'':::::
function irGetDataSize( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	return dtypeTB(dtype).size

end function

'':::::
function irGetDataBits( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	return dtypeTB(dtype).bits

end function

'':::::
function irGetSignedType( byval dtype as integer ) as integer static
	dim dt as integer

	dt = dtype
	if( dt >= IR.DATATYPE.POINTER ) then
		dt = IR.DATATYPE.UINT
	end if

	if( dtypeTB(dt).class <> IR.DATACLASS.INTEGER ) then
		return dtype
	end if

	select case as const dt
	case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT, IR.DATATYPE.ULONGINT
		dtype = dtype - 1						'' hack! assuming sign/unsig are in pairs
	end select

	return dtype

end function

'':::::
function irGetUnsignedType( byval dtype as integer ) as integer static
	dim dt as integer

	dt = dtype
	if( dt >= IR.DATATYPE.POINTER ) then
		dt = IR.DATATYPE.UINT
	end if

	if( dtypeTB(dt).class <> IR.DATACLASS.INTEGER ) then
		return dtype
	end if

	select case as const dt
	case IR.DATATYPE.BYTE, IR.DATATYPE.SHORT, IR.DATATYPE.INTEGER, IR.DATATYPE.LONGINT
		dtype = dtype + 1						'' hack! assuming sign/unsig are in pairs
	case IR.DATATYPE.CHAR
		dtype = IR.DATATYPE.BYTE
	end select

	return dtype

end function

'':::::
sub irhLoadIDX( byval vreg as integer, _
				byval typ as integer )
    dim vi as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	select case typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
	case else
		exit sub
	end select

	'' any vreg attached?
	vi = vregTB(vreg).vi
	if( vi = INVALID ) then
		exit sub
	end if

	'' hack! x86 optimization, don't load immediates to registers
	if( vregTB(vi).typ = IR.VREGTYPE.IMM ) then
		exit sub
	end if

	vregTB(vi).reg = regTB(IR.DATACLASS.INTEGER)->ensure( regTB(IR.DATACLASS.INTEGER), vi )

end sub

'':::::
#define irhGetVREG(vreg,dtype,dclass,typ) 			_
	if( vreg <> INVALID ) then 						: _
		typ = vregTB(vreg).typ 						: _
                                                	: _
		dtype = vregTB(vreg).dtype					: _
		if( dtype >= IR.DATATYPE.POINTER ) then		: _
			dtype  = IR.DATATYPE.UINT				: _
			dclass = IR.DATACLASS.INTEGER			: _
		else										: _
			dclass = dtypeTB(dtype).class			: _
		end if										: _
													: _
	else											: _
		typ    = INVALID							: _
		dtype  = INVALID							: _
		dclass = INVALID							: _
	end if

'':::::
function irGetInverseLogOp( byval op as integer ) as integer static

	select case as const op
	case IR.OP.EQ
		op = IR.OP.NE
	case IR.OP.NE
		op = IR.OP.EQ
	case IR.OP.GT
		op = IR.OP.LE
	case IR.OP.LT
		op = IR.OP.GE
	case IR.OP.GE
		op = IR.OP.LT
	case IR.OP.LE
		op = IR.OP.GT
	end select

	irGetInverseLogOp = op

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irEmitEx( byval op as integer, _
			  byval v1 as integer, _
			  byval v2 as integer, _
			  byval vr as integer, _
			  byval ex1 as FBSYMBOL ptr, _
			  byval ex2 as integer = 0 ) static
    dim p as IRTAC ptr

    if( ctx.codes >= ctx.nodes ) then
    	irReallocAddrTB ctx.nodes \ 2
    end if

    p = @tacTB(ctx.codes)
    ctx.codes = ctx.codes + 1

    p->op  = op
    p->v1  = v1
    p->v2  = v2
    p->vr  = vr
    p->ex1 = ex1
    p->ex2 = ex2

end sub

'':::::
sub irEmit( byval op as integer, _
			byval v1 as integer, _
			byval v2 as integer, _
			byval vr as integer ) static

	irEmitEx op, v1, v2, vr, NULL

end sub

'':::::
sub irEmitCONVERT( byval v1 as integer, _
				   byval dtype1 as integer, _
				   byval v2 as integer, _
				   byval dtype2 as integer ) static

	if( dtype1 >= IR.DATATYPE.POINTER ) then dtype1 = IR.DATATYPE.UINT

	select case dtypeTB(dtype1).class
	case IR.DATACLASS.INTEGER
		irEmit IR.OP.TOINT, v1, v2, INVALID
	case IR.DATACLASS.FPOINT
		irEmit IR.OP.TOFLT, v1, v2, INVALID
	end select

end sub

'':::::
sub irEmitBOP( byval op as integer, _
			   byval v1 as integer, _
			   byval v2 as integer, _
			   byval vr as integer ) static
	irEmit op, v1, v2, vr
end sub

'':::::
sub irEmitBOPEx( byval op as integer, _
				 byval v1 as integer, _
				 byval v2 as integer, _
				 byval vr as integer, _
				 byval ex as FBSYMBOL ptr ) static
	irEmitEx op, v1, v2, vr, ex
end sub

'':::::
sub irEmitUOP( byval op as integer, _
			   byval v1 as integer, _
			   byval vr as integer ) static
	irEmit op, v1, INVALID, vr
end sub

'':::::
sub irEmitSTORE( byval v1 as integer, _
				 byval v2 as integer ) static
	irEmit IR.OP.STORE, v1, v2, INVALID
end sub

'':::::
sub irEmitLOAD( byval op as integer, _
				byval v1 as integer ) static
	irEmit op, v1, INVALID, INVALID
end sub

'':::::
sub irEmitPUSH( byval v1 as integer ) static
	irEmit IR.OP.PUSH, v1, INVALID, INVALID
end sub

'':::::
sub irEmitPUSHUDT( byval v1 as integer, _
				   byval lgt as integer ) static
	irEmitEx IR.OP.PUSHUDT, v1, INVALID, INVALID, NULL, lgt
end sub

'':::::
sub irEmitPOP( byval v1 as integer ) static
	irEmit IR.OP.POP, v1, INVALID, INVALID
end sub

'':::::
sub irEmitADDR( byval op as integer, _
				byval v1 as integer, _
				byval vr as integer ) static
	irEmit op, v1, INVALID, vr
end sub


'':::::
sub irEmitLABEL( byval label as FBSYMBOL ptr, _
				 byval isglobal as integer ) static
    dim lname as string

	irFlush

	lname = symbGetName( label )

	emitLABEL lname

end sub

'':::::
sub irEmitLABELNF( byval label as FBSYMBOL ptr ) static

	irEmitEx IR.OP.LABEL, INVALID, INVALID, INVALID, label

end sub

'':::::
sub irEmitCALLFUNCT( byval proc as FBSYMBOL ptr, _
					 byval bytestopop as integer, _
					 byval vr as integer ) static

    irEmitEx IR.OP.CALLFUNCT, INVALID, INVALID, vr, proc, bytestopop

end sub

'':::::
sub irEmitCALLPTR( byval v1 as integer, _
				   byval vr as integer, _
				   byval bytestopop as integer ) static

    irEmitEx IR.OP.CALLPTR, v1, INVALID, vr, NULL, bytestopop

end sub

'':::::
sub irEmitSTACKALIGN( byval bytes as integer ) static

    irEmitEx IR.OP.STACKALIGN, INVALID, INVALID, INVALID, NULL, bytes

end sub


'':::::
sub irEmitBRANCHPTR( byval v1 as integer ) static

    irEmitEx IR.OP.JUMPPTR, v1, INVALID, INVALID, NULL

end sub

'':::::
sub irEmitBRANCH( byval op as integer, _
				  byval label as FBSYMBOL ptr ) static

    irEmitEx op, INVALID, INVALID, INVALID, label

end sub

'':::::
sub irEmitRETURN( byval bytestopop as integer ) static

	irFlush

	emitRET bytestopop

end sub

'':::::
sub irEmitPROCBEGIN( byval proc as FBSYMBOL ptr, _
					 byval initlabel as FBSYMBOL ptr, _
					 byval endlabel as FBSYMBOL ptr, _
					 byval ispublic as integer ) static
    dim label as integer
    dim id as string

    id = symbGetName( proc )

	''
	irEMITBRANCH IR.OP.JMP, endlabel

	irFlush

	edbgProcBegin proc, ispublic, -1

	''
	if( env.clopt.debug ) then
		emitASM ".asciz " + chr$( CHAR_QUOTE ) + id + chr$( CHAR_QUOTE )
	end if

	emitALIGN 16

	if( ispublic ) then
		emitPUBLIC id
	end if
	emitLABEL id

	emitPROCBEGIN proc, initlabel, ispublic

end sub

'':::::
sub irEmitPROCEND( byval proc as FBSYMBOL ptr, _
				   byval initlabel as FBSYMBOL ptr, _
				   byval exitlabel as FBSYMBOL ptr ) static
    dim bytestopop as integer, mode as integer

    mode = symbGetFuncMode( proc )
    if( (mode = FB.FUNCMODE.CDECL) or ((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
		bytestopop = 0
	else
		bytestopop = symbGetLen( proc )
	end if

	irFlush

	emitPROCEND proc, bytestopop, initlabel, exitlabel

end sub

'':::::
function irEmitPUSHPARAM( byval proc as FBSYMBOL ptr, _
						  byval arg as FBSYMBOL ptr, _
						  byval vr as integer, _
						  byval pmode as integer, _
						  byval plen as integer ) as integer static
    dim as integer vt, isptr
    dim as integer adtype, adclass, amode
    dim as integer pdtype, pdclass, pclass
    dim as FBSYMBOL ptr s, d

	irEmitPUSHPARAM = FALSE

	''
	amode  = symbGetArgMode( proc, arg )
	adtype = symbGetType( arg )
	if( adtype <> INVALID ) then
		adclass = irGetDataClass( adtype )
	end if

	''
	pdtype  = irGetVRDataType( vr )
	pdclass = irGetDataClass( pdtype )

    pclass = irGetVRType( vr )

	'' by descriptor?
	if( amode = FB.ARGMODE.BYDESC ) then

		amode = FB.ARGMODE.BYVAL

    '' var args?
    elseif( amode = FB.ARGMODE.VARARG ) then

    	'' string argument?
    	if( (pdclass = IR.DATACLASS.STRING) or _
    		(pdtype = IR.DATATYPE.CHAR) ) then
			'' not a pointer yet?
			if( pclass = IR.VREGTYPE.PTR ) then
				amode = FB.ARGMODE.BYREF
			else
				amode = FB.ARGMODE.BYVAL
			end if

    	'' otherwise, pass as-is
    	else
    		amode = FB.ARGMODE.BYVAL
    	end if

    '' as any?
    elseif( adtype = IR.DATATYPE.VOID ) then

		if( pmode = FB.ARGMODE.BYVAL ) then

    		'' another quirk: BYVAL strings passed to BYREF ANY args..
    		if( (pdclass = IR.DATACLASS.STRING) or _
    			(pdtype = IR.DATATYPE.CHAR) ) then
    			'' not a pointer yet?
    			if( pclass <> IR.VREGTYPE.PTR ) then
    				amode = FB.ARGMODE.BYVAL
    			else
    				amode = FB.ARGMODE.BYREF
    			end if

    		'' otherwise, pass as-is
    		else
    			amode = FB.ARGMODE.BYVAL
    		end if

    	'' passing an immediate?
    	elseif( irIsIMM( vr ) ) then
        	amode = FB.ARGMODE.BYVAL

    	'' anything else, use the param type to create a temp var if needed
    	else
    		adtype = pdtype
    	end if

    '' byval or byref (but as any)
    else

    	'' string argument?
    	if( adclass = IR.DATACLASS.STRING ) then
			'' not a pointer yet?
			if( pclass = IR.VREGTYPE.PTR ) then
				'' BYVAL or not the mode has to be changed to byref, as
				'' BYVAL AS STRING is actually BYREF AS ZSTRING
				amode = FB.ARGMODE.BYREF
			else
				amode = FB.ARGMODE.BYVAL
			end if
		end if

	end if

	'' push to stack, depending on arg mode
	select case amode
	case FB.ARGMODE.BYVAL

		if( plen = 0 ) then
			irEmitPUSH vr
		else
			irEmitPUSHUDT vr, plen
		end if

	case FB.ARGMODE.BYREF
		'' BYVAL param? pass as-is
		if( pmode = FB.ARGMODE.BYVAL ) then
			irEmitPUSH vr

		else

			isptr = FALSE

			select case pclass
			'' simple pointer?
			case IR.VREGTYPE.PTR
				if( vregTB(vr).ofs = 0 ) then
					isptr = TRUE
				end if

			'' simple index?
			case IR.VREGTYPE.IDX
				if( vregTB(vr).ofs = 0 ) then
					if( vregTB(vr).sym = NULL ) then
						if( vregTB(vr).mult <= 1 ) then
							isptr = TRUE
						end if
					end if
				end if
			end select

			if( isptr ) then
				irEmitPUSH vregTB(vr).vi

			else
				'' byref arg and it's not a var? create a temp one..
				if( not irIsVAR( vr ) ) then
					if( not irIsIDX( vr ) ) then
						s = symbAddTempVar( adtype )
						vt = irAllocVRVAR( adtype, s, s->ofs )
						irEmitSTORE vt, vr
						vr = vt
					end if
				end if

				vt = irAllocVREG( IR.DATATYPE.UINT )
				irEmitADDR IR.OP.ADDROF, vr, vt
				irEmitPUSH vt
			end if

		end if
	end select

	''
	irEmitPUSHPARAM = TRUE

end function

'':::::
sub irEmitVARINIBEGIN( byval sym as FBSYMBOL ptr ) static

	irFlush

	emitVARINIBEGIN sym

end sub

'':::::
sub irEmitVARINIEND( byval sym as FBSYMBOL ptr ) static

	emitVARINIEND sym

end sub

'':::::
sub irEmitVARINI( byval dtype as integer, _
				  byval value as double ) static

	emitVARINI dtype, value

end sub

'':::::
sub irEmitVARINI64( byval dtype as integer, _
					byval value as longint ) static

	emitVARINI64 dtype, value

end sub

'':::::
sub irEmitVARINISTR( byval totlgt as integer, _
				     byval s as string ) static

	dim lgt as integer

	'' zstring * 1?
	if( totlgt = 0 ) then
		emitVARINI IR.DATATYPE.BYTE, 0
		exit sub
	end if

	''
	lgt = len( s )

	if( lgt > totlgt ) then
		emitVARINISTR totlgt, left$( s, totlgt )
	else
		emitVARINISTR lgt, s

		if( lgt < totlgt ) then
			emitVARINIPAD totlgt - lgt
		end if
	end if

end sub

'':::::
sub irEmitVARINIPAD( byval bytes as integer ) static

	emitVARINIPAD bytes

end sub


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function irNewVR( byval dtype as integer, _
				  byval typ as integer ) as integer static
	dim v as integer
	dim p as IRVREG ptr

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	if( ctx.vregs >= ctx.vrnodes ) then
		irReallocVregTB ctx.vrnodes \ 2
	end if

	v = ctx.vregs
	p = @vregTB(v)
	ctx.vregs = ctx.vregs + 1

	p->typ 	= typ
	p->dtype= dtype
	p->sym	= NULL
	p->reg	= INVALID
	p->vi	= INVALID
	p->va	= INVALID
	p->ofs	= 0

	irNewVR = v

end function

'':::::
function irAllocVREG( byval dtype as integer ) as integer static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.REG )

	irAllocVREG = vr

	if( vr = INVALID ) then
		exit function
	end if

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		 vregTB(vr).va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.REG )
	end if

end function

'':::::
function irAllocVRIMM( byval dtype as integer, _
					   byval value as integer ) as integer static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.IMM )

	irAllocVRIMM = vr

	if( vr = INVALID ) then
		exit function
	end if

	vregTB(vr).value = value

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		 vregTB(vr).va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IMM )
		 vregTB(vregTB(vr).va).value = 0
	end if

end function

'':::::
function irAllocVRIMM64( byval dtype as integer, _
						 byval value as longint ) as integer static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.IMM )

	irAllocVRIMM64 = vr

	if( vr = INVALID ) then
		exit function
	end if

	vregTB(vr).value = cuint( value )

	'' aux
	vregTB(vr).va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IMM )

	vregTB(vregTB(vr).va).value = cint( value shr 32 )

end function

'':::::
function irAllocVRVAR( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer ) as integer static
	dim vr as integer, va as integer

	vr = irNewVR( dtype, IR.VREGTYPE.VAR )

	irAllocVRVAR = vr

	if( vr = INVALID ) then
		exit function
	end if

	vregTB(vr).sym 	= symbol
	vregTB(vr).ofs 	= ofs

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.VAR )
		vregTB(vr).va	= va
		vregTB(va).ofs 	= ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irAllocVRIDX( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer, _
					   byval mult as integer, _
					   byval vidx as integer ) as integer static
	dim vr as integer, va as integer

	vr = irNewVR( dtype, IR.VREGTYPE.IDX )

	irAllocVRIDX = vr

	if( vr = INVALID ) then
		exit function
	end if

	vregTB(vr).sym 	= symbol
	vregTB(vr).ofs 	= ofs
	vregTB(vr).mult	= mult
	vregTB(vr).vi 	= vidx

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IDX )
		vregTB(vr).va	= va
		vregTB(va).ofs 	= ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irAllocVRPTR( byval dtype as integer, _
					   byval ofs as integer, _
					   byval vidx as integer ) as integer static
	dim vr as integer, va as integer

	vr = irNewVR( dtype, IR.VREGTYPE.PTR )

	irAllocVRPTR = vr

	if( vr = INVALID ) then
		exit function
	end if

	vregTB(vr).ofs 	= ofs
	vregTB(vr).mult = 1
	vregTB(vr).vi 	= vidx

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IDX )
		vregTB(vr).va	= va
		vregTB(va).ofs 	= ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irIsVAR( byval vreg as integer ) as integer static

	irIsVAR = FALSE

	select case vregTB(vreg).typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		irIsVAR = TRUE
	end select

end function

'':::::
function irIsIDX( byval vreg as integer ) as integer static

	irIsIDX = FALSE

	select case vregTB(vreg).typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		irIsIDX = TRUE
	end select

end function


'':::::
function irGetVRDataClass( byval vreg as integer ) as integer static
	dim dtype as integer

	dtype = vregTB(vreg).dtype

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	irGetVRDataClass = dtypeTB(dtype).class

end function

'':::::
function irGetVRDataSize( byval vreg as integer ) as integer static
	dim dtype as integer

	dtype = vregTB(vreg).dtype

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	irGetVRDataSize = dtypeTB(dtype).size

end function

'':::::
sub irGetVRIndexName( byval vreg as integer, _
					  vname as string )
    dim sym as FBSYMBOL ptr, mult as integer, vi as integer
    dim sname as string

	if( vreg = INVALID ) then
		vname = "NULL"
		exit sub
	end if

    sym = vregTB(vreg).sym
    vi 	= vregTB(vreg).vi
    mult= vregTB(vreg).mult

	if( vi <> INVALID ) then
		irGetVRName( vi, vname )
	else
		vname = ""
	end if

	if( sym <> NULL ) then
		sname = symbGetName( sym )
	else
		sname = ""
	end if

	emitGetIDXName( mult, sname, vname )

end sub

'':::::
sub irGetVRNameEx( byval vreg as integer, _
				   byval typ as integer, _
				   vname as string )
    dim dtype as integer, dclass as integer

	if( vreg = INVALID ) then
		vname = "NULL"
		exit function
	end if

	select case as const typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		vname = symbGetName( vregTB(vreg).sym )

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
	    irGetVRIndexName( vreg, vname )

	case IR.VREGTYPE.IMM
		dtype = vregTB(vreg).dtype
		vname = str$( vregTB(vreg).value )

	case IR.VREGTYPE.REG
		irhGetVREG( vreg, dtype, dclass, typ )
		emitGetRegName( dtype, dclass, vregTB(vreg).reg, vname )

	end select

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irRename( byval vold as integer, _
			  byval vnew as integer ) static
    dim i as integer

	for i = ctx.currc to ctx.codes-1
		if( tacTB(i).v1 = vold ) then
			tacTB(i).v1 = vnew
		elseif( tacTB(i).v2 = vold ) then
			tacTB(i).v2 = vnew
		elseif( tacTB(i).vr = vold ) then
			tacTB(i).vr = vnew
		end if
	next i

	for i = 0 to ctx.vregs-1
		select case vregTB(i).typ
		case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
			if( vregTB(i).vi = vold ) then
				vregTB(i).vi = vnew
			end if
		end select

		if( vregTB(i).va = vold ) then
			vregTB(i).va = vnew
		end if

	next i

end sub

'':::::
sub irReuse( byval i as integer ) static
    dim as integer op
    dim as integer v1, dt1, dc1, t1
    dim as integer v2, dt2, dc2, t2
    dim as integer vr, dtr, dcr, tr
    dim as integer v1rename, v2rename

	op 	 = tacTB(i).op
	v1   = tacTB(i).v1
	v2   = tacTB(i).v2
	vr   = tacTB(i).vr

	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
    irhGetVREG( vr, dtr, dcr, tr )

	select case opTB(op).typ
	case IR.OPTYPE.UNARY
		if( (vr <> v1) and (dtr = dt1) ) then
           	if( irGetDistance( v1 ) = IR.MAXDIST ) then
           		irRename vr, v1
           	end if
		end if

	case IR.OPTYPE.BINARY, IR.OPTYPE.COMP

		if( vr = INVALID ) then
			exit sub
		end if

		'' check if operands have the same class (can happen 'cause the x86 FPU hacks)
		if( dc1 <> dc2 ) then
			exit sub
		end if

		v1rename = FALSE
		if( (vr <> v1) and (dtr = dt1) ) then
           	if( irGetDistance( v1 ) = IR.MAXDIST ) then
           		v1rename = TRUE
           	end if
		end if

		v2rename = FALSE
		if( opTB(op).cummutative ) then
			if( (vr <> v2) and (dtr = dt2) and (t2 <> IR.VREGTYPE.IMM) ) then
           		if( irGetDistance( v2 ) = IR.MAXDIST ) then
           			v2rename = TRUE
           		end if
			end if
		end if

		if( v1rename and v2rename ) then
			if( not irIsREG( v1 ) ) then
           		v1rename = FALSE
			end if
		end if

		if( v1rename ) then
           	irRename vr, v1
		elseif( v2rename ) then
			swap tacTB(i).v1, tacTB(i).v2
			irRename vr, v2
		end if

	end select

end sub

'':::::
sub irFlush static
    dim op as integer, i as integer
    dim v1 as integer, v2 as integer, vr as integer

	if( ctx.codes = 0 ) then
		exit sub
	end if

	'irOptimize

	for i = 0 to ctx.codes-1
		ctx.currc = i

		irReuse i

		op 	 = tacTB(i).op

		v1   = tacTB(i).v1
		v2   = tacTB(i).v2
		vr   = tacTB(i).vr

		''
		'irDump op, v1, v2, vr

        ''
		select case as const opTB(op).typ
		case IR.OPTYPE.UNARY
			irFlushUOP op, v1, vr

		case IR.OPTYPE.BINARY
			irFlushBOP op, v1, v2, vr

		case IR.OPTYPE.COMP
			irFlushCOMP op, v1, v2, vr, tacTB(i).ex1

		case IR.OPTYPE.STORE
			irFlushSTORE op, v1, v2

		case IR.OPTYPE.LOAD
			irFlushLOAD op, v1

		case IR.OPTYPE.CONVERT
			irFlushCONVERT op, v1, v2

		case IR.OPTYPE.STACK
			irFlushSTACK op, v1, tacTB(i).ex2

		case IR.OPTYPE.CALL
			irFlushCALL op, tacTB(i).ex1, tacTB(i).ex2, v1, vr

		case IR.OPTYPE.BRANCH
			irFlushBRANCH op, tacTB(i).ex1

		case IR.OPTYPE.ADDRESSING
			irFlushADDR op, v1, vr
		end select

		''
		'irDump op, v1, v2, vr

	next i

	''
	ctx.codes 	= 0
	ctx.currc	= 0
	ctx.vregs	= 0

end sub

'':::::
sub irFlushBRANCH( byval op as integer, _
				   byval label as FBSYMBOL ptr ) static
    dim lname as string

	lname = symbGetName( label )

	''
	select case as const op
	case IR.OP.LABEL
		emitLABEL lname

	case IR.OP.JMP
		emitJMP lname
	case IR.OP.CALL
		emitCALL lname, 0

	case IR.OP.JLE
		emitBRANCH "jle", lname
	case IR.OP.JGE
		emitBRANCH "jge", lname
	case IR.OP.JLT
		emitBRANCH "jl", lname
	case IR.OP.JGT
		emitBRANCH "jg", lname
	case IR.OP.JEQ
		emitBRANCH "je", lname
	case IR.OP.JNE
		emitBRANCH "jne", lname
	end select

end sub

'':::::
private sub irhPreserveRegs( byval ptrvreg as integer = INVALID ) static
    dim vr as integer, r as integer
    dim dclass as integer, dtype as integer, typ as integer
    dim dname as string, sname as string
    dim fr as integer							'' free reg
    dim npr as integer							'' don't preserve reg (used with CALLPTR)
    dim class as integer

	'' for each reg class
	for class = 0 to EMIT.REGCLASSES-1

    	'' set the register that shouldn't be preserved (used for CALLPTR only)
    	npr = INVALID
    	if( class = IR.DATACLASS.INTEGER ) then
    		if( ptrvreg <> INVALID ) then

    			select case vregTB(ptrvreg).typ
    			case IR.VREGTYPE.REG
    				npr = vregTB(ptrvreg).reg

    			case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
    				ptrvreg = vregTB(ptrvreg).vi
    				if( ptrvreg <> INVALID ) then
    					npr = vregTB(ptrvreg).reg
    				end if
    			end select

    			ptrvreg = INVALID
    		end if
    	end if

		'' for each register on that class
		r = regTB(class)->getFirst( regTB(class) )
		do until( r = INVALID )
			'' if not free
			if( (not regTB(class)->isFree( regTB(class), r )) and (r <> npr) ) then

				'' get the attached vreg
				vr = regTB(class)->getVreg( regTB(class), r )
                irhGetVREG( vr, dtype, dclass, typ )

        		'' if reg is not preserved between calls
        		if( not emitIsRegPreserved( dtype, dclass, r ) ) then

        			'' find a preserved reg to copy to
        			fr = emitGetFreePreservedReg( dtype, dclass )

        			'' if none free, spill reg
        			if( fr = INVALID ) then
        				irStoreVR vr, r

        			'' else, copy it to a preserved reg
        			else
        				fr = regTB(dclass)->allocateReg( regTB(dclass), fr, vr )
        				vregTB(vr).reg = fr
        				''!!!FIXME!!! assumming emitMOV won't check the src and dst reg's
        				emitGetRegName( dtype, dclass, fr, dname )
        				emitGetRegName( dtype, dclass, r, sname )
        				emitMOV dname, @vregTB(vr), sname, @vregTB(vr)

        			end if

        			'' free reg
        			regTB(dclass)->free( regTB(dclass), r )
        		end if
        	end if

        	'' next reg
        	r = regTB(class)->getNext( regTB(class), r )
		loop

	next class

end sub

'':::::
sub irFlushCALL( byval op as integer, _
				 byval proc as FBSYMBOL ptr, _
				 byval bytes2pop as integer, _
				 byval v1 as integer, _
				 byval vr as integer ) static
    dim as string pname
    dim as integer rr, rr2, rdclass, rdtype, rtyp
    dim as integer va, mode

	'' call function
    if( proc <> NULL ) then
    	mode = symbGetFuncMode( proc )
    	if( (mode = FB.FUNCMODE.CDECL) or ((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
			if( bytes2pop = 0 ) then
				bytes2pop = symbGetLen( proc )
			end if
		else
			bytes2pop = 0
		end if

    	'' save used registers and free the FPU stack
    	irhPreserveRegs

		emitCALL symbGetName( proc ), bytes2pop

	'' call or jump to pointer
	else

    	'' if it's a CALL, save used registers and free the FPU stack
    	if( op = IR.OP.CALLPTR ) then
    		irhPreserveRegs v1
    	end if

		'' load pointer
		irhGetVREG( v1, rdtype, rdclass, rtyp )
		irhLoadIDX v1, rtyp
		if( rtyp = IR.VREGTYPE.REG ) then
			rr = regTB(rdclass)->ensure( regTB(rdclass), v1 )
		end if

		irGetVRName( v1, pname )

		'' CALLPTR
		if( op = IR.OP.CALLPTR ) then
			emitCALLPTR pname, @vregTB(v1), bytes2pop
		'' JUMPPTR
		else
			emitBRANCHPTR pname, @vregTB(v1)
		end if

		'' free pointer
		irhFreeREG v1
	end if

	'' load result
	if( vr <> INVALID ) then
		irhGetVREG( vr, rdtype, rdclass, rtyp )

		emitGetResultReg( rdtype, rdclass, rr, rr2 )

		'' longints..
		if( (rdtype = IR.DATATYPE.LONGINT) or (rdtype = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(vr).va
			vregTB(va).reg = regTB(rdclass)->allocateReg( regTB(rdclass), rr2, va )
			vregTB(va).typ = IR.VREGTYPE.REG
		end if

		vregTB(vr).reg = regTB(rdclass)->allocateReg( regTB(rdclass), rr, vr )
		vregTB(vr).typ = IR.VREGTYPE.REG

    	'' fb allows function calls w/o saving the result
		irhFreeREG vr
	end if

end sub

'':::::
sub irFlushSTACK( byval op as integer, _
				  byval v1 as integer, _
				  byval ex as integer ) static
	dim as string dst
	dim as integer r1, t1, dt1, dc1

	''
	if( op = IR.OP.STACKALIGN ) then
		emitSTACKALIGN ex
		exit sub
	end if

	''
	irhGetVREG( v1, dt1, dc1, t1 )

	irhLoadIDX v1, t1

	'' only load fp's, if they are on the fpu stack (x86 assumption)
	if( dc1 = IR.DATACLASS.FPOINT )  then
		if( t1 = IR.VREGTYPE.REG ) then
			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		end if
	end if

	''
	irGetVRName( v1, dst )

	''
	select case op
	case IR.OP.PUSH
		emitPUSH dst, @vregTB(v1)
	case IR.OP.PUSHUDT
		emitPUSHUDT dst, @vregTB(v1), ex
	case IR.OP.POP
		emitPOP dst, @vregTB(v1)
	end select

    ''
	irhFreeREG v1

end sub

'':::::
sub irFlushUOP( byval op as integer, _
			    byval v1 as integer, _
			    byval vr as integer ) static
	dim as string dst, res
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, tr, dtr, dcr
	dim as integer va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX v1, t1
	irhLoadIDX vr, tr


	r1 = INVALID
	rr = INVALID

    ''
    if ( vr <> INVALID ) then
		if( (v1 <> vr) ) then
			'' handle longint
			if( (dtr = IR.DATATYPE.LONGINT) or (dtr = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(vr).va
				vregTB(va).reg = regTB(dcr)->ensure( regTB(dcr), va, FALSE )
			end if

			rr = regTB(dcr)->ensure( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			emitGetRegName( dtr, dcr, rr, res )
		end if
	end if

	'' UOP to self? x86 assumption at AST
	if( vr <> INVALID ) then
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v1).va
			vregTB(va).reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	''
	irGetVRName( v1, dst )

	select case as const op
	case IR.OP.NEG
		emitNEG dst, @vregTB(v1)
	case IR.OP.NOT
		emitNOT dst, @vregTB(v1)

	case IR.OP.ABS
		emitABS dst, @vregTB(v1)
	case IR.OP.SGN
		emitSGN dst, @vregTB(v1)
	end select

    ''
    if ( vr <> INVALID ) then
		if( v1 <> vr ) then
			emitMOV res, @vregTB(vr), dst, @vregTB(v1)
		end if
	end if

    ''
	irhFreeREG v1
	irhFreeREG vr

end sub

'':::::
sub irFlushBOP( byval op as integer, _
				byval v1 as integer, _
				byval v2 as integer, _
				byval vr as integer ) static
	dim as string dst, src, res
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer rr, tr, dtr, dcr
	dim as integer va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX v1, t1
	irhLoadIDX v2, t2
	irhLoadIDX vr, tr

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' BOP to self? (x86 assumption at AST)
	if( vr = INVALID ) then
		if( t2 <> IR.VREGTYPE.IMM ) then		'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(v2).va
				vregTB(va).reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
			t2 = IR.VREGTYPE.REG
		end if

	else
		if( t2 = IR.VREGTYPE.REG ) then			'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(v2).va
				vregTB(va).reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		'' destine allocation comes *after* source, 'cause the FPU stack
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v1).va
			vregTB(va).reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	''
	irGetVRName( v2, src )
	irGetVRName( v1, dst )

    ''
	select case as const op
	case IR.OP.ADD
		emitADD dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.SUB
		emitSUB dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.MUL
		emitMUL dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.DIV
        emitDIV dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.INTDIV
        emitINTDIV dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.MOD
		emitMOD dst, @vregTB(v1), src, @vregTB(v2)

	case IR.OP.SHL
		emitSHL dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.SHR
		emitSHR dst, @vregTB(v1), src, @vregTB(v2)

	case IR.OP.AND
		emitAND dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.OR
		emitOR dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.XOR
		emitXOR dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.EQV
		emitEQV dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.IMP
		emitIMP dst, @vregTB(v1), src, @vregTB(v2)

	case IR.OP.MOV
		emitMOV dst, @vregTB(v1), src, @vregTB(v2)
	end select

    '' not BOP to self?
	if ( vr <> INVALID ) then
		'' result not equal destine? (can happen with DAG optimizations)
		if( (v1 <> vr) ) then
			'' handle longint
			if( (dtr = IR.DATATYPE.LONGINT) or (dtr = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(vr).va
				vregTB(va).reg = regTB(dcr)->ensure( regTB(dcr), va, FALSE )
			end if

			rr = regTB(dcr)->ensure( regTB(dcr), vr )

			emitGetRegName( dtr, dcr, rr, res )
			emitMOV res, @vregTB(vr), dst, @vregTB(v1)
		end if
	end if

    ''
	irhFreeREG v1
	irhFreeREG v2
	irhFreeREG vr

end sub

'':::::
sub irFlushCOMP( byval op as integer, _
				 byval v1 as integer, _
				 byval v2 as integer, _
				 byval vr as integer, _
				 byval label as FBSYMBOL ptr ) static
	dim as string dst, src, res, lname
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer rr, tr, dtr, dcr
	dim as integer va
	dim as integer doload

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX v1, t1
	irhLoadIDX v2, t2
	irhLoadIDX vr, tr

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' load source if it's a reg, or if result was not allocated
	doload = FALSE
	if( vr = INVALID ) then						'' x86 assumption
		if( dc2 = IR.DATACLASS.INTEGER ) then	'' /
			if( t2 <> IR.VREGTYPE.IMM ) then	'' /
				if( dc1 <> IR.DATACLASS.FPOINT ) then
					doload = TRUE
				end if
			end if
		end if
	end if

	if( (t2 = IR.VREGTYPE.REG) or doload ) then
		'' handle longint
		if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v2).va
			vregTB(va).reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
		end if

		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		t2 = IR.VREGTYPE.REG
	end if

	'' destine allocation comes *after* source, 'cause the FPU stack
	if( (vr <> INVALID) and (vr = v1) ) then	'' x86 assumption
		doload = TRUE
	elseif( dc1 = IR.DATACLASS.FPOINT ) then	'' /
		doload = TRUE
	elseif( t1 = IR.VREGTYPE.IMM) then          '' /
		doload = TRUE
	elseif( t2 <> IR.VREGTYPE.REG ) then        '' /
		doload = TRUE
	else
		doload = FALSE
	end if

	if( (t1 = IR.VREGTYPE.REG) or doload ) then
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v1).va
			vregTB(va).reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
	end if

	'' result not equal destine? (can happen with DAG optimizations and floats comparations)
	if( vr <> INVALID ) then
		if( vr <> v1 ) then
			rr = regTB(dcr)->allocate( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			vregTB(vr).reg = rr
			vregTB(vr).typ = tr
			emitGetRegName( dtr, dcr, rr, res )
		end if
	end if

    ''
	if( v2 <> INVALID ) then					'' yet another FOR..LOOP optimization..
		irGetVRName( v2, src )
	else
		src = ""
	end if

	irGetVRName( v1, dst )

	if( vr = v1 ) then
		res = dst
	elseif( vr = INVALID ) then
		res = ""
	end if

	''
	if( label = NULL ) then
		lname = hMakeTmpStr
	else
		lname = symbGetName( label )
	end if

	if( vr = INVALID ) then
		vr = v1
	end if

	''
	select case as const op
	case IR.OP.EQ
		emitEQ res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.NE
		emitNE res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.GT
		emitGT res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.LT
		emitLT res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.LE
		emitLE res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	case IR.OP.GE
		emitGE res, @vregTB(vr), lname, dst, @vregTB(v1), src, @vregTB(v2)
	end select

    ''
	irhFreeREG v1
	irhFreeREG v2
	if( vr <> v1 ) then
		irhFreeREG vr
	end if

end sub

'':::::
sub irFlushSTORE( byval op as integer, _
				  byval v1 as integer, _
				  byval v2 as integer ) static
	dim as string dst, src
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )

	irhLoadIDX v1, t1
	irhLoadIDX v2, t2

	r1 = INVALID
	r2 = INVALID

    '' if dst is a fpoint, only load src if its a reg (x86 assumption)
	if( (t2 = IR.VREGTYPE.REG) or ((t2 <> IR.VREGTYPE.IMM) and (dc1 = IR.DATACLASS.INTEGER)) ) then
		'' handle longint
		if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v2).va
			vregTB(va).reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
		end if

		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
	end if

	''
	irGetVRName( v2, src )
	irGetVRName( v1, dst )

	emitSTORE dst, @vregTB(v1), src, @vregTB(v2)

    ''
	irhFreeREG v1
	irhFreeREG v2

end sub

'':::::
sub irFlushLOAD( byval op as integer, _
				 byval v1 as integer ) static
	dim as string src, dst
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, rr2, vr
	dim as integer va

	''
	irhGetVREG( v1, dt1, dc1, t1 )

	irhLoadIDX v1, t1

	r1 = INVALID

	''
	select case op
	case IR.OP.LOAD
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v1).va
			vregTB(va).reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )

	case IR.OP.LDFUNCRESULT
		if( t1 = IR.VREGTYPE.REG ) then
			'' handle longint
			if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(v1).va
				vregTB(va).reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
			end if

			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )

		end if

		emitGetResultReg( dt1, dc1, rr, rr2 )
		if( rr <> r1 ) then
			vr = irAllocVREG( dt1 )

			'' handle longint
			if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(vr).va
				vregTB(va).reg = regTB(dc1)->allocateReg( regTB(dc1), rr2, va )
				vregTB(va).typ = IR.VREGTYPE.REG
			end if

			vregTB(vr).reg = regTB(dc1)->allocateReg( regTB(dc1), rr, vr )
			vregTB(vr).typ = IR.VREGTYPE.REG

			''
			irGetVRName( v1, src )
			irGetVRName( vr, dst )

			emitLOAD dst, @vregTB(vr), src, @vregTB(v1)

			''
			irhFreeREG vr							'' <-- assuming this is the last operation!!!
		end if
    end select


	''
	irhFreeREG v1

end sub

'':::::
sub irFlushCONVERT( byval op as integer, _
					byval v1 as integer, _
					byval v2 as integer ) static
	dim as string dst, src
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer reuse
	dim as integer va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )

	irhLoadIDX v1, t1
	irhLoadIDX v2, t2

	r1 = INVALID
	r2 = INVALID

    '' hack! if src is a reg and if classes are the same and src won't be used (DAG?), reuse src
	reuse = FALSE
	if( (dc1 = dc2) and (t2 = IR.VREGTYPE.REG) ) then

		'' fp to fp conversion with source already on stack? do nothing..
		if( dc2 = IR.DATACLASS.FPOINT ) then
			r1 				= vregTB(v2).reg
			vregTB(v1).reg 	= r1
			vregTB(v1).typ 	= IR.VREGTYPE.REG
			regTB(dc1)->setOwner( regTB(dc1), r1, v1 )
			vregTB(v2).reg 	= INVALID
			exit sub
		end if

		'' it's an integer, check if used again
		if( irGetDistance( v2 ) = IR.MAXDIST ) then
			'' don't reuse if it's a longint
			if( (irGetDataSize( dt1 ) <> FB.INTEGERSIZE*2) and _
				(irGetDataSize( dt2 ) <> FB.INTEGERSIZE*2) ) then
				reuse = TRUE
			end if
		end if
	end if

	if( reuse ) then
		r1 = vregTB(v2).reg
		t1 = IR.VREGTYPE.REG
		vregTB(v1).reg = r1
		vregTB(v1).typ = t1
		regTB(dc1)->setOwner( regTB(dc1), r1, v1 )

	else
		if( t2 = IR.VREGTYPE.REG ) then			'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = vregTB(v2).va
				vregTB(va).reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = vregTB(v1).va
			vregTB(va).reg = regTB(dc1)->allocate( regTB(dc1), va )
			vregTB(va).typ = IR.VREGTYPE.REG
		end if

		vregTB(v1).reg = regTB(dc1)->allocate( regTB(dc1), v1 )
		vregTB(v1).typ = IR.VREGTYPE.REG
	end if

	''
	irGetVRName( v2, src )
	irGetVRName( v1, dst )

	''
	emitLOAD dst, @vregTB(v1), src, @vregTB(v2)

	if( not reuse ) then
		irhFreeREG v2
	else
		vregTB(v2).reg = INVALID
	end if

	''
	irhFreeREG v1

end sub

'':::::
sub irFlushADDR( byval op as integer, _
				 byval v1 as integer, _
				 byval vr as integer ) static
	dim as string src, dst
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, tr, dtr, dcr

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX v1, t1
	irhLoadIDX vr, tr

	r1 = INVALID
	rr = INVALID

	''
	if( t1 = IR.VREGTYPE.REG ) then				'' x86 assumption
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
	end if

	if( tr = IR.VREGTYPE.REG ) then             '' x86 assumption
		rr  = regTB(dcr)->ensure( regTB(dcr), vr )
	end if

	''
	irGetVRName( v1, src )
	irGetVRName( vr, dst )

	select case op
	case IR.OP.ADDROF
		emitADDROF dst, @vregTB(vr), src, @vregTB(v1)
	case IR.OP.DEREF
		emitDEREF dst, @vregTB(vr), src, @vregTB(v1)
	end select

    ''
	irhFreeREG v1
	irhFreeREG vr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irhFreeIDX( byval vreg as integer, _
				byval force as integer = FALSE )
	dim vi as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	vi = vregTB(vreg).vi
    if( vi <> INVALID ) then
    	if( vregTB(vi).reg <> INVALID ) then
    		irhFreeREG vi, force				'' recursively
    		vregTB(vreg).vi = INVALID
		end if
	end if

end sub

'':::::
sub irhFreeREG( byval vreg as integer, _
				byval force as integer = FALSE )
	dim reg as integer
	dim rdtype as integer, rdclass as integer, rtyp as integer
	dim freereg as integer
	dim va as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	'' free any attached index
	irhFreeIDX vreg, force

	'' aux?
	if( vregTB(vreg).va <> INVALID ) then
		va = vregTB(vreg).va
		if( vregTB(va).reg <> INVALID ) then
			irhFreeREG va
		end if
	end if

    ''
	if( vregTB(vreg).typ <> IR.VREGTYPE.REG ) then
		exit sub
	end if

	reg = vregTB(vreg).reg
	if( reg = INVALID ) then
		exit sub
	end if

	''
	if( not force ) then
		freereg = irGetDistance( vreg ) = IR.MAXDIST
	else
		freereg = TRUE
	end if

	if( freereg ) then
    	irhGetVREG( vreg, rdtype, rdclass, rtyp )
		regTB(rdclass)->free( regTB(rdclass), reg )
		vregTB(vreg).reg = INVALID
	end if

end sub

'':::::
function irGetDistance( byval vreg as integer ) as integer
    dim i as integer, vi as integer, va as integer

	if( vreg = INVALID ) then
		irGetDistance = IR.MAXDIST
		exit function
	end if

	'' check if there's any index with the vreg attached
	vi = INVALID
	va = INVALID
	for i = 0 to ctx.vregs-1
		if( vregTB(i).vi = vreg ) then
			vi = i
			exit for
		end if

		if( vregTB(i).va = vreg ) then
			va = i
			exit for
		end if
	next i

	'' check all 3-addr-codes, skipping the current one
	for i = ctx.currc+1 to ctx.codes-1
		'' vr is not checked, as it doesn't count as an operand
		if( (tacTB(i).v2 = vreg) or (tacTB(i).v1 = vreg) ) then
			irGetDistance = i - (ctx.currc+1)
			exit function
		end if

		if( vi <> INVALID ) then
			if( (tacTB(i).v2 = vi) or (tacTB(i).v1 = vi) ) then
				irGetDistance = i - (ctx.currc+1)
				exit function
			end if
		end if

		if( va <> INVALID ) then
			if( (tacTB(i).v2 = va) or (tacTB(i).v1 = va) ) then
				irGetDistance = i - (ctx.currc+1)
				exit function
			end if
		end if
	next i

	irGetDistance = IR.MAXDIST

end function

'':::::
sub irLoadVR( byval reg as integer, _
			  byval vr as integer, _
			  byval doload as integer ) static
	dim vname as string, rname as string
	dim rvreg as IRVREG
	dim vreg as IRVREG ptr

	vreg = @vregTB(vr)

	if( vreg->typ <> IR.VREGTYPE.REG ) then

		if( doload ) then
			irGetVRName( vr, vname )

			rvreg.typ 	= IR.VREGTYPE.REG
			rvreg.dtype = vreg->dtype
			rvreg.reg	= reg
			rvreg.va	= vreg->va

			emitGetRegName( vreg->dtype, irGetDataClass( vreg->dtype ), reg, rname )

			emitLOAD rname, @rvreg, vname, vreg
		end if

    	'' free any attached reg, forcing if needed
    	irhFreeIDX vr, TRUE

    	vreg->typ = IR.VREGTYPE.REG
    end if

	vreg->reg = reg

end sub

'':::::
sub irCreateTMPVAR( byval vr as integer, _
					vname as string ) static
    dim vreg as IRVREG ptr

	vreg = @vregTB(vr)

	if( vreg->typ <> IR.VREGTYPE.TMPVAR ) then
		vreg->typ	= IR.VREGTYPE.TMPVAR
		vreg->sym	= symbAddTempVar( vreg->dtype )
		vreg->ofs 	= vreg->sym->ofs
		vreg->reg	= INVALID
	end if

	irGetVRNameEx( vr, vreg->typ, vname )

end sub

'':::::
sub irStoreVR( byval vr as integer, _
			   byval reg as integer ) static
	dim vname as string, rname as string
    dim rvreg as IRVREG
	dim vreg as IRVREG ptr, vareg as IRVREG ptr

	vreg = @vregTB(vr)

	if( irGetDistance( vr ) = IR.MAXDIST ) then
		exit sub
	end if

	rvreg.typ		= IR.VREGTYPE.REG
	rvreg.dtype		= vreg->dtype
	rvreg.reg		= reg
	rvreg.va		= vreg->va

	irCreateTMPVAR( vr, vname )

	emitGetRegName( rvreg.dtype, dtypeTB(rvreg.dtype).class, reg, rname )

	emitSTORE vname, vreg, rname, @rvreg

	'' handle longints
	if( (vreg->dtype = IR.DATATYPE.LONGINT) or (vreg->dtype = IR.DATATYPE.ULONGINT) ) then
		vareg = @vregTB(vreg->va)
		if( vareg->typ <> IR.VREGTYPE.TMPVAR ) then
			regTB(IR.DATACLASS.INTEGER)->free( regTB(IR.DATACLASS.INTEGER), vareg->reg )
			vareg->reg = INVALID
			vareg->typ = IR.VREGTYPE.TMPVAR
			vareg->ofs = vreg->ofs + FB.INTEGERSIZE
		end if
	end if

end sub

'':::::
sub irXchgTOS( byval reg as integer ) static
    dim rname as string
    dim rvreg as IRVREG

	emitGetRegName( IR.DATATYPE.DOUBLE, IR.DATACLASS.FPOINT, reg, rname )

	rvreg.typ 	= IR.VREGTYPE.REG
	rvreg.dtype = IR.DATATYPE.DOUBLE
	rvreg.reg	= reg

	emitFXCHG rname, @rvreg

end sub

#if 0
'':::::
sub irDump( byval op as integer, _
			byval v1 as integer, _
			byval v2 as integer, _
			byval vr as integer ) 'static
	dim vname as string

	if( vr <> INVALID ) then
		irGetVRName( vr, vname )
		print "v";ltrim$(str$(vr));"(";vname;":";ltrim$(str$(irGetVRType( vr )));":";ltrim$(str$(irGetVRDataType( vr )));")";chr$( 9 );"= ";
	end if

	if( v1 <> INVALID ) then
		irGetVRName( v1, vname )
		print "v";ltrim$(str$(v1));"(";vname;":";ltrim$(str$(irGetVRType( v1 )));":";ltrim$(str$(irGetVRDataType( v1 )));")";
	end if

	if( vr = INVALID ) then print chr$( 9 ); else print " ";
	print rtrim$(opTB(op).name);

	if( v2 <> INVALID ) then
		irGetVRName( v2, vname )
		print " v";ltrim$(str$(v2));"(";vname;":";ltrim$(str$(irGetVRType( v2 )));":";ltrim$(str$(irGetVRType( v2 )));")"
	else
		print
	end if

end sub
#endif

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#if 0
'':::::
function irGetVRRealValue( byval vreg as integer ) as integer static
    dim rval as integer

	if( vreg = INVALID ) then
		irGetVRRealValue = INVALID
		exit function
	end if

	select case as const vregTB(vreg).typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		rval = vregTB(vreg).sym

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		rval = 1234

	case IR.VREGTYPE.IMM
		rval = vregTB(vreg).value

	case IR.VREGTYPE.REG
		rval = vreg
	end select

	irGetVRRealValue = rval

end function

'':::::
sub irOptimize static
    dim op as integer, class as integer, i as integer, vi as integer
    dim v1 as integer, v2 as integer, vr as integer
    dim vtx1 as integer, vtx2 as integer, vtxo as integer

	if( ctx.codes = 0 ) then
		exit sub
	end if

	for i = 0 to ctx.codes-1

		op 	 = tacTB(i).op
		v1   = tacTB(i).v1
		v2   = tacTB(i).v2
		vr   = tacTB(i).vr

		'class= vregTB(v1).class

        ''
		select case as const opTB(op).typ
		'':::::
		case IR.OPTYPE.BINARY

            'vtx1 = irDagGetLeaf( v1 )
            if( vtx1 = INVALID ) then
            '	vtx1 = irDagNewLeaf( v1 )
            end if

            'vtx2 = irDagGetLeaf( v2 )
            if( vtx2 = INVALID ) then
            '	vtx2 = irDagNewLeaf( v2 )
            end if

            'vtxo = irDagGetNode( op, vtx1, vtx2 )
            if( vtxo = INVALID ) then
            '	vtxo = irDagNewNode( op, vtx1, vtx2, vr )
            else
            '	irDagAddResult vtxo, vr
            end if

		'':::::
		case IR.OPTYPE.STORE
            'vtx1 = irDagGetLeaf( v2 )
            if( vtx1 = INVALID ) then
            '	vtx1 = irDagNewLeaf( v2 )
            end if

            'vtxo = irDagGetNode( op, vtx1, INVALID )
            if( vtxo = INVALID ) then
            '	vtxo = irDagNewNode( op, vtx1, INVALID, v1 )
            else
            '	irDagAddResult vtxo, v1
            end if

		end select

	next i

	'dagTopSort

end sub
#endif
