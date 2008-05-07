''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


'' ast support for GOSUB/RETURN (for asm and setjmp/longjmp implementations)
''
'' chng: apr/2008 written [jeffm]

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

''
'' GOSUB/RETURN support
''

'' This must match with fb_error.h in the run-time library
#define FB_RTERROR_RETURNWITHOUTGOSUB 16

'' -gen option is used to select the GOSUB implementation:
''     - GAS emitter will use CALL/RET
''     - C emitter will use setjmp/longjmp
'' However, setjmp/longjmp implementation will also work with the GAS emitter,
'' but since it is like 1000 times slower than CALL/RET, it isn't. (jeffm)
''
#define AsmBackend() (FB_BACKEND_GAS = fbGetOption( FB_COMPOPT_BACKEND ))

'':::::
sub astGosubAddInit _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr var_decl = any
	dim as integer dtype = any

	if( proc->proc.ext = NULL ) then
		proc->proc.ext = symbAllocProcExt( )
	end if
	
	if( symbGetProcStatGosub( proc ) ) then
		exit sub
	end if

	if( AsmBackend() ) then
		'' create a local counter for depth of gosub calls
		'' this is needed for the error checks

		'' DIM "{gosubctx}" as integer = 0
		dtype = FB_DATATYPE_INTEGER

	else

		'' create a local pointer to the gosub stack
		'' Note: on the rtlib side, GOSUBCTX contains one pointer field only
		'' so this cheap trick using an any ptr will work.

		'' DIM "{gosubctx}" as GOSUBCTX = NULL
		dtype = typeAddrOf( FB_DATATYPE_VOID )

	end if

	sym = symbAddVarEx( @"{gosubctx}", NULL, _
						 dtype, NULL, 0, _
						 0, dTB(), _
						 FB_SYMBATTRIB_NONE, FB_SYMBOPT_UNSCOPE )

	var_decl = astNewDECL( FB_SYMBCLASS_VAR, sym, NULL )

	symbSetIsDeclared( sym )
	
	astAddUnscoped( var_decl )

	symbSetProcGosubSym( proc, sym )
	symbSetProcStatGosub( proc )

end sub

'':::::
function astGosubAddJmp _
	( _
		byval proc as FBSYMBOL ptr, _
		byval l as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr label = any

	'' make sure gosub-ctx var is declared
	astGosubAddInit( proc )

	if( AsmBackend() ) then
		
		'' ctx += 1
		astAdd( astBuildVarInc( symbGetProcGosubSym( proc ), 1 ) )

		astAdd( astNewBRANCH( AST_OP_CALL, l ) )

	else

		'' if ( setjmp( fb_GosubPush( @ctx ) ) ) = 0 ) then
		label = symbAddLabel( NULL )

		astAdd( astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
					rtlSetJmp( rtlGosubPush( _
						astNewAddrOf( astNewVar( symbGetProcGosubSym( proc ) ) ) _
					) ), _
					astNewCONSTi( 0, FB_DATATYPE_INTEGER ) ), _
			  label, _
			  FALSE ) )

		'' goto label
		astAdd( astNewBRANCH( AST_OP_JMP, l ) )

		'' end if
		astAdd( astNewLABEL( label ) )

	end if

	function = TRUE

end function

'':::::
function astGosubAddJumpPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval exitlabel as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr label = any

	'' make sure gosub-ctx var is declared
	astGosubAddInit( proc )

	if( AsmBackend() ) then

		'' ctx += 1
		astAdd( astBuildVarInc( symbGetProcGosubSym( proc ), 1 ) )

		astAdd( astNewSTACK( AST_OP_PUSH, _
						 astNewADDROF( astNewVAR( exitlabel ) ) ) )

		astAdd( astNewBranch( AST_OP_JUMPPTR, NULL, expr ) )

	else

		'' make sure gosub-ctx var is declared
		astGosubAddInit( proc )

		'' if ( setjmp( fb_GosubPush( @ctx ) ) ) = 0 ) then
		label = symbAddLabel( NULL )

		astAdd( astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
					rtlSetJmp( rtlGosubPush( _
						astNewAddrOf( astNewVar( symbGetProcGosubSym( proc ) ) ) _
					) ), _
					astNewCONSTi( 0, FB_DATATYPE_INTEGER ) ), _
			  label, _
			  FALSE ) )

		'' goto [expr]
		astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )

		'' end if
		astAdd( astNewLABEL( label ) )

		'' jump to exit label
		astAdd( astNewBRANCH( AST_OP_JMP, exitlabel ) )

	end if

	function = TRUE

