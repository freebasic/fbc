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
 
'// cpHashSet uses a chained hashtable implementation.
'// Other than the transformation functions, there is nothing fancy going on.

'// cpHashSetBin's form the linked lists in the chained hash table.
type cpHashSetBin 
	'// Pointer to the element.
	 as any ptr elt
	'// Hash value of the element.
	as uinteger hash
	'// Next element in the chain.
	as cpHashSetBin ptr _next
end type

'// Equality function. Returns true if ptr is equal to elt.
type cpHashSetEqlFunc as function( byval ptr_ as any ptr, byval elt as any ptr ) as integer
'// Used by cpHashSetInsert(). Called to transform the ptr into an element.
type cpHashSetTransFunc as function( byval ptr_ as any ptr, byval data_ as any ptr ) as any ptr
'// Iterator function for a hashset.
type cpHashSetIterFunc as sub( byval elt as any ptr, byval data_ as any ptr )
'// Reject function. Returns true if elt should be dropped.
type cpHashSetRejectFunc as function( byval elt as any ptr, byval data_ as any ptr ) as integer

type cpHashSet
	'// Number of elements stored in the table.
	as integer entries
	'// Number of cells in the table.
	as integer size
	
	as cpHashSetEqlFunc eql
	as cpHashSetTransFunc trans_
	
	'// Default value returned by cpHashSetFind() when no element is found.
	'// Defaults to NULL.
	as any ptr default_value
	
	as cpHashSetBin ptr ptr table
end type

'// Basic allocation/destruction functions.
void cpHashSetDestroy(cpHashSet *set);
void cpHashSetFree(cpHashSet *set);

cpHashSet *cpHashSetAlloc(void);
cpHashSet *cpHashSetInit(cpHashSet *set, int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);
cpHashSet *cpHashSetNew(int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);

'// Insert an element into the set, returns the element.
'// If it doesn't already exist, the transformation function is applied.
declare function cpHashSetInsert( byval set as cpHashSet ptr, byval hash as uinteger, byval ptr_ as any ptr, byval data_ as any ptr ) as any ptr
'// Remove and return an element from the set.
declare function cpHashSetRemove( byval set as cpHashSet ptr, byval hash as uinteger, byval ptr_ as any ptr ) as any ptr
'// Find an element in the set. Returns the default value if the element isn't found.
declare function cpHashSetFind( byval set as cpHashSet ptr, byval hash as uinteger, byval ptr_ as any ptr ) as any ptr

'// Iterate over a hashset.
declare sub cpHashSetEach( byval set as cpHashSet ptr, byval func as cpHashSetIterFunc, byval data_ as any ptr )
'// Iterate over a hashset while rejecting certain elements.
declare sub cpHashSetReject( byval set as cpHashSet ptr, byval func as cpHashSetRejectFunc, byval data_ as any ptr )
