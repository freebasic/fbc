#include once "vbcompat.bi"
#include once "zstr.bi"
#include once "list.bi"
#include once "file.bi"

namespace fb.file.search

	type findCtx
		mode 		as searchBy
		union
			serial 	as double
		end union
		mask 		as zstring ptr
	end type

	type intrCtx
		node		as entry ptr
	end type
	
	type CSearch_
		root 	as zstring ptr
		list	as list.CList ptr
		dirCb 	as dirCallback
		intrCtx	as intrCtx
		findCtx as findCtx
	end type

	declare sub _resetList _
		( _
			byval l as list.CList ptr _
		)

	declare function _findFiles _
		( _
			byval _this as CSearch ptr, _
			byval path as zstring ptr _
		) as integer

	'':::::
	function new_ _
		( _
			byval root as zstring ptr, _
			byval dirCb as dirCallback = NULL _
		) as CSearch ptr
	
		dim as CSearch ptr _this
		
		_this = allocate( len( CSearch ) )
		
		_this->root = zStr.Dup( root )
		_this->dirCb = dirCb
		
		_this->list = list.new_( 30, len( entry ), list.flags_NOCLEAR )
		_this->intrCtx.node = NULL
		
		function = _this
	
	end function

	'':::::
	function delete_ _
		( _
			byval _this as CSearch ptr _
		) as integer
		
		if( _this = NULL ) then
			return 0
		end if
		
		_resetList( _this->list )
		list.delete_( _this->list )
		
		zStr.del( _this->root )
		
		deallocate( _this )
		
		return -1
		
	end function

	'':::::
	function getFirst _
		( _
			byval _this as CSearch ptr _
		) as entry ptr
		
		_this->intrCtx.node = list.getHead( _this->list )
		
		function = _this->intrCtx.node
		
	end function

	'':::::
	function getNext _
		( _
			byval _this as CSearch ptr _
		) as entry ptr
		
		if( _this->intrCtx.node = NULL ) then
			return NULL
		end if
		
		_this->intrCtx.node = list.getNext( _this->intrCtx.node )
		
		function = _this->intrCtx.node
		
	end function

	'':::::
	function byDate _
		( _
			byval _this as CSearch ptr, _
			byval mask as zstring ptr, _
			byval serial as double, _
			byval mode as searchBy _
		) as integer
		
		with _this->findCtx
			.mode = mode
			.serial = serial
			.mask = mask
		end with
		
		_resetList( _this->list )
		
		function = _findFiles( _this, NULL ) > 0
		
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
			byval _this as CSearch ptr, _
			byval path as zstring ptr _
		) as integer
		
		dim as string fname, fpath
		dim as integer files = 0
		
		'' add files
		if( _this->root <> NULL ) then
			fpath = *_this->root + "/"
		end if	
		
		if( path <> NULL ) then
			fpath += *path + "/" 
		end if
			
		fname = *_this->findCtx.mask
		
		fname = dir( fpath + fname, vbNormal )
		do while len( fname ) > 0
			dim as double serial = filedatetime( fpath + fname )
				
			select case _this->findCtx.mode
			case searchBy_SerialNewer
				if( serial > _this->findCtx.serial ) then
					_addFile( _this->list, path, fname, serial )
					files += 1
				end if
			end select
			
			fname = dir( )
		loop
		
		'' collect dirs (can't use recursion here, DIR() has a global context)
		type DIRENTRY
			name	as zstring ptr
		end type
		
		dim as list.CList ptr l = list.new_( 16, len( DIRENTRY ), list.flags_NOCLEAR )
		dim as DIRENTRY ptr node = any, nxt = any
		
		fname = dir( fpath + "*.*", vbDirectory )
		do while len( fname ) > 0
			select case fname
			case ".", ".."
			
			case else
				dim as integer doAdd = iif( _this->dirCb <> NULL, _this->dirCb( path, fname ), TRUE )
				
				if( doAdd ) then
					node = list.insert( l )
					node->name = zStr.dup( fname )
				end if
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
			
			files += _findFiles( _this, fname )
			
			zStr.del( node->name )
			list.remove( l, node )
			
			node = nxt
		loop

		list.delete_( l )
		
		function = files
	
	end function

end namespace
