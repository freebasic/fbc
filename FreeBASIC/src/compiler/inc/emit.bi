#ifndef EMIT_BI__
#define EMIT_BI__

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


'$include once: 'inc\reg.bi'
'$include once: 'inc\ir.bi'


const EMIT_MAINPROC			= "fb_modulemain"
const EMIT_LOCALPREFIX		= "L"

const EMIT.VAR.OPENCHAR		= 91				'' [
const EMIT.VAR.CLOSECHAR	= 93				'' ]

const EMIT.REGCLASSES		= 2					'' assuming IR.DATACLASS. will start at 0!

enum EMITINTREG
	EMIT.INTREG.EDX
	EMIT.INTREG.EDI
	EMIT.INTREG.ESI
	EMIT.INTREG.ECX
	EMIT.INTREG.EBX
	EMIT.INTREG.EAX
end enum

'' section types
enum EMITSECTYPE
	EMIT.SECTYPE.CONST
	EMIT.SECTYPE.DATA
	EMIT.SECTYPE.BSS
	EMIT.SECTYPE.CODE
end enum


''
''
''
declare sub 		emitInit			( )
declare sub 		emitEnd				( )

declare function 	emitGetRegClass		( byval dclass as integer ) as REGCLASS ptr

declare function 	emitOpen			( ) as integer
declare sub 		emitClose			( byval tottime as double )

declare function 	emitIsKeyword		( text as string ) as integer
declare sub 		emitASM				( s as string )

declare sub 		emitCOMMENT			( s as string )
declare sub 		emitTYPE			( byval typ as integer, text as string )

declare sub 		emitALIGN			( byval bytes as integer )
declare sub 		emitSECTION			( byval section as integer )

declare sub 		emitDATABEGIN		( lname as string )
declare sub 		emitDATA			( litext as string, byval litlen as integer, byval dtype as integer )
declare sub 		emitDATAEND			( )

declare sub 		emitGetRegName		( byval dtype as integer, byval dclass as integer, _
										  byval reg as integer, rname as string )
declare sub 		emitGetIDXName		( byval mult as integer, sname as string, idxname as string )

declare function 	emitIsRegPreserved 	( byval dtype as integer, byval dclass as integer, byval reg as integer ) as integer
declare function 	emitGetResultReg 	( byval dtype as integer, byval dclass as integer ) as integer
declare function 	emitGetFreePreservedReg( byval dtype as integer, byval dclass as integer ) as integer

declare function 	emitSave			( filename as string ) as integer

declare sub 		emitPROCBEGIN		( byval proc as FBSYMBOL ptr, byval initlabel as FBSYMBOL ptr, byval ispublic as integer )
declare sub 		emitPROCEND			( byval proc as FBSYMBOL ptr, byval bytestopop as integer, byval initlabel as FBSYMBOL ptr, byval exitlabel as FBSYMBOL ptr )
declare function 	emitAllocLocal		( byval lgt as integer, ofs as integer ) as string
declare sub 		emitFreeLocal		( byval lgt as integer )
declare function 	emitAllocArg		( byval lgt as integer, ofs as integer ) as string
declare sub 		emitFreeArg			( byval lgt as integer )

declare sub 		emitCALL			( pname as string, byval bytestopop as integer )
declare sub 		emitCALLPTR			( dname as string, byval svreg as IRVREG ptr, byval bytestopop as integer )
declare sub 		emitBRANCHPTR		( dname as string, byval svreg as IRVREG ptr )
declare sub 		emitLABEL			( label as string )
declare sub 		emitJMP				( label as string )
declare sub 		emitRET				( byval bytestopop as integer )
declare sub 		emitPUBLIC			( label as string )

declare sub 		emitBRANCH			( mnemonic as string, label as string )

declare sub 		emitFXCHG			( dname as string, byval svreg as IRVREG ptr )

declare sub 		emitMOV				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitSTORE			( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitLOAD			( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitADD				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitSUB				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitMUL				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitDIV				( dname as string, byval dvreg as IRVREG ptr, _
		     							  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitINTDIV			( dname as string, byval dvreg as IRVREG ptr, _
		     							  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitMOD				( dname as string, byval dvreg as IRVREG ptr, _
		     							  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitSHL				( dname as string, byval dvreg as IRVREG ptr, _
			 					  	 	  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitSHR				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitAND				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitOR				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitXOR				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitEQV				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitIMP				( dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitADDROF			( dname as string, byval dvreg as IRVREG ptr, _
			    						  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitDEREF			( dname as string, byval dvreg as IRVREG ptr, _
			    						  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitGT				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitLT				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitEQ				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitNE				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitLE				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )
declare sub 		emitGE				( rname as string, byval rvreg as IRVREG ptr, label as string, _
								  		  dname as string, byval dvreg as IRVREG ptr, _
			 					  		  sname as string, byval svreg as IRVREG ptr )

declare sub 		emitNEG				( dname as string, byval dvreg as IRVREG ptr )
declare sub 		emitNOT				( dname as string, byval dvreg as IRVREG ptr )
declare sub 		emitABS				( dname as string, byval dvreg as IRVREG ptr )
declare sub 		emitSGN				( dname as string, byval dvreg as IRVREG ptr )

declare sub 		emitPUSH			( sname as string, byval svreg as IRVREG ptr )
declare sub 		emitPUSHUDT			( sname as string, byval svreg as IRVREG ptr, byval sdsize as integer )
declare sub 		emitPOP				( sname as string, byval svreg as IRVREG ptr )


declare	sub 		emitDbgLine			( byval lnum as integer, lname as string )

declare	function 	emitGetPos 			( ) as integer


declare sub 		hWriteStr			( byval f as integer, byval addtab as integer, s as string )

#endif '' EMIT_BI__