end function

'':::::
function astGosubAddReturn _
	( _
		byval proc as FBSYMBOL ptr, _
		byval l as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr label = any

	'' make sure gosub-ctx var is declared
	astGosubAddInit( proc )

	if( AsmBackend() ) then

		'' if( ctx <> 0 ) then
		label = symbAddLabel( NULL )

		astAdd( astUpdComp2Branch( astNewBOP( AST_OP_NE, _
					astNewVar( symbGetProcGosubSym( proc ) ), _
					astNewCONSTi( 0, FB_DATATYPE_INTEGER ) ), _
			  label, _
			  FALSE ) )

		'' ctx -= 1
		astAdd( astBuildVarInc( symbGetProcGosubSym( proc ), -1 ) )

		'' RETURN
		if( l = NULL ) then
			astAdd( astNewBRANCH( AST_OP_RET, NULL ) )

		'' RETURN [label]
		else
			'' pop return address from the stack.  Uses "POP immed" which will be
			'' handled specially in emit_x86.bas::_emitPOPI()
			astAdd( astNewSTACK( AST_OP_POP, astNewCONSTi( symbGetDataSize( FB_DATATYPE_POINTER ), FB_DATATYPE_INTEGER ) ) )

			'' GOTO label
			astAdd( astNewBRANCH( AST_OP_JMP, l ) )

		end if

		'' else
		astAdd( astNewLABEL( label ) )

		'' set/throw error (note: compiler dependency on rtlib's FB_RTERROR_RETURNWITHOUTGOSUB)
		rtlErrorSetNum( astNewCONSTi( FB_RTERROR_RETURNWITHOUTGOSUB, FB_DATATYPE_INTEGER ) )
		if( env.clopt.errorcheck ) then
			rtlErrorThrow( astNewCONSTi( FB_RTERROR_RETURNWITHOUTGOSUB, FB_DATATYPE_INTEGER ), _
								lexLineNum( ), env.inf.name )
		end if

		'' end if

		function = TRUE

	else

		'' RETURN
		if( l = NULL ) then
	
			'' fb_GosubReturn( @ctx )
			function = ( NULL <> rtlGosubReturn( astNewAddrOf( astNewVar( symbGetProcGosubSym( proc ) ) ) ) )

		'' RETURN [label]
		else

			'' if( fb_GosubPop( @ctx ) = 0 ) then
			label = symbAddLabel( NULL )

			astAdd( astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
						rtlGosubPop( _
							astNewAddrOf( astNewVar( symbGetProcGosubSym( proc ) ) ) _
						), _
						astNewCONSTi( 0, FB_DATATYPE_INTEGER ) ), _
				  label, _
				  FALSE ) )

			'' goto label
			astAdd( astNewBRANCH( AST_OP_JMP, l ) )

			'' else
			astAdd( astNewLABEL( label ) )

			'' set/throw error (note: compiler dependency on rtlib's FB_RTERROR_RETURNWITHOUTGOSUB)
			rtlErrorSetNum( astNewCONSTi( FB_RTERROR_RETURNWITHOUTGOSUB, FB_DATATYPE_INTEGER ) )
			if( env.clopt.errorcheck ) then
				rtlErrorThrow( astNewCONSTi( FB_RTERROR_RETURNWITHOUTGOSUB, FB_DATATYPE_INTEGER ), _
									lexLineNum( ), env.inf.name )
			end if

			'' end if

			function = TRUE

		end if

	end if

end function

'':::::
function astGosubAddExit _
	( _
		proc as FBSYMBOL ptr _
	) as integer

	if( symbGetProcStatGosub( proc ) ) then
		if( AsmBackend() = FALSE ) then
			astAdd( rtlGosubExit( astNewAddrOf( astNewVar( symbGetProcGosubSym( proc ) ) ) ) )
		end if
	end if

	function = TRUE

end function
