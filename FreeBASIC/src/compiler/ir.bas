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
'$include once:'inc\flist.bi'
'$include once:'inc\ir.bi'
'$include once:'inc\dag.bi'


type IROPCODE
	typ			as integer
	cummutative as integer
	name		as string * 3
end type

type IRCTX
	tacTB			as TFLIST
	taccnt			as integer
	tacidx			as IRTAC ptr

	vregTB			as TFLIST
end type


declare sub 		irCreateTMPVAR		( byval vreg as IRVREG ptr, _
										  vname as string )

declare sub 		irFlushUOP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		irFlushBOP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		irFlushCOMP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr, _
										  byval label as FBSYMBOL ptr )

declare sub 		irFlushSTORE		( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr )

declare sub 		irFlushLOAD			( byval op as integer, _
										  byval v1 as IRVREG ptr )

declare sub 		irFlushCONVERT		( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr )

declare sub 		irFlushCALL			( byval op as integer, _
										  byval proc as FBSYMBOL ptr, _
										  byval bytestopop as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		irFlushBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		irFlushSTACK		( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval ex as integer )

declare sub 		irFlushADDR			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		irhFreeIDX			( byval vreg as IRVREG ptr, _
										  byval force as integer = FALSE )

declare sub 		irhFreeREG			( byval vreg as IRVREG ptr, _
										  byval force as integer = FALSE )

declare sub 		irOptimize			( )

declare sub 		irDump				( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

'' globals
	dim shared ctx as IRCTX

	dim shared regTB(0 to EMIT.REGCLASSES-1) as REGCLASS ptr

	dim shared opTB( 0 to 255 ) as IROPCODE

	dim shared dtypeTB( 0 to IR.MAXDATATYPES-1 ) as IRDATATYPE = { _
			(IR.DATACLASS.UNKNOWN, 0			 	, 0					, FALSE, "void"		), _
			(IR.DATACLASS.INTEGER, 1			 	, 8*1				, TRUE , "byte"		), _
			(IR.DATACLASS.INTEGER, 1			 	, 8*1				, FALSE, "ubyte"	), _
			(IR.DATACLASS.INTEGER, 1			 	, 8*1				, FALSE, "char"		), _
			(IR.DATACLASS.INTEGER, 2			 	, 8*2				, TRUE , "short"	), _
			(IR.DATACLASS.INTEGER, 2			 	, 8*2				, FALSE, "ushort"	), _
			(IR.DATACLASS.INTEGER, FB.INTEGERSIZE	, 8*FB.INTEGERSIZE	, TRUE , "integer"	), _
			(IR.DATACLASS.INTEGER, FB.INTEGERSIZE	, 8*FB.INTEGERSIZE	, FALSE, "uint"		), _
			(IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2	, 8*FB.INTEGERSIZE*2, TRUE , "quad"		), _
			(IR.DATACLASS.INTEGER, FB.INTEGERSIZE*2	, 8*FB.INTEGERSIZE*2, FALSE, "uquad"	), _
			(IR.DATACLASS.FPOINT , 4             	, 8*4				, TRUE , "single"	), _
			(IR.DATACLASS.FPOINT , 8			 	, 8*8				, TRUE , "double"	), _
			(IR.DATACLASS.STRING , FB.STRSTRUCTSIZE	, 0					, FALSE, "string"	), _
			(IR.DATACLASS.STRING , 1			 	, 8*1				, FALSE, "fixstr"	), _
			(IR.DATACLASS.UDT	 , 0			 	, 0					, FALSE, "udt"		), _
			(IR.DATACLASS.FUNCT	 , 0			 	, 0					, FALSE, "func"		), _
			(IR.DATACLASS.UNKNOWN, 0			 	, 0					, FALSE, "typedef"	) }

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
data IR.OP.LOADRESULT, IR.OPTYPE.LOAD	, FALSE, "ldr"
data IR.OP.ABS		, IR.OPTYPE.UNARY	, FALSE, "abs"
data IR.OP.SGN		, IR.OPTYPE.UNARY	, FALSE, "sgn"
data IR.OP.CALLPTR	, IR.OPTYPE.CALL	, FALSE, "ca@"
data IR.OP.JUMPPTR	, IR.OPTYPE.CALL	, FALSE, "jm@"
data IR.OP.PUSHUDT	, IR.OPTYPE.STACK	, FALSE, "psh"
data IR.OP.STACKALIGN, IR.OPTYPE.STACK	, FALSE, "alg"
data IR.OP.SIN		, IR.OPTYPE.UNARY	, FALSE, "sin"
data IR.OP.ASIN		, IR.OPTYPE.UNARY	, FALSE, "asn"
data IR.OP.COS		, IR.OPTYPE.UNARY	, FALSE, "cos"
data IR.OP.ACOS		, IR.OPTYPE.UNARY	, FALSE, "acs"
data IR.OP.TAN		, IR.OPTYPE.UNARY	, FALSE, "tan"
data IR.OP.ATAN		, IR.OPTYPE.UNARY	, FALSE, "atn"
data IR.OP.SQRT		, IR.OPTYPE.UNARY	, FALSE, "sqr"
data IR.OP.LOG		, IR.OPTYPE.UNARY	, FALSE, "log"
data IR.OP.FLOOR	, IR.OPTYPE.UNARY	, FALSE, "flo"
data IR.OP.ATAN2	, IR.OPTYPE.BINARY	, FALSE, "at2"
data -1

'':::::
sub irInit
	dim as integer i, op

	''
	ctx.tacidx = NULL
	ctx.taccnt = 0

	flistNew( @ctx.tacTB, IR.INITADDRNODES, len( IRTAC ) )

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
	flistNew( @ctx.vregTB, IR.INITVREGNODES, len( IRVREG ) )

	''
	emitInit( )

	for i = 0 to EMIT.REGCLASSES-1
		regTB(i) = emitGetRegClass( i )
	next i


end sub

'':::::
sub irEnd

	''
	flistFree( @ctx.vregTB )

	''
	flistFree( @ctx.tacTB )

	ctx.tacidx = NULL
	ctx.taccnt = 0

end sub

'':::::
function irGetDataClass( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).class

end function

'':::::
function irMaxDataType( byval dtype1 as integer, _
						byval dtype2 as integer ) as integer static

    function = -1

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
    case IR.DATATYPE.UBYTE, IR.DATATYPE.USHORT, IR.DATATYPE.UINT, _
    	 IR.DATATYPE.ULONGINT, IR.DATATYPE.DOUBLE
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
    	function = dtype1
    else
    	function = dtype2
    end if

end function

'':::::
function irIsSigned( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).signed

end function

'':::::
function irGetDataSize( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).size

end function

'':::::
function irGetDataBits( byval dtype as integer ) as integer static

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).bits

end function

'':::::
function irGetSignedType( byval dtype as integer ) as integer static
	dim as integer dt

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

	function = dtype

end function

'':::::
function irGetUnsignedType( byval dtype as integer ) as integer static
	dim as integer dt

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

	function = dtype

end function

'':::::
sub irhLoadIDX( byval vreg as IRVREG ptr, _
				byval typ as integer )
    dim as IRVREG ptr vi

	if( vreg = NULL ) then
		exit sub
	end if

	select case typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
	case else
		exit sub
	end select

	'' any vreg attached?
	vi = vreg->vidx
	if( vi = NULL ) then
		exit sub
	end if

	'' hack! x86 optimization, don't load immediates to registers
	if( vi->typ = IR.VREGTYPE.IMM ) then
		exit sub
	end if

	vi->reg = regTB(IR.DATACLASS.INTEGER)->ensure( regTB(IR.DATACLASS.INTEGER), vi )

end sub

'':::::
#define irhGetVREG(vreg,dt,dc,t) 					_
	if( vreg <> NULL ) then 						: _
		t = vreg->typ 								: _
                                                	: _
		dt = vreg->dtype							: _
		if( dt >= IR.DATATYPE.POINTER ) then		: _
			dt  = IR.DATATYPE.UINT					: _
			dc = IR.DATACLASS.INTEGER				: _
		else										: _
			dc = dtypeTB(dt).class					: _
		end if										: _
													: _
	else											: _
		t  = INVALID								: _
		dt = INVALID								: _
		dc = INVALID								: _
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

	function = op

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#define hRelinkVreg(v,t)										_
    t->v.next = NULL											:_
																:_
    if( v <> NULL ) then										:_
    	if( v->tacvhead = NULL ) then							:_
    		v->tacvhead = @t->v									:_
    	else													:_
    		v->tacvtail->next = @t->v							:_
    	end if													:_
    	v->tacvtail = @t->v										:_
                                                                :_
    	v->taclast = t                                          :_
    	if( v->vidx <> NULL ) then                              :_
    		v->vidx->taclast = t                                :_
    	end if                                                  :_
    	if( v->vaux <> NULL ) then                              :_
    		v->vaux->taclast = t                                :_
    	end if													:_
    end if

'':::::
sub irEmit( byval op as integer, _
			byval arg1 as IRVREG ptr, _
			byval arg2 as IRVREG ptr, _
			byval res as IRVREG ptr, _
			byval ex1 as FBSYMBOL ptr = NULL, _
			byval ex2 as integer = 0 ) static

    dim as IRTAC ptr t

    t = flistNewItem( @ctx.tacTB )

    t->pos		 = ctx.taccnt

    t->op  		 = op

    t->arg1.vreg = arg1
    hRelinkVreg( arg1, t )

    t->arg2.vreg = arg2
    hRelinkVreg( arg2, t )

    t->res.vreg  = res
    hRelinkVreg( res, t )

    t->ex1 		 = ex1
    t->ex2 		 = ex2

    ctx.taccnt += 1

end sub

'':::::
sub irEmitCONVERT( byval v1 as IRVREG ptr, _
				   byval dtype1 as integer, _
				   byval v2 as IRVREG ptr, _
				   byval dtype2 as integer ) static

	if( dtype1 >= IR.DATATYPE.POINTER ) then
		dtype1 = IR.DATATYPE.UINT
	end if

	select case dtypeTB(dtype1).class
	case IR.DATACLASS.INTEGER
		irEmit( IR.OP.TOINT, v1, v2, NULL )
	case IR.DATACLASS.FPOINT
		irEmit( IR.OP.TOFLT, v1, v2, NULL )
	end select

end sub

'':::::
sub irEmitLABEL( byval label as FBSYMBOL ptr, _
				 byval isglobal as integer ) static
    dim as string lname

	irFlush( )

	lname = symbGetName( label )

	emitLABEL( lname )

end sub

'':::::
sub irEmitRETURN( byval bytestopop as integer ) static

	irFlush( )

	emitRET( bytestopop )

end sub

'':::::
sub irEmitPROCBEGIN( byval proc as FBSYMBOL ptr, _
					 byval initlabel as FBSYMBOL ptr, _
					 byval endlabel as FBSYMBOL ptr, _
					 byval ispublic as integer ) static
    dim as string id

    id = symbGetName( proc )

	''
	irEMITBRANCH( IR.OP.JMP, endlabel )

	irFlush( )

	edbgProcBegin( proc, ispublic, -1 )

	''
	if( env.clopt.debug ) then
		emitASM( ".asciz \"" + id + "\"" )
	end if

	emitALIGN( 16 )

	if( ispublic ) then
		emitPUBLIC( id )
	end if

	emitLABEL( id )

	emitPROCBEGIN( proc, initlabel, ispublic )

end sub

'':::::
sub irEmitPROCEND( byval proc as FBSYMBOL ptr, _
				   byval initlabel as FBSYMBOL ptr, _
				   byval exitlabel as FBSYMBOL ptr ) static
    dim as integer bytestopop, mode

    mode = symbGetFuncMode( proc )
    if( (mode = FB.FUNCMODE.CDECL) or _
    	((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
		bytestopop = 0
	else
		bytestopop = symbGetLen( proc )
	end if

	irFlush( )

	emitPROCEND( proc, bytestopop, initlabel, exitlabel )

end sub

'':::::
function irEmitPUSHPARAM( byval proc as FBSYMBOL ptr, _
						  byval arg as FBSYMBOL ptr, _
						  byval vr as IRVREG ptr, _
						  byval pmode as integer, _
						  byval plen as integer ) as integer static
    dim as IRVREG ptr vt
    dim as integer isptr
    dim as integer adtype, adclass, amode
    dim as integer pdtype, pdclass, pclass
    dim as FBSYMBOL ptr s, d

	function = FALSE

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
    		if( pdclass = IR.DATACLASS.STRING ) then
    			'' not a pointer yet?
    			if( pclass <> IR.VREGTYPE.PTR ) then
    				amode = FB.ARGMODE.BYVAL
    			else
    				amode = FB.ARGMODE.BYREF
    			end if

    		'' zstring?
    		elseif( pdtype = IR.DATATYPE.CHAR ) then
    			'' not a pointer yet?
    			if( pclass <> IR.VREGTYPE.PTR ) then
    				amode = FB.ARGMODE.BYVAL
    			else
    				pmode = INVALID
    				amode = FB.ARGMODE.BYREF
    			end if

    		'' otherwise, pass as-is
    		else
    			amode = FB.ARGMODE.BYVAL
    		end if

    	'' passing an immediate?
    	elseif( irIsIMM( vr ) or (vr->typ = IR.VREGTYPE.OFS) ) then
        	amode = FB.ARGMODE.BYVAL

    	'' anything else, use the param type to create a temp var if needed
    	else
    		adtype = pdtype
    	end if

    '' byval or byref (but as any)
    else

    	'' string argument?
    	if( adclass = IR.DATACLASS.STRING ) then

			if( pmode <> FB.ARGMODE.BYVAL ) then

				'' not a pointer yet?
				if( pclass = IR.VREGTYPE.PTR ) then
					'' BYVAL or not the mode has to be changed to byref, as
					'' BYVAL AS STRING is actually BYREF AS ZSTRING
					amode = FB.ARGMODE.BYREF
				else
					amode = FB.ARGMODE.BYVAL
				end if

			else
				amode = FB.ARGMODE.BYVAL
			end if

		end if

	end if

	'' push to stack, depending on arg mode
	select case amode
	case FB.ARGMODE.BYVAL

		if( plen = 0 ) then
			irEmitPUSH( vr )
		else
			irEmitPUSHUDT( vr, plen )
		end if

	case FB.ARGMODE.BYREF
		'' BYVAL param? pass as-is
		if( pmode = FB.ARGMODE.BYVAL ) then
			irEmitPUSH( vr )

		else

			isptr = FALSE

			select case pclass
			'' simple pointer?
			case IR.VREGTYPE.PTR
				if( vr->ofs = 0 ) then
					isptr = TRUE
				end if

			'' simple index?
			case IR.VREGTYPE.IDX
				if( vr->ofs = 0 ) then
					if( vr->sym = NULL ) then
						if( vr->mult <= 1 ) then
							isptr = TRUE
						end if
					end if
				end if
			end select

			if( isptr ) then
				irEmitPUSH( vr->vidx )

			else
				'' byref arg and it's not a var? create a temp one..
				if( not irIsVAR( vr ) ) then
					if( not irIsIDX( vr ) ) then
						s = symbAddTempVar( adtype )
						vt = irAllocVRVAR( adtype, s, s->ofs )
						irEmitSTORE( vt, vr )
						vr = vt
					end if
				end if

				vt = irAllocVREG( IR.DATATYPE.UINT )
				irEmitADDR( IR.OP.ADDROF, vr, vt )
				irEmitPUSH( vt )
			end if

		end if
	end select

	''
	function = TRUE

end function

'':::::
sub irEmitVARINIBEGIN( byval sym as FBSYMBOL ptr ) static

	irFlush( )

	emitVARINIBEGIN( sym )

end sub

'':::::
sub irEmitVARINIEND( byval sym as FBSYMBOL ptr ) static

	emitVARINIEND( sym )

end sub

'':::::
sub irEmitVARINIi( byval dtype as integer, _
				   byval value as integer ) static

	emitVARINIi( dtype, value )

end sub

'':::::
sub irEmitVARINIf( byval dtype as integer, _
				   byval value as double ) static

	emitVARINIf( dtype, value )

end sub

'':::::
sub irEmitVARINI64( byval dtype as integer, _
					byval value as longint ) static

	emitVARINI64( dtype, value )

end sub

'':::::
sub irEmitVARINIOFS( byval sym as FBSYMBOL ptr ) static

	emitVARINIOFS( symbGetName( sym ) )

end sub

'':::::
sub irEmitVARINISTR( byval totlgt as integer, _
				     byval litstr as string, _
				     byval litlgt as integer ) static

	dim as string s

	'' zstring * 1?
	if( totlgt = 0 ) then
		emitVARINIi( IR.DATATYPE.BYTE, 0 )
		exit sub
	end if

	''
	s = hEscapeStr( litstr )

	''
	if( litlgt > totlgt ) then
		emitVARINISTR( totlgt, left$( s, totlgt ) )
	else
		emitVARINISTR( litlgt, s )

		if( litlgt < totlgt ) then
			emitVARINIPAD( totlgt - litlgt )
		end if
	end if

end sub

'':::::
sub irEmitVARINIPAD( byval bytes as integer ) static

	emitVARINIPAD( bytes )

end sub


'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function irNewVR( byval dtype as integer, _
				  byval typ as integer ) as IRVREG ptr static
	dim as IRVREG ptr v

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	v = flistNewItem( @ctx.vregTB )

	v->typ 	= typ
	v->dtype= dtype
	v->sym	= NULL
	v->reg	= INVALID
	v->vidx	= NULL
	v->vaux	= NULL
	v->ofs	= 0

	v->tacvhead = NULL
	v->tacvtail = NULL
	v->taclast  = NULL

	function = v

end function

'':::::
function irAllocVREG( byval dtype as integer ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR.VREGTYPE.REG )

	function = vr

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		 vr->vaux = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.REG )
	end if

end function

'':::::
function irAllocVRIMM( byval dtype as integer, _
					   byval value as integer ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR.VREGTYPE.IMM )

	function = vr

	vr->value = value

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		 vr->vaux = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IMM )
		 vr->vaux->value = 0
	end if

end function

'':::::
function irAllocVRIMM64( byval dtype as integer, _
						 byval value as longint ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR.VREGTYPE.IMM )

	function = vr

	vr->value = cuint( value )

	'' aux
	vr->vaux = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IMM )

	vr->vaux->value = cint( value shr 32 )

