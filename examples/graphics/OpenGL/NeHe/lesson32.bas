''------------------------------------------------------------------------------
''
''    Jeff Molofee's Picking Tutorial
''           nehe.gamedev.net
''                 2001
''
''------------------------------------------------------------------------------



'' Setup our booleans
const false = 0
const true  = not false
const null = 0


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                '' for Scan code constants
#include once "crt.bi"

#ifdef __FB_WIN32__
#include once "windows.bi"
#include once "win/mmsystem.bi"         '' for PlaySound() in sub Selection()
#else
type RECT
	left as long
	top as long
	right as long
	bottom as long
end type
#endif

'' User Defined Variables
dim shared bbase as uinteger            '' Font Display List
dim shared roll as single               '' Rolling Clouds
dim shared as integer level = 1         '' Current Level
dim shared miss as integer              '' Missed Targets
dim shared kills as integer             '' Level Kill Counter
dim shared score as integer             '' Current Score
dim shared game as integer              '' Game Over?

type objects
	rot as uinteger                     '' Rotation (0-None, 1-Clockwise, 2-Counter Clockwise)
	hit as integer                      '' Object Hit?
	frame as uinteger                   '' Current Explosion Frame
	ddir as uinteger                    '' Object Direction (0-Left, 1-Right, 2-Up, 3-Down)
	texid as uinteger                   '' Object Texture ID
	x as single                         '' Object X Position
	y as single                         '' Object Y Position
	spin as single                      '' Object Spin
	distance as single                  '' Object Distance
end type

type TextureImage                       '' Create A Structure
	imageData as ubyte ptr              '' Image Data (Up To 32 Bits)
	bpp as uinteger                     '' Image Color Depth In Bits Per Pixel.
	wwidth as uinteger                  '' Image Width
	height as uinteger                  '' Image Height
	texID as uinteger                   '' Texture ID Used To Select A Texture
end type


dim shared textures(0 to 9) as TextureImage   '' Storage For 10 Textures
dim shared object_(0 to 29) as objects        '' Storage For 30 Objects

type dimensions                         '' Object Dimensions
	w as single                         '' Object Width
	h as single                         '' Object Height
end type

'' Size Of Each Object:    
dim shared size(0 to 4) as dimensions => { _
		(1.0f, 1.0f), _                       '' Blueface
		(1.0f, 1.0f), _                       '' Bucket
		(1.0f, 1.0f), _                       '' Target
		(0.5f, 1.0f), _                       '' Coke
		(0.75f, 1.5f) _                       '' Vase
		}

dim shared as integer mouse_x, mouse_y, mouse_b, mouse_down
 
