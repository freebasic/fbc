#ifndef _3DOBJECT_H_
#define _3DOBJECT_H_
#ifndef TRUE
#define TRUE = not FALSE
#endif

'' vertex in 3d-coordinate system
type sPoint
	x as single
	y as single
	z as single
end type

'' plane equation
type sPlaneEq
	a as single
	b as single
	c as single
	d as single
end type

'' structure describing an object's face
type sPlane
	p(0 to 2) as uinteger
	normals(0 to 2) as sPoint
	neigh(0 to 2) as uinteger
	PlaneEq as sPlaneEq
	visible as integer
end type

'' object structure
type glObject
	nPlanes as uinteger
	nPoints as uinteger
	points(0 to 99) as sPoint
	planes(0 to 199) as sPlane
end type

'' read in a line from the data file
private sub readstr(byval f as integer, byref sstring as string)
	sstring = ""
	do
		line input #f, sstring    '' Gets A String Of 255 Chars Max From f (File)
	loop while sstring = "" and not eof(f)
end sub

'' load object
private function ReadObject(byref st as string, byval o as glObject ptr) as integer
	dim as integer file
	dim as uinteger i
	dim oneline as string * 256

	file = freefile
	if (open(st, for input, as #file)<>0) then  return 0

	''points
	readstr(file, oneline)
	sscanf(strptr(oneline), "%d", @o->nPoints)
	for i=1 to o->nPoints
		readstr(file, oneline)
		sscanf(strptr(oneline), "%f %f %f", @o->points(i).x,@o->points(i).y,@o->points(i).z)
	next
	''planes
	readstr(file, oneline)
	sscanf(strptr(oneline), "%d", @o->nPlanes)
	for i=0 to o->nPlanes-1
		readstr(file, oneline)
		sscanf(strptr(oneline), "%d %d %d %f %f %f %f %f %f %f %f %f", _
			@o->planes(i).p(0), _
			@o->planes(i).p(1), _
			@o->planes(i).p(2), _
			@o->planes(i).normals(0).x, _
			@o->planes(i).normals(0).y, _
			@o->planes(i).normals(0).z, _
			@o->planes(i).normals(1).x, _
			@o->planes(i).normals(1).y, _
			@o->planes(i).normals(1).z, _
			@o->planes(i).normals(2).x, _
			@o->planes(i).normals(2).y, _
			@o->planes(i).normals(2).z)
	next
	return TRUE
end function

'' connectivity procedure - based on Gamasutra's article
'' hard to explain here
private sub SetConnectivity(byval o as glObject ptr)
	dim as uinteger p1i, p2i, p1j, p2j
	dim as uinteger b1i, b2i, b1j, b2j
	dim as uinteger i,j,ki,kj

	for i=0  to o->nPlanes-2
		for j=i+1 to o->nPlanes-1
			for ki=0 to 2
				if o->planes(i).neigh(ki) = 0 then
					for kj=0 to 2
						p1i=ki
						p1j=kj
						p2i=(ki+1) mod 3
						p2j=(kj+1) mod 3

						p1i=o->planes(i).p(p1i)
						p2i=o->planes(i).p(p2i)
						p1j=o->planes(j).p(p1j)
						p2j=o->planes(j).p(p2j)

						b1i=((p1i+p2i)-abs(p1i-p2i))\2
						b2i=((p1i+p2i)+abs(p1i-p2i))\2
						b1j=((p1j+p2j)-abs(p1j-p2j))\2
						b2j=((p1j+p2j)+abs(p1j-p2j))\2

						if ((b1i=b1j) and (b2i=b2j)) then  ''they are neighbours
							o->planes(i).neigh(ki) = j+1
							o->planes(j).neigh(kj) = i+1
						end if
					next
				end if
			next
		next
	next
end sub

'' function for computing a plane equation given 3 points
private sub CalcPlane(byval o as glObject ptr, byval plane as sPlane ptr)
	dim as sPoint v(0 to 3)
	dim as integer i

	for i=0  to 2
		v(i+1).x = o->points(plane->p(i)).x
		v(i+1).y = o->points(plane->p(i)).y
		v(i+1).z = o->points(plane->p(i)).z
	next
	plane->PlaneEq.a = v(1).y*(v(2).z-v(3).z) + v(2).y*(v(3).z-v(1).z) + v(3).y*(v(1).z-v(2).z)
	plane->PlaneEq.b = v(1).z*(v(2).x-v(3).x) + v(2).z*(v(3).x-v(1).x) + v(3).z*(v(1).x-v(2).x)
	plane->PlaneEq.c = v(1).x*(v(2).y-v(3).y) + v(2).x*(v(3).y-v(1).y) + v(3).x*(v(1).y-v(2).y)
	plane->PlaneEq.d =-( v(1).x*(v(2).y*v(3).z - v(3).y*v(2).z) + _
		v(2).x*(v(3).y*v(1).z - v(1).y*v(3).z) + _
		v(3).x*(v(1).y*v(2).z - v(2).y*v(1).z) )
end sub

'' procedure for drawing the object - very simple
private sub DrawGLObject(byval o as glObject ptr)
	dim as uinteger i, j

	glBegin(GL_TRIANGLES)
		for i=0 to o->nPlanes-1
			for j=0 to 2
				glNormal3f(o->planes(i).normals(j).x, _
					o->planes(i).normals(j).y, _
					o->planes(i).normals(j).z)
				glVertex3f(o->points(o->planes(i).p(j)).x, _
					o->points(o->planes(i).p(j)).y, _
					o->points(o->planes(i).p(j)).z)
			next
		next
	glEnd()
end sub

private sub  CastShadow(byval o as glObject ptr, byval lp as single ptr)
	dim as uinteger	i, j, k, jj
	dim as uinteger	p1, p2
	dim as sPoint v1, v2
	dim as single side

	'' set visual parameter
	for i=0 to o->nPlanes-1
		'' chech to see if light is in front or behind the plane (face plane)
		side =	o->planes(i).PlaneEq.a*lp[0]+ _
			o->planes(i).PlaneEq.b*lp[1]+ _
			o->planes(i).PlaneEq.c*lp[2]+ _
			o->planes(i).PlaneEq.d*lp[3]
		if (side >0) then
			o->planes(i).visible = 1
		else
			o->planes(i).visible = 0
		end if
	next

	glDisable(GL_LIGHTING)
	glDepthMask(GL_FALSE)
	glDepthFunc(GL_LEQUAL)

	glEnable(GL_STENCIL_TEST)
	glColorMask(0, 0, 0, 0)
	glStencilFunc(GL_ALWAYS, 1, &hffffffff)

	'' first pass, stencil operation decreases stencil value
	glFrontFace(GL_CCW)
	glStencilOp(GL_KEEP, GL_KEEP, GL_INCR)
	for i=0 to o->nPlanes-1
		if o->planes(i).visible <> 0 then
			for j=0 to 2
				k = o->planes(i).neigh(j)
				if k = 0 or o->planes(k-1).visible = 0 then
					'' here we have an edge, we must draw a polygon
					p1 = o->planes(i).p(j)
					jj = (j+1) mod 3
					p2 = o->planes(i).p(jj)

					'' calculate the length of the vector
					v1.x = (o->points(p1).x - lp[0])*100
					v1.y = (o->points(p1).y - lp[1])*100
					v1.z = (o->points(p1).z - lp[2])*100

					v2.x = (o->points(p2).x - lp[0])*100
					v2.y = (o->points(p2).y - lp[1])*100
					v2.z = (o->points(p2).z - lp[2])*100
					
					'' draw the polygon
					glBegin(GL_TRIANGLE_STRIP)
						glVertex3f(o->points(p1).x, _
							o->points(p1).y, _
							o->points(p1).z)
						glVertex3f(o->points(p1).x + v1.x, _
							o->points(p1).y + v1.y, _
							o->points(p1).z + v1.z)

						glVertex3f(o->points(p2).x, _
							o->points(p2).y, _
							o->points(p2).z)
						glVertex3f(o->points(p2).x + v2.x, _
							o->points(p2).y + v2.y, _
							o->points(p2).z + v2.z)
					glEnd()
				end if
			next
		end if
	next

	'' second pass, stencil operation increases stencil value
	glFrontFace(GL_CW)
	glStencilOp(GL_KEEP, GL_KEEP, GL_DECR)
	for i=0 to o->nPlanes-1
		if o->planes(i).visible <> 0 then
			for j=0 to 2
				k = o->planes(i).neigh(j)
				if k = 0 or o->planes(k-1).visible= 0 then
					'' here we have an edge, we must draw a polygon
					p1 = o->planes(i).p(j)
					jj = (j+1) mod 3
					p2 = o->planes(i).p(jj)

					''calculate the length of the vector
					v1.x = (o->points(p1).x - lp[0])*100
					v1.y = (o->points(p1).y - lp[1])*100
					v1.z = (o->points(p1).z - lp[2])*100

					v2.x = (o->points(p2).x - lp[0])*100
					v2.y = (o->points(p2).y - lp[1])*100
					v2.z = (o->points(p2).z - lp[2])*100
					
					''draw the polygon
					glBegin(GL_TRIANGLE_STRIP)
						glVertex3f(o->points(p1).x, _
							o->points(p1).y, _
							o->points(p1).z)
						glVertex3f(o->points(p1).x + v1.x, _
							o->points(p1).y + v1.y, _
							o->points(p1).z + v1.z)

						glVertex3f(o->points(p2).x, _
							o->points(p2).y, _
							o->points(p2).z)
						glVertex3f(o->points(p2).x + v2.x, _
							o->points(p2).y + v2.y, _
							o->points(p2).z + v2.z)
					glEnd()
				end if
			next
		end if
	next

	glFrontFace(GL_CCW)
	glColorMask(1, 1, 1, 1)

	''draw a shadowing rectangle covering the entire screen
	glColor4f(0.0, 0.0, 0.0, 0.4)
	glEnable(GL_BLEND)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	glStencilFunc(GL_NOTEQUAL, 0, &hffffffff)
	glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP)
	glPushMatrix()
		glLoadIdentity()
		glBegin(GL_TRIANGLE_STRIP)
			glVertex3f(-0.1, 0.1,-0.10)
			glVertex3f(-0.1,-0.1,-0.10)
			glVertex3f( 0.1, 0.1,-0.10)
			glVertex3f( 0.1,-0.1,-0.10)
		glEnd()
	glPopMatrix()
	glDisable(GL_BLEND)

	glDepthFunc(GL_LEQUAL)
	glDepthMask(GL_TRUE)
	glEnable(GL_LIGHTING)
	glDisable(GL_STENCIL_TEST)
	glShadeModel(GL_SMOOTH)
end sub

#endif '' _3DOBJECT_H_
