'Flower tunnel 
'relsoft 2006 
'http://rel.betterwebber.com 

#include "tinyptc.bi"

declare sub DrawTunnel( Buffer() as integer, Texture() as integer,_ 
                       Tangle() as integer, Tdepth() as integer,_ 
                       byval addx as integer, byval addy as integer) 
declare FUNCTION dist (byval x as single, byval y as single, xc() as single, yc() as single) as single


const SCR_WIDTH = 320  * 1 
const SCR_HEIGHT = 240 * 1 
const SCR_SIZE = SCR_WIDTH * SCR_HEIGHT 

const TWID = SCR_WIDTH 
const THEI = SCR_HEIGHT 
const TWIDM1 = TWID - 1 
const THEIM1 = THEI - 1 

const MAXPOINTS = 32 

const XMID = SCR_WIDTH \ 2 
const YMID = SCR_HEIGHT \ 2 



const PI = 3.141593 
const TWOPI = (2 * PI) 


   dim shared Buffer( 0 to SCR_SIZE-1 ) as integer 
   dim shared Tangle( TWID, THEI) as integer 
   dim shared Tdepth( TWID, THEI) as integer 
   dim shared Texture( 255, 255) as integer 
   dim shared Distbuffer( 255, 255) as single
    dim shared xcoords(maxpoints) as single
    dim shared ycoords(maxpoints) as single


   if( ptc_open( "freeBASIC v0.01 - Blob demo(Relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then 
      end -1 
   end if 

    randomize timer 

    dim as integer x, y, i, r, g, b 

    FOR i = 0 TO maxpoints 
        xcoords(i) = rnd * SCR_WIDTH 
        ycoords(i) = rnd * SCR_HEIGHT 
    NEXT i 

	dim as single mindist, maxdist, tx, ty, distance

    mindist = 1D+16 
    maxdist = 0 

    FOR y = 0 TO 255 
       FOR x = 0 TO 255 
              tx = abs(x - 128) 
              ty = abs(y - 128) 
              distance = dist(tx, ty, xcoords(), ycoords()) 
              distbuffer(x, y) = distance
              IF distance < mindist THEN mindist = distance 
              IF distance > maxdist THEN maxdist = distance
       NEXT x 
    NEXT y 

	dim as single c

    FOR y = 0 TO 255 
       FOR x = 0 TO 255 
              c =(distbuffer(x, y) - mindist) / (maxdist - mindist) 
              r = cint(c * 55) 
              g = cint(c * 155) 
              b = cint(c * 255) 
              texture(x, y) = r shl 16 or g shl 8 or b 
       NEXT x 
    NEXT y 



    dim as single t  

    do 
        t = timer 
        DrawTunnel Buffer(), Texture(), Tangle(), Tdepth(), (TWID shr 1)* sin(t * .5),_ 
                   (t *.8)* (THEI shr 1) 

        ptc_update @buffer(0) 

    loop until inkey<>"" 


   ptc_close 

end 


private sub DrawTunnel(Buffer() as integer, Texture() as integer,_ 
                       Tangle() as integer, Tdepth() as integer,_ 
                       byval addx as integer, byval addy as integer) 

   dim as integer ptr pbuff, ptext  
   dim as integer x, y, tx, ty
    
    static as integer cx= 160, cy =120 
    dim as single xdist  
    dim as integer cxmx, cymy, diamxscale 
    static as short  frame 
    static as single fold_off = 0.02 
    static as single fold_scale = 0.07' * sin(timer / 512.0) 
    static as single fold_num = 8 
    static as single rad_factor = 0 

    frame +=1 
    dim as integer diameter = 128 
    diamxscale = 64 * diameter 
    cx = (TWID\2)+ sin(addx/80)*70 
   	cy = (THEI\2)+ sin(addy/90)*70 
    dim temp as short 
    temp = 512/pi 
    dim angle as single 
    fold_off += 0.2    
    fold_scale = 0.3 * sin(frame / 40)    
    
   dim as integer ptr b = @buffer(0)
   for y = 0 to THEIM1 
        cymy = cy - y 
      for x = 0 to TWIDM1 
            cxmx = cx -x              
            angle = atan2(cymy,cxmx)            
            tx = cint(angle * temp) + addx            
            xdist = sqr((cxmx*cxmx) + (cymy*cymy)) * ((sin(fold_off + fold_num * angle) * fold_scale)+1)            
            ty =  (diamxscale / xdist) + addy            
            tx = tx and 255 
            ty = ty and 255 
         *b = texture(tx, ty)            
         b += 1
      next x 
        
   next y 


end sub 

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