'------------------------------------------------------------------------
declare function LoadTGA(byval texture as TEXTUREIMAGE ptr, byref filename as string) as integer
declare sub BuildFont ()
declare sub glPrint cdecl(byval x as integer, byval y as integer, byref fmt as string, ...)
declare function Compare (byval elem1 as objects ptr, byval elem2 as objects ptr) as integer
declare sub InitObject (byval num as integer)
declare function Initialize () as integer
declare sub Deinitialize ()
declare sub Selection ()
declare sub Update (byval milliseconds as integer)
declare sub drawobject (byval wwidth as single, byval height as single, byval texid as uinteger)
declare sub Explosion (byval num as integer)
declare sub DrawTargets ()
declare sub drawscr ()
'------------------------------------------------------------------------

	dim as double lastTickCount, tickCount
	windowtitle "NeHe's Picking Tutorial"      '' Set window title
	screen 18, 32, , 2

	'' Initialize The GL Window
	glViewport 0, 0, 640, 480                  '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                 '' Select The Projection Matrix
	glLoadIdentity                             '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 1.0, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                  '' Select The Modelview Matrix
	glLoadIdentity                             '' Reset The Projection Matrix

	if not Initialize() then end               '' All Setup For OpenGL Goes Here
	lastTickCount  = timer
	do
		SETMOUSE , , 0
		getmouse mouse_x, mouse_y , ,mouse_b
		if mouse_x = -1 then SETMOUSE , , 1
		if (mouse_b and 1 ) and not mouse_down then
			Selection()
			mouse_down = true
		end if
		if not (mouse_b and 1) then mouse_down = FALSE

		tickCount = timer
		Update ((tickCount - lastTickCount)*1000)	'' Update The Counter
		lastTickCount = tickCount			        '' Set Last Count To Current Count
		drawscr()
		flip
		if inkey = chr(255)+"k" then exit do      '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0
	Deinitialize()
	'' Empty keyboard buffer
	while inkey <> "": wend

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
		get #hFile, , TGAcompare()             '' If So Read First 12 Header Bytes
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

	texture->bpp = header(4)                             '' Grab The TGA's Bits Per Pixel (24 or 32)

	bytesPerPixel = texture->bpp/8                       '' Divide By 8 To Get The Bytes Per Pixel
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
'' Build Our Font Display List
sub BuildFont ()
	dim  as integer iLoop = 0
	dim cx as single                             '' X Position Of Current Character
	dim cy as single                             '' Y Position Of Current Character

	bbase = glGenLists (95)                            '' Creating 95 Display Lists
	glBindTexture (GL_TEXTURE_2D, textures(9).texID)   '' Bind Our Font Texture
	'' Loop Through All 95 Lists

	while iLoop<95
		cx = (iLoop mod 16) / 16.0f
		cy = (iLoop \ 16) / 8.0f
		glNewList (bbase + iLoop, GL_COMPILE)          '' Start Building A List
		glBegin (GL_QUADS)                             '' Use A Quad For Each Character
			glTexCoord2f (cx, 1.0f - cy - 0.120f)           : glVertex2i (0, 0)    '' Texture / Vertex Coord (Bottom Left)
			glTexCoord2f (cx + 0.0625f, 1.0f - cy - 0.120f) : glVertex2i (16, 0)   '' Texutre / Vertex Coord (Bottom Right)
			glTexCoord2f (cx + 0.0625f, 1.0f - cy)          : glVertex2i (16, 16)  '' Texture / Vertex Coord (Top Right)
			glTexCoord2f (cx, 1.0f - cy)                    : glVertex2i (0, 16)   '' Texture / Vertex Coord (Top Left)
		glEnd ()                                       '' Done Building Our Quad (Character)
		glTranslated (10, 0, 0)                        '' Move To The Right Of The Character
		glEndList ()                                   '' Done Building The Display List
		iLoop+=1
	wend
	'' Loop Until All 256 Are Built
end sub

'------------------------------------------------------------------------
sub glPrint cdecl(byval x as integer, byval y as integer, byref fmt as string, ...)    '' Where The Printing Happens
	dim text as string * 256                           '' Holds Our String
	dim ap as any ptr                                  '' Pointer To List Of Arguments

	'' If There's No Text
	if len(fmt)= 0 then                                '' Do Nothing
		exit sub
	end if

	ap = va_first()                                   '' get pointer to first arg
	vsprintf (text, fmt, ap)                          '' And Converts Symbols To Actual Numbers


	glBindTexture (GL_TEXTURE_2D, textures(9).texID)  '' Select Our Font Texture
	glPushMatrix ()                                   '' Store The Modelview Matrix
		glLoadIdentity ()                             '' Reset The Modelview Matrix
		glTranslated (x, y, 0)                        '' Position The Text (0,0 - Bottom Left)
		glListBase (bbase - 32)                       '' Choose The Font Set
		glCallLists (strlen (text), GL_UNSIGNED_BYTE, strptr(text))   '' Draws The Display List Text
	glPopMatrix ()                                    '' Restore The Old Projection Matrix
end sub

'------------------------------------------------------------------------
'' Compare Function *** MSDN CODE MODIFIED FOR THIS TUT ***
function Compare (byval elem1 as objects ptr, byval elem2 as objects ptr) as integer
 
	if elem1->distance < elem2->distance then
		'' If First Structure distance Is Less Than The Second Return -1
		return  - 1
	elseif elem1->distance > elem2->distance then
		'' If First Structure distance Is Greater Than The Second Return 1
		return  1
	else
		'' Otherwise (If The distance Is Equal) Return 0
		return  0
	end if
end function

