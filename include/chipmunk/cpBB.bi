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
 
type cpBB
	as cpFloat l, b, r ,t
end type

#define cpBBNew(l,b,r,t) type((l),(b),(r),(t))
#define cpBBintersects(a,b) ((a).l<=(b).r and (b).l<=(a).r and (a).b<=(b).t and (b).b<=(a).t)
#define cpBBcontainsBB(bb,other) ((bb).l < (other).l and (bb).r > (other).r and (bb).b < (other).b and (bb).t > (other).t)
#define cpBBcontainsVect(bb,v) ((bb).l < (v).x and (bb).r > (v).x and (bb).b < (v).y and (bb).t > (v).y)

declare function cpBBClampVect( byval bb as const cpBB, byval v as const cpVect ) as cpVect 'clamps the vector to lie within the bbox
declare function cpBBWrapVect( byval bb as const cpBB, byval v as const cpVect ) as cpVect 'wrap a vector to a bbox
