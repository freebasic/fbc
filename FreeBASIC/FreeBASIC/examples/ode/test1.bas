'************************************************************************
'* Examples for FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu *
'************************************************************************
#include "ode/ode.bi"
#include "drawstuff.bi"

' select correct drawing functions
#ifdef dDOUBLE
#define dsDrawBox dsDrawBoxD
#define dsDrawLine dsDrawLineD
#endif

' some constants
#define SIDEa 0.1f ' defth
#define SIDEb 0.5f ' width
#define SIDEc 2.0f ' height
#define MASS  10f         ' mass of a box
#define MAX_CONTACTS 8
#define GRAVITY      -0.981 ' slomotion
const as single stepsize=1f/30f ' = 30 FPS
' some globals
dim shared as dWorldID      world
dim shared as dSpaceID      world_space
dim shared as dGeomID       geomground,geombox
dim shared as dBodyID       bodybox
dim shared as dJointGroupID contactgroup
dim shared as dContact      contacts(MAX_CONTACTS-1)
dim shared as dJointID      hing
dim shared as integer draw_contacts = 1

' start simulation - set viewpoint
sub DoStart()
  static as single xyz(2) = {-3f,0f,3f}  ' from
  static as single hpr(2) = {0f,-45f,0f} ' 45 deg pitch
  dsSetViewpoint (@xyz(0),@hpr(0))
  dsPrint("press:")
  dsPrint("      ' ' drop it again")
  dsPrint("      'c' togle draw contacts")
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
  dim as string key=lcase(chr(cmd))
  select case key
    case "c":draw_contacts xor=1
    case " "
     dim as dMATRIX3    r
     dRFromAxisAndAngle(@r,1,0,0,0.0)
     dBodySetRotation(bodybox,r)
     dBodySetPosition(bodybox,0,0,4)
 
  end select
end sub
 
sub CollisionCallback cdecl (lpData as any ptr, _
                             o1     as dGeomID, _
                             o2     as dGeomID)
  static as dVector3 pos2
  static as integer  num_of_contacts
  ' our box and the ground must be involved
  dim as integer g1 = (o1 = geomground or o1 = geombox)
  dim as integer g2 = (o2 = geomground or o2 = geombox)
  if (g1 xor g2)=1 then return ' nothing to do
  ' how many contact points?
  num_of_contacts =dCollide(o1,o2,MAX_CONTACTS,@contacts(0).geom,sizeof(dContact))
  if (num_of_contacts > 0) then
    for i as integer=0 to num_of_contacts-1
      with contacts(i).surface
        .mode = dContactSlip1 _
              or dContactSlip2 _
              or dContactSoftERP _
              or dContactSoftCFM _
              or dContactApprox1
        .mu = dInfinity
        .slip1 = 0.5
        .slip2 = 0.1
        .soft_erp = 1.1  '(h*kp) / (h*kp+kd)
        .soft_cfm = 0.1  '1.0/(h*kp+kd)
      end with
      dim as dJointID c = dJointCreateContact(world,contactgroup,@contacts(i))
      dJointAttach (c,dGeomGetBody(contacts(i).geom.g1), _
                      dGeomGetBody(contacts(i).geom.g2))
      if draw_contacts then
        dsSetColor(1,1,0)
        with Contacts(i).geom
          for j as integer=0 to 2
            pos2.v(j)=.pos.v(j) + .normal.v(j)
          next
          dsDrawLine(@.pos.v(0),@pos2.v(0))
        end with
      end if
    next
  end if
end sub

' simulation loop
sub DoSimLoop(pause as integer)
  static as integer frames,fps
  static as double  t1
  dim    as double  t2
  dim    as single  curent_stepsize
  if t1=0 then t1=Timer()
  if curent_stepsize=0 then curent_stepsize=stepsize
  if (pause=0) then
    dSpaceCollide (world_space,NULL,@CollisionCallback)
    if fps=  0 then fps=50
    if fps< 10 then fps=10
    if fps>500 then fps=500
    dWorldStep(world,1f/fps)
    dJointGroupEmpty (contactgroup)
  end if

  ' draw it
  static as dReal sides(2) = {SIDEa,SIDEb,SIDEc}
  dsSetTexture (DS_WOOD)
  dsSetColor(0.3,0.6,0.9)
  dsDrawBox (dBodyGetPosition(bodybox), _
             dBodyGetRotation(bodybox),@sides(0))

  frames+=1
  if frames=50 then
    t2=Timer()
    fps=(frames/(t2-t1))
    WindowTitle "fps=" & fps
    t1=t2:frames=0
  end if
end sub

' 
' main 
'

Randomize Timer

' setup pointers to drawstuff callback functions
dim as dsFunctions fn
fn.version  = DS_VERSION
fn._start   = @DoStart
fn._step    = @DoSimLoop
fn._command = @DoCommand
fn._stop    = 0

' create world and set gravity
world = dWorldCreate()
dWorldSetGravity(world,0,0,GRAVITY)
' craete a contact group (faster to delete)
contactgroup = dJointGroupCreate(0)
' create an space for our objects
world_space = dHashSpaceCreate(0)
' the ground are an static object (geom only)
geomground = dCreatePlane(world_space,0,0,1,0)
' the box are an dynamic object (body and geom)
bodybox = dBodyCreate(world)
' set params for the dynamic box
dim as dMass m
dMassSetBoxTotal(@m,MASS,SIDEa,SIDEb,SIDEc)
' set the mass to the box
dBodySetMass      (bodybox,@m)
' set the position
dBodySetPosition  (bodybox,0,0,3)
' create the geom for our body box
geombox = dCreateBox(world_space,SIDEa,SIDEb,SIDEc)
' set it
dGeomSetBody (geombox,bodybox)

' get width and height from curent desktop
dim as integer w,h
screeninfo w,h:w*=0.5:h*=0.5
' run simulation
dsSimulationLoop (w,h,@fn)
dWorldDestroy (world)
end 0
