''
''      This Code Was Created By Jeff Molofee and GB Schmick 2000
''      A HUGE Thanks To Fredric Echols For Cleaning Up
''      And Optimizing The Base Code, Making It More Flexible!
''      If You've Found This Code Useful, Please Let Me Know.
''      Visit Our Sites At www.tiptup.com and nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use Up and Down arrow keys to scroll list
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson24.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "crt.bi"

''------------------------------------------------------------------------------
'' Type to store image data
type TEXTUREIMAGE                                  '' Create A Structure
	imageData as ubyte ptr                         '' Image Data (Up To 32 Bits)
	bpp as uinteger                                '' Image Color Depth In Bits Per Pixel.
	wwidth as uinteger                             '' Image Width
	height as uinteger                             '' Image Height
	texID as uinteger                              '' Texture ID Used To Select A Texture
end type                                           '' Structure Name

''------------------------------------------------------------------------------
declare function LoadTGA(byval texture as TEXTUREIMAGE ptr, byref filename as string) as integer
declare sub BuildFont()
declare sub glPrint cdecl (byval x as integer, byval y as integer, byval gset as integer, byref fmt as string, ...)


dim shared textures(0) as TEXTUREIMAGE             '' Storage For One Texture
dim shared gbase as uinteger                       '' Base Display List For The Font

	dim scroll as integer                          '' Used For Scrolling The Screen
	dim maxtokens as integer                       '' Keeps Track Of The Number Of Extensions Supported
	dim swidth as integer                          '' Scissor Width
	dim sheight as integer                         '' Scissor Height

	dim token as string                            '' Storage For Our Token
	dim cnt as integer = 0                         '' Local Counter Variable
	dim text as string                             '' List of extensions
	dim as integer i, j                            '' counters for parsing extension list

	windowtitle "NeHe's Token, Extensions, Scissoring & TGA Loading Tutorial"   '' Set window title
	screen 18, 16, , 2

	'' ReSizeGLScene
	swidth=640                                     '' Set Scissor Width To Window Width
	sheight=480                                    '' Set Scissor Height To Window Height
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	glOrtho 0.0, 640, 480, 0.0, -1.0, 1.0          '' Create Ortho 640x480 View (0,0 At Top Left)
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity

	'' All Setup For OpenGL Goes Here

	if (not LoadTGA(@textures(0), exepath + "/data/Font.tga")) then   '' Load The Font Texture
		end 1                                  '' If Loading Failed, Quit
	end if
	
	BuildFont()                                           '' Build The Font

	glShadeModel(GL_SMOOTH)                               '' Enable Smooth Shading
	glClearColor(0.0, 0.0, 0.0, 0.5)                      '' Black Background
	glClearDepth(1.0)                                     '' Depth Buffer Setup
	glBindTexture(GL_TEXTURE_2D, textures(0).texID)       '' Select Our Font Texture

	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear The Screen And The Depth Buffer
		glColor3f(1.0, 0.5, 0.5)                          ''  Set Color To Bright Red
		glPrint(50, 16, 1, "Renderer")                    ''  Display Renderer
		glPrint(80, 48, 1, "Vendor")                      ''  Display Vendor Name
		glPrint(66, 80, 1, "Version")                     ''  Display Version

		glColor3f(1.0, 0.7, 0.4)                          ''  Set Color To Orange
		glPrint(200, 16, 1, *glGetString(GL_RENDERER))    ''  Display Renderer
		glPrint(200, 48, 1, *glGetString(GL_VENDOR))      ''  Display Vendor Name
		glPrint(200, 80, 1, *glGetString(GL_VERSION))     ''  Display Version

		glColor3f(0.5,0.5,1.0)                            ''  Set Color To Bright Blue
		glPrint(192,432,1,"NeHe Productions")             ''  Write NeHe Productions At The Bottom Of The Screen

		glLoadIdentity()                                  ''  Reset The ModelView Matrix
		glColor3f(1.0,1.0,1.0)                            ''  Set The Color To White
		glBegin(GL_LINE_STRIP)                            ''  Start Drawing Line Strips (Something New)
			glVertex2d(639,417)                           ''  Top Right Of Bottom Box
			glVertex2d(0,417)                             ''  Top Left Of Bottom Box
			glVertex2d(0,480)                             ''  Lower Left Of Bottom Box
			glVertex2d(639,480)                           ''  Lower Right Of Bottom Box
			glVertex2d(639,128)                           ''  Up To Bottom Right Of Top Box
		glEnd()                                           ''  Done First Line Strip
		glBegin(GL_LINE_STRIP)                            ''  Start Drawing Another Line Strip
			glVertex2d(0,128)                             ''  Bottom Left Of Top Box
			glVertex2d(639,128)                           ''  Bottom Right Of Top Box
			glVertex2d(639, 1)                            ''  Top Right Of Top Box
			glVertex2d(0, 1)                              ''  Top Left Of Top Box
			glVertex2d(0,417)                             ''  Down To Top Left Of Bottom Box
		glEnd()                                           ''  Done Second Line Strip

		glScissor(1 , int(0.135416*sheight), swidth-2, int(0.597916*sheight))      ''  Define Scissor Region
		glEnable(GL_SCISSOR_TEST)                         ''  Enable Scissor Testing

		text = *glGetString(GL_EXTENSIONS)        ''  Grab The Extension List, Store In Text

		''  Parse 'text'  For Words, Separated By spaces
		i = 1                            '' i is start position for search
		j = instr(i,text, " ")           '' j is location in extension string of next space
		token = mid(text, i, j - i)      '' extract token from extension string
		i = j + 1                        '' advance start position for next search
        cnt = 0                          '' reset counter
		while (j <> 0)                                   ''  While The Token Isn't NULL
			cnt = cnt + 1                                ''  Increase The Counter
			if (cnt>maxtokens) then                      ''  Is 'maxtokens' Less Than 'cnt'
				maxtokens=cnt                            ''  If So, Set 'maxtokens' Equal To 'cnt'
			end if

			glColor3f(0.5,1.0,0.5)                       ''  Set Color To Bright Green
			glPrint(0,96+(cnt*32)-scroll,0,"%i",cnt)     ''  Print Current Extension Number
			glColor3f(1.0,1.0,0.5)                       ''  Set Color To Yellow
			glPrint(50,96+(cnt*32)-scroll,0,token)       ''  Print The Current Token (Parsed Extension Name)
			j = instr(i,text, " ")           '' j is location in extension string of next space
			token = mid(text, i, j - i)      '' extract token from extension string
			i = j + 1                        '' advance start position for next search
		wend

		glDisable(GL_SCISSOR_TEST)                              ''  Disable Scissor Testing
		glFlush()                                               ''  Flush The Rendering Pipeline

		'' Keyboard handlers
		if MULTIKEY(FB.SC_UP) and (scroll>0) then                  '' Is Up Arrow Being Pressed?
			scroll =scroll-2                                    '' If So, Decrease 'scroll' Moving Screen Down
		end if

		if MULTIKEY(FB.SC_DOWN) and scroll < 32*(maxtokens-9) then '' Is Down Arrow Being Pressed?
			scroll=scroll+2                                     '' If So, Increase 'scroll' Moving Screen Up
		end if

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do    '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend

	glDeleteLists(gbase,256)                      '' Delete All 256 Display Lists
	end


