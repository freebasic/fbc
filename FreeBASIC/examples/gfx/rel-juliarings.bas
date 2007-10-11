' The Lord of the Julia Rings
' The Fellowship of the Julia Ring
' Free Basic
' Relsoft
' Rel.BetterWebber.com
'



#ifdef __FB_WIN32__
#include once "windows.bi"
#endif

#include once "tinyptc.bi"

const SCR_WIDTH = 320  * 1
const SCR_HEIGHT = 240 * 1
const SCR_SIZE = SCR_WIDTH*SCR_HEIGHT
const SCR_MIDX = SCR_WIDTH \ 2
const SCR_MIDY = SCR_HEIGHT \ 2


const PI = 3.141593
const MAXITER = 20
const MAXSIZE = 4


dim Buffer(SCR_SIZE - 1) as integer
dim Lx(SCR_WIDTH-1) as single
dim Ly(SCR_HEIGHT-1) as single
dim sqrt(SCR_SIZE - 1) as single


if( ptc_open( "Julia (Relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then
	end -1
end if

dim px as integer, py as integer
dim p as single, q as single
dim xmin as single, xmax as single, ymin as single, ymax as single
dim theta as single
dim deltax as single, deltay as single
dim x as single, y as single
dim xsquare as single, ysquare as single
dim ytemp as single
dim temp1 as single, temp2 as single
dim i as integer, pixel as integer
dim p_buffer as integer ptr, p_bufferl as integer ptr
dim t as uinteger, frame as uinteger
dim ty as single
dim r as integer, g as integer, b as integer
dim red as integer, grn as integer, blu as integer
dim tmp as integer, i_last as integer

dim cmag as single
dim cmagsq as single
dim zmag as single
dim drad as single
dim drad_L as single
dim drad_H as single
dim ztot as single
dim ztoti as integer

xmin = -2.0
xmax =  2.0
ymin = -1.5
ymax =  1.5

deltax = (xmax - xmin) / (SCR_WIDTH - 1)
deltay = (ymax - ymin) / (SCR_HEIGHT - 1)

for i = 0 to SCR_WIDTH - 1
    lx(i) = xmin + i * deltax
next i

for i = 0 to SCR_HEIGHT - 1
    ly(i) = ymax - i * deltay
next i

for i = 0 to SCR_SIZE - 1
    sqrt(i) = sqr(i)
next i


#ifdef __FB_WIN32__
	dim hwnd as HWND
	hwnd = GetActiveWindow( )
#endif

dim stime as integer, Fps as single, Fps2 as single

stime = timer

do
    p_buffer = @buffer(0)
    p_bufferl = @buffer(SCR_SIZE-1)

    frame = (frame + 1) and &H7fffffff
    theta = frame * PI / 180

    p = cos(theta) * sin(theta * .7)
    q = sin(theta) + sin(theta)
    p = p * .6
    q = q * .6



    cmag = sqr(p *p + q* q)
    cmagsq = (p *p + q* q)
    drad = 0.04
    drad_L = (cmag - drad)
    drad_L = drad_L * drad_L
    drad_H = (cmag + drad)
    drad_H = drad_H * drad_H


    for py = 0 to (SCR_HEIGHT shr 1) - 1
        ty = ly(py)
        for px = 0 to SCR_WIDTH - 1
            x = Lx(px)
            y = ty
            xsquare = 0
            ysquare = 0
            ztot =0
            i = 0
            while (i < MAXITER) and (( xsquare + ysquare ) < MAXSIZE)
                xsquare = x * x
                ysquare = y * y
                ytemp = x * y * 2
                x = xsquare - ysquare + p
                y = ytemp + q
                zmag = (x * x + y * y)
                if (zmag < drad_H) then
                	if (zmag > drad_L) and (i > 0) then
                    		ztot = ztot + ( 1 - (abs(zmag - cmagsq) / drad))
                    		i_last = i
                    end if
                end if
                i = i + 1
                if zmag > 4.0 then
                    exit while
                end if
            wend

            if ztot > 0 then
                i = cint(sqr(ztot) * 500)
            else
                i = 0
            end if
              if i < 256 then
                red = i
              else
                red = 255
              end if

              if i < 512 and i > 255 then
                grn = i - 256
              else
                if i >= 512 then
                  grn = 255
                else
                  grn = 0
                end if
              end if

              if i <= 768 and i > 511 then
                blu = i - 512
              else
                if i >= 768 then
                  blu = 255
                else
                  blu = 0
                end if
              end if

          		tmp = cint((red+grn+blu) * 0.33)
          		red = cint((red+grn+tmp) * 0.33)
          		grn = cint((grn+blu+tmp) * 0.33)
          		blu = cint((blu+red+tmp) * 0.33)

              select case (i_last and 3)
          		case 1
                  tmp = red
                  red = grn
                  grn = blu
                  blu = tmp
          		case 2
                  tmp = red
                  blu = grn
                  red = blu
                  grn = tmp
              end select

            pixel = rgb( red, grn, blu )
            *p_buffer = pixel
            *p_bufferl = pixel
            p_buffer = p_buffer + 1
            p_bufferl = p_bufferl - 1
        next px
    next py

    'calc fps
    fps = fps + 1
    if stime + 1 < timer then
     fps2 = fps
     fps = 0
     stime = timer
#ifdef __FB_WIN32__
     SetWindowText( hwnd, "FreeBasic Julia Rings FPS:" & Fps2 )
#endif
    end if
    ptc_update @buffer(0)
loop until inkey <> ""


ptc_close

end




