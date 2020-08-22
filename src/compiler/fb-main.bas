'' prolog and epilog for the implicit main() function
''
'' chng: jun/2005 written [v1ctor]
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "symb.bi"

private sub hCallMain( )
	dim as ASTNODE ptr main = any

	'' main( 0, NULL )
	main = astNewCALL( env.main.proc )
	astNewARG( main, astNewCONSTi( 0 ) )
	astNewARG( main, astNewCONSTi( NULL, typeAddrOf( FB_DATATYPE_VOID ) ) )

	'' tell the emitter to not allocate a result
	astSetType( main, FB_DATATYPE_VOID, NULL )

	astAdd( main )
end sub

private sub hBuildDllMainWin32( )
	dim as FBSYMBOL ptr proc = any, label = any, param = any

	proc = symbPreAddProc( NULL )

	'' instance
	symbAddProcParam( proc, "__FB_DLLINSTANCE__", typeAddrOf( FB_DATATYPE_VOID ), NULL, _
	                  0, FB_PARAMMODE_BYVAL, 0, 0 )

	'' reason
	param = symbAddProcParam( proc, "__FB_DLLREASON__", FB_DATATYPE_UINT, NULL, _
	                          0, FB_PARAMMODE_BYVAL, 0, 0 )

	'' reserved
	symbAddProcParam( proc, "__FB_DLLRESERVED__", typeAddrOf( FB_DATATYPE_VOID ), NULL, _
	                  0, FB_PARAMMODE_BYVAL, 0, 0 )

	'' function DllMain stdcall( byval instance as any ptr, byval reason as uinteger, _
	''                           byval reserved as any ptr ) as integer
	proc = symbAddProc( proc, NULL, "DllMain", FB_DATATYPE_INTEGER, NULL, _
	                    FB_SYMBATTRIB_PUBLIC, FB_PROCATTRIB_NONE, env.target.stdcall, FB_SYMBOPT_DECLARING )

	astProcBegin( proc, FALSE )

	'' function = TRUE
	astAdd( astNewASSIGN( astNewVAR( symbGetProcResult( proc ) ), _
	                      astNewCONSTi( 1, symbGetType( proc ) ) ) )

	'' if( reason = DLL_PROCESS_ATTACH ) then
	param = symbGetParamVar( param )
	label = symbAddLabel( NULL )
	astAdd( astNewBOP( AST_OP_NE, _
			astNewVAR( param ), _
			astNewCONSTi( 1, FB_DATATYPE_UINT ), _
			label, AST_OPOPT_NONE ) )

	'' main( ... )
	hCallMain( )

	'' end if
	astAdd( astNewLABEL( label ) )

	'' end function
	astProcEnd( FALSE )
end sub

private sub hBuildDllMainCtor( )
	dim as FBSYMBOL ptr proc = any

	'' sub ctor cdecl( ) constructor
	proc = symbAddProc( symbPreAddProc( NULL ), NULL, "__fb_DllMain_ctor", FB_DATATYPE_VOID, NULL, _
	                    FB_SYMBATTRIB_PRIVATE, FB_PROCATTRIB_NONE, FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )
	symbAddGlobalCtor( proc )
	astProcBegin( proc, FALSE )

	'' main( ... )
	hCallMain( )

	'' end sub
	astProcEnd( FALSE )
end sub

private sub hMainBegin( )
	dim as FBSYMBOL ptr proc = any, argv = any

	proc = symbPreAddProc( NULL )

	'' byval argc as long
	symbAddProcParam( proc, "__FB_ARGC__", FB_DATATYPE_LONG, NULL, _
	                  0, FB_PARAMMODE_BYVAL, 0, 0 )

	'' byval argv as zstring ptr ptr
	argv = symbAddProcParam( proc, "__FB_ARGV__", typeMultAddrOf( FB_DATATYPE_CHAR, 2 ), NULL, _
	                         0, FB_PARAMMODE_BYVAL, 0, 0 )

	'' if it's a dll, the main() function should be private
	var attrib = FB_SYMBATTRIB_PUBLIC
	var id = fbGetEntryPoint( )
	if( env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB ) then
		attrib = FB_SYMBATTRIB_PRIVATE
		'' Use a random name for the C backend
		if( env.clopt.backend = FB_BACKEND_GCC ) then
			id = *symbUniqueId( )
		end if
	else
		'' If the implicit main() will actually be called main() and be
		'' public too, then the C backend needs to take care to emit
		'' argv with the proper dtype...
		argv->stats or= FB_SYMBSTATS_ARGV
	end if

	'' function main cdecl( byval argc as long, byval argv as zstring ptr ptr ) as long
	env.main.proc = symbAddProc( proc, NULL, id, FB_DATATYPE_LONG, NULL, _
	                             attrib, FB_PROCATTRIB_NONE, FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )

	'' Must be done before astProcBegin(), so it will add the fb_Init() call, etc.
	symbSetIsMainProc( env.main.proc )

	astProcBegin( env.main.proc, TRUE )
end sub

private sub hModLevelBegin( )
	'' sub modlevel cdecl( ) constructor
	env.main.proc = symbAddProc( symbPreAddProc( NULL ), "{modlevel}", fbGetModuleEntry( ), FB_DATATYPE_VOID, NULL, _
	                             FB_SYMBATTRIB_PRIVATE, FB_PROCATTRIB_NONE, FB_FUNCMODE_CDECL, FB_SYMBOPT_DECLARING )
	symbAddGlobalCtor( env.main.proc )
	symbSetIsAccessed( env.main.proc )
	symbSetIsModLevelProc( env.main.proc )

	astProcBegin( env.main.proc, TRUE )
end sub

sub fbMainBegin( )
	if( env.outf.ismain ) then
		'' function main( ... )
		hMainBegin( )
	else
		'' sub modlevel( ) constructor
		hModLevelBegin( )
	end if

	'' Generate a DllMain() or global ctor that calls main()/modlevel() in DLLs/shared libs
	if( env.outf.ismain and (env.clopt.outtype = FB_OUTTYPE_DYNAMICLIB) ) then
		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			hBuildDllMainWin32( )
		else
			hBuildDllMainCtor( )
		end if
	end if
end sub

sub fbMainEnd( )
	dim as integer callrtexit = FALSE

	if( env.outf.ismain ) then
		'' set default data label (def label isn't global as it could clash with other
		'' modules, so DataRestore alone can't figure out where to start)
		if( astGetFirstDataStmtSymbol( ) <> NULL ) then
			rtlDataRestore( NULL, env.main.initnode )
		end if

		callrtexit = (env.clopt.outtype <> FB_OUTTYPE_DYNAMICLIB)
	end if

	'' end sub|function (main() or modlevel())
	astProcEnd( callrtexit )
end sub
