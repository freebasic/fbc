/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001,2002 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 ************************************************************************'/

' This is a demo of the QuickStep and StepFast methods,
' originally by David Whittaker.

#include "ode/ode.bi"
#include "drawstuff.bi"

' select correct drawing functions
#ifdef dDOUBLE
# define dsDrawBox dsDrawBoxD
# define dsDrawSphere dsDrawSphereD
# define dsDrawCylinder dsDrawCylinderD
# define dsDrawCapsule dsDrawCapsuleD
#endif

' select the method you want to test here (only uncomment *one* line)
#define QUICKSTEP 1
'#define STEPFAST 1

' some constants
#define cLENGTH               3.5   ' chassis length
#define cWIDTH                2.5   ' chassis width
#define cHEIGHT               1.0   ' chassis height
#define wRADIUS               0.5   ' wheel radius
#define cSTARTZ               1.0   ' starting height of chassis
#define cMASS                1     ' chassis mass
#define wMASS                1     ' wheel mass
#define COMOFFSET           -5     ' center of mass offset
#define WALLMASS             1     ' wall box mass
#define BALLMASS             1     ' ball mass
#define FMAX                25     ' car engine fmax
#define ROWS                 1     ' rows of cars
#define COLS                 1     ' columns of cars
#define ITERS               20     ' number of iterations
#define WBOXSIZE             1.0   ' size of wall boxes
#define WALLWIDTH           12     ' width of wall
#define WALLHEIGHT          10     ' height of wall
#define DISABLE_THRESHOLD    0.008 ' maximum velocity (squared) a body can have and be disabled
#define DISABLE_STEPS       10     ' number of steps a box has to have been disable-able before it will be disabled
#define CANNON_X           -10     ' x position of cannon
#define CANNON_Y             5     ' y position of cannon
#define CANNON_BALL_MASS    10     ' mass of the cannon ball
#define CANNON_BALL_RADIUS   0.5

#define CREATE_CAR
#define CREATE_WALL
#define CREATE_BALLS
'#define CREATE_BALLSTACK
#define CREATE_ONEBALL
#define CREATE_CENTIPEDE
#define CREATE_CANNON

' dynamics and collision objects
dim shared as dWorldID World
dim shared as dSpaceID WorldSpace
dim shared as dBodyID  Bodies(10000-1)
dim shared as integer  nBodies
dim shared as dJointID Joints(100000-1)
dim shared as integer  nJoints
dim shared as dJointGroupID ContactGroup
dim shared as dGeomID  Ground
dim shared as dGeomID  Boxes(10000-1)
dim shared as integer  nBoxes
dim shared as dGeomID  Spheres(10000-1)
dim shared as integer  nSpheres
dim shared as dGeomID  WallBoxes(10000-1)
dim shared as dBodyID  WallBodies(10000-1)
dim shared as dGeomID  cannon_ball_geom
dim shared as dBodyID  cannon_ball_body
dim shared as integer  WBStepsDis(10000-1)
dim shared as integer  nWB
dim shared as integer  doFast
dim shared as dBodyID  gB
dim shared as dMass    gM

' things that the user controls
dim shared as dReal turn = 0, speed = 0 ' user commands
dim shared as dReal cannon_angle=0,cannon_elevation=-1.2

' this is called by dSpaceCollide when two objects 
'  in space are potentially colliding.
sub CollisionCallback cdecl (lpData as any ptr, _
                             o1     as dGeomID, _
                             o2     as dGeomID)
  const as integer max_contacts = 8
  static as dContact Contacts(max_contacts-1)

  dim as dBodyID b1 = dGeomGetBody(o1)
  dim as dBodyID b2 = dGeomGetBody(o2)
  dim as integer ret
  'if (b1=NULL) and (b2=NULL) then return

  if (b1<>NULL) and (b2<>NULL) then 
    ret=dAreConnected(b1,b2)
    if ret=1 then return
  end if

  dim as integer n = dCollide(o1,o2,max_contacts,@Contacts(0).geom,sizeof(dContact))
  if (n > 0) then
    for i as integer=0 to n-1
      with Contacts(i)
        .surface.mode = dContactSlip1   _
                     or dContactSlip2   _
                     or dContactSoftERP _
                     or dContactSoftCFM _
                     or dContactApprox1
        if (dGeomGetClass(o1) = dSphereClass) or (dGeomGetClass(o2) = dSphereClass) then
          .surface.mu = 20
        else
          .surface.mu = 0.5
        end if
        .surface.slip1 = 0.0
        .surface.slip2 = 0.0
        .surface.soft_erp = 0.8
        .surface.soft_cfm = 0.01
      end with
      dim as dJointID c =dJointCreateContact(World,ContactGroup,@Contacts(i))
      dJointAttach(c,dGeomGetBody(o1),dGeomGetBody(o2))
    next
  end if
