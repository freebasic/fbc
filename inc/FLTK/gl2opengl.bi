#include once "gl_draw.bi"

extern "c++"
private sub clear_()
	glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)
end sub

#define RGBcolor(r,g,b) glColor3ub(r,g,b)
#define bgnline() glBegin(GL_LINE_STRIP)
#define bgnpolygon() glBegin(GL_POLYGON)
#define bgnclosedline() glBegin(GL_LINE_LOOP)
#define endline() glEnd()
#define endpolygon() glEnd()
#define endclosedline() glEnd()
#define v2f(v) glVertex2fv(v)
#define v2s(v) glVertex2sv(v)
#define cmov(x,y,z) glRasterPos3f(x,y,z)
#define charstr(s) gl_draw(s)
#define fmprstr(s) gl_draw(s)

type Matrix
	m(3,3) as single
end type

private sub pushmatrix()
	glPushMatrix()
end sub
private sub popmatrix()
	glPopMatrix()
end sub
private sub multmatrix(m as Matrix)
	glMultMatrixf(@m.m(0,0))
end sub
private sub color_(n as long)
	glIndexi(n)
end sub
private sub rect(x as long, y as long, r as long, t as long)
	gl_rect(x,y,r-x,t-y)
end sub
private sub rectf(x as long, y as long, r as long, t as long)
	glRectf(x,y,r+1,t+1)
end sub
private sub recti(x as long, y as long, r as long, t as long)
	gl_rect(x,y,r-x,t-y)
end sub
private sub rectfi(x as long, y as long, r as long, t as long)
	glRecti(x,y,r+1,t+1)
end sub
private sub rects(x as long, y as long, r as long, t as long)
	gl_rect(x,y,r-x,t-y)
end sub
private sub rectfs(x as long, y as long, r as long, t as long)
	glRects(x,y,r+1,t+1)
end sub

end extern