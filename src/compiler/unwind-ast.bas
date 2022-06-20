'' Implements generation of object unwind blocks, region labelling
'' and the management of data structures to send to the generators

'' This method is based on (but not identical to) how GCC implements
'' C++ exception unwinding. A simple description and walkthrough of
'' that is here 
'' https://monkeywritescode.blogspot.com/p/c-exceptions-under-hood.html
'' and the LSDA data we emulate is defined here
'' https://www.airs.com/blog/archives/464
''
'' This is how FB unwind generation (and runtime unwinding) works:
''
'' 1. Every stack allocated variable that requires a constructor call 
'' has a label added after it (except manual array construction loops
'' where the label is added before - see hCallCtorList)
''
'' 2. At the end of every scope that has such a label, after any normal 
'' destructor calls:
'' a) a jump is inserted (so the next block is skipped when there are
''    no exceptions)
'' b) a label is added to mark the start of the unwind block
'' c) then all the destructor calls are generated again. This time
''    each has a label inserted before it
'' d) at the end of the block, an assembly 'ret' is inserted
'' e) then a final label, which is the target of the jump from a)
'' 
'' 3. The construction and destruction labels are then used to build 
'' a coverage table. Each construction label from 1) is subtracted 
'' from the label created in 2b) in reverse order (so from closet
'' to furthest away), and those ranges are mapped to the destruction
'' labels created in 2c) in sequential order.
'' This marks out the regions of the code and points to the most specific
'' cleanup that is required for a scope without having to check
'' every object at runtime. If execution passes the labels from 1)
'' that object was constructed successfully, if it didn't, it wasn't
''
'' 4. At runtime when an error happens, the tables from 3) are consulted
'' by subtracting the instruction pointer from the address of the start
'' of the function. As the stack 
'' frames are popped execution jumps to the correct 
'' cleanup blocks where destructors are called, and that process continues up
'' the stack, eventually landing at the handler.
'' If there are no handlers, no cleanup is done
''
'' In order to avoid NULL checks at all the label creation points in the compiler,
'' labels are always generated, regardless of if the unwind compiler option
'' was set. 2, 3 & 4 above won't be done if the option isn't set

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "symb.bi"
#include once "unwind.bi"
#include once "ast.bi"
#include once "list.bi"
#include once "rtl.bi"
#include once "error.bi"

type CTORLIST_COUNTER
	countervar as FBSYMBOL ptr
	itervar as FBSYMBOL ptr
end type

dim shared as Long lbluniqifier = 0

'' None of these allocations need deleting, as by the time 
private function hAllocUnwindData( byval bytes as integer ) as any ptr
	'' the largest size our pool accommodates
	assert( bytes <= sizeof( FB_SCOPEUNWIND ) )

	dim as byte ptr dataptr = poolNewItem( @symb.unwindpool, bytes )
	clear( *dataptr, 0, bytes )
	return dataptr
end function

private function hMaybeAllocScopeData( byref undata as FB_SCOPEUNWIND ptr ) as FB_SCOPEUNWIND ptr
	if( undata = NULL ) then
		undata = hAllocUnwindData( sizeof( FB_SCOPEUNWIND ) )
	end if
	return undata
end function

private function hCurrentProcExt( byval init as integer = 1 ) as FB_PROCEXT ptr
	dim as FB_PROCEXT ptr ext = parser.currproc->proc.ext
	'' initialize our ext data for the current proc
	if( init ) then
		if( ext = 0 ) then
			symbProcAllocExt( parser.currproc )
			ext = parser.currproc->proc.ext
		end if
		if( ext andalso ( ext->coveragetablelocation = NULL ) ) then 
			dim as string labelname = *symbGetMangledName( parser.currproc ) + "_unw_coveragetable"
			ext->coveragetablelocation = symbAddLabel( strptr( labelname ) )
		end if
	end if
	return ext
end function