end function

'':::::
function irAllocVRVAR( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR.VREGTYPE.VAR )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= ofs

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.VAR )
		vr->vaux = va
		va->ofs = ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irAllocVRIDX( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer, _
					   byval mult as integer, _
					   byval vidx as IRVREG ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR.VREGTYPE.IDX )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= ofs
	vr->mult	= mult
	vr->vidx	= vidx

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IDX )
		vr->vaux= va
		va->ofs = ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irAllocVRPTR( byval dtype as integer, _
					   byval ofs as integer, _
					   byval vidx as IRVREG ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR.VREGTYPE.PTR )

	function = vr

	vr->ofs 	= ofs
	vr->mult 	= 1
	vr->vidx	= vidx

	'' longint?
	if( (dtype = IR.DATATYPE.LONGINT) or (dtype = IR.DATATYPE.ULONGINT) ) then
		va = irNewVR( IR.DATATYPE.INTEGER, IR.VREGTYPE.IDX )
		vr->vaux= va
		va->ofs = ofs + FB.INTEGERSIZE
	end if

end function

'':::::
function irAllocVROFS( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR.VREGTYPE.OFS )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= 0

end function

'':::::
function irIsVAR( byval vreg as IRVREG ptr ) as integer static

	function = FALSE

	select case vreg->typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		function = TRUE
	end select

