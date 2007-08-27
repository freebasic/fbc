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
#define dsDrawSphere dsDrawSphereD
#define dsDrawCylinder dsDrawCylinderD
#define dsDrawCapsule dsDrawCapsuleD
#endif

' some constants
#define cLENGTH 0.7  ' chassis length
#define cWIDTH  0.5  ' chassis width
#define cHEIGHT 0.1  ' chassis height
#define cRADIUS 0.2 ' wheel radius
#define cSTARTZ 0.3  ' starting height of chassis
#define cMASS   10.0  ' chassis mass
#define cWHEELMASS 0.5  ' wheel mass
#define GRAVITY   -0.981

' dynamics and collision objects (chassis, 3 wheels, environment)
dim shared as dWorldID      World
dim shared as dSpaceID      WorldSpace
dim shared as dBodyID       body(3)
dim shared as dJointID      Joint(2)
dim shared as dJointGroupID ContactGroup
dim shared as dGeomID       Ground
dim shared as dSpaceID      CarSpace
dim shared as dGeomID       Box(0)
dim shared as dGeomID       Sphere(2)
dim shared as dGeomID       GroundBox

' things that the user controls
dim shared as dReal speed=10,steer=10*DEG_TO_RAD ' user commands


' start simulation - set viewpoint
sub DoStart()
  static as single xyz(2) = {  0,  6,3}
  static as single hpr(2) = {-90,-15,0}
  dsSetViewpoint(@xyz(0),@hpr(0))
  dsPrint("Press:'w' to increase speed.")
  dsPrint("      's' to decrease speed.")
  dsPrint("      'a' to steer left.")
  dsPrint("      'd' to steer right.")
  dsPrint("      ' ' to reset speed and steering.")
  dsPrint("")
  dsPrint("      'T' togle texture.")
  dsPrint("      'S' togle shadow.")
  dsPrint("      'F' togle fog.")
  dsPrint("")
  dsPrint("camera: drag the mouse")
  dsPrint("      left  button rotate")
  dsPrint("      right button move")
  dsPrint("      both  button up/down")
end sub

' called when a key are pressed
sub DoCommand (cmd as integer)
  dim as string key=chr(cmd)
  select case lcase(key)
    case "w":speed += 0.1:if speed >10 then speed=10
    case "s":speed -= 0.1:if speed <-1 then speed=-1
    case "a":steer -= 0.1:if steer <-1 then steer=-1
    case "d":steer += 0.1:if steer > 1 then steer= 1
    case " ":speed=0:steer=0
  end select
end sub

' this is called by dSpaceCollide when two objects 
' in space are potentially colliding.
sub CollisionCallback cdecl (lpData as any ptr, _
                             o1     as dGeomID, _
                             o2     as dGeomID)
  const  as integer  max_contacts = 16
  static as dContact Contacts(max_contacts-1)

  ' only collide things with the ground
  dim as integer g1 = (o1 = Ground or o1 = GroundBox)
  dim as integer g2 = (o2 = Ground or o2 = GroundBox)
  if (g1 xor g2)=0 then return

  dim as integer n = dCollide(o1,o2,max_contacts,@Contacts(0).geom,sizeof(dContact))
  if (n > 0) then
    n-=1
    for i as integer=0 to n
      with Contacts(i).surface
        .mode = dContactSlip1 _
             or dContactSlip2 _
             or dContactSoftERP _
             or dContactSoftCFM _
             or dContactApprox1
        .mu       = dInfinity
        .slip1    = 0.001
        .slip2    = 0.001
        .soft_erp = 0.8
        .soft_cfm = 0.01
      end with
      dim as dJointID c = dJointCreateContact(World,ContactGroup,@Contacts(i))
      dJointAttach (c,dGeomGetBody(Contacts(i).geom.g1), _
                      dGeomGetBody(Contacts(i).geom.g2))
    next
  end if
end sub

' simulation loop
sub DoSimLoop(pause as integer)
  static as double  t1
  static as integer frames,fps=150
  dim    as double  t2

  if t1=0 then t1=Timer()

  if pause=0 then
    ' motor 0 to 0 front wheel
    ' motor 1 to 2 back wheels
    ' motor 0 to 2 all wheels
    for i as integer=1 to 2
      dJointSetHinge2Param(joint(i),dParamVel2 ,-speed)
      dJointSetHinge2Param(joint(i),dParamFMax2,1)
    next
   
    ' steering
    dim as dReal v = steer - dJointGetHinge2Angle1(joint(0))
    if (v > 0.1) then v = 0.1
    if (v <-0.1) then v =-0.1
    v *= 10.0
    dJointSetHinge2Param (joint(0),dParamVel,v)
    dJointSetHinge2Param (joint(0),dParamFMax,0.5)
    dJointSetHinge2Param (joint(0),dParamLoStop,-10*DEG_TO_RAD)
    dJointSetHinge2Param (joint(0),dParamHiStop, 10*DEG_TO_RAD)
    dJointSetHinge2Param (joint(0),dParamFudgeFactor,0.1)

    dSpaceCollide (WorldSpace,0,@CollisionCallback)
    if fps=  0 then fps= 50
    if fps< 10 then fps= 10
    if fps>250 then fps=250
    dWorldStep(World,1f/fps)
    dJointGroupEmpty(ContactGroup)
  end if

  dsSetColor (0,1,1)
  dsSetTexture(DS_WOOD)
  dim as dReal sides(2)={cLENGTH,cWIDTH,cHEIGHT}
  ' draw chassi
  dsDrawBox (dBodyGetPosition(body(0)), _
             dBodyGetRotation(body(0)), _
             @sides(0))

  dsSetColor (1,1,1)
  ' draw the wheels
  for i as integer=1 to 3
     dsDrawCylinder (dBodyGetPosition(body(i)), _
                     dBodyGetRotation(body(i)), _
                     0.05f,cRADIUS)
  next

  dim as dVector3 ss
  dGeomBoxGetLengths(GroundBox,@ss)
  dsDrawBox(dGeomGetPosition(GroundBox), _
            dGeomGetRotation(GroundBox), _
            @ss.v(0))
  frames+=1
  if frames=50 then
    t2=timer()
    fps=(frames/(t2-t1))
    windowtitle "fsp:" & fps
    t1=t2:frames=0
  end if
