
TYPE FB_IMAGE field = 1
	width 				AS USHORT
	height 				AS USHORT
  	imageData(64000) 	AS UBYTE
END TYPE

declare SUB Redraw(title AS STRING)

	DIM udt AS FB_IMAGE
	DIM udt_ptr AS FB_IMAGE PTR
	DIM array(16001) AS INTEGER
	DIM array_ptr AS INTEGER PTR

	SCREEN 13

	udt_ptr = @udt
	array_ptr = @array(0)


	Redraw "array": CLEAR array(0),,64004
	GET (0,0)-(319,199), array
	CLS: PUT (0,0), array, PSET: sleep
	k$ = inkey$

	Redraw "array(0)": CLEAR array(0),,64004
	GET (0,0)-(319,199), array(0)
	CLS: PUT (0,0), array(0), PSET: sleep
	k$ = inkey$

	Redraw "@array(0)": CLEAR array(0),,64004
	GET (0,0)-(319,199), @array(0)
	CLS: PUT (0,0), @array(0), PSET: sleep
	k$ = inkey$

	Redraw "array_ptr": CLEAR array(0),,64004
	GET (0,0)-(319,199), array_ptr
	CLS: PUT (0,0), array_ptr, PSET: sleep
	k$ = inkey$

	Redraw "@udt": CLEAR udt,, 64004
	GET (0,0)-(319,199), @udt
	CLS: PUT (0,0), @udt, PSET: sleep
	k$ = inkey$

	Redraw "udt_ptr": CLEAR udt,,64004
	GET (0,0)-(319,199), udt_ptr
	CLS: PUT (0,0), udt_ptr, PSET: sleep
	k$ = inkey$

	Redraw "@array_ptr[0]": CLEAR array(0),,64004
	GET (0,0)-(319,199), @array_ptr[0]
	CLS: PUT (0,0), @array_ptr[0], PSET: sleep
	k$ = inkey$

	Redraw "@udt_ptr[0]": CLEAR udt,,64004
	GET (0,0)-(319,199), @udt_ptr[0]
	CLS: PUT (0,0), @udt_ptr[0], PSET: sleep


SUB Redraw(title AS STRING)
	CLS
	LINE (0,0)-(319,199), 4
	LINE (0,199)-(319,0), 2
	PRINT title
END SUB