end function

'':::::
function irIsIDX( byval vreg as IRVREG ptr ) as integer static

	function = FALSE

	select case vreg->typ
	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		function = TRUE
	end select

end function


'':::::
function irGetVRDataClass( byval vreg as IRVREG ptr ) as integer static
	dim as integer dtype

	dtype = vreg->dtype

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).class

end function

'':::::
function irGetVRDataSize( byval vreg as IRVREG ptr ) as integer static
	dim as integer dtype

	dtype = vreg->dtype

	if( dtype >= IR.DATATYPE.POINTER ) then
		dtype = IR.DATATYPE.UINT
	end if

	function = dtypeTB(dtype).size

end function

'':::::
sub irGetVRIndexName( byval vreg as IRVREG ptr, _
					  vname as string )

    dim as FBSYMBOL ptr sym
    dim as IRVREG ptr vi
    dim as string sname

	if( vreg = NULL ) then
		vname = "NULL"
		exit sub
	end if

    vi = vreg->vidx
	if( vi <> NULL ) then
		irGetVRName( vi, vname )
	else
		vname = ""
	end if

	sym = vreg->sym
	if( sym <> NULL ) then
		sname = symbGetName( sym )
	else
		sname = ""
	end if

	emitGetIDXName( vreg->mult, sname, vname )

