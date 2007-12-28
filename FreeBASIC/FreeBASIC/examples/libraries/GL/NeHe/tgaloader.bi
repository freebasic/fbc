''*******************************************************************************
'' Name:        TGALoader.bi
'' Purpose:     Load Compressed and Uncompressed TGA files
'' Functions:   LoadTGA(texture, filename)
''              LoadCompressedTGA(texture, filename, fTGA)
''              LoadUncompressedTGA(texture, filename, fTGA)
''******************************************************************************
#include once "crt.bi"

type structTexture
	imageData as ubyte ptr				'' Image Data (Up To 32 Bits)
	bpp as uinteger						'' Image Color Depth In Bits Per Pixel
	texwidth as uinteger				'' Image Width
	height as uinteger					'' Image Height
	texID as uinteger					'' Texture ID Used To Select A Texture
	textype	as uinteger					'' Image Type (GL_RGB, GL_RGBA)
end type

type structTGAHeader
	Header(0 to 11) as ubyte			'' TGA File Header
end type

type structTGA
	header(0 to 5) as ubyte				'' First 6 Useful Bytes From The Header
	bytesPerPixel as uinteger			'' Holds Number Of Bytes Per Pixel Used In The TGA File
	imageSize as uinteger				'' Used To Store The Image Size When Setting Aside Ram
	temp as uinteger					'' Temporary Variable
	ttype as uinteger
	Height as uinteger					'' Height of Image
	wwidth as uinteger					'' Width ofImage
	Bpp as uinteger						'' Bits Per Pixel
end type


dim shared as structTGAHeader tgaheader		'' TGA header
dim shared as structTGA tga					'' TGA image data



dim shared as ubyte uTGAcompare(0 to 11) => {0,0,2, 0,0,0,0,0,0,0,0,0}	'' Uncompressed TGA Header
dim shared as ubyte cTGAcompare(0 to 11) => {0,0,10,0,0,0,0,0,0,0,0,0}	'' Compressed TGA Header

declare function LoadUncompressedTGA(byval as structTexture ptr, byref fname as string, byval filenumber as integer) as integer
declare function LoadCompressedTGA(byval as structTexture ptr, byref fname as string, byval filenumber as integer) as integer


'' *******************************************************************************
'' name :      LoadTGA(texture, filename)
'' function:   Open and test the file to make sure it is a valid TGA file
'' parems:     texture, pointer to a Texture structure
''             filename, name of file to open
'' *******************************************************************************

function LoadTGA(byval texture as structTexture ptr, byref filename as string) as integer      '' Load a TGA file
	dim fTGA as integer
	fTGA = freefile
	if (open (filename, for binary, as fTGA) <> 0) then '' Open file for reading
		''  If it didn't open....
		return false                                    '' Exit function
	end if

	''  Attempt to read 12 byte header from file
	get #fTGA, , tgaheader

	''  See if header matches the predefined header of
	if memcmp (@uTGAcompare(0), @tgaheader, len(tgaheader)) = 0 then     '' an Uncompressed TGA image
		LoadUncompressedTGA (texture, filename, fTGA)   '' If so, jump to Uncompressed TGA loading code
		''  See if header matches the predefined header of
	elseif memcmp (@cTGAcompare(0), @tgaheader, len(tgaheader)) = 0 then '' an RLE compressed TGA image
		LoadCompressedTGA (texture, filename, fTGA)     '' If so, jump to Compressed TGA loading code
		''  If header matches neither type
	else
		close fTGA
		return false                                    '' Exit function
	end if
	return true                                         '' All went well, continue on
end function

