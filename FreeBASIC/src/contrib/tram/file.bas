option explicit

#include once "vbcompat.bi"
#include once "zstr.bi"
#include once "list.bi"
#include once "file.bi"

#define NULL 0

namespace fb.file.search

	type CSearch_
		root 	as zstring ptr
		list	as list.CList ptr
		intNode	as entry ptr
	end type

	type findCtx
		mode 		as searchBy
		union
			serial 	as double
		end union
		mask 		as zstring ptr
		list		as list.CList ptr
	end type
	
	declare sub _resetList _
		( _
			byval l as list.CList ptr _
		)

	declare function _findFiles _
		( _
			byval ctx as findCtx ptr, _
			byval root as zstring ptr, _
			byval path as zstring ptr _
		) as integer

	'':::::
	function new _
		( _
			byval root as zstring ptr _
		) as CSearch ptr
	
		dim as CSearch ptr _this
		
		_this = allocate( len( CSearch ) )
		
		_this->root = zStr.Dup( root )
		_this->list = list.new( 30, len( entry ), list.flags_NOCLEAR )
		_this->intNode = NULL
		
		function = _this
	
	end function

	'':::::
	function delete _
		( _
			byval _this as CSearch ptr _
		) as integer
		
		if( _this = NULL ) then
			return 0
		end if
		
		_resetList( _this->list )
		list.delete( _this->list )
		
		zStr.del( _this->root )
		
		deallocate( _this )
		
		return -1
		
	end function

	'':::::
	function getFirst _
		( _
			byval _this as CSearch ptr _
		) as entry ptr
		
		_this->intNode = list.getHead( _this->list )
		
		function = _this->intNode
		
	end function

	'':::::
	function getNext _
		( _
			byval _this as CSearch ptr _
		) as entry ptr
		
		if( _this->intNode = NULL ) then
			return NULL
		end if
		
		_this->intNode = list.getNext( _this->intNode )
		
		function = _this->intNode
		
	end function

	'':::::
	function byDate _
		( _
			byval _this as CSearch ptr, _
			byval mask as zstring ptr, _
			byval serial as double, _
			byval mode as searchBy _
		) as integer
		
		dim as findCtx f = any
		
		with f
			.mode = mode
			.serial = serial
			.mask = mask
			.list = _this->list
		end with
		
		_resetList( _this->list )
		
		function = _findFiles( @f, _this->root, NULL ) > 0
		
	end function
	
	'':::::
	private sub _resetList _
		( _
			byval l as list.CList ptr _
		)
		
		dim as entry ptr n = any, nxt = any
		
		n = list.getHead( l )
		do while( n <> NULL )
			
			zstr.del( n->path )
			zstr.del( n->name )
			
			nxt = fb.list.getNext( n )
			list.remove( l, n )
			n = nxt
		loop
		
	end sub
	
	'':::::
	private function _addFile _
		( _
			byval l as list.CList ptr, _
			byval path as zstring ptr, _
			byval fname as zstring ptr, _
			byval serial as double _
		) as entry ptr
		
		dim as entry ptr n = any
		
		n = list.insert( l )
		
		if( path <> NULL ) then
			n->path = zstr.dup( path )
		else
			n->path = NULL
		end if
		n->name = zstr.dup( fname )
		n->serial = serial
		
		function = n
		
	end function
	
	'':::::
	private function _findFiles _
		( _
			byval ctx as findCtx ptr, _
			byval root as zstring ptr, _
			byval path as zstring ptr _
		) as integer
		
		dim as string fname, fpath
		dim as integer files = 0
		
		'' add files
		if( root <> NULL ) then
			fpath = *root + "/"
		end if	
		
		if( path <> NULL ) then
			fpath += *path + "/" 
		end if
			
		fname = *ctx->mask
		
		fname = dir( fpath + fname, vbNormal )
		do while len( fname ) > 0
			dim as double serial = filedatetime( fpath + fname )
				
			select case ctx->mode
			case searchBy_SerialNewer
				if( serial > ctx->serial ) then
					_addFile( ctx->list, path, fname, serial )
					files += 1
				end if
			end select
			
			fname = dir( )
		loop
		
		'' collect dirs (can't use recursion here, DIR() has a global context)
		type DIRENTRY
			name	as zstring ptr
		end type
		
		dim as list.CList ptr l = list.new( 16, len( DIRENTRY ), list.flags_NOCLEAR )
		dim as DIRENTRY ptr node = any, nxt = any
		
		fname = dir( fpath + "*.*", vbDirectory )
		do while len( fname ) > 0
			select case fname
			case ".", ".."
			
			case else
				node = list.insert( l )
				node->name = zStr.dup( fname )
			end select
			
			fname = dir( )
		loop
		
		'' recurse
		node = list.getHead( l )
		do while( node <> NULL )
			nxt = list.getNext( node )
			
			if( path <> NULL ) then
				fname = *path + "/"
			else
				fname = ""
			end if
			fname += *node->name
			
			files += _findFiles( ctx, root, fname )
			
			zStr.del( node->name )
			list.remove( l, node )
			
			node = nxt
		loop

		list.delete( l )
		
		function = files
	
	end function

end namespace