'------------------------------------------------------------------------
sub InitObject (byval num as integer)                '' Initialize An Object
	with object_(num)
		.rot = 1                              '' Clockwise Rotation
		.frame = 0                            '' Reset The Explosion Frame To Zero
		.hit = FALSE                          '' Reset Object Has Been Hit Status To False
		.texid = int(rnd * 5)                 '' Assign A New Texture
		.distance = - (int(rnd * 4001) / 100.0f) '' Random Distance
		.y = - 1.5f + (int(rnd * 451) / 100.0f)  '' Random Y Position

		'' Random Starting X Position Based On Distance Of Object And Random Amount For A Delay (Positive Value)
		.x = ((.distance - 15.0f) / 2.0f) - (5 *level) -  (rnd * (5 *level))
		.ddir = int(rnd * 2)                 '' Pick A Random Direction

		'' Is Random Direction Right
		if .ddir = 0 then
				.rot = 2                         '' Counter Clockwise Rotation
				.x = -.x             '' Start On The Left Side (Negative Value)
		end if
		'' Blue Face
		if .texid = 0 then                   '' Always Rolling On The Ground
			.y = - 2.0f
		end if
		'' Bucket
		if .texid = 1 then
			.ddir = 3                        '' Falling Down
			.x = (abs(rnd * cint(.distance - 10.0f))) + ((.distance - 10.0f) / 2.0f)
			.y = 4.5f                        '' Random X, Start At Top Of The Screen
		end if
		'' Target
		if .texid = 2 then
			.ddir = 2                        '' Start Off Flying Up
			.x = abs(rnd *  cint(.distance - 10.0f)) + ((.distance - 10.0f) / 2.0f)
			.y = - 3.0f - cint(rnd * (5 *level))  '' Random X, Start Under Ground + Random Value 32.51
		end if
	end with

	'' Sort Objects By Distance:   Beginning Address Of Our object Array   *** MSDN CODE MODIFIED FOR THIS TUT ***
	''                      Number Of Elements To Sort
	''                      Size Of Each Element
	''                      Pointer To Our Compare Function
	QSORT (@object_(0), level, sizeof (objects),  cast(any ptr,@Compare))
end sub

'------------------------------------------------------------------------
function Initialize () as integer     '' Any OpenGL Initialization Goes Here

	randomize timer                   '' Randomize Things

	if ( not  LoadTGA (@textures(0), exepath + "/data/BlueFace.tga")) _           '' Load The BlueFace Texture
			or  ( not  LoadTGA (@textures(1), exepath + "/data/Bucket.tga")) _    '' Load The Bucket Texture
			or  ( not  LoadTGA (@textures(2), exepath + "/data/Target.tga")) _    '' Load The Target Texture
			or  ( not  LoadTGA (@textures(3), exepath + "/data/Coke.tga")) _      '' Load The Coke Texture
			or  ( not  LoadTGA (@textures(4), exepath + "/data/Vase.tga")) _      '' Load The Vase Texture
			or  ( not  LoadTGA (@textures(5), exepath + "/data/Explode.tga")) _   '' Load The Explosion Texture
			or  ( not  LoadTGA (@textures(6), exepath + "/data/Ground.tga")) _    '' Load The Ground Texture
			or  ( not  LoadTGA (@textures(7), exepath + "/data/Sky.tga")) _       '' Load The Sky Texture
			or  ( not  LoadTGA (@textures(8), exepath + "/data/Crosshair.tga")) _ '' Load The Crosshair Texture
			or  ( not  LoadTGA (@textures(9), exepath + "/data/Font.tga")) then   '' Load The font Texture
		return  FALSE                                                  '' If Loading Failed, Return False
	end if
	BuildFont ()                                         '' Build Our Font Display List

	glClearColor (0.0f, 0.0f, 0.0f, 0.0f)                '' Black Background
	glClearDepth (1.0f)                                  '' Depth Buffer Setup
	glDepthFunc (GL_LEQUAL)                              '' Type Of Depth Testing
	glEnable (GL_DEPTH_TEST)                             '' Enable Depth Testing
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)   '' Enable Alpha Blending (disable alpha testing)
	glEnable (GL_BLEND)                                  '' Enable Blending       (disable alpha testing)
	'' glAlphaFunc(GL_GREATER,0.1f);                     '' Set Alpha Testing     (disable blending)
	'' glEnable(GL_ALPHA_TEST);                          '' Enable Alpha Testing  (disable blending)
	glEnable (GL_TEXTURE_2D)                             '' Enable Texture Mapping
	glEnable (GL_CULL_FACE)                              '' Remove Back Face

	'' Loop Through 30 Objects
	dim  as integer iLoop = 0
	while iLoop<30
		'' Initialize Each Object
		InitObject (iLoop)
		iLoop+=1
	wend

	return  TRUE                                         '' Return TRUE (Initialization Successful)
