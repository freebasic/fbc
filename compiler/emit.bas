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


'' code generation for x86, GNU assembler (GAS) - Intel arch
''
'' chng: sep/2004 written [v1ctor]

defint a-z
option explicit

'$include:'inc\fb.bi'
'$include:'inc\fbint.bi'
'$include:'inc\reg.bi'
'$include:'inc\ir.bi'
'$include:'inc\emit.bi'
'$include:'inc\emitdbg.bi'
'$include:'inc\hash.bi'

type EMITCTX
	inited			as integer

	outf			as integer
	pos				as long

	procstksetup 	as long
	procstkcleanup 	as long

	dataend			as long

	localptr		as integer
	argptr			as integer
end type

type EMITDATATYPE
	class			as integer
	size			as integer
	rnametb			as integer
	mname			as string * 12
	iname			as string * 8
end type

''
declare sub 		outp				( s as string )

declare sub 		hSaveAsmHeader		( byval asmf as integer )


declare function 	hGetTypeString		( byval typ as integer ) as string


''
''globals
	dim shared ctx as EMITCTX
	dim shared NEWLINE as string '* 2
	dim shared COMMA as string '* 2
	dim shared TABCHAR as string '* 1

	redim shared dtypeTB( 0 ) as EMITDATATYPE
	redim shared rnameTB( 0, 0 ) as string

	redim shared keywordhash( 0 ) as HASHTB

''
const EMIT.MAXRNAMES  = 8
const EMIT.MAXRTABLES = 4

regnametbdata:
data "dl","di","si","cl","bl","al","",""
data "dx","di","si","cx","bx","ax","",""
data "edx","edi","esi","ecx","ebx","eax","",""
data "st(0)","st(1)","st(2)","st(3)","st(4)","st(5)","st(6)","st(7)"

'' class, size, regnametb, mov's ptr name, init name
datatypedata:
data IR.DATACLASS.INTEGER, 0 			 , 0, "", ".void"
data IR.DATACLASS.INTEGER, 1			 , 0, "byte ptr", ".byte"
data IR.DATACLASS.INTEGER, 1			 , 0, "byte ptr", ".byte"
data IR.DATACLASS.INTEGER, 2             , 1, "word ptr", ".short"
data IR.DATACLASS.INTEGER, 2             , 1, "word ptr", ".short"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 2, "dword ptr", ".int"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 2, "dword ptr", ".int"
data IR.DATACLASS.FPOINT , 4			 , 3, "dword ptr", ".float"
data IR.DATACLASS.FPOINT , 8			 , 3, "qword ptr", ".double"
data IR.DATACLASS.STRING , 8             , 0, "", ""
data IR.DATACLASS.STRING , 0             , 0, "", ".asciz"
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 0, "dword ptr", ""
data IR.DATACLASS.INTEGER, FB.INTEGERSIZE, 0, "dword ptr", ""

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
data IR.DATACLASS.FPOINT, 7: 'st(7)
data -1

''
keywordata:
data "ebp"
data "esp"
data "st"
data "byte"
data "word"
data "dword"
data "qword"
data "ptr"
data "offset"
data "mov"
data "add"
data "sub"
data "mul"
data "div"
data "imul"
data "idiv"
data "sal"
data "sar"
data "push"
data "pop"
data "test"
data "fild"
data "fld"
data ""

const EMIT_MAXKEYWORDS = 128

'':::::
private sub hInitKeywordsTB
    dim t as integer, i as integer, k as integer
    dim keyword as string

	hashNew keywordhash(), EMIT_MAXKEYWORDS

	'' add reg names
	restore regnametbdata
	for t = 0 to EMIT.MAXRTABLES-1
		for i = 0 to EMIT.MAXRNAMES-2
			read keyword
			if( len( keyword ) > 0 ) then
				k = strpAdd( keyword )
				hashAdd keyword, 0, k, keywordhash(), EMIT_MAXKEYWORDS
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

		k = strpAdd( keyword )
		hashAdd keyword, 0, k, keywordhash(), EMIT_MAXKEYWORDS
	loop

end sub

'':::::
private sub hEndKeywordsTB

	hashFree keywordhash(), EMIT_MAXKEYWORDS

end sub

'':::::
sub emitInit
	dim class as integer, lclass as integer
	dim reg as integer, regs as integer
	dim i as integer, t as integer

	if( ctx.inited ) then
		exit sub
	end if

	''
#ifdef TARGET_WIN32
	NEWLINE = chr$( CHAR_CR ) + chr$( CHAR_LF )
#else
	NEWLINE = chr$( CHAR_LF )
#endif

	COMMA = ", "

	TABCHAR = chr$( CHAR_TAB )

	''
	redim dtypeTB(0 to IR.MAXDATATYPES-1) as EMITDATATYPE

	restore datatypedata
	for i = 0 to IR.MAXDATATYPES-1
		read dtypeTB(i).class
		read dtypeTB(i).size
		read dtypeTB(i).rnametb
		read dtypeTB(i).mname
		read dtypeTB(i).iname
	next i


	''
	redim rnameTB( 0 to EMIT.MAXRTABLES-1, 0 to EMIT.MAXRNAMES-1 ) as string

	restore regnametbdata
	for t = 0 to EMIT.MAXRTABLES-1
		for i = 0 to EMIT.MAXRNAMES-1
			read rnameTB(t, i)
		next i
	next t


	''
	regInit REG.MAXCLASSES

	restore regdata
	lclass = -1
	regs = 0
	do
		read class

		if( lclass <> class ) then
			if( lclass <> -1 ) then
				regInitClass lclass, regs
			end if
			regs = 0
			lclass = class
		end if

		if( class = -1 ) then
			exit do
		end if

		read reg
		regs = regs + 1
	loop

	''
	hInitKeywordsTB

	''
	ctx.inited = TRUE
	ctx.dataend = 0
	ctx.pos		= 0

end sub

'':::::
sub emitEnd

	if( not ctx.inited ) then
		exit sub
	end if

    ''regEnd

    hEndKeywordsTB

    erase rnameTB

	erase dtypeTB

	ctx.inited = FALSE

end sub

'':::::
function emitGetRegName( byval dtype as integer, byval dclass as integer, byval reg as integer ) as string 'static
    dim t as integer

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	if( reg = INVALID ) then
		emitGetRegName = "~"
	else
		t = dtypeTB(dtype).rnametb

		'' with fp, reg isn't the real reg num
		if( dclass = IR.DATACLASS.FPOINT ) then
			reg = sregGetRealReg( reg )
		end if

		emitGetRegName = rnameTB(t, reg)
	end if

end function

'':::::
function emitGetIDXName( byval lgt as integer, byval ofs as integer, idxname as string, _
						 sname as string ) as string
    dim scalestr as string, name as string
    dim addone as integer

	if( lgt > 1 ) then

		addone = FALSE
		select case lgt
		case 3, 5, 9
			lgt = lgt - 1
			addone = TRUE
		end select

		scalestr = "*" + ltrim$( str$( lgt ) )

		if( addone ) then
			scalestr =  scalestr + "+" + idxname
		end if

	else
		scalestr = ""
	end if

	if( ofs <> 0 ) then
		scalestr = scalestr + " +" + str$( ofs )
	end if

	name = idxname + scalestr

	if( len( sname ) > 0 ) then
		name = sname + " + " + name
	end if

	emitGetIDXName = name

end function

'':::::
private function emitLookupReg( rname as string, byval dtype as integer ) as integer 'static
	dim t as integer, i as integer

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	t = dtypeTB(dtype).rnametb

	for i = 0 to EMIT.MAXRNAMES-1
		if( rnameTB(t, i) = rname ) then
			emitLookupReg = i
			exit function
		end if
	next i

	emitLookupReg = INVALID

