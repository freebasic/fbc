dim as any ptr image
dim as integer w, h, bpp, pitch
dim as byte ptr pixdata
dim as integer size
dim as integer result

screenres 320, 200, 8

image = imagecreate( 45, 37 )
if( image = 0 ) then
	print "ImageCreate failed"
	end
end if

'' Get image information:
result = imageinfo( image, w, h, bpp, pitch, pixdata, size )
if( result <> 0 ) then
	print "imageinfo() failed with error: " & result
end if

print "image buffer at address: " & hex( image )
print "width:             " & w
print "height:            " & h
print "bytes per pixel:   " & bpp
print "pitch:             " & pitch
print "pixel data:        " & pixdata
print "image buffer size: " & size
sleep

'' Draw to image buffer
for y as integer = 0 to h - 1
	for x as integer = 0 to w - 1
		pset image, (x, y), 56 + sqr( 3*(x-w\2)^2 + 4*(y-h\2)^2 ) mod 24
	next
next
line image, (0, 0) - (w - 1, h - 1), 15, b

'' PUT image buffer to screen
put (10, 100), image
sleep

'' PSET image buffer pixels to screen (should look the same)
screenlock
	for y as integer = 0 to h - 1
		dim as byte ptr p = pixdata + y * pitch
		for x as integer = 0 to w - 1
			pset (x + 10 + w + 10, y + 100), p[x]
		next
	next
screenunlock
sleep

imagedestroy( image )