end function

'------------------------------------------------------------------------
sub Deinitialize ()                                      '' Any User DeInitialization Goes Here
	glDeleteLists (bbase, 95)                            '' Delete All 95 Font Display Lists
end sub

'------------------------------------------------------------------------
sub Selection ()                                         '' This Is Where Selection Is Done
	dim buffer(512) as uinteger                          '' Set Up A Selection Buffer
	dim hits as integer                                  '' The Number Of Objects That We Selected
	if mouse_x = -1 then exit sub
	'' Is Game Over?
	if game = TRUE then                                  '' If So, Don't Bother Checking For Hits
		exit sub
	end if
	#ifdef __FB_WIN32__
		PlaySound ("data/shot.wav", NULL, SND_ASYNC)     '' Play Gun Shot Sound
	#endif
	'' The Size Of The Viewport. (0) Is <x>, (1) Is <y>, (2) Is <length>, (3) Is <width>
	dim viewport(4) as integer

	'' This Sets The Array <viewport> To The Size And Location Of The Screen Relative To The Window
	glGetIntegerv (GL_VIEWPORT, @viewport(0))
	glSelectBuffer (512, @buffer(0))                     '' Tell OpenGL To Use Our Array For Selection

	'' Puts OpenGL In Selection Mode. Nothing Will Be Drawn.  Object ID's and Extents Are Stored In The Buffer.
	glRenderMode (GL_SELECT)

	glInitNames ()                                       '' Initializes The Name Stack
	glPushName (0)                                       '' Push 0 (At Least One Entry) Onto The Stack

	glMatrixMode (GL_PROJECTION)                         '' Selects The Projection Matrix
	glPushMatrix ()                                      '' Push The Projection Matrix
		glLoadIdentity ()                                '' Resets The Matrix

		'' This Creates A Matrix That Will Zoom Up To A Small Portion Of The Screen, Where The Mouse Is.
		gluPickMatrix ( mouse_x,  (viewport(3) - mouse_y), 1.0f, 1.0f, @viewport(0))

		'' Apply The Perspective Matrix
		gluPerspective (45.0f, (viewport(2) - viewport(0)) / (viewport(3) - viewport(1)), 0.1f, 100.0f)
		glMatrixMode (GL_MODELVIEW)                      '' Select The Modelview Matrix
		DrawTargets ()                                   '' Render The Targets To The Selection Buffer
		glMatrixMode (GL_PROJECTION)                     '' Select The Projection Matrix
	glPopMatrix ()                                       '' Pop The Projection Matrix
	glMatrixMode (GL_MODELVIEW)                          '' Select The Modelview Matrix
	hits = glRenderMode (GL_RENDER)                      '' Switch To Render Mode, Find Out How Many
	'' Objects Were Drawn Where The Mouse Was
	'' If There Were More Than 0 Hits
	if hits > 0 then
		dim as integer choose = buffer(3)                '' Make Our Selection The First Object
		dim as integer depth = buffer(1)                 '' Store How Far Away It Is

		'' Loop Through All The Detected Hits
		dim  as integer iLoop = 1
		while iLoop<hits
			'' If This Object Is Closer To Us Than The One We Have Selected
			if buffer(iLoop *4 + 1) < depth then
				choose = buffer(iLoop *4 + 3)            '' Select The Closer Object
				depth = buffer(iLoop *4 + 1)             '' Store How Far Away It Is
			end if
			iLoop+=1
		wend

		'' If The Object Hasn't Already Been Hit
		if  not  object_(choose).hit then
			object_(choose).hit = TRUE                    '' Mark The Object As Being Hit
			score + = 1                                  '' Increase Score
			kills + = 1                                  '' Increase Level Kills
			'' New Level Yet?
			if kills > level *5 then
				miss = 0                                 '' Misses Reset Back To Zero
				kills = 0                                '' Reset Level Kills
				level + = 1                              '' Increase Level
				'' Higher Than 30?
				if level > 30 then                       '' Set Level To 30 (Are You A God?)
					level = 30
				end if
			end if
		end if
	end if
