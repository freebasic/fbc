#ifndef __UNWIND_BI__
#define __UNWIND_BI__

#include once "ast.bi"
#include once "symb.bi"

''
'' unwind-ast functions
''
declare sub unwindDeleteScopeData( byval scopedata as FB_SCOPEUNWIND ptr )

declare sub unwindDeleteProcExt( byval procdata as FB_PROCEXT ptr )

'' causes a reverse for loop to destruct a constructor-initialised array
'' in the unwind block. The function itself
'' returns the unwind checkpoint label
declare function unwindPushManualArrayCleanup( byval loopvar as FBSYMBOL ptr, byval iter as FBSYMBOL ptr ) as ASTNODE ptr

'' These labels are used to create the metadata tables
'' describing which unwind blocks to jump to on error
declare function unwindCreateCheckpointLabel() as ASTNODE ptr

'' Will generate the cleanup block (if required)
'' does nothing if the unwindobj cmdline is not set
'' or if no checkpoint labels have been created
'' in the current scope
declare sub unwindCreateCleanupBlock( byval scopeSymb as FBSYMBOL ptr )

'' Creates a new label marking the start point of an on error goto region
'' /catchPoint/ is the label supplied as the goto
declare function unwindCreateCatchStartLabel( byval catchPoint as FBSYMBOL ptr, byval labelbeforestmt as integer ) as ASTNODE ptr

'' used in parsing of 'On Error Goto 0' to mark the end of the 'try' range for the previously active on error goto
declare function unwindMarkEndOfCatchRange(  ) as ASTNODE ptr

'' used to start the throw/unwinding process
declare sub unwindThrowException( byval throwObj as FBSYMBOL ptr )

'' If this label is the target of an on error goto, 
'' inserts an empty asm block to cause emitters to forget their 
'' register state
declare sub unwindCheckForErrorGotoLabel( byval label as FBSYMBOL ptr )

'' If the currently parsed proc has any catch or cleanup regions
declare function unwindCurProcHasActions( ) as integer
declare function unwindProcHasActions( byval proc as FBSYMBOL ptr ) as integer

'' generates things like asm gotos to reference labels that GCC would remove,
'' SEH registration and teardown etc
declare function unwindGenProcSupportCode( _
	byval proc as FBSYMBOL ptr, _
	byval procinitlabel as FBSYMBOL ptr, _
	byval procexitlabel as FBSYMBOL ptr, _
	byval cleanupNode as ASTNODE ptr ptr _
) as ASTNODE ptr

declare function unwindGenGCCCoverageTableLabel( ) as FBSYMBOL ptr

''
'' unwind-asmgen functions
''

declare function unwindGenCfiHeader( byval datalabel as FBSYMBOL ptr ) as ASTNODE ptr
declare function unwindGenProcTable( _
	byval proc as FBSYMBOL ptr, _
	byref procendlabel as FBSYMBOL ptr _
) as ASTNODE ptr
declare function unwindGenProcGCCAttributes( byval proc as FBSYMBOL ptr ) as string

#endif