'------------------------------------------------------------------------
'' Loads A TGA File Into Memory
function LoadTGA(byval texture as TEXTUREIMAGE ptr, byref filename as string) as integer
	dim i as integer
	dim TGAheader (0 to 11) as ubyte => {0,0,2,0,0,0,0,0,0,0,0,0} '' Uncompressed TGA Header
	dim TGAcompare(0 to 11) as ubyte           '' Used To Compare TGA Header
	dim header(0 to 5) as ubyte                '' First 6 Useful Bytes From The Header
	dim bytesPerPixel as uinteger              '' Holds Number Of Bytes Per Pixel Used In The TGA File
	dim imageSize as integer                   '' Used To Store The Image Size When Setting Aside Ram
	dim temp as ubyte                          '' Temporary Variable
	dim gtype as uinteger  = GL_RGBA           '' Set The Default GL Mode To RBGA (32 BPP)
	dim hFile as integer
	dim pb as ubyte ptr
	dim b as ubyte

	hFile = freefile                           '' Open The TGA File
	if (open (filename, for binary, as hFile) <> 0) then
		return false                           '' Exit if File not Even Exist
	end if

	if lof(hFile) > 18 then                    '' Are There 12+6 Bytes To Read?
		get #hFile, , TGAcompare()             '' If So Read FIrst 12 Header Bytes
		if memcmp(@TGAheader(0),@TGAcompare(0),len(TGAheader)) = 0 then     '' Does The Header Match What We Want?
			get #hFile, , header()             '' If So Read Next 6 Header Bytes
		else
			'Header does not match
			close hFile
			return FALSE
		end if
	else
		'File is too small to be a TGA File
		close hFile
		return FALSE
	end if

	texture->wwidth = header(1) * 256 + header(0)        '' Determine The TGA Width (highbyte*256+lowbyte)
	texture->height = header(3) * 256 + header(2)        '' Determine The TGA Height (highbyte*256+lowbyte)

	if (texture->wwidth <=0 or _                         '' Is The Width Less Than Or Equal To Zero
			texture->height <=0 or _                     '' Is The Height Less Than Or Equal To Zero
			(header(4) <> 24 and header(4) <> 32)) then  '' Is The TGA 24 or 32 Bit?
		close hFile                                      '' If Anything Failed, Close The File
		return FALSE                                     '' Return FALSE
	end if

	texture->bpp = header(4)                                '' Grab The TGA's Bits Per Pixel (24 or 32)

	bytesPerPixel = texture->bpp/8                          '' Divide By 8 To Get The Bytes Per Pixel
	imageSize = texture->wwidth*texture->height*bytesPerPixel  '' Calculate The Memory Required For The TGA Data

	texture->imageData=allocate(imageSize)               '' Reserve Memory To Hold The TGA Data

	if texture->imageData = NULL then                    '' Does The Storage Memory Exist?
		close hFile                                      '' Close The File
		return FALSE                                     '' Return FALSE
	end if

	pb = texture->imageData
	for i = 0 to imageSize -1
		get #hFile, , b
		*pb = b : pb = pb + 1
	next

	for i=0 to imageSize -1 step bytesPerPixel           '' Loop Through The Image Data Swaps The 1st And 3rd Bytes ('R'ed and 'B'lue)
		temp=texture->imageData[i]                       '' Temporarily Store The Value At Image Data 'i'
		texture->imageData[i] = texture->imageData[i+2]  '' Set The 1st Byte To The Value Of The 3rd Byte
		texture->imageData[i+2] = temp                   '' Set The 3rd Byte To The Value In 'temp' (1st Byte Value)
	next

	close hFile                                          '' Close The File

	'' Build A Texture From The Data
	glGenTextures(1, varptr(texture->texID))             '' Generate OpenGL texture IDs

	glBindTexture(GL_TEXTURE_2D, texture->texID)         '' Bind Our Texture
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)  '' Linear Filtered
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)  '' Linear Filtered

	if (texture[0].bpp=24) then                          '' Was The TGA 24 Bits
		gtype=GL_RGB                                     '' If So Set The 'type' To GL_RGB
	end if

	glTexImage2D(GL_TEXTURE_2D, 0, gtype, texture[0].wwidth, texture[0].height, 0, gtype, GL_UNSIGNED_BYTE, texture[0].imageData)

	return TRUE                                          '' Texture Building Went Ok, Return True
