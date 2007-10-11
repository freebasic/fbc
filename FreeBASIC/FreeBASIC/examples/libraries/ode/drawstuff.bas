/'************************************************************************
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * Ported to FreeBASIC by D.J.Peters (Joshy) http://www.freebasic.eu     *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 ************************************************************************'/
#include "GL/gl.bi"
#include "GL/glu.bi"
#include "drawstuff.bi"
#include "internal.bi"

' constants to convert degrees to radians and the reverse


' light vector. LIGHTZ is implicitly 1
#define LIGHTX 1.0f
#define LIGHTY 0.4f

' ground and sky
#define SHADOW_INTENSITY (0.5)
#define GROUND_R (0.5f) ' ground color for when there's no texture
#define GROUND_G (0.5f)
#define GROUND_B (0.3f)

const ground_scale = 1.0f/5.0f ' ground texture scale (1/size)
const ground_ofsx  = 0.5       ' offset of ground texture
const ground_ofsy  = 0.5
const sky_scale    = 1.0f/16.0f ' sky texture scale (1/size)
const sky_height   = 3.0f      ' sky height above viewpoint

#macro dCROSS(a,op,b,c)
  (a)[0] op ((b)[1]*(c)[2] - (b)[2]*(c)[1]):
  (a)[1] op ((b)[2]*(c)[0] - (b)[0]*(c)[2]):
  (a)[2] op ((b)[0]*(c)[1] - (b)[1]*(c)[0]):
#endmacro

function dDOT (a as single ptr,b as single ptr) as single
  return ((a)[0]*(b)[0] + (a)[1]*(b)[1] + (a)[2]*(b)[2])
end function

sub normalizeVector3 (v as single ptr)
  dim as single l = v[0]*v[0] + v[1]*v[1] + v[2]*v[2]
  if (l <= 0.0f) then
    v[0] = 1
    v[1] = 0
    v[2] = 0
  else 
    l = 1.0f / sqr(l)
    v[0] *= l
    v[1] *= l
    v[2] *= l
  end if
end sub


' Texture object.
Type BMPHEADER Field = 1
  as ushort  fileid  
  as integer filesize
  as ushort  res1, res2
  as integer offset
  as integer headersize      
  as integer w,h    
  as short   planes, bitCount
  as integer compression, imagesize
  as integer pelsperX, pelspery
  as integer colorsinuse
  as integer colorsimportant
End Type
type PALENTRY field=1
  as ubyte r,g,b,f
end type
enum TEXTUREERRORS
  ok
  cantload
  nobmp
  wrongformat
end enum

type BMPTEXTURE
  as BMPHEADER descriptor
  as ubyte ptr     lpPixels
  as GLuint        glID
  declare function load(filename as string,targetbits as integer=24) as TEXTUREERRORS
  declare property w() as integer
  declare property h() as integer
  declare property pixels() as ubyte ptr
  declare sub      toGL()
  declare sub      bind(modulate as integer)
  declare sub      destroy()
end type

function BMPTEXTURE.load(filename  as string, _
                         targetbits as integer=24) as TEXTUREERRORS
  dim as integer   i,c,r,pitch,TargetAdd,SourceAdd,hFile
  dim as ubyte     onebyte
  dim as ubyte ptr lpImage,lpSourceRow,lpTargetRow
  dim as PALENTRY pal()
  'bits to bytes
  targetbits shr=3
  ' 2,3,4 bytes
  if targetbits<2 then return wrongformat

  hFile=FreeFile
  if open(filename for binary access read as #hFile)=0 then
    ' must be header + 4bytes = 1X1 bitmap
    if lof(hFile)<44 then
      close #hFile:return wrongformat
    end if
    ' read bmp header
    get #hFile,,this.descriptor
    ' is it a bmp
    if this.descriptor.fileid<>&H4D42 then
      close #hFile:return nobmp
    end if
    ' compression not supported
    if this.descriptor.compression<>0 then
      close #hFile:return wrongformat
    end if
    ' 1,2,4 bits not supported
    if this.descriptor.bitcount<8 then
      close #hFile:return wrongformat
    end if
    with this.descriptor
    ' seek to palette or image
    if .headersize>40 then
      for i=1 to .headersize-40
        get #hFile,,onebyte
      next
    end if
    ' get palette
    if .bitcount=8 then
      if .colorsinuse=0 then .colorsinuse=256
      ' read not more as defined
      redim pal(.colorsinuse-1)
      get #hFile,,pal()
    end if
    ' seek to first pixel / palleteentry
    seek #hFile,.offset

    ' get image from file and close
    lpImage=callocate(.imagesize)
    get #hFile,,*lpImage,.imagesize
    close #hFile
    ' bits to bytes
    .bitcount shr=3
    ' get pitch per row
    pitch =.imagesize \ abs(.h) 'can be -h
    pitch-=.w*.bitcount
    ' alloc texture memory for RGB 2,3,4 bytes
    this.lpPixels=allocate(.w*abs(.h)*targetbits)
    lpSourceRow=lpImage
    SourceAdd  =.w*.bitCount+pitch
    lpTargetRow=this.lpPixels
    TargetAdd  =.w*targetbits
    if .h<0 then
      .h=abs(.h):SourceAdd*=-1
      ' last row in source image
      lpSourceRow=lpImage+(.h-1)*SourceAdd
    end if
    
    ' NOTE: all in bytes not bits
    select case .bitcount
      case 1 ' source has palette
        select case targetbits 
          case 3
            for r=0 to .h-1
              for c=0 to .w-1
                 i=lpSourceRow[c]
                 lpTargetRow[c*targetbits+0]=pal(i).b
                 lpTargetRow[c*targetbits+1]=pal(i).g
                 lpTargetRow[c*targetbits+2]=pal(i).r
              next
              lpTargetRow+=TargetAdd
              lpSourceRow+=SourceAdd
            next
          case 4
        end select
      case 3
        for r=0 to .h-1
          for c=0 to .w-1
            lpTargetRow[c*targetbits+0]=lpSourceRow[c*.bitCount+0]
            lpTargetRow[c*targetbits+1]=lpSourceRow[c*.bitCount+2]
            lpTargetRow[c*targetbits+2]=lpSourceRow[c*.bitCount+1]
          next
          lpTargetRow+=TargetAdd
          lpSourceRow+=SourceAdd
        next
    end select

    end with

    if lpImage<>0 then deallocate lpImage
    return ok
  else
    return cantload
  end if
end function

sub BMPTEXTURE.destroy()
  if this.lpPixels<>0 then
    deallocate this.lpPixels
    this.lpPixels=0
  end if
end sub

property BMPTEXTURE.w() as integer
  return this.descriptor.w
end property
property BMPTEXTURE.h() as integer
  return this.descriptor.h
end property

sub BMPTEXTURE.bind (modulate as integer)
  glBindTexture (GL_TEXTURE_2D,this.glID)
  glTexEnvi (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE,iif(modulate,GL_MODULATE,GL_DECAL))
end sub

sub BMPTEXTURE.toGL()
  glGenTextures (1,@glID)
  glBindTexture (GL_TEXTURE_2D,glID)

  ' set pixel unpacking mode
  glPixelStorei (GL_UNPACK_SWAP_BYTES , 0)
  glPixelStorei (GL_UNPACK_ROW_LENGTH , 0)
  glPixelStorei (GL_UNPACK_ALIGNMENT  , 1)
  glPixelStorei (GL_UNPACK_SKIP_ROWS  , 0)
  glPixelStorei (GL_UNPACK_SKIP_PIXELS, 0)

  glTexImage2D (GL_TEXTURE_2D, 0, 3,this.w, this.h, 0, _
                 GL_RGB, GL_UNSIGNED_BYTE, this.lpPixels)
  gluBuild2DMipmaps (GL_TEXTURE_2D, 3, this.w, this.h, _
                     GL_RGB, GL_UNSIGNED_BYTE, this.lpPixels)

  ' set texture parameters - will these also be bound to the texture???
  glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
  glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)

  glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
  glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)

  glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL)