private function hCurrentScopeData( byval alloc as integer = 1 ) as FB_SCOPEUNWIND ptr
	'' parser.currblock can be a proc symbol or a scope symbol, 
	'' modifying one as if it was the other leads to very bad things
	'' happening
	dim as FB_SCOPEUNWIND ptr scopedata
	dim as FBSYMBOL ptr currblock = parser.currblock
	dim as FB_SYMBCLASS blockclass = symbGetClass( currblock )
	select case as const blockclass
		case FB_SYMBCLASS_PROC
			dim as FB_PROCEXT ptr procext = hCurrentProcExt( alloc )
			if procext then
				scopedata = Iif( _
					alloc, _
					hMaybeAllocScopeData( procext->scopeunwind ), _
					procext->scopeunwind _
				)
			end if
		case FB_SYMBCLASS_SCOPE
			scopedata = Iif( _
				alloc, _
				hMaybeAllocScopeData( currblock->scp.unwind ), _
				currblock->scp.unwind _
			)
		case else
			assert( strptr( "Parser.currblock is of an unexpected type" ) = 0 )
	end select
	return scopedata
end function

sub unwindDeleteScopeData( byval scopedata as FB_SCOPEUNWIND ptr )
	if scopedata then poolDelItem( @symb.unwindpool, scopedata )
end sub

sub unwindDeleteProcExt( byval procext as FB_PROCEXT ptr )
	dim as FB_UNWINDREGION ptr iter = procext->cleanupregionshead
	dim as FB_UNWINDREGION ptr temp = any
	dim as integer donecatch
	'' The labels in the unwindregion udts will be freed 
	'' when the proc symbol table is freed
	do
		if iter = 0 then
			if donecatch = 0 then
				iter = procext->catchregionshead
				donecatch = 1
				continue do
			else
				exit do
			end if
		end if
		temp = iter->next
		poolDelItem( @symb.unwindpool, iter )
		iter = temp
	loop
	unwindDeleteScopeData( procext->scopeunwind )
end sub

function unwindPushManualArrayCleanup( byval loopvar as FBSYMBOL ptr, byval iter as FBSYMBOL ptr ) as ASTNODE ptr
	dim as FB_SCOPEUNWIND ptr unwinddata = hCurrentScopeData( )
	dim as TLIST ptr ctorlist = @unwinddata->ctorlistcounters
	if unwinddata->hasarraycleanup = 0 then
		listInit( ctorlist, 16, SizeOf( CTORLIST_COUNTER ), LIST_FLAGS_NOCLEAR )
	end if
	unwinddata->hasarraycleanup = 1
	dim as CTORLIST_COUNTER ptr newentry = listNewNode( ctorlist )
	newentry->countervar = loopvar
	newentry->itervar = iter
	return unwindCreateCheckpointLabel( )
end function

private sub hAddCheckpointToLists( _
	byval labelsym as FBSYMBOL ptr, _
	byref prochead as FB_UNWINDREGION ptr, _
	byref proctail as FB_UNWINDREGION ptr, _
	byref scopehead as FB_UNWINDREGION ptr, _
	byref scopetail as FB_UNWINDREGION ptr _
)

	dim as FB_UNWINDREGION ptr checkpoint = hAllocUnwindData( sizeof( *checkpoint ) )
	checkpoint->startlabel = labelsym
	if( prochead = NULL ) then
		prochead = checkpoint
	else
		proctail->next = checkpoint
	end if
	proctail = checkpoint
	if( scopehead = NULL ) then scopehead = checkpoint
	scopetail = checkpoint

end sub

private function hCreateLabel( _
	byval labelnamestem as zstring ptr, _
	byval id as integer _
) as FBSYMBOL ptr

	dim as integer currscope = parser.scope
	dim as string labelname = *labelnamestem + Str( currscope ) + "_" + Str( id ) + "_" + Str( lblUniqifier )
	lblUniqifier += 1
	return symbAddLabel( StrPtr( labelname ) )
end function