'' Load an uncompressed TGA (note, much of this code is based on NeHe's
function LoadUncompressedTGA(byval texture as structTexture ptr, byref fname as string, byval fTGA as integer) as integer
	'' TGA Loading code nehe.gamedev.net)
	''  Read TGA header
	dim pb as ubyte ptr
	dim b as ubyte
	dim i as integer

	get #fTGA,, tga.header()

	texture->texwidth = tga.header(1)*256 + tga.header(0)   ''  Determine The TGA Width   (highbyte*256+lowbyte)
	texture->height = tga.header(3)*256 + tga.header(2)     ''  Determine The TGA Height   (highbyte*256+lowbyte)
	texture->bpp = tga.header(4)                            ''  Determine the bits per pixel
	tga.wwidth = texture->texwidth                          ''  Copy width into local structure
	tga.Height = texture->height                            ''  Copy height into local structure
	tga.Bpp = texture->bpp                                  ''  Copy BPP into local structure

	''  Make sure all information is valid
	if (texture->texwidth <= 0) or (texture->height <= 0) or ((texture->bpp <> 24) and (texture->bpp <> 32)) then
		''  Check if file is still open
		if fTGA <> NULL then
			close fTGA                                      '' If so, close it
		end if
		return false                                        '' Return failed
	end if
	''  If the BPP of the image is 24...
	if texture->bpp = 24 then                               '' Set Image type to GL_RGB
		texture->textype = GL_RGB
	else                                                    ''  Else if its 32 BPP Set image type to GL_RGBA
		texture->textype = GL_RGBA
	end if
	tga.bytesPerPixel = (tga.Bpp \ 8)                       '' Compute the number of BYTES per pixel
	tga.imageSize = (tga.bytesPerPixel*tga.wwidth*tga.Height)    '' Compute the total amount of memory needed to store data
	texture->imageData = allocate(tga.imageSize)            '' Allocate that much memory

	''  If no space was allocated
	if texture->imageData = NULL then
		close fTGA                                          '' Close the file
		return false                                        '' Return failed
	end if

	''  Attempt to read image data
	pb = texture->imageData
	for i = 0 to tga.imageSize -1
		get #fTGA, , b
		*pb = b : pb = pb + 1
	next

	''  Byte Swapping Optimized By Steve Thomas
	dim  as uinteger cswap = 0
	while cswap<tga.imageSize
		texture->imageData[cswap] = texture->imageData[cswap] xor texture->imageData[cswap + 2]
		texture->imageData[cswap + 2] = texture->imageData[cswap + 2] xor texture->imageData[cswap]
		texture->imageData[cswap] = texture->imageData[cswap] xor texture->imageData[cswap + 2]
		cswap+=tga.bytesPerPixel
	wend

	close fTGA                         '' Close file
	return true                        '' Return success
end function