end function

'':::::
function emitIsRegPreserved ( byval dtype as integer, byval dclass as integer, byval reg as integer ) as integer 'static

    if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

    '' fp? fpu stack *must* be cleared before calling any function
    if( dclass = IR.DATACLASS.FPOINT ) then
    	emitIsRegPreserved = FALSE
    	exit function
    end if

    select case reg
    case EMIT.INTREG.EAX, EMIT.INTREG.ECX, EMIT.INTREG.EDX
    	emitIsRegPreserved = FALSE
    case else
    	emitIsRegPreserved = TRUE
	end select

end function

'':::::
function emitGetResultReg( byval dtype as integer, byval dclass as integer ) as integer 'static

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	if( dclass = IR.DATACLASS.INTEGER ) then
		emitGetResultReg = EMIT.INTREG.EAX
	else
		emitGetResultReg = 0					'' st(0)
	end if

end function

'':::::
function emitGetFreePreservReg( byval dtype as integer, byval dclass as integer ) as integer 'static

	if( dtype >= IR.DATATYPE.POINTER ) then dtype = IR.DATATYPE.UINT

	emitGetFreePreservReg = INVALID

	'' fp? no other regs can be used
	if( dclass = IR.DATACLASS.FPOINT ) then
		exit function
	end if

	'' try to reuse regs that are preserved between calls
	if( regIsFree( dtype, dclass, EMIT.INTREG.EBX ) ) then
		emitGetFreePreservReg = EMIT.INTREG.EBX

	elseif( regIsFree( dtype, dclass, EMIT.INTREG.ESI ) ) then
		emitGetFreePreservReg = EMIT.INTREG.ESI

	elseif( regIsFree( dtype, dclass, EMIT.INTREG.EDI ) ) then
		emitGetFreePreservReg = EMIT.INTREG.EDI
	end if

end function

'':::::
private sub outEx( s as string, byval updpos as integer ) 'static

	on local error goto outerror

	put #ctx.outf, , s

	if( updpos ) then
		ctx.pos = ctx.pos + 1
	end if

outerror:

end sub

'':::::
private sub outp( s as string ) 'static
    dim p as integer

	p = instr( s, " " )
	if( p > 0 ) then
		mid$( s, p, 1 ) = TABCHAR
	end if

	outEX TABCHAR + s + NEWLINE, TRUE

end sub

'':::::
private function hPrepOperand( oname as string, byval odtype as integer, byval odclass as integer, byval otype as integer ) as string 'static
    dim operand as string

	operand = oname

	select case otype
	case IR.VREGTYPE.VAR, IR.VREGTYPE.IDX, IR.VREGTYPE.PTR, IR.VREGTYPE.TMPVAR
		operand = rtrim$(dtypeTB(odtype).mname) + " [" + operand + "]"
	end select

	hPrepOperand = operand

end function

'':::::
function emitIsKeyword( text as string ) as integer

	if( hashLookup( text, keywordhash(), EMIT_MAXKEYWORDS ) <> INVALID ) then
		emitIsKeyword = TRUE
	else
		emitIsKeyword = FALSE
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function emitGetPos as long static

	emitGetPos = ctx.pos

end function

'':::::
sub emitCOMMENT( s as string ) 'static

	outEX TABCHAR + chr$( 35 ) + s + NEWLINE, FALSE

end sub

'':::::
sub emitASM( s as string ) 'static

	outEX TABCHAR + s + NEWLINE, TRUE

end sub

'':::::
sub emitALIGN( byval bytes as integer ) 'static

	outp ".balign " + str$( bytes )

end sub


'':::::
sub emitCALL( pname as string, byval bytestopop as integer, byval ispublic as integer ) 'static

	outp "call " + pname

    if( bytestopop <> 0 ) then
    	outp "add " + "esp, " + str$( bytestopop )
    end if

end sub

'':::::
sub emitCALLPTR( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, byval bytestopop as integer ) 'static

	dname = hPrepOperand( dname, ddtype, ddclass, dtype )

	outp "call " + dname

    if( bytestopop <> 0 ) then
    	outp "add " + "esp, " + str$( bytestopop )
    end if

end sub