private function hCreateGCCLabelReferences( _
	byval cleanuphead as FB_UNWINDREGION ptr, _
	byval cleanuptail as FB_UNWINDREGION ptr, _
	byval catchhead as FB_UNWINDREGION ptr, _
	byval catchtail as FB_UNWINDREGION ptr _
) as ASTNODE ptr
	dim as ASTNODE ptr gotonode
	if( fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GCC ) then
		'' If our cleanup sections aren't referenced in a reachable code path
		'' then GCC will remove them as they are behind direct jumps
		'' so here, we insert all of this scope's labels into an asm goto
		'' which tells GCC the code in the asm string might reach them
		'' and so it keeps them around.

		'' For our purposes, we only really need - asm goto(""::::<labels>)
		'' but appending a label (to cause the asm goto to be generated)
		'' causes ir-hlc.bas to output - asm goto("%l0"::::<labelname>)
		'' this will insert "L50" (or whatever label number GCC generates) into the asm file
		'' this'd be fine if we were writing any code but by itself is an invalid statement that causes errors
		'' this hash prefixing here turns the L50 line into a gas comment and makes everything fine again
		dim as ASTASMTOK ptr asmtokens = astAsmAppendText( NULL, @"#" )
		dim as ASTASMTOK ptr asmtail = asmtokens
		dim as FB_UNWINDREGION ptr head = cleanuphead
		dim as FB_UNWINDREGION ptr tail = cleanuptail
		dim as integer keepgoing = ( head <> 0 )
		while keepgoing
			asmtail = astAsmAppendSymb( asmtail, head->actionlabel )
			keepgoing = ( head <> tail )
			head = head->next
		wend
		head = catchhead
		tail = catchtail
		keepgoing = ( head <> 0 )
		while keepgoing
			asmtail = astAsmAppendSymb( asmtail, head->actionlabel )
			keepgoing = ( head <> tail )
			head = head->next
		wend
		dim as FBSYMBOL ptr tablelabel = unwindGenGCCCoverageTableLabel( )
		asmtail = astAsmAppendSymb( asmtail, tablelabel )
		gotonode = astNewASM( asmtokens )
	end if
	return gotonode
end function

private function hCreateRegisterFlushNode( ) as ASTNODE ptr
	'' empty asm nodes don't trigger the clobbers for GCC code gen
	'' but we don't want to actually generate any code
	'' so the comment fulfills both purposes
	return astNewASM( astAsmAppendText( NULL, @"#" ) )
end function

private function unwindCreateCheckpointLabelMaybeLink( byval link as integer ) as ASTNODE ptr
	dim as FB_SCOPEUNWIND ptr unwinddata = hCurrentScopeData( )
	dim as FB_PROCEXT ptr curproc = hCurrentProcExt( )
	dim as integer id = unwinddata->numcheckpoints + 1
	dim as FBSYMBOL ptr labelsym = hCreateLabel( @"unwindconlabel", id )
	if link then
		hAddCheckpointToLists( _
			labelsym, _
			curproc->cleanupregionshead, _
			curproc->cleanupregionstail, _
			unwinddata->cleanupregionshead, _
			unwinddata->cleanupregionstail _
		)
	end if
	unwinddata->numcheckpoints = id
	return astNewLABEL( labelsym )
end function

function unwindCreateCheckpointLabel( ) as ASTNODE ptr
	return unwindCreateCheckpointLabelMaybeLink( 1 )
end function

function unwindCreateCleanupLabel( ) as ASTNODE ptr
	dim as FB_SCOPEUNWIND ptr unwinddata = hCurrentScopeData( )
	assert( unwinddata->numcheckpoints > unwinddata->numcleanpoints )
	'' cleanup labels apply to the checkpoints in reverse order
	''
	'' by this point the end of scope checkpoint has been added, discount that
	dim as integer node_to_find = (unwinddata->numcheckpoints - 1) - unwinddata->numcleanpoints
	dim as integer i = 1
	dim as FB_UNWINDREGION ptr nodeiter = unwinddata->cleanupregionshead
	while i < node_to_find
		nodeiter = nodeiter->next
		i += 1
	wend
	dim as FBSYMBOL ptr labelsym = hCreateLabel( @"unwinddestructlabel", node_to_find )
	labelsym->lbl.unwindtarget = true
	nodeiter->actionlabel = labelsym
	unwinddata->numcleanpoints += 1
	return astNewLABEL( labelsym )
end function