end sub

'------------------------------------------------------------------------
sub Update (byval milliseconds as integer)               '' Perform Motion Updates Here

	dim as integer iLoop = 0
	
	'' Space Bar Being Pressed After Game Has Ended?
	if MULTIKEY(FB.SC_SPACE)  and  game = TRUE then
		'' Loop Through 30 Objects		
		while iLoop<30
			'' Initialize Each Object
			InitObject (iLoop)
			iLoop+=1
		wend

		game = FALSE                                     '' Set game (Game Over) To False
		score = 0                                        '' Set score To 0
		level = 1                                        '' Set level Back To 1
		kills = 0                                        '' Zero Player Kills
		miss = 0                                         '' Set miss (Missed Shots) To 0
	end if

	roll -= milliseconds *0.00005f                       '' Roll The Clouds

	'' Loop Through The Objects
	while iLoop<level
		with object_(iLoop)
			'' If Rotation Is Clockwise
			if .rot = 1 then                   '' Spin Clockwise
				.spin -= 0.2f *( (iLoop + milliseconds))
			end if
			'' If Rotation Is Counter Clockwise
			if .rot = 2 then                   '' Spin Counter Clockwise
				.spin += 0.2f *((iLoop + milliseconds))
			end if
			'' If Direction Is Right
			if .ddir = 1 then                  '' Move Right
				.x += 0.012f * (milliseconds)
			end if
			'' If Direction Is Left
			if .ddir = 0 then                  '' Move Left
				.x -= 0.012f * (milliseconds)
			end if
			'' If Direction Is Up
			if .ddir = 2 then                  '' Move Up
				.y += 0.012f * (milliseconds)
			end if
			'' If Direction Is Down
			if .ddir = 3 then                  '' Move Down
				.y -= 0.0025f * (milliseconds)
			end if
			'' If We Are Too Far Left, Direction Is Left And The Object Was Not Hit
			if (.x < (.distance - 15.0f) / 2.0f)  and  (.ddir = 0)  and (.hit = FALSE) then
				miss += 1                                   '' Increase miss (Missed Object)
				.hit = TRUE                                 '' Set hit To True To Manually Blow Up The Object
			end if
			'' If We Are Too Far Right, Direction Is right And The Object Was Not Hit
			if (.x > -(.distance - 15.0f) / 2.0f)  and  (.ddir = 1)  and (.hit = FALSE) then
				miss += 1                                   '' Increase miss (Missed Object)
				.hit = TRUE                    '' Set hit To True To Manually Blow Up The Object
			end if
			'' If We Are Too Far Down, Direction Is Down And The Object Was Not Hit
			if (.y < - 2.0f)  and  (.ddir = 3)  and (.hit = FALSE) then
				miss += 1                                   '' Increase miss (Missed Object)
				.hit = TRUE                    '' Set hit To True To Manually Blow Up The Object
			end if
			'' If We Are Too Far Up And The Direction Is Up
			if (.y > 4.5f)  and  (.ddir = 2) then    '' Change The Direction To Down
				.ddir = 3
			end if
		end with
		iLoop+=1
	wend
end sub

'------------------------------------------------------------------------
sub drawobject (byval wwidth as single, byval height as single, byval texid as uinteger)    '' Draw Object Using Requested Width, Height And Texture
	glBindTexture (GL_TEXTURE_2D, textures(texid).texID) '' Select The Correct Texture
	glBegin (GL_QUADS)                                   '' Start Drawing A Quad
		glTexCoord2f (0.0f, 0.0f) : glVertex3f (- wwidth, - height, 0.0f)      '' Bottom Left
		glTexCoord2f (1.0f, 0.0f) : glVertex3f (wwidth, - height, 0.0f)        '' Bottom Right
		glTexCoord2f (1.0f, 1.0f) : glVertex3f (wwidth, height, 0.0f)          '' Top Right
		glTexCoord2f (0.0f, 1.0f) : glVertex3f (- wwidth, height, 0.0f)        '' Top Left
	glEnd ()                                             '' Done Drawing Quad
end sub

