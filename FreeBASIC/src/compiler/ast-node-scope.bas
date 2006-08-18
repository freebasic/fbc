''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST scope and break nodes
'' scope: l = NULL; r = NULL
'' break: l = branch (used as reference, not loaded)
''
'' chng: mar/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\ast.bi"
#include once "inc\ir.bi"
#include once "inc\emit.bi"

declare function hCheckBranch			( _
										  	byval proc as ASTNODE ptr, _
										  	byval n as ASTNODE ptr _
										) as integer

declare sub 	 hDelLocals				( _
											byval n as ASTNODE ptr, _
										  	byval check_backward as integer _
										)

'':::::
function astScopeBegin _
	( _
		_
	) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as FBSYMBOL ptr s

	if( env.scope >= FB_MAXSCOPEDEPTH ) then
		return NULL
	end if

	''
	n = astNewNode( AST_NODECLASS_SCOPEBEGIN, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	s = symbAddScope( n )

	'' must update the stmt count or any internal label
	'' allocated/emitted previously will lie in the same stmt
	env.stmtcnt += 1

    '' change to scope's symbol tb
    n->sym = s
    n->block.parent = ast.currblock
	n->block.inistmt = env.stmtcnt

    astAdd( n )

	''
	env.scope += 1
	env.currblock = s
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

'':::::
function astScopeBreak _
	( _
		byval target as FBSYMBOL ptr _
	) as integer static

	dim as ASTNODE ptr n

	function = FALSE

	n = astNewNode( AST_NODECLASS_SCOPE_BREAK, INVALID, NULL )

	n->sym = target
	n->l = astNewBRANCH( AST_OP_JMP, target )
	n->break.parent = ast.currblock
	n->break.scope = env.scope
	n->break.linenum = lexLineNum( )
	n->break.stmtnum = env.stmtcnt

	hAddToBreakList( @ast.proc.curr->block.breaklist, n )

	'' the branch node is added, not the break itself, any
	'' destructor will be added before this node when
	'' processing the proc's branch list
	astAdd( n->l )

	function = TRUE

end function

'':::::
sub astScopeEnd _
	( _
		byval n as ASTNODE ptr _
	) static

	dim as FBSYMBOL ptr s

	s = n->sym

	'' must update the stmt count or any internal label
	'' allocated/emitted previously will lie in the same stmt
	env.stmtcnt += 1

	n->block.endstmt = env.stmtcnt

	'' free dynamic vars
	symbFreeScopeDynVars( s )

	'' remove symbols from hash table
	symbDelScopeTb( s )

	''
	irScopeEnd( s )

	'' back to preview symbol tb
	symbSetCurrentSymTb( s->symtb )

	ast.currblock = n->block.parent
	env.currblock = ast.currblock->sym
	env.scope -= 1

	''
	astAdd( astNewDBG( AST_OP_DBG_SCOPEEND, cint( s ) ) )

	n = astNewNode( AST_NODECLASS_SCOPEEND, INVALID )
    n->sym = s

    astAdd( n )

end sub

'':::::
function astScopeUpdBreakList _
	( _
		byval proc as ASTNODE ptr _
	) as integer static

    dim as ASTNODE ptr n

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
private function hBranchError _
	( _
		byval errnum as integer, _
		byval n as ASTNODE ptr, _
		byval s as FBSYMBOL ptr = NULL _
	) as integer static

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

	function = errReportEx( errnum, msg, n->break.linenum )

	env.clopt.showerror = showerror

end function

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
private function hCheckCrossing _
	( _
		byval n as ASTNODE ptr, _
		byval blk as FBSYMBOL ptr, _
		byval top_stmt as integer, _
		byval bot_stmt as integer _
	) as integer static

	dim as FBSYMBOL ptr s
	dim as integer stmt

	'' search for:
	'' 		goto label
	'' 		redim array(...) as type | dim obj as object() | dim str as string
	'' 		label:

    if( symbIsScope( blk ) ) then
    	s = blk->scp.symtb.head
    else
    	s = blk->proc.symtb.head
    end if

    do while( s <> NULL )
    	if( symbIsVar( s ) ) then
    		stmt = symbGetVarStmt( s )
    		if( stmt > top_stmt ) then
    			if( stmt < bot_stmt ) then
    				if( symbVarIsLocalObj( s ) ) then
    					if( hBranchError( FB_ERRMSG_BRANCHCROSSINGDYNDATADEF, n, s ) = FALSE ) then
    						return FALSE
    					end if

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

	function = TRUE

end function

'':::::
private function hCheckScopeLocals _
	( _
		byval n as ASTNODE ptr _
	) as integer static

    dim as FBSYMBOL ptr dst, blk, src_blk
    dim as integer dst_stmt, src_stmt

    dst = n->sym
    dst_stmt = symbGetLabelStmt( dst )

    src_blk = n->break.parent->sym
    src_stmt = n->break.stmtnum

    blk = symbGetLabelParent( dst )
    do
    	'' check for any var allocated between the block's
    	'' beginning and the branch
    	if( hCheckCrossing( n, blk, 0, dst_stmt ) = FALSE ) then
    		return FALSE
    	end if

    	blk = symbGetParent( blk )

    	'' same parent?
    	if( symbIsProc( blk ) or (blk = src_blk) ) then
    		'' forward?
			if( dst_stmt > src_stmt ) then
    			if( hCheckCrossing( n, blk, src_stmt, dst_stmt ) = FALSE ) then
    				return FALSE
    			end if
    		end if

    		exit do
    	end if
    loop

	function = TRUE

end function

'':::::
private function hDelBlockLocals _
	( _
		byval blk as FBSYMBOL ptr, _
		byval top_stmt as integer, _
		byval bot_stmt as integer, _
		byval base_expr as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr
	dim as integer stmt

    if( symbIsScope( blk ) ) then
    	s = blk->scp.symtb.head
    else
    	s = blk->proc.symtb.head
    end if

    do while( s <> NULL )
    	if( symbIsVar( s ) ) then
    		stmt = symbGetVarStmt( s )
    		if( stmt > top_stmt ) then
    			if( stmt < bot_stmt ) then
   					if( symbVarIsLocalDyn( s ) ) then
                    	expr = symbFreeDynVar( s )
                    	if( expr <> NULL ) then
                    		astAddBefore( expr, base_expr )
                    		base_expr = expr
                    	end if
    				end if
    			end if
    		end if
    	end if

    	s = s->next
    loop

    function = base_expr

end function

'':::::
private sub hDelBackwardLocals _
	( _
		byval n as ASTNODE ptr _
	)

    '' free any dyn var allocated between the block's
    '' beginning and the branch
    hDelBlockLocals( n->break.parent->sym, _
    				 symbGetLabelStmt( n->sym ), _
    				 n->break.stmtnum, _
    				 n->l )

end sub


#define hisInside( blk, lbl_stmt ) _
	iif( lbl_stmt < blk->block.inistmt, FALSE, lbl_stmt < blk->block.endstmt )


'':::::
private sub hDelLocals _
	( _
		byval n as ASTNODE ptr, _
		byval check_backward as integer _
	) static

	dim as FBSYMBOL ptr s
	dim as integer dst_stmt, src_stmt
	dim as ASTNODE ptr blk, expr

	dst_stmt = symbGetLabelStmt( n->sym )
	src_stmt = n->break.stmtnum

    expr = n->l

    blk = n->break.parent
    do
    	'' free any dyn var allocated between the block's
    	'' beginning and the branch
    	expr = hDelBlockLocals( blk->sym, 0, src_stmt, expr )

    	blk = blk->block.parent
    	if( blk = NULL ) then
    		exit do
    	end if

    	'' target label found?
    	if( hIsInside( blk, dst_stmt ) ) then
    		if( check_backward ) then
    			'' if backward, free any dyn var allocated
    			'' between the target label and the branch
				if( dst_stmt <= src_stmt ) then
    				hDelBlockLocals( blk->sym, dst_stmt, src_stmt, expr )
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
	if( (proc->attrib and (FB_SYMBATTRIB_MAINPROC or _
						   FB_SYMBATTRIB_MODLEVELPROC)) <> 0 ) then

		function = symbGetParent( label ) <> NULL

	else
		function = symbGetParent( label ) <> proc
	end if

end function

'':::::
private function hCheckBranch _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer static

    dim as ASTNODE ptr src_parent
    dim as FBSYMBOL ptr dst, dst_parent
    dim as integer src_scope, dst_scope, src_stmt, dst_stmt, isparent

	function = FALSE

    dst = n->sym

    '' not declared?
    if( symbGetLabelIsDeclared( dst ) = FALSE ) then
    	hBranchError( FB_ERRMSG_BRANCHTARTGETOUTSIDECURRPROC, n )
    	exit function
    end if

	'' branching to other procs or mod-level?
    if( hIsTargetOutside( proc->sym, dst ) ) then
    	hBranchError( FB_ERRMSG_BRANCHTARTGETOUTSIDECURRPROC, n )
        exit function
    end if

    ''
    dst_scope = symbGetScope( dst )
    dst_parent = symbGetLabelParent( dst )
    dst_stmt = symbGetLabelStmt( dst )

    src_scope = n->break.scope
    src_parent = n->break.parent
    src_stmt = n->break.stmtnum

    '' inside parent?
    if( hIsInside( src_parent, dst_stmt ) ) then
    	'' jumping to a child block?
    	if( dst_scope > src_scope ) then
           	'' any locals?
			if( hCheckScopeLocals( n ) = FALSE ) then
       			if( errGetLast( ) <> FB_ERRMSG_OK ) then
       				exit function
       			end if
       		end if

    		'' backward?
    		if( dst_stmt <= src_stmt ) then
    			hDelBackwardLocals( n )
    		end if

    	'' same level..
    	else
    		'' backward?
    		if( dst_stmt <= src_stmt ) then
    			hDelBackwardLocals( n )

    		'' forward..
    		else
    			'' crossing any declaration?
    			if( hCheckCrossing( n, dst_parent, src_stmt, dst_stmt ) = FALSE ) then
       				if( errGetLast( ) <> FB_ERRMSG_OK ) then
       					exit function
       				end if
    			end if
    		end if
    	end if

    	return TRUE
    end if

    '' outside..

   	'' jumping to a scope block?
	if( symbIsScope( dst_parent ) ) then
		isparent = (dst_parent->scp.backnode->block.inistmt <= _
					src_parent->block.inistmt) and _
  	    		   (dst_parent->scp.backnode->block.endstmt >= _
  	    		    src_parent->block.endstmt)

		'' not a parent block?
        if( isparent = FALSE ) then
			'' any locals?
			if( hCheckScopeLocals( n ) = FALSE ) then
       			if( errGetLast( ) <> FB_ERRMSG_OK ) then
       				exit function
       			end if
       		end if
       	end if

   	'' proc level..
   	else
   		isparent = TRUE
   	end if

   	if( isparent ) then
   	   	'' forward?
   		if( dst_stmt > src_stmt ) then
   			'' crossing any declaration?
   			if( hCheckCrossing( n, dst_parent, src_stmt, dst_stmt ) = FALSE ) then
       			if( errGetLast( ) <> FB_ERRMSG_OK ) then
       				exit function
       			end if
   			end if
   		end if
   	end if

   	'' jumping out, free any dyn var already allocated
   	'' until the target block if reached
   	hDelLocals( n, TRUE )

	function = TRUE

end function

dim shared cnt as integer = 0

'':::::
function astLoadSCOPEBEGIN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr static

    dim as FBSYMBOL ptr s

	s = n->sym

	s->scp.emit.baseofs = emitGetLocalOfs( env.currproc )

	symbScopeAllocLocals( s )

	if( ast.doemit ) then
		irEmitSCOPEBEGIN( s )
	end if

	function = NULL

end function

'':::::
function astLoadSCOPEEND _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr static

    dim as FBSYMBOL ptr s

    s = n->sym

	if( ast.doemit ) then
		irEmitSCOPEEND( s )
	end if

    emitSetLocalOfs( env.currproc, s->scp.emit.baseofs )

    function = NULL

end function