'' This is the inverse of hCallCtorList in ast-node-proc.bas
'' If the loop generated in here changes, the loop there will probably need
'' updating too
private function hGenDtorLoop( byval cntr as CTORLIST_COUNTER ptr ) as ASTNODE ptr
	
	dim as ASTNODE ptr tree 
	'' first the release label
	dim as FBSYMBOL ptr loopend = symbAddLabel( NULL )
	dim as FBSYMBOL ptr loopstart = symbAddLabel( NULL )
	dim as FBSYMBOL ptr iter = cntr->itervar
	dim as FBSYMBOL ptr cnt = cntr->countervar

	'' the iterator needs decremening first
	'' either it got to the end of the loop successfully 
	'' (so points past the end)
	'' or it's at the index of the constructor that caused an error
	'' (and that one doesn't need to have it's destructor called)
	tree = astBuildVarInc( iter, -1 )

	'' the counter does not need similarly decementing
	'' as the loop terminates when the var is 0, from value x down to 1
	'' is the same number of loops as from x-1 to 0
	''
	'' While (countervar > 0)
	tree = astBuildWhileCounterBegin( tree, cnt, loopstart, loopend, astNewVAR( cnt ), FALSE )

	'' dtor(*iter)
	tree = astNewLINK( tree, astBuildDtorCall( symbGetSubType( iter ), astBuildVarDeref( iter ) ), AST_LINK_RETURN_NONE )

	'' iter -= 1
	tree = astNewLINK( tree, astBuildVarInc( iter, -1 ), AST_LINK_RETURN_NONE )

	'' countervar -= 1
	'' wend
	return astBuildWhileCounterEnd( tree, cntr->countervar, loopstart, loopend )
	
end function

private sub hFixupScopeEndLabels( byval unwinddata as FB_SCOPEUNWIND ptr, byval endlabel as ASTNODE ptr )
	dim as FB_UNWINDREGION ptr nodeiter = unwinddata->cleanupregionshead
	dim as FB_UNWINDREGION ptr endnode = unwinddata->cleanupregionstail
	dim as FBSYMBOL ptr endlabelsym = endlabel->sym

	'' listend needs to be included
	while nodeiter <> endnode
		nodeiter->endlabel = endlabelsym
		nodeiter = nodeiter->next
	wend
	nodeiter->endlabel = endlabelsym
end sub

