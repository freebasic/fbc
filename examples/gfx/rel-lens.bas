'//lens mapping cell texture
'//
'//
'//

#include "tinyptc.bi"

declare sub smooth( buffer() as integer)
declare sub put_pixel(buffer() as integer, byval x as integer, byval y as integer,_
                      byval col as integer)
declare function dist (byval x as single,byval  y as single, xc() as single, yc() as single) as single
declare sub do_lens(dest() as integer, source() as integer,_
                    byval x as integer, byval y as integer, byval radius as integer )
declare sub pcopy_ ( dest() as integer, source() as integer)


const SCR_WIDTH = 320 * 1
const SCR_HEIGHT = 240 * 1
const SCR_WIDTH_M1 = SCR_WIDTH  - 1
const SCR_HEIGHT_M1 = SCR_HEIGHT - 1
const SCR_WIDTH_P1 = SCR_WIDTH  + 1
const SCR_HEIGHT_P1 = SCR_HEIGHT + 1

const SCR_SIZE = SCR_WIDTH*SCR_HEIGHT


const PI = 3.141593

const MAXPOINTS = 64

const XMID = SCR_WIDTH \ 2
const YMID = SCR_HEIGHT \ 2

	dim shared buffer( 0 to SCR_SIZE-1 ) as integer
	dim shared texture( 0 to SCR_SIZE-1 ) as integer
	dim shared distbuffer( SCR_WIDTH - 1, SCR_HEIGHT - 1 ) as single
    DIM shared xcoords(maxpoints) as single
    DIM shared ycoords(maxpoints) as single
    dim shared sqrt(256* 256) as integer



	if( ptc_open( "Lens mapping", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then
		end -1                                    
	end if


    randomize timer
    
    dim as integer x, y, i, r, g, b, frame

    for i = 0 to 256*256
        sqrt(i) = sqr(i)
    next i

    'goto jump
    FOR i = 0 TO maxpoints
        xcoords(i) = rnd * SCR_WIDTH
        ycoords(i) = rnd * SCR_HEIGHT
    NEXT i
    
    dim as single mindist, maxdist, tx, ty, distance

    frame = 0

          mindist = 1D+16
          maxdist = 0

          FOR y = 0 TO SCR_HEIGHT - 1
          FOR x = 0 TO SCR_WIDTH  - 1
              tx = x
              ty = y
              distance = dist(tx, ty, xcoords(), ycoords())
              distbuffer(x, y) = distance
              IF distance < mindist THEN mindist = distance
              IF distance > maxdist THEN maxdist = distance
          NEXT x
          NEXT y

          dim as single c
          
          '1
          FOR y = 0 TO SCR_HEIGHT - 1
          FOR x = 0 TO SCR_WIDTH - 1
              c =1 - (distbuffer(x, y) - mindist) / (maxdist - mindist)
              r = cint(c * 55)
              g = cint(c * 155)
              b = cint(c * 255)
              put_pixel texture(), x, y, r shl 16 or g shl 8 or b
          NEXT x
          NEXT y

          'jump:

         ' FOR y = 0 TO SCR_HEIGHT - 1
          'FOR x = 0 TO SCR_WIDTH - 1
          '    put_pixel texture(), x, y, (x shl 16) or (y shl 8) shl 8 or (x + y)
          'NEXT x
          'NEXT y

          dim t as single
          dim as integer x2, y2, x3, y3
    do
        T = timer
        x =  INT(sin(T * .6) * cos(T) * 140)
        y =  INT(cos(T + .2) * cos(T * .1) * 90)
        x2 =  INT(cos(T * .1) * sin(T) * 140)
        y2 =  INT(cos(T + .12) * cos(T * 1.1) * 90)
        x3 =  INT(sin(T * .34) * sin(T * .45) * 140)
        y3 =  INT(sin(T + .72) * cos(T * .5) * 90)

        pcopy_ buffer(), texture()
        do_lens buffer(), texture(),-64+ x + XMID, -64+ y + YMID, 64
        do_lens buffer(), texture(),-16+ x2 + XMID, -16+ y2 + YMID, 32
        do_lens buffer(), texture(),-22+ x3 + XMID, -22+ y3 + YMID, 44
        ptc_update @buffer(0)

    loop until( inkey = chr( 27 ) )


	ptc_close




private FUNCTION dist (byval x as single, byval y as single, xc() as single, yc() as single) as single
    dim as single mindist = 1D+16 
    dim as integer max = UBOUND(xc) 
    dim as single a, b, d
    dim as integer i
    FOR i = 0 TO max 
        a = (xc(i) - x) * (xc(i) - x) 
        b = (yc(i) - y) * (yc(i) - y) 
        d = SQR(a + b) 
        IF d < mindist THEN mindist = d
    NEXT i 
    dist = mindist
END FUNCTION 

'*******************************************************************************************
'GFX subs/Funks
'
'*******************************************************************************************
private sub put_pixel(buffer() as integer, byval x as integer, byval y as integer, byval col as integer)
        if cunsg(x) >= SCR_WIDTH or cunsg(y) >= SCR_HEIGHT then exit sub
        buffer(y * SCR_WIDTH + x) = col
end sub

private sub pcopy_ ( dest() as integer, source() as integer)
    dim offset as integer
    for offset = 0 to  SCR_SIZE -1
        dest( offset ) = source( offset )
    next offset
end sub

Private sub do_lens(dest()as integer, source() as integer,_
                    byval x as integer, byval y as integer, byval radius as integer )

   	const SCR_X_MAX = SCR_WIDTH - 1
	const SCR_Y_MAX = SCR_HEIGHT - 1

    dim as integer wid, hei
    dim as integer hypotsquared, radiussquared, h
    dim as integer sx, sy, x1, y1, yt, xt
    dim as integer px, py
    dim as integer minx, miny
    dim as integer pixel 
    dim as integer wtemp, htemp 
    dim as integer sphereheight, cleaner 

    sphereheight = (radius shr 1)
    cleaner = sphereheight * 10

    RadiusSquared = Radius * Radius

    wid = Radius shl 1
    hei = wid


    minx = 0
    miny = 0

  	if y < 0 then
		y = -y
		miny = y
		hei = hei - y
		if hei <= 0 then exit sub
		y = 0
	end if

	if  (y + hei) > SCR_Y_MAX then
		htemp = (y + hei) - SCR_HEIGHT
		hei = hei - htemp
		if hei <= 0 then exit sub
	end if

	if x < 0 then
		x = -x
		minx = x
		wid = wid - x
		if wid <= 0 then exit sub
		x = 0
	end if
	if  (x + wid) > SCR_X_MAX then
		wtemp = (x + wid) - SCR_WIDTH
		wid = wid - wtemp
		if (wid <= 0) then exit sub
	end if

    FOR yt = 0 TO hei - 1
     FOR xt = 0 TO wid - 1
          x1 = (xt - Radius) + minx
          y1 = (yt - Radius) + miny

          HypotSquared = (x1 * x1) + (y1 * y1)
          IF HypotSquared < (RadiusSquared - Cleaner) THEN
           H = (Sqrt(RadiusSquared - HypotSquared))
           Sx = (SphereHeight - H)
           Sy = (SphereHeight - H)
           Sx = Sx * ((x1 shl 16) \ H)
           Sy = Sy * ((y1 shl 16) \ H)
           py = ((Sy shr 16) + yt + y)
           px = ((Sx shr 16) + xt + x)
           if px > -1 and px < SCR_WIDTH and py > -1 and py < SCR_HEIGHT then
              dest( (y+yt) * SCR_WIDTH + (x + xt) ) = source(py * SCR_WIDTH + px)
           end if
          END IF
     NEXT xt
    NEXT yt


end sub
