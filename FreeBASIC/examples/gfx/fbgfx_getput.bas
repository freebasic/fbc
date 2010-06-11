

type fb_image field = 1
	width 				as ushort
	height 				as ushort
  	imagedata(64000) 	as ubyte
end type

type udtfield
	x					as integer
	y					as integer
	array(64000+4)		as ubyte
end type

declare sub redraw(byref title as string)

	dim udt as fb_image
	dim udt_ptr as fb_image ptr
	dim array(16001) as integer
	dim array_ptr as integer ptr
	dim udtf as udtfield, pudtf as udtfield ptr
	dim k as string

	screen 13

	udt_ptr = @udt
	array_ptr = @array(0)
	pudtf = @udtf

	dim as integer i = 0

	redraw "array": clear array(0),,64004
	get (0,0)-(319,199), array
	cls: put (0,0), array, pset: sleep
	k = inkey

	redraw "array(i)": clear array(0),,64004
	get (0,0)-(319,199), array(i)
	cls: put (0,0), array(i), pset: sleep
	k = inkey

	redraw "@array(i)": clear array(0),,64004
	get (0,0)-(319,199), @array(i)
	cls: put (0,0), @array(i), pset: sleep
	k = inkey

	redraw "array_ptr": clear array(0),,64004
	get (0,0)-(319,199), array_ptr
	cls: put (0,0), array_ptr, pset: sleep
	k = inkey

	redraw "@udt": clear udt,, 64004
	get (0,0)-(319,199), @udt
	cls: put (0,0), @udt, pset: sleep
	k = inkey

	'redraw "udt_ptr": clear udt,,64004
	'get (0,0)-(319,199), udt_ptr
	'cls: put (0,0), udt_ptr, pset: sleep
	'k = inkey

	redraw "@array_ptr[i]": clear array(0),,64004
	get (0,0)-(319,199), @array_ptr[i]
	cls: put (0,0), @array_ptr[i], pset: sleep
	k = inkey

	'redraw "@udt_ptr[i]": clear udt,,64004
	'get (0,0)-(319,199), @udt_ptr[i]
	'cls: put (0,0), @udt_ptr[i], pset: sleep
	'k = inkey

	redraw "udt.array": clear udtf.array(0),,64004
	get (0,0)-(319,199), udtf.array
	cls: put (0,0), udtf.array, pset: sleep
	k = inkey

	redraw "udt.array(i)": clear udtf.array(0),,64004
	get (0,0)-(319,199), udtf.array(i)
	cls: put (0,0), udtf.array(i), pset: sleep
	k = inkey

	redraw "@udt.array(i)": clear udtf.array(0),,64004
	get (0,0)-(319,199), @udtf.array(i)
	cls: put (0,0), @udtf.array(i), pset: sleep
	k = inkey

	redraw "udt->array(i)": clear udtf.array(0),,64004
	get (0,0)-(319,199), pudtf->array(i)
	cls: put (0,0), pudtf->array(i), pset: sleep
	k = inkey


sub redraw(byref title as string)
	static as integer c = 1
	cls
	line (0,0)-(319,199), c
	line (0,199)-(319,0), c+1	
	print title
	c += 1
end sub
