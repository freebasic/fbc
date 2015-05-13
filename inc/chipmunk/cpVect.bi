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
 
type cpVect
	as cpFloat x,y
end type

static const cpvzero as cpVect = type(0.0f,0.0f)

#define cpv(x,y) type(x,y)
#define cpvadd(v1,v2) cpv((v1).x + (v2).x,(v1).y + (v2).y)
#define cpvneg(v) cpv(-((v).x),-((v).y))
#define cpvsub(v1,v2) cpv((v1).x - (v2).x,(v1).y - (v2).y)
#define cpvmult(v,s) cpv((v).x*s,(v).y*s)
#define cpvdot(v1,v2) ((v1).x*(v2).x)+((v1).y*(v2).y)
#define cpvcross(v1,v2) ((v1).x*(v2).y)-((v1).y*(v2).x)
#define cpvperp(v) cpv(-(v).y,(v).x)
#define cpvrperp(v) cpv((v).y,-(v).x)
#define cpvproject(v1,v2) cpvmult((v2), cpvdot((v1),(v2))/cpvdot((v2),(v2)))
#define cpvrotate(v1,v2) cpv((v1).x*(v2).x - (v1).y*(v2).y, (v1).x*(v2).y + (v1).y*(v2).x)
#define cpvunrotate(v1,v2) cpv((v1).x*(v2).x + (v1).y*(v2).y, (v1).y*(v2).x - (v1).x*(v2).y)

declare function cpvlength( byval v as const cpVect ) as cpFloat
declare function cpvlengthsq( byval v as const cpVect ) as cpFloat 'no sqrt() call
declare function cpvnormalize( byval v as const cpVect ) as cpVect
declare function cpvforangle( byval a as const cpFloat ) as cpVect 'convert radians to a normalized vector
declare function cpvtoangle( byval v as const cpVect ) as cpFloat 'convert a vector to radians
declare function cpvstr( byval v as const cpVect ) as zstring ptr 'get a string representation of a vector

