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

'$include:'inc\fb.bi'
'$include:'inc\fbint.bi'
'$include:'inc\reg.bi'
'$include:'inc\emit.bi'
'$include:'inc\emitdbg.bi'
'$include:'inc\ir.bi'
'$include:'inc\dag.bi'

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

type IR3ADDRCODE
	op			as integer						'' opcode
	vr			as integer						'' result
	v1			as integer						'' operand 1
	v2			as integer						'' operand 2
	ex1			as FBSYMBOL ptr					'' extra field, used by call/jmp
	ex2			as integer						'' /
end type


declare function 	irCreateTMPVAR		( byval vreg as integer ) as string

declare sub 		irFlushUOP			( byval op as integer, byval v1 as integer, byval vr as integer )
declare sub 		irFlushBOP			( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer )
declare sub 		irFlushCOMP			( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval label as FBSYMBOL ptr )
declare sub 		irFlushSTORE		( byval op as integer, byval v1 as integer, byval v2 as integer )
declare sub 		irFlushLOAD			( byval op as integer, byval v1 as integer )
declare sub 		irFlushCONVERT		( byval op as integer, byval v1 as integer, byval v2 as integer )
declare sub 		irFlushCALL			( byval op as integer, byval proc as FBSYMBOL ptr, byval bytestopop as integer, byval v1 as integer, byval vr as integer )
declare sub 		irFlushBRANCH		( byval op as integer, byval label as FBSYMBOL ptr )
declare sub 		irFlushSTACK		( byval op as integer, byval v1 as integer, byval ex as integer )
declare sub 		irFlushADDR			( byval op as integer, byval v1 as integer, byval vr as integer )


declare sub 		irhFreeIDX			( byval vreg as integer )
declare sub 		irhFreeIDXEx		( byval vreg as integer, byval force as integer )
declare sub 		irhFreeREG			( byval vreg as integer )
declare sub 		irhFreeREGEx		( byval vreg as integer, byval force as integer )

declare sub 		irOptimize			( )

declare sub 		irDump				( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer )

'' globals
	dim shared ctx as IRCTX

	dim shared regTB(0 to EMIT.REGCLASSES-1) as REGCLASS ptr

	redim shared dtypeTB( 0 ) as IRDATATYPE
	redim shared opTB( 0 ) as IROPCODE
	redim shared tacTB( 0 ) as IR3ADDRCODE
	redim shared vregTB( 0 ) as IRVREG


'' class, size, signed?, name
datatypedata:
data IR.DATACLASS.INTEGER, 1			 , FALSE, "void"
data IR.DATACLASS.INTEGER, 1			 , TRUE , "char"
data IR.DATACLASS.INTEGER, 1			 , FALSE, "byte"
data IR.DATACLASS.INTEGER, 2			 , TRUE , "short"
data IR.DATACLASS.INTEGER, 2			 , FALSE, "word"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, TRUE , "integer"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, FALSE, "dword"
data IR.DATACLASS.FPOINT , 4             , TRUE , "single"
data IR.DATACLASS.FPOINT , 8			 , TRUE , "double"
data IR.DATACLASS.STRING , 8			 , FALSE, "string"
data IR.DATACLASS.STRING , 0			 , FALSE, "fixstr"
data IR.DATACLASS.INTEGER, 0			 , FALSE, "udt"
data IR.DATACLASS.INTEGER, 0			 , FALSE, "func"

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
data IR.OP.CALL		, IR.OPTYPE.CALL	, FALSE, "cal"
data IR.OP.JMP		, IR.OPTYPE.BRANCH	, FALSE, "jmp"
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

data -1

'':::::
sub irReallocAddrTB( byval nodes as integer ) static
	dim lb as integer, ub as integer

	lb = ctx.nodes
	ub = ctx.nodes + (nodes - 1)

	redim preserve tacTB(0 to ub) as IR3ADDRCODE

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
	redim dtypeTB(0 to IR.MAXDATATYPES-1) as IRDATATYPE

	restore datatypedata
	for i = 0 to IR.MAXDATATYPES-1
		read dtypeTB(i).class
		read dtypeTB(i).size
		read dtypeTB(i).signed
		read dtypeTB(i).dname
	next i


	''
	ctx.nodes	= 0
	ctx.codes	= 0
	ctx.currc	= 0

	irReallocAddrTB IR.INITADDRNODES

	''
	redim opTB(0 to 255) as IROPCODE

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

	erase opTB

	erase tacTB

	erase dtypeTB

	''
	ctx.codes	= 0
	ctx.currc	= 0
	ctx.vregs	= 0

end sub

'':::::
function irGetDataClass( byval dtype as integer ) as integer 'static

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	irGetDataClass = dtypeTB(dtype).class

end function

'':::::
function irMaxDataType( byval dtype1 as integer, byval dtype2 as integer ) as integer 'static

    if( dtype1 >= IR.DATATYPE.POINTER ) then dtype1 = IR.DATATYPE.UINT

    if( dtype2 >= IR.DATATYPE.POINTER ) then dtype2 = IR.DATATYPE.UINT


    irMaxDataType = -1

    '' don't convert byte <-> char, word <-> short, dword <-> integer, single <-> double
    select case dtype1
    case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT, IR.DATATYPE.DOUBLE
    	if( dtype1 - dtype2 = 1 ) then
    		exit function
    	end if
    case IR.DATATYPE.STRING, IR.DATATYPE.FIXSTR
    	irMaxDataType = IR.DATATYPE.STRING
    	exit function
    case else
    	if( dtype1 - dtype2 = -1 ) then
    		exit function
    	end if
    end select

    '' assuming DATATYPE's are in order of precision
    if( dtype1 >= dtype2 ) then
    	irMaxDataType = dtype1
    else
    	irMaxDataType = dtype2
    end if

end function

'':::::
function irIsSigned( byval dtype as integer ) as integer 'static

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	irIsSigned = dtypeTB(dtype).signed

end function

'':::::
function irGetDataSize( byval dtype as integer ) as integer 'static

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	irGetDataSize = dtypeTB(dtype).size

end function

'':::::
function irGetSignedType( byval dtype as integer ) as integer 'static
	dim dt as integer

	dt = dtype
	if( dt >= IR.DATATYPE.POINTER ) then dt = IR.DATATYPE.UINT

	if( dtypeTB(dt).class <> IR.DATACLASS.INTEGER ) then
		irGetSignedType = dtype
		exit function
	end if

	select case dt
	case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT
		dtype = dtype - 1						'' hack! assuming sign/unsig are in pairs
	end select

	irGetSignedType = dtype

end function

'':::::
function irGetUnsignedType( byval dtype as integer ) as integer 'static
	dim dt as integer

	dt = dtype
	if( dt >= IR.DATATYPE.POINTER ) then dt = IR.DATATYPE.UINT

	if( dtypeTB(dt).class <> IR.DATACLASS.INTEGER ) then
		irGetUnsignedType = dtype
		exit function
	end if

	select case dt
	case IR.DATATYPE.BYTE, IR.DATATYPE.SHORT, IR.DATATYPE.INTEGER
		dtype = dtype + 1						'' hack! assuming sign/unsig are in pairs
	end select

	irGetUnsignedType = dtype

end function

'':::::
sub irhLoadIDX( byval vreg as integer, byval dtype as integer, byval dclass as integer, byval typ as integer ) 'static
    dim vi as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	'' idx?
	if( (typ <> IR.VREGTYPE.IDX) and (typ <> IR.VREGTYPE.PTR) ) then
		exit sub
	end if

	'' any vreg attached?
	vi = vregTB(vreg).vi
	if( vi = INVALID ) then
		exit sub
	end if

	'' hack! x86 optimization, don't load immediates to registers
	if( vregTB(vi).typ = IR.VREGTYPE.IMM ) then
		exit sub
	end if

	vregTB(vi).r   = regTB(IR.DATACLASS.INTEGER)->ensure( regTB(IR.DATACLASS.INTEGER), vi )

end sub

'':::::
sub irhGetVREG( byval vreg as integer, dtype as integer, dclass as integer, typ as integer ) 'static

	if( vreg <> INVALID ) then
		typ	= vregTB(vreg).typ

		dtype = vregTB(vreg).dtype
		if( dtype >= IR.DATATYPE.POINTER ) then
			dtype  = IR.DATATYPE.UINT
			dclass = IR.DATACLASS.INTEGER
		else
			dclass = dtypeTB(dtype).class
		end if

	else
		typ    = INVALID
		dtype  = INVALID
		dclass = INVALID
	end if

end sub

'':::::
function irGetInverseLogOp( byval op as integer ) as integer 'static

	select case op
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
sub irEmitEx( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex1 as FBSYMBOL ptr, byval ex2 as integer = 0 ) 'static
    dim i as integer

    if( ctx.codes >= ctx.nodes ) then
    	irReallocAddrTB ctx.nodes \ 2
    end if

    i = ctx.codes

    tacTB(i).op  = op
    tacTB(i).v1  = v1
    tacTB(i).v2  = v2
    tacTB(i).vr  = vr
    tacTB(i).ex1 = ex1
    tacTB(i).ex2 = ex2

    ctx.codes = ctx.codes + 1

end sub

'':::::
sub irEmit( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer ) 'static

	irEmitEx op, v1, v2, vr, NULL

end sub

'':::::
sub irEmitCONVERT( byval v1 as integer, byval dtype1 as integer, byval v2 as integer, byval dtype2 as integer ) 'static

	if( dtype1 >= IR.DATATYPE.POINTER ) then dtype1 = IR.DATATYPE.UINT

	select case dtypeTB(dtype1).class
	case IR.DATACLASS.INTEGER
		irEmit IR.OP.TOINT, v1, v2, INVALID
	case IR.DATACLASS.FPOINT
		irEmit IR.OP.TOFLT, v1, v2, INVALID
	end select

end sub

'':::::
sub irEmitBOP( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer ) 'static
	irEmit op, v1, v2, vr
end sub

'':::::
sub irEmitBOPEx( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval ex as FBSYMBOL ptr ) 'static
	irEmitEx op, v1, v2, vr, ex
end sub

'':::::
sub irEmitUOP( byval op as integer, byval v1 as integer, byval vr as integer ) 'static
	irEmit op, v1, INVALID, vr
end sub

'':::::
sub irEmitSTORE( byval v1 as integer, byval v2 as integer ) 'static
	irEmit IR.OP.STORE, v1, v2, INVALID
end sub

'':::::
sub irEmitLOAD( byval op as integer, byval v1 as integer ) 'static
	irEmit op, v1, INVALID, INVALID
end sub

'':::::
sub irEmitPUSH( byval v1 as integer ) 'static
	irEmit IR.OP.PUSH, v1, INVALID, INVALID
end sub

'':::::
sub irEmitPUSHUDT( byval v1 as integer, byval lgt as integer ) 'static
	irEmitEx IR.OP.PUSHUDT, v1, INVALID, INVALID, NULL, lgt
end sub

'':::::
sub irEmitPOP( byval v1 as integer ) 'static
	irEmit IR.OP.POP, v1, INVALID, INVALID
end sub

'':::::
sub irEmitADDR( byval op as integer, byval v1 as integer, byval vr as integer ) 'static
	irEmit op, v1, INVALID, vr
end sub


'':::::
sub irEmitLABEL( byval label as FBSYMBOL ptr, byval isglobal as integer ) 'static
    dim lname as string

	irFlush										'' needed? (no way to know if label is ever called)

	lname = symbGetLabelName( label )

	emitLABEL lname, isglobal

end sub

'':::::
sub irEmitLABELNF( byval label as FBSYMBOL ptr ) 'static

	irEmitEx IR.OP.LABEL, INVALID, INVALID, INVALID, label

end sub

'':::::
sub irEmitCALL( pname as string, byval bytestopop as integer, byval isglobal as integer ) 'static

    irFlush										'' needed? (only if passing any param by ref?)

    emitCALL pname, bytestopop, isglobal

end sub

