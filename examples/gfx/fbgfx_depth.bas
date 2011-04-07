

DIM depth(3) AS INTEGER
DIM key AS STRING, driver AS STRING
DIM AS INTEGER i, j, w, h, d, rate

depth(0) = 8
depth(1) = 16
depth(2) = 32

FOR i = 0 to 2
	SCREEN 14, depth(i)
	SCREENINFO w, h, d,,,rate, driver
	LINE(0,0)-(w-1,h-1),IIF(i = 0, 40, CINT(RGB(255, 0, 0))),B
	LOCATE 2,2: PRINT "Mode: " + STR(w) + "x" + STR(h) + "x" + STR(d);
	IF (rate > 0) THEN
		PRINT " @ " + STR(rate) + " Hz";
	END IF
	PRINT " (" + driver + ")"
	IF (i = 0) THEN
		FOR j = 0 TO 255: LINE(32+j, 100)-(32+j, 139), j : NEXT
	ELSE
		FOR j = 0 TO 255
			LINE(32+j, 40)-(32+j, 79), j SHL 16
			LINE(32+j, 100)-(32+j, 139), j SHL 8
			LINE(32+j, 160)-(32+j, 199), j
		NEXT
	END IF
	key = INKEY
	WHILE key = "": key = INKEY: WEND
	IF key = CHR(255) + "k" THEN END
NEXT i
