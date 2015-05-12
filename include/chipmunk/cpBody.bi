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

type cpBodyVelocityFunc as sub( byval body as cpBody ptr, byval gravity as cpVect, byval damping as cpFloat, byval dt as cpFloat )
type cpBodyPositionFunc as sub( byval body as cpBody ptr, byval dt as cpFloat )
 
type cpBody
	'// *** Integration Functions.ntoehu

	'// Function that is called to integrate the body's velocity. (Defaults to cpBodyUpdateVelocity)
	as cpBodyVelocityFunc velocity_func
	
	'// Function that is called to integrate the body's position. (Defaults to cpBodyUpdatePosition)
	as cpBodyPositionFunc position_func
	
	'// *** Mass Properties
	
	'// Mass and it's inverse.
	'// Always use cpBodySetMass() whenever changing the mass as these values must agree.
	as cpFloat m, m_inv
	
	'// Moment of inertia and it's inverse.
	'// Always use cpBodySetMass() whenever changing the mass as these values must agree.
	as cpFloat i, i_inv
	
	'// *** Positional Properties
	
	'// Linear components of motion (position, velocity, and force)
	as cpVect p, v, f
	
	'// Angular components of motion (angle, angular velocity, and torque)
	'// Always use cpBodySetAngle() to set the angle of the body as a and rot must agree.
	as cpFloat a, w, t
	
	'// Cached unit length vector representing the angle of the body.
	'// Used for fast vector rotation using cpvrotate().
	as cpVect rot
	
	'// *** User Definable Fields
	
	'// User defined data pointer.
	as any ptr data_
	
	'// *** Internally Used Fields
	
	'// Velocity bias values used when solving penetrations and correcting constraints.
	as cpVect v_bias
	as cpFloat w_bias
	
end type

'// Basic allocation/destruction functions
declare function cpBodyAlloc() as cpBody ptr
declare function cpBodyInit( byval body as cpBody ptr, byval m as cpFloat, byval i as cpFloat ) as cpBody ptr
declare function cpBodyNew( byval m as cpFloat, byval i as cpFloat ) as cpBody ptr

declare sub cpBodyDestroy( byval body as cpBody ptr )
declare sub cpBodyFree( byval body as cpBody ptr )


'// Setters for some of the special properties (mandatory!)
declare sub cpBodySetMass( byval body as cpBody ptr, byval m as cpFloat )
declare sub cpBodySetMoment( byval body as cpBody ptr, byval i as cpFloat )
declare sub cpBodySetAngle( byval body as cpBody ptr, byval a as cpFloat )


'//  Modify the velocity of the body so that it will move to the specified absolute coordinates in the next timestep.
'// Intended for objects that are moved manually with a custom velocity integration function.
declare sub cpBodySlew( byval body as cpBody ptr, byval pos_ as cpVect, byval dt as cpFloat )


'// Default Integration functions.
declare sub cpBodyUpdateVelocity( byval body as cpBody ptr, byval gravity as cpVect, byval damping as cpFloat, byval dt as cpFloat )
declare sub cpBodyUpdatePosition( byval body as cpbody ptr, byval dt as cpFloat )


'// Convert body local to world coordinates
#define cpBodyLocal2World(body,v) cpvadd((body)->p, cpvrotate((v),(body)->rot))

'// Convert world to body local coordinates
#define cpBodyWorld2Local(body,v) cpvunrotate(cpvsub((v), (body)->p), (body)->rot)

'// Apply an impulse (in world coordinates) to the body.
#macro cpBodyApplyImpulse(body,j,r)
(body)->v = cpvadd((body)->v, cpvmult((j), (body)->m_inv))
(body)->w += (body)->i_inv * cpvcross((r),(j)
#endmacro

'// Not intended for external use. Used by cpArbiter.c and cpConstraint.c.
#macro cpBodyApplyBiasImpulse(body,j,r)
(body)->v_bias = cpvadd((body)->v_bias, cpvmult((j), (body)->m_inv));
(body)->w_bias += (body)->i_inv*cpvcross((r), (j));
#endmacro

'// Zero the forces on a body.
declare sub cpBodyResetForces( byval body as cpBody ptr )

'// Apply a force (in world coordinates) to a body.
declare sub cpBodyApplyForce( byval body as cpBody ptr, byval f as cpVect, byval r as cpVect )

'// Apply a damped spring force between two bodies.
declare sub cpApplyDampedSpring( byval a as cpBody ptr, byval b as cpBody ptr, _
                                byval anchr1 as cpVect, byval anchr2 as cpVect, byval rlen as cpFloat, _
                                byval k as cpFloat, byval dmp as cpFloat, byval dt as cpFloat )