'' Load COMPRESSED TGAs
function LoadCompressedTGA(byval texture as structTexture ptr, byref fname as string, byval fTGA as integer) as integer
	dim pb as ubyte ptr
	dim b as ubyte
	dim i as integer

	''  Attempt to read header
	get #fTGA,, tga.header()

	texture->texwidth = tga.header(1)*256 + tga.header(0)      '' Determine The TGA Width   (highbyte*256+lowbyte)
	texture->height = tga.header(3)*256 + tga.header(2)        '' Determine The TGA Height   (highbyte*256+lowbyte)
	texture->bpp = tga.header(4)                               '' Determine Bits Per Pixel
	tga.wwidth = texture->texwidth                             '' Copy width to local structure
	tga.Height = texture->height                               '' Copy width to local structure
	tga.Bpp = texture->bpp                                     '' Copy width to local structure

	'' Make sure all texture info is ok
	if (texture->texwidth <= 0) or (texture->height <= 0) or ((texture->bpp <> 24) and (texture->bpp <> 32)) then
		''  Check if file is open
		if fTGA <> NULL then
			close fTGA                                         '' If it is, close it
		end if
		return false                                           '' Return failed
	end if
	''  If the BPP of the image is 24...
	if texture->bpp = 24 then                                  '' Set Image type to GL_RGB
		texture->textype = GL_RGB
	else                                                       '' Else if its 32 BPP Set image type to GL_RGBA
		texture->textype = GL_RGBA
	end if
	tga.bytesPerPixel = (tga.Bpp \ 8)                          '' Compute BYTES per pixel
	tga.imageSize = (tga.bytesPerPixel*tga.wwidth*tga.Height)  '' Compute amount of memory needed to store image
	texture->imageData = allocate(tga.imageSize)               '' Allocate that much memory

	''  If it wasn't allocated correctly..
	if texture->imageData = NULL then
		close fTGA                                             '' Close file
		return false                                           '' Return failed
	end if

	dim as uinteger pixelcount = tga.Height*tga.wwidth         '' Number of pixels in the image
	dim as uinteger currentpixel = 0                           '' Current pixel being read
	dim as uinteger currentbyte = 0                            '' Current byte
	dim colorbuffer as ubyte ptr                               '' Storage for 1 pixel

	colorbuffer = allocate (tga.bytesPerPixel)

	do
		dim as ubyte chunkheader = 0                           '' Storage for "chunk" header
		dim as short counter = 0

		''  Read in the 1 byte header
		get #fTGA,,chunkheader
		''  If the header is < 128, it means the that is the number of RAW color packets minus 1
		if chunkheader < 128 then                              '' that follow the header
			chunkheader+=1                                     '' add 1 to get number of following color values
			''  Read RAW color values			
			while counter<chunkheader
				''  Try to read 1 pixel
				pb = colorbuffer
				for i = 0 to tga.bytesPerPixel-1
					get #fTGA, , b
					*pb = b : pb = pb + 1
				next
				''  write to memory
				texture->imageData[currentbyte] = colorbuffer[2]      '' Flip R and B color values around in the process
				texture->imageData[currentbyte + 1] = colorbuffer[1]
				texture->imageData[currentbyte + 2] = colorbuffer[0]

				''  if its a 32 bpp image
				if tga.bytesPerPixel = 4 then
					texture->imageData[currentbyte + 3] = colorbuffer[3]     '' copy the 4th byte
				end if
				currentbyte += tga.bytesPerPixel           '' Increase the current byte by the number of bytes per pixel
				currentpixel+=1                            '' Increase current pixel by 1

				'' ' Make sure we haven't read too many pixels
				if currentpixel > pixelcount then
					''  If there is a file open
					if fTGA <> NULL then
						close (fTGA)                       '' Close file
					end if
					''  If there is data in colorbuffer
					if colorbuffer <> NULL then
						deallocate (colorbuffer)           '' Delete it
					end if
					''  If there is Image data
					if texture->imageData <> NULL then
						deallocate (texture->imageData)    '' delete it
					end if
					return false                           '' Return failed
				end if
				counter+=1
			wend
		else    ''  chunkheader > 128 RLE data, next color repeated chunkheader - 127 times
			chunkheader -= 127                             '' Subtract 127 to get rid of the ID bit
			''  Attempt to read following color values
			pb = colorbuffer
			for i = 0 to tga.bytesPerPixel-1
				get #fTGA, , b
				*pb = b : pb = pb + 1
			next
			''  copy the color into the image data as many times as dictated
			counter = 0
			while counter<chunkheader
				'' by the header
				texture->imageData[currentbyte] = colorbuffer[2]      '' switch R and B bytes around while copying
				texture->imageData[currentbyte + 1] = colorbuffer[1]
				texture->imageData[currentbyte + 2] = colorbuffer[0]

				''  If TGA images is 32 bpp
				if tga.bytesPerPixel = 4 then
					texture->imageData[currentbyte + 3] = colorbuffer[3]  '' Copy 4th byte
				end if
				currentbyte += tga.bytesPerPixel            '' Increase current byte by the number of bytes per pixel
				currentpixel+=1                             '' Increase pixel count by 1

				''  Make sure we haven't written too many pixels
				if currentpixel > pixelcount then
					''  If there is a file open
					if fTGA <> NULL then
						close (fTGA)    '' Close file
					end if
					''  If there is data in colorbuffer
					if colorbuffer <> NULL then
						deallocate (colorbuffer)             '' Delete it
					end if
					''  If there is Image data
					if texture->imageData <> NULL then
						deallocate (texture->imageData)      '' delete it
					end if
					return false                             '' Return failed
				end if
				counter+=1
			wend
		end if
	loop while (currentpixel < pixelcount)                   '' Loop while there are still pixels left

	close fTGA                                               '' Close the file
	return true                                              '' return success
end function
