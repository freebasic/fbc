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

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\reg.bi"
#include once "inc\emit.bi"
#include once "inc\emitdbg.bi"
#include once "inc\flist.bi"
#include once "inc\ir.bi"
#include once "inc\dag.bi"


type IROPCODE
	typ			as integer
	cummutative as integer
	name		as zstring * 3+1
end type

type IRCTX
	tacTB			as TFLIST
	taccnt			as integer
	tacidx			as IRTAC ptr

	vregTB			as TFLIST
end type

declare sub 		hFlushUOP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		hFlushBOP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		hFlushCOMP			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr, _
										  byval label as FBSYMBOL ptr )

declare sub 		hFlushSTORE			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr )

declare sub 		hFlushLOAD			( byval op as integer, _
										  byval v1 as IRVREG ptr )

declare sub 		hFlushCONVERT		( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr )

declare sub 		hFlushCALL			( byval op as integer, _
										  byval proc as FBSYMBOL ptr, _
										  byval bytestopop as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		hFlushBRANCH		( byval op as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		hFlushSTACK			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval ex as integer )

declare sub 		hFlushADDR			( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

declare sub 		hFreeIDX			( byval vreg as IRVREG ptr, _
										  byval force as integer = FALSE )

declare sub 		hFreeREG			( byval vreg as IRVREG ptr, _
										  byval force as integer = FALSE )

declare sub 		hCreateTMPVAR		( byval vreg as IRVREG ptr )

declare sub 		irDump				( byval op as integer, _
										  byval v1 as IRVREG ptr, _
										  byval v2 as IRVREG ptr, _
										  byval vr as IRVREG ptr )

'' globals
	dim shared ctx as IRCTX

	dim shared regTB(0 to EMIT_REGCLASSES-1) as REGCLASS ptr

	'' same order as IRDATATYPE_ENUM
	dim shared dtypeTB( 0 to IR_MAXDATATYPES-1 ) as IRDATATYPE => _
	{ _
		(IR_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, IR_DATATYPE_VOID    ), _
		(IR_DATACLASS_INTEGER, 1			 	, 8*1				, TRUE , IR_DATATYPE_BYTE    ), _
		(IR_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, IR_DATATYPE_UBYTE   ), _
		(IR_DATACLASS_INTEGER, 1			 	, 8*1				, FALSE, IR_DATATYPE_CHAR	 ), _ '' zstring
		(IR_DATACLASS_INTEGER, 2			 	, 8*2				, TRUE , IR_DATATYPE_SHORT 	 ), _
		(IR_DATACLASS_INTEGER, 2			 	, 8*2				, FALSE, IR_DATATYPE_USHORT	 ), _
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , IR_DATATYPE_INTEGER ), _
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, IR_DATATYPE_UINT 	 ), _
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, TRUE , IR_DATATYPE_INTEGER ), _ '' enum
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, TRUE , IR_DATATYPE_LONGINT ), _
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE*2	, 8*FB_INTEGERSIZE*2, FALSE, IR_DATATYPE_ULONGINT), _
		(IR_DATACLASS_FPOINT , 4             	, 8*4				, TRUE , IR_DATATYPE_SINGLE	 ), _
		(IR_DATACLASS_FPOINT , 8			 	, 8*8				, TRUE , IR_DATATYPE_DOUBLE	 ), _
		(IR_DATACLASS_STRING , FB_STRSTRUCTSIZE	, 0					, FALSE, IR_DATATYPE_STRING	 ), _
		(IR_DATACLASS_STRING , 1			 	, 8*1				, FALSE, IR_DATATYPE_FIXSTR	 ), _
		(IR_DATACLASS_UDT	 , 0			 	, 0					, FALSE, IR_DATATYPE_USERDEF ), _
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, IR_DATATYPE_UINT	 ), _ '' func
		(IR_DATACLASS_UNKNOWN, 0			 	, 0					, FALSE, IR_DATATYPE_VOID	 ), _ '' fwdref
		(IR_DATACLASS_INTEGER, FB_INTEGERSIZE	, 8*FB_INTEGERSIZE	, FALSE, IR_DATATYPE_UINT	 )  _ '' ptr
	}

	'' same order as IROP_ENUM
	dim shared opTB( 0 to IR_OPS-1 ) as IROPCODE => _
	{ _
		( IR_OPTYPE_LOAD	, FALSE, "ld"  ), _ '' IR_OP_LOAD
		( IR_OPTYPE_LOAD	, FALSE, "ldr" ), _ '' IR_OP_LOADRESULT
		( IR_OPTYPE_STORE	, FALSE, ":="  ), _	'' IR_OP_STORE
		( IR_OPTYPE_BINARY	, TRUE , "+"   ), _	'' IR_OP_ADD
		( IR_OPTYPE_BINARY	, FALSE, "-"   ), _	'' IR_OP_SUB
		( IR_OPTYPE_BINARY	, TRUE , "*"   ), _	'' IR_OP_MUL
		( IR_OPTYPE_BINARY	, FALSE, "/"   ), _	'' IR_OP_DIV
		( IR_OPTYPE_BINARY	, FALSE, "\\"  ), _	'' IR_OP_INTDIV
		( IR_OPTYPE_BINARY	, FALSE, "%"   ), _	'' IR_OP_MOD
		( IR_OPTYPE_BINARY	, TRUE , "&"   ), _	'' IR_OP_AND
		( IR_OPTYPE_BINARY	, TRUE , "|"   ), _	'' IR_OP_OR
		( IR_OPTYPE_BINARY	, TRUE , "~"   ), _	'' IR_OP_XOR
		( IR_OPTYPE_BINARY	, FALSE, "eqv" ), _	'' IR_OP_EQV
		( IR_OPTYPE_BINARY	, FALSE, "imp" ), _	'' IR_OP_IMP
		( IR_OPTYPE_BINARY	, FALSE, "<<"  ), _	'' IR_OP_SHL
		( IR_OPTYPE_BINARY	, FALSE, ">>"  ), _	'' IR_OP_SHR
		( IR_OPTYPE_BINARY	, FALSE, "^"   ), _	'' IR_OP_POW
		( IR_OPTYPE_BINARY	, FALSE, "mov" ), _	'' IR_OP_MOV
		( IR_OPTYPE_BINARY	, FALSE, "at2" ), _	'' IR_OP_ATN2
		( IR_OPTYPE_COMP	, TRUE , "=="  ), _	'' IR_OP_EQ
		( IR_OPTYPE_COMP	, FALSE, ">"   ), _	'' IR_OP_GT
		( IR_OPTYPE_COMP	, FALSE, "<"   ), _	'' IR_OP_LT
		( IR_OPTYPE_COMP	, TRUE , "<>"  ), _	'' IR_OP_NE
		( IR_OPTYPE_COMP	, FALSE, ">="  ), _	'' IR_OP_GE
		( IR_OPTYPE_COMP	, FALSE, "<="  ), _	'' IR_OP_LE
		( IR_OPTYPE_UNARY 	, FALSE, "!"   ), _	'' IR_OP_NOT
		( IR_OPTYPE_UNARY	, FALSE, "-"   ), _	'' IR_OP_NEG
		( IR_OPTYPE_UNARY	, FALSE, "abs" ), _	'' IR_OP_ABS
		( IR_OPTYPE_UNARY	, FALSE, "sgn" ), _	'' IR_OP_SGN
		( IR_OPTYPE_UNARY	, FALSE, "sin" ), _	'' IR_OP_SIN
		( IR_OPTYPE_UNARY	, FALSE, "asn" ), _	'' IR_OP_ASIN
		( IR_OPTYPE_UNARY	, FALSE, "cos" ), _	'' IR_OP_COS
		( IR_OPTYPE_UNARY	, FALSE, "acs" ), _	'' IR_OP_ACOS
		( IR_OPTYPE_UNARY	, FALSE, "tan" ), _	'' IR_OP_TAN
		( IR_OPTYPE_UNARY	, FALSE, "atn" ), _	'' IR_OP_ATAN
		( IR_OPTYPE_UNARY	, FALSE, "sqr" ), _	'' IR_OP_SQRT
		( IR_OPTYPE_UNARY	, FALSE, "log" ), _	'' IR_OP_LOG
		( IR_OPTYPE_UNARY	, FALSE, "flo" ), _	'' IR_OP_FLOOR
		( IR_OPTYPE_ADDRESS , FALSE, "@"   ), _	'' IR_OP_ADDROF
		( IR_OPTYPE_ADDRESS , FALSE, "*"   ), _	'' IR_OP_DEREF
		( IR_OPTYPE_CONVERT	, FALSE, "2i"  ), _	'' IR_OP_TOINT
		( IR_OPTYPE_CONVERT	, FALSE, "2f"  ), _	'' IR_OP_TOFLT
		( IR_OPTYPE_STACK	, FALSE, "psh" ), _	'' IR_OP_PUSH
		( IR_OPTYPE_STACK	, FALSE, "pop" ), _	'' IR_OP_POP
		( IR_OPTYPE_STACK	, FALSE, "psh" ), _	'' IR_OP_PUSHUDT
		( IR_OPTYPE_STACK	, FALSE, "alg" ), _	'' IR_OP_STACKALIGN
		( IR_OPTYPE_BRANCH	, FALSE, "jeq" ), _	'' IR_OP_JEQ
		( IR_OPTYPE_BRANCH	, FALSE, "jgt" ), _	'' IR_OP_JGT
		( IR_OPTYPE_BRANCH	, FALSE, "jlt" ), _	'' IR_OP_JLT
		( IR_OPTYPE_BRANCH	, FALSE, "jne" ), _	'' IR_OP_JNE
		( IR_OPTYPE_BRANCH	, FALSE, "jge" ), _	'' IR_OP_JGE
		( IR_OPTYPE_BRANCH	, FALSE, "jle" ), _	'' IR_OP_JLE
		( IR_OPTYPE_BRANCH	, FALSE, "jmp" ), _	'' IR_OP_JMP
		( IR_OPTYPE_BRANCH	, FALSE, "cal" ), _	'' IR_OP_CALL
		( IR_OPTYPE_BRANCH	, FALSE, "lbl" ), _	'' IR_OP_LABEL
		( IR_OPTYPE_CALL	, FALSE, "caf" ), _	'' IR_OP_CALLFUNC
		( IR_OPTYPE_CALL	, FALSE, "ca@" ), _	'' IR_OP_CALLPTR
		( IR_OPTYPE_CALL	, FALSE, "jm@" )  _	'' IR_OP_JUMPPTR
	}