'------------------------------------------------------------------------
sub Explosion (byval num as integer)                     '' Draws An Animated Explosion For Object "num"
	dim ex as single                                     '' Calculate Explosion X Frame (0.0f - 0.75f)
	ex =  ((object_(num).frame \ 4) mod 4) / 4.0f
	dim ey as single                                     '' Calculate Explosion Y Frame (0.0f - 0.75f)
	ey =  ((object_(num).frame \ 4) \ 4) / 4.0f

	glBindTexture (GL_TEXTURE_2D, textures(5).texID)     '' Select The Explosion Texture
	glBegin (GL_QUADS)                                   '' Begin Drawing A Quad
		glTexCoord2f (ex, 1.0f - (ey))                 : glVertex3f (- 1.0f, - 1.0f, 0.0f) '' Bottom Left
		glTexCoord2f (ex + 0.25f, 1.0f - (ey))         : glVertex3f (1.0f, - 1.0f, 0.0f)   '' Bottom Right
		glTexCoord2f (ex + 0.25f, 1.0f - (ey + 0.25f)) : glVertex3f (1.0f, 1.0f, 0.0f)     '' Top Right
		glTexCoord2f (ex, 1.0f - (ey + 0.25f))         : glVertex3f (- 1.0f, 1.0f, 0.0f)   '' Top Left
	glEnd ()                                             '' Done Drawing Quad

	object_(num).frame += 1                              '' Increase Current Explosion Frame
	'' Have We Gone Through All 16 Frames?
	if object_(num).frame > 63 then
		InitObject (num)                                '' Init The Object (Assign New Values)
	end if
end sub

'------------------------------------------------------------------------
sub DrawTargets ()                                       '' Draws The Targets (Needs To Be Seperate)
	glLoadIdentity ()                                    '' Reset The Modelview Matrix
	glTranslatef (0.0f, 0.0f, - 10.0f)                   '' Move Into The Screen 20 Units
	'' Loop Through 9 Objects
	dim  as integer iLoop = 0
	while iLoop<level
		glLoadName (iLoop)                               '' Assign Object A Name (ID)
		glPushMatrix ()                                  '' Push The Modelview Matrix
			with object_(iLoop)
				glTranslatef (.x, .y, .distance)   '' Position The Object (x,y)
				'' If Object Has Been Hit
				if .hit = TRUE then
					Explosion (iLoop)                        '' Draw An Explosion
					'' Otherwise
				else
					glRotatef (.spin, 0.0f, 0.0f, 1.0f)    '' Rotate The Object
					drawobject (size(.texid).w, size(.texid).h, .texid)  '' Draw The Object
				end if
			end with
		glPopMatrix ()                                   '' Pop The Modelview Matrix
		iLoop+=1
	wend
end sub

