/' Copyright (c) 2007 Scott Lembcke
 ' 
 ' Permission is hereby granted, free of charge, to any person obtaining a copy
 ' of this software and associated documentation files (the "Software"), to deal
 ' in the Software without restriction, including without limitation the rights
 ' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 ' copies of the Software, and to permit persons to whom the Software is
 ' furnished to do so, subject to the following conditions:
 ' 
 ' The above copyright notice and this permission notice shall be included in
 ' all copies or substantial portions of the Software.
 ' 
 ' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 ' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 ' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 ' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 ' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 ' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 ' SOFTWARE.
 '/

'// The spatial hash is Chipmunk's default (and currently only) spatial index type.
'// Based on a chained hash table.

'// Used internally to track objects added to the hash
type cpHandle
	'// Pointer to the object
	as any ptr obj
	'// Retain count
	as integer retain
	'// Query stamp. Used to make sure two objects
	'// aren't identified twice in the same query.
	as integer stamp
end type

'// Linked list element for in the chains.
type cpSpaceHashBin
	as cpHandle ptr handle
	as cpSpaceHashBin ptr _next;
end type

'// BBox callback. Called whenever the hash needs a bounding box from an object.
type cpSpaceHashBBFunc as function( byval obj as any ptr ) as cpBB

type cpSpaceHash
	'// Number of cells in the table.
	as integer numcells
	'// Dimentions of the cells.
	as cpFloat celldim
	
	'// BBox callback.
	as cpSpaceHashBBFunc bbfunc

	'// Hashset of all the handles.
	as cpHashSet ptr handleSet
	
	as cpSpaceHashBin ptr ptr table
	'// List of recycled bins.
	as cpSpaceHashBin ptr bins

	'// Incremented on each query. See cpHandle.stamp.
	as integer stamp
end type

'//Basic allocation/destruction functions.
declare function cpSpaceHashAlloc() as cpSpaceHash ptr
declare function cpSpaceHashInit( byval hash as cpSpaceHash ptr, byval celldim as cpFloat, byval cells as integer, byval bbfunc as cpSpaceHashBBFunc ) as cpSpaceHash ptr
declare function cpSpaceHashNew( byval celldim as cpFloat, byval cells as integer, byval bbfunc as cpSpaceHashBBFunc ) as cpSpaceHash ptr

declare sub cpSpaceHashDestroy( byval hash as cpSpaceHash ptr )
declare sub cpSpaceHashFree( byval hash as cpSpaceHash ptr )

'// Resize the hashtable. (Does not rehash! You must call cpSpaceHashRehash() if needed.)
declare sub cpSpaceHashResize( byval hash as cpSpaceHash ptr, byval celldim as cpFloat, byval numcells as integer )

'// Add an object to the hash.
declare sub cpSpaceHashInsert( byval hash as cpSpaceHash ptr, byval obj as any ptr, byval id as uinteger, byval bb as cpBB )
'// Remove an object from the hash.
declare sub cpSpaceHashRemove( byval hash as cpSpaceHash ptr, byval obj as any ptr, byval id as uinteger )

'// Iterator function
type cpSpaceHashIterator as sub( byval obj as any ptr, byval data_ as any ptr )
'// Iterate over the objects in the hash.
declare sub cpSpaceHashEach( byval hash as cpSpaceHash, byval func as cpSpaceHashIterator, byval data_ as any ptr )

'// Rehash the contents of the hash.
declare sub cpSpaceHashRehash( byval hash as cpSpaceHash ptr )
'// Rehash only a specific object.
declare sub cpSpacehashRehashObject( byval hash as cpSpaceHash ptr, byval obj as any ptr, byval id as uinteger )

'// Query callback.
type cpSpaceHashQueryFunc as sub( byval obj1 as any ptr, byval obj2 as any ptr, byval data_ as any ptr )
'// Point query the hash. A reference to the query point is passed as obj1 to the query callback.
declare sub cpSpaceHashPointQuery( byval hash as cpSpaceHash ptr, byval point_ as cpVect, byval func as cpSpaceHashQueryFunc, byval data_ as any ptr )
'// Query the hash for a given BBox.
declare sub cpSpaceHashQuery( byval hash as cpSpaceHash ptr, byval obj as any ptr, byval bb as cpBB, byval func as cpSpaceHashQueryFunc, byval data_ as any ptr )
'// Run a query for the object, then insert it. (Optimized case)
declare sub cpSpaceHashQueryInsert( byval hash as cpSpaceHash ptr, byval obj as any ptr, byval bb as cpBB, byval func as cpSpaceHashQueryFunc, byval data_ as any ptr )
'// Rehashes while querying for each object. (Optimized case) 
declare sub cpSpaceHashQueryRehash( byval hash as cpSpaceHash ptr, byval func as cpSpaceHashQueryFunc, byval data_ as any ptr )