'':::::
sub irInit
	dim as integer i

	''
	ctx.tacidx = NULL
	ctx.taccnt = 0

	flistNew( @ctx.tacTB, IR_INITADDRNODES, len( IRTAC ) )

	''
	flistNew( @ctx.vregTB, IR_INITVREGNODES, len( IRVREG ) )

	''
	emitInit( )

	for i = 0 to EMIT_REGCLASSES-1
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

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).class

end function

'':::::
function irMaxDataType( byval ldtype as integer, _
						byval rdtype as integer ) as integer static

    dim as integer dtype1, dtype2

    function = INVALID

    if( ldtype > IR_DATATYPE_POINTER ) then
    	dtype1 = IR_DATATYPE_UINT				'' can't be POINTER, due the -1 +1 hacks below
    else
    	dtype1 = dtypeTB(ldtype).remaptype
    end if

    if( rdtype > IR_DATATYPE_POINTER ) then
    	dtype2 = IR_DATATYPE_UINT               '' ditto
    else
    	dtype2 = dtypeTB(rdtype).remaptype
    end if

    '' don't convert between zstring's and (u)byte's
    if( dtype2 = IR_DATATYPE_CHAR ) then
 		select case dtype1
 		case IR_DATATYPE_BYTE, IR_DATATYPE_UBYTE
 			exit function
    	end select
    elseif( dtype1 = IR_DATATYPE_CHAR ) then
 		select case dtype2
 		case IR_DATATYPE_BYTE, IR_DATATYPE_UBYTE
 			exit function
    	end select
    end if

    ''
    if( dtype1 = dtype2 ) then
    	exit function
    end if

    '' don't convert byte <-> char, word <-> short, dword <-> integer, single <-> double
    select case as const dtype1
    case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT, _
    	 IR_DATATYPE_ULONGINT, IR_DATATYPE_DOUBLE
    	if( dtype1 - dtype2 = 1 ) then
    		exit function
    	end if

    case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR
    	return IR_DATATYPE_STRING

    case else
    	if( dtype1 - dtype2 = -1 ) then
    		exit function
    	end if
    end select

    '' assuming DATATYPE's are in order of precision
    if( dtype1 > dtype2 ) then
    	function = ldtype
    else
    	function = rdtype
    end if