private sub hGenUnwindBlock( byval symTb as FBSYMBOL ptr, byval unwinddata as FB_SCOPEUNWIND ptr )

	'' This sub generates an unwind block of the format
	''
	'' asm goto referencing all scope label (in the GCC case, so they aren't removed)
	'' direct jump to after this section (normal operation of the code doesn't need the block)
	'' for each destructor
	''     a label
	''     destructor call
	'' next
	'' asm mov SP, savedSPVal
	'' asm ret
	'' the jump target label

	'' A local variable of Any Ptr type is also added, to hold the exception
	'' state between the unwinding and the resume
	'' this is initialized from eax/rax at the start of the handler

	'' last checkpoint label, 2b) in the description at the top
	dim as ASTNODE ptr endofscopelabel = unwindCreateCheckpointLabelMaybeLink( 0 )
	dim as TLIST ptr ctornodelist = @unwinddata->ctorlistcounters
	dim as CTORLIST_COUNTER ptr ctorNode = Iif( unwinddata->hasarraycleanup = 1, listGetTail( ctornodelist ), NULL )
	dim as FBSYMBOL ptr s = symTb
	dim as ASTNODE ptr unwindingtree = NULL, destructorlist = NULL
	dim as FBSYMBOL ptr nextCounter = Iif( ctorNode = NULL, NULL, ctorNode->countervar )
	dim as integer hadctornodes = ( ctorNode <> NULL )
	dim as integer is64target = ( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 )
	dim as ASTNODE ptr cleanupsectionlabel = unwindCreateCleanupLabel( )
#ifdef UNWIND_CLEANUP_STATE_VAR
	dim as FBSYMBOL ptr exceptionstatevar = symbAddImplicitVar( typeAddrOf( FB_DATATYPE_VOID ) )
#endif
	'' we don't want cleanupsectionlabel linked into destructortree
	'' from the beginning, we need to add code between it and those
	'' later on
	dim as integer firstlink = 1

	do while( s <> NULL )
		if( symbIsVar( s ) ) then
			if( s = nextCounter ) then
				if( firstlink = 0 ) then
					destructorlist = astNewLINK( destructorlist, unwindCreateCleanupLabel( ), AST_LINK_RETURN_NONE )
					'' fbexcept can jump in at any cleanup label
					'' so the generators saved register state needs to be
					'' invalidated at each
					destructorlist = astNewLINK( destructorlist, hCreateRegisterFlushNode ( ), AST_LINK_RETURN_NONE )
				end if
				destructorlist = astNewLINK( destructorlist, hGenDtorLoop( ctorNode ), AST_LINK_RETURN_NONE )
				ctorNode = listGetPrev( ctorNode )
				nextCounter = Iif( ctorNode = NULL, NULL, ctorNode->counterVar )
				firstlink = 0
			else
				'' has a dtor?
				if( symbGetVarHasDtor( s ) ) then
					'' call it..
					dim as ASTNODE ptr expr = astBuildVarDtorCall( s, TRUE )
					if( expr <> NULL ) then
						if( firstlink = 0 ) then
							destructorlist = astNewLINK( destructorlist, unwindCreateCleanupLabel( ), AST_LINK_RETURN_NONE )
						end if
						destructorlist = astNewLINK( destructorlist, expr, AST_LINK_RETURN_NONE )
						firstlink = 0
					end if
				end if
			end if
		end if
		s = s->prev
	loop

	Assert( destructorlist <> NULL )

	'' bits for the jump over all the duplicated destructors
	'' for the common case
	dim as FBSYMBOL ptr jumptargetsym = symbAddLabel( NULL )
	dim as ASTNODE ptr jumplabel = astNewLABEL( jumptargetsym )
	dim as ASTNODE ptr jumpop = astNewBRANCH( AST_OP_JMP, jumptargetsym )

	'' start generating the code:
	'' add the last checkpoint label
	unwindingtree = endofscopelabel

	'' the jump over
	unwindingtree = astNewLINK( unwindingtree, jumpop, AST_LINK_RETURN_NONE )

	'' the cleanup label head
	unwindingtree = astNewLINK( unwindingtree, cleanupsectionlabel, AST_LINK_RETURN_NONE )
	'' register invalidation
	unwindingtree = astNewLINK( unwindingtree, hCreateRegisterFlushNode ( ), AST_LINK_RETURN_NONE )

#ifdef UNWIND_CLEANUP_STATE_VAR
	'' when the cleanup block is executed, unwinder puts the exception state
	'' in rax/eax. This isn't useful now (the mechanism was redesigned after this was created)
	'' but in future with user defined cleanup or catches that might need to examine
	'' the exception state, this could be re-enabled as it might be useful
	unwindingtree = astNewLINK( unwindingtree, astNewDECL( exceptionstatevar, FALSE ), AST_LINK_RETURN_NONE )
	dim as zstring ptr exceptvarinit = @"mov ["
	dim as ASTASMTOK ptr asmassignexvar = astAsmAppendText( NULL, exceptvarinit )
	dim as ASTASMTOK ptr assignexvartail = astAsmAppendSymb( asmassignexvar, exceptionstatevar )
	if is64target then
		exceptvarinit = @"], rax"
	else
		exceptvarinit = @"], eax"
	end if

	astAsmAppendText( assignexvartail, exceptvarinit )
	unwindingtree = astNewLINK( unwindingtree, astNewASM( asmassignexvar ), AST_LINK_RETURN_NONE )
#endif

	'' then the duplicated destructors
	unwindingtree = astNewLINK( unwindingtree, destructorlist, AST_LINK_RETURN_NONE )

	'' then the return to the exception handler
	'' This has to be an asm ret rather than a FreeBasic return as
	'' the code gen on an FB return will cleanup the stack frame
	'' we don't want that as the unwinding may need to call into
	'' another cleanup or catch section which requires the stack frame
	''
	'' we need to replace the stack pointer before the ret as the cleanup
	'' has its own stack frame so in order to get back to the handler
	'' it needs resetting to the handlers stack frame (which is in (e|r)bx)
	'' we can't just leave it as GCC will sometimes generate code like
	'' mov [esp], <value> that will overwrite the return address that's
	'' at the top of the stack
	dim as zstring ptr replacestackptr = iif( is64target, @!"mov rsp, rbx" NEWLINE "ret", @!"mov esp, ebx" NEWLINE "ret" )
	unwindingtree = astNewLINK( unwindingtree, astNewASM( astAsmAppendText( NULL, replacestackptr ) ), AST_LINK_RETURN_NONE )

	'' finally, add in the jump target label
	unwindingtree = astNewLINK( unwindingtree, jumpLabel, AST_LINK_RETURN_NONE )

	'' link it in
	astAdd( unwindingtree )

	'' there should now be only one more checkpoint than cleanpoint
	'' (the end of scope label)
	assert( unwinddata->numcheckpoints = ( unwinddata->numcleanpoints + 1 ) )
	'' point all the unwind region end labels to endofscopelabel
	hFixupScopeEndLabels( unwinddata, endofscopelabel )

	'' don't need this any more
	if( hadctornodes <> 0 ) then 
		listEnd( ctornodelist )
		unwinddata->hasarraycleanup = 0
	end if
end sub

sub unwindCreateCleanupBlock( byval scopeSyms as FBSYMBOL ptr )

	dim as FB_SCOPEUNWIND ptr unwinddata = hCurrentScopeData( 0 )
	if( ( unwinddata = NULL ) orelse _
	    ( unwinddata->numcheckpoints = 0 ) orelse _
	    ( fbGetOption( FB_COMPOPT_OBJUNWIND ) = 0 ) _
	) _
	then exit sub

	hGenUnwindBlock( scopeSyms, unwinddata )
end sub

private function hGenSEHProcData( byval procsym as FBSYMBOL ptr, byval cleanupTree as ASTNODE ptr ptr ) as ASTNODE ptr
	'' only needed on 32-bit windows
	'' when the unwind opt is set
	'' and if we have some data
	if ( fbGetOption( FB_COMPOPT_TARGET ) <> FB_COMPTARGET_WIN32 ) orelse _
	   ( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 ) orelse _
	   ( fbGetOption( FB_COMPOPT_OBJUNWIND ) = 0 ) orelse _
	   ( unwindProcHasActions( procsym ) = 0 ) _
	then
		return NULL
	end if

	dim as FBSYMBOL ptr sehstruct = symbAddImplicitVar( FB_DATATYPE_STRUCT, symb.sehtype )

	'' we can't just push the requisite values onto the stack to 
	'' create the struct like GCC does as GCC assumes the stack pointer
	'' won't be changed by asm blocks, and that would definitely
	'' change the stack pointer...
	'' so we lea the FB stack variable and fill it in like that

	'' edx doesn't have to be saved in -gen gcc since the emitter
	'' specifies it in the clobber list. It does in the gas case
	'' because the emitter won't know we've modified it in order to save it
	'' beforehand
	dim as zstring ptr varlea = _
		@"push edx" NEWLINE _
		"mov eax, fs:[0]" NEWLINE _ '' old seh list head
		"lea edx, ["
	dim as ASTASMTOK ptr sehasmhead = any, sehasmtail = any
	sehasmhead = astAsmAppendText( NULL, varlea )
	sehasmtail = astAsmAppendSymb( sehasmhead, sehstruct )

	dim as zstring ptr initsehstruct = @"]" NEWLINE _
		"mov [edx], eax" NEWLINE _ '' prevNode
		"lea eax, [esp + 4]" NEWLINE _ '' espVal (plus the edx pop to come)
		"mov dword ptr [edx+4], offset _fb_DispatchException" NEWLINE _ '' handler
		"mov [edx+8], eax" NEWLINE _ '' espval
		"mov [edx+12], ebp" NEWLINE _ '' ebpval
		"mov dword ptr [edx+16], 0" NEWLINE _ '' scratch
		"mov fs:[0], edx" NEWLINE '' add link to chain

	dim as zstring ptr popedx = @"pop edx" NEWLINE  '' restore edx

	sehasmtail = astAsmAppendText( sehasmtail, initsehstruct )
	sehasmtail = astAsmAppendText( sehasmtail, popedx )

	'' generate the code tree
	dim as ASTNODE ptr prologtree = astNewDECL( sehstruct, 0 )
	prologtree = astNewLINK( prologtree, astNewASM( sehasmhead ), AST_LINK_RETURN_NONE )

	'' also generate the epilog that removes the frame from the list
	dim as zstring ptr sehpopstart = @"mov ecx, ["
	dim as ASTASMTOK ptr pophead = astAsmAppendText( NULL, sehpopstart )
	dim as ASTASMTOK ptr poptail = astAsmAppendSymb( pophead, sehstruct )
	poptail = astAsmAppendText(poptail, @"] " NEWLINE "mov fs:[0], ecx" NEWLINE)

	*cleanupTree = astNewASM( pophead )

	return prologtree
end function

function unwindGenProcSupportCode( _
	byval proc as FBSYMBOL ptr, _
	byval procinitlabel as FBSYMBOL ptr, _
	byval procexitlabel as FBSYMBOL ptr, _
	byval cleanupNode as ASTNODE ptr ptr _
) as ASTNODE ptr
	dim as ASTNODE ptr prolognode
	dim as FB_PROCEXT ptr procext = proc->proc.ext
	if( _
		procext andalso _
		fbGetOption( FB_COMPOPT_OBJUNWIND ) andalso _
	    	unwindProcHasActions( proc ) _
	) then
		dim as ASTNODE ptr headerlinks, taillinks
		dim as ASTNODE ptr gcclabels = hCreateGCCLabelReferences( _
			procext->cleanupregionshead, _
			procext->cleanupregionstail, _
			procext->catchregionshead, _
			procext->catchregionstail _
		)
		dim as ASTNODE ptr cfiheader = unwindGenCfiHeader( procext->coveragetablelocation )
		dim as ASTNODE ptr sehprochead = any, sehproctail
		dim as ASTNODE ptr proctable = unwindGenProcTable( proc, procexitlabel )
		sehprochead = hGenSEHProcData( proc, @sehproctail )

		'' things that needs to go in the proc header
		if cfiheader then
			headerlinks = cfiheader
		end if
		if sehprochead then
			headerlinks = astNewLINK( headerlinks, sehprochead, AST_LINK_RETURN_NONE )
		end if
		prolognode = headerlinks

		'' then things that go in the footer
		if gcclabels then
			taillinks = gcclabels
		end if
		if proctable then
			taillinks = astNewLINK( taillinks, proctable, AST_LINK_RETURN_NONE )
		end if
		if sehproctail then
			taillinks = astNewLINK( taillinks, sehproctail, AST_LINK_RETURN_NONE )
		end if
		*cleanupnode = taillinks
	end if
	return prolognode
end function

function unwindCreateCatchStartLabel( byval catchpoint as FBSYMBOL ptr, byval labelbeforestmt as integer ) as ASTNODE ptr
	'' If the error label is before the on error, error out.
	'' It's too compilcated to work out which cleanups to run
	if labelbeforestmt then 
		'' if this ever is allowed, unwindcheckerrorgotolabel below
		'' will need changing, since targets defined before the on error
		'' won't be in the list to check
		errReport( FB_ERRMSG_UNWINDGOTOBEFOREONERROR )
	end if

	dim as FB_SCOPEUNWIND ptr unwinddata = hCurrentScopeData( )
	dim as FB_PROCEXT ptr curproc = hCurrentProcExt( )
	dim as FBSYMBOL ptr labelsym = hCreateLabel( @"unwindtrylabel", 0 )
	dim as ASTNODE ptr returnlabel = astNewLABEL( labelsym )
	hAddCheckpointToLists( _
		labelsym, _
		curproc->catchregionshead, _
		curproc->catchregionstail, _
		unwinddata->catchregionshead, _
		unwinddata->catchregionstail _
	)
	dim as FB_UNWINDREGION ptr newcatch = unwinddata->catchregionstail
	newcatch->actionlabel = catchPoint
	newcatch->endlabel = catchpoint
	return returnlabel
end function

private sub hMaybeRestrictUnwindRegion( byval region as FB_UNWINDREGION ptr, byval potentialend as FBSYMBOL ptr )
	dim byref as FBSYMBOL ptr endlabel = region->endlabel
	if endlabel = null then 
		endlabel = potentialend
	else
		dim byref as FBS_LABEL potentialendlbl = potentialend->lbl
		dim byref as FBS_LABEL curendlbl = endlabel->lbl
		if potentialendlbl.stmtnum < curendlbl.stmtnum then
			endlabel = potentialend
		end if
	end if
end sub

private sub hCurtailCatchRegions( byval curprocext as FB_PROCEXT ptr, byval lastonly as integer, byval rangeend as FBSYMBOL ptr )
	dim as FB_uNWINDREGION ptr listtail = curprocext->catchregionstail
	hMaybeRestrictUnwindRegion( listtail, rangeend )
	if lastonly = 0 then
		dim as FB_UNWINDREGION ptr listhead = curprocext->catchregionshead
		while listhead <> listtail
			hMaybeRestrictUnwindRegion( listhead, rangeend )
			listhead = listhead->next
		wend
	endif
end sub

'' On Error Goto 0 curtails the 'try' regions so that errors occuring after here are
'' not caught by the/any previously set handler.
function unwindMarkEndOfCatchRange(  ) as ASTNODE ptr
	'' if there isn't any data for this proc yet, or any active catch regions
	'' don't do anything
	dim as FB_PROCEXT ptr curprocext = hCurrentProcExt( 0 )
	if ( curprocext = 0 ) orelse ( curprocext->catchregionstail = 0 ) then return null
	dim as FBSYMBOL ptr labelsym = hCreateLabel( @"unwindcatchendlabel", 0 )
	'' curtail the range of the last catch
	hCurtailCatchRegions( curprocext, 1, labelsym )
	return astNewLABEL( labelsym )
end function

sub unwindThrowException( byval throwobj as FBSYMBOL ptr )
	dim as ASTNODE ptr proc = astNewCALL( PROCLOOKUP( EX_THROWERROR ) )
	if throwobj = NULL then
		'' thrown type
		astNewARG( proc, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) ) )
		'' thrown object
		astNewARG( proc, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) ) )
	else
		assert( strptr( "Throwing types not supported yet, need to figure out what type info to serialise" ) = 0 )
	end if
	astAdd( proc )