end sub

'':::::
sub irGetVRNameEx( byval vreg as IRVREG ptr, _
				   byval typ as integer, _
				   vname as string )
    dim as integer dtype, dclass

	if( vreg = NULL ) then
		vname = "NULL"
		exit function
	end if

	select case as const typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR, IR.VREGTYPE.OFS
		vname = symbGetName( vreg->sym )

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
	    irGetVRIndexName( vreg, vname )

	case IR.VREGTYPE.IMM
		vname = str$( vreg->value )

	case IR.VREGTYPE.REG
		irhGetVREG( vreg, dtype, dclass, typ )
		emitGetRegName( dtype, dclass, vreg->reg, vname )

	end select

end sub

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irRename( byval vold as IRVREG ptr, _
			  byval vnew as IRVREG ptr ) static

    dim as IRTACVREG ptr t
    dim as IRVREG ptr v

	'' reassign tac table vregs
	'' (assuming res, arg1 and arg2 will never point to the same vreg!)
	t = vold->tacvhead
	do
		t->vreg = vnew
		t = t->next
	loop while( t <> NULL )

	vnew->tacvhead = vold->tacvhead
	vnew->tacvtail = vold->tacvtail

	'' index and auxiliar regs must be checked one by one..
	v = flistGetHead( @ctx.vregTB )
	do while( v <> NULL )
		select case v->typ
		case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
			if( v->vidx = vold ) then
				v->vidx = vnew
			end if
		end select

		if( v->vaux = vold ) then
			v->vaux = vnew
		end if

		v = v->nxt
	loop

	vnew->taclast = vold->taclast

end sub

