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

#ifndef CHIPMUNK_HEADER
#define CHIPMUNK_HEADER -1

#inclib "chipmunk41"

#include once "crt.bi"

extern "C"

#define CP_ALLOW_DEPRECATED_API_4 -1

type cpFloat as double

#define cpfsqrt sqrt
#define cpfsin sin
#define cpfcos cos
#define cpfatan2 atan2
#define cpfmod fmod
#define cpfexp exp
#define cpfpow pow
	
#define cpfmax(a,b) iif(a > b, a , b)

#define cpfmin(a,b) iif(a<b,a,b)

#define cpfabs(n) iif(n<0,-n,n)

#define cpfclamp(f,min,max) cpfmin(cpfmax(f, min), max)

#ifndef INFINITY
	#define INFINITY (1e1000)
#endif

#include "chipmunk/cpVect.bi" 
#include "chipmunk/cpBB.bi" 
#include "chipmunk/cpBody.bi" 
#include "chipmunk/cpArray.bi" 
#include "chipmunk/cpHashSet.bi" 
#include "chipmunk/cpSpaceHash.bi" 
#include "chipmunk/cpShape.bi"
#include "chipmunk/cpPolyShape.bi"
#include "chipmunk/cpArbiter.bi"
#include "chipmunk/cpCollision.bi" 
#include "chipmunk/constraints/cpConstraint.bi"
#include "chipmunk/cpSpace.bi"

#define CP_HASH_COEF (3344921057ul)
#define CP_HASH_PAIR(A, B) (cast(uinteger,(A))*CP_HASH_COEF xor cast(uinteger,(B))*CP_HASH_COEF)

declare sub cpInitChipmunk()

declare function cpMomentForCircle( byval m as cpFloat, byval r1 as cpFloat, byval r2 as cpFloat, byval offset as cpVect ) as cpFloat
declare function cpMomentForSegment( byval m as cpFloat, byval a as cpVect, byval b as cpVect ) as cpFloat
declare function cpMomentForPoly( byval m as cpFloat, byval numVerts as integer, byval verts as cpVect ptr, byval offset as cpVect ) as cpFloat

end extern

#endif
