OPTION EXPLICIT

TYPE SCREENINFOTYPE
	driver_name AS STRING
	w AS INTEGER
	h AS INTEGER
	depth AS INTEGER
	pitch AS INTEGER
	bpp AS INTEGER
	mask_color AS INTEGER
	num_pages AS INTEGER
	flags AS INTEGER
END TYPE

DIM depth(3) AS INTEGER
DIM info AS SCREENINFOTYPE PTR
DIM key AS STRING
DIM i AS INTEGER, j AS INTEGER

depth(0) = 8
depth(1) = 16
depth(2) = 32

FOR i = 0 to 2
	SCREEN 14, depth(i)
	info = SCREENINFO
	LOCATE 1: PRINT "Mode: " + STR$(info->w) + "x" + STR$(info->h) + "x" + STR$(info->depth);
	PRINT " (" + info->driver_name + ")"
	IF (i = 0) THEN
		FOR j = 0 TO 255: LINE(32+j, 100)-(32+j, 139), j : NEXT
	ELSE
		FOR j = 0 TO 255
			LINE(32+j, 40)-(32+j, 79), j SHL 16
			LINE(32+j, 100)-(32+j, 139), j SHL 8
			LINE(32+j, 160)-(32+j, 199), j
		NEXT
	END IF
	key = INKEY$
	WHILE key = "": key = INKEY$: WEND
	IF key = CHR$(255) + "X" THEN END
NEXT i