end sub

'' this sub checks all the previously encountered on error goto labels
'' and if this label is a 'catch'/on error target, a blank asm node is
'' inserted into the ast to make the generators (GCC/Gas/Gas64) forget 
'' the register state and reload them, meaning code after the
'' label won't be relying on register state from calls from the outside (libfbexcept) 
sub unwindCheckForErrorGotoLabel( byval label as FBSYMBOL ptr )
	dim as FB_PROCEXT ptr curprocext = hCurrentProcExt( 0 )
	if ( curprocext = 0 ) orelse ( curprocext->catchregionstail = 0 ) then exit sub

	dim as FB_UNWINDREGION ptr catchhead = curprocext->catchregionshead
	dim as string labelname = *symbGetMangledName( label )

	while catchhead
		if( *symbGetMangledName( catchhead->actionlabel ) = labelname ) then
			'' found it, insert the flush
			astAdd( hCreateRegisterFlushNode( ) )
			label->lbl.unwindtarget = true
			exit while
		end if
		catchhead = catchhead->next
	wend 
end sub

function unwindCurProcHasActions( ) as integer
	return unwindProcHasActions( parser.currproc )
end function

function unwindProcHasActions( byval proc as FBSYMBOL ptr ) as integer
	dim as FB_PROCEXT ptr procext = proc->proc.ext
	return procext andalso procext->coveragetablelocation <> 0
end function

function unwindGenGCCCoverageTableLabel( ) as FBSYMBOL ptr
	dim as zstring ptr labelname = @"__fb_unw_coverage_table"
	dim as FBSYMBOL ptr tablelabel = symbLookupByNameAndClass( _
		symbGetCurrentNamespc( ), _
		labelname, _
		FB_SYMBCLASS_LABEL _
	)
	if tablelabel = NULL then
		tablelabel = symbAddLabel( labelname )
	end if
	return tablelabel
end function