end sub

'
' main
'
dim as integer i
dim as dMass   m

' setup pointers to drawstuff callback functions
dim as  dsFunctions fn
fn.version  = DS_VERSION
fn._start   = @DoStart
fn._step    = @DoSimLoop
fn._command = @DoCommand
fn._stop    = 0
fn.path_to_textures = 0
  
' create world
World=dWorldCreate()
WorldSpace=dHashSpaceCreate(0)
ContactGroup=dJointGroupCreate(0)
dWorldSetGravity(World,0,0,GRAVITY)
Ground=dCreatePlane(WorldSpace,0,0,1,0)

' chassis body
body(0)=dBodyCreate(World)
dBodySetPosition (body(0),0,0,cSTARTZ)
dMassSetBox (@m,1,cLENGTH,cWIDTH,cHEIGHT)
dMassAdjust (@m,cMASS)
dBodySetMass (body(0),@m)
box(0)=dCreateBox(0,cLENGTH,cWIDTH,cHEIGHT)
dGeomSetBody(box(0),body(0))

' wheel bodies
dim as dQuaternion q
for i=1 to 3
  body(i) =dBodyCreate(World)
  dQFromAxisAndAngle(@q,1,0,0,M_PI*0.5)
  dBodySetQuaternion(body(i),q)
  dMassSetSphere(@m,1,cRADIUS)
  dMassAdjust(@m,cWHEELMASS)
  dBodySetMass(body(i),@m)
  sphere(i-1)=dCreateSphere(0,cRADIUS)
  dGeomSetBody(sphere(i-1),body(i))
next

dBodySetPosition (body(1), 0.8*cLENGTH,        0.0,cSTARTZ)'-cHEIGHT*0.5)
dBodySetPosition (body(2),-0.8*cLENGTH, cWIDTH*0.7,cSTARTZ)'-cHEIGHT*0.5)
dBodySetPosition (body(3),-0.8*cLENGTH,-cWIDTH*0.7,cSTARTZ)'-cHEIGHT*0.5)

' front and back wheel hinges
for i=0 to 2
  joint(i)=dJointCreateHinge2(World,0)
  dJointAttach (joint(i),body(0),body(i+1))
  dim as dReal ptr a = dBodyGetPosition(body(i+1))
  dJointSetHinge2Anchor(joint(i),a[0],a[1],a[2])
  dJointSetHinge2Axis1 (joint(i),   0,   0,   1)
  dJointSetHinge2Axis2 (joint(i),   0,   1,   0)
next

' set joint suspension
for i=0 to 2
  dJointSetHinge2Param (joint(i),dParamSuspensionERP,0.8)
  dJointSetHinge2Param (joint(i),dParamSuspensionCFM,0.4)
next

' lock back wheels along the steering axis
for i=1 to 2
  ' set stops to make sure wheels always stay in alignment
  dJointSetHinge2Param (joint(i),dParamLoStop,0)
  dJointSetHinge2Param (joint(i),dParamHiStop,0)
next

' create car space and add it to the top level space
CarSpace=dSimpleSpaceCreate(WorldSpace)
dSpaceSetCleanup(CarSpace,0)
dSpaceAdd(CarSpace,box(0))
dSpaceAdd(CarSpace,sphere(0))
dSpaceAdd(CarSpace,sphere(1))
dSpaceAdd(CarSpace,sphere(2))

' environment
GroundBox = dCreateBox(WorldSpace,2,1.5,0.1)
dim as dMatrix3 R
dRFromAxisAndAngle (@R,0,1,0,-5 * DEG_TO_RAD)
dGeomSetPosition (GroundBox,1,0,0.04)
dGeomSetRotation (GroundBox,R)

dim as integer w,h
screeninfo w,h:w*=0.5:h*=0.5
' run simulation
dsSimulationLoop (w,h,@fn)

' free the resources
dGeomDestroy(box(0))
dGeomDestroy(sphere(0))
dGeomDestroy(sphere(1))
dGeomDestroy(sphere(2))
dJointGroupDestroy(ContactGroup)
dSpaceDestroy(WorldSpace)
dWorldDestroy(World)

end

