/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 ************************************************************************'/

#include "GL/gl.bi"
#include "GL/glu.bi"
#include "drawstuff.bi"

sub DoStart()
  ' adjust the starting viewpoint a bit
  static as single xyz(2)={3,0,2}
  static as single hpr(2)={180,-20,0}
  dsSetViewpoint (@xyz(0),@hpr(0))
end sub

sub DoStop()

end sub

sub DoSimLoop(pause as integer)
  static as single P(2),R(11)
  static as single  a = 0
 
  if (pause=0) then a += 0.02f
  if (a > (2*M_PI)) then a -= csng(2*M_PI)
  dim as single ca = cos(a)
  dim as single sa = sin(a)


  dsSetTexture(DS_WOOD)
  dim as single b = iif(a > M_PI,2*(a-csng(M_PI)),a*2)
  p(0) =  0: p(1) = 0: p(2)=csng(0.1f*(2*M_PI*b - b*b) + 0.65f)
  R(0) = ca: R(1) = 0: R(2)  = -sa
  R(4) =  0: R(5) = 1: R(6)  =   0
  R(8) = sa: R(9) = 0: R(10) =  ca
  dsSetColor (1,0.8f,0.6f)
  dsDrawSphere (@p(0),@R(0),0.3f)

  p(0)=-0f:p(1)= 1f:p(2)= 0.45f
  R(0)= ca:R(1)=-sa:R(2) =0
  R(4)= sa:R(5)= ca:R(6) =0
  R(8)=  0:R(9)=  0:R(10)=1
  dim as single sides(2)={0.1f,0.4f,0.9f}
  dsSetTexture (DS_WOOD)
  dsSetColor (0.6,0.6,0.9)
  dsDrawBox (@p(0),@R(0),@sides(0))

  dim as single ra  = 0.3f ' cylinder radius
  dim as single d  = cos(a*2) * 0.4f
  dim as single cd = cos(-d/ra)
  dim as single sd = sin(-d/ra)
  p(0) =  0:p(1)=-1+d:p(2)=0.3f
  R(0) =  0:R(1)= 0:R(2) =-1
  R(4) =-sd:R(5)=cd:R(6) = 0
  R(8) = cd:R(9)=sd:R(10)= 0
  dsSetTexture (DS_WOOD)
  dsSetColor (0.4f,1,1)
  dsDrawCylinder (@p(0),@R(0),0.9f,ra)

  dsSetTexture (DS_WOOD)
  p(0) = 0:p(1) = 0:p(2) = 0.2f
  R(0) = 0:R(1)=sa:R(2) =-ca
  R(4) = 0:R(5)=ca:R(6) = sa
  R(8) = 1:R(9)= 0:R(10)=  0
  dsSetColor (1,0.9f,0.2f)
  dsDrawCappedCylinder (@p(0),@R(0),1f,0.25f)
end sub

sub DoCommand(cmd as integer)
  dsDebug("DoCommand " & cmd)
end sub

' 
' main
'
' setup pointers to callback functions
dim as dsFunctions fn
fn.version  = DS_VERSION
fn._start   = @DoStart
fn._step    = @DoSimLoop
fn._command = @DoCommand
fn._stop    = @DoStop

' run simulation
dim as integer w,h
screeninfo w,h:w*=0.8:h*=0.8
dsSimulationLoop (w,h,@fn)
end