'':::::
sub irReuse( byval t as IRTAC ptr ) static
    dim as IRVREG ptr v1
    dim as IRVREG ptr v2
    dim as IRVREG ptr vr
    dim as integer dt1, dc1, t1
    dim as integer dt2, dc2, t2
    dim as integer dtr, dcr, tr
    dim as integer op, v1rename, v2rename
    dim as IRTACVREG ptr tmp

	op	 = t->op
	v1   = t->arg1.vreg
	v2   = t->arg2.vreg
	vr   = t->res.vreg

	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
    irhGetVREG( vr, dtr, dcr, tr )

	select case opTB(op).typ
	case IR.OPTYPE.UNARY
		if( vr <> v1 ) then
			if( dtr = dt1 ) then
           		if( irGetDistance( v1 ) = IR.MAXDIST ) then
           			irRename( vr, v1 )
           		end if
           	end if
		end if

	case IR.OPTYPE.BINARY, IR.OPTYPE.COMP

		if( vr = NULL ) then
			exit sub
		end if

		'' check if operands have the same class (can happen 'cause the x86 FPU hacks)
		if( dc1 <> dc2 ) then
			exit sub
		end if

		v1rename = FALSE
		if( vr <> v1 ) then
			if( dtr = dt1 ) then
           		if( irGetDistance( v1 ) = IR.MAXDIST ) then
           			v1rename = TRUE
           		end if
           	end if
		end if

		v2rename = FALSE
		if( opTB(op).cummutative ) then
			if( vr <> v2 ) then
				if( dtr = dt2 ) then
					if( t2 <> IR.VREGTYPE.IMM ) then
           				if( irGetDistance( v2 ) = IR.MAXDIST ) then
           					v2rename = TRUE
           				end if
           			end if
           		end if
			end if
		end if

		if( v1rename and v2rename ) then
			if( not irIsREG( v1 ) ) then
           		v1rename = FALSE
			end if
		end if

		if( v1rename ) then
           	irRename( vr, v1 )

		elseif( v2rename ) then
			'' swap t->arg1, t->arg2
			t->arg2.vreg = v1
			t->arg1.vreg = v2

			tmp = t->arg2.next
			t->arg2.next = t->arg1.next
			t->arg1.next = tmp

			irRename( vr, v2 )
		end if

	end select

end sub

'':::::
sub irFlush static
    dim as integer op
    dim as IRTAC ptr t

	if( ctx.taccnt = 0 ) then
		exit sub
	end if

	'irOptimize

	t = flistGetHead( @ctx.tacTB )
	do
		ctx.tacidx = t


		irReuse( t )

		op = t->op

		''
		''irDump( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg )

        ''
		select case as const opTB(op).typ
		case IR.OPTYPE.UNARY
			irFlushUOP( op, t->arg1.vreg, t->res.vreg )

		case IR.OPTYPE.BINARY
			irFlushBOP( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg )

		case IR.OPTYPE.COMP
			irFlushCOMP( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg, t->ex1 )

		case IR.OPTYPE.STORE
			irFlushSTORE( op, t->arg1.vreg, t->arg2.vreg )

		case IR.OPTYPE.LOAD
			irFlushLOAD( op, t->arg1.vreg )

		case IR.OPTYPE.CONVERT
			irFlushCONVERT( op, t->arg1.vreg, t->arg2.vreg )

		case IR.OPTYPE.STACK
			irFlushSTACK( op, t->arg1.vreg, t->ex2 )

		case IR.OPTYPE.CALL
			irFlushCALL( op, t->ex1, t->ex2, t->arg1.vreg, t->res.vreg )

		case IR.OPTYPE.BRANCH
			irFlushBRANCH( op, t->ex1 )

		case IR.OPTYPE.ADDRESSING
			irFlushADDR( op, t->arg1.vreg, t->res.vreg )
		end select

		''
		'irDump( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg )

		t = t->nxt
	loop while( t <> NULL )

	''
	ctx.tacidx = NULL
	ctx.taccnt = 0
	flistReset( @ctx.tacTB )

	''
	flistReset( @ctx.vregTB )

end sub

'':::::
sub irFlushBRANCH( byval op as integer, _
				   byval label as FBSYMBOL ptr ) static
    dim lname as string

	lname = symbGetName( label )

	''
	select case as const op
	case IR.OP.LABEL
		emitLABEL( lname )

	case IR.OP.JMP
		emitJMP( lname )
	case IR.OP.CALL
		emitCALL( lname, 0 )

	case else
		emitBRANCH( op, lname )
	end select

end sub

'':::::
private sub irhPreserveRegs( byval ptrvreg as IRVREG ptr = NULL ) static
    dim as IRVREG ptr vr
    dim as integer r
    dim as integer dclass, dtype, typ
    dim as string dname, sname
    dim as integer fr 							'' free reg
    dim as integer npr 							'' don't preserve reg (used with CALLPTR)
    dim as integer class

	'' for each reg class
	for class = 0 to EMIT.REGCLASSES-1

    	'' set the register that shouldn't be preserved (used for CALLPTR only)
    	npr = INVALID
    	if( class = IR.DATACLASS.INTEGER ) then
    		if( ptrvreg <> NULL ) then

    			select case ptrvreg->typ
    			case IR.VREGTYPE.REG
    				npr = ptrvreg->reg

    			case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
    				ptrvreg = ptrvreg->vidx
    				if( ptrvreg <> NULL ) then
    					npr = ptrvreg->reg
    				end if
    			end select

    			ptrvreg = NULL
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
        				irStoreVR( vr, r )

        			'' else, copy it to a preserved reg
        			else
        				fr = regTB(dclass)->allocateReg( regTB(dclass), fr, vr )
        				vr->reg = fr
        				''!!!FIXME!!! assumming emitMOV won't check the src and dst reg's
        				emitGetRegName( dtype, dclass, fr, dname )
        				emitGetRegName( dtype, dclass, r, sname )
        				emitMOV( dname, vr, sname, vr )

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
				 byval v1 as IRVREG ptr, _
				 byval vr as IRVREG ptr ) static

    dim as string pname
    dim as integer rr, rr2, rdclass, rdtype, rtyp, mode
    dim as IRVREG ptr va

	'' call function
    if( proc <> NULL ) then
    	mode = symbGetFuncMode( proc )
    	if( (mode = FB.FUNCMODE.CDECL) or _
    		((mode = FB.FUNCMODE.STDCALL) and (env.clopt.nostdcall)) ) then
			if( bytes2pop = 0 ) then
				bytes2pop = symbGetLen( proc )
			end if
		else
			bytes2pop = 0
		end if

    	'' save used registers and free the FPU stack
    	irhPreserveRegs( )

		emitCALL( symbGetName( proc ), bytes2pop )

	'' call or jump to pointer
	else

    	'' if it's a CALL, save used registers and free the FPU stack
    	if( op = IR.OP.CALLPTR ) then
    		irhPreserveRegs( v1 )
    	end if

		'' load pointer
		irhGetVREG( v1, rdtype, rdclass, rtyp )
		irhLoadIDX( v1, rtyp )
		if( rtyp = IR.VREGTYPE.REG ) then
			rr = regTB(rdclass)->ensure( regTB(rdclass), v1 )
		end if

		irGetVRName( v1, pname )

		'' CALLPTR
		if( op = IR.OP.CALLPTR ) then
			emitCALLPTR( pname, v1, bytes2pop )
		'' JUMPPTR
		else
			emitBRANCHPTR( pname, v1 )
		end if

		'' free pointer
		irhFreeREG( v1 )
	end if

	'' load result
	if( vr <> NULL ) then
		irhGetVREG( vr, rdtype, rdclass, rtyp )

		emitGetResultReg( rdtype, rdclass, rr, rr2 )

		'' longints..
		if( (rdtype = IR.DATATYPE.LONGINT) or (rdtype = IR.DATATYPE.ULONGINT) ) then
			va = vr->vaux
			va->reg = regTB(rdclass)->allocateReg( regTB(rdclass), rr2, va )
			va->typ = IR.VREGTYPE.REG
		end if

		vr->reg = regTB(rdclass)->allocateReg( regTB(rdclass), rr, vr )
		vr->typ = IR.VREGTYPE.REG

    	'' fb allows function calls w/o saving the result
		irhFreeREG( vr )
	end if

end sub

'':::::
sub irFlushSTACK( byval op as integer, _
				  byval v1 as IRVREG ptr, _
				  byval ex as integer ) static
	dim as string dst
	dim as integer r1, t1, dt1, dc1
	dim as IRVREG ptr va

	''
	if( op = IR.OP.STACKALIGN ) then
		emitSTACKALIGN( ex )
		exit sub
	end if

	''
	irhGetVREG( v1, dt1, dc1, t1 )

	irhLoadIDX( v1, t1 )

	'' only load fp's, if they are on the fpu stack (x86 assumption)
	'if( dc1 = IR.DATACLASS.FPOINT )  then
		if( t1 = IR.VREGTYPE.REG ) then
			'' handle longint
			if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				va = v1->vaux
				va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
			end if

			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		end if
	'end if

	''
	irGetVRName( v1, dst )

	''
	select case op
	case IR.OP.PUSH
		emitPUSH( dst, v1 )
	case IR.OP.PUSHUDT
		emitPUSHUDT( dst, v1, ex )
	case IR.OP.POP
		emitPOP( dst, v1 )
	end select

    ''
	irhFreeREG( v1 )

end sub

