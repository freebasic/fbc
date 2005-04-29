#ifndef __EMIT_BI__
#define __EMIT_BI__

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
	EMIT.SECTYPE.DIRECTIVE
end enum


''
''
''
declare sub 		emitInit			( )

declare sub 		emitEnd				( )

declare function 	emitGetRegClass		( byval dclass as integer ) as REGCLASS ptr

declare function 	emitOpen			( ) as integer

declare sub 		emitClose			( byval tottime as double )

declare function 	emitIsKeyword		( byval text as string ) as integer

declare sub 		emitASM				( byval s as string )

declare sub 		emitCOMMENT			( byval s as string )

declare sub 		emitTYPE			( byval typ as integer, _
										  byval text as string )

declare sub 		emitALIGN			( byval bytes as integer )

declare sub 		emitSTACKALIGN		( byval bytes as integer )

declare sub 		emitSECTION			( byval section as integer )

declare sub 		emitDATABEGIN		( byval lname as string )

declare sub 		emitDATA			( byval litext as string, _
										  byval litlen as integer, _
										  byval dtype as integer )

declare sub 		emitDATAOFS			( byval sname as string )

declare sub 		emitDATAEND			( )

declare sub 		emitVARINIBEGIN		( byval sym as FBSYMBOL ptr )

declare sub 		emitVARINIEND		( byval sym as FBSYMBOL ptr )

declare sub 		emitVARINIi			( byval dtype as integer, _
										  byval value as integer )

declare sub 		emitVARINIf			( byval dtype as integer, _
										  byval value as double )

declare sub 		emitVARINI64		( byval dtype as integer, _
										  byval value as longint )

declare sub 		emitVARINIOFS		( byval sname as string )

declare sub 		emitVARINISTR		( byval lgt as integer, _
				   						  byval s as string )

declare sub 		emitVARINIPAD		( byval bytes as integer )

declare sub 		emitGetRegName		( byval dtype as integer, _
										  byval dclass as integer, _
										  byval reg as integer, _
										  rname as string )

declare sub 		emitGetIDXName		( byval mult as integer, _
										  sname as string, _
										  idxname as string )

declare function 	emitGetVarName		( byval s as FBSYMBOL ptr ) as string

declare function 	emitIsRegPreserved 	( byval dtype as integer, _
										  byval dclass as integer, _
										  byval reg as integer ) as integer

declare sub			emitGetResultReg 	( byval dtype as integer, _
										  byval dclass as integer, _
										  r1 as integer, _
										  r2 as integer )

declare function 	emitGetFreePreservedReg( byval dtype as integer, _
											 byval dclass as integer ) as integer

declare function 	emitSave			( byval filename as string ) as integer

declare sub 		emitPROCBEGIN		( byval proc as FBSYMBOL ptr, _
										  byval initlabel as FBSYMBOL ptr, _
										  byval ispublic as integer )

declare sub 		emitPROCEND			( byval proc as FBSYMBOL ptr, _
										  byval bytestopop as integer, _
										  byval initlabel as FBSYMBOL ptr, _
										  byval exitlabel as FBSYMBOL ptr )

declare function 	emitAllocLocal		( byval lgt as integer, _
										  ofs as integer ) as zstring ptr

declare sub 		emitFreeLocal		( byval lgt as integer )

declare function 	emitAllocArg		( byval lgt as integer, _
										  ofs as integer ) as zstring ptr

declare sub 		emitFreeArg			( byval lgt as integer )

declare sub 		emitCALL			( byval pname as string, _
										  byval bytestopop as integer )

declare sub 		emitCALLPTR			( byval dname as string, _
										  byval svreg as IRVREG ptr, _
										  byval bytestopop as integer )

declare sub 		emitBRANCHPTR		( byval dname as string, _
										  byval svreg as IRVREG ptr )
declare sub 		emitLABEL			( byval label as string )

declare sub 		emitJMP				( byval label as string )

declare sub 		emitRET				( byval bytestopop as integer )

declare sub 		emitPUBLIC			( byval label as string )

declare sub 		emitBRANCH			( byval op as integer, _
										  byval label as string )

declare sub 		emitFXCHG			( byval dname as string, _
										  byval svreg as IRVREG ptr )

declare sub 		emitMOV				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitSTORE			( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLOAD			( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitADD				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitSUB				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitMUL				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitDIV				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
		     							  byval sname as string, _
		     							  byval svreg as IRVREG ptr )

declare sub 		emitINTDIV			( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
		     							  byval sname as string, _
		     							  byval svreg as IRVREG ptr )

declare sub 		emitMOD				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
		     							  byval sname as string, _
		     							  byval svreg as IRVREG ptr )


declare sub 		emitSHL				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  	 	  byval sname as string, _
			 					  	 	  byval svreg as IRVREG ptr )

declare sub 		emitSHR				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitAND				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitOR				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitXOR				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitEQV				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitIMP				( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitADDROF			( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			    						  byval sname as string, _
			    						  byval svreg as IRVREG ptr )

declare sub 		emitDEREF			( byval dname as string, _
										  byval dvreg as IRVREG ptr, _
			    						  byval sname as string, _
			    						  byval svreg as IRVREG ptr )

declare sub 		emitGT				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLT				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitEQ				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitNE				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitLE				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitGE				( byval rname as string, _
										  byval rvreg as IRVREG ptr, _
										  byval label as string, _
								  		  byval dname as string, _
								  		  byval dvreg as IRVREG ptr, _
			 					  		  byval sname as string, _
			 					  		  byval svreg as IRVREG ptr )

declare sub 		emitATAN2			( byval dname as string, _
			   							  byval dvreg as IRVREG ptr, _
			   							  byval sname as string, _
			   							  byval svreg as IRVREG ptr )

declare sub 		emitPOW				( byval dname as string, _
			   							  byval dvreg as IRVREG ptr, _
			   							  byval sname as string, _
			   							  byval svreg as IRVREG ptr )

declare sub 		emitNEG				( byval dname as string, _
										  byval dvreg as IRVREG ptr )

declare sub 		emitNOT				( byval dname as string, _
										  byval dvreg as IRVREG ptr )

declare sub 		emitABS				( byval dname as string, _
										  byval dvreg as IRVREG ptr )

declare sub 		emitSGN				( byval dname as string, _
										  byval dvreg as IRVREG ptr )

declare sub 		emitSIN				( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitASIN			( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitCOS				( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitACOS			( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitTAN				( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitATAN			( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitSQRT			( byval dname as string, _
			  							  byval dvreg as IRVREG ptr )

declare sub 		emitLOG				( byval dname as string, _
			 							  byval dvreg as IRVREG ptr )

declare sub 		emitFLOOR			( byval dname as string, _
			   							  byval dvreg as IRVREG ptr )

declare sub 		emitPUSH			( byval sname as string, _
										  byval svreg as IRVREG ptr )

declare sub 		emitPUSHUDT			( byval sname as string, _
										  byval svreg as IRVREG ptr, _
										  byval sdsize as integer )

declare sub 		emitPOP				( byval sname as string, _
										  byval svreg as IRVREG ptr )

declare	sub 		emitDbgLine			( byval lnum as integer, _
										  byval lname as string )

declare	function 	emitGetPos 			( ) as integer


declare sub 		hWriteStr			( byval f as integer, _
										  byval addtab as integer, _
										  byval s as string )

#endif '' __EMIT_BI__