end function

'':::::
function irIsSigned( byval dtype as integer ) as integer static

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).signed

end function

'':::::
function irGetDataSize( byval dtype as integer ) as integer static

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).size

end function

'':::::
function irGetDataBits( byval dtype as integer ) as integer static

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).bits

end function

'':::::
function irGetSignedType( byval dtype as integer ) as integer static
	dim as integer dt

	dt = dtype
	if( dt > IR_DATATYPE_POINTER ) then
		dt = IR_DATATYPE_POINTER
	end if

	if( dtypeTB(dt).class <> IR_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case IR_DATATYPE_UBYTE, IR_DATATYPE_USHORT, IR_DATATYPE_UINT, IR_DATATYPE_ULONGINT
		dtype -= 1							'' hack! assuming sign/unsig are in pairs
	case IR_DATATYPE_POINTER
		dtype = IR_DATATYPE_INTEGER
	end select

	function = dtype

end function

'':::::
function irGetUnsignedType( byval dtype as integer ) as integer static
	dim as integer dt

	dt = dtype
	if( dt > IR_DATATYPE_POINTER ) then
		dt = IR_DATATYPE_POINTER
	end if

	if( dtypeTB(dt).class <> IR_DATACLASS_INTEGER ) then
		return dtype
	end if

	select case as const dt
	case IR_DATATYPE_BYTE, IR_DATATYPE_SHORT, IR_DATATYPE_INTEGER, IR_DATATYPE_LONGINT
		dtype = dtype + 1					'' hack! assuming sign/unsig are in pairs
	case IR_DATATYPE_CHAR
		dtype = IR_DATATYPE_BYTE
	case IR_DATATYPE_ENUM
		dtype = IR_DATATYPE_UINT
	end select

	function = dtype

end function

'':::::
private sub hLoadIDX( byval vreg as IRVREG ptr, _
					  byval vtype as integer )
    dim as IRVREG ptr vi

	if( vreg = NULL ) then
		exit sub
	end if

	select case vtype
	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
	case else
		exit sub
	end select

	'' any vreg attached?
	vi = vreg->vidx
	if( vi = NULL ) then
		exit sub
	end if

	'' x86 assumption: don't load immediates to registers
	if( vi->typ = IR_VREGTYPE_IMM ) then
		exit sub
	end if

	regTB(IR_DATACLASS_INTEGER)->ensure( regTB(IR_DATACLASS_INTEGER), vi )

end sub

'':::::
#define hGetVREG(vreg,dt,dc,t) 						_
	if( vreg <> NULL ) then 						: _
		t = vreg->typ 								: _
                                                	: _
		dt = vreg->dtype							: _
		if( dt >= IR_DATATYPE_POINTER ) then		: _
			dt = IR_DATATYPE_UINT					: _
			dc = IR_DATACLASS_INTEGER				: _
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
	case IR_OP_EQ
		op = IR_OP_NE
	case IR_OP_NE
		op = IR_OP_EQ
	case IR_OP_GT
		op = IR_OP_LE
	case IR_OP_LT
		op = IR_OP_GE
	case IR_OP_GE
		op = IR_OP_LT
	case IR_OP_LE
		op = IR_OP_GT
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

	if( dtype1 > IR_DATATYPE_POINTER ) then
		dtype1 = IR_DATATYPE_POINTER
	end if

	select case dtypeTB(dtype1).class
	case IR_DATACLASS_INTEGER
		irEmit( IR_OP_TOINT, v1, v2, NULL )
	case IR_DATACLASS_FPOINT
		irEmit( IR_OP_TOFLT, v1, v2, NULL )
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
	irEMITBRANCH( IR_OP_JMP, endlabel )

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
    if( (mode = FB_FUNCMODE_CDECL) or _
    	((mode = FB_FUNCMODE_STDCALL) and (env.clopt.nostdcall)) ) then
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
	if( amode = FB_ARGMODE_BYDESC ) then

		amode = FB_ARGMODE_BYVAL

    '' var args?
    elseif( amode = FB_ARGMODE_VARARG ) then

    	'' string argument?
    	if( (pdclass = IR_DATACLASS_STRING) or _
    		(pdtype = IR_DATATYPE_CHAR) ) then
			'' not a pointer yet?
			if( pclass = IR_VREGTYPE_PTR ) then
				amode = FB_ARGMODE_BYREF
			else
				amode = FB_ARGMODE_BYVAL
			end if

    	'' otherwise, pass as-is
    	else
    		amode = FB_ARGMODE_BYVAL
    	end if

    '' as any?
    elseif( adtype = IR_DATATYPE_VOID ) then

		if( pmode = FB_ARGMODE_BYVAL ) then

    		'' another quirk: BYVAL strings passed to BYREF ANY args..
    		if( pdclass = IR_DATACLASS_STRING ) then
    			'' not a pointer yet?
    			if( pclass <> IR_VREGTYPE_PTR ) then
    				amode = FB_ARGMODE_BYVAL
    			else
    				amode = FB_ARGMODE_BYREF
    			end if

    		'' zstring?
    		elseif( pdtype = IR_DATATYPE_CHAR ) then
    			'' not a pointer yet?
    			if( pclass <> IR_VREGTYPE_PTR ) then
    				amode = FB_ARGMODE_BYVAL
    			else
    				pmode = INVALID
    				amode = FB_ARGMODE_BYREF
    			end if

    		'' otherwise, pass as-is
    		else
    			amode = FB_ARGMODE_BYVAL
    		end if

    	'' passing an immediate?
    	elseif( irIsIMM( vr ) or (vr->typ = IR_VREGTYPE_OFS) ) then
        	amode = FB_ARGMODE_BYVAL

    	'' anything else, use the param type to create a temp var if needed
    	else
    		adtype = pdtype
    	end if

    '' byval or byref (but as any)
    else

    	'' string argument?
    	if( adclass = IR_DATACLASS_STRING ) then

			if( pmode <> FB_ARGMODE_BYVAL ) then

				'' not a pointer yet?
				if( pclass = IR_VREGTYPE_PTR ) then
					'' BYVAL or not the mode has to be changed to byref, as
					'' BYVAL AS STRING is actually BYREF AS ZSTRING
					amode = FB_ARGMODE_BYREF
				else
					amode = FB_ARGMODE_BYVAL
				end if

			else
				amode = FB_ARGMODE_BYVAL
			end if

		end if

	end if

	'' push to stack, depending on arg mode
	select case amode
	case FB_ARGMODE_BYVAL

		if( plen = 0 ) then
			irEmitPUSH( vr )
		else
			irEmitPUSHUDT( vr, plen )
		end if

	case FB_ARGMODE_BYREF
		'' BYVAL param? pass as-is
		if( pmode = FB_ARGMODE_BYVAL ) then
			irEmitPUSH( vr )

		else

			isptr = FALSE

			select case pclass
			'' simple pointer?
			case IR_VREGTYPE_PTR
				if( vr->ofs = 0 ) then
					isptr = TRUE
				end if

			'' simple index?
			case IR_VREGTYPE_IDX
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

				vt = irAllocVREG( IR_DATATYPE_UINT )
				irEmitADDR( IR_OP_ADDROF, vr, vt )
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
		emitVARINIi( IR_DATATYPE_BYTE, 0 )
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
				  byval vtype as integer ) as IRVREG ptr static
	dim as IRVREG ptr v

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	v = flistNewItem( @ctx.vregTB )

	v->typ 	= vtype
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

	vr = irNewVR( dtype, IR_VREGTYPE_REG )

	function = vr

	'' longint?
	if( ISLONGINT( dtype ) ) then
		 vr->vaux = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_REG )
	end if