end sub

' start simulation - set viewpoint
sub DoStart()
  static as single xyz(2) = {3.8548f,9.0843f,7.5900f}
  static as single hpr(2) = {-145.5f,-22.5f,0.25f}
  dsSetViewpoint(@xyz(0),@hpr(0))
  dsPrint("Press:")
  dsPrint("  'w' to increase speed.")
  dsPrint("  's' to decrease speed.")
  dsPrint("  'a' to steer left.")
  dsPrint("  'd' to steer right.")
  dsPrint("  ' ' to reset speed and steering.")
  dsPrint("  'c' to turn the cannon left.")
  dsPrint("  'v' to turn the cannon right.")
  dsPrint("  '1' to lower the cannon.")
  dsPrint("  '2' to raise the cannon.")
  dsPrint("  'x' to shoot from the cannon.")
  dsPrint("  'f' to toggle fast step mode.")
  dsPrint("  '+' to increase AutoEnableDepth.")
  dsPrint("  '-' to decrease AutoEnableDepth.")
  dsPrint("  'r' to reset simulation.")
  dsPrint ("")
  dsPrint ("Render control:")
  dsPrint ("  'S' toggle shadows")
  dsPrint ("  'T' toggle textures")
  dsPrint ("  'F' toggle fog")
  dsPrint ("")
  dsPrint ("Camera control:")
  dsPrint ("  'left'  button rotate")
  dsPrint ("  'right' button move around")
  dsPrint ("  'both'  button up and down")
end sub

