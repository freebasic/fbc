'//Blobs with moozic
'//Relsoft 2004
'//v3cz0r is da man!
'//bass by plaz
defint a-z


'$include: 'tinyptc.bi'
'$Include: 'win\kernel32.bi'
'$Include: 'win\user32.bi'

Declare Sub ErrorQuit (Message$)

declare sub cls_(buffer())
declare sub pcopy_ ( dest() as integer, source() as integer)
declare sub put_pixel(buffer(), byval x as integer, byval y as integer, byval col as integer)
declare sub draw_blob(buffer() as integer, light() as integer,_
                      byval x as integer, byval y as integer)

const SCR_WIDTH = 320  * 2
const SCR_HEIGHT = 240 * 2
const SCR_SIZE = SCR_WIDTH * SCR_HEIGHT


const PI = 3.141593

const BLOB_WID = 128
const BLOB_HEI = 128



	dim shared buffer( 0 to SCR_SIZE-1 ) as integer
	dim shared light(BLOB_WID - 1, BLOB_HEI - 1) as integer

	if( ptc_open( "Blob demo(Relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then
		end -1
	end if

    dim strength as integer
    dim x, y as integer
    dim bcol as integer
    dim dist as single
    strength =  BLOB_WID \ 2
    for x = -(BLOB_WID \ 2) to (BLOB_WID \ 2) - 1
        for y = -(BLOB_HEI \ 2) to (BLOB_HEI \ 2) - 1
            dist = sqr(x ^ 2 + y ^ 2)
            if x = 0 and y = 0 then
                bcol = 255
            else
                bcol = (Strength / dist) * 255
                bcol = bcol - 255
            end if
            if bcol < 0 then bcol = 0
            if bcol > 255 then bcol = 255
            light(x + (BLOB_WID \ 2), y + (BLOB_HEI \ 2)) =_
                        bcol shl 16 or bcol shl 8 or bcol

        next y
    next x

    dim f, i as integer

    do

        F = F + 1
        cls_ buffer()
        for i = 0 to 8
            x = SIN(F / 40 * .8 * i) * (i * (SCR_HEIGHT \ 28)) + ((SCR_WIDTH \ 2) - (BLOB_WID \2))
            y = COS(F / 35 * .9 * i) * (i * (SCR_HEIGHT \ 28)) + ((SCR_HEIGHT\ 2) - (BLOB_HEI \2))
            Draw_Blob buffer(), light(), x, y
        next i

        ptc_update @buffer(0)


    loop until( inkey$ = chr$( 27 ) )


	ptc_close

end  

'*******************************************************************************************
'bass subs
'
'*******************************************************************************************

Sub ErrorQuit (Message$)

  MessageBox 0, Message$, "Error", MB_ICONERROR
  End

End Sub

'*******************************************************************************************
'misc subs
'
'*******************************************************************************************

private sub draw_blob(buffer() as integer, light() as integer,_
                      byval x as integer, byval y as integer)

   	const SCR_X_MAX = SCR_WIDTH - 1
	const SCR_Y_MAX = SCR_HEIGHT - 1

    dim wid, hei as integer
    dim minx, miny as integer
    dim wtemp, htemp as integer
    dim offset as integer ptr





    wid = (Ubound(light,1) - Lbound(light,1)) + 1
    hei = (Ubound(light,2) - Lbound(light,2)) + 1

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



    dim erroradd as integer ptr
    dim nx, ny as integer
    dim c, oc, occ as integer
    dim lr, lg, lb, br, bg , bb as integer
    dim r, g, b as integer

    erroradd = (SCR_WIDTH - wid) * len(integer)
	offset = @buffer(0)+ ((y * SCR_WIDTH + x)* len(integer))

    for ny = 0 to hei -1
        for nx = 0 to wid -1
            c = light(nx + minx, ny + miny)
            if c then
                oc = *offset
                br = oc shr 16
                bg = (oc shr 8) and 255
                bb = oc and 255

                lr = c shr 16
                lg = (c shr 8) and 255
                lb = c and 255

                r = (lr + br)
                if r > 255 then r = 255

                g = (lg + bg)
                if g > 255 then g = 255

                b = (lb + bb)
                if b > 255 then b = 255

                occ = r shl 16 or g shl 8 or b
                *offset = occ
            end if

            offset = offset + len(integer)
        next nx
            offset = offset + erroradd
    next ny
end sub


'*******************************************************************************************
'GFX subs/Funks
'
'*******************************************************************************************
private sub put_pixel(buffer(), byval x as integer, byval y as integer, byval col as integer)
    if (y >= 0) and (y < SCR_HEIGHT) and (x >= 0) and (x < SCR_WIDTH) then
        buffer(y * SCR_WIDTH + x) = col
    end if
end sub


private sub pcopy_ ( dest() as integer, source() as integer)
    dim offset1 as integer ptr
    dim offset2 as integer ptr
    dim i as integer
    offset1 = @dest(0)
    offset2 = @source(0)
    for i = 0 to  SCR_SIZE -1
        *offset1 = *offset2
        offset1 = offset1 + len(integer)
        offset2 = offset2 + len(integer)
    next offset

end sub

private sub cls_(buffer())
    dim offset as integer ptr
    dim i as integer
    offset = @buffer(0)
    for i = 0 to  SCR_SIZE -1
        *offset = 0
        offset = offset + len(integer)
    next offset

end sub