end function

'':::::
function irAllocVRIMM( byval dtype as integer, _
					   byval value as integer ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR_VREGTYPE_IMM )

	function = vr

	vr->value = value

	'' longint?
	if( ISLONGINT( dtype ) ) then
		 vr->vaux = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_IMM )
		 vr->vaux->value = 0
	end if

end function

'':::::
function irAllocVRIMM64( byval dtype as integer, _
						 byval value as longint ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR_VREGTYPE_IMM )

	function = vr

	vr->value = cuint( value )

	'' aux
	vr->vaux = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_IMM )

	vr->vaux->value = cint( value shr 32 )

end function

'':::::
function irAllocVRVAR( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR_VREGTYPE_VAR )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= ofs

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_VAR )
		vr->vaux = va
		va->ofs = ofs + FB_INTEGERSIZE
	end if

end function

'':::::
function irAllocVRIDX( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr, _
					   byval ofs as integer, _
					   byval mult as integer, _
					   byval vidx as IRVREG ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR_VREGTYPE_IDX )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= ofs
	vr->mult	= mult
	vr->vidx	= vidx

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_IDX )
		vr->vaux= va
		va->ofs = ofs + FB_INTEGERSIZE
	end if

end function

'':::::
function irAllocVRPTR( byval dtype as integer, _
					   byval ofs as integer, _
					   byval vidx as IRVREG ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr, va

	vr = irNewVR( dtype, IR_VREGTYPE_PTR )

	function = vr

	vr->ofs 	= ofs
	vr->mult 	= 1
	vr->vidx	= vidx

	'' longint?
	if( ISLONGINT( dtype ) ) then
		va = irNewVR( IR_DATATYPE_INTEGER, IR_VREGTYPE_IDX )
		vr->vaux= va
		va->ofs = ofs + FB_INTEGERSIZE
	end if

end function

'':::::
function irAllocVROFS( byval dtype as integer, _
					   byval symbol as FBSYMBOL ptr ) as IRVREG ptr static
	dim as IRVREG ptr vr

	vr = irNewVR( dtype, IR_VREGTYPE_OFS )

	function = vr

	vr->sym 	= symbol
	vr->ofs 	= 0

end function

'':::::
function irIsVAR( byval vreg as IRVREG ptr ) as integer static

	function = FALSE

	select case vreg->typ
	case IR_VREGTYPE_VAR
		function = TRUE
	end select

end function

'':::::
function irIsIDX( byval vreg as IRVREG ptr ) as integer static

	function = FALSE

	select case vreg->typ
	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		function = TRUE
	end select

end function


'':::::
function irGetVRDataClass( byval vreg as IRVREG ptr ) as integer static
	dim as integer dtype

	dtype = vreg->dtype

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).class

end function

'':::::
function irGetVRDataSize( byval vreg as IRVREG ptr ) as integer static
	dim as integer dtype

	dtype = vreg->dtype

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	function = dtypeTB(dtype).size

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hRename( byval vold as IRVREG ptr, _
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
		case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
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
private sub hReuse( byval t as IRTAC ptr ) static
    dim as IRVREG ptr v1
    dim as IRVREG ptr v2
    dim as IRVREG ptr vr
    dim as integer v1_dtype, v1_dclass, v1_typ
    dim as integer v2_dtype, v2_dclass, v2_typ
    dim as integer vr_dtype, vr_dclass, vr_typ
    dim as integer op, v1rename, v2rename
    dim as IRTACVREG ptr tmp

	op	 = t->op
	v1   = t->arg1.vreg
	v2   = t->arg2.vreg
	vr   = t->res.vreg

	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
    hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	select case opTB(op).typ
	case IR_OPTYPE_UNARY
		if( vr <> v1 ) then
			if( vr_dtype = v1_dtype ) then
           		if( irGetDistance( v1 ) = IR_MAXDIST ) then
           			hRename( vr, v1 )
           		end if
           	end if
		end if

	case IR_OPTYPE_BINARY, IR_OPTYPE_COMP

		if( vr = NULL ) then
			exit sub
		end if

		'' check if operands have the same class (can happen 'cause the x86 FPU hacks)
		if( v1_dclass <> v2_dclass ) then
			exit sub
		end if

		v1rename = FALSE
		if( vr <> v1 ) then
			if( vr_dtype = v1_dtype ) then
           		if( irGetDistance( v1 ) = IR_MAXDIST ) then
           			v1rename = TRUE
           		end if
           	end if
		end if

		v2rename = FALSE
		if( opTB(op).cummutative ) then
			if( vr <> v2 ) then
				if( vr_dtype = v2_dtype ) then
					if( v2_typ <> IR_VREGTYPE_IMM ) then
           				if( irGetDistance( v2 ) = IR_MAXDIST ) then
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
           	hRename( vr, v1 )

		elseif( v2rename ) then
			'' swap t->arg1, t->arg2
			t->arg2.vreg = v1
			t->arg1.vreg = v2

			tmp = t->arg2.next
			t->arg2.next = t->arg1.next
			t->arg1.next = tmp

			hRename( vr, v2 )
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

	'hOptimize

	t = flistGetHead( @ctx.tacTB )
	do
		ctx.tacidx = t

		hReuse( t )

		op = t->op

		''
		''irDump( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg )

        ''
		select case as const opTB(op).typ
		case IR_OPTYPE_UNARY
			hFlushUOP( op, t->arg1.vreg, t->res.vreg )

		case IR_OPTYPE_BINARY
			hFlushBOP( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg )

		case IR_OPTYPE_COMP
			hFlushCOMP( op, t->arg1.vreg, t->arg2.vreg, t->res.vreg, t->ex1 )

		case IR_OPTYPE_STORE
			hFlushSTORE( op, t->arg1.vreg, t->arg2.vreg )

		case IR_OPTYPE_LOAD
			hFlushLOAD( op, t->arg1.vreg )

		case IR_OPTYPE_CONVERT
			hFlushCONVERT( op, t->arg1.vreg, t->arg2.vreg )

		case IR_OPTYPE_STACK
			hFlushSTACK( op, t->arg1.vreg, t->ex2 )

		case IR_OPTYPE_CALL
			hFlushCALL( op, t->ex1, t->ex2, t->arg1.vreg, t->res.vreg )

		case IR_OPTYPE_BRANCH
			hFlushBRANCH( op, t->ex1 )

		case IR_OPTYPE_ADDRESS
			hFlushADDR( op, t->arg1.vreg, t->res.vreg )
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
private sub hFlushBRANCH( byval op as integer, _
				   		  byval label as FBSYMBOL ptr ) static
    dim lname as string

	lname = symbGetName( label )

	''
	select case as const op
	case IR_OP_LABEL
		emitLABEL( lname )

	case IR_OP_JMP
		emitJMP( lname )
	case IR_OP_CALL
		emitCALL( lname, 0 )

	case else
		emitBRANCH( op, lname )
	end select

end sub

'':::::
private sub hPreserveRegs( byval ptrvreg as IRVREG ptr = NULL ) static
    dim as IRVREG ptr vr
    dim as IRVREG tr
    dim as integer reg
    dim as integer vr_dclass, vr_dtype, vr_typ
    dim as string dname, sname
    dim as integer freg							'' free reg
    dim as integer npreg						'' don't preserve reg (used with CALLPTR)
    dim as integer class

	'' for each reg class
	for class = 0 to EMIT_REGCLASSES-1

    	'' set the register that shouldn't be preserved (used for CALLPTR only)
    	npreg = INVALID
    	if( class = IR_DATACLASS_INTEGER ) then
    		if( ptrvreg <> NULL ) then

    			select case ptrvreg->typ
    			case IR_VREGTYPE_REG
    				npreg = ptrvreg->reg

    			case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
    				ptrvreg = ptrvreg->vidx
    				if( ptrvreg <> NULL ) then
    					npreg = ptrvreg->reg
    				end if
    			end select

    			ptrvreg = NULL
    		end if
    	end if

		'' for each register on that class
		reg = regTB(class)->getFirst( regTB(class) )
		do until( reg = INVALID )
			'' if not free
			if( (not regTB(class)->isFree( regTB(class), reg )) and (reg <> npreg) ) then

				'' get the attached vreg
				vr = regTB(class)->getVreg( regTB(class), reg )
                hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

        		'' if reg is not preserved between calls
        		if( not emitIsRegPreserved( vr_dtype, vr_dclass, reg ) ) then

        			'' find a preserved reg to copy to
        			freg = emitGetFreePreservedReg( vr_dtype, vr_dclass )

        			'' if none free, spill reg
        			if( freg = INVALID ) then
        				irStoreVR( vr, reg )

        			'' else, copy it to a preserved reg
        			else
        				tr = *vr
        				vr->reg = regTB(vr_dclass)->allocateReg( regTB(vr_dclass), freg, vr )
        				emitMOV( vr, @tr )

        			end if

        			'' free reg
        			regTB(vr_dclass)->free( regTB(vr_dclass), reg )
        		end if
        	end if

        	'' next reg
        	reg = regTB(class)->getNext( regTB(class), reg )
		loop

	next

end sub

'':::::
private sub hFlushCALL( byval op as integer, _
				 		byval proc as FBSYMBOL ptr, _
				 		byval bytes2pop as integer, _
				 		byval v1 as IRVREG ptr, _
				 		byval vr as IRVREG ptr ) static

    dim as integer mode
    dim as integer vr_dclass, vr_dtype, vr_typ, vr_reg, vr_reg2
    dim as IRVREG ptr va

	'' call function
    if( proc <> NULL ) then
    	mode = symbGetFuncMode( proc )
    	if( (mode = FB_FUNCMODE_CDECL) or _
    		((mode = FB_FUNCMODE_STDCALL) and (env.clopt.nostdcall)) ) then
			if( bytes2pop = 0 ) then
				bytes2pop = symbGetLen( proc )
			end if
		else
			bytes2pop = 0
		end if

    	'' save used registers and free the FPU stack
    	hPreserveRegs( )

		emitCALL( symbGetName( proc ), bytes2pop )

	'' call or jump to pointer
	else

    	'' if it's a CALL, save used registers and free the FPU stack
    	if( op = IR_OP_CALLPTR ) then
    		hPreserveRegs( v1 )
    	end if

		'' load pointer
		hGetVREG( v1, vr_dtype, vr_dclass, vr_typ )
		hLoadIDX( v1, vr_typ )
		if( vr_typ = IR_VREGTYPE_REG ) then
			regTB(vr_dclass)->ensure( regTB(vr_dclass), v1 )
		end if

		'' CALLPTR
		if( op = IR_OP_CALLPTR ) then
			emitCALLPTR( v1, bytes2pop )
		'' JUMPPTR
		else
			emitBRANCHPTR( v1 )
		end if

		'' free pointer
		hFreeREG( v1 )
	end if

	'' load result
	if( vr <> NULL ) then
		hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

		emitGetResultReg( vr_dtype, vr_dclass, vr_reg, vr_reg2 )

		'' longints..
		if( ISLONGINT( vr_dtype ) ) then
			va = vr->vaux
			va->reg = regTB(vr_dclass)->allocateReg( regTB(vr_dclass), vr_reg2, va )
			va->typ = IR_VREGTYPE_REG
		end if

		vr->reg = regTB(vr_dclass)->allocateReg( regTB(vr_dclass), vr_reg, vr )
		vr->typ = IR_VREGTYPE_REG

    	'' fb allows function calls w/o saving the result
		hFreeREG( vr )
	end if

end sub

'':::::
private sub hFlushSTACK( byval op as integer, _
				  		 byval v1 as IRVREG ptr, _
				  		 byval ex as integer ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as IRVREG ptr va

	''
	if( op = IR_OP_STACKALIGN ) then
		emitSTACKALIGN( ex )
		exit sub
	end if

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )

	hLoadIDX( v1, v1_typ )

	'' load only if it's a reg (x86 assumption)
	if( v1_typ = IR_VREGTYPE_REG ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
	end if

	''
	select case op
	case IR_OP_PUSH
		emitPUSH( v1 )
	case IR_OP_PUSHUDT
		emitPUSHUDT( v1, ex )
	case IR_OP_POP
		emitPOP( v1 )
	end select

    ''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushUOP( byval op as integer, _
			    	   byval v1 as IRVREG ptr, _
			    	   byval vr as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( vr, vr_typ )

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			'' handle longint
			if( ISLONGINT( vr_dtype ) ) then
				va = vr->vaux
				regTB(vr_dclass)->ensure( regTB(vr_dclass), va, FALSE )
			end if

			regTB(vr_dclass)->ensure( regTB(vr_dclass), vr )
		end if
	end if

	'' UOP to self? x86 assumption at AST
	if( vr <> NULL ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
	end if

	''
	select case as const op
	case IR_OP_NEG
		emitNEG( v1 )
	case IR_OP_NOT
		emitNOT( v1 )

	case IR_OP_ABS
		emitABS( v1 )
	case IR_OP_SGN
		emitSGN( v1 )

	case IR_OP_SIN
		emitSIN( v1 )
	case IR_OP_ASIN
		emitASIN( v1 )
	case IR_OP_COS
		emitCOS( v1 )
	case IR_OP_ACOS
		emitACOS( v1 )
	case IR_OP_TAN
		emitTAN( v1 )
	case IR_OP_ATAN
		emitATAN( v1 )
	case IR_OP_SQRT
		emitSQRT( v1 )
	case IR_OP_LOG
		emitLOG( v1 )
	case IR_OP_FLOOR
		emitFLOOR( v1 )
	end select

    ''
    if ( vr <> NULL ) then
		if( v1 <> vr ) then
			emitMOV( vr, v1 )
		end if
	end if

    ''
	hFreeREG( v1 )
	hFreeREG( vr )

end sub

'':::::
private sub hFlushBOP( byval op as integer, _
					   byval v1 as IRVREG ptr, _
					   byval v2 as IRVREG ptr, _
					   byval vr as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( v2, v2_typ )
	hLoadIDX( vr, vr_typ )

	'' BOP to self? (x86 assumption at AST)
	if( vr = NULL ) then
		if( v2_typ <> IR_VREGTYPE_IMM ) then		'' x86 assumption
			'' handle longint
			if( ISLONGINT( v2_dtype ) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, FALSE )
			end if

			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2 )
		end if

	else
		if( v2_typ = IR_VREGTYPE_REG ) then			'' x86 assumption
			'' handle longint
			if( ISLONGINT( v2_dtype ) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, FALSE )
			end if

			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2 )
		end if

		'' destine allocation comes *after* source, 'cause the x86 FPU stack
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
	end if

    ''
	select case as const op
	case IR_OP_ADD
		emitADD( v1, v2 )
	case IR_OP_SUB
		emitSUB( v1, v2 )
	case IR_OP_MUL
		emitMUL( v1, v2 )
	case IR_OP_DIV
        emitDIV( v1, v2 )
	case IR_OP_INTDIV
        emitINTDIV( v1, v2 )
	case IR_OP_MOD
		emitMOD( v1, v2 )

	case IR_OP_SHL
		emitSHL( v1, v2 )
	case IR_OP_SHR
		emitSHR( v1, v2 )

	case IR_OP_AND
		emitAND( v1, v2 )
	case IR_OP_OR
		emitOR( v1, v2 )
	case IR_OP_XOR
		emitXOR( v1, v2 )
	case IR_OP_EQV
		emitEQV( v1, v2 )
	case IR_OP_IMP
		emitIMP( v1, v2 )

	case IR_OP_MOV
		emitMOV( v1, v2 )

	case IR_OP_ATAN2
        emitATAN2( v1, v2 )
    case IR_OP_POW
    	emitPOW( v1, v2 )
	end select

    '' not BOP to self?
	if ( vr <> NULL ) then
		'' result not equal destine? (can happen with DAG optimizations)
		if( (v1 <> vr) ) then
			'' handle longint
			if( ISLONGINT( vr_dtype ) ) then
				va = vr->vaux
				regTB(vr_dclass)->ensure( regTB(vr_dclass), va, FALSE )
			end if

			regTB(vr_dclass)->ensure( regTB(vr_dclass), vr )

			emitMOV( vr, v1 )
		end if
	end if

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )
	hFreeREG( vr )

end sub

'':::::
private sub hFlushCOMP( byval op as integer, _
				 		byval v1 as IRVREG ptr, _
				 		byval v2 as IRVREG ptr, _
				 		byval vr as IRVREG ptr, _
				 		byval label as FBSYMBOL ptr ) static

	dim as string lname
	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass
	dim as IRVREG ptr va
	dim as integer doload

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( v2, v2_typ )
	hLoadIDX( vr, vr_typ )

	'' load source if it's a reg, or if result was not allocated
	doload = FALSE
	if( vr = NULL ) then							'' x86 assumption
		if( v2_dclass = IR_DATACLASS_INTEGER ) then	'' /
			if( v2_typ <> IR_VREGTYPE_IMM ) then	'' /
				if( v1_dclass <> IR_DATACLASS_FPOINT ) then
					doload = TRUE
				end if
			end if
		end if
	end if

	if( (v2_typ = IR_VREGTYPE_REG) or doload ) then
		'' handle longint
		if( ISLONGINT( v2_dtype ) ) then
			va = v2->vaux
			regTB(v2_dclass)->ensure( regTB(v2_dclass), va, FALSE )
		end if

		regTB(v2_dclass)->ensure( regTB(v2_dclass), v2 )
		v2_typ = IR_VREGTYPE_REG
	end if

	'' destine allocation comes *after* source, 'cause the FPU stack
	doload = FALSE
	if( (vr <> NULL) and (vr = v1) ) then			'' x86 assumption
		doload = TRUE
	elseif( v1_dclass = IR_DATACLASS_FPOINT ) then	'' /
		doload = TRUE
	elseif( v1_typ = IR_VREGTYPE_IMM) then          '' /
		doload = TRUE
	elseif( v2_typ <> IR_VREGTYPE_REG ) then        '' /
		if( v2_typ <> IR_VREGTYPE_IMM ) then
			doload = TRUE
		end if
	end if

	if( (v1_typ = IR_VREGTYPE_REG) or doload ) then
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
	end if

	'' result not equal destine? (can happen with DAG optimizations and floats comparations)
	if( vr <> NULL ) then
		if( vr <> v1 ) then
			vr->reg = regTB(vr_dclass)->allocate( regTB(vr_dclass), vr )
			vr->typ = IR_VREGTYPE_REG
		end if
	end if

	''
	if( label = NULL ) then
		lname = *hMakeTmpStr( )
	else
		lname = symbGetName( label )
	end if

	''
	select case as const op
	case IR_OP_EQ
		emitEQ( vr, lname, v1, v2 )
	case IR_OP_NE
		emitNE( vr, lname, v1, v2 )
	case IR_OP_GT
		emitGT( vr, lname, v1, v2 )
	case IR_OP_LT
		emitLT( vr, lname, v1, v2 )
	case IR_OP_LE
		emitLE( vr, lname, v1, v2 )
	case IR_OP_GE
		emitGE( vr, lname, v1, v2 )
	end select

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )
	if( vr <> NULL ) then
		hFreeREG( vr )
	end if

end sub

'':::::
private sub hFlushSTORE( byval op as integer, _
				  		 byval v1 as IRVREG ptr, _
				  		 byval v2 as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( v2, v2_typ )

    '' if dst is a fpoint, only load src if its a reg (x86 assumption)
	if( (v2_typ = IR_VREGTYPE_REG) or _
		((v2_typ <> IR_VREGTYPE_IMM) and (v1_dclass = IR_DATACLASS_INTEGER)) ) then

		'' handle longint
		if( ISLONGINT( v2_dtype ) ) then
			va = v2->vaux
			regTB(v2_dclass)->ensure( regTB(v2_dclass), va, FALSE )
		end if

		regTB(v2_dclass)->ensure( regTB(v2_dclass), v2 )
	end if

	''
	emitSTORE( v1, v2 )

    ''
	hFreeREG( v1 )
	hFreeREG( v2 )

end sub

'':::::
private sub hFlushLOAD( byval op as integer, _
				 		byval v1 as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass, v1_reg
	dim as integer vr_reg, vr_reg2
	dim as IRVREG ptr va, vr

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )

	hLoadIDX( v1, v1_typ )

	''
	select case op
	case IR_OP_LOAD
		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
		end if

		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )

	case IR_OP_LOADRESULT
		if( v1_typ = IR_VREGTYPE_REG ) then
			'' handle longint
			if( ISLONGINT( v1_dtype ) ) then
				va = v1->vaux
				regTB(v1_dclass)->ensure( regTB(v1_dclass), va, FALSE )
			end if

			v1_reg = regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
		else
			v1_reg = INVALID
		end if

		emitGetResultReg( v1_dtype, v1_dclass, vr_reg, vr_reg2 )
		if( vr_reg <> v1_reg ) then
			vr = irAllocVREG( v1_dtype )

			'' handle longint
			if( ISLONGINT( v1_dtype ) ) then
				va = vr->vaux
				va->reg = regTB(v1_dclass)->allocateReg( regTB(v1_dclass), vr_reg2, va )
				va->typ = IR_VREGTYPE_REG
			end if

			vr->reg = regTB(v1_dclass)->allocateReg( regTB(v1_dclass), vr_reg, vr )
			vr->typ = IR_VREGTYPE_REG

			''
			emitLOAD( vr, v1 )

			''
			hFreeREG( vr )						'' assuming this is the last operation
		end if
    end select

	''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushCONVERT( byval op as integer, _
				   		   byval v1 as IRVREG ptr, _
				   		   byval v2 as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer v2_typ, v2_dtype, v2_dclass
	dim as integer reuse
	dim as IRVREG ptr va

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( v2, v2_dtype, v2_dclass, v2_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( v2, v2_typ )

    '' x86 assumption: if src is a reg and if classes are the same and
    ''                 src won't be used (DAG?), reuse src
	reuse = FALSE
	if( (v1_dclass = v2_dclass) and (v2_typ = IR_VREGTYPE_REG) ) then

		'' fp to fp conversion with source already on stack? do nothing..
		if( v2_dclass = IR_DATACLASS_FPOINT ) then
			v1->reg 	= v2->reg
			v2->reg 	= INVALID
			v1->typ 	= IR_VREGTYPE_REG
			regTB(v1_dclass)->setOwner( regTB(v1_dclass), v1->reg, v1 )
			exit sub
		end if

		'' it's an integer, check if used again
		if( irGetDistance( v2 ) = IR_MAXDIST ) then
			'' don't reuse if it's a longint
			if( (irGetDataSize( v1_dtype ) <> FB_INTEGERSIZE*2) and _
				(irGetDataSize( v2_dtype ) <> FB_INTEGERSIZE*2) ) then
				reuse = TRUE
			end if
		end if
	end if

	if( reuse ) then
		v1->reg = v2->reg
		v1->typ = IR_VREGTYPE_REG
		regTB(v1_dclass)->setOwner( regTB(v1_dclass), v1->reg, v1 )

	else
		if( v2_typ = IR_VREGTYPE_REG ) then			'' x86 assumption
			'' handle longint
			if( (v2_dtype = IR_DATATYPE_LONGINT) or (v2_dtype = IR_DATATYPE_ULONGINT) ) then
				va = v2->vaux
				regTB(v2_dclass)->ensure( regTB(v2_dclass), va, FALSE )
			end if

			regTB(v2_dclass)->ensure( regTB(v2_dclass), v2 )
		end if

		'' handle longint
		if( ISLONGINT( v1_dtype ) ) then
			va = v1->vaux
			va->reg = regTB(v1_dclass)->allocate( regTB(v1_dclass), va )
			va->typ = IR_VREGTYPE_REG
		end if

		v1->reg = regTB(v1_dclass)->allocate( regTB(v1_dclass), v1 )
		v1->typ = IR_VREGTYPE_REG
	end if

	''
	emitLOAD( v1, v2 )

	''
	if( not reuse ) then
		hFreeREG( v2 )
	else
		v2->reg = INVALID
	end if

	''
	hFreeREG( v1 )

end sub

'':::::
private sub hFlushADDR( byval op as integer, _
						byval v1 as IRVREG ptr, _
						byval vr as IRVREG ptr ) static

	dim as integer v1_typ, v1_dtype, v1_dclass
	dim as integer vr_typ, vr_dtype, vr_dclass

	''
	hGetVREG( v1, v1_dtype, v1_dclass, v1_typ )
	hGetVREG( vr, vr_dtype, vr_dclass, vr_typ )

	hLoadIDX( v1, v1_typ )
	hLoadIDX( vr, vr_typ )

	''
	if( v1_typ = IR_VREGTYPE_REG ) then				'' x86 assumption
		regTB(v1_dclass)->ensure( regTB(v1_dclass), v1 )
	end if

	if( vr_typ = IR_VREGTYPE_REG ) then             '' x86 assumption
		regTB(vr_dclass)->ensure( regTB(vr_dclass), vr )
	end if

	''
	select case op
	case IR_OP_ADDROF
		emitADDROF( vr, v1 )
	case IR_OP_DEREF
		emitDEREF( vr, v1 )
	end select

    ''
	hFreeREG( v1 )
	hFreeREG( vr )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hFreeIDX( byval vreg as IRVREG ptr, _
			  		  byval force as integer = FALSE )

	dim as IRVREG ptr vidx

	if( vreg = NULL ) then
		exit sub
	end if

	vidx = vreg->vidx
    if( vidx <> NULL ) then
    	if( vidx->reg <> INVALID ) then
    		hFreeREG( vidx, force )				'' recursively
    		vreg->vidx = NULL
		end if
	end if

end sub

'':::::
private sub hFreeREG( byval vreg as IRVREG ptr, _
					  byval force as integer = FALSE )

	dim as integer dclass, dist
	dim as IRVREG ptr vaux

	if( vreg = NULL ) then
		exit sub
	end if

	'' free any attached index
	hFreeIDX( vreg, force )

    ''
	if( vreg->typ <> IR_VREGTYPE_REG ) then
		exit sub
	end if

	if( vreg->reg = INVALID ) then
		exit sub
	end if

	''
	dist = IR_MAXDIST
	if( not force ) then
		dist = irGetDistance( vreg )
	end if

	if( dist = IR_MAXDIST ) then
		'' aux?
		if( vreg->vaux <> NULL ) then
			vaux = vreg->vaux
			if( vaux->reg <> INVALID ) then
				hFreeREG( vaux, TRUE )
			end if
		end if

    	dclass = irGetVRDataClass( vreg )
		regTB(dclass)->free( regTB(dclass), vreg->reg )
		vreg->reg = INVALID
	end if

end sub

'':::::
function irGetDistance( byval vreg as IRVREG ptr ) as uinteger
    dim as IRVREG ptr v
    dim as IRTAC ptr t
    dim as integer dist

	if( vreg = NULL ) then
		return IR_MAXDIST
	end if

	'' skip the current tac
	t = ctx.tacidx->nxt

	'' eol?
	if( t = NULL ) then
		return IR_MAXDIST
	end if

	''
	dist = vreg->taclast->pos - t->pos

	'' not used anymore?
	if( dist < 0 ) then
		function = IR_MAXDIST
	else
		function = dist
	end if

end function

'':::::
sub irLoadVR( byval reg as integer, _
			  byval vreg as IRVREG ptr, _
			  byval doload as integer ) static

	dim as IRVREG rvreg

	if( vreg->typ <> IR_VREGTYPE_REG ) then

		if( doload ) then
			rvreg.typ 	= IR_VREGTYPE_REG
			rvreg.dtype = vreg->dtype
			rvreg.reg	= reg
			rvreg.vaux	= vreg->vaux

			emitLOAD( @rvreg, vreg )
		end if

    	'' free any attached reg, forcing if needed
    	hFreeIDX( vreg, TRUE )

    	vreg->typ = IR_VREGTYPE_REG
    end if

	vreg->reg = reg

end sub

'':::::
private sub hCreateTMPVAR( byval vreg as IRVREG ptr ) static

	if( vreg->typ <> IR_VREGTYPE_VAR ) then
		vreg->typ = IR_VREGTYPE_VAR
		vreg->sym = symbAddTempVar( vreg->dtype )
		vreg->ofs = vreg->sym->ofs
		vreg->reg = INVALID
	end if

end sub

'':::::
sub irStoreVR( byval vreg as IRVREG ptr, _
			   byval reg as integer ) static

    dim as IRVREG rvreg
	dim as IRVREG ptr vareg

	if( irGetDistance( vreg ) = IR_MAXDIST ) then
		exit sub
	end if

	rvreg.typ		= IR_VREGTYPE_REG
	rvreg.dtype		= vreg->dtype
	rvreg.reg		= reg
	rvreg.vaux		= vreg->vaux

	hCreateTMPVAR( vreg )

	emitSTORE( vreg, @rvreg )

	'' handle longints
	if( ISLONGINT( vreg->dtype ) ) then
		vareg = vreg->vaux
		if( vareg->typ <> IR_VREGTYPE_VAR ) then
			regTB(IR_DATACLASS_INTEGER)->free( regTB(IR_DATACLASS_INTEGER), vareg->reg )
			vareg->reg = INVALID
			vareg->typ = IR_VREGTYPE_VAR
			vareg->ofs = vreg->ofs + FB_INTEGERSIZE
		end if
	end if

end sub

'':::::
sub irXchgTOS( byval reg as integer ) static
    dim as IRVREG rvreg

	rvreg.typ 	= IR_VREGTYPE_REG
	rvreg.dtype = IR_DATATYPE_DOUBLE
	rvreg.reg	= reg

	emitFXCHG( @rvreg )

end sub

#if 0
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
#endif

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
	case IR_VREGTYPE_VAR
		rval = vreg->sym

	case IR_VREGTYPE_IDX, IR_VREGTYPE_PTR
		rval = 1234

	case IR_VREGTYPE_IMM
		rval = vreg->value

	case IR_VREGTYPE_REG
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
		case IR_OPTYPE_BINARY

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
		case IR_OPTYPE_STORE
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
