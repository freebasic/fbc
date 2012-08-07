'' QB-ish graphics test

sub createsprite( sprite() as byte, byval w as integer, byval h as integer, byval bpp as integer = 1 )
	redim sprite(0 to w*h*bpp-1 + 2*len(short)) as byte

	cls

	for y as integer = 0 to h-1
		for x as integer = 0 to w-1
			pset (x, y), (x xor y) * 4
		next
	next

	line (0,0)-(w-1, h-1), 0, B

	get (0, 0)-(w-1,h-1), sprite(0)

	cls
end sub

const xres = 320*1
const yres = 200*1

screen 13

window (0, 0)-(xres-1, yres-1)
view (4,4)-(xres-4,yres-4)

dim as integer mypal(0 to 255) 
for i as integer = 0 to 255
	mypal(i) = (i \ 4) shl 16
next
mypal(255) = 63 shl 16 or 63 shl 8 or 63

palette using mypal

const spritesize = 64
dim mysprite() as byte
createsprite( mysprite(), spritesize, spritesize )

color 255

do
	'' Draw the sprite in 100 different random places :)
	for i as integer = 1 to 100
		put (-spritesize+rnd*(xRes-1+spritesize), -spritesize+rnd*(yRes-1+spritesize)), mysprite, PSET
		'color rnd*254
		'line -( rnd*(xRes-1), rnd*(yRes-1) )
		'line ( rnd*(xRes-1), rnd*(yRes-1) )-( rnd*(xRes-1), rnd*(yRes-1) )
		'circle ( rnd*(xRes-1), rnd*(yRes-1) ), rnd*100, , , , 1.0
	next

	'' Draw some text at a random position
	locate 1 + rnd*23, 1 + rnd*40
	color 255, 0
	print "QB gfx!";

	'' Slow down the loop a little, so the pretty graphics can be seen...
	sleep 100, 1
loop while( len( inkey() ) = 0 )
