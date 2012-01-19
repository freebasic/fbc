'' AST scope and break nodes
'' scope: l = NULL; r = NULL
'' break: l = branch (used as reference, not loaded)
''
'' chng: mar/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "ir.bi"

declare function hCheckBranch _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer

declare sub hDelLocals _
	( _
		byval n as ASTNODE ptr, _
		byval check_backward as integer _
	)

declare sub hDestroyVars _
	( _
		byval scp as FBSYMBOL ptr _
	)

'':::::
function astScopeBegin _
	( _
		_
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as FBSYMBOL ptr s = any

	if( parser.scope >= FB_MAXSCOPEDEPTH ) then
		return NULL
	end if

	''
	n = astNewNode( AST_NODECLASS_SCOPEBEGIN, FB_DATATYPE_INVALID )

    n = astAdd( n )

	''
	s = symbAddScope( n )

    '' change to scope's symbol tb
    n->sym = s
    n->block.parent = ast.currblock
	n->block.inistmt = parser.stmt.cnt

	'' must update the stmt count or any internal label
	'' allocated/emitted previously will lie in the same stmt
	parser.stmt.cnt += 1

	''
	parser.scope += 1
	parser.currblock = s
    ast.currblock = n

	symbSetCurrentSymTb( @s->scp.symtb )

	''
	irScopeBegin( s )

	''
	astAdd( astNewDBG( AST_OP_DBG_SCOPEINI, cint( s ) ) )

	function = n

end function

'':::::
private sub hAddToBreakList _
	( _
		byval list as AST_BREAKLIST ptr, _
		byval node as ASTNODE ptr _
	) static

	if( list->tail <> NULL ) then
		list->tail->next = node
	else
		list->head = node
	end if

	node->prev = list->tail
	node->next = NULL
	list->tail = node

end sub

sub astScopeBreak(byval target as FBSYMBOL ptr)
	dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_SCOPE_BREAK, FB_DATATYPE_INVALID, NULL )

	n->sym = target
	n->break.parent = ast.currblock
	n->break.scope = parser.scope
	n->break.linenum = lexLineNum( )
	n->break.stmtnum = parser.stmt.cnt

	'' the branch node is added, not the break itself, any
	'' destructor will be added before this node when
	'' processing the proc's branch list
	n->l = astAdd( astNewBRANCH( AST_OP_JMP, target ) )

	hAddToBreakList( @ast.proc.curr->block.breaklist, n )
end sub