end sub

' the current drawing state (for when the user's step function is drawing)
dim shared as single  colors(3) = {0,0,0,0} ' current r,g,b,alpha color
dim shared as integer tnum = 0 ' current texture number


' OpenGL utility stuff
private _
sub setCamera (x as single,y as single,z as single, _
               h as single,p as single,r as single)
  glMatrixMode (GL_MODELVIEW)
  glLoadIdentity()
  glRotatef    (90, 0,0,1)
  glRotatef    (90, 0,1,0)
  glRotatef    ( r, 1,0,0)
  glRotatef    ( p, 0,1,0)
  glRotatef    (-h, 0,0,1)
  glTranslatef (-x,-y,-z)
end sub

' sets the material color, not the light color
private _
sub setColor (r as single, _
              g as single, _
              b as single, _
              a as single)
  dim as single light_ambient(3),light_diffuse(3),light_specular(3)
  light_ambient(0) = r*0.3f
  light_ambient(1) = g*0.3f
  light_ambient(2) = b*0.3f
  light_ambient(3) = a

  light_diffuse(0) = r*0.7f
  light_diffuse(1) = g*0.7f
  light_diffuse(2) = b*0.7f
  light_diffuse(3) = a

  light_specular(0) = r'*0.2f
  light_specular(1) = g'*0.2f
  light_specular(2) = b'*0.2f
  light_specular(3) = a
  glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT , @light_ambient(0))
  glMaterialfv (GL_FRONT_AND_BACK, GL_DIFFUSE , @light_diffuse(0))
  glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, @light_specular(0))
  glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 5.0f)
end sub

private _
sub setTransform (p as single ptr, _
                  R as single ptr) static
  static as GLfloat matrix(15)
  matrix(0)=R[0]
  matrix(1)=R[4]
  matrix(2)=R[8]
  matrix(3)=0
  matrix(4)=R[1]
  matrix(5)=R[5]
  matrix(6)=R[9]
  matrix(7)=0
  matrix(8)=R[2]
  matrix(9)=R[6]
  matrix(10)=R[10]
  matrix(11)=0
  matrix(12)=p[0]
  matrix(13)=p[1]
  matrix(14)=p[2]
  matrix(15)=1
  glPushMatrix()
  glMultMatrixf (@matrix(0))
end sub

private _
sub setTransformD (P as double ptr, _
                   R as double ptr) static
  dim as GLdouble matrix(15)
  matrix(0)=R[0]
  matrix(1)=R[4]
  matrix(2)=R[8]
  matrix(3)=0
  matrix(4)=R[1]
  matrix(5)=R[5]
  matrix(6)=R[9]
  matrix(7)=0
  matrix(8)=R[2]
  matrix(9)=R[6]
  matrix(10)=R[10]
  matrix(11)=0
  matrix(12)=P[0]
  matrix(13)=P[1]
  matrix(14)=P[2]
  matrix(15)=1
  glPushMatrix()
  glMultMatrixd(@matrix(0))
end sub

' set shadow projection transform
private _
sub setShadowTransform() static
  dim as GLfloat matrix(15)
  dim as integer i
  for i=0 to 15:matrix(i)=0:next
  matrix(0)=1
  matrix(5)=1
  matrix(8)=-LIGHTX
  matrix(9)=-LIGHTY
  matrix(15)=1
  glPushMatrix()
  glMultMatrixf (@matrix(0))
end sub

private _
sub drawConvex (_planes     as single ptr, _planecount as integer  , _
                _points     as single ptr, _pointcount as integer  , _
                _polygons   as integer ptr)
  dim as integer i,j,polyindex,pointcount
  for i=0 to _planecount-1
    pointcount=_polygons[polyindex]
    polyindex+=1
    glBegin (GL_POLYGON)
      glNormal3f(_planes[(i*4)+0], _
                 _planes[(i*4)+1], _
                 _planes[(i*4)+2])
      for j=0 to pointcount-1
        glVertex3f(_points[(_polygons[polyindex]*3)  ], _
                   _points[(_polygons[polyindex]*3)+1], _
                   _points[(_polygons[polyindex]*3)+2])
        polyindex+=1
      next
    glEnd()
  next
end sub

private _
sub drawConvexD(_planes     as double ptr, _planecount as integer  , _
                _points     as double ptr, _pointcount as integer  , _
                _polygons   as uinteger ptr)
  dim as integer i,j,polyindex,pointcount
  for i=0 to _planecount-1
    pointcount=_polygons[polyindex]
    polyindex+=1
    glBegin (GL_POLYGON)
      glNormal3f(_planes[(i*4)+0], _
                 _planes[(i*4)+1], _
                 _planes[(i*4)+2])
      for j=0 to pointcount-1
        glVertex3f(_points[ _polygons[polyindex]*3   ], _
                   _points[(_polygons[polyindex]*3)+1], _
                   _points[(_polygons[polyindex]*3)+2])
        polyindex+=1
      next
    glEnd()
  next
end sub

