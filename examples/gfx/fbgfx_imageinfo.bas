dim as any ptr img
dim as integer wid, hei, bpp, pitch
dim as byte ptr pixdata
dim as integer imgsize
dim as integer x, y
dim as integer res

screenres 320, 200, 8

img = imagecreate(45, 37)

if img = 0 then
	print "ImageCreate failed"
	end
end if


'' Get image information:

res = imageinfo(img, wid, hei, bpp, pitch, pixdata, imgsize)

if res = 0 then
	print "ImageInfo succeeded"
else
	print "ImageInfo failed with error: " & res
end if

print
print "img buffer at:   " & img
print
print "Width:           " & wid
print "Height:          " & hei
print "Bytes per pixel: " & bpp
print "Pitch:           " & pitch
print "Pixel data:      " & pixdata
print "img buffer size: " & imgsize

if res <> 0 then
	imagedestroy img
	sleep
	end
end if
sleep
cls


'' Draw to image buffer
for y = 0 to hei - 1
	for x = 0 to wid - 1
		pset img, (x, y), 56 + sqr( 3*(x-wid\2)^2 + 4*(y-hei\2)^2 ) mod 24
	next x
next y
line img, (0, 0)-(wid-1, hei-1), 15, b


'' PUT image buffer to screen
put (10, 10), img

'' PSET image buffer pixels to screen (should look the same)
screenlock
	for y = 0 to hei - 1
		dim as ubyte ptr p = pixdata + y * pitch
		for x = 0 to wid - 1
			pset (x + 10+wid+10, y + 10), p[x]
		next x
	next y
screenunlock

imagedestroy img

sleep