sub makeCar(byval x       as dReal  , _
            byval y       as dReal  , _
            byref bodyI   as integer, _
            byref jointI  as integer, _
            byref boxI    as integer, _
            byref sphereI as integer)

  dim as integer i
  dim as dMass   m

  ' chassis body
  Bodies(bodyI) = dBodyCreate (World)
  dBodySetPosition (Bodies(bodyI),x,y,cSTARTZ)
  dMassSetBox (@m,1,cLENGTH,cWIDTH,cHEIGHT)
  dMassAdjust (@m,cMASS/2.0)
  dBodySetMass (Bodies(bodyI),@m)
  Boxes(boxI) = dCreateBox (WorldSpace,cLENGTH,cWIDTH,cHEIGHT)
  dGeomSetBody(Boxes(boxI),Bodies(bodyI))

  ' wheel bodies
  for i=1 to 4
    Bodies(bodyI+i) = dBodyCreate(World)
    dim as dQuaternion q
    dQFromAxisAndAngle (@q,1,0,0,M_PI*0.5)
    dBodySetQuaternion (Bodies(bodyI+i),q)
    dMassSetSphere (@m,1,wRADIUS)
    dMassAdjust (@m,WMASS)
    dBodySetMass (Bodies(bodyI+i),@m)
    Spheres(sphereI+i-1) = dCreateSphere(WorldSpace,wRADIUS)
    dGeomSetBody (Spheres(sphereI+i-1),Bodies(bodyI+i))
  next
  dBodySetPosition (Bodies(bodyI+1),x+0.4*cLENGTH-0.5*wRADIUS,y+cWIDTH*0.5,cSTARTZ-cHEIGHT*0.5)
  dBodySetPosition (Bodies(bodyI+2),x+0.4*cLENGTH-0.5*wRADIUS,y-cWIDTH*0.5,cSTARTZ-cHEIGHT*0.5)
  dBodySetPosition (Bodies(bodyI+3),x-0.4*cLENGTH+0.5*wRADIUS,y+cWIDTH*0.5,cSTARTZ-cHEIGHT*0.5)
  dBodySetPosition (Bodies(bodyI+4),x-0.4*cLENGTH+0.5*wRADIUS,y-cWIDTH*0.5,cSTARTZ-cHEIGHT*0.5)

  ' front and back wheel hinges
  for i=0 to 3
    Joints(jointI+i) = dJointCreateHinge2(World,0)
    dJointAttach (Joints(jointI+i),Bodies(bodyI),Bodies(bodyI+i+1))
    dim as dReal ptr a = dBodyGetPosition (Bodies(bodyI+i+1))
    dJointSetHinge2Anchor(Joints(jointI+i),a[0],a[1],a[2])
    dJointSetHinge2Axis1 (Joints(jointI+i),0,0,iif(i<2,1,-1))
    dJointSetHinge2Axis2 (Joints(jointI+i),0,1,0)
    dJointSetHinge2Param (Joints(jointI+i),dParamSuspensionERP,0.8)
    dJointSetHinge2Param (Joints(jointI+i),dParamSuspensionCFM,1e-5)
    dJointSetHinge2Param (Joints(jointI+i),dParamVel2,0)
    dJointSetHinge2Param (Joints(jointI+i),dParamFMax2,FMAX)
  next

  ' center of mass offset body. 
  '(hang another copy of the body COMOFFSET units below it by a fixed joint)
  dim as dBodyID b = dBodyCreate (World)
  dBodySetPosition (b,x,y,cSTARTZ+COMOFFSET)
  dMassSetBox (@m,1,cLENGTH,cWIDTH,cHEIGHT)
  dMassAdjust (@m,cMASS/2.0)
  dBodySetMass (b,@m)
  dim as dJointID j = dJointCreateFixed(World, 0)
  dJointAttach(j, Bodies(bodyI), b)
  dJointSetFixed(j)
  'box[boxI+1] = dCreateBox(space,LENGTH,WIDTH,HEIGHT)
  'dGeomSetBody (box[boxI+1],b)
  bodyI  +=5
  jointI +=4
  boxI   +=1
  sphereI+=4
end sub

sub resetSimulation()
  dim as integer i
  ' destroy world if it exists
  if (nBodies) then
    dJointGroupDestroy (ContactGroup)
    dSpaceDestroy (WorldSpace)
    dWorldDestroy (World)
  end if

  for i = 0 to 999
    WBStepsDis(i) = 0
  next

  ' recreate world
  World = dWorldCreate()
  WorldSpace = dHashSpaceCreate (0)
  ContactGroup = dJointGroupCreate (0)
  dWorldSetGravity (World,0,0,-1.5)
  dWorldSetCFM (World, 1e-5)
  dWorldSetERP (World, 0.8)
  dWorldSetQuickStepNumIterations (World,ITERS)
  Ground = dCreatePlane(WorldSpace,0,0,1, 0)

  nBodies  = 0
  nJoints  = 0
  nBoxes   = 0
  nSpheres = 0
  nWB      = 0

#ifdef CREATE_CAR
  dim as dReal x = 0.0
  dim as dReal y = -((ROWS-1)*(cWIDTH/2+wRADIUS))
  makeCar(x, y, nBodies, nJoints, nBoxes, nSpheres)
  dMessage(0,"after create car nBodies %i nJoints %i nBoxes %i nSpheres %i",nBodies,nJoints,nBoxes,nSpheres)
#endif

