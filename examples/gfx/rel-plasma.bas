'//Plasma using y*xwidth +x addresing
'//Relsoft 2004
'//Uses the superhot FB compiler

#include "tinyptc.bi"

const SCR_WIDTH = 320
const SCR_HEIGHT = 200
const SCR_SIZE = SCR_WIDTH*SCR_HEIGHT

const PI = 3.141593

type TRGB
	r as ubyte
	g as ubyte
	b as ubyte
	a as ubyte
end type

	dim shared buffer( 0 to SCR_SIZE-1 ) as integer
	dim shared Lsin1( -1024 to 1024) as integer
	dim shared Lsin2( -1024 to 1024) as integer
	dim shared Lsin3( -1024 to 1024) as integer
	dim shared Lcols(255) as TRGB
	
	
    dim frame as long
    dim col as integer
    dim i as integer
    dim ofs as long
    dim rot as integer
    dim counter as integer, cdir as integer
    dim pixel as integer

	if( ptc_open( "plasma test (relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then
		end -1
	end if

    for i = -1024 to 1024
        Lsin1(i) = SIN(i / 128) * 256      'Play with these values
        Lsin2(i) = SIN(i / 64) * 128       'for different types of fx
        Lsin3(i) = SIN(i / 32) * 64        ';*)
    next i

    for i = 0 to 255
        Lcols(i).r = cbyte(abs(INT(128 - 127 * SIN(i * PI / 32))))
	    Lcols(i).g = cbyte(abs(INT(128 - 127 * SIN(i * PI / 64))))
	    Lcols(i).b = cbyte(abs(INT(128 - 127 * SIN(i * PI / 128))))
	next i

    counter = 0
    cdir = 1

    dim p as integer ptr
    do
		counter = counter + cdir
      	if( (counter < 1) or (counter > 4096) ) then 
			cdir = -cdir
      	end if
     
      	rot = 64 * (((counter AND 1) = 1) OR 1)
      
      	p = @buffer(0)
      	FOR y As Integer = 0 TO SCR_HEIGHT-1
          	FOR x As Integer = 0 TO SCR_WIDTH-1
				rot = -rot
              	col = (Lsin3(x + Rot) + Lsin1(x + Rot + Counter) + Lsin2(y + Rot)) and 255
              	
              	*p = rgb( Lcols(col).r, Lcols(col).g, Lcols(col).b )
              	p += 1
          	NEXT x
      	NEXT y
    
		ptc_update @buffer(0)
	loop until( inkey = chr( 27 ) )

	ptc_close
	
	