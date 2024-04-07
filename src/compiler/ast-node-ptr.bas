'' AST deref pointer nodes
'' l = pointer expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

function astNewDEREF _
	( _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	if( l <> NULL ) then
		if( dtype = FB_DATATYPE_INVALID ) then
			dtype = typeDeref( astGetFullType( l ) )
			subtype = astGetSubType( l )
		end if

		if( ofs = 0 ) then
			'' skip any casting if they won't do any conversion
			dim as ASTNODE ptr t = astSkipNoConvCAST( l )

			'' convert *@ to nothing
			dim as integer delchild = any
			select case t->class
			case AST_NODECLASS_ADDROF
				delchild = TRUE

			case AST_NODECLASS_OFFSET
				delchild = (t->ofs.ofs = 0)

			case AST_NODECLASS_PTRCHK

				'' convert *PTRCHK(@expr) to (expr)
				'' TODO: remove null-ptr checks in ptr indexing

				if( (t->l->class = AST_NODECLASS_ADDROF) or _
					(t->l->class = AST_NODECLASS_OFFSET and t->l->ofs.ofs = 0) ) then

					'' delete the null ptr check func call
					astDelTree( t->r )

					'' move to ADDROF/OFFSET node
					t = t->l

					delchild = TRUE
				else
					delchild = FALSE
				end if

			case else
				delchild = FALSE
			end select

			''
			if( delchild ) then

				n = t->l

				'' astSkipNoConvCAST() and removing the null pointer check
				'' may have skipped multiple nodes
				'' delete all nodes from L to T (up to but not including N)

				while( l <> n )
					t = l->l
					astDelNode( l )
					l = t
				wend

				astSetType( n, dtype, subtype )
				return n
			end if
		end if

		if( astIsCONST( l ) ) then
			ofs += astConstFlushToInt( l )
			l = NULL
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DEREF, dtype, subtype )

	n->l = l    '' Can be NULL e.g. if it was a constant
	n->ptr.ofs = ofs

	function = n
end function

function astLoadDEREF( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as ASTNODE ptr l = any
	dim as IRVREG ptr v1 = any, vp = any, vr = any

	l = n->l
	'' no index? can happen with absolute addresses + ptr typecasting
	if( l = NULL ) then
		if( ast.doemit ) then
			vr = irAllocVRPTR( astGetFullType( n ), n->subtype, n->ptr.ofs, NULL )
			vr->vector = n->vector
		end if
		return vr
	end if

	v1 = astLoad( l )

	''
	if( ast.doemit ) then
		'' src is not a reg?
		if( (irIsREG( v1 ) = FALSE) or _
			(typeGetClass(v1->dtype) <> FB_DATACLASS_INTEGER) or _
			(typeGetSize(v1->dtype) <> env.pointersize) ) then

			vp = irAllocVREG( typeAddrOf( astGetFullType( n ) ), n->subtype )
			irEmitADDR( AST_OP_DEREF, v1, vp )
		else
			vp = v1
		end if

		vr = irAllocVRPTR( astGetFullType( n ), n->subtype, n->ptr.ofs, vp )
		vr->vector = n->vector
	end if

	astDelNode( l )

	function = vr
end function