#ifdef CREATE_WALL
  dim as integer offset = 0
  for z as dReal = WBOXSIZE/2.0 to WALLHEIGHT step WBOXSIZE
    offset xor = 1
    for y as dReal = (-WALLWIDTH+z)/2 to (WALLWIDTH-z)/2 step WBOXSIZE
      WallBodies(nWB) = dBodyCreate (World)
      dBodySetPosition (WallBodies(nWB),-20,y,z)
      dMassSetBox (@gM,1,WBOXSIZE,WBOXSIZE,WBOXSIZE)
      dMassAdjust (@gM, WALLMASS)
      dBodySetMass(WallBodies(nWB),@gM)
      WallBoxes(nWB) = dCreateBox(WorldSpace,WBOXSIZE,WBOXSIZE,WBOXSIZE)
      dGeomSetBody (WallBoxes(nWB),WallBodies(nWB))
      ' dBodyDisable(wall_bodies[wb++]);
      nWB+=1
    next
  next
  dMessage(0,"wall boxes: %i", nWB)
#endif

#ifdef CREATE_BALLS
  for x as integer=-7 to -4
    for y as dReal =-1.5 to +1.5
      for z  as integer = 1 to 4
        gB = dBodyCreate (World)
        dBodySetPosition (gB,x*wRADIUS*2,y*wRADIUS*2,z*wRADIUS*2)
        dMassSetSphere (@gM,1,wRADIUS)
        dMassAdjust (@gM, BALLMASS)
        dBodySetMass (gB,@gM)
        Spheres(nSpheres) = dCreateSphere(WorldSpace,wRADIUS)
        dGeomSetBody(Spheres(nSpheres),gB)
        nSpheres+=1
      next
    next
  next
#endif

#ifdef CREATE_ONEBALL
  gB = dBodyCreate (World)
  dBodySetPosition (gb,0,0,2)
  dMassSetSphere (@gM,1,wRADIUS)
  dMassAdjust (@gM, 1)
  dBodySetMass (gB,@gM)
  Spheres(nSpheres) = dCreateSphere (WorldSpace,wRADIUS)
  dGeomSetBody (Spheres(nSpheres),gB)
  nSpheres+=1
#endif

#ifdef CREATE_BALLSTACK
  for z as integer = 1 to 6 ' !!! as dReal
    gB = dBodyCreate (World)
    dBodySetPosition (gB,0,0,z*wRADIUS*2)
    dMassSetSphere (@gM,1,wRADIUS)
    dMassAdjust (@gM, 0.1)
    dBodySetMass (gB,@gM)
    Spheres(nSpheres) = dCreateSphere(WorldSpace,wRADIUS)
    dGeomSetBody (Spheres(nSpheres),gB)
    nSpheres+=1
  next
  dMessage(0,"ball stack %i", nSpheres)
#endif

#ifdef CREATE_CENTIPEDE
  dim as dBodyID lastb = NULL
#ifndef y 
  dim as dReal y