'':::::
sub irFlushUOP( byval op as integer, _
			    byval v1 as IRVREG ptr, _
			    byval vr as IRVREG ptr ) static
	dim as string dst, res
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, tr, dtr, dcr
	dim as IRVREG ptr va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( vr, tr )


	r1 = INVALID
	rr = INVALID

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			'' handle longint
			if( (dtr = IR.DATATYPE.LONGINT) or (dtr = IR.DATATYPE.ULONGINT) ) then
				va = vr->vaux
				va->reg = regTB(dcr)->ensure( regTB(dcr), va, FALSE )
			end if

			rr = regTB(dcr)->ensure( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			emitGetRegName( dtr, dcr, rr, res )
		end if
	end if

	'' UOP to self? x86 assumption at AST
	if( vr <> NULL ) then
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = v1->vaux
			va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
		t1 = IR.VREGTYPE.REG
	end if

	''
	irGetVRName( v1, dst )

	select case as const op
	case IR.OP.NEG
		emitNEG( dst, v1 )
	case IR.OP.NOT
		emitNOT( dst, v1 )

	case IR.OP.ABS
		emitABS( dst, v1 )
	case IR.OP.SGN
		emitSGN( dst, v1 )

	case IR.OP.SIN
		emitSIN( dst, v1 )
	case IR.OP.ASIN
		emitASIN( dst, v1 )
	case IR.OP.COS
		emitCOS( dst, v1 )
	case IR.OP.ACOS
		emitACOS( dst, v1 )
	case IR.OP.TAN
		emitTAN( dst, v1 )
	case IR.OP.ATAN
		emitATAN( dst, v1 )
	case IR.OP.SQRT
		emitSQRT( dst, v1 )
	case IR.OP.LOG
		emitLOG( dst, v1 )
	case IR.OP.FLOOR
		emitFLOOR( dst, v1 )
	end select

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			emitMOV( res, vr, dst, v1 )
		end if
	end if

    ''
	irhFreeREG( v1 )
	irhFreeREG( vr )

end sub

'':::::
sub irFlushBOP( byval op as integer, _
				byval v1 as IRVREG ptr, _
				byval v2 as IRVREG ptr, _
				byval vr as IRVREG ptr ) static
	dim as string dst, src, res
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer rr, tr, dtr, dcr
	dim as IRVREG ptr va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( v2, t2 )
	irhLoadIDX( vr, tr )

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' BOP to self? (x86 assumption at AST)
	if( vr = NULL ) then
		if( t2 <> IR.VREGTYPE.IMM ) then		'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = v2->vaux
				va->reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
			t2 = IR.VREGTYPE.REG
		end if

	else
		if( t2 = IR.VREGTYPE.REG ) then			'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = v2->vaux
				va->reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		'' destine allocation comes *after* source, 'cause the FPU stack
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = v1->vaux
			va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
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
		emitADD( dst, v1, src, v2 )
	case IR.OP.SUB
		emitSUB( dst, v1, src, v2 )
	case IR.OP.MUL
		emitMUL( dst, v1, src, v2 )
	case IR.OP.DIV
        emitDIV( dst, v1, src, v2 )
	case IR.OP.INTDIV
        emitINTDIV( dst, v1, src, v2 )
	case IR.OP.MOD
		emitMOD( dst, v1, src, v2 )

	case IR.OP.SHL
		emitSHL( dst, v1, src, v2 )
	case IR.OP.SHR
		emitSHR( dst, v1, src, v2 )

	case IR.OP.AND
		emitAND( dst, v1, src, v2 )
	case IR.OP.OR
		emitOR( dst, v1, src, v2 )
	case IR.OP.XOR
		emitXOR( dst, v1, src, v2 )
	case IR.OP.EQV
		emitEQV( dst, v1, src, v2 )
	case IR.OP.IMP
		emitIMP( dst, v1, src, v2 )

	case IR.OP.MOV
		emitMOV( dst, v1, src, v2 )

	case IR.OP.ATAN2
        emitATAN2( dst, v1, src, v2 )
    case IR.OP.POW
    	emitPOW( dst, v1, src, v2 )
	end select

    '' not BOP to self?
	if ( vr <> NULL ) then
		'' result not equal destine? (can happen with DAG optimizations)
		if( (v1 <> vr) ) then
			'' handle longint
			if( (dtr = IR.DATATYPE.LONGINT) or (dtr = IR.DATATYPE.ULONGINT) ) then
				va = vr->vaux
				va->reg = regTB(dcr)->ensure( regTB(dcr), va, FALSE )
			end if

			rr = regTB(dcr)->ensure( regTB(dcr), vr )

			emitGetRegName( dtr, dcr, rr, res )
			emitMOV( res, vr, dst, v1 )
		end if
	end if

    ''
	irhFreeREG( v1 )
	irhFreeREG( v2 )
	irhFreeREG( vr )

end sub

'':::::
sub irFlushCOMP( byval op as integer, _
				 byval v1 as IRVREG ptr, _
				 byval v2 as IRVREG ptr, _
				 byval vr as IRVREG ptr, _
				 byval label as FBSYMBOL ptr ) static
	dim as string dst, src, res, lname
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer rr, tr, dtr, dcr
	dim as IRVREG ptr va
	dim as integer doload

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( v2, t2 )
	irhLoadIDX( vr, tr )

	r1 = INVALID
	r2 = INVALID
	rr = INVALID

	'' load source if it's a reg, or if result was not allocated
	doload = FALSE
	if( vr = NULL ) then						'' x86 assumption
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
			va = v2->vaux
			va->reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
		end if

		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		t2 = IR.VREGTYPE.REG
	end if

	'' destine allocation comes *after* source, 'cause the FPU stack
	doload = FALSE
	if( (vr <> NULL) and (vr = v1) ) then		'' x86 assumption
		doload = TRUE
	elseif( dc1 = IR.DATACLASS.FPOINT ) then	'' /
		doload = TRUE
	elseif( t1 = IR.VREGTYPE.IMM) then          '' /
		doload = TRUE
	elseif( t2 <> IR.VREGTYPE.REG ) then        '' /
		if( t2 <> IR.VREGTYPE.IMM ) then
			doload = TRUE
		end if
	end if

	if( (t1 = IR.VREGTYPE.REG) or doload ) then
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = v1->vaux
			va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )
	end if

	'' result not equal destine? (can happen with DAG optimizations and floats comparations)
	if( vr <> NULL ) then
		if( vr <> v1 ) then
			rr = regTB(dcr)->allocate( regTB(dcr), vr )
			tr = IR.VREGTYPE.REG
			vr->reg = rr
			vr->typ = tr
			emitGetRegName( dtr, dcr, rr, res )
		end if
	end if

    ''
	if( v2 <> NULL ) then					'' yet another FOR..LOOP optimization..
		irGetVRName( v2, src )
	else
		src = ""
	end if

	irGetVRName( v1, dst )

	if( vr = v1 ) then
		res = dst
	elseif( vr = NULL ) then
		res = ""
	end if

	''
	if( label = NULL ) then
		lname = *hMakeTmpStr( )
	else
		lname = symbGetName( label )
	end if

	if( vr = NULL ) then
		vr = v1
	end if

	''
	select case as const op
	case IR.OP.EQ
		emitEQ( res, vr, lname, dst, v1, src, v2 )
	case IR.OP.NE
		emitNE( res, vr, lname, dst, v1, src, v2 )
	case IR.OP.GT
		emitGT( res, vr, lname, dst, v1, src, v2 )
	case IR.OP.LT
		emitLT( res, vr, lname, dst, v1, src, v2 )
	case IR.OP.LE
		emitLE( res, vr, lname, dst, v1, src, v2 )
	case IR.OP.GE
		emitGE( res, vr, lname, dst, v1, src, v2 )
	end select

    ''
	irhFreeREG( v1 )
	irhFreeREG( v2 )
	if( vr <> v1 ) then
		irhFreeREG( vr )
	end if