'':::::
sub emitBRANCHPTR( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static

	dname = hPrepOperand( dname, ddtype, ddclass, dtype )

	outp "jmp " + dname

end sub

'':::::
sub emitPUBLIC( label as string ) 'static

	outEx NEWLINE + ".globl " + label + NEWLINE, FALSE

end sub

'':::::
sub emitLABEL( label as string, byval ispublic as integer ) 'static

	outEx label + ":" + NEWLINE, FALSE

end sub

'':::::
sub emitJMP( label as string, byval ispublic as integer ) 'static

	outp "jmp " + label

end sub

'':::::
sub emitJLE( label as string, byval ispublic as integer ) 'static

	outp "jle " + label

end sub

'':::::
sub emitBRANCH( mnemonic as string, label as string, byval ispublic as integer ) 'static

	outp mnemonic + " " + label

end sub

'':::::
sub emitRET( byval bytestopop as integer ) 'static

    outp "ret " + str$( bytestopop )

end sub

'':::::
sub emithPUSH( rname as string ) 'static

	outp "push " + rname

end sub

'':::::
sub emithPOP( rname as string ) 'static

	outp "pop " + rname

end sub

'':::::
sub emithMOV( dname as string, sname as string ) 'static

	outp "mov " + dname + ", " + sname

end sub

'':::::
sub emitFXCHG( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static

	if( ddclass = IR.DATACLASS.FPOINT ) then
		outp "fxch " + dname
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' load & store
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitMOV( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	select case ddclass
	case IR.DATACLASS.INTEGER
		outp "mov " + dst + COMMA + src
	case IR.DATACLASS.FPOINT
	end select

end sub

'':::::
sub emitSTORE( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			   sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim ext as string, reg as integer
    dim ddsize as integer, sdsize as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	ddsize = irGetDataSize( ddtype )
	sdsize = irGetDataSize( sdtype )

	select case ddclass
	'' integer destine
	case IR.DATACLASS.INTEGER
		'' fpoint source
		if( sdclass = IR.DATACLASS.FPOINT ) then

			'' byte destine? damn..
			if( ddsize = 1 ) then

				outp "sub esp, 4"
				outp "fistp dword ptr [esp]"

				if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
					emithPUSH "edx"
				end if

				outp "mov dl, byte ptr [esp]"
				outp "mov " + dst + ", dl"

				if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
					emithPOP "edx"
				end if

				outp  "add esp, 4"

            else
				outp "fistp " + dst
			end if

		'' integer source
		else

			if( ddsize = 1 ) then
				if( stype = IR.VREGTYPE.IMM ) then
					ddsize = 4
				end if
			end if

			if( (ddsize > 1) and _
				((stype = IR.VREGTYPE.IMM) or (ddtype = sdtype) or (irMaxDataType( ddtype, sdtype ) = INVALID)) ) then
				outp "mov " + dst + COMMA + src

			else
				reg = emitLookupReg( src, sdtype )
				ext = emitGetRegName( ddtype, ddclass, reg )
				if( ddtype > sdtype ) then
					if( irIsSigned( sdtype ) ) then
						outp "movsx " + ext + COMMA + src
					else
						outp "movzx " + ext + COMMA + src
					end if
					outp "mov " + dst + COMMA + ext
				else
					'' handle DI/SI as byte
					if( (ddsize = 1) and right$( ext, 1 ) <> "l" ) then
						if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
							emithPUSH "edx"
						end if
						outp "mov dx, " + ext
						outp "mov " + dst + ", dl"
						if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
							emithPOP "edx"
						end if
					else
						outp "mov " + dst + COMMA + ext
					end if
				end if
			end if
		end if

	'' fpoint destine
	case IR.DATACLASS.FPOINT

		'' byte source? damn..
		if( sdsize = 1 ) then

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				emithPUSH "edx"
			end if

			if( irIsSigned( sdtype ) ) then
				outp "movsx edx, " + src
			else
				outp "movzx edx, " + src
			end if

			outp "push edx"
			outp "fild dword ptr [esp]"
			outp "add esp, 4"

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				emithPOP "edx"
			end if

		else
			'' integer source
			if( sdclass <> IR.DATACLASS.FPOINT ) then
				if( (stype = IR.VREGTYPE.REG) or (stype = IR.VREGTYPE.IMM) ) then
					'' not an integer? make it
					if( (stype = IR.VREGTYPE.REG) and (sdsize < FB.INTEGERSIZE) ) then
						src = emitGetRegName( IR.DATATYPE.INTEGER, sdclass, emitLookupReg( src, sdtype ) )
					end if

					outp "push " + src
					outp "fild " + rtrim$(dtypeTB(sdtype).mname) + " [esp]"
					outp "add esp, 4"
				else
					outp "fild "  + src
				end if
			end if
		end if

		outp "fstp " + dst
	end select

end sub

'':::::
sub emitLOAD( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			  sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim ext as string, reg as integer
    dim ddsize as integer, sdsize as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

    sdsize = irGetDataSize( sdtype )
	ddsize = irGetDataSize( ddtype )

	select case ddclass
	'' integer destine
	case IR.DATACLASS.INTEGER
		'' integer source
		if( sdclass = IR.DATACLASS.INTEGER ) then

			if( ddsize = 1 ) then
				if( stype = IR.VREGTYPE.IMM ) then
					ddsize = 4
				end if
			end if

			if( (ddsize > 1) and _
				((ddtype = sdtype) or (irMaxDataType( ddtype, sdtype ) = INVALID)) ) then
				outp "mov " + dst + COMMA + src

			else
				if( ddtype > sdtype ) then
					if( irIsSigned( sdtype ) ) then
						outp "movsx " + dst + COMMA + src
					else
						outp "movzx " + dst + COMMA + src
					end if
				else
					if( stype = IR.VREGTYPE.REG ) then
						reg = emitLookupReg( src, sdtype )
						if( reg <> emitLookupReg( dst, ddtype ) ) then
							ext = emitGetRegName( ddtype, ddclass, reg )
							outp "mov " + dst + COMMA + ext
						end if
					else
						'' handle DI/SI as byte
						if( (ddsize = 1) and right$( dst, 1 ) <> "l" ) then
							if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
								emithPUSH "edx"
							end if

							src = hPrepOperand( sname, ddtype, ddclass, stype )
							outp "mov " + "dl, " + src

							if( irIsSigned( sdtype ) ) then
								outp "movsx " + dst + ", dl"
							else
								outp "movzx " + dst + ", dl"
							end if

							if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
								emithPOP "edx"
							end if
						else
							src = hPrepOperand( sname, ddtype, sdclass, stype )
							outp "mov " + dst + COMMA + src
						end if
					end if
				end if
			end if

		'' fpoint source
		else
			if( stype <> IR.VREGTYPE.REG ) then
				outp "fld " + src
			end if

			'' byte destine? damn..
			if( ddsize = 1 ) then
				if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
					emithPUSH "edx"
				end if

                outp "sub esp, 4"
                outp "fistp dword ptr [esp]"
                outp "pop edx"
                outp "mov " + dst + ", dl"

				if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
					emithPOP "edx"
				end if

            else
				outp "sub esp, 4"
				outp "fistp " + rtrim$(dtypeTB(ddtype).mname) + " [esp]"

				'' not an integer? make it
				if( ddsize < FB.INTEGERSIZE ) then
					dst = emitGetRegName( IR.DATATYPE.INTEGER, ddclass, emitLookupReg( dst, ddtype ) )
				end if

				outp "pop " + dst
			end if
		end if

	'' fpoint destine
	case IR.DATACLASS.FPOINT
		'' byte source? damn..
		if( sdsize = 1 ) then
			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				emithPUSH "edx"
			end if

			if( irIsSigned( sdtype ) ) then
				outp "movsx edx, " + src
			else
				outp "movzx edx, " + src
			end if

			outp "push edx"
			outp "fild dword ptr [esp]"
			outp "add esp, 4"

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				emithPOP "edx"
			end if

        else
			'' fpoint source
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fld " + src

			'' integer source
			else
				if( (stype = IR.VREGTYPE.REG) or (stype = IR.VREGTYPE.IMM) ) then
					'' not an integer? make it
					if( (stype = IR.VREGTYPE.REG) and (sdsize < FB.INTEGERSIZE) ) then
						src = emitGetRegName( IR.DATATYPE.INTEGER, sdclass, emitLookupReg( src, sdtype ) )
					end if

					outp "push " + src
					outp "fild " + rtrim$(dtypeTB(sdtype).mname) + " [esp]"
					outp "add esp, 4"
				else
					outp "fild " + src
				end if
			end if
		end if
	end select

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' binary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitADD( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	select case ddclass
	case IR.DATACLASS.INTEGER
		doinc = FALSE
		dodec = FALSE
		if( stype = IR.VREGTYPE.IMM ) then
			select case val( src )
			case 1
				doinc = TRUE
			case -1
				dodec = TRUE
			end select

		end if
		if( doinc ) then
			outp "inc " + dst
		elseif( dodec ) then
			outp "dec " + dst
		else
			outp "add " + dst + COMMA + src
		end if

	case IR.DATACLASS.FPOINT
		if( stype = IR.VREGTYPE.REG ) then
			outp "faddp"
		else
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fadd " + src
			else
				outp "fiadd " + src
			end if
		end if
	end select

end sub

'':::::
sub emitSUB( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim doinc as integer, dodec as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	select case ddclass
	case IR.DATACLASS.INTEGER
		doinc = FALSE
		dodec = FALSE
		if( stype = IR.VREGTYPE.IMM ) then
			select case val( src )
			case 1
				dodec = TRUE
			case -1
				doinc = TRUE
			end select

		end if
		if( dodec ) then
			outp "dec " + dst
		elseif( doinc ) then
			outp "inc " + dst
		else
			outp "sub " + dst + COMMA + src
		end if

	case IR.DATACLASS.FPOINT
		if( stype = IR.VREGTYPE.REG ) then
			outp "fsubrp"
		else
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fsub " + src
			else
				outp "fisub " + src
			end if
		end if
	end select

end sub

'':::::
sub emithINTMUL( dst as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			     src as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static

    dim eaxfree as integer, edxfree as integer
    dim edxtrashed as integer
    dim eax as string, edx as string

    if( dtypeTB(ddtype).size = 4 ) then
    	eax = "eax"
    	edx = "edx"
    else
    	eax = "ax"
    	edx = "dx"
    end if

	eaxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX )
	edxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX )

	edxtrashed = FALSE
	if( (src = eax) or (stype = IR.VREGTYPE.IMM) ) then
		edxtrashed = TRUE
		if( (dst = edx) or (not edxfree) ) then
			emithPUSH edx
		end if
		outp "mov " + edx + ", " + src
		src = edx
	end if

	if( dst <> eax ) then
		if( (dst = edx) and (edxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg " + eax + ", [esp]"
			else
				emithPOP eax
			end if
		else
			if( not eaxfree ) then
				emithPUSH eax
			end if
			outp "mov " + eax + ", " + dst
		end if
	end if

	outp "mul " + src

	if( dst <> eax ) then
		outp "mov " + dst + ", " + eax
		if( not eaxfree ) then
			emithPOP eax
		end if
	end if

	if( edxtrashed ) then
		if( (not edxfree) and (dst <> edx) ) then
			emithPOP edx
		end if
	end if

end sub

'':::::
function emithFindRegButSrc( src as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) as integer 'static
    dim i as integer, reg as integer

	emithFindRegButSrc = INVALID

	if( stype <> IR.VREGTYPE.REG ) then
		reg = INVALID
	else
		reg = emitLookupReg( src, sdtype )
	end if

	for i = regGetMaxRegs( sdclass )-1 to 0 step -1
		if( i <> reg ) then
			emithFindRegButSrc = i
			if( regIsFree( sdtype, sdclass, i ) ) then
				exit function
			end if
		end if
	next i

end function

'':::::
sub emithINTIMUL( dst as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			      src as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static

    dim reg as integer, isfree as integer, rname as string

	if( dtype <> IR.VREGTYPE.REG ) then

		reg = emithFindRegButSrc( src, sdtype, sdclass, stype )
		rname = emitGetRegName( sdtype, sdclass, reg )

		isfree = regIsFree( sdtype, sdclass, reg )

		if( not isfree ) then emithPUSH rname

		emithMOV rname, dst
		outp "imul " + rname + COMMA + src
		emithMOV dst, rname

		if( not isfree ) then emithPOP rname

	else
		outp "imul " + dst + COMMA + src
	end if

end sub

'':::::
sub emitMUL( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	select case ddclass
	case IR.DATACLASS.INTEGER
		if( irIsSigned( ddtype ) ) then
        	emithINTIMUL dst, ddtype, ddclass, dtype, src, sdtype, sdclass, stype
		else
			emithINTMUL dst, ddtype, ddclass, dtype, src, sdtype, sdclass, stype
		end if

	case IR.DATACLASS.FPOINT
		if( stype = IR.VREGTYPE.REG ) then
			outp "fmulp"
		else
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fmul " + src
			else
				outp "fimul " + src
			end if
		end if
	end select

end sub

'':::::
sub emitDIV( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.FPOINT ) then
		if( stype = IR.VREGTYPE.REG ) then
			outp "fdivrp"
		else
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fdiv " + src
			else
				outp "fidiv " + src
			end if
		end if
	end if

end sub

'':::::
sub emitINTDIV( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			    sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim ecxtrashed as integer
    dim eaxfree as integer, ecxfree as integer, edxfree as integer
    dim eax as string, ecx as string, edx as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass <> IR.DATACLASS.INTEGER ) then
		exit sub
	end if

    if( dtypeTB(ddtype).size = 4 ) then
    	eax = "eax"
    	ecx = "ecx"
    	edx = "edx"
    else
    	eax = "ax"
    	ecx = "cx"
    	edx = "dx"
    end if

	ecxtrashed = FALSE

	eaxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX )
	ecxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.ECX )
	edxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX )

	if( (src = eax) or (src = edx) or (stype = IR.VREGTYPE.IMM) ) then
		ecxtrashed = TRUE
		if( (dst = ecx) or (not ecxfree) ) then
			emithPUSH ecx
		end if
		emithMOV ecx, src
		src = ecx
	end if

	if( dst <> eax ) then
		if( (dst = ecx) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg " + eax + ", [esp]"
			else
				emithPOP eax
			end if
		else
			if( not eaxfree ) then emithPUSH eax
			emithMOV eax, dst
		end if
	end if

	if( (not edxfree) and (dst <> edx) ) then
		emithPUSH edx
	end if

	if( irIsSigned( ddtype ) ) then
		if( dtypeTB(ddtype).size = 4 ) then
			outp "cdq"
		else
			outp "cwd"
		end if
		outp "idiv " + src
	else
		outp "xor " + edx + ", " + edx
		outp "div " + src
	end if

	if( (not edxfree) and (dst <> edx) ) then
		emithPOP edx
	end if

	if( dst <> eax ) then
		emithMOV dst, eax
		if( not eaxfree ) then emithPOP eax
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (dst <> ecx) ) then emithPOP ecx
	end if

end sub

'':::::
sub emitMOD( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim ecxtrashed as integer
    dim eaxfree as integer, ecxfree as integer, edxfree as integer
    dim eax as string, ecx as string, edx as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass <> IR.DATACLASS.INTEGER ) then
		exit sub
	end if

    if( dtypeTB(ddtype).size = 4 ) then
    	eax = "eax"
    	ecx = "ecx"
    	edx = "edx"
    else
    	eax = "ax"
    	ecx = "cx"
    	edx = "dx"
    end if

	ecxtrashed = FALSE

	eaxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX )
	ecxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.ECX )
	edxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX )

	if( (src = eax) or (src = edx) or (stype = IR.VREGTYPE.IMM) ) then
		ecxtrashed = TRUE
		if( (dst = ecx) or (not ecxfree) ) then emithPUSH ecx
		emithMOV ecx, src
		src = ecx
	end if

	if( dst <> eax ) then
		if( (dst = ecx) and (ecxtrashed) ) then
			if( not eaxfree ) then
				outp "xchg " + eax + ", [esp]"
			else
				emithPOP eax
			end if
		else
			if( not eaxfree ) then emithPUSH eax
			emithMOV eax, dst
		end if
	end if

	if( (not edxfree) and (dst <> edx) ) then
		emithPUSH edx
	end if

	if( irIsSigned( ddtype ) ) then
		if( dtypeTB(ddtype).size = 4 ) then
			outp "cdq"
		else
			outp "cwd"
		end if
		outp "idiv " + src
	else
		outp "xor " + edx + ", " + edx
		outp "div " + src
	end if

	if( dst <> edx ) then
		emithMOV dst, edx
		if( not edxfree ) then emithPOP edx
	end if

	if( dst <> eax ) then
		if( not eaxfree ) then emithPOP eax
	end if

	if( ecxtrashed ) then
		if( (not ecxfree) and (dst <> ecx) ) then emithPOP ecx
	end if

end sub

'':::::
sub emitSHIFT( mnemonic as string, dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		       sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim eaxpreserved as integer, ecxpreserved as integer
    dim eaxfree as integer, ecxfree as integer
    dim eax as string, ecx as string, reg as integer
    dim isecxdestine as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )

	if( ddclass <> IR.DATACLASS.INTEGER ) then
		exit sub
	end if

	isecxdestine = FALSE

	eaxpreserved = FALSE
	ecxpreserved = FALSE

	eaxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX )
	ecxfree = regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.ECX )

   	select case dtypeTB(ddtype).size
   	case 4
   		eax = "eax"
   		ecx = "ecx"
   	case 2
   		eax = "ax"
   		ecx = "cx"
   	case 1
   		eax = "al"
   		ecx = "cl"
   	end select


	if( stype = IR.VREGTYPE.IMM ) then
		src = sname
	else

		reg = INVALID
		if( stype = IR.VREGTYPE.REG ) then
			reg = emitLookupReg( sname, sdtype )
		end if

		if( dst = ecx ) then
			isecxdestine = TRUE
		end if

		if( (isecxdestine) or ((reg <> EMIT.INTREG.ECX) and (not ecxfree)) ) then
			if( not isecxdestine ) then ecxpreserved = TRUE
			emithPUSH ecx
		end if

		if( stype <> IR.VREGTYPE.REG ) then
			emithMOV "cl", "byte ptr [" + sname + "]"
		else
			if( reg <> EMIT.INTREG.ECX ) then
				emithMOV "ecx", rnameTB(dtypeTB(IR.DATATYPE.INTEGER).rnametb, reg)
			end if
		end if

		if( isecxdestine ) then
			if( not eaxfree ) then
				eaxpreserved = TRUE
				outp "xchg " + eax + ", [esp]"
			else
				emithPOP eax
			end if

			dst = eax
		end if

		src = "cl"

	end if

	outp mnemonic + " " + dst + COMMA + src

	if( isecxdestine ) then
		emithMOV ecx, eax
	end if

	if( eaxpreserved ) then
		emithPOP eax
	end if

	if( ecxpreserved ) then
		emithPOP ecx
	end if

end sub

'':::::
sub emitSHL( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		     sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim inst as string

	if( irIsSigned( ddtype ) ) then
		inst = "sal"
	else
		inst = "shl"
	end if

	emitSHIFT inst, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype

end sub

'':::::
sub emitSHR( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		     sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim inst as string

	if( irIsSigned( ddtype ) ) then
		inst = "sar"
	else
		inst = "shr"
	end if

	emitSHIFT inst, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype

end sub


'':::::
sub emitAND( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			 sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "and " + dst + COMMA + src
	end if

end sub

'':::::
sub emitOR( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		    sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "or " + dst + COMMA + src
	end if

end sub

'':::::
sub emitXOR( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		     sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "xor " + dst + COMMA + src
	end if

end sub

'':::::
sub emitEQV( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		     sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "xor " + dst + COMMA + src
		outp "not " + dst
	end if

end sub

'':::::
sub emitIMP( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
		     sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "not " + dst
		outp "or " + dst + COMMA + src
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' comps
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emithICMP( rname as string, label as string, mnemonic as string, _
			   dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			   sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim dotest as integer
    dim reg as integer, rname8 as string, edx as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	dotest = FALSE
	if( len( src ) = 0 ) then
		dotest = TRUE
	elseif( (stype = IR.VREGTYPE.IMM) and (dtype = IR.VREGTYPE.REG) ) then
		if( val( src ) = 0 ) then
			dotest = TRUE
		end if
	end if

	if( dotest ) then
		outp "test " + dst + COMMA + dst
	else
		outp "cmp " + dst + COMMA + src
	end if

	''!!!FIXME!!! assuming res = dst !!!FIXME!!!
	if( (env.clopt.cputype >= FB.CPUTYPE.486) and (len( rname ) > 0) and (dtype = IR.VREGTYPE.REG) ) then
		reg = emitLookupReg( rname, ddtype )
		rname8 = emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg )

		'' handle EDI and ESI
		if( right$( rname8, 1 ) <> "l" ) then

   			select case dtypeTB(ddtype).size
   			case 4
   				edx = "edx"
   			case 2
   				edx = "dx"
   			end select

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				outp "xchg " + edx + COMMA + rname
			end if

			outp "set" + mnemonic + TABCHAR + "dl"

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				outp "xchg " + edx + COMMA + rname
			else
				emithMOV rname, edx
			end if
		else
			outp "set" + mnemonic + TABCHAR + rname8
		end if

		outp "shr " + rname + ", 1"
		outp "sbb " + rname + COMMA + rname

	else
		if( len( rname ) > 0 ) then
			outp "mov " + rname + ", -1"
		end if
		emitBRANCH "j" + mnemonic, label, FALSE
		if( len( rname ) > 0 ) then
			outp "xor " + rname + COMMA + rname
			emitLabel label, FALSE
		end if
	end if

end sub

'':::::
sub emithFCMP( rname as string, label as string, mnemonic as string, mask as string, _
		   	   dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			   sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string
    dim reg as integer, rname8 as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, sdtype, sdclass, stype )

	if( stype = IR.VREGTYPE.REG ) then
		outp "fcompp"
	else
		if( len( src ) > 0 ) then
			if( sdclass = IR.DATACLASS.FPOINT ) then
				outp "fcomp " + src
			else
				outp "ficomp " + src
			end if
		else
			outp "ftst"
		end if
	end if

    if( rname <> "eax" ) then
    	if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX ) ) then
    		emithPUSH "eax"
    	end if
	end if

    outp "fnstsw " + "ax"
	if( len( mask ) > 0 ) then
		outp "test ah, " + mask
	else
		outp "sahf"
	end if

    if( rname <> "eax" ) then
       	if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX ) ) then
       		emithPOP "eax"
       	end if
    end if

	if( (env.clopt.cputype >= FB.CPUTYPE.486) and (len( rname ) > 0) ) then
		reg = emitLookupReg( rname, IR.DATATYPE.INTEGER )
		rname8 = emitGetRegName( IR.DATATYPE.BYTE, IR.DATACLASS.INTEGER, reg )

		'' handle EDI and ESI
		if( right$( rname8, 1 ) <> "l" ) then

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				outp "xchg edx" + COMMA + rname
			end if

			outp "set" + mnemonic + TABCHAR + "dl"

			if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EDX ) ) then
				outp "xchg edx" + COMMA + rname
			else
				emithMOV rname, "edx"
			end if
		else
			outp "set" + mnemonic + TABCHAR + rname8
		end if

		outp "shr " + rname + ", 1"
		outp "sbb " + rname + COMMA + rname

	else
 	   if( len( rname ) > 0 ) then
    		outp "mov " + rname + ", -1"
    	end if
    	emitBRANCH "j" + mnemonic, label, FALSE
		if( len( rname ) > 0 ) then
			outp "xor " + rname + COMMA + rname
			emitLabel label, FALSE
		end if
	end if

end sub

'':::::
sub emitGT( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
	dim jmp as string

	if( ddclass = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( ddtype ) ) then
			jmp = "g"
		else
			jmp = "a"
		end if
		emithICMP rname, label, jmp, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "z", "0b01000001", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

'':::::
sub emitLT( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
	dim jmp as string

	if( ddclass = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( ddtype ) ) then
			jmp = "l"
		else
			jmp = "b"
		end if
		emithICMP rname, label, jmp, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "nz", "0b00000001", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

'':::::
sub emitEQ( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static

	if( ddclass = IR.DATACLASS.INTEGER ) then
		emithICMP rname, label, "e", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "nz", "0b01000000", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

'':::::
sub emitNE( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static

	if( ddclass = IR.DATACLASS.INTEGER ) then
		emithICMP rname, label, "ne", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "z", "0b01000000", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

'':::::
sub emitLE( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
	dim jmp as string

	if( ddclass = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( ddtype ) ) then
			jmp = "le"
		else
			jmp = "be"
		end if
		emithICMP rname, label, jmp, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "nz", "0b01000001", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

'':::::
sub emitGE( rname as string, label as string, _
			dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
	dim jmp as string

	if( ddclass = IR.DATACLASS.INTEGER ) then
		if( irIsSigned( ddtype ) ) then
			jmp = "ge"
		else
			jmp = "ae"
		end if
		emithICMP rname, label, jmp, dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	else
		emithFCMP rname, label, "ae", "", dname, ddtype, ddclass, dtype, sname, sdtype, sdclass, stype
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' unary ops
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitNEG( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static
    dim dst as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )

	select case ddclass
	case IR.DATACLASS.INTEGER
		outp "neg " + dst

	case IR.DATACLASS.FPOINT
		outp "fchs"
	end select

end sub

'':::::
sub emitNOT( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static
    dim dst as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "not " + dst
	end if

end sub

'':::::
sub emitABS( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static
    dim dst as string
    dim reg as integer, isfree as integer, rname as string, bits as integer

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )

	select case ddclass
	case IR.DATACLASS.INTEGER

		reg = emithFindRegButSrc( dname, ddtype, ddclass, dtype )
		rname = emitGetRegName( ddtype, ddclass, reg )
		isfree = regIsFree( ddtype, ddclass, reg )
		if( not isfree ) then emithPUSH rname

		bits = (dtypeTB(ddtype).size * 8)-1

		outp "mov " + rname + COMMA + dst
		outp "sar " + rname + COMMA + str$( bits )
		outp "xor " + dst + COMMA + rname
		outp "sub " + dst + COMMA + rname

		if( not isfree ) then emithPOP rname

	case IR.DATACLASS.FPOINT
		outp "fabs"
	end select

end sub

'':::::
sub emitSGN( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer ) 'static
    dim dst as string
    dim label as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )

	if( ddclass = IR.DATACLASS.INTEGER ) then

		label = hMakeTmpStr

		outp "cmp " + dst + ", 0"
		emitBRANCH "je", label, FALSE
		outp "mov " + dst + ", 1"
		emitBRANCH "jg", label, FALSE
		outp "mov " + dst + ", -1"
		emitLABEL label, FALSE

	end if

	'' hack! floating-point SGN is done by a rtlib function, called by AST

end sub


'':::::
sub emitPUSH( sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim src as string, sdsize as integer
    dim reg as integer

	src = hPrepOperand( sname, sdtype, sdclass, stype )

	sdsize = irGetDataSize( sdtype )

	select case sdclass
	case IR.DATACLASS.INTEGER
		if( sdsize > 1 ) then
			if( stype = IR.VREGTYPE.REG ) then
				if( sdsize < FB.INTEGERSIZE ) then
					reg = emitLookupReg( src, sdtype )
					src = emitGetRegName( IR.DATATYPE.INTEGER, sdclass, reg )
				end if
			else
				if( sdsize < FB.INTEGERSIZE ) then
					src = hPrepOperand( sname, IR.DATATYPE.INTEGER, sdclass, stype )
				end if
			end if

			outp "push " + src

		else
			if( stype = IR.VREGTYPE.REG ) then
				reg = emitLookupReg( src, sdtype )
				src = emitGetRegName( IR.DATATYPE.INTEGER, sdclass, reg )
			else
				src = hPrepOperand( sname, IR.DATATYPE.INTEGER, sdclass, stype )
			end if
			outp "push " + src
		end if

	case IR.DATACLASS.FPOINT
		if( stype <> IR.VREGTYPE.REG ) then
			if( sdtype = IR.DATATYPE.SINGLE ) then
				outp "push " + src
			else
				outp "push " + "dword ptr [" + sname + "+4]"
				outp "push " + "dword ptr [" + sname + "+0]"
			end if
		else
			outp "sub " + "esp," + str$( irGetDataSize( sdtype ) )
			outp "fstp " + rtrim$(dtypeTB(sdtype).mname) + " [esp]"
		end if
	end select

end sub

'':::::
sub emitPOP( sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim src as string
    dim reg as integer

	src = hPrepOperand( sname, sdtype, sdclass, stype )

	select case sdclass
	case IR.DATACLASS.INTEGER
		if( irGetDataSize( sdtype ) > 1  ) then
			outp "pop " + src

		else
			if( stype = IR.VREGTYPE.REG ) then
				reg = emitLookupReg( src, sdtype )
				src = emitGetRegName( IR.DATATYPE.INTEGER, sdclass, reg )
				outp "pop " + src
			else

				outp "xchg eax, [esp]"
				emithMOV src, "al"
				if( not regIsFree( IR.DATATYPE.INTEGER, IR.DATACLASS.INTEGER, EMIT.INTREG.EAX ) ) then
					emithPOP "eax"
				else
					outp "add esp, 4"
				end if
			end if

		end if

	case IR.DATACLASS.FPOINT
		if( stype <> IR.VREGTYPE.REG ) then
			if( sdtype = IR.DATATYPE.SINGLE ) then
				outp "pop " + src
			else
				outp "pop " + "dword ptr [" + sname + "+0]"
				outp "pop " + "dword ptr [" + sname + "+4]"
			end if
		else
			outp "fstp " + rtrim$(dtypeTB(sdtype).mname) + " [esp]"
			outp "add esp," + str$( irGetDataSize( sdtype ) )
		end if
	end select

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' addressing
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitADDROF( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			    sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static

	if( ddclass = IR.DATACLASS.INTEGER ) then
		if( dtype = IR.VREGTYPE.REG ) then
			outp "lea " + dname + ", [" + sname + "]"
		end if
	end if

end sub

'':::::
sub emitDEREF( dname as string, byval ddtype as integer, byval ddclass as integer, byval dtype as integer, _
			   sname as string, byval sdtype as integer, byval sdclass as integer, byval stype as integer ) 'static
    dim dst as string, src as string

	dst = hPrepOperand( dname, ddtype, ddclass, dtype )
	src = hPrepOperand( sname, ddtype, ddclass, stype )

	if( ddclass = IR.DATACLASS.INTEGER ) then
		outp "mov " + dst + COMMA + src
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' procs
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitPROCBEGIN( byval proc as integer, byval initlabel as integer, byval ispublic as integer ) 'static
	dim lname as string
	dim id as string

	id = symbGetProcName( proc )
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
    outp space$( 128 )

    lname = symbGetLabelName( initlabel )
    emitLABEL lname, FALSE

    ''
    ctx.localptr = 0
    ctx.argptr	 = FB.POINTERSIZE + 4			'' skip return address + pushed ebp

end sub

'':::::
sub emitPROCEND( byval proc as integer, byval bytestopop as integer, byval initlabel as integer, byval exitlabel as integer ) 'static
    dim currpos as long
    dim bytestoalloc as integer
    dim i as integer
	dim id as string

	id = symbGetProcName( proc )

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

		seek #ctx.outf, currpos
	end if

end sub

'':::::
function emitAllocLocal( byval lgt as integer ) as string 'static

    ctx.localptr = ctx.localptr - lgt

	emitAllocLocal = "ebp -" + str$( abs( ctx.localptr ) )

end function

'':::::
sub emitFreeLocal( byval lgt as integer ) 'static

    ctx.localptr = ctx.localptr + lgt

end sub

'':::::
function emitAllocArg( byval lgt as integer ) as string 'static

	emitAllocArg = "ebp +" + str$( ctx.argptr )

    ctx.argptr = ctx.argptr + ((lgt + 3) and not 3)

end function

'':::::
sub emitFreeArg( byval lgt as integer ) 'static

    ctx.argptr = ctx.argptr - ((lgt + 3) and not 3)

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' data
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub emitSECTION( byval section as integer ) 'static
    dim sname as string

	select case section
	case EMIT.SECTYPE.CONST
#ifdef TARGET_LINUX
		sname = "data"
#else
		sname = "const"
#endif
	case EMIT.SECTYPE.DATA
		sname = "data"
	case EMIT.SECTYPE.BSS
		sname = "bss"
	case EMIT.SECTYPE.CODE
		sname = "text"
	end select

	outEx ".section ." + sname + NEWLINE, TRUE

end sub

'':::::
sub emitDATABEGIN( lname as string ) 'static
    dim currpos as long

	if( ctx.dataend <> 0 ) then
		currpos = seek( ctx.outf )

		seek #ctx.outf, ctx.dataend
		outp ".int " + lname
		seek #ctx.outf, currpos

    end if

end sub

'':::::
sub emitDATAEND 'static

    '' link + NULL
    outp ".short 0xffff"
    ctx.dataend = seek( ctx.outf )
    outp ".int 0" + space$( FB.MAXNAMELEN )

end sub

'':::::
sub emitDATA ( litext as string, byval typ as integer )
    dim esctext as string

    esctext = hScapeStr( litext )

	'' len + asciiz
	if( typ <> INVALID ) then
		outp ".short 0x" + hex$( len( litext ) )
		outp ".asciz " + chr$( CHAR_QUOTE ) + esctext + chr$( CHAR_QUOTE )
	else
		outp ".short 0x0000"
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' high-level
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub hSaveAsmHeader( byval asmf as integer )
    dim res as long
    dim entry as string, lname as string
    dim maininitlabel as integer

	edbgHeader asmf, env.infile

	hWriteStr asmf, TRUE,  ".intel_syntax noprefix"
	hWriteStr asmf, TRUE,  ".arch i386"

    hWriteStr asmf, FALSE, ""
    hWriteStr asmf, TRUE, "#'" + env.infile + "' compilation started at " + time$ + " (" + FB.SIGN + ")"

    entry = env.infile
    entry = hStripPath( hStripExt( entry ) )
    hClearName entry

    hWriteStr asmf, FALSE, NEWLINE + "#entry point"
    hWriteStr asmf, FALSE, ".section .text"
    hWriteStr asmf, TRUE,  ".balign 16" + NEWLINE
    hWriteStr asmf, FALSE, ".globl " + "fb_" + entry + "_entry"
    hWriteStr asmf, FALSE, ".globl " + "fb_" + ucase$( entry ) + "_entry"
    hWriteStr asmf, FALSE, "fb_" + entry  + "_entry" + ":"
    hWriteStr asmf, FALSE, "fb_" + ucase$( entry )  + "_entry" + ":"
#ifdef TARGET_LINUX
	if( env.clopt.outtype = FB_OUTTYPE_EXECUTABLE ) then
		' Add small stub to get commandline under linux
		hWriteStr asmf, TRUE, "pop" + TABCHAR + "ecx"
		hWriteStr asmf, TRUE, "lea" + TABCHAR + "edi, [fb_commandline]"
		hWriteStr asmf, TRUE, "mov" + TABCHAR + "edx, 1023"
		hWriteStr asmf, TRUE, "cld"
		hWriteStr asmf, FALSE, "fb_get_argv:"
		hWriteStr asmf, TRUE, "pop" + TABCHAR + "esi"
		hWriteStr asmf, FALSE, "fb_copy_arg:"
		hWriteStr asmf, TRUE, "mov" + TABCHAR + "al, [esi]"
		hWriteStr asmf, TRUE, "test" + TABCHAR + "al, al"
		hWriteStr asmf, TRUE, "jz" + TABCHAR + "fb_end_copy_arg"
		hWriteStr asmf, TRUE, "movsb"
		hWriteStr asmf, TRUE, "dec" + TABCHAR + "edx"
		hWriteStr asmf, TRUE, "jz" + TABCHAR + "fb_end_get_argv"
		hWriteStr asmf, TRUE, "jmp" + TABCHAR + "fb_copy_arg"
		hWriteStr asmf, FALSE, "fb_end_copy_arg:"
		hWriteStr asmf, TRUE, "mov" + TABCHAR + "al, 32"
		hWriteStr asmf, TRUE, "stosb"
		hWriteStr asmf, TRUE, "dec" + TABCHAR + "ecx"
		hWriteStr asmf, TRUE, "jnz" + TABCHAR + "fb_get_argv"
		hWriteStr asmf, TRUE, "mov" + TABCHAR + "byte ptr [edi-1], 0"
		hWriteStr asmf, FALSE, "fb_end_get_argv:"
	end if
#endif
    hWriteStr asmf, TRUE,  "call" + TABCHAR + "fb_moduleinit"
    hWriteStr asmf, TRUE,  "call" + TABCHAR + EMIT_MAINPROC
    hWriteStr asmf, TRUE,  "ret"

    ''
    maininitlabel = symbAddLabel( hMakeTmpStr )

    edbgMain maininitlabel

    hWriteStr asmf, FALSE, NEWLINE + "#user code"
    hWriteStr asmf, FALSE, EMIT_MAINPROC + ":"
    hWriteStr asmf, TRUE,  "push" + TABCHAR + "ebp"
    hWriteStr asmf, TRUE,  "mov" + TABCHAR + "ebp, esp"
    hWriteStr asmf, FALSE, ""

    lname = symbGetLabelName( maininitlabel )
    emitLABEL lname, FALSE

end sub

'':::::
private sub hSaveAsmInitProc( byval asmf as integer )
    dim s as integer

    hWriteStr asmf, FALSE, NEWLINE + "#initialization"
    hWriteStr asmf, FALSE, "fb_moduleinit:"

    hWriteStr asmf, TRUE,  "finit"
    hWriteStr asmf, TRUE,  "call" + TABCHAR + hCreateAliasName( "fb_Init", 0, FALSE, FB.FUNCMODE.STDCALL )

    '' set default data label (def label isn't global as it could clash with other
    '' modules, so DataRestore alone can't figure out where to start)
    s = symbLookupLabel( FB.DATALABELNAME )
    if( s <> INVALID ) then
    	hWriteStr asmf, TRUE,  "push" + TABCHAR + "offset " + symbGetLabelName( s )
    	hWriteStr asmf, TRUE,  "call" + TABCHAR + hCreateAliasName( "fb_DataRestore", 4, FALSE, FB.FUNCMODE.STDCALL )
    	if( env.clopt.nostdcall = TRUE) then
			hWriteStr asmf, TRUE,  "add" + TABCHAR + "esp, 4"
		end if
    end if

    hWriteStr asmf, TRUE,  "ret"

end sub

'':::::
private sub hSaveAsmFooter( byval asmf as integer )

    hWriteStr asmf, FALSE, ""
    hWriteStr asmf, TRUE,  "push" + TABCHAR + "0"
    hWriteStr asmf, TRUE,  "call" + TABCHAR + hCreateAliasName( "fb_End", 4, FALSE, FB.FUNCMODE.STDCALL )
    hWriteStr asmf, TRUE,  "mov" + TABCHAR + "esp, ebp"
    hWriteStr asmf, TRUE,  "pop" + TABCHAR + "ebp"
    hWriteStr asmf, TRUE,  "ret"

    hSaveAsmInitProc asmf

    hWriteStr asmf, FALSE, NEWLINE + TABCHAR + "#'" + env.infile + "' compilation finished at " + time$ + " (" + FB.SIGN + ")"
end sub


'':::::
private function hGetTypeString( byval typ as integer ) as string 'static
	dim tstr as string

	select case typ
    case FB.SYMBTYPE.UBYTE, FB.SYMBTYPE.BYTE
    	tstr = ".byte"
    case FB.SYMBTYPE.USHORT, FB.SYMBTYPE.SHORT
    	tstr = ".short"
    case FB.SYMBTYPE.INTEGER, FB.SYMBTYPE.LONG, FB.SYMBTYPE.UINT
    	tstr = ".long"
    case FB.SYMBTYPE.SINGLE
		tstr = ".float"
	case FB.SYMBTYPE.DOUBLE
    	tstr = ".double"
	case FB.SYMBTYPE.FIXSTR
    	tstr = ".asciz"
    case FB.SYMBTYPE.STRING
    	tstr = ".long"
	case FB.SYMBTYPE.USERDEF
		tstr = "INVALID"
    case FB.SYMBTYPE.POINTER to FB.SYMBTYPE.POINTER + FB.SYMBOLTYPES
    	tstr = ".long"
	end select

	hGetTypeString = tstr

end function

'':::::
private sub hSaveAsmBss( byval asmf as integer ) 'static
    dim i as integer
    dim lgt as long, sname as string
    dim elements as long, alloc as string

    hWriteStr asmf, FALSE, NEWLINE + "#global non-initialized vars"
    hWriteStr asmf, FALSE, ".section .bss"
    hWriteStr asmf, TRUE,  ".balign 16" + NEWLINE

    i = symbGetFirstNode
    do while( i <> INVALID )

    	if( (symbGetClass( i ) = FB.SYMBCLASS.VAR) and _
    		(not symbGetInitialized( i )) and _
    		(not symbGetVarIsDynamic( i )) ) then

    	    lgt = symbGetLen( i )

    	    '' don't add initialized string or array descriptors
    	    if( lgt > 0 ) then
    	    	elements = 1
    	    	if( symbGetVarDimensions( i ) > 0 ) then
    	    		elements = hCalcElements( i )
    	    	end if

    	    	sname = symbGetVarName( i )

    	    	if( (symbGetAlloctype( i ) and FB.ALLOCTYPE.COMMON) = 0 ) then
    	    		alloc = ".lcomm"
    	    	else
    	    		emitPUBLIC sname
    	    		alloc = ".comm"
    	    	end if

    	    	hWriteStr asmf, TRUE, ".balign 4"
    	    	hWriteStr asmf, TRUE,  alloc + TABCHAR + sname + "," + str$( lgt * elements )
    	    end if
    	end if

    	i = symbGetNextNode( i )
    loop

end sub

'':::::
private sub hSaveAsmConst( byval asmf as integer ) 'static
    dim i as integer, typ as integer
    dim sname as string, stext as string, stype as string

    hWriteStr asmf, FALSE, NEWLINE + "#global initialized constants"
#ifdef TARGET_LINUX
	hWriteStr asmf, FALSE, ".section .data"
#else
    hWriteStr asmf, FALSE, ".section .const"
#endif
    hWriteStr asmf, TRUE,  ".balign 16" + NEWLINE

    i = symbGetFirstNode
    do while( i <> INVALID )

    	if( (symbGetClass( i ) = FB.SYMBCLASS.VAR) and (symbGetInitialized( i )) ) then

    	    '' don't add initialized string or array descriptors
    	    typ = symbGetType( i )
    	    if( typ <> FB.SYMBTYPE.USERDEF ) then
    	    	if( (symbGetLen( i ) > 0) or (symbGetType( i ) = FB.SYMBTYPE.FIXSTR) ) then
    	    		sname = symbGetVarName( i )
    	    		stype = hGetTypeString( typ )
    	    		stext = symbGetVarText( i )
    	    		if( symbGetType( i ) = FB.SYMBTYPE.FIXSTR ) then
    	    			stext = chr$( CHAR_QUOTE ) + hScapeStr( stext ) + chr$( CHAR_QUOTE )
    	    		end if

    	    		hWriteStr asmf, TRUE, ".balign 4"
    	    		hWriteStr asmf, FALSE, sname + ":" + TABCHAR + stype + TABCHAR + stext
    	    	end if
    	    end if
    	end if

    	i = symbGetNextNode( i )
    loop

end sub

'':::::
private sub hWriteArrayDesc( byval asmf as integer, byval s as integer ) 'static
	dim d as integer
    dim l as long, u as long
    dim dims as integer, diff as long
    dim sname as string, dname as string

    dims = symbGetVarDimensions( s )
    diff = symbGetVarDiff( s )
    if( dims = 0 ) then
    	exit sub
    end if

    if( symbGetVarIsDynamic( s ) ) then
    	sname = "0"
	else
    	sname = symbGetVarName( s )
	end if
	dname = symbGetVarDscName( s )

    '' common?
    if( (symbGetAlloctype( s ) and FB.ALLOCTYPE.COMMON) > 0 ) then
    	if( dims = -1 ) then dims = 1
    	hWriteStr asmf, TRUE, ".balign 4"
    	hWriteStr asmf, TRUE,  ".comm" + TABCHAR + dname + "," + _
    					str$( FB.ARRAYDESCSIZE + dims * FB.INTEGERSIZE*2 )
    	exit sub
    end if


    hWriteStr asmf, TRUE, ".balign 4"
    hWriteStr asmf, FALSE, dname + ":"

	''	void		*data 	// ptr + diff
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + sname + " +" + str$( diff )
	''	void		*ptr
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + sname
	''	uint		size
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( symbGetLen( s ) * hCalcElements( s ) )
	''	uint		element_len
    hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( symbGetLen( s ) )
	''	uint		dimensions
	if( dims = -1 ) then dims = 1
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( dims )

    if( not symbGetVarIsDynamic( s ) ) then
    	d = symbGetFirstVarDim( s )
    	do while( d <> INVALID )
    		symbGetVarDims s, d, l, u

			''	uint	dim_elemts
			hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( u - l + 1 )
			''	int		dim_first
			hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( l )

			d = symbGetNextVarDim( s, d )
    	loop

    else
        for d = 0 to dims-1
			''	uint	dim_elemts
			hWriteStr asmf, TRUE,  ".int" + TABCHAR + "0"
			''	int		dim_first
			hWriteStr asmf, TRUE,  ".int" + TABCHAR + "0"
        next d
    end if

end sub

'':::::
private sub hWriteStringDesc( byval asmf as integer, byval s as integer ) 'static
    dim sname as string, dname as string

    sname = symbGetVarName( s )
	dname = symbGetVarDscName( s )

    hWriteStr asmf, TRUE, ".balign 4"
    hWriteStr asmf, FALSE, dname + ":"

	''	void		*data
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + sname
	''	int			len
	hWriteStr asmf, TRUE,  ".int" + TABCHAR + str$( symbGetLen( s ) )

end sub

'':::::
private sub hSaveAsmData( byval asmf as integer ) 'static
    dim i as integer, d as integer

    hWriteStr asmf, FALSE, NEWLINE + "#global initialized vars"
    hWriteStr asmf, FALSE, ".section .data" + NEWLINE
    hWriteStr asmf, TRUE,  ".balign 16" + NEWLINE

    i = symbGetFirstNode
    do while( i <> INVALID )

    	if( symbGetClass( i ) = FB.SYMBCLASS.VAR ) then
    	    d = symbGetVarDesc( i )
    	    if( d <> INVALID ) then
    	    	select case symbGetSubtype( d )
    	    	case FB.DESCTYPE.ARRAY
    	    		hWriteArrayDesc asmf, i
    	    	case FB.DESCTYPE.STR
    	    		hWriteStringDesc asmf, i
    	    	end select
    	    end if
    	end if

    	i = symbGetNextNode( i )
    loop

end sub

'':::::
function emitOpen

	if( hFileExists( env.outfile ) ) then
		kill env.outfile
	end if

	on local error goto eoerror

	ctx.outf = freefile
	open env.outfile for binary as #ctx.outf

	'' header
	hSaveAsmHeader ctx.outf


	emitOpen = TRUE

eoerror:
	exit function
end function

'':::::
sub emitClose

    '' footer
    hSaveAsmFooter ctx.outf

	'' const
	hSaveAsmConst ctx.outf

	'' BSS
	hSaveAsmBss ctx.outf

	'' data
	hSaveAsmData ctx.outf

	''
	edbgFooter

	''
	close #ctx.outf

end sub

'':::::
sub emitDbgLine( byval lnum as integer, lname as string )

	edbgLine lnum, lname

end sub

'':::::
sub hWriteStr( byval f as integer, byval addtab as integer, s as string ) 'static
    dim t as string

	if( addtab ) then
		t = TABCHAR + s + NEWLINE
	else
		t = s + NEWLINE
	end if

	on local error goto writeerror

	put #f, , t

writeerror:

end sub