#endif
  y = 0
  while  y <(10*cLENGTH)
    ' chassis body
    gB=dBodyCreate(World)
    Bodies(nBodies)=gB
    dBodySetPosition (Bodies(nBodies),-15,y,cSTARTZ)
    dMassSetBox (@gM,1,cWIDTH,cLENGTH,cHEIGHT)
    dMassAdjust (@gM,CMASS)
    dBodySetMass (Bodies(nBodies),@gM)
    Boxes(nBoxes) = dCreateBox(WorldSpace,cWIDTH,cLENGTH,cHEIGHT)
    dGeomSetBody(Boxes(nBoxes),Bodies(nBodies))
    nBoxes+=1:nBodies+=1

    dim as dReal x = -17
    while x > -20
      Bodies(nBodies) = dBodyCreate(World)
      dBodySetPosition(Bodies(nBodies), x, y, cSTARTZ)
      dMassSetSphere(@gM, 1, wRADIUS)
      dMassAdjust(@gM, WMASS)
      dBodySetMass(Bodies(nBodies),@gM)
      Spheres(nSpheres) = dCreateSphere(WorldSpace,wRADIUS)
      dGeomSetBody(Spheres(nSpheres),Bodies(nBodies))
      nSpheres+=1
      Joints(nJoints) = dJointCreateHinge2(World,0)
      if (x = -17) then
        dJointAttach (Joints(nJoints),gB,Bodies(nBodies))
      else
        dJointAttach (Joints(nJoints),Bodies(nBodies-2),Bodies(nBodies))
      end if
      dim as dReal ptr a = dBodyGetPosition (Bodies(nBodies))
      nBodies+=1

      dJointSetHinge2Anchor(Joints(nJoints),a[0],a[1],a[2])
      dJointSetHinge2Axis1 (Joints(nJoints),0,0,1)
      dJointSetHinge2Axis2 (Joints(nJoints),1,0,0)
      dJointSetHinge2Param (Joints(nJoints),dParamSuspensionERP,1.0)
      dJointSetHinge2Param (Joints(nJoints),dParamSuspensionCFM,1e-5)
      dJointSetHinge2Param (Joints(nJoints),dParamLoStop,0)
      dJointSetHinge2Param (Joints(nJoints),dParamHiStop,0)
      dJointSetHinge2Param (Joints(nJoints),dParamVel2,-10.0)
      dJointSetHinge2Param (Joints(nJoints),dParamFMax2,FMAX)
      nJoints+=1

      Bodies(nBodies) = dBodyCreate(World)
      dBodySetPosition(Bodies(nBodies), -30 - x, y, cSTARTZ)
      dMassSetSphere(@gM, 1, wRADIUS)
      dMassAdjust(@gM, wMASS)
      dBodySetMass(Bodies(nBodies),@gM)
      Spheres(nSpheres) = dCreateSphere(WorldSpace,wRADIUS)
      dGeomSetBody(Spheres(nSpheres),Bodies(nBodies))
      nSpheres+=1

      Joints(nJoints) = dJointCreateHinge2(World,0)
      if (x = -17) then
        dJointAttach (Joints(nJoints),gB,Bodies(nBodies))
      else
        dJointAttach (Joints(nJoints),Bodies(nBodies-2),Bodies(nBodies))
      end if
      dim as dReal ptr b = dBodyGetPosition (Bodies(nBodies))
      nBodies+=1
      dJointSetHinge2Anchor(Joints(nJoints),b[0],b[1],b[2])
      dJointSetHinge2Axis1 (Joints(nJoints),0,0,1)
      dJointSetHinge2Axis2 (Joints(nJoints),1,0,0)
      dJointSetHinge2Param (Joints(nJoints),dParamSuspensionERP,1.0)
      dJointSetHinge2Param (Joints(nJoints),dParamSuspensionCFM,1e-5)
      dJointSetHinge2Param (Joints(nJoints),dParamLoStop,0)
      dJointSetHinge2Param (Joints(nJoints),dParamHiStop,0)
      dJointSetHinge2Param (Joints(nJoints),dParamVel2,10.0)
      dJointSetHinge2Param (Joints(nJoints),dParamFMax2,FMAX)
      nJoints+=1

      x-=(wRADIUS*2)
    wend

    if (lastb<>NULL) then
      dim as dJointID j = dJointCreateFixed(World,0)
      dJointAttach (j, gB, lastb)
      dJointSetFixed(j)
    end if
    lastb = gB
    y+=(cLENGTH+0.1)
  wend
#endif

#ifdef CREATE_CANNON
  cannon_ball_body = dBodyCreate(World)
  cannon_ball_geom = dCreateSphere(WorldSpace,CANNON_BALL_RADIUS)
  dMassSetSphereTotal (@gM,CANNON_BALL_MASS,CANNON_BALL_RADIUS)
  dBodySetMass (cannon_ball_body,@gM)
  dGeomSetBody (cannon_ball_geom,cannon_ball_body)
  dBodySetPosition (cannon_ball_body,CANNON_X,CANNON_Y,CANNON_BALL_RADIUS)
  dMessage(0,"create CANNON")
#endif

end sub