'------------------------------------------------------------------------
sub drawscr ()                                           '' Draw Our Scene
	glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) '' Clear Screen And Depth Buffer
	glLoadIdentity ()                                    '' Reset The Modelview Matrix

	glPushMatrix ()                                      '' Push The Modelview Matrix
		glBindTexture (GL_TEXTURE_2D, textures(7).texID) '' Select The Sky Texture
		glBegin (GL_QUADS)                               '' Begin Drawing Quads
			glTexCoord2f (1.0f, roll / 1.5f + 1.0f) : glVertex3f (28.0f, + 7.0f, - 50.0f)   '' Top Right
			glTexCoord2f (0.0f, roll / 1.5f + 1.0f) : glVertex3f (- 28.0f, + 7.0f, - 50.0f) '' Top Left
			glTexCoord2f (0.0f, roll / 1.5f + 0.0f) : glVertex3f (- 28.0f, - 3.0f, - 50.0f) '' Bottom Left
			glTexCoord2f (1.0f, roll / 1.5f + 0.0f) : glVertex3f (28.0f, - 3.0f, - 50.0f)   '' Bottom Right

			glTexCoord2f (1.5f, roll + 1.0f) : glVertex3f (28.0f, + 7.0f, - 50.0f)          '' Top Right
			glTexCoord2f (0.5f, roll + 1.0f) : glVertex3f (- 28.0f, + 7.0f, - 50.0f)        '' Top Left
			glTexCoord2f (0.5f, roll + 0.0f) : glVertex3f (- 28.0f, - 3.0f, - 50.0f)        '' Bottom Left
			glTexCoord2f (1.5f, roll + 0.0f) : glVertex3f (28.0f, - 3.0f, - 50.0f)          '' Bottom Right

			glTexCoord2f (1.0f, roll / 1.5f + 1.0f) : glVertex3f (28.0f, + 7.0f, 0.0f)      '' Top Right
			glTexCoord2f (0.0f, roll / 1.5f + 1.0f) : glVertex3f (- 28.0f, + 7.0f, 0.0f)    '' Top Left
			glTexCoord2f (0.0f, roll / 1.5f + 0.0f) : glVertex3f (- 28.0f, + 7.0f, - 50.0f) '' Bottom Left
			glTexCoord2f (1.0f, roll / 1.5f + 0.0f) : glVertex3f (28.0f, + 7.0f, - 50.0f)   '' Bottom Right

			glTexCoord2f (1.5f, roll + 1.0f) : glVertex3f (28.0f, + 7.0f, 0.0f)             '' Top Right
			glTexCoord2f (0.5f, roll + 1.0f) : glVertex3f (- 28.0f, + 7.0f, 0.0f)           '' Top Left
			glTexCoord2f (0.5f, roll + 0.0f) : glVertex3f (- 28.0f, + 7.0f, - 50.0f)        '' Bottom Left
			glTexCoord2f (1.5f, roll + 0.0f) : glVertex3f (28.0f, + 7.0f, - 50.0f)          '' Bottom Right
		glEnd ()                                          '' Done Drawing Quads

		glBindTexture (GL_TEXTURE_2D, textures(6).texID) '' Select The Ground Texture
		glBegin (GL_QUADS)                                '' Draw A Quad
			glTexCoord2f (7.0f, 4.0f - roll) : glVertex3f (27.0f, - 3.0f, - 50.0f)          '' Top Right
			glTexCoord2f (0.0f, 4.0f - roll) : glVertex3f (- 27.0f, - 3.0f, - 50.0f)        '' Top Left
			glTexCoord2f (0.0f, 0.0f - roll) : glVertex3f (- 27.0f, - 3.0f, 0.0f)           '' Bottom Left
			glTexCoord2f (7.0f, 0.0f - roll) : glVertex3f (27.0f, - 3.0f, 0.0f)             '' Bottom Right
		glEnd ()                                          '' Done Drawing Quad

		DrawTargets ()                                    '' Draw Our Targets
	glPopMatrix ()                                        '' Pop The Modelview Matrix

	'' Crosshair (In Ortho View)
	dim as integer scrw, scrh                             '' Storage For window Dimensions
	dim as integer oldm_x, oldm_y
	if mouse_x <> -1 then oldm_x = mouse_x : oldm_y = mouse_y

	screeninfo scrw, scrh                                 '' Get Window Dimensions
	glMatrixMode (GL_PROJECTION)                          '' Select The Projection Matrix
	glPushMatrix ()                                       '' Store The Projection Matrix
		glLoadIdentity ()                                 '' Reset The Projection Matrix
		glOrtho (0, scrw, 0, scrh, - 1, 1)                '' Set Up An Ortho Screen
		glMatrixMode (GL_MODELVIEW)                       '' Select The Modelview Matrix
		glTranslated (oldm_x, scrh - oldm_y, 0.0f)        '' Move To The Current Mouse Position
		drawobject (16, 16, 8)                            '' Draw The Crosshair

		'' Game Stats / Title
		glPrint (240, 450, "NeHe Productions")            '' Print Title
		glPrint (10, 10, "Level: %i", level)              '' Print Level
		glPrint (250, 10, "Score: %i", score)             '' Print Score

		'' Have We Missed 10 Objects?
		if miss > 9 then
			miss = 9                                      '' Limit Misses To 10
			game = TRUE                                   '' Game Over TRUE
		end if
		'' Is Game Over?
		if game = TRUE then                               '' Game Over Message
			glPrint (490, 10, "GAME OVER")
		else                                              '' Print Morale #/10
			glPrint (490, 10, "Morale: %i/10", 10 - miss)
		end if
		glMatrixMode (GL_PROJECTION)                      '' Select The Projection Matrix
	glPopMatrix ()                                        '' Restore The Old Projection Matrix
	glMatrixMode (GL_MODELVIEW)                           '' Select The Modelview Matrix

	glFlush ()                                            '' Flush The GL Rendering Pipeline
end sub
