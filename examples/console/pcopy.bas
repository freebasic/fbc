
dim SCRW as integer = width and &hffff
dim SCRH as integer = (width shr 16) and &hffff

locate ,, 0

'' fill page 1
screen , 1
color 15, 1
locate 1, 1
PRINT STRING(SCRW * SCRH, asc("1"));

'' fill page 2
screen , 2
color 14, 2
locate 1, 1
PRINT STRING(SCRW * SCRH, asc("2"));

'' fill page 3
screen , 3
color 13, 3
locate 1, 1
PRINT STRING(SCRW * SCRH, asc("3"));

'' copy to page 0
dim as integer pg = 0, fpscnt = 0, fps = 0
dim as double tini = timer
do 
	pcopy 1 + pg
	pg = (pg + 1) mod 3
	
	fps += 1
	if timer - tini >= 1 then
		fpscnt = fps
		fps = 0
		tini = timer
	end if
loop until len(inkey) > 0

screen , 0
cls
print "fps:"; fpscnt
sleep
