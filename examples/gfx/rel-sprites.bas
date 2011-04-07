'//TinyPTC relGFX style 
'//Relsoft 2004 
'//v3cz0r is da man! 
'// 
#lang "fblite"

#include "tinyptc.bi"

declare sub cls_sprite(buffer()) 
declare sub put_pixel(buffer(), byval x as integer, byval y as integer, byval col as integer) 
declare sub draw_line(buffer(), byval x as integer, byval y as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 
declare sub draw_line_h ( buffer(), byval x1 as integer, byval y as integer, byval x2 as integer, byval col as integer) 
declare sub draw_line_v ( buffer(), byval x as integer, byval y1 as integer, byval y2 as integer, byval col as integer) 
declare sub draw_rect_fill(buffer(), byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 
declare sub draw_rect(buffer(), byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 
declare sub put_sprite (buffer(), byval x as integer, byval y as integer, sprite()) 
declare sub put_sprite_mask (buffer(), byval x as integer, byval y as integer, sprite()) 
declare sub get_sprite( buffer() as integer, byval x1 as integer, byval y1 as integer _ 
                        , byval x2 as integer, byval y2 as integer, sprite() as integer) 
declare function size_of_image(byval x1 as integer, byval y1 as integer, byval x2 as integer _ 
                               , byval y2 as integer) 


const SCR_WIDTH = 320 
const SCR_HEIGHT = 240 
const SCR_SIZE = SCR_WIDTH*SCR_HEIGHT 


const PI = 3.141593 

const SPR_WID = 64 
const SPR_HEI = 64 
const SPR_SIZE = SPR_WID * SPR_HEI 


   dim shared buffer( 0 to SCR_SIZE-1 ) as integer 
   dim shared Lcos(0 to 359) as single 
   dim shared Lsin(0 to 359) as single 
   'dim shared sprite(0 to (SPR_SIZE - 1) + 2) as integer 
   redim shared sprite(0 to size_of_image(0,0,SPR_WID - 1, SPR_HEI -1)) as integer 

    dim frame as long 
    dim col as integer 
    dim i as integer 
    dim j as integer 
    dim offs as long 
    dim rot as integer 
    dim counter as long 
    dim pixel as integer 
    dim xptr as long ptr 
    dim x as integer 
    dim y as integer 
    dim x1 as integer 
    dim y1 as integer 
    dim x2 as integer 
    dim y2 as integer 
    dim t as single 
    dim angle as integer 


    dim r as integer 
    dim g as integer 
    dim b as integer 


   if( ptc_open( "RelGFX win demo(Relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then 
      end -1 
   end if 

    for i = 0 to 359 
        Lcos(i) = cos ( i * PI /180) 
        Lsin(i) = sin ( i * PI /180) 
    next i 

    sprite(0) = SPR_WID 
    sprite(1) = SPR_HEI 

    for y = 0 to SPR_HEI -1 
        for x = 0 to SPR_WID -1 
            r = abs(INT(128 - 127 * SIN(x * PI / 16))) 
            g = abs(INT(128 - 127 * SIN(y * PI / 32))) 
            b = abs(INT(128 - 127 * SIN((x+y) * PI / 16))) 
            put_pixel buffer(), x, y , rgb( r, g, b )
        next x 
    next y 
    get_sprite buffer(), 0, 0, SPR_WID -1, SPR_HEI -1, sprite() 
    counter = 0 
    frame = 0 
    angle = 0 
    do 
      frame = (frame + 1) and &h7fffffff 
        angle = (angle + 1) mod 360 
        x = (Lcos(angle) * (SCR_WIDTH  \ 2 ) ) 
        y = (Lsin(angle) * (SCR_HEIGHT \ 2 ) ) 

        cls_sprite buffer() 
        put_sprite buffer(), x+ ((SCR_WIDTH  \ 2) - 32), y+ ((SCR_HEIGHT \ 2) - 32), sprite() 
        put_sprite buffer(), -x+ ((SCR_WIDTH  \ 2) - 32), y+ ((SCR_HEIGHT \ 2) - 32), sprite() 
        put_sprite buffer(), x+ ((SCR_WIDTH  \ 2) - 32), -y+ ((SCR_HEIGHT \ 2) - 32), sprite() 
        put_sprite buffer(), -x+ ((SCR_WIDTH  \ 2) - 32), -y+ ((SCR_HEIGHT \ 2) - 32), sprite() 
        ptc_update @buffer(0)

    loop until( inkey = chr( 27 ) )


   ptc_close 


private sub put_pixel(buffer(), byval x as integer, byval y as integer, byval col as integer) 
        buffer(y * SCR_WIDTH + x) = col 
end sub 

private sub cls_sprite(buffer()) 
    dim i as long
    dim b as integer ptr
    
    b = @buffer(0)
	for i = 0 to SCR_SIZE - 1
		*b = 0
		b = b + 1
	next i
end sub 

private sub draw_line(buffer(), byval x as integer, byval y as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 

dim i as integer 
dim slope as integer 
dim eterm as integer 
dim dx as integer 
dim dy as integer 
dim sx as integer 
dim sy as integer 
dim notclip as integer 
dim temp as integer 


const scrxmax = SCR_WIDTH  - 1 
const scrymax = SCR_HEIGHT - 1 


I = 0 
Slope = 0 
Eterm = 0 

IF (X2 - X) > 0 THEN 
     SX = 1 
ELSE 
     SX = -1 
END IF 
Dx = ABS(X2 - X) 


IF (Y2 - Y) > 0 THEN 
     SY = 1 
ELSE 
     SY = -1 
END IF 
Dy = ABS(Y2 - Y) 

IF (Dy > Dx) THEN 
        Slope = 1 
        swap x, y

        swap dx, dy

        swap sx, sy

END IF 
Eterm = 2 * Dy - Dx 

FOR I = 0 TO Dx - 1 
   IF Slope = 1 THEN 
     NotClip = (((Y < 0) + (X < 0) + (Y > scrxmax) + (X > scrymax)) = 0) 
     IF NotClip THEN  buffer(x * SCR_WIDTH + y ) = col 
   ELSE 
     NotClip = (((X < 0) + (Y < 0) + (X > scrxmax) + (Y > scrymax)) = 0) 
     IF NotClip THEN buffer(Y * SCR_WIDTH + X ) = col 
   END IF 

   WHILE Eterm >= 0 
      Y = Y + SY: Eterm = Eterm - 2 * Dx 
   WEND 
   X = X + SX: Eterm = Eterm + 2 * Dy 
NEXT  I 
     NotClip = (((X2 < 0) + (Y2 < 0) + (X2 > scrxmax) + (Y2 > scrymax)) = 0) 
     IF NotClip THEN buffer(Y2 * SCR_WIDTH + X2 ) = col 

end sub 



private sub draw_line_h ( buffer(), byval x1 as integer, byval y as integer, byval x2 as integer, byval col as integer) 

   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim wid as integer 
   dim offset as long 
   dim counter as integer 
   dim temp as integer 


   if (y < 0) or (y > SCR_Y_MAX)  then exit sub 

   if (x1 > x2) then 
      swap x1, x2
    end if 

   if x1 > SCR_X_MAX then exit sub 

   if x2 < 0 then exit sub 

   if x1 < 0 then 
      x1 = 0 
      if (x2 - x1) < 0 then exit sub 
   end if 

   if x2 > SCR_X_MAX then 
      x2 = SCR_X_MAX 
      if (x2 - x1) < 0 then exit sub 
   end if 

      wid = (x2 - x1) + 1 
   if wid <= 0  then exit sub 


   offset = y * SCR_WIDTH + x1 

   for counter = 0 to  (wid - 1) 
       buffer( offset ) = col 
       offset += 1 
   next counter 

end sub 

private sub draw_line_v ( buffer(), byval x as integer, byval y1 as integer, byval y2 as integer, byval col as integer) 

   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim hite as integer 
   dim offset as long 
   dim counter as integer 
   dim temp as integer 


   if (x < 0) or (x > SCR_X_MAX)  then exit sub 

   if (y1 > y2) then 
      swap y1, y2
    end if 

   if y1 > SCR_Y_MAX then exit sub 

   if y2 < 0 then exit sub 

   if y1 < 0 then 
      y1 = 0 
      if (y2 - y1) < 0 then exit sub 
   end if 

   if y2 > SCR_Y_MAX then 
      y2 = SCR_Y_MAX 
      if (y2 - y1) < 0 then exit sub 
   end if 

      hite = (y2 - y1) + 1 
   if hite <= 0  then exit sub 


   offset = y1 * SCR_WIDTH + x 

   for counter = 0 to  (hite - 1) 
       buffer( offset ) = col 
       offset += SCR_WIDTH 
   next counter 

end sub 


private sub draw_rect_fill(buffer(), byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 

   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim hite as integer 
   dim wid as integer 
   dim offset as long 
   dim xcounter as integer 
   dim ycounter as integer 
   dim temp as integer 


   if (x1 > x2) then 
      swap x1, x2
    end if 

   if x1 > SCR_X_MAX then exit sub 

   if x2 < 0 then exit sub 

   if x1 < 0 then 
      x1 = 0 
      if (x2 - x1) < 0 then exit sub 
   end if 

   if x2 > SCR_X_MAX then 
      x2 = SCR_X_MAX 
      if (x2 - x1) < 0 then exit sub 
   end if 

      wid = (x2 - x1) + 1 
   if wid <= 0  then exit sub 


   if (y1 > y2) then 
      swap y1, y2 
    end if 

   if y1 > SCR_Y_MAX then exit sub 

   if y2 < 0 then exit sub 

   if y1 < 0 then 
      y1 = 0 
      if (y2 - y1) < 0 then exit sub 
   end if 

   if y2 > SCR_Y_MAX then 
      y2 = SCR_Y_MAX 
      if (y2 - y1) < 0 then exit sub 
   end if 

      hite = (y2 - y1) + 1 
   if hite <= 0  then exit sub 

    offset = y1 * SCR_WIDTH + x1 

   for ycounter = 0  to  (hite - 1) 
       for xcounter = 0  to  (wid  - 1) 
           buffer( offset + xcounter ) = col 
          next xcounter 
          offset = offset + SCR_WIDTH 
   next ycounter 

end sub 

private sub draw_rect(buffer(), byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval col as integer) 
    draw_line_h buffer(), x1, y1, x2, col 
    draw_line_v buffer(), x1, y1, y2, col 
    draw_line_h buffer(), x1, y2, x2, col 
    draw_line_v buffer(), x2, y1, y2, col 
end sub 

private function size_of_image(byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer) 
   dim s as integer 
   dim temp as integer 
   if x1 > x2 then 
      swap x1, x2 
   end if 
   if y1 > y2 then 
      swap y1, y2 
   end if 
   s = ((x2 - x1) + 1) * ((y2 - y1) + 1) + 2 
   size_of_image = s 

end function 

private sub put_sprite (buffer(), byval x as integer, byval y as integer, sprite()) 


   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim owid as integer 
   dim ohei as integer 
      dim wid  as integer 
   dim hei  as integer 
      dim wcounter as integer 
   dim hcounter as integer 
   dim offset  as long 
   dim soffset as long 
   dim htemp as integer 
   dim wtemp as integer 




   if (x > SCR_X_MAX) then exit sub 
   if (y > SCR_Y_MAX) then exit sub 
   owid = sprite(0) 
   ohei = sprite(1) 
   wid = owid 
   hei = ohei 

    soffset = 2 

   if y < 0 then 
      y = -y 
      soffset = soffset + (wid * y) 
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
      soffset= soffset + x 
      wid = wid - x 
      if wid <= 0 then exit sub 
      x = 0 
   end if 
   if  (x + wid) > SCR_X_MAX then 
      wtemp = (x + wid) - SCR_WIDTH 
      wid = wid - wtemp 
      if (wid <= 0) then exit sub 
   end if 

	dim b as integer ptr, s as integer ptr
	offset = y * SCR_WIDTH + x
   
	for hcounter = 1 to hei
		b = @buffer( offset )
   		s = @sprite( soffset )
      	for wcounter = 1 to wid
			*b = *s
			b = b + 1
			s = s + 1
		next wcounter 
		offset += SCR_WIDTH 
		soffset += owid 
	next hcounter 


end sub 

private sub put_sprite_mask (buffer(), byval x as integer, byval y as integer, sprite()) 


   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim owid as integer 
   dim ohei as integer 
      dim wid  as integer 
   dim hei  as integer 
      dim wcounter as integer 
   dim hcounter as integer 
   dim offset  as long 
   dim soffset as long 
   dim htemp as integer 
   dim wtemp as integer 
   dim pixel as integer 




   if (x > SCR_X_MAX) then exit sub 
   if (y > SCR_Y_MAX) then exit sub 
   owid = sprite(0) 
   ohei = sprite(1) 
   wid = owid 
   hei = ohei 

    soffset = 2 

   if y < 0 then 
      y = -y 
      soffset = soffset + (wid * y) 
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
      soffset= soffset + x 
      wid = wid - x 
      if wid <= 0 then exit sub 
      x = 0 
   end if 
   if  (x + wid) > SCR_X_MAX then 
      wtemp = (x + wid) - SCR_WIDTH 
      wid = wid - wtemp 
      if (wid <= 0) then exit sub 
   end if 

	dim b as integer ptr, s as integer ptr
   	offset = y * SCR_WIDTH + x 

	for hcounter = 1 to hei
		b = @buffer( offset )
   		s = @sprite( soffset )
      	for wcounter = 1 to wid
            pixel = *s
           	if pixel <> 0 then *b = pixel 
			b += 1
			s += 1
      next wcounter 
      offset += SCR_WIDTH 
      soffset += owid 
   next hcounter 


end sub 


private sub get_sprite( buffer() as integer, byval x1 as integer, byval y1 as integer _ 
                        , byval x2 as integer, byval y2 as integer, sprite() as integer) 

   const SCR_X_MAX = SCR_WIDTH - 1 
   const SCR_Y_MAX = SCR_HEIGHT - 1 

   dim hite as integer 
   dim wid as integer 
   dim offset as long 
   dim soffset as long 
   dim xcounter as integer 
   dim ycounter as integer 
   dim temp as integer 



   if (x1 > x2) then 
      swap x1, x2 
   end if 

   if x1 > SCR_X_MAX then exit sub 

   if x2 < 0 then exit sub 

   if x1 < 0 then 
      x1 = 0 
      if (x2 - x1) < 0 then exit sub 
   end if 

   if x2 > SCR_X_MAX then 
      x2 = SCR_X_MAX 
      if (x2 - x1) < 0 then exit sub 
   end if 

   wid = (x2 - x1) + 1 
   if wid <= 0  then exit sub 


   if (y1 > y2) then 
      swap y1, y2 
    end if 

   if y1 > SCR_Y_MAX then exit sub 

   if y2 < 0 then exit sub 

   if y1 < 0 then 
      y1 = 0 
      if (y2 - y1) < 0 then exit sub 
   end if 

   if y2 > SCR_Y_MAX then 
      y2 = SCR_Y_MAX 
      if (y2 - y1) < 0 then exit sub 
   end if 

   hite = (y2 - y1) + 1 
   if hite <= 0  then exit sub 

    sprite(0) = wid 
    sprite(1) = hite 

	dim b as integer ptr, s as integer ptr
    soffset = 2 
    offset = y1 * SCR_WIDTH + x1 

   	for ycounter = 1 to hite
		b = @buffer( offset )
   		s = @sprite( soffset )
    	for xcounter = 1 to wid
			*s = *b
			b += 1
			s += 1
        next xcounter 
		offset += SCR_WIDTH 
        soffset += wid 
   	next ycounter 

end sub 