' called when a key pressed
sub DoCommand ( cmd as integer)
  dim as dReal cpos(2) = {CANNON_X,CANNON_Y,1}
  static as dReal force = 10

  dim as string key=lcase(chr(cmd))
  select case (key) 
    case "w":speed += 0.3
    case "s":speed -= 0.3
    case "a":turn  += 0.1:if (turn > 0.3) then turn = 0.3
    case "d":turn  -= 0.1:if (turn <-0.3) then turn =-0.3
    case " ":speed  =   0:turn = 0
    case "f":doFast xor = 1
    case "+":dWorldSetAutoEnableDepthSF1(World,dWorldGetAutoEnableDepthSF1(World) + 1)
    case "-":dWorldSetAutoEnableDepthSF1(World,dWorldGetAutoEnableDepthSF1(world) - 1)
    case "r":resetSimulation()
    case "c":cannon_angle += 0.1
    case "v":cannon_angle -= 0.1
    case "1":cannon_elevation -= 0.1:if cannon_elevation<-1.7 then cannon_elevation=-1.7
    case "2":cannon_elevation += 0.1:if cannon_elevation> 1.7 then cannon_elevation= 1.7
    case "x":
      if (cannon_ball_body<>NULL) then
        dim as dMatrix3 R2,R3,R4
        dRFromAxisAndAngle (@R2,0,0,1,cannon_angle)
        dRFromAxisAndAngle (@R3,0,1,0,cannon_elevation)
        dMultiply0 (@R4.m(0),@R2.m(0),@R3.m(0),3,3,3)
        for i as integer=0 to 2
          cpos(i) += 3*R4.m(i*4+2)
        next
        dBodySetPosition (cannon_ball_body,cpos(0),cpos(1),cpos(2))
        dBodySetLinearVel (cannon_ball_body,force*R4.m(2),force*R4.m(6),force*R4.m(10))
        dBodySetAngularVel (cannon_ball_body,0,0,0)
      end if
  end select
end sub


' simulation loop
sub DoSimLoop(pause as integer)
  static as dReal sides (2) = {cLENGTH,cWIDTH,cHEIGHT}
  static as dReal csides(2) = {2,2,2}
  static as dReal lspeed
  static as dReal curturn
  static as dReal ptr lvel
  static as dReal ptr avel
  static as dReal aspeed
  static as double t1
  static as integer frames=0,fps=0
  dim    as dReal cpos  (2) = {CANNON_X,CANNON_Y,1}
  dim    as double t2

  dsSetTexture (DS_WOOD)
  if t1=0 then t1=Timer()
  if (pause=0) then
#ifdef CREATE_BOX
    dBodyAddForce(Bodies(nBodies-1),lspeed,0,0)
#endif
    for j as integer= 0 to nJoints-1
      curturn = dJointGetHinge2Angle1 (Joints(j))
      ' dMessage (0,"curturn %e, turn %e, vel %e", curturn, turn, (turn-curturn)*1.0);
      dJointSetHinge2Param(Joints(j),dParamVel,(turn-curturn)*1.0)
      dJointSetHinge2Param(Joints(j),dParamFMax,dInfinity)
      dJointSetHinge2Param(Joints(j),dParamVel2,speed)
      dJointSetHinge2Param(Joints(j),dParamFMax2,FMAX)
      dBodyEnable(dJointGetBody(Joints(j),0))
      dBodyEnable(dJointGetBody(Joints(j),1))
    next

    if (doFast<>0) then
      dSpaceCollide (WorldSpace,0,@CollisionCallback)
#ifdef QUICKSTEP
      dWorldQuickStep (World,0.05)
#else
 #ifdef STEPFAST
      dWorldStepFast1 (World,0.05,ITERS)
 #else
   #error "QUICKSTEP or STEPFAST must be defined"
 #endif 
