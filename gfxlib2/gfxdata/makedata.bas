''
'' Small tool to compress the font and palette data files for gfxlib2 and
'' write the resulting data bytes to inline.h to be compiled into gfxlib2.
'' Run/adjust this to update inline.h as needed.
''
'' best compiled with -g -exx to catch assertions and file I/O errors
''

#define TRUE (-1)
#define FALSE 0
#define NULL 0

#include once "crt.bi"

declare function fb_hEncode lib "fbgfx" alias "fb_hEncode" _
	( _
		byval as const ubyte ptr, _
		byval as integer, _
		byval as ubyte ptr, _
		byval as integer ptr _
	) as integer

type Entry
	as zstring * 16 typename
	as zstring * 16 varname
	as integer num1
	as integer num2
	as zstring * 16 defname
	as zstring * 16 file
	as ubyte ptr p
	as integer size
end type

dim shared as Entry entries(0 to ...) = _
{ _
	( "FONT"   , "fb_font_8x8"   ,   8,  8, "FONT_8" , "fnt08x08.fnt" ), _
	( "FONT"   , "fb_font_8x14"  ,   8, 14, "FONT_14", "fnt08x14.fnt" ), _
	( "FONT"   , "fb_font_8x16"  ,   8, 16, "FONT_16", "fnt08x16.fnt" ), _
	( "PALETTE", "fb_palette_2"  ,   2,  0, "PAL_2"  , "pal002.pal"   ), _
	( "PALETTE", "fb_palette_16" ,  16,  0, "PAL_16" , "pal016.pal"   ), _
	( "PALETTE", "fb_palette_64" ,  64,  0, "PAL_64" , "pal064.pal"   ), _
	( "PALETTE", "fb_palette_256", 256,  0, "PAL_256", "pal256.pal"   )  _
}

'' Load data files
for i as integer = 0 to ubound( entries )
	with( entries(i) )
		dim as string filename = exepath( ) + "/" + .file

		dim as integer f = freefile()
		open filename for binary access read as #f

		.size = lof( f )
		.p = allocate( .size )
		get #f, , *.p, .size, .size
		assert( .size > 0 )

		print "loading: '" + filename + "' (" & .size & " bytes)"

		close #f
	end with
next

'' Get size of all entries combined
dim as integer rawsize = 0
for i as integer = 0 to ubound( entries )
	rawsize += entries(i).size
next

'' Combine all the data files into one big buffer
dim as ubyte ptr raw = allocate( rawsize )
scope
	dim as integer offset = 0
	for i as integer = 0 to ubound( entries )
		with( entries(i) )
			memcpy( raw + offset, .p, .size )
			offset += .size
		end with
	next
end scope

'' Use this to store the raw data into a file
#if 0
scope
	dim as integer f = freefile( )
	open exepath( ) + "/data.dat" for binary access write as #f
	put #f, , *raw, rawsize
	close #f
end scope
#endif

'' Compress the data
dim as integer compressedsize = rawsize
dim as ubyte ptr compressed = allocate( rawsize )
fb_hEncode( raw, rawsize, compressed, @compressedsize )

print rawsize, compressedsize

dim as string ccode
ccode += !"/* Automatically created by makedata, to be used by data.c */\n"
ccode += !"/* Compressed internal font/palette data for FB graphics */\n"
ccode += !"\n"

'' Emit #define and declaration for each entry
scope
	dim as integer offset = 0
	for i as integer = 0 to ubound( entries )
		with( entries(i) )
			ccode += "#define DATA_" + .defname + " 0x" + hex( offset, 8 ) + !"\n"

			ccode += "const " + .typename + " " + .varname + " = {" + str( .num1 ) + ", "
			if( .typename = "FONT" ) then
				ccode += str( .num2 ) + ", "
			end if
			ccode += "&internal_data[DATA_" + .defname + !"]};\n\n"

			offset += .size
		end with
	next
end scope

'' Emit the compressed data
ccode += !"static const unsigned char compressed_data[] = {\n"

for i as integer = 0 to compressedsize - 1
	if( (i mod 16) = 0 ) then
		ccode += "    "
	end if

	ccode += "0x" + hex( compressed[i], 2 )

	if( i < (compressedsize - 1) ) then
		ccode += ","
		'' Emit a newline every 16 bytes
		if( ((i + 1) mod 16) = 0 ) then
			ccode += !"\n"
		else
			ccode += " "
		end if
	else
		ccode += !"\n"
	end if
next

ccode += !"};\n\n"

ccode += !"#define DATA_SIZE " & rawsize & !"\n"

'' Write out the emitted C code into the output file
scope
	dim as integer f = freefile( )
	open exepath( ) + "/inline.h" for output as #f
	print #f, ccode;
	close #f
end scope

print rawsize & " bytes in, " & compressedsize & " bytes out " & _
		"(" & (rawsize / compressedsize) & ":1 ratio)"