private _
sub drawBox (sides as single ptr)
  dim as single lx = sides[0]*0.5f
  dim as single ly = sides[1]*0.5f
  dim as single lz = sides[2]*0.5f
  ' sides
  glBegin (GL_TRIANGLE_STRIP)
   glNormal3f (-1,0,0)
   glVertex3f (-lx,-ly,-lz)
   glVertex3f (-lx,-ly, lz)
   glVertex3f (-lx, ly,-lz)
   glVertex3f (-lx, ly, lz)

   glNormal3f (  0,  1,  0)
   glVertex3f ( lx, ly,-lz)
   glVertex3f ( lx, ly, lz)

   glNormal3f (  1,  0,  0)
   glVertex3f ( lx,-ly,-lz)
   glVertex3f ( lx,-ly, lz)

   glNormal3f (  0, -1,  0)
   glVertex3f (-lx,-ly,-lz)
   glVertex3f (-lx,-ly, lz)
  glEnd()

  ' top face
  glBegin (GL_TRIANGLE_FAN)
   glNormal3f (  0,  0, 1)
   glVertex3f (-lx,-ly,lz)
   glVertex3f ( lx,-ly,lz)
   glVertex3f ( lx, ly,lz)
   glVertex3f (-lx, ly,lz)
  glEnd()

  ' bottom face
  glBegin (GL_TRIANGLE_FAN)
   glNormal3f (  0,  0,-1 )
   glVertex3f (-lx,-ly,-lz)
   glVertex3f (-lx, ly,-lz)
   glVertex3f ( lx, ly,-lz)
   glVertex3f ( lx,-ly,-lz)
  glEnd()
end sub


' This is recursively subdivides a triangular area (vertices p1,p2,p3) into
' smaller triangles, and then draws the triangles. All triangle vertices are
' normalized to a distance of 1.0 from the origin (p1,p2,p3 are assumed
' to be already normalized). Note this is not super-fast because it draws
' triangles rather than triangle strips.
private _
sub drawPatch (p1()  as  single, _
               p2()  as  single, _
               p3()  as  single, _
               level as integer)
  dim as integer i
  if (level > 0) then
    dim as single q1(2),q2(2),q3(2) ' sub-vertices
    for i=0 to 2
      q1(i) = 0.5f*(p1(i)+p2(i))
      q2(i) = 0.5f*(p2(i)+p3(i))
      q3(i) = 0.5f*(p3(i)+p1(i))
    next
    dim as single length1 = (1.0/sqr(q1(0)*q1(0)+q1(1)*q1(1)+q1(2)*q1(2)))
    dim as single length2 = (1.0/sqr(q2(0)*q2(0)+q2(1)*q2(1)+q2(2)*q2(2)))
    dim as single length3 = (1.0/sqr(q3(0)*q3(0)+q3(1)*q3(1)+q3(2)*q3(2)))
    for i=0 to 2
      q1(i) *= length1
      q2(i) *= length2
      q3(i) *= length3
    next

    drawPatch (p1(0),q1(0),q3(0),level-1)
    drawPatch (q1(0),p2(0),q2(0),level-1)
    drawPatch (q1(0),q2(0),q3(0),level-1)
    drawPatch (q3(0),q2(0),p3(0),level-1)
  else 
    'dsDebug( p1(0)& "," & p1(1) & "," & p1(2))
    'dsDebug( p2(0)& "," & p2(1) & "," & p2(2))
    'dsDebug( p3(0)& "," & p3(1) & "," & p3(2))
    glNormal3f (p1(0),p1(1),p1(2))
    glVertex3f (p1(0),p1(1),p1(2))
    glNormal3f (p2(0),p2(1),p2(2))
    glVertex3f (p2(0),p2(1),p2(2))
    glNormal3f (p3(0),p3(1),p3(2))
    glVertex3f (p3(0),p3(1),p3(2))
  end if
end sub


' draw a sphere of radius 1
dim shared as integer sphere_quality = 1

