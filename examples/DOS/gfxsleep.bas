#include once "fbgfx.bi"

extern "c"
	extern as unsigned long __fb_dos_no_dpmi_yield
end extern

'' tells SLEEP to call usleep_private() which does not yeild to dpmi
'' this prevents djgpp c runtime from call __dmpi_yeild() during a
'' call in SLEEP.  Disabling this behaviour appears to prevent the
'' program from crashing at least in dosbox with some extenders.

__fb_dos_no_dpmi_yield = 1

screen 13

dim as long w, h
ScreenControl fb.GET_SCREEN_SIZE, w, h

dim as single maxtime = 100
dim as single x = 10, y = 10, dx = 50, dy = 0, r = 10
dim as double t0 = timer, t1 = t0, t2 = 0, td = 0.0001
dim as string k

do while( t1 - t0 < maxtime ) 

	k = inkey
	select case k
	case chr(27)
		exit do
	end select

	dy += td * 200
	x += dx * td
	y += dy * td

	if( (dx > 0) and (x > w - r) ) then
		dx *= -1
	elseif( (dx < 0) and (x < r) ) then
		dx *= -1
	end if

	if( (dy > 0) and (y > h - r - r) ) then
		dy *= -1 * 0.9
	end if
	
	circle ( x, y ), r

	sleep 15, 1

	t2 = timer
	td = t2 - t1
	t1 =t2
loop

cls
print "exiting"
sleep 1000, 1