end sub

'':::::
sub irFlushSTORE( byval op as integer, _
				  byval v1 as IRVREG ptr, _
				  byval v2 as IRVREG ptr ) static
	dim as string dst, src
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as IRVREG ptr va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( v2, t2 )

	r1 = INVALID
	r2 = INVALID

    '' if dst is a fpoint, only load src if its a reg (x86 assumption)
	if( (t2 = IR.VREGTYPE.REG) or ((t2 <> IR.VREGTYPE.IMM) and (dc1 = IR.DATACLASS.INTEGER)) ) then
		'' handle longint
		if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
			va = v2->vaux
			va->reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
		end if

		r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
	end if

	''
	irGetVRName( v2, src )
	irGetVRName( v1, dst )

	emitSTORE( dst, v1, src, v2 )

    ''
	irhFreeREG( v1 )
	irhFreeREG( v2 )

end sub

'':::::
sub irFlushLOAD( byval op as integer, _
				 byval v1 as IRVREG ptr ) static
	dim as string src, dst
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, rr2
	dim as IRVREG ptr va, vr

	''
	irhGetVREG( v1, dt1, dc1, t1 )

	irhLoadIDX( v1, t1 )

	r1 = INVALID

	''
	select case op
	case IR.OP.LOAD
		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = v1->vaux
			va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
		end if

		r1 = regTB(dc1)->ensure( regTB(dc1), v1 )

	case IR.OP.LOADRESULT
		if( t1 = IR.VREGTYPE.REG ) then
			'' handle longint
			if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				va = v1->vaux
				va->reg = regTB(dc1)->ensure( regTB(dc1), va, FALSE )
			end if

			r1 = regTB(dc1)->ensure( regTB(dc1), v1 )

		end if

		emitGetResultReg( dt1, dc1, rr, rr2 )
		if( rr <> r1 ) then
			vr = irAllocVREG( dt1 )

			'' handle longint
			if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
				va = vr->vaux
				va->reg = regTB(dc1)->allocateReg( regTB(dc1), rr2, va )
				va->typ = IR.VREGTYPE.REG
			end if

			vr->reg = regTB(dc1)->allocateReg( regTB(dc1), rr, vr )
			vr->typ = IR.VREGTYPE.REG

			''
			irGetVRName( v1, src )
			irGetVRName( vr, dst )

			emitLOAD( dst, vr, src, v1 )

			''
			irhFreeREG( vr )						'' <-- assuming this is the last operation!!!
		end if
    end select


	''
	irhFreeREG( v1 )

end sub

'':::::
sub irFlushCONVERT( byval op as integer, _
					byval v1 as IRVREG ptr, _
					byval v2 as IRVREG ptr ) static
	dim as string dst, src
	dim as integer r1, t1, dt1, dc1
	dim as integer r2, t2, dt2, dc2
	dim as integer reuse
	dim as IRVREG ptr va

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( v2, dt2, dc2, t2 )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( v2, t2 )

	r1 = INVALID
	r2 = INVALID

    '' hack! if src is a reg and if classes are the same and src won't be used (DAG?), reuse src
	reuse = FALSE
	if( (dc1 = dc2) and (t2 = IR.VREGTYPE.REG) ) then

		'' fp to fp conversion with source already on stack? do nothing..
		if( dc2 = IR.DATACLASS.FPOINT ) then
			r1 			= v2->reg
			v1->reg 	= r1
			v1->typ 	= IR.VREGTYPE.REG
			regTB(dc1)->setOwner( regTB(dc1), r1, v1 )
			v2->reg 	= INVALID
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
		r1 = v2->reg
		t1 = IR.VREGTYPE.REG
		v1->reg = r1
		v1->typ = t1
		regTB(dc1)->setOwner( regTB(dc1), r1, v1 )

	else
		if( t2 = IR.VREGTYPE.REG ) then			'' x86 assumption
			'' handle longint
			if( (dt2 = IR.DATATYPE.LONGINT) or (dt2 = IR.DATATYPE.ULONGINT) ) then
				va = v2->vaux
				va->reg = regTB(dc2)->ensure( regTB(dc2), va, FALSE )
			end if

			r2 = regTB(dc2)->ensure( regTB(dc2), v2 )
		end if

		'' handle longint
		if( (dt1 = IR.DATATYPE.LONGINT) or (dt1 = IR.DATATYPE.ULONGINT) ) then
			va = v1->vaux
			va->reg = regTB(dc1)->allocate( regTB(dc1), va )
			va->typ = IR.VREGTYPE.REG
		end if

		v1->reg = regTB(dc1)->allocate( regTB(dc1), v1 )
		v1->typ = IR.VREGTYPE.REG
	end if

	''
	irGetVRName( v2, src )
	irGetVRName( v1, dst )

	''
	emitLOAD( dst, v1, src, v2 )

	if( not reuse ) then
		irhFreeREG( v2 )
	else
		v2->reg = INVALID
	end if

	''
	irhFreeREG( v1 )

end sub

'':::::
sub irFlushADDR( byval op as integer, _
				 byval v1 as IRVREG ptr, _
				 byval vr as IRVREG ptr ) static
	dim as string src, dst
	dim as integer r1, t1, dt1, dc1
	dim as integer rr, tr, dtr, dcr

	''
	irhGetVREG( v1, dt1, dc1, t1 )
	irhGetVREG( vr, dtr, dcr, tr )

	irhLoadIDX( v1, t1 )
	irhLoadIDX( vr, tr )

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
		emitADDROF( dst, vr, src, v1 )
	case IR.OP.DEREF
		emitDEREF( dst, vr, src, v1 )
	end select

    ''
	irhFreeREG( v1 )
	irhFreeREG( vr )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub irhFreeIDX( byval vreg as IRVREG ptr, _
				byval force as integer = FALSE )
	dim as IRVREG ptr vi

	if( vreg = NULL ) then
		exit sub
	end if

	vi = vreg->vidx
    if( vi <> NULL ) then
    	if( vi->reg <> INVALID ) then
    		irhFreeREG( vi, force )				'' recursively
    		vreg->vidx = NULL
		end if
	end if