private _
sub drawSphere()
  static as GLuint listnum = 0
  
  const NumOfPoints = (16 + 1) * (16 + 1)
  redim as glfloat points(NumOfPoints*3-1)
  
 
  dim as integer i
  if (listnum=0) then
    dim as single  UR,YP,VR,UW,VW,l
    dim as single  US = (m_PI*2) / 16
    dim as single  VS =  m_PI    / 16
    dim as integer PC =0
    For yc as integer = 0 To 16
      UR = Sin(VW) '* 0.5
      YP = Cos(VW) '* 0.5
      VR = Sin(VW) '* 0.5
      VW+=VS
          
      UW = 0
      For xc as integer = 0 To 16
        Points(PC*3+0)=Sin(UW) * UR
        Points(PC*3+1)=YP
        Points(PC*3+2)=Cos(m_PI + UW) * VR
        PC+=1: UW+=US
      Next
    Next
    listnum = glGenLists(1)
    glNewList (listnum,GL_COMPILE)
    glBegin (GL_TRIANGLES)
    For yc as integer = 0 To 16 - 1
      For xc as integer= 0 To 16 - 1
        dim as integer P0 = (yc + 0) * (16 + 1) + (xc + 0)
        dim as integer P1 = (yc + 0) * (16 + 1) + (xc + 1)
        dim as integer P2 = (yc + 1) * (16 + 1) + (xc + 1)
        dim as integer P3 = (yc + 1) * (16 + 1) + (xc + 0)
        dim as glfloat v(2),n(2)
        v(0)=Points(p0*3+0):v(1)=Points(p0*3+1):v(2)=Points(p0*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        NormalizeVector3(@n(0))
        glNormal3fv(@n(0)):glVertex3fv(@v(0))

        v(0)=Points(p1*3+0):v(1)=Points(p1*3+1):v(2)=Points(p1*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        NormalizeVector3(@n(0))
        glNormal3fv(@n(0)):glVertex3fv(@v(0))

        v(0)=Points(p3*3+0):v(1)=Points(p3*3+1):v(2)=Points(p3*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        l=n(0)*n(0) + n(1)*n(1) +n(2)*n(2)
        if l<>0 then
          l=1/sqr(l):n(0)*=l:n(1)*=l:n(2)*=l
        end if
        glNormal3fv(@n(0)):glVertex3fv(@v(0))

        v(0)=Points(p1*3+0):v(1)=Points(p1*3+1):v(2)=Points(p1*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        NormalizeVector3(@n(0))
        glNormal3fv(@n(0)):glVertex3fv(@v(0))

        v(0)=Points(p2*3+0):v(1)=Points(p2*3+1):v(2)=Points(p2*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        NormalizeVector3(@n(0))
        glNormal3fv(@n(0)):glVertex3fv(@v(0))

        v(0)=Points(p3*3+0):v(1)=Points(p3*3+1):v(2)=Points(p3*3+2)
        for i as integer=0 to 2:n(i)=v(i):next
        NormalizeVector3(@n(0))
        glNormal3fv(@n(0)):glVertex3fv(@v(0))
      Next
    Next
    glEnd()
    glEndList()
  end if
  glCallList(listnum)
end sub

private _
sub drawSphereShadow (px as single, _
                      py as single, _
                      pz as single, _
                      radius as single) static
  ' calculate shadow constants based on light vector
  static as integer init=0
  static as single  len2,len1,scale,x,y,x2,y2,xtmp
  if (init=0) then
    len2 = LIGHTX*LIGHTX + LIGHTY*LIGHTY
    len1 = 1.0f/sqr(len2)
    scale = sqr(len2 + 1)
    init = 1
  end if

  ' map sphere center to ground plane based on light vector
  px -= LIGHTX*pz
  py -= LIGHTY*pz

  const as single kx = 0.96592582628907f
  const as single ky = 0.25881904510252f
  x=radius:y=0
  
  glBegin (GL_TRIANGLE_FAN)
  for i as integer=0 to 22
    ' for all points on circle, scale to elongated rotated shadow and draw
    x2 = (LIGHTX*x*scale - LIGHTY*y)*len1 + px
    y2 = (LIGHTY*x*scale + LIGHTX*y)*len1 + py
    glTexCoord2f (x2*ground_scale+ground_ofsx,y2*ground_scale+ground_ofsy)
    glVertex3f (x2,y2,0)

    ' rotate [x,y] vector
    xtmp = kx*x - ky*y
    y = ky*x + kx*y
    x = xtmp
  next
  glEnd()
end sub

private _
sub drawTriangle (v0 as single ptr, _
                  v1 as single ptr, _
                  v2 as single ptr, _
                  solid as integer)
  static as single u(2),v(2),n(2)
  
  u(0) = v1[0] - v0[0]
  u(1) = v1[1] - v0[1]
  u(2) = v1[2] - v0[2]
  v(0) = v2[0] - v0[0]
  v(1) = v2[1] - v0[1]
  v(2) = v2[2] - v0[2]

  dCROSS (@n(0),=,@u(0),@v(0))
  normalizeVector3(@n(0))

  glBegin(iif(solid,GL_TRIANGLES,GL_LINE_STRIP))
   glNormal3fv (@n(0))
   glVertex3fv (v0)
   glVertex3fv (v1)
   glVertex3fv (v2)
  glEnd()

end sub

private _
sub drawTriangleD(v0 as double ptr, _
                  v1 as double ptr, _ 
                  v2 as double ptr, _
                  solid as integer)
  dim as single ptr u,v,normal
  u=callocate(sizeof(single)*3)
  v=callocate(sizeof(single)*3)
  normal=callocate(sizeof(single)*3)

  u[0] = csng( v1[0] - v0[0] )
  u[1] = csng( v1[1] - v0[1] )
  u[2] = csng( v1[2] - v0[2] )
  v[0] = csng( v2[0] - v0[0] )
  v[1] = csng( v2[1] - v0[1] )
  v[2] = csng( v2[2] - v0[2] )
  dCROSS (normal,=,u,v)
  normalizeVector3 (normal)

  glBegin(iif(solid,GL_TRIANGLES,GL_LINE_STRIP))
   glNormal3fv (normal)
   glVertex3dv (v0)
   glVertex3dv (v1)
   glVertex3dv (v2)
  glEnd()
  deallocate u
  deallocate v
  deallocate normal
end sub


' draw a capped cylinder of length l and radius r, aligned along the x axis
dim shared as integer capped_cylinder_quality = 3
private _
sub drawCapsule(l as single, r as single)
  dim as integer i,j,n
  dim as single tmp,nx,ny,nz,start_nx,start_ny,a,ca,sa
  ' number of sides to the cylinder (divisible by 4):
  n = capped_cylinder_quality*4

  l *= 0.5
  a = (M_PI*2.0)/n
  sa = sin(a)
  ca = cos(a)

  ' draw cylinder body
  nx=0:ny=1:nz=0 ' normal vector = (0,ny,nz)
  glBegin (GL_TRIANGLE_STRIP)
  for i=0 to n
    glNormal3d (ny,nz,0)
    glVertex3d (ny*r,nz*r,l)
    glNormal3d (ny,nz,0)
    glVertex3d (ny*r,nz*r,-l)
    ' rotate ny,nz
    tmp = ca*ny - sa*nz
    nz  = sa*ny + ca*nz
    ny  = tmp
  next
  glEnd()

  ' draw first cylinder cap
  start_nx = 0
  start_ny = 1
  for j=0 to (n/4)-1
    ' get start_n2 = rotated start_n
    dim as single start_nx2 =  ca*start_nx + sa*start_ny
    dim as single start_ny2 = -sa*start_nx + ca*start_ny
    ' get n=start_n and n2=start_n2
    nx = start_nx: ny = start_ny: nz = 0
    dim as single nx2 = start_nx2, ny2 = start_ny2, nz2 = 0
    glBegin (GL_TRIANGLE_STRIP)
    for i= 0 to n
      glNormal3d (ny2,nz2,nx2)
      glVertex3d (ny2*r,nz2*r,l+nx2*r)
      glNormal3d (ny,nz,nx)
      glVertex3d (ny*r,nz*r,l+nx*r)
      ' rotate n,n2
      tmp = ca*ny - sa*nz
      nz  = sa*ny + ca*nz
      ny  = tmp
      tmp = ca*ny2 - sa*nz2
      nz2 = sa*ny2 + ca*nz2
      ny2 = tmp
    next
    glEnd()
    start_nx = start_nx2
    start_ny = start_ny2
  next

  ' draw second cylinder cap
  start_nx = 0
  start_ny = 1
  for j=0 to (n/4)-1
    ' get start_n2 = rotated start_n
    dim as single start_nx2 = ca*start_nx - sa*start_ny
    dim as single start_ny2 = sa*start_nx + ca*start_ny
    ' get n=start_n and n2=start_n2
    nx = start_nx: ny = start_ny: nz = 0
    dim as single nx2 = start_nx2, ny2 = start_ny2, nz2 = 0
    glBegin (GL_TRIANGLE_STRIP)
    for i=0 to n
      glNormal3d (ny,nz,nx)
      glVertex3d (ny*r,nz*r,-l+nx*r)
      glNormal3d (ny2,nz2,nx2)
      glVertex3d (ny2*r,nz2*r,-l+nx2*r)
      ' rotate n,n2
      tmp = ca*ny - sa*nz
      nz  = sa*ny + ca*nz
      ny  = tmp
      tmp = ca*ny2 - sa*nz2
      nz2 = sa*ny2 + ca*nz2
      ny2 = tmp
    next
    glEnd()
    start_nx = start_nx2
    start_ny = start_ny2
  next
  glPopMatrix()
end sub

' draw a cylinder of length l and radius r, aligned along the z axis
private _
sub drawCylinder (l as single,r as single,zoffset as single)
  dim as integer i,n
  dim as single tmp,ny,nz,a,ca,sa
  n = 24 ' number of sides to the cylinder (divisible by 4)

  l *= 0.5
  a  = (M_PI*2.0)/n
  sa = sin(a)
  ca = cos(a)

  ' draw cylinder body
  ny=1: nz=0: ' normal vector = (0,ny,nz)
  glBegin (GL_TRIANGLE_STRIP)
  for i=0 to n
    glNormal3d (ny,nz,0)
    glVertex3d (ny*r,nz*r, l+zoffset)
    glNormal3d (ny,nz,0)
    glVertex3d (ny*r,nz*r,-l+zoffset)
    ' rotate ny,nz
    tmp = ca*ny - sa*nz
    nz  = sa*ny + ca*nz
    ny  = tmp
  next
  glEnd()

  ' draw top cap
  glShadeModel (GL_FLAT)
  ny=1: nz=0 ' normal vector = (0,ny,nz)
  glBegin (GL_TRIANGLE_FAN)
  glNormal3d (0,0,1)
  glVertex3d (0,0,l+zoffset)
  for i=0 to n
    if (i=1) or (i=n/2+1) then
      setColor (1,1,0,1)
    end if
    glNormal3d (0,0,1)
    glVertex3d (ny*r,nz*r,l+zoffset)
    if (i=1) or (i=n/2+1) then
      setColor (colors(0),colors(1),colors(2),colors(3))
    end if
    ' rotate ny,nz
    tmp = ca*ny - sa*nz
    nz  = sa*ny + ca*nz
    ny  = tmp
  next
  glEnd()

  ' draw bottom cap
  ny=1: nz=0 ' normal vector = (0,ny,nz)
  glBegin (GL_TRIANGLE_FAN)
  glNormal3d (0,0,-1)
  glVertex3d (0,0,-l+zoffset)
  for i=0 to n
    if (i=1) or (i=n/2+1) then
      setColor (1,1,0,1)
    end if
    glNormal3d (0,0,-1)
    glVertex3d (ny*r,nz*r,-l+zoffset)
    if (i=1) or (i=n/2+1) then
      setColor (colors(0),colors(1),colors(2),colors(3))
    end if
    ' rotate ny,nz
    tmp =  ca*ny + sa*nz
    nz  = -sa*ny + ca*nz
    ny  = tmp
  next
  glEnd()
end sub

' current camera position and orientation
dim shared as single view_xyz(2)' position x,y,z
dim shared as single view_hpr(2)' heading, pitch, roll (degrees)

' initialize the above variables
private _
sub initMotionModel() static
  view_xyz(0) = 2
  view_xyz(1) = 0
  view_xyz(2) = 1
  view_hpr(0) = 180
  view_hpr(1) = 0
  view_hpr(2) = 0
end sub

private _
sub wrapCameraAngles() static
  dim as integer i
  for i=0 to 2
    while (view_hpr(i) >  180):view_hpr(i) -= 360:wend
    while (view_hpr(i) < -180):view_hpr(i) += 360:wend
  next
end sub

' call this to update the current camera position. the bits in `mode' say
' if the left (1), middle (2) or right (4) mouse button is pressed, and
' (deltax,deltay) is the amount by which the mouse pointer has moved.
sub dsMotion (mode   as integer, _
              deltax as integer, _
              deltay as integer) export
  dim as single side = 0.01f * csng(deltax)
  dim as single fwd  = iif(mode=4,0.01f * csng(deltay),0.0f)
  dim as single s    = sin(view_hpr(0)*DEG_TO_RAD)
  dim as single c    = cos(view_hpr(0)*DEG_TO_RAD)

  if (mode=1) then
    view_hpr(0) += csng(deltax) * 0.5f
    view_hpr(1) += csng(deltay) * 0.5f
  else 
    view_xyz(0) += -s*side + c*fwd
    view_xyz(1) +=  c*side + s*fwd
    if (mode=2) or (mode=5) then view_xyz(2) += 0.01f * csng(deltay)
  end if
  wrapCameraAngles()
end sub


' drawing loop stuff
' the current state:
'    0 = uninitialized
'    1 = dsSimulationLoop() called
'    2 = dsDrawFrame() called
dim shared as integer current_state = 0

' textures and shadows
dim shared as integer use_textures=1 ' 1 if textures to be drawn
dim shared as integer use_shadows =1 ' 1 if shadows to be drawn
dim shared as integer use_fog     =0 ' 1 if fog to be drawn
dim shared as BMPTEXTURE sky_texture
dim shared as BMPTEXTURE ground_texture
dim shared as BMPTEXTURE wood_texture

sub dsStartGraphics (w as integer, _
                     h as integer, _
                     fn as dsFunctions ptr) export
  dim as TEXTUREERRORS ok1,ok2,ok3

  if ok1=sky_texture.load   ("sky.bmp"   ) then sky_texture.toGL
  if ok2=ground_texture.load("ground.bmp") then ground_texture.toGL
  if ok3=wood_texture.load  ("wood.bmp"  ) then wood_texture.toGL
  if ok1<>ok or ok2<>ok or ok3<>ok then
    dsDebug("dsStartGraphics: problem while loading textures!")
    use_textures=0
  end if
end sub

sub dsStopGraphics() export
'dsDebug("dsStopGraphics: destroy textures")
  sky_texture.destroy
  ground_texture.destroy
  wood_texture.destroy
'dsDebug("dsStopGraphics: ok")
end sub

private _
sub drawSky (view_xyz as single ptr)
  static as single offset = 0.0f
  glDisable (GL_LIGHTING)
  if (use_textures) then
    glEnable (GL_TEXTURE_2D)
    sky_texture.bind(0)
  else 
    glDisable (GL_TEXTURE_2D)
    glColor3f (0,0.5,1.0)
  end if

  ' make sure sky depth is as far back as possible
  glShadeModel (GL_FLAT)
  glEnable     (GL_DEPTH_TEST)
  glDepthFunc  (GL_LEQUAL)
  glDepthRange (1,1)

  const as single ssize = 1000.0f
  dim as single x = ssize*sky_scale
  dim as single z = view_xyz[2] + sky_height

  glBegin (GL_QUADS)
   glNormal3f (0,0,-1)
   glTexCoord2f (-x+offset,-x+offset)
   glVertex3f   (-ssize+view_xyz[0],-ssize+view_xyz[1],z)
   glTexCoord2f (-x+offset,x+offset)
   glVertex3f   (-ssize+view_xyz[0],ssize+view_xyz[1],z)
   glTexCoord2f (x+offset,x+offset)
   glVertex3f   (ssize+view_xyz[0],ssize+view_xyz[1],z)
   glTexCoord2f (x+offset,-x+offset)
   glVertex3f   (ssize+view_xyz[0],-ssize+view_xyz[1],z)
  glEnd()

  offset = offset + 0.0001f
  if (offset > 1) then offset -= 1

  glDepthFunc (GL_LESS)
  glDepthRange (0,1)
end sub

private _
sub drawGround() static
  static as GLfloat fogColor(3) = {0.5, 0.5,0.5, 1}

  glDisable(GL_LIGHTING)
  glShadeModel(GL_FLAT)
  glEnable (GL_DEPTH_TEST)
  glDepthFunc (GL_LESS)
  ' glDepthRange (1,1)

  if (use_textures) then
    glEnable (GL_TEXTURE_2D)
    ground_texture.bind (0)
  else
    glDisable (GL_TEXTURE_2D)
    glColor3f (GROUND_R,GROUND_G,GROUND_B)
  end if

  if use_fog then
    glEnable (GL_FOG)
    glFogi (GL_FOG_MODE, GL_EXP2)
    glFogfv (GL_FOG_COLOR, @fogColor(0))
    glFogf (GL_FOG_DENSITY, 0.1)
    glHint (GL_FOG_HINT, GL_NICEST) ' GL_DONT_CARE)
    glFogf (GL_FOG_START, 0.9)
    glFogf (GL_FOG_END, 1)
  else
    glDisable (GL_FOG)
  end if

  const as single gsize = 100.0f
  const as single offset = 0 ' -0.001f ' polygon offsetting doesn't work well

  glBegin (GL_QUADS)
   glNormal3f (0,0,1)
   glTexCoord2f (-gsize*ground_scale + ground_ofsx, _
                 -gsize*ground_scale + ground_ofsy)
   glVertex3f   (-gsize,-gsize,offset)
   glTexCoord2f ( gsize*ground_scale + ground_ofsx, _
                 -gsize*ground_scale + ground_ofsy)
   glVertex3f   ( gsize,-gsize,offset)
   glTexCoord2f ( gsize*ground_scale + ground_ofsx, _
                  gsize*ground_scale + ground_ofsy)
   glVertex3f   ( gsize,gsize,offset)
   glTexCoord2f (-gsize*ground_scale + ground_ofsx, _
                  gsize*ground_scale + ground_ofsy)
   glVertex3f   (-gsize,gsize,offset)
  glEnd()
  glDisable(GL_FOG)
end sub

private _
sub drawPyramidGrid() static
  ' setup stuff
  glEnable     (GL_LIGHTING)
  glDisable    (GL_TEXTURE_2D)
  glShadeModel (GL_FLAT)
  glEnable     (GL_DEPTH_TEST)
  glDepthFunc  (GL_LESS)

  ' draw the pyramid grid
  dim as integer i,j
  for i=-1 to 1
    for j=-1 to 1
      glPushMatrix()
      glTranslatef (i,j,0)
      if (i=1) and (j=0) then
        setColor (1,0,0,1)
      elseif (i=0) and (j=1) then
        setColor (0,0,1,1)
      else 
        setColor (1,1,0,1)
      end if

      const as single k = 0.05f
      glBegin (GL_TRIANGLE_FAN)
       glNormal3f ( 0,-1,1)
       glVertex3f ( 0, 0,k)
       glVertex3f (-k,-k,0)
       glVertex3f ( k,-k,0)
       glNormal3f ( 1, 0,1)
       glVertex3f ( k, k,0)
       glNormal3f ( 0, 1,1)
       glVertex3f (-k, k,0)
       glNormal3f (-1, 0,1)
       glVertex3f (-k,-k,0)
      glEnd()
      glPopMatrix()
    next
  next
end sub

sub dsDrawFrame (w as integer, _
                 h as integer, _
                 fn     as dsFunctions ptr, _
                 pause  as integer) export
 
  if (current_state < 1) then dsDebug ("internal error")
  current_state = 2
 
  ' setup stuff
  glEnable     (GL_LIGHTING)
  glEnable     (GL_LIGHT0)
  glDisable    (GL_TEXTURE_2D)
  glDisable    (GL_TEXTURE_GEN_S)
  glDisable    (GL_TEXTURE_GEN_T)
  glShadeModel (GL_FLAT)
  glEnable     (GL_DEPTH_TEST)
  glDepthFunc  (GL_LESS)
  glEnable     (GL_CULL_FACE)
  glCullFace   (GL_BACK)
  glFrontFace  (GL_CCW)

  ' setup viewport
  glViewport (0,0,w,h)
  glMatrixMode (GL_PROJECTION)
  glLoadIdentity()
  const as single vnear =   0.1f
  const as single vfar  = 100.0f
  const as single k     =   0.8f ' view scale, 1 = +/- 45 degrees
  if (w >= h) then
    dim as single k2 = h/w
    glFrustum (-vnear*k,vnear*k,-vnear*k*k2,vnear*k*k2,vnear,vfar)
  else 
    dim as single k2 = w/h
    glFrustum (-vnear*k*k2,vnear*k*k2,-vnear*k,vnear*k,vnear,vfar)
  end if

  ' setup lights. it makes a difference whether this is done in the
  ' GL_PROJECTION matrix mode (lights are scene relative) or the
  ' GL_MODELVIEW matrix mode (lights are camera relative, bad!).
  static as GLfloat light_ambient(3)  = { 0.75, 0.75, 0.75, 1.0 }
  static as GLfloat light_diffuse(3)  = { 1.0, 1.0, 1.0, 1.0 }
  static as GLfloat light_specular(3) = { 1.0, 1.0, 1.0, 1.0 }
  glLightfv (GL_LIGHT0, GL_AMBIENT ,@light_ambient(0) )
  glLightfv (GL_LIGHT0, GL_DIFFUSE ,@light_diffuse(0) )
  glLightfv (GL_LIGHT0, GL_SPECULAR,@light_specular(0))
  glColor3f (1.0, 1.0, 1.0)

  ' clear the window
  glClearColor (0.5,0.5,0.5,1)
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

  ' snapshot camera position (in MS Windows it is changed by the GUI thread)
  dim as single view2_xyz(2)
  dim as single view2_hpr(2)
  dim as integer i
  for i=0 to 2
   view2_xyz(i)=view_xyz(i)
   view2_hpr(i)=view_hpr(i)
  next
  ' go to GL_MODELVIEW matrix mode and set the camera
  glMatrixMode (GL_MODELVIEW)
  glLoadIdentity()
  setCamera (view2_xyz(0),view2_xyz(1),view2_xyz(2), _
             view2_hpr(0),view2_hpr(1),view2_hpr(2))

  ' set the light position (for some reason we have to do this in model view.
  static as GLfloat light_position(3) = { LIGHTX, LIGHTY, 1.0, 0.0 }
  glLightfv (GL_LIGHT0, GL_POSITION, @light_position(0))

  ' draw the background (ground, sky etc)
  drawSky (@view2_xyz(0))
  drawGround()

  ' draw the little markers on the ground
  drawPyramidGrid()

  ' leave openGL in a known state - flat shaded white, no textures
  glEnable     (GL_LIGHTING)
  glDisable    (GL_TEXTURE_2D)
  glShadeModel (GL_FLAT)
  glEnable     (GL_DEPTH_TEST)
  glDepthFunc  (GL_LESS)
  glColor3f    (1,1,1)
  setColor     (1,1,1,1)

  'draw the rest of the objects. set drawing state first.
  colors(0) = 1
  colors(1) = 1
  colors(2) = 1
  colors(3) = 1
  tnum = 0
  if fn<>0 then
    if (fn->_step<>0) then fn->_step(pause)
  end if
end sub

function dsGetShadows() as integer export
  return use_shadows
end function
sub dsSetShadows (a as integer) export
  use_shadows = a
end sub
function dsGetTextures() as integer export
  return use_textures
end function
sub dsSetTextures (a as integer) export
  use_textures = a
end sub
function dsGetFog() as integer export
  return use_fog
end function
sub dsSetFog (a as integer) export
  use_fog = a
end sub

' C interface
' sets lighting and texture modes, sets current color
private _
sub setupDrawingMode() static
  static as GLfloat s_params(3) = {1.0f,1.0f,0.0f,1}
  static as GLfloat t_params(3) = {0.817f,-0.817f,0.817f,1}
  
  glEnable (GL_LIGHTING)
  if (tnum) then
    if (use_textures) then
      glEnable (GL_TEXTURE_2D)
      wood_texture.bind(1)
      glEnable (GL_TEXTURE_GEN_S)
      glEnable (GL_TEXTURE_GEN_T)
      glTexGeni (GL_S,GL_TEXTURE_GEN_MODE,GL_OBJECT_LINEAR)
      glTexGeni (GL_T,GL_TEXTURE_GEN_MODE,GL_OBJECT_LINEAR)
      glTexGenfv (GL_S,GL_OBJECT_PLANE,@s_params(0))
      glTexGenfv (GL_T,GL_OBJECT_PLANE,@t_params(0))
    else 
      glDisable(GL_TEXTURE_2D)
    end if
  else 
    glDisable (GL_TEXTURE_2D)
  end if
  setColor (colors(0),colors(1),colors(2),colors(3))
  if (color(3) < 1.0) then
    glEnable (GL_BLEND)
    glBlendFunc (GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
  else
    'glDisable (GL_BLEND)
  end if
end sub

private _
sub setShadowDrawingMode() static
  static as GLfloat s_params(3) = {ground_scale,0,0,ground_ofsx}
  static as GLfloat t_params(3) = {0,ground_scale,0,ground_ofsy}
    
  glDisable (GL_LIGHTING)
  if (use_textures) then
    glEnable (GL_TEXTURE_2D)
    ground_texture.bind(1)
    glColor3f (SHADOW_INTENSITY,SHADOW_INTENSITY,SHADOW_INTENSITY)
    glEnable (GL_TEXTURE_2D)
    glEnable (GL_TEXTURE_GEN_S)
    glEnable (GL_TEXTURE_GEN_T)
    glTexGeni (GL_S,GL_TEXTURE_GEN_MODE,GL_EYE_LINEAR)
    glTexGeni (GL_T,GL_TEXTURE_GEN_MODE,GL_EYE_LINEAR)
    glTexGenfv (GL_S,GL_EYE_PLANE,@s_params(0))
    glTexGenfv (GL_T,GL_EYE_PLANE,@t_params(0))
  else
    glDisable (GL_TEXTURE_2D)
    glColor3f (GROUND_R * SHADOW_INTENSITY, _
               GROUND_G * SHADOW_INTENSITY, _
               GROUND_B * SHADOW_INTENSITY)
  end if
  glDepthRange (0,0.9999)
end sub

sub dsSimulationLoop (window_width as integer, _
                      window_height as integer, _
                      fn as dsFunctions ptr) export

  if (current_state <> 0) then dsError ("dsSimulationLoop() called more than once")
  current_state = 1
  ' look for flags that apply to us
  dim as integer initial_pause = 0

  if (fn->version > DS_VERSION) then
    dsDebug ("dsSimulationLoop: bad version number in dsFunctions structure")
  end if
  initMotionModel()
  dsPlatformSimLoop (window_width,window_height,fn,initial_pause)
  current_state = 0
end sub


sub dsSetViewpoint (xyz as single ptr, _
                    hpr as single ptr) export
  if (current_state < 1) then dsError ("dsSetViewpoint() called before simulation started")
  if (xyz<>0) then
    view_xyz(0) = xyz[0]
    view_xyz(1) = xyz[1]
    view_xyz(2) = xyz[2]
  end if
  if (hpr<>0) then
    view_hpr(0) = hpr[0]
    view_hpr(1) = hpr[1]
    view_hpr(2) = hpr[2]
    wrapCameraAngles()
  end if
end sub

sub dsGetViewpoint(xyz as single ptr,hpr as single ptr) export
  if (current_state < 1) then dsError ("dsGetViewpoint() called before simulation started")
  if (xyz<>0) then
    xyz[0] = view_xyz(0)
    xyz[1] = view_xyz(1)
    xyz[2] = view_xyz(2)
  end if
  if (hpr<>0) then
    hpr[0] = view_hpr(0)
    hpr[1] = view_hpr(1)
    hpr[2] = view_hpr(2)
  end if
end sub

sub dsSetTexture (texture_number as integer) export
  if (current_state <> 2) then dsError ("drawing function called outside simulation loop")
  tnum = texture_number
end sub

sub dsSetColor (r as single, _
                g as single, _
                b as single) export
  if (current_state <> 2) then dsError ("dsSetcolor called outside simulation loop")
  colors(0) = r
  colors(1) = g
  colors(2) = b
  colors(3) = 1
end sub


sub dsSetColorAlpha(r as single, _
                    g as single, _
                    b as single, _
                    a as single) export
  if (current_state <> 2) then dsError ("dsSetColoAlpha called outside simulation loop")
  colors(0) = r
  colors(1) = g
  colors(2) = b
  colors(3) = a
end sub

sub dsDrawBox (P as single ptr, _
               R as single ptr, _
               sides as single ptr) export
  if (current_state <> 2) then dsError ("dsDrawBox called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_FLAT)
  setTransform (P,R)
  drawBox (sides)
  glPopMatrix()

  if (use_shadows) then
    setShadowDrawingMode()
    setShadowTransform()
    setTransform (P,R)
    drawBox (sides)
    glPopMatrix()
    glPopMatrix()
    glDepthRange (0,10)
  end if
end sub

sub dsDrawConvex(P           as single ptr, _
                 R           as single ptr, _
                 _planes     as single ptr, _
                 _planecount as integer  , _
                 _points     as single ptr, _
                 _pointcount as integer  , _
                 _polygons   as integer ptr) export
  if (current_state <> 2) then dsError ("dsDrawConvex called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_FLAT)
  setTransform (P,R)
  drawConvex(_planes,_planecount,_points,_pointcount,_polygons)
  glPopMatrix()
  if (use_shadows) then
    setShadowDrawingMode()
    setShadowTransform()
    setTransform (P,R)
    drawConvex(_planes,_planecount,_points,_pointcount,_polygons)
    glPopMatrix()
    glPopMatrix()
    glDepthRange (0,1)
  end if
end sub

sub dsDrawSphere(P as single ptr, _
                 R as single ptr, _
                 radius as single) export
  if (current_state <>2) then dsError ("dsDrawSphere called outside simulation loop")
  setupDrawingMode()
  glEnable (GL_NORMALIZE)
  glShadeModel (GL_SMOOTH)
  setTransform (P,R)
  glScaled (radius,radius,radius)
  drawSphere()
  glPopMatrix()
  glDisable (GL_NORMALIZE)

  if (use_shadows) then
    glDisable (GL_LIGHTING)
    if (use_textures) then
      ground_texture.bind(1)
      glEnable (GL_TEXTURE_2D)
      glDisable (GL_TEXTURE_GEN_S)
      glDisable (GL_TEXTURE_GEN_T)
      glColor3f (SHADOW_INTENSITY,SHADOW_INTENSITY,SHADOW_INTENSITY)
    else
      glDisable (GL_TEXTURE_2D)
      glColor3f (GROUND_R*SHADOW_INTENSITY, _
                 GROUND_G*SHADOW_INTENSITY, _
                 GROUND_B*SHADOW_INTENSITY)
    end if
    glShadeModel (GL_FLAT)
    glDepthRange (0,0.9999)
    drawSphereShadow (p[0],p[1],p[2],radius)
    glDepthRange (0,1)
  end if
end sub

sub dsDrawTriangle (P     as single ptr, _
                    R     as single ptr, _
                    v0    as single ptr, _
                    v1    as single ptr, _
                    v2    as single ptr, _
                    solid as integer) export

  if (current_state<>2) then dsError ("dsDrawTriangle called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_FLAT)
  setTransform (P,R)
  drawTriangle (v0, v1, v2, solid)
  glPopMatrix()
end sub

sub dsDrawCylinder(P    as single ptr, _
                   R    as single ptr, _
                   length as single, _
                   radius as single) export

  if (current_state<>2) then dsError ("dsDrawCylinder called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_SMOOTH)
  setTransform (P,R)
  drawCylinder (length,radius,0)
  glPopMatrix()

  if (use_shadows) then
    setShadowDrawingMode()
    setShadowTransform()
    setTransform (P,R)
    drawCylinder (length,radius,0)
    glPopMatrix()
    glPopMatrix()
    glDepthRange(0,1)
  end if
end sub


sub dsDrawCapsule(P      as single ptr, _
                  R      as single ptr, _
                  length as single, _
                  radius as single) export
  if (current_state<>2) then dsError ("dsDrawCapsule called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_SMOOTH)
  setTransform (P,R)
  drawCapsule (length,radius)
  glPopMatrix()

  if (use_shadows) then
    setShadowDrawingMode()
    setShadowTransform()
    setTransform (P,R)
    drawCapsule (length,radius)
    glPopMatrix()
    glPopMatrix()
    glDepthRange (0,1)
  end if
end sub

sub dsDrawLine (pos1 as single ptr, _
                pos2 as single ptr) export
  setupDrawingMode()
  glColor3f (colors(0),colors(1),colors(2))
  glDisable (GL_LIGHTING)
  glLineWidth(1)
  glShadeModel(GL_FLAT)
  glBegin(GL_LINES)
  glVertex3f (pos1[0],pos1[1],pos1[2])
  glVertex3f (pos2[0],pos2[1],pos2[2])
  glEnd()
end sub

sub dsDrawBoxD (P as double ptr, _
                R as double ptr, _
                S as double ptr) export
  dim as integer i
  dim as single P2(2),R2(11),S2(2)

  for i=0 to  2:P2(i)=p[i]:next
  for i=0 to 11:R2(i)=R[i]:next
  for i=0 to  2:S2(i)=S[i]:next
  dsDrawBox(@P2(0),@R2(0),@S2(0))
end sub

sub dsDrawConvexD(P           as double ptr, _
                  R           as double ptr, _
                  _planes     as double ptr, _
                  _planecount as uinteger  , _
                  _points     as double ptr, _
                  _pointcount as uinteger  , _
                  _polygons   as uinteger ptr) export
  if (current_state<>2) then dsError ("dsDrawConvexD called outside simulation loop")
  setupDrawingMode()
  glShadeModel (GL_FLAT)
  setTransformD (P,R)
  drawConvexD(_planes,_planecount,_points,_pointcount,_polygons)
  glPopMatrix()
  if (use_shadows) then
    setShadowDrawingMode()
    setShadowTransform()
    setTransformD (P,R)
    drawConvexD(_planes,_planecount,_points,_pointcount,_polygons)
    glPopMatrix()
    glPopMatrix()
    glDepthRange(0,1)
  end if
end sub


sub dsDrawSphereD (P as double ptr, _
                   R as double ptr, _
                   radius as single) export
  dim as integer i
  dim as single p2(2),R2(11)
  for i=0 to  2:p2(i)=p[i]:next
  for i=0 to 11:R2(i)=R[i]:next
  dsDrawSphere (@p2(0),@R2(0),radius)
end sub

sub dsDrawTriangleD (P     as double ptr   , _
                     R     as double ptr   , _
                     v0    as double ptr, _
                     v1    as double ptr, _
                     v2    as double ptr, _
                     solid as integer) export
  dim as integer i
  dim as single P2(2),R2(11)
  for i=0 to i< 2:P2(i)=P[i]:next
  for i=0 to i<11:R2(i)=R[i]:next

  setupDrawingMode()
  glShadeModel (GL_FLAT)
  setTransform (@P2(0),@R2(0))
  drawTriangleD (v0, v1, v2, solid)
  glPopMatrix()
end sub


sub dsDrawCylinderD(P      as double ptr, _
                    R      as double ptr, _
                    length as single, _
                    radius as single) export
  dim as integer i
  dim as single P2(2),R2(11)
  for i=0 to  2:P2(i)=P[i]:next
  for i=0 to 11:R2(i)=R[i]:next
  dsDrawCylinder (@p2(0),@R2(0),length,radius)
end sub

sub dsDrawCapsuleD (P as double ptr, _
                    R as double ptr, _
                    length as single, _
                   radius as single) export
  dim as integer i
  dim as single P2(2),R2(11)
  for i=0 to  2:P2(i)=P[i]:next
  for i=0 to 11:R2(i)=R[i]:next
  dsDrawCapsule (@P2(0),@R2(0),length,radius)
end sub

sub dsDrawLineD (_pos1 as double ptr, _
                 _pos2 as double ptr) export

  dim as integer i
  dim as single pos1(2),pos2(2)
  for i=0 to 2:pos1(i)=_pos1[i]:next
  for i=0 to 2:pos2(i)=_pos2[i]:next
  dsDrawLine (@pos1(0),@pos2(0))
end sub

sub dsSetSphereQuality (a as integer) export
  sphere_quality = a
end sub

sub dsSetCapsuleQuality (a as integer) export
  capped_cylinder_quality = a
end sub