'':::::
sub irEmitCALLSUB( byval proc as FBSYMBOL ptr ) 'static
    dim pname as string, bytes2pop as integer, mode as integer

    irFlush										'' needed? (only if passing any param by ref?)

    mode = symbGetFuncMode( proc )
    if( (mode = FB.FUNCMODE.CDECL) or ((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
		bytes2pop = symbGetArgsLen( proc )
	else
		bytes2pop = 0
	end if

	pname = symbGetProcName( proc )
	emitCALL pname, bytes2pop, TRUE

end sub

'':::::
sub irEmitCALLFUNCT( byval proc as FBSYMBOL ptr, byval bytestopop as integer, byval vr as integer ) 'static

    irEmitEx IR.OP.CALL, INVALID, INVALID, vr, proc, bytestopop

end sub

'':::::
sub irEmitCALLPTR( byval v1 as integer, byval vr as integer, byval bytestopop as integer ) 'static

    irEmitEx IR.OP.CALLPTR, v1, INVALID, vr, NULL, bytestopop

end sub

'':::::
sub irEmitBRANCHPTR( byval v1 as integer ) 'static

    irEmitEx IR.OP.JUMPPTR, v1, INVALID, INVALID, NULL

end sub

'':::::
sub irEmitBRANCH( byval op as integer, byval label as FBSYMBOL ptr, byval isglobal as integer ) 'static
	dim lname as string

    irFlush

    lname = symbGetLabelName( label )

    select case op
    case IR.OP.JMP
    	emitJMP lname, isglobal
    case IR.OP.JLE
    	emitJLE lname, isglobal
    end select

end sub

'':::::
sub irEmitBRANCHNF( byval op as integer, byval label as FBSYMBOL ptr ) 'static

    irEmitEx op, INVALID, INVALID, INVALID, label

end sub

'':::::
sub irEmitCOMPBRANCH( byval op as integer, byval v1 as integer, byval v2 as integer, byval label as FBSYMBOL ptr ) 'static

    irFlush

    irFlushCOMP op, v1, v2, INVALID, label

end sub

'':::::
sub irEmitCOMPBRANCHNF( byval op as integer, byval v1 as integer, byval v2 as integer, byval label as FBSYMBOL ptr ) 'static

    irEmitEx op, v1, v2, INVALID, label

end sub

'':::::
sub irEmitRETURN( byval bytestopop as integer ) 'static

	irFlush

	emitRET bytestopop

end sub

'':::::
sub irEmitPROCBEGIN( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval endlabel as FBSYMBOL ptr, byval ispublic as integer ) 'static
    dim label as integer
    dim id as string

    id = symbGetProcName( proc )

	''
	irEMITBRANCH IR.OP.JMP, endlabel, FALSE

	edbgProcBegin proc, ispublic, -1

	''
	if( env.clopt.debug ) then
		emitASM ".asciz " + chr$( CHAR_QUOTE ) + id + chr$( CHAR_QUOTE )
	end if

	emitALIGN 16

	if( ispublic ) then
		emitPUBLIC id
	end if
	emitLABEL id, TRUE

	emitPROCBEGIN proc, initlabel, ispublic

end sub

'':::::
sub irEmitPROCEND( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval exitlabel as FBSYMBOL ptr ) 'static
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
function irEmitPUSHPARAM( byval proc as FBSYMBOL ptr, byval arg as FBPROCARG ptr, _
						  byval vr as integer, byval pmode as integer, byval plen as integer ) as integer 'static
    dim vt as integer, vp as integer
    dim atype as integer, aclass as integer
    dim ptype as integer, pclass as integer, psize as integer
    dim s as FBSYMBOL ptr, amode as integer, typ as integer, isfixed as integer, desc as FBSYMBOL ptr

	irEmitPUSHPARAM = FALSE

	amode = symbGetArgMode( proc, arg )

	'' convert param to arg type if needed
	atype  = symbGetArgDataType( proc, arg )
	aclass = irGetDataClass( atype )
	ptype  = irGetVRDataType( vr )
	pclass = irGetDataClass( ptype )
	psize  = irGetDataSize( ptype )

    typ = irGetVRType( vr )

	'print symbGetProcName(proc), arg, atype; aclass, ptype; pclass

	'' process by descriptor arguments..
	if( amode = FB.ARGMODE.BYDESC ) then

        '' param is an pointer
        if( pmode = FB.ARGMODE.BYVAL ) then
            amode = FB.ARGMODE.BYVAL

        '' param is an identifier
        else

			s = vregTB(vr).s
			'' not an argument passed by descriptor?
			if ( (symbGetAllocType( s ) and FB.ALLOCTYPE.ARGUMENTBYDESC) = 0 ) then
				ptype = IR.DATATYPE.VOID
        		vr = irAllocVRVAR( ptype, symbGetArrayDescriptor( s ), 0 )
        		amode = FB.ARGMODE.BYREF

        	'' it's already a descriptor pointer, pass as-is
        	else
        		vr = irAllocVRVAR( IR.DATATYPE.UINT, s, 0 )
        		amode = FB.ARGMODE.BYVAL
        	end if

        end if

    ''
    elseif( atype <> IR.DATATYPE.VOID ) then

    	'' string argument?
    	if( aclass = IR.DATACLASS.STRING ) then
			'' byval and fixed/byte ptr/ptr   	: pass the pointer as-is
			'' byval and variable				: pass the pointer at ofs 0 of the string descriptor
			'' byref and variable				: pass the pointer to descriptor
			'' byref and fixed/byte ptr   		: alloc a temp string, copy fixed to temp, pass temp,
			''					   				  copy temp back to fixed when func returns, del temp
			if( amode = FB.ARGMODE.BYVAL ) then

				'' do not check byte ptr or byval ptrs
				if( pclass = IR.DATACLASS.STRING ) then
					amode = FB.ARGMODE.BYREF
					'' not fixed-len? deref var-len (ptr at offset 0)
					if( ptype <> IR.DATATYPE.FIXSTR ) then
            			vt = irAllocVREG( IR.DATATYPE.UINT )
            			vregTB(vr).dtype = IR.DATATYPE.UINT
            			irEmitADDR IR.OP.DEREF, vr, vt
            			vr = irAllocVRPTR( IR.DATATYPE.STRING, 0, vt )
            			typ = IR.VREGTYPE.PTR
            		end if
				end if

			end if

			'' descriptor or fixed-len? get the address of
			if( typ <> IR.VREGTYPE.PTR ) then
				if( pclass = IR.DATACLASS.STRING ) then
					vp = irAllocVREG( IR.DATATYPE.UINT )
					irEmitADDR IR.OP.ADDROF, vr, vp
					vr = irAllocVRPTR( IR.DATATYPE.STRING, 0, vp )
					typ = IR.VREGTYPE.PTR
				end if
			end if

		else
	        '' passing a BYVAL ptr to an BYREF arg?
			if( (pmode = FB.ARGMODE.BYVAL) and (amode = FB.ARGMODE.BYREF) ) then

			'' UDT arg? check if the same, can't convert
			elseif( atype = IR.DATATYPE.USERDEF ) then

			''
			else
				if( (aclass <> pclass) or (irGetDataSize( atype ) <> psize) ) then
					vt = irAllocVREG( atype )
					irEmitCONVERT vt, atype, vr, ptype
					vr = vt
					ptype = atype
				end if
			end if
		end if

	'' another quirk: BYVAL strings passed to BYREF ANY args..
	else
		if( (pclass = IR.DATACLASS.STRING) and (pmode = FB.ARGMODE.BYVAL) ) then

			if( ptype <> IR.DATATYPE.FIXSTR ) then
            	vt = irAllocVREG( IR.DATATYPE.UINT )
            	vregTB(vr).dtype = IR.DATATYPE.UINT
            	irEmitADDR IR.OP.DEREF, vr, vt
            	vr = vt
			else
				vp = irAllocVREG( IR.DATATYPE.UINT )
				irEmitADDR IR.OP.ADDROF, vr, vp
				vr = vp
			end if

			amode = FB.ARGMODE.BYVAL
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

		'' simple pointer?
		elseif( (typ = IR.VREGTYPE.PTR) and (vregTB(vr).ofs = 0) ) then

			irEmitPUSH vregTB(vr).vi

		'' simple index?
		elseif( (typ = IR.VREGTYPE.IDX) and (vregTB(vr).ofs = 0) and _
				(vregTB(vr).s = NULL) and (vregTB(vr).lgt <= 1) ) then

			irEmitPUSH vregTB(vr).vi

		else

			if( (atype = IR.DATATYPE.VOID) and irIsIMM( vr ) ) then
				irEmitPUSH vr

			else
				if( not irIsVAR( vr ) and not irIsIDX( vr ) ) then
					typ = hDtype2Stype( atype )
					s = symbAddTempVar( typ )
					vt = irAllocVRVAR( atype, s, 0 )
					irEmitSTORE vt, vr
					vr = vt
				end if

				vp = irAllocVREG( IR.DATATYPE.UINT )
				irEmitADDR IR.OP.ADDROF, vr, vp
				irEmitPUSH vp
			end if

		end if
	end select

	''
	irEmitPUSHPARAM = TRUE

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function irNewVR( byval dtype as integer, byval typ as integer ) as integer 'static
	dim v as integer

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	if( ctx.vregs >= ctx.vrnodes ) then
		irReallocVregTB ctx.vrnodes \ 2
	end if

	v = ctx.vregs
	ctx.vregs = ctx.vregs + 1

	vregTB(v).typ 	= typ
	vregTB(v).dtype	= dtype
	vregTB(v).s		= NULL
	vregTB(v).r		= INVALID
	vregTB(v).vi	= INVALID

	irNewVR = v

end function

'':::::
function irAllocVREG( byval dtype as integer ) as integer 'static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.REG )

	irAllocVREG = vr

	if( vr = INVALID ) then exit function

end function

'':::::
function irAllocVRIMM( byval dtype as integer, byval value as integer ) as integer 'static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.IMM )

	irAllocVRIMM = vr

	if( vr = INVALID ) then exit function

	vregTB(vr).value = value

end function

'':::::
function irAllocVRVAR( byval dtype as integer, byval symbol as FBSYMBOL ptr, byval ofs as integer ) as integer 'static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.VAR )

	irAllocVRVAR = vr

	if( vr = INVALID ) then exit function

	vregTB(vr).s 	= symbol
	vregTB(vr).ofs 	= ofs

end function

'':::::
function irAllocVRIDX( byval dtype as integer, byval symbol as FBSYMBOL ptr, byval ofs as integer, byval lgt as integer, byval vidx as integer ) as integer 'static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.IDX )

	irAllocVRIDX = vr

	if( vr = INVALID ) then exit function

	vregTB(vr).s 	= symbol
	vregTB(vr).ofs 	= ofs
	vregTB(vr).lgt 	= lgt
	vregTB(vr).vi 	= vidx

end function

'':::::
function irAllocVRPTR( byval dtype as integer, byval ofs as integer, byval vidx as integer ) as integer 'static
	dim vr as integer

	vr = irNewVR( dtype, IR.VREGTYPE.PTR )

	irAllocVRPTR = vr

	if( vr = INVALID ) then exit function

	vregTB(vr).ofs 	= ofs
	vregTB(vr).lgt 	= 1
	vregTB(vr).vi 	= vidx

end function

'':::::
function irCloneVR( byval src as integer ) as integer 'static
    dim dst as integer

	dst = irNewVR( vregTB(src).dtype, vregTB(src).typ )

	if( dst <> INVALID ) then
		vregTB(dst) = vregTB(src)
	end if

	irCloneVR = dst

end function

'':::::
sub irCopyVR( byval src as integer, byval dst as integer ) 'static

	if( dst <> INVALID ) then
		vregTB(dst) = vregTB(src)
	end if

end sub

'':::::
function irIsREG( byval vreg as integer ) as integer 'static

	if( vregTB(vreg).typ = IR.VREGTYPE.REG ) then
		irIsREG = TRUE
	else
		irIsREG = FALSE
	end if

end function

'':::::
function irIsIMM( byval vreg as integer ) as integer 'static

	if( vregTB(vreg).typ = IR.VREGTYPE.IMM ) then
		irIsIMM = TRUE
	else
		irIsIMM = FALSE
	end if

end function

'':::::
function irIsVAR( byval vreg as integer ) as integer 'static

	irIsVAR = FALSE

	select case vregTB(vreg).typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		irIsVAR = TRUE
	end select

end function

'':::::
function irIsIDX( byval vreg as integer ) as integer 'static

	irIsIDX = FALSE

	select case vregTB(vreg).typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		irIsIDX = TRUE
	end select

end function

'':::::
function irGetVRValue( byval vreg as integer ) as integer 'static
	irGetVRValue = vregTB(vreg).value
end function

'':::::
function irGetVRDataType( byval vreg as integer ) as integer 'static
	irGetVRDataType = vregTB(vreg).dtype
end function

'':::::
function irGetVRDataClass( byval vreg as integer ) as integer 'static
	dim dtype as integer

	dtype = vregTB(vreg).dtype

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	irGetVRDataClass = dtypeTB(dtype).class

end function

'':::::
function irGetVRDataSize( byval vreg as integer ) as integer 'static
	dim dtype as integer

	dtype = vregTB(vreg).dtype

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	irGetVRDataSize = dtypeTB(dtype).size

end function

'':::::
function irGetVARSymbol( byval vreg as integer ) as FBSYMBOL ptr 'static
	irGetVARSymbol = vregTB(vreg).s
end function

'':::::
function irGetVAROffset( byval vreg as integer ) as integer 'static
	irGetVAROffset = vregTB(vreg).ofs
end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irRename( byval vold as integer, byval vnew as integer ) 'static
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
	next i

end sub

'':::::
sub irReuse( byval i as integer ) 'static
    dim op as integer
    dim v1 as integer, dt1 as integer, dc1 as integer, t1 as integer
    dim v2 as integer, dt2 as integer, dc2 as integer, t2 as integer
    dim vr as integer, dtr as integer, dcr as integer, tr as integer
    dim v1rename as integer, v2rename as integer

	op 	 = tacTB(i).op
	v1   = tacTB(i).v1
	v2   = tacTB(i).v2
	vr   = tacTB(i).vr

	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG v2, dt2, dc2, t2
    irhGetVREG vr, dtr, dcr, tr

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
sub irFlush 'static
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
		select case opTB(op).typ
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
sub irFlushBRANCH( byval op as integer, byval label as FBSYMBOL ptr ) 'static
    dim lname as string

	lname = symbGetLabelName( label )

	''
	select case op
	case IR.OP.LABEL
		emitLABEL lname, FALSE

	case IR.OP.JMP
		emitJMP lname, FALSE

	case IR.OP.JLE
		emitBRANCH "jle", lname, FALSE
	case IR.OP.JGE
		emitBRANCH "jge", lname, FALSE
	case IR.OP.JLT
		emitBRANCH "jl", lname, FALSE
	case IR.OP.JGT
		emitBRANCH "jg", lname, FALSE
	case IR.OP.JEQ
		emitBRANCH "je", lname, FALSE
	case IR.OP.JNE
		emitBRANCH "jne", lname, FALSE
	end select

end sub

'':::::
private sub irhPreserveRegs 'static
    dim vr as integer, r as integer
    dim dclass as integer, dtype as integer, typ as integer
    dim fr as integer
    dim class as integer

	'' for each reg class
	for class = 0 to EMIT.REGCLASSES-1

		'' for each register on that class
		r = regTB(class)->getFirst( regTB(class) )
		do until( r = INVALID )
			'' if not free
			if( not regTB(class)->isFree( regTB(class), r ) ) then

				'' get the attached vreg
				vr = regTB(class)->getVreg( regTB(class), r )
                irhGetVREG vr, dtype, dclass, typ

        		'' if reg is not preserved between calls
        		if( not emitIsRegPreserved( dtype, dclass, r ) ) then

        			'' find a preserved reg to copy to
        			fr = emitGetFreePreservReg( dtype, dclass )

        			'' if none free, spill reg
        			if( fr = INVALID ) then
        				irStoreVR vr, r

        			'' else, copy it to a preserved reg
        			else
        				fr = regTB(dclass)->allocateReg( regTB(dclass), fr, vr )
        				vregTB(vr).r = fr
        				emitMOV emitGetRegName( dtype, dclass, fr ), dtype, dclass, IR.VREGTYPE.REG, _
        						emitGetRegName( dtype, dclass, r ), dtype, dclass, IR.VREGTYPE.REG
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
sub irFlushCALL( byval op as integer, byval proc as FBSYMBOL ptr, byval bytes2pop as integer, byval v1 as integer, byval vr as integer ) 'static
    dim pname as string, mode as integer
    dim rr as integer, rdclass as integer, rdtype as integer, rtyp as integer

    if( proc <> NULL ) then
    	mode = symbGetFuncMode( proc )
    	if( (mode = FB.FUNCMODE.CDECL) or ((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
			if( bytes2pop = 0 ) then
				bytes2pop = symbGetArgsLen( proc )
			end if
		else
			bytes2pop = 0
		end if
	end if

    '' save used registers and free FPU stack
    irhPreserveRegs

	'' call ptr
	if( proc = NULL ) then

		irhGetVREG v1, rdtype, rdclass, rtyp
		irhLoadIDX v1, rdtype, rdclass, rtyp
		if( rtyp = IR.VREGTYPE.REG ) then
			rr = regTB(rdclass)->ensure( regTB(rdclass), v1 )
		end if

		pname = irGetVRName( v1 )

		if( op = IR.OP.CALLPTR ) then
			emitCALLPTR pname, rdtype, rdclass, rtyp, bytes2pop
		else
			emitBRANCHPTR pname, rdtype, rdclass, rtyp
		end if

		irhFreeREG v1

	'' call function
	else
		pname = symbGetProcName( proc )
		emitCALL pname, bytes2pop, TRUE
	end if

	'' load result
	if( vr <> INVALID ) then
		irhGetVREG vr, rdtype, rdclass, rtyp
		rr = emitGetResultReg( rdtype, rdclass )
		vregTB(vr).r = regTB(rdclass)->allocateReg( regTB(rdclass), rr, vr )
		vregTB(vr).typ = IR.VREGTYPE.REG

    	'' fb allows function calls w/o saving the result (can be dangerous with strings!)
		irhFreeREG vr
	end if

end sub

'':::::
sub irFlushSTACK( byval op as integer, byval v1 as integer, byval ex as integer ) 'static
	dim dst as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer

	''
	irhGetVREG v1, dt1, dc1, t1

	irhLoadIDX v1, dt1, dc1, t1

	''
	if( dc1 = IR.DATACLASS.FPOINT )  then
		if( t1 = IR.VREGTYPE.REG ) then
			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		end if
	end if

	''
	dst = irGetVRName( v1 )

	''
	select case op
	case IR.OP.PUSH
		emitPUSH dst, dt1, dc1, t1
	case IR.OP.PUSHUDT
		emitPUSHUDT dst, dt1, ex, t1
	case IR.OP.POP
		emitPOP dst, dt1, dc1, t1
	end select

    ''
	irhFreeREG v1

end sub

'':::::
sub irFlushUOP( byval op as integer, byval v1 as integer, byval vr as integer ) 'static
	dim dst as string, res as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim rr as integer, tr as integer, dtr as integer, dcr as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG vr, dtr, dcr, tr

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX vr, dtr, dcr, tr


	r1 = INVALID
	rr = INVALID

	''
    ''
    if ( vr <> INVALID ) then
		if( (v1 <> vr) ) then
			rr = regTB(dcr)->ensure( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			res = emitGetRegName( dtr, dcr, rr )
		end if
	end if

	if( vr <> INVALID ) then
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	''
	dst = irGetVRName( v1 )

	select case op
	case IR.OP.NEG
		emitNEG dst, dt1, dc1, t1
	case IR.OP.NOT
		emitNOT dst, dt1, dc1, t1

	case IR.OP.ABS
		emitABS dst, dt1, dc1, t1
	case IR.OP.SGN
		emitSGN dst, dt1, dc1, t1
	end select

    ''
    if ( vr <> INVALID ) then
		if( v1 <> vr ) then
			emitMOV res, dtr, dcr, tr, dst, dt1, dc1, t1
		end if
	end if

    ''
	irhFreeREG v1
	irhFreeREG vr

end sub

'':::::
sub irFlushBOP( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer ) 'static
	dim dst as string, src as string, res as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim r2 as integer, t2 as integer, dt2 as integer, dc2 as integer
	dim rr as integer, tr as integer, dtr as integer, dcr as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG v2, dt2, dc2, t2
	irhGetVREG vr, dtr, dcr, tr

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX v2, dt2, dc2, t2
	irhLoadIDX vr, dtr, dcr, tr

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' hack! to gen better FOR..NEXT counters.. only if integers
	if( (vr = INVALID) and (dc1 <> IR.DATACLASS.FPOINT) ) then
		if( t2 <> IR.VREGTYPE.IMM ) then
			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
			t2 = IR.VREGTYPE.REG
		end if

	else
		if( t2 = IR.VREGTYPE.REG ) then
			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		'' destine allocation comes *after* source, 'cause the FPU stack
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	''
	src = irGetVRName( v2 )
	dst = irGetVRName( v1 )

    ''
	select case op
	case IR.OP.ADD
		emitADD dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.SUB
		emitSUB dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.MUL
		emitMUL dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.DIV
        emitDIV dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.INTDIV
        emitINTDIV dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.MOD
		emitMOD dst, dt1, dc1, t1, src, dt2, dc2, t2

	case IR.OP.SHL
		emitSHL dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.SHR
		emitSHR dst, dt1, dc1, t1, src, dt2, dc2, t2

	case IR.OP.AND
		emitAND dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.OR
		emitOR dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.XOR
		emitXOR dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.EQV
		emitEQV dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.IMP
		emitIMP dst, dt1, dc1, t1, src, dt2, dc2, t2

	case IR.OP.MOV
		emitMOV dst, dt1, dc1, t1, src, dt2, dc2, t2
	end select

    '' hack! to gen better FOR..NEXT counters.. handle float counters..
	if ( vr = INVALID ) then
		if( dc1 = IR.DATACLASS.FPOINT ) then
			dst = irGetVRNameEx( v1, IR.VREGTYPE.VAR )
			emitSTORE dst, dt1, dc1, IR.VREGTYPE.VAR, "", dt1, dc1, t1
			irhFreeREG v1
			vregTB(v1).typ = IR.VREGTYPE.VAR
	    end if

	'' result not equal destine? (can happen with DAG optimizations)
	else
		if( (v1 <> vr) ) then
			rr = regTB(dcr)->ensure( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			res = emitGetRegName( dtr, dcr, rr )
			emitMOV res, dtr, dcr, tr, dst, dt1, dc1, t1
		end if
	end if

    ''
	irhFreeREG v1
	irhFreeREG v2
	irhFreeREG vr

end sub

'':::::
sub irFlushCOMP( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer, byval label as FBSYMBOL ptr ) 'static
	dim dst as string, src as string, res as string, lname as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim r2 as integer, t2 as integer, dt2 as integer, dc2 as integer
	dim rr as integer, tr as integer, dtr as integer, dcr as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG v2, dt2, dc2, t2
	irhGetVREG vr, dtr, dcr, tr

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX v2, dt2, dc2, t2
	irhLoadIDX vr, dtr, dcr, tr

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' all these checks for better FOR..NEXT loops..
	if( (t2 = IR.VREGTYPE.REG) or _
		((vr = INVALID) and (dc2 = IR.DATACLASS.INTEGER) and (t2 <> IR.VREGTYPE.IMM) and (dc1 <> IR.DATACLASS.FPOINT)) ) then
		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		t2 = IR.VREGTYPE.REG
	end if

	'' destine allocation comes *after* source, 'cause the FPU stack
	if( (vr <> INVALID) or _
		(t1 = IR.VREGTYPE.REG) or _
		(dc1 = IR.DATACLASS.FPOINT) or _
		(t1 = IR.VREGTYPE.IMM) ) then
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	'' result not equal destine? (can happen with DAG optimizations and floats comparations)
	if( vr = INVALID ) then
		res = ""
	else
		if( vr <> v1 ) then
			rr = regTB(dcr)->allocate( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			vregTB(vr).r   = rr
			vregTB(vr).typ = tr
			res = emitGetRegName( dtr, dcr, rr )
		end if
	end if

    ''
	if( v2 <> INVALID ) then					'' yet another FOR..LOOP optimization..
		src = irGetVRName( v2 )
	else
		src = ""
	end if
	dst = irGetVRName( v1 )

	if( vr = v1 ) then
		res = dst
	end if

	''
	if( label = NULL ) then
		lname = hMakeTmpStr
	else
		lname = symbGetLabelName( label )
	end if

	''
	select case op
	case IR.OP.EQ
		emitEQ res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.NE
		emitNE res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.GT
		emitGT res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.LT
		emitLT res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.LE
		emitLE res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	case IR.OP.GE
		emitGE res, lname, dst, dt1, dc1, t1, src, dt2, dc2, t2
	end select

    ''
	irhFreeREG v1
	irhFreeREG v2
	irhFreeREG vr

end sub

'':::::
sub irFlushSTORE( byval op as integer, byval v1 as integer, byval v2 as integer ) 'static
	dim dst as string, src as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim r2 as integer, t2 as integer, dt2 as integer, dc2 as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG v2, dt2, dc2, t2

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX v2, dt2, dc2, t2

	r1 = INVALID
	r2 = INVALID

    ''
	if( t2 <> IR.VREGTYPE.IMM ) then
		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		t2 = IR.VREGTYPE.REG
	end if

	''
	src = irGetVRName( v2 )
	dst = irGetVRName( v1 )

	emitSTORE dst, dt1, dc1, t1, src, dt2, dc2, t2

    ''
	irhFreeREG v1
	irhFreeREG v2

end sub

'':::::
sub irFlushLOAD( byval op as integer, byval v1 as integer ) 'static
	dim src as string, dst as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim rr as integer, vr as integer

	''
	irhGetVREG v1, dt1, dc1, t1

	irhLoadIDX v1, dt1, dc1, t1

	r1 = INVALID

	''
	select case op
	case IR.OP.LOAD
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG

	case IR.OP.LDFUNCRESULT
		if( t1 = IR.VREGTYPE.REG ) then
			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		end if

		rr = emitGetResultReg( dt1, dc1 )
		if( rr <> r1 ) then
			vr = irAllocVREG( dt1 )
			vregTB(vr).r = regTB(dc1)->allocateReg( regTB(dc1), rr, vr )
			vregTB(vr).typ = IR.VREGTYPE.REG

			''
			src = irGetVRName( v1 )
			dst = irGetVRName( vr )

			emitLOAD dst, dt1, dc1, IR.VREGTYPE.REG, src, dt1, dc1, t1

			''
			irhFreeREG vr							'' <-- assuming this is the last operation!!!
		end if
    end select


	''
	irhFreeREG v1

end sub

'':::::
sub irFlushCONVERT( byval op as integer, byval v1 as integer, byval v2 as integer ) 'static
	dim dst as string, src as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim r2 as integer, t2 as integer, dt2 as integer, dc2 as integer
	dim reuse as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG v2, dt2, dc2, t2

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX v2, dt2, dc2, t2

	r1 = INVALID
	r2 = INVALID

    '' hack! if src is a reg and if classes are the same and src won't be used (DAG?), reuse src
	reuse = FALSE
	if( (dc1 = dc2) and (t2 = IR.VREGTYPE.REG) ) then

		'' fp to fp conversion with source already on stack? do nothing..
		if( dc2 = IR.DATACLASS.FPOINT ) then
			r1 				= vregTB(v2).r
			vregTB(v1).r   	= r1
			vregTB(v1).typ 	= IR.VREGTYPE.REG
			regTB(dc1)->setOwner( regTB(dc1), r1, v1 )
			vregTB(v2).r   	= INVALID
			exit sub
		end if

		if( irGetDistance( v2 ) = IR.MAXDIST ) then
			reuse = TRUE
		end if
	end if

	if( reuse ) then
		r1 = vregTB(v2).r
		t1 = IR.VREGTYPE.REG
		vregTB(v1).r   = r1
		vregTB(v1).typ = t1
		regTB(dc1)->setOwner( regTB(dc1), r1, v1 )
	else
		if( t2 = IR.VREGTYPE.REG ) then
			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		r1 = regTB(dc1)->allocate( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
		vregTB(v1).r   = r1
		vregTB(v1).typ = t1
	end if

	''
	src = irGetVRName( v2 )
	dst = irGetVRName( v1 )

	''
	emitLOAD dst, dt1, dc1, t1, src, dt2, dc2, t2

	if( not reuse ) then
		irhFreeREG v2
	else
		vregTB(v2).r = INVALID
	end if

	''
	irhFreeREG v1

end sub

'':::::
sub irFlushADDR( byval op as integer, byval v1 as integer, byval vr as integer ) 'static
	dim src as string, dst as string
	dim r1 as integer, t1 as integer, dt1 as integer, dc1 as integer
	dim rr as integer, tr as integer, dtr as integer, dcr as integer

	''
	irhGetVREG v1, dt1, dc1, t1
	irhGetVREG vr, dtr, dcr, tr

	irhLoadIDX v1, dt1, dc1, t1
	irhLoadIDX vr, dtr, dcr, tr

	r1 = INVALID
	rr = INVALID

	''
	if( t1 = IR.VREGTYPE.REG ) then
		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
	end if

	if( tr = IR.VREGTYPE.REG ) then
		rr  = regTB(dcr)->ensure( regTB(dcr), vr )
	end if

	''
	src = irGetVRName( v1 )
	dst = irGetVRName( vr )

	select case op
	case IR.OP.ADDROF
		emitADDROF dst, dtr, dcr, tr, src, dt1, dc1, t1
	case IR.OP.DEREF
		emitDEREF dst, dtr, dcr, tr, src, dt1, dc1, t1
	end select

    ''
	irhFreeREG v1
	irhFreeREG vr

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irhFreeIDXEx( byval vreg as integer, byval force as integer )
	dim vi as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	select case vregTB(vreg).typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR

		vi = vregTB(vreg).vi
    	if( vi <> INVALID ) then
    		if( vregTB(vi).r <> INVALID ) then
    			irhFreeREGEx vi, force				'' recursive...
    			vregTB(vreg).vi = INVALID
			end if
		end if

	end select

end sub

'':::::
sub irhFreeIDX( byval vreg as integer ) 'static
	irhFreeIDXEx vreg, FALSE
end sub

'':::::
sub irhFreeREGEx( byval vreg as integer, byval force as integer )
	dim reg as integer
	dim rdtype as integer, rdclass as integer, rtyp as integer
	dim freereg as integer

	if( vreg = INVALID ) then
		exit sub
	end if

	'' free any attached index
	irhFreeIDXEx vreg, force

	if( vregTB(vreg).typ <> IR.VREGTYPE.REG ) then
		exit sub
	end if

	reg = vregTB(vreg).r
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
    	irhGetVREG vreg, rdtype, rdclass, rtyp
		regTB(rdclass)->free( regTB(rdclass), reg )
		vregTB(vreg).r = INVALID
	end if

end sub

'':::::
sub irhFreeREG( byval vreg as integer ) 'static
	irhFreeREGEx vreg, FALSE
end sub

'':::::
function irGetDistance( byval vreg as integer ) as integer
    dim i as integer, vi as integer

	if( vreg = INVALID ) then
		irGetDistance = IR.MAXDIST
		exit function
	end if

	'' check if there's any index with the vreg attached
	vi = INVALID
	for i = 0 to ctx.vregs-1
		select case vregTB(i).typ
		case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
			if( vregTB(i).vi = vreg ) then
				vi = i
				exit for
			end if
		end select
	next i

	'' check all 3-addr-codes, skipping the current one
	for i = ctx.currc+1 to ctx.codes-1
		'' vr is not checked, as it doesn't count as an operand
		if( (tacTB(i).v2 = vreg) or (tacTB(i).v1 = vreg) ) then
			irGetDistance = i - (ctx.currc+1)
			exit function
		elseif( vi <> INVALID ) then
			if( (tacTB(i).v2 = vi) or (tacTB(i).v1 = vi) ) then
				irGetDistance = i - (ctx.currc+1)
				exit function
			end if
		end if
	next i

	irGetDistance = IR.MAXDIST

end function

'':::::
function irhGetVRIndexName( byval vreg as integer ) as string 'static
    dim s as FBSYMBOL ptr, ofs as integer, lgt as integer, vi as integer
    dim varname as string, idxname as string

	if( vreg = INVALID ) then
		irhGetVRIndexName = "NULL"
		exit function
	end if

    s  	= vregTB(vreg).s
    ofs = vregTB(vreg).ofs
    vi 	= vregTB(vreg).vi
    lgt	= vregTB(vreg).lgt

	if( vi <> INVALID ) then
		idxname = irGetVRName( vi )
	else
		idxname = ""
	end if

	if( s <> NULL ) then
		varname = symbGetVarName( s )
	else
		varname = ""
	end if

	irhGetVRIndexName = emitGetIDXName( lgt, ofs, idxname, varname )

end function

'':::::
function irGetVRType( byval vreg as integer ) as integer 'static

	if( vreg = INVALID ) then
		irGetVRType = INVALID
	else
		irGetVRType = vregTB(vreg).typ
	end if

end function

'':::::
function irGetVRSymbol( byval vreg as integer ) as FBSYMBOL ptr 'static

	irGetVRSymbol = NULL

	if( vreg = INVALID ) then
		exit function
	end if

	select case vregTB(vreg).typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR, IR.VREGTYPE.IDX
		irGetVRSymbol = vregTB(vreg).s
	end select

end function

'':::::
function irGetVRNameEx( byval vreg as integer, byval typ as integer ) as string 'static
    dim vname as string, dtype as integer, dclass as integer

	if( vreg = INVALID ) then
		irGetVRNameEx = "NULL"
		exit function
	end if

	select case typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		vname = symbGetVarName( vregTB(vreg).s )
		if( vregTB(vreg).ofs <> 0 ) then
			vname = vname + "+" + ltrim$( str$( vregTB(vreg).ofs ) )
		end if

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
	    vname = irhGetVRIndexName( vreg )

	case IR.VREGTYPE.IMM
		vname =  ltrim$( str$( vregTB(vreg).value ) )

	case IR.VREGTYPE.REG
		irhGetVREG vreg, dtype, dclass, typ
		vname = emitGetRegName( dtype, dclass, vregTB(vreg).r )
	end select

	irGetVRNameEx = vname

end function

'':::::
function irGetVRName( byval vreg as integer ) as string 'static

	irGetVRName = irGetVRNameEx( vreg, vregTB(vreg).typ )

end function


'':::::
sub irLoadVR( byval reg as integer, byval vreg as integer ) 'static
	dim vname as string, rname as string
	dim dtype as integer, dclass as integer, vtyp as integer

	if( vregTB(vreg).typ <> IR.VREGTYPE.REG ) then
		vname  = irGetVRName( vreg )
		irhGetVREG vreg, dtype, dclass, vtyp

		rname = emitGetRegName( dtype, dclass, reg )

		emitLOAD rname, dtype, dclass, IR.VREGTYPE.REG, vname, dtype, dclass, vtyp

    	'' free any attached reg, forcing if needed
    	irhFreeIDXEx vreg, TRUE

    	vregTB(vreg).dtype	= dtype
    end if

	vregTB(vreg).typ 	= IR.VREGTYPE.REG
	vregTB(vreg).r 		= reg

end sub

'':::::
'''''sub irSetVR( byval reg as integer, byval vreg as integer )

'''''	vregTB(vreg).typ 	= IR.VREGTYPE.REG
'''''	vregTB(vreg).r 		= reg
'''''    vregTB(vreg).dtype	= rtype

'''''end sub

'':::::
function irCreateTMPVAR( byval vreg as integer ) as string
    dim typ as integer, vdclass as integer, vdtype as integer, vtyp as integer

	irhGetVREG vreg, vdtype, vdclass, vtyp

	if( vtyp <> IR.VREGTYPE.TMPVAR ) then
		typ = hDtype2Stype( vdtype )
		vregTB(vreg).typ	= IR.VREGTYPE.TMPVAR
		vregTB(vreg).s		= symbAddTempVar( typ )
		vregTB(vreg).ofs 	= 0
		vregTB(vreg).r		= INVALID
	end if

	irCreateTMPVAR = symbGetVarName( vregTB(vreg).s )

end function

'':::::
sub irStoreVR( byval vreg as integer, byval reg as integer ) 'static
	dim vname as string, dtype as integer, dclass as integer, vtyp as integer
    dim rname as string

	irhGetVREG vreg, dtype, dclass, vtyp

	if( irGetDistance( vreg ) = IR.MAXDIST ) then
		exit sub
	end if

	vname = irCreateTMPVAR( vreg )

	rname = emitGetRegName( dtype, dclass, reg )

	emitSTORE vname, dtype, dclass, IR.VREGTYPE.TMPVAR, rname, dtype, dclass, IR.VREGTYPE.REG

end sub

'':::::
sub irXchgTOS( byval reg as integer ) 'static
    dim rname as string

	rname = emitGetRegName( IR.DATATYPE.DOUBLE, IR.DATACLASS.FPOINT, reg )

	emitFXCHG rname, IR.DATATYPE.DOUBLE, IR.DATACLASS.FPOINT, IR.VREGTYPE.REG

end sub

'':::::
sub irDump( byval op as integer, byval v1 as integer, byval v2 as integer, byval vr as integer ) 'static

	if( vr <> INVALID ) then print "v";ltrim$(str$(vr));"(";irGetVRName( vr );":";ltrim$(str$(irGetVRType( vr )));":";ltrim$(str$(irGetVRDataType( vr )));")";chr$( 9 );"= ";

	if( v1 <> INVALID ) then print "v";ltrim$(str$(v1));"(";irGetVRName( v1 );":";ltrim$(str$(irGetVRType( v1 )));":";ltrim$(str$(irGetVRDataType( v1 )));")";

	if( vr = INVALID ) then print chr$( 9 ); else print " ";
	print rtrim$(opTB(op).name);

	if( v2 <> INVALID ) then
		print " v";ltrim$(str$(v2));"(";irGetVRName( v2 );":";ltrim$(str$(irGetVRType( v2 )));":";ltrim$(str$(irGetVRType( v2 )));")"
	else
		print
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function irGetVRRealValue( byval vreg as integer ) as integer 'static
    dim rval as integer

	if( vreg = INVALID ) then
		irGetVRRealValue = INVALID
		exit function
	end if

	select case vregTB(vreg).typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		rval = vregTB(vreg).s

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
sub irOptimize 'static
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
		select case opTB(op).typ
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