end function


'------------------------------------------------------------------------
sub BuildFont()                                  '' Build Our Font Display List
	dim loop1 as integer
	dim cx as single                             '' Holds Our X Character Coord
	dim cy as single                             '' Holds Our Y Character Coord

	gbase = glGenLists(256)                      '' Creating 256 Display Lists
	glBindTexture GL_TEXTURE_2D, textures(0).texID      '' Select Our Font Texture
	for loop1 = 0 to 255                         '' Loop Through All 256 Lists

		cx = (loop1 mod 16)/16.0                 '' X Position Of Current Character
		cy = (loop1\16)/16.0                     '' Y Position Of Current Character

		glNewList gbase+loop1, GL_COMPILE        '' Start Building A List
		glBegin GL_QUADS                         '' Use A Quad For Each Character
			glTexCoord2f cx, 1-cy-0.0625         '' Texture Coord (Bottom Left)
			glVertex2i 0, 16                     '' Vertex Coord (Bottom Left)
			glTexCoord2f cx+0.0625, 1-cy-0.0625  '' Texture Coord (Bottom Right)
			glVertex2i 16, 16                    '' Vertex Coord (Bottom Right)
			glTexCoord2f cx+0.0625, 1-cy         '' Texture Coord (Top Right)
			glVertex2i 16, 0                     '' Vertex Coord (Top Right)
			glTexCoord2f cx, 1-cy                '' Texture Coord (Top Left)
			glVertex2i 0, 0                      '' Vertex Coord (Top Left)
		glEnd                                    '' Done Building Our Quad (Character)
		glTranslated 14, 0, 0                    '' Move To The Right Of The Character
		glEndList                                '' Done Building The Display List
	next                                         '' Loop Until All 256 Are Built
end sub

'------------------------------------------------------------------------
'' Where The Printing Happens
sub glPrint cdecl (byval x as integer, byval y as integer, byval gset as integer, byref fmt as string, ...)
	dim text as string * 256                '' Holds Our String
	dim ap as any ptr                       '' Pointer To List Of Arguments

	if len(fmt) = 0 then                    '' If There's No Text
		exit sub                            '' Do Nothing
	end if

	ap = va_first()                         '' get pointer to first arg
	vsprintf(text, fmt, ap)                 '' And Converts Symbols To Actual Numbers

	if gset>1 then                          '' Did User Choose An Invalid Character Set?
		gset=1                              '' If So, Select Set 1 (Italic)
	end if

	glEnable(GL_TEXTURE_2D)                 '' Enable Texture Mapping
	glLoadIdentity()                        '' Reset The Modelview Matrix
	glTranslated(x,y,0)                     '' Position The Text (0,0 - Bottom Left)
	glListBase(gbase-32+(128*gset))         '' Choose The Font Set (0 or 1)

	glScalef 1.0, 2.0, 1.0                  '' Make The Text 2X Taller

	glCallLists(strlen(text),GL_UNSIGNED_BYTE, strptr(text)) '' Write The Text To The Screen
	glDisable(GL_TEXTURE_2D)                '' Disable Texture Mapping
end sub