'':::::
sub astScopeEnd _
	( _
		byval n as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr s = any

	s = n->sym

	'' must update the stmt count or any internal label
	'' allocated/emitted previously will lie in the same stmt
	parser.stmt.cnt += 1

	n->block.endstmt = parser.stmt.cnt

	'' free dynamic vars
	hDestroyVars( s )

	'' remove symbols from hash table
	symbDelScopeTb( s )

	''
	irScopeEnd( s )

	'' back to preview symbol tb
	symbSetCurrentSymTb( s->symtb )

	ast.currblock = n->block.parent
	parser.currblock = ast.currblock->sym
	parser.scope -= 1

	''
	astAdd( astNewDBG( AST_OP_DBG_SCOPEEND, cint( s ) ) )

	n = astNewNode( AST_NODECLASS_SCOPEEND, FB_DATATYPE_INVALID )

    n = astAdd( n )

    n->sym = s

end sub

'':::::
function astScopeUpdBreakList _
	( _
		byval proc as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n = any

    function = FALSE

    '' for each break in this proc..
    n = proc->block.breaklist.head
    do while( n <> NULL )

    	'' EXIT SUB | FUNCTION?
    	if( n->sym = proc->block.exitlabel ) then
    		'' special case due the non implicit scope block, that
    		'' can't be created for procs because the implicit
    		'' main() function
    		hDelLocals( n, FALSE )

		else
			if( hCheckBranch( proc, n ) = FALSE ) then
				exit function
			end if
		end if

        '' next
    	n = n->next
    loop

    function = TRUE

end function

'':::::
private sub hBranchError _
	( _
		byval errnum as integer, _
		byval n as ASTNODE ptr, _
		byval s as FBSYMBOL ptr = NULL _
	) static

	dim as integer showerror
	dim as string msg

	showerror = env.clopt.showerror
	env.clopt.showerror = FALSE

	if( symbGetName( n->sym ) <> NULL ) then
		msg = "to label: " + *symbGetName( n->sym )
		if( s <> NULL ) then
			msg += ", "
		end if
	end if

	if( s <> NULL ) then
		msg += "local "
		if( symbGetType( s ) = FB_DATATYPE_STRING ) then
			msg += "string: "
		elseif( symbGetArrayDimensions( s ) <> 0 ) then
			msg += "array: "
		else
			msg += "object: "
		end if

		msg += *symbGetName( s )
	end if

	errReportEx( errnum, msg, n->break.linenum )

	env.clopt.showerror = showerror
end sub

'':::::
private sub hBranchWarning _
	( _
		byval errnum as integer, _
		byval n as ASTNODE ptr, _
		byval s as FBSYMBOL ptr = NULL _
	) static

	dim as integer showerror
	dim as string msg

	showerror = env.clopt.showerror
	env.clopt.showerror = FALSE

	if( symbGetName( n->sym ) <> NULL ) then
		msg = "to label: " + *symbGetName( n->sym )
		if( s <> NULL ) then
			msg += ", "
		end if
	end if

	if( s <> NULL ) then
		msg += "variable: "
		msg += *symbGetName( s )
	end if

	errReportWarnEx( errnum, msg, n->break.linenum )

	env.clopt.showerror = showerror

end sub

'':::::
private function hFindCommonParent _
	( _
		byval branch_parent as ASTNODE ptr, _
		byval label_parent_sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as ASTNODE ptr label_parent = label_parent_sym->scp.backnode

	dim as integer branch_scope = symbGetScope( branch_parent->sym )
	dim as integer label_scope = symbGetScope( label_parent_sym )

	if( branch_scope > label_scope ) then
		do
			branch_parent = branch_parent->block.parent
			branch_scope = symbGetScope( branch_parent->sym )
		loop until( branch_scope = label_scope )

	elseif( branch_scope < label_scope ) then
		do
			label_parent = label_parent->block.parent
			label_scope = symbGetScope( label_parent->sym )
		loop until( label_scope = branch_scope )
	end if

	do until( branch_parent = label_parent )
		branch_parent = branch_parent->block.parent
		label_parent = label_parent->block.parent
	loop

	function = branch_parent->sym

end function

private sub hCheckCrossing _
	( _
		byval n as ASTNODE ptr, _
		byval blk as FBSYMBOL ptr, _
		byval top_stmt as integer, _
		byval bot_stmt as integer _
	)

	dim as FBSYMBOL ptr s = any
	dim as integer stmt = any

	'' search for:
	'' 		goto label
	'' 		redim array(...) as type | dim obj as object() | dim str as string
	'' 		label:

    if( symbIsScope( blk ) ) then
    	s = symbGetScopeSymbtb( blk ).head
    else
    	s = symbGetProcSymbtb( blk ).head
    end if

    do while( s <> NULL )
    	if( symbIsVar( s ) ) then
    		stmt = symbGetVarStmt( s )
    		if( stmt > top_stmt ) then
    			if( stmt < bot_stmt ) then
    				if( symbGetVarHasCtor( s ) ) then
						hBranchError( FB_ERRMSG_BRANCHCROSSINGDYNDATADEF, n, s )

    				else
    					'' not static, shared or temp?
    					if( (s->attrib and (FB_SYMBATTRIB_STATIC or _
    										FB_SYMBATTRIB_SHARED or _
    										FB_SYMBATTRIB_TEMP)) = 0 ) then
    						'' must be cleaned?
    						if( symbGetDontInit( s ) = FALSE ) then
    							hBranchWarning( FB_WARNINGMSG_BRANCHCROSSINGLOCALVAR, n, s )
    						end if
    					end if
    				end if
    			end if
    		end if
    	end if

    	s = s->next
    loop
end sub

private sub hCheckScopeLocals _
	( _
		byval n as ASTNODE ptr, _
		byval top_parent as FBSYMBOL ptr = NULL _
	)

    dim as FBSYMBOL ptr label = any, blk = any
    dim as integer label_stmt = any, branch_stmt = any

    if( top_parent = NULL ) then
    	top_parent = n->break.parent->sym
    end if

    branch_stmt = n->break.stmtnum

    label = n->sym
    label_stmt = symbGetLabelStmt( label )

    blk = symbGetLabelParent( label )
    do
		'' check for any var allocated between the block's
		'' beginning and the branch
		hCheckCrossing( n, blk, 0, label_stmt )

		if( symbGetSymbtb( blk ) = NULL ) then
			exit do
		end if

		blk = symbGetParent( blk )

		'' same parent?
		if( blk = top_parent ) then
			'' forward?
			if( label_stmt > branch_stmt ) then
				hCheckCrossing( n, blk, branch_stmt, label_stmt )
			end if
			exit do
		end if
	loop
end sub

'':::::
private sub hDestroyBlockLocals _
	( _
		byval blk as FBSYMBOL ptr, _
		byval top_stmt as integer, _
		byval bot_stmt as integer, _
		byval base_expr as ASTNODE ptr _	'' the node before the branch, not itself!
	)

	dim as FBSYMBOL ptr s = any
	dim as ASTNODE ptr expr = any
	dim as integer stmt = any

    '' for each now (in reverse order)
    if( symbIsScope( blk ) ) then
    	s = symbGetScopeSymbTb( blk ).tail
    else
    	s = symbGetProcSymbTb( blk ).tail
    end if

    do while( s <> NULL )
    	if( symbIsVar( s ) ) then
    		stmt = symbGetVarStmt( s )
    		if( stmt > top_stmt ) then
    			if( stmt < bot_stmt ) then
                    '' has a dtor?
                    if( symbGetVarHasDtor( s ) ) then
                    	'' call it..
                    	expr = astBuildVarDtorCall( s, TRUE )
                    	if( expr <> NULL ) then
                    		base_expr = astAddAfter( expr, base_expr )
                    	end if
                    end if
    			end if
    		end if
    	end if

    	s = s->prev
    loop

end sub

'':::::
private sub hDelBackwardLocals _
	( _
		byval n as ASTNODE ptr _
	)

    '' free any dyn var allocated between the block's
    '' beginning and the branch
    hDestroyBlockLocals( n->break.parent->sym, _
    				 	 symbGetLabelStmt( n->sym ), _
    				 	 n->break.stmtnum, _
    				 	 astGetPrev( n->l ) )

end sub


#define hisInside( blk, lbl_stmt ) _
	( (lbl_stmt) >= (blk)->block.inistmt andalso (lbl_stmt) < (blk)->block.endstmt)


'':::::
private sub hDelLocals _
	( _
		byval n as ASTNODE ptr, _
		byval check_backward as integer _
	)

	dim as FBSYMBOL ptr s = any
	dim as integer label_stmt = any, branch_stmt = any
	dim as ASTNODE ptr blk = any

	label_stmt = symbGetLabelStmt( n->sym )
	branch_stmt = n->break.stmtnum

    '' for each parent (starting from the branch ones)
    blk = n->break.parent
    do
    	'' destroy any var created between the beginning of
    	'' the block and the branch
    	hDestroyBlockLocals( blk->sym, _
    						 0, _
    						 branch_stmt, _
    						 astGetPrev( n->l ) ) '' prev node will change

    	blk = blk->block.parent
    	if( blk = NULL ) then
    		exit do
    	end if

    	'' target label found?
    	if( hIsInside( blk, label_stmt ) ) then
    		if( check_backward ) then
    			'' if backward, free any dyn var allocated
    			'' between the target label and the branch
				if( label_stmt <= branch_stmt ) then
    				hDestroyBlockLocals( blk->sym, _
    									 label_stmt, _
    									 branch_stmt, _
    									 astGetPrev( n->l ) )
    			end if
    		end if

    		exit do
    	end if
    loop

end sub

'':::::
private function hIsTargetOutside _
	( _
		byval proc as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr _
	) as integer

	'' main?
	if( (proc->stats and (FB_SYMBSTATS_MAINPROC or _
						  FB_SYMBSTATS_MODLEVELPROC)) <> 0 ) then

		function = symbGetParent( label ) <> @symbGetGlobalNamespc( )

	else
		function = symbGetParent( label ) <> proc
	end if

end function

'':::::
private function hCheckBranch _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr branch_parent = any
    dim as FBSYMBOL ptr label = any, label_parent = any
    dim as integer branch_scope = any, label_scope = any
    dim as integer branch_stmt = any, label_stmt = any, isparent = any

	function = FALSE

    label = n->sym

    '' not declared?
    if( symbGetLabelIsDeclared( label ) = FALSE ) then
    	hBranchError( FB_ERRMSG_BRANCHTARGETOUTSIDECURRPROC, n )
    	exit function
    end if

	'' branching to other procs or mod-level?
    if( hIsTargetOutside( proc->sym, label ) ) then
    	hBranchError( FB_ERRMSG_BRANCHTARGETOUTSIDECURRPROC, n )
        exit function
    end if

    ''
    label_scope = symbGetScope( label )
    label_parent = symbGetLabelParent( label )
    label_stmt = symbGetLabelStmt( label )

    branch_scope = n->break.scope
    branch_parent = n->break.parent
    branch_stmt = n->break.stmtnum

    '' inside parent?
    if( hIsInside( branch_parent, label_stmt ) ) then
    	'' jumping to a child block?
    	if( label_scope > branch_scope ) then
           	'' any locals?
			hCheckScopeLocals( n )

    		'' backward?
    		if( label_stmt <= branch_stmt ) then
    			hDelBackwardLocals( n )
    		end if

    	'' same level..
    	else
    		'' backward?
    		if( label_stmt <= branch_stmt ) then
    			hDelBackwardLocals( n )

    		'' forward..
    		else
    			'' crossing any declaration?
				hCheckCrossing( n, label_parent, branch_stmt, label_stmt )
    		end if
    	end if

    	return TRUE
    end if

    '' outside..

   	'' jumping to a scope block?
	if( symbIsScope( label_parent ) ) then
		isparent = (label_parent->scp.backnode->block.inistmt <= _
					branch_parent->block.inistmt) and _
  	    		   (label_parent->scp.backnode->block.endstmt >= _
  	    		    branch_parent->block.endstmt)

		'' not a parent block?
        if( isparent = FALSE ) then
			'' any locals?
			hCheckScopeLocals( n, hFindCommonParent( branch_parent, label_parent ) )
       	end if

   	'' proc level..
   	else
   		isparent = TRUE
   	end if

   	if( isparent ) then
   	   	'' forward?
   		if( label_stmt > branch_stmt ) then
   			'' crossing any declaration?
				hCheckCrossing( n, label_parent, branch_stmt, label_stmt )
   		end if
   	end if

   	'' jumping out, free any dyn var already allocated
   	'' until the target block if reached
   	hDelLocals( n, TRUE )

	function = TRUE

end function

'':::::
private sub hDestroyVars _
	( _
		byval scp as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr s = any

	'' for each symbol declared inside the SCOPE block (in reverse order)..
	s = symbGetScopeSymbTb( scp ).tail
    do while( s <> NULL )
    	'' variable?
    	if( symbGetClass( s ) = FB_SYMBCLASS_VAR ) then
			'' has a dtor?
			if( symbGetVarHasDtor( s ) ) then
    			astAdd( astBuildVarDtorCall( s, TRUE ) )
    		end if
    	end if

    	s = s->prev
    loop

end sub

sub astScopeAllocLocals(byval symtbhead as FBSYMBOL ptr)
	'' Used for both scope and proc locals/statics

	'' For the C emitter, let static vars be allocated here too, so they're
	'' emitted inside the procedure. The irProcAllocStaticVars() later does
	'' nothing.
	'' Otherwise for the ASM emitter, ignore static vars here via the
	'' filter mask; irProcAllocStaticVars() will handle them later.
	dim as integer mask = any
	if (irGetOption(IR_OPT_HIGHLEVEL)) then
		mask = FB_SYMBATTRIB_SHARED
	else
		mask = FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
	end if

	dim as FBSYMBOL ptr s = symtbhead
	while (s)
		'' non-shared/static variable?
		if (symbIsVar(s) andalso ((s->attrib and mask) = 0)) then
			'' Procedure parameter?
			if (symbIsParam(s)) then
				s->ofs = irProcAllocArg(parser.currproc, s, iif(symbIsParamByVal(s), s->lgt, FB_POINTERSIZE))
			else
				s->ofs = irProcAllocLocal(parser.currproc, s, s->lgt * symbGetArrayElements(s))
			end if
			symbSetVarIsAllocated(s)
		end if
		s = s->next
	wend
end sub

'':::::
function astLoadSCOPEBEGIN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as FBSYMBOL ptr s = any

	s = n->sym

	s->scp.emit.baseofs = symbGetProcLocalOfs( parser.currproc )

	if( ast.doemit ) then
		irEmitSCOPEBEGIN( s )
	end if

	astScopeAllocLocals(symbGetScopeSymbTbHead(s))

	function = NULL

end function

'':::::
function astLoadSCOPEEND _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as FBSYMBOL ptr s = any

    s = n->sym

	if( ast.doemit ) then
		irEmitSCOPEEND( s )
	end if

    symbSetProcLocalOfs( parser.currproc, s->scp.emit.baseofs )

    function = NULL

end function


