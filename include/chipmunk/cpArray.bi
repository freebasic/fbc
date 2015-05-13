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
 
'// NOTE: cpArray is rarely used and will probably go away.

type cpArray
	as integer num, max
	as any ptr ptr arr
end type

type cpArrayIter as sub( byval ptr_ as any ptr, byval data_ as any ptr )

declare function cpArrayAlloc() as cpArray ptr
declare function cpArrayInit( byval arr as cpArray ptr, byval size as integer ) as cpArray ptr
declare function cpArrayNew( byval size as integer ) as cpArray ptr

declare sub cpArrayDestroy( byval arr as cpArray ptr )
declare sub cpArrayFree( byval arr as cpArray ptr )

declare sub cpArrayClear( byval arr as cpArray ptr )

declare sub cpArrayPush( byval arr as cpArray ptr, byval object as any ptr )
declare sub cpArrayDeleteIndex( byval arr as cpArray ptr, byval index as integer )
declare sub cpArrayDeleteObj( byval arr as cpArray ptr, byval obj as any ptr )


declare sub cpArrayEach( byval arr as cpArray ptr, byval iterFunc as cpArrayIter, byval data_ as any ptr )
declare function cpArrayContains( byval arr as cpArray ptr, byval ptr_ as any ptr ) as integer