#endif
      dJointGroupEmpty(ContactGroup)
    else
      dSpaceCollide (WorldSpace,0,@CollisionCallback)
      dWorldStep (World,0.05)
      dJointGroupEmpty(ContactGroup)
    end if

    for i as integer = 0 to nWB-1
      gB = dGeomGetBody(WallBoxes(i))
    if gB<>NULL then
      if (dBodyIsEnabled(gB)<>0) then
        dim as integer disable = 1
        lvel = dBodyGetLinearVel(gB)
        lspeed = lvel[0]*lvel[0]+lvel[1]*lvel[1]+lvel[2]*lvel[2]
        if (lspeed > DISABLE_THRESHOLD) then disable = 0
        avel = dBodyGetAngularVel(gB)
        aspeed = avel[0]*avel[0]+avel[1]*avel[1]+avel[2]*avel[2]
        if (aspeed > DISABLE_THRESHOLD) then disable = 0

        if (disable) then 
          WBStepsDis(i)+=1 ' wb_stepsdis[i]++
        else
          WBStepsDis(i) =0
        end if

        if (WBStepsDis(i) > DISABLE_STEPS) then
          dBodyDisable(gB)
          dsSetColor(0.5,0.5,1)
        else
          dsSetColor(1,1,1)
        end if
      else
        dsSetColor(0.4,0.4,0.4)
      end if
      dim as dVector3 ss
      dGeomBoxGetLengths (WallBoxes(i), @ss)
      dsDrawBox(dGeomGetPosition(WallBoxes(i)), _
                dGeomGetRotation(WallBoxes(i)), _
                @ss.v(0))
    end if
    next
  
  else ' pause=1
    for i as integer = 0 to nWB-1
      if WallBoxes(i)<>NULL then
        gB = dGeomGetBody(WallBoxes(i))
        if (dBodyIsEnabled(gB)) then
          dsSetColor(1,1,1)
        else
          dsSetColor(0.4,0.4,0.4)
        end if
        dim as dVector3 ss
        dGeomBoxGetLengths(WallBoxes(i),@ss)
        dsDrawBox(dGeomGetPosition(WallBoxes(i)), _
                  dGeomGetRotation(WallBoxes(i)), @ss.v(0))
      end if
    next
  end if

  dsSetColor (0,1,1)
  for i as integer = 0 to nBoxes-1
    if Boxes(i)<>NULL then
      dsDrawBox (dGeomGetPosition(Boxes(i)),_
                 dGeomGetRotation(Boxes(i)), _
                 @sides(0))
    end if
  next

  dsSetColor (1,1,1)
  for i as integer=0 to nSpheres-1 
    if Spheres(i)<>NULL then
      dsDrawSphere (dGeomGetPosition(Spheres(i)), _
                    dGeomGetRotation(Spheres(i)), _
                    wRADIUS)
    end if
  next

#ifdef CREATE_CANNON
  ' draw the cannon

  dim as dMatrix3 R2,R3,R4
  if (cannon_ball_body<>NULL) then
    dRFromAxisAndAngle (@R2,0,0,1,cannon_angle)
    dRFromAxisAndAngle (@R3,0,1,0,cannon_elevation)
    dMultiply0 (@R4.m(0),@R2.m(0),@R3.m(0),3,3,3)
    dsSetTexture (DS_NONE)
    dsSetColor(0.2,0.2,0.2)
    dsDrawBox (@cpos(0),@R2.m(0),@csides(0))

    for i as integer=0 to 2 
      cpos(i) += 1.5*R4.m(i*4+2)
    next
    dsSetColor(0.5,0.5,0.5)
    dsDrawCylinder (@cpos(0),@R4.m(0),3,0.5)
    ' draw the cannon ball
    dsSetColor(1,0,0)
    dsDrawSphere (dBodyGetPosition(cannon_ball_body), _
                  dBodyGetRotation(cannon_ball_body), _
                  CANNON_BALL_RADIUS)
  end if
#endif
  frames+=1
  if frames=50 then
    t2=timer
    fps=frames/(t2-t1)
    WindowTitle "fps:" & fps
    t1=t2:frames=0
  end if
end sub

'
' main
'
doFast = 1

' setup pointers to drawstuff callback functions
dim as dsFunctions fn
fn.version  = DS_VERSION
fn._start   = @DoStart
fn._step    = @DoSimLoop
fn._command = @DoCommand
fn._stop    = NULL
fn.path_to_textures = NULL
  
nBodies  = 0
nJoints  = 0
nBoxes   = 0
nSpheres = 0

resetSimulation()

' get curent desktop size
dim as integer w,h
ScreenInfo w,h:w*=0.75:h*=0.75
' run simulation
dsSimulationLoop (w,h,@fn)
' free resources
dJointGroupDestroy (ContactGroup)
dSpaceDestroy (WorldSpace)
dWorldDestroy (World)

end 0