end sub

'':::::
sub irhFreeREG( byval vreg as IRVREG ptr, _
				byval force as integer = FALSE )
	dim as integer reg
	dim as integer rdtype, rdclass, rtyp
	dim as integer freereg
	dim as IRVREG ptr va

	if( vreg = NULL ) then
		exit sub
	end if

	'' free any attached index
	irhFreeIDX( vreg, force )

    ''
	if( vreg->typ <> IR.VREGTYPE.REG ) then
		exit sub
	end if

	reg = vreg->reg
	if( reg = INVALID ) then
		exit sub
	end if

	''
	if( not force ) then
		freereg = (irGetDistance( vreg ) = IR.MAXDIST)
	else
		freereg = TRUE
	end if

	if( freereg ) then
		'' aux?
		if( vreg->vaux <> NULL ) then
			va = vreg->vaux
			if( va->reg <> INVALID ) then
				irhFreeREG( va, TRUE )
			end if
		end if

    	irhGetVREG( vreg, rdtype, rdclass, rtyp )
		regTB(rdclass)->free( regTB(rdclass), reg )
		vreg->reg = INVALID
	end if

end sub

'':::::
function irGetDistance( byval vreg as IRVREG ptr ) as uinteger
    dim as IRVREG ptr v
    dim as IRTAC ptr t
    dim as integer dist

	if( vreg = NULL ) then
		return IR.MAXDIST
	end if

	'' skipping the current tac
	t = ctx.tacidx->nxt
	if( t = NULL ) then
		return IR.MAXDIST
	end if

	''
	dist = vreg->taclast->pos - t->pos
	if( dist < 0 ) then
		function = IR.MAXDIST
	else
		function = dist
	end if

end function

'':::::
sub irLoadVR( byval reg as integer, _
			  byval vreg as IRVREG ptr, _
			  byval doload as integer ) static
	dim as string vname, rname
	dim as IRVREG rvreg

	if( vreg->typ <> IR.VREGTYPE.REG ) then

		if( doload ) then
			irGetVRName( vreg, vname )

			rvreg.typ 	= IR.VREGTYPE.REG
			rvreg.dtype = vreg->dtype
			rvreg.reg	= reg
			rvreg.vaux	= vreg->vaux

			emitGetRegName( vreg->dtype, irGetDataClass( vreg->dtype ), reg, rname )

			emitLOAD( rname, @rvreg, vname, vreg )
		end if

    	'' free any attached reg, forcing if needed
    	irhFreeIDX( vreg, TRUE )

    	vreg->typ = IR.VREGTYPE.REG
    end if

	vreg->reg = reg

end sub

'':::::
sub irCreateTMPVAR( byval vreg as IRVREG ptr, _
					vname as string ) static

	if( vreg->typ <> IR.VREGTYPE.TMPVAR ) then
		vreg->typ	= IR.VREGTYPE.TMPVAR
		vreg->sym	= symbAddTempVar( vreg->dtype )
		vreg->ofs 	= vreg->sym->ofs
		vreg->reg	= INVALID
	end if

	irGetVRNameEx( vreg, vreg->typ, vname )

end sub

'':::::
sub irStoreVR( byval vreg as IRVREG ptr, _
			   byval reg as integer ) static
	dim as string vname, rname
    dim as IRVREG rvreg
	dim as IRVREG ptr vareg

	if( irGetDistance( vreg ) = IR.MAXDIST ) then
		exit sub
	end if

	rvreg.typ		= IR.VREGTYPE.REG
	rvreg.dtype		= vreg->dtype
	rvreg.reg		= reg
	rvreg.vaux		= vreg->vaux

	irCreateTMPVAR( vreg, vname )

	emitGetRegName( rvreg.dtype, dtypeTB(rvreg.dtype).class, reg, rname )

	emitSTORE( vname, vreg, rname, @rvreg )

	'' handle longints
	if( (vreg->dtype = IR.DATATYPE.LONGINT) or (vreg->dtype = IR.DATATYPE.ULONGINT) ) then
		vareg = vreg->vaux
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
    dim as string rname
    dim as IRVREG rvreg

	emitGetRegName( IR.DATATYPE.DOUBLE, IR.DATACLASS.FPOINT, reg, rname )

	rvreg.typ 	= IR.VREGTYPE.REG
	rvreg.dtype = IR.DATATYPE.DOUBLE
	rvreg.reg	= reg

	emitFXCHG( rname, @rvreg )

end sub

'#if 0
'':::::
sub irDump( byval op as integer, _
			byval v1 as IRVREG ptr, _
			byval v2 as IRVREG ptr, _
			byval vr as IRVREG ptr ) static
	dim as string vname

	if( vr <> NULL ) then
		irGetVRName( vr, vname )
		print "v";str$(vr);"(";vname;":";str$(irGetVRType( vr ));":";str$(irGetVRDataType( vr ));")";chr$( 9 );"= ";
	end if

	if( v1 <> NULL ) then
		irGetVRName( v1, vname )
		print "v";str$(v1);"(";vname;":";str$(irGetVRType( v1 ));":";str$(irGetVRDataType( v1 ));")";
	end if

	if( vr = NULL ) then print chr$( 9 ); else print " ";
	print opTB(op).name;

	if( v2 <> NULL ) then
		irGetVRName( v2, vname )
		print " v";str$(v2);"(";vname;":";str$(irGetVRType( v2 ));":";str$(irGetVRType( v2 ));")"
	else
		print
	end if

end sub
'#endif

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#if 0
'':::::
function irGetVRRealValue( byval vreg as IRVREG ptr ) as integer static
    dim as integer rval

	if( vreg = NULL ) then
		irGetVRRealValue = INVALID
		exit function
	end if

	select case as const vreg->typ
	case IR.VREGTYPE.VAR, IR.VREGTYPE.TMPVAR
		rval = vreg->sym

	case IR.VREGTYPE.IDX, IR.VREGTYPE.PTR
		rval = 1234

	case IR.VREGTYPE.IMM
		rval = vreg->value

	case IR.VREGTYPE.REG
		rval = vreg
	end select

	irGetVRRealValue = rval

end function

'':::::
sub irOptimize static
    dim op as integer, class as integer, i as integer, vi as integer
    dim IRVREG ptr v1, v2, vr
    dim vtx1 as integer, vtx2 as integer, vtxo as integer

	if( ctx.codes = 0 ) then
		exit sub
	end if

	for i = 0 to ctx.codes-1

		op 	 = tacTB(i).op
		v1   = tacTB(i).v1
		v2   = tacTB(i).v2
		vr   = tacTB(i).vr

		'class= v1->class

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
