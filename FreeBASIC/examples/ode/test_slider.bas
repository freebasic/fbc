/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 ************************************************************************'/

#include "ode/ode.bi"
#include "drawstuff.bi"

' select correct drawing functions
#ifdef dDOUBLE
#define dsDrawBox dsDrawBoxD
#endif

' some constants
#define SIDE 0.5f ' side length of a box
#define MASS .1   ' mass of a box

' dynamics and collision objects
dim shared as dWorldID world
dim shared as dBodyID  body(1)
dim shared as dJointID slider

' state set by keyboard commands
dim shared as integer occasional_error = 0

' start simulation - set viewpoint
sub DoStart()
  static as single xyz(2) = {  1.0382f, -1.0811f,1.4700f}
  static as single hpr(2) = {135.0000f,-19.5000f,0.0000f}
  dsSetViewpoint (@xyz(0),@hpr(0))
  dsPrint ("Press 'e' to start/stop occasional error.")
end sub

' called when a key pressed
sub DoCommand (cmd as integer)
  dim as string key=lcase(chr(cmd))
  if key = "e" then occasional_error xor=1
end sub

' simulation loop
sub DoSimLoop (pause as integer)
  const as dReal kd =-0.3 ' angular damping constant
  const as dReal ks = 0.5 ' spring constant
  if (pause=0) then
    ' add an oscillating torque to body 0, and also damp its rotational motion
    static as dReal a=0
    dim as dReal ptr w = dBodyGetAngularVel(body(0))
    dBodyAddTorque (body(0),kd*w[0], _
                    kd*w[1]+0.1*cos(a), _
                    kd*w[2]+0.1*sin(a))
    a += 0.01

    ' add a spring force to keep the bodies together, 
    ' otherwise they will fly apart along the slider axis.
    dim as dReal ptr p1 = dBodyGetPosition(body(0))
    dim as dReal ptr p2 = dBodyGetPosition(body(1))
    dBodyAddForce (body(0),ks*(p2[0]-p1[0]), _
                           ks*(p2[1]-p1[1]), _
                           ks*(p2[2]-p1[2]))

    dBodyAddForce (body(1),ks*(p1[0]-p2[0]), _
                           ks*(p1[1]-p2[1]), _
                           ks*(p1[2]-p2[2]))

    ' occasionally re-orient one of the bodies to create a deliberate error.
    if (occasional_error) then
      static as integer count = 0
      if (count mod 20)=0 then 
        ' randomly adjust orientation of body[0]
        dim as dReal ptr R1=dBodyGetRotation (body(0))
        dim as dMatrix3 R2,R3
        dRFromAxisAndAngle (@R2,dRandReal()-0.5, _
                                dRandReal()-0.5, _
                                dRandReal()-0.5, _
                                dRandReal()-0.5)
        dMultiply0 (@R3.m(0),R1,@R2.m(0),3,3,3)
        dBodySetRotation(body(0),R3)

        ' randomly adjust position of body(0)
        dim as dReal ptr p = dBodyGetPosition (body(0))
        dBodySetPosition (body(0),p[0]+0.2*(dRandReal()-0.5), _
                                  p[1]+0.2*(dRandReal()-0.5), _
                                  p[2]+0.2*(dRandReal()-0.5))
      end if
      count+=1
    end if
    dWorldStep (world,0.05)
  end if

  dim as dReal sides1(2) = {SIDE,SIDE,SIDE}
  dim as dReal sides2(2) = {SIDE*0.8f,SIDE*0.8f,SIDE*2.0f}
  dsSetTexture (DS_WOOD)
  dsSetColor (1,1,0)
  dsDrawBox (dBodyGetPosition(body(0)),dBodyGetRotation(body(0)),@sides1(0))
  dsSetColor (0,1,1)
  dsDrawBox (dBodyGetPosition(body(1)),dBodyGetRotation(body(1)),@sides2(0))
end sub


' 
' main 
'
' setup pointers to drawstuff callback functions
dim as dsFunctions fn
fn.version  = DS_VERSION
fn._start   = @DoStart
fn._step    = @DoSimLoop
fn._command = @DoCommand
fn._stop    = 0

' create world
world = dWorldCreate()
dim as dMass m
dMassSetBox (@m,1,SIDE,SIDE,SIDE)
dMassAdjust (@m,MASS)

body(0) = dBodyCreate (world)
dBodySetMass (body(0),@m)
dBodySetPosition (body(0),0,0,1)

body(1) = dBodyCreate (world)
dBodySetMass (body(1),@m)
dim as dQuaternion q
dQFromAxisAndAngle (@q,-1,1,0,0.25*M_PI)
dBodySetPosition   (body(1),0.2,0.2,1.2)
dBodySetQuaternion (body(1),q)

slider = dJointCreateSlider (world,0)
dJointAttach (slider,body(0),body(1))
dJointSetSliderAxis (slider,1,1,1)

' run simulation
dim as integer w,h
screeninfo w,h:w*=0.5:h*=0.5

dsSimulationLoop (w,h,@fn)

dWorldDestroy (world)
end 0
