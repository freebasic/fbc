''
'' This Code Was Created By Jeff Molofee 2000
'' A HUGE Thanks To Fredric Echols For Cleaning Up
'' And Optimizing The Base Code, Making It More Flexible!
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Use ESC key to quit
'' UpArrow, DnArrow, RightArrow, Left Arrow to move around grid
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson21.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "crt.bi"
#include once "createtex.bi"

type OBJECT_           '' Create A Structure For Our Player
	fx as integer
	fy as integer     '' Fine Movement Position
	x as integer
	y as integer      '' Current Player Position
	spin as single    '' Spin Direction
end type

declare sub BuildFont()
declare sub glPrint cdecl (byval x as integer, byval y as integer, byval gset as integer, byref fmt as string, ...)
declare sub ResetObjects()

dim shared player as OBJECT_
dim shared loop1 as integer                                 '' Generic Loop1
dim shared stage as integer = 1                             '' Game Stage
dim shared level as integer = 1                             '' Internal Game Level
dim shared enemy(8) as OBJECT_
dim shared gbase as uinteger                                '' Base Display List For The Font
dim shared texture(1) as uinteger                           '' Font Texture Storage Space

	dim vline(0 to 10, 0 to 9) as integer                   '' Keeps Track Of Vertical Lines
	dim hline(0 to 9, 0 to 10) as integer                   '' Keeps Track Of Horizontal Lines
	dim ap as integer                                       '' 'A'' Key Pressed?
	dim filled as integer                                   '' Done Filling In The Grid?
	dim gameover as integer                                 '' Is The Game Over?
	dim anti as integer = TRUE                              '' Antialiasing?
	dim start as single                                     '' start of timing loop

	dim loop2 as integer                                    '' Generic Loop2
	dim gdelay as integer                                   '' Enemy Delay
	dim adjust as integer = 3                               '' Speed Adjustment For Really Slow Video Cards
	dim lives as integer = 5                                '' Player Lives

	dim level2 as integer = 1                               '' Displayed Game Level

	dim hourglass as OBJECT_

	dim steps(0 to 5) as integer => {1, 2, 4, 5, 10, 20}    '' Stepping Values For Slow Video Adjustment

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION               '' Select The Projection Matrix
	glLoadIdentity                           '' Reset The Projection Matrix
	glOrtho 0.0, 640, 480, 0.0, -1.0, 1.0    '' Create Ortho 640x480 View (0,0 At Top Left)
	glMatrixMode GL_MODELVIEW                '' Select The Modelview Matrix
	glLoadIdentity                           '' Reset The Projection Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte       '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Font.bmp", @buffer(0)        '' BLOAD the bitmap
	texture(0) = CreateTexture(@buffer(0))   '' Linear Texture
	bload exepath + "/data/colpatt.bmp", @buffer(0)       '' BLOAD the bitmap
	texture(1) = CreateTexture(@buffer(0))   '' Linear Texture
	'' Exit if error loading textures
	if texture(0) = 0 or texture(1) = 0 then end 1

	'' All Setup For OpenGL Goes Here
	BuildFont()                                             '' Build The Font

	glShadeModel GL_SMOOTH                                  '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                         '' Black Background
	glClearDepth 1.0                                        '' Depth Buffer Setup
	glHint GL_LINE_SMOOTH_HINT, GL_NICEST                   '' Set Line Antialiasing
	glEnable GL_BLEND                                       '' Enable Blending
	glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA        '' Type Of Blending To Use
	randomize timer
	ResetObjects()

	do
		start = timer                                         '' FreeBASIC uses a high performance timer if present
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT    '' Clear Screen And Depth Buffer
		glBindTexture GL_TEXTURE_2D, texture(0)               '' Select Our Font Texture
		glColor3f 1.0, 0.5, 1.0                               '' Set Color To Purple
		glPrint 207, 24, 0, "GRID CRAZY"                      '' Write GRID CRAZY On The Screen
		glColor3f 1.0, 1.0, 0.0                               '' Set Color To Yellow
		glPrint 20, 20, 1, "Level:%2i", level2                '' Write Actual Level Stats
		glPrint 20, 40, 1, "Stage:%2i", stage                 '' Write Stage Stats

		if gameover then                                      '' Is The Game Over?
			glColor3ub int(rnd*255), int(rnd*255), int(rnd*255)    '' Pick A Random Color
			glPrint 472, 20, 1, "GAME OVER"                   '' Write GAME OVER To The Screen
			glPrint 456, 40, 1, "PRESS SPACE"                 '' Write PRESS SPACE To The Screen
		end if

		for loop1=0 to lives-2                                '' Loop Through Lives Minus Current Life
			glLoadIdentity                                    '' Reset The View
			glTranslatef 490+(loop1*40.0), 40.0, 0.0          '' Move To The Right Of Our Title Text
			glRotatef -player.spin, 0.0, 0.0, 1.0             '' Rotate Counter Clockwise
			glColor3f 0.0, 1.0, 0.0                           '' Set Player Color To Light Green
			glBegin GL_LINES                                  '' Start Drawing Our Player Using Lines
				glVertex2d -5,-5                              '' Top Left Of Player
				glVertex2d  5, 5                              '' Bottom Right Of Player
				glVertex2d  5,-5                              '' Top Right Of Player
				glVertex2d -5, 5                              '' Bottom Left Of Player
			glEnd                                             '' Done Drawing The Player
			glRotatef -player.spin*0.5, 0.0, 0.0, 1.0         '' Rotate Counter Clockwise
			glColor3f 0.0, 0.75, 0.0                          '' Set Player Color To Dark Green
			glBegin GL_LINES                                  '' Start Drawing Our Player Using Lines
				glVertex2d -7, 0                              '' Left Center Of Player
				glVertex2d  7, 0                              '' Right Center Of Player
				glVertex2d  0,-7                              '' Top Center Of Player
				glVertex2d  0, 7                              '' Bottom Center Of Player
			glEnd                                             '' Done Drawing The Player
		next

		filled = TRUE                                         '' Set Filled To True Before Testing
		glLineWidth 2.0                                       '' Set Line Width For Cells To 2.0
		glDisable GL_LINE_SMOOTH                              '' Disable Antialiasing
		glLoadIdentity                                        '' Reset The Current Modelview Matrix
		for loop1 = 0 to 10                                   '' Loop From Left To Right
			for loop2 = 0 to 10                               '' Loop From Top To Bottom
				glColor3f 0.0, 0.5, 1.0                       '' Set Line Color To Blue
				If loop1 < 10 Then
					If hline(loop1,loop2) Then                    '' Has The Horizontal Line Been Traced
						glColor3f 1.0, 1.0, 1.0                   '' If So, Set Line Color To White
					End If

					If Not hline(loop1,loop2) Then            '' If A Horizontal Line Isn''t Filled
						filled = FALSE                        '' filled Becomes False
					End If
					glBegin GL_LINES                          '' Start Drawing Horizontal Cell Borders
						glVertex2d 20+(loop1*60), 70+(loop2*40)     '' Left Side Of Horizontal Line
						glVertex2d 80+(loop1*60), 70+(loop2*40)     '' Right Side Of Horizontal Line
					glEnd                                     '' Done Drawing Horizontal Cell Borders
				End If

				glColor3f 0.0, 0.5, 1.0                       '' Set Line Color To Blue
				If loop2<10 Then
					If vline(loop1,loop2) Then                    '' Has The Horizontal Line Been Traced
						glColor3f 1.0, 1.0, 1.0                   '' If So, Set Line Color To White
					End If
                                        If Not vline(loop1,loop2) Then            '' If A Vertical Line isn''t Filled
                                                filled = FALSE                        '' filled Becomes False
                                        End If
                                        glBegin GL_LINES                          '' Start Drawing Vertical Cell Borders
                                                glVertex2d 20+(loop1*60), 70+(loop2*40)     '' Left Side Of Horizontal Line
                                                glVertex2d 20+(loop1*60), 110+(loop2*40)    '' Right Side Of Horizontal Line
                                        glEnd                                     '' Done Drawing Vertical Cell Borders
                                End If
				glEnable GL_TEXTURE_2D                        '' Enable Texture Mapping
				glColor3f 1.0, 1.0, 1.0                       '' Bright White Color
				glBindTexture GL_TEXTURE_2D, texture(1)       '' Select The Tile Image
				if loop1<10  and loop2<10 then                '' If In Bounds, Fill In Traced Boxes

					'' Are All Sides Of The Box Traced?
					if hline(loop1,loop2) and hline(loop1,loop2+1) and vline(loop1,loop2) and vline(loop1+1,loop2) then

						glBegin GL_QUADS                      '' Draw A Textured Quad
							glTexCoord2f (loop1/10.0)+0.1, 1.0-(loop2/10.0)
							glVertex2d 20+(loop1*60)+59, 70+loop2*40+1       '' Top Right
							glTexCoord2f loop1/10.0, 1.0-(loop2/10.0)
							glVertex2d 20+(loop1*60)+1, 70+loop2*40+1        '' Top Left
							glTexCoord2f loop1/10.0, 1.0-((loop2/10.0)+0.1)
							glVertex2d 20+(loop1*60)+1, (70+loop2*40)+39     '' Bottom Left
							glTexCoord2f (loop1/10.0)+0.1, 1.0-((loop2/10.0)+0.1)
							glVertex2d 20+(loop1*60)+59, (70+loop2*40)+39    '' Bottom Right
						glEnd                                 '' Done Texturing The Box
					end if
				end if
				glDisable GL_TEXTURE_2D                       '' Disable Texture Mapping
			next
		next
		glLineWidth 1.0                                       '' Set The Line Width To 1.0

		if anti then                                          '' Is Anti TRUE?
			glEnable GL_LINE_SMOOTH                           '' If So, Enable Antialiasing
		end if

		if hourglass.fx=1 then                                '' If fx=1 Draw The Hourglass
			glLoadIdentity                                    '' Reset The Modelview Matrix
			glTranslatef 20.0+(hourglass.x*60), 70.0+(hourglass.y*40), 0.0         '' Move To The Fine Hourglass Position
			glRotatef hourglass.spin, 0.0, 0.0, 1.0           '' Rotate Clockwise
			glColor3ub int(rnd*255), int(rnd*255), int(rnd*255)   '' Set Hourglass Color To Random Color
			glBegin GL_LINES                                  '' Start Drawing Our Hourglass Using Lines
				glVertex2d -5, -5                             '' Top Left Of Hourglass
				glVertex2d 5, 5                               '' Bottom Right Of Hourglass
				glVertex2d  5, -5                             '' Top Right Of Hourglass
				glVertex2d -5, 5                              '' Bottom Left Of Hourglass
				glVertex2d -5, 5                              '' Bottom Left Of Hourglass
				glVertex2d  5, 5                              '' Bottom Right Of Hourglass
				glVertex2d -5, -5                             '' Top Left Of Hourglass
				glVertex2d  5, -5                             '' Top Right Of Hourglass
			glEnd                                             '' Done Drawing The Hourglass
		end if

		glLoadIdentity                                        '' Reset The Modelview Matrix
		glTranslatef player.fx+20.0, player.fy+70.0,0.0       '' Move To The Fine Player Position
		glRotatef player.spin, 0.0, 0.0, 1.0                  '' Rotate Clockwise
		glColor3f 0.0, 1.0, 0.0                               '' Set Player Color To Light Green
		glBegin GL_LINES                                      '' Start Drawing Our Player Using Lines
			glVertex2d -5, -5                                 '' Top Left Of Player
			glVertex2d 5, 5                                   '' Bottom Right Of Player
			glVertex2d 5,-5                                   '' Top Right Of Player
			glVertex2d -5, 5                                  '' Bottom Left Of Player
		glEnd                                                 '' Done Drawing The Player
		glRotatef player.spin*0.5, 0.0, 0.0, 1.0              '' Rotate Clockwise
		glColor3f 0.0, 0.75, 0.0                              '' Set Player Color To Dark Green
		glBegin GL_LINES                                      '' Start Drawing Our Player Using Lines
			glVertex2d -7, 0                                  '' Left Center Of Player
			glVertex2d  7, 0                                  '' Right Center Of Player
			glVertex2d 0,-7                                   '' Top Center Of Player
			glVertex2d 0, 7                                   '' Bottom Center Of Player
		glEnd                                                 '' Done Drawing The Player

		for loop1 = 0 to (stage*level)-1                      '' Loop To Draw Enemies
			glLoadIdentity                                    '' Reset The Modelview Matrix
			glTranslatef enemy(loop1).fx+20.0, enemy(loop1).fy+70.0, 0.0
			glColor3f 1.0, 0.5, 0.5                           '' Make Enemy Body Pink
			glBegin GL_LINES                                  '' Start Drawing Enemy
				glVertex2d 0, -7                              '' Top Point Of Body
				glVertex2d -7, 0                              '' Left Point Of Body
				glVertex2d -7, 0                              '' Left Point Of Body
				glVertex2d 0, 7                               '' Bottom Point Of Body
				glVertex2d 0, 7                               '' Bottom Point Of Body
				glVertex2d 7, 0                               '' Right Point Of Body
				glVertex2d 7, 0                               '' Right Point Of Body
				glVertex2d 0,-7                               '' Top Point Of Body
			glEnd                                             '' Done Drawing Enemy Body
			glRotatef enemy(loop1).spin, 0.0, 0.0, 1.0        '' Rotate The Enemy Blade
			glColor3f 1.0, 0.0, 0.0                           '' Make Enemy Blade Red
			glBegin GL_LINES                                  '' Start Drawing Enemy Blade
				glVertex2d -7,-7                              '' Top Left Of Enemy
				glVertex2d 7, 7                               '' Bottom Right Of Enemy
				glVertex2d -7, 7                              '' Bottom Left Of Enemy
				glVertex2d 7, -7                              '' Top Right Of Enemy
			glEnd                                             '' Done Drawing Enemy Blade
		next

		while timer < start+(steps(adjust)*2.0/1000) : wend   '' Waste Cycles On Fast Systems

		if not gameover then                               '' If Game Is not Over Move Objects
			for loop1=0 to stage*level - 1                 '' Loop Through The Different Stages
				if ((enemy(loop1).x<player.x) and (enemy(loop1).fy=enemy(loop1).y*40)) then
					enemy(loop1).x = enemy(loop1).x + 1    '' Move The Enemy Right
				end if
				if ((enemy(loop1).x>player.x)  and  (enemy(loop1).fy=enemy(loop1).y*40)) then
					enemy(loop1).x = enemy(loop1).x - 1    '' Move The Enemy Left
				end if
				if ((enemy(loop1).y<player.y)  and  (enemy(loop1).fx=enemy(loop1).x*60)) then
					enemy(loop1).y = enemy(loop1).y + 1    '' Move The Enemy Down
				end if
				if ((enemy(loop1).y>player.y)  and  (enemy(loop1).fx=enemy(loop1).x*60)) then
					enemy(loop1).y = enemy(loop1).y - 1     '' Move The Enemy Up
				end if

				if (gdelay>(3-level) and (hourglass.fx <> 2)) then    '' If Our Delay Is Done And Player Doesn't Have Hourglass
					gdelay=0                                          '' Reset The Delay Counter Back To Zero
					for loop2=0 to stage*level -1                     '' Loop Through All The Enemies
						if (enemy(loop2).fx<enemy(loop2).x*60) then   '' Is Fine Position On X Axis Lower Than Intended Position?
							enemy(loop2).fx+=steps(adjust)            '' If So, Increase Fine Position On X Axis
							enemy(loop2).spin+=steps(adjust)          '' Spin Enemy Clockwise
						end if
						if (enemy(loop2).fx>enemy(loop2).x*60) then   '' Is Fine Position On X Axis Higher Than Intended Position?
							enemy(loop2).fx-=steps(adjust)            '' If So, Decrease Fine Position On X Axis
							enemy(loop2).spin-=steps(adjust)          '' Spin Enemy Counter Clockwise
						end if
						if (enemy(loop2).fy<enemy(loop2).y*40) then   '' Is Fine Position On Y Axis Lower Than Intended Position?
							enemy(loop2).fy+=steps(adjust)            '' If So, Increase Fine Position On Y Axis
							enemy(loop2).spin+=steps(adjust)          '' Spin Enemy Clockwise
						end if
						if (enemy(loop2).fy>enemy(loop2).y*40) then   '' Is Fine Position On Y Axis Higher Than Intended Position?
							enemy(loop2).fy-=steps(adjust)            '' If So, Decrease Fine Position On Y Axis
							enemy(loop2).spin-=steps(adjust)          '' Spin Enemy Counter Clockwise
						end if
					next
				end if

				'' Are Any Of The Enemies On Top Of The Player?
				if ((enemy(loop1).fx=player.fx)  and  (enemy(loop1).fy=player.fy)) then
					lives = lives - 1                                 '' If So, Player Loses A Life
					if (lives=0) then                                 '' Are We Out Of Lives?
						gameover=TRUE                                 '' If So, gameover Becomes TRUE
					end if
					ResetObjects()                                    '' Reset Player / Enemy Positions
				end if
			next

			if (MULTIKEY(FB.SC_RIGHT) and (player.x<10)  and  (player.fx=player.x*60)  and  (player.fy=player.y*40)) then
				hline(player.x,player.y)=TRUE                         '' Mark The Current Horizontal Border As Filled
				player.x = player.x + 1                               '' Move The Player Right
			end if
			if (MULTIKEY(FB.SC_LEFT) and  (player.x>0)  and  (player.fx=player.x*60)  and  (player.fy=player.y*40)) then
				player.x = player.x -1                                '' Move The Player Left
				hline(player.x,player.y)=TRUE                         '' Mark The Current Horizontal Border As Filled
			end if
			if (MULTIKEY(FB.SC_DOWN) and  (player.y<10)  and  (player.fx=player.x*60)  and  (player.fy=player.y*40)) then
				vline(player.x,player.y)=TRUE                         '' Mark The Current Verticle Border As Filled
				player.y = player.y +1                                '' Move The Player Down
			end if
			if (MULTIKEY(FB.SC_UP) and  (player.y>0)  and  (player.fx=player.x*60)  and  (player.fy=player.y*40)) then
				player.y = player.y -1                                '' Move The Player Up
				vline(player.x,player.y)=TRUE                         '' Mark The Current Vertical Border As Filled
			end if

			if (player.fx<player.x*60) then                           '' Is Fine Position On X Axis Lower Than Intended Position?
				player.fx+=steps(adjust)                              '' If So, Increase The Fine X Position
			end if
			if (player.fx>player.x*60) then                           '' Is Fine Position On X Axis Greater Than Intended Position?
				player.fx-=steps(adjust)                              '' If So, Decrease The Fine X Position
			end if
			if (player.fy<player.y*40) then                           '' Is Fine Position On Y Axis Lower Than Intended Position?
				player.fy+=steps(adjust)                              '' If So, Increase The Fine Y Position
			end if
			if (player.fy>player.y*40) then                           '' Is Fine Position On Y Axis Lower Than Intended Position?
				player.fy-=steps(adjust)                              '' If So, Decrease The Fine Y Position
			end if
		else                                                          '' Otherwise
			if MULTIKEY(FB.SC_SPACE) then                                '' If Spacebar Is Being Pressed
				gameover=FALSE                                        '' gameover Becomes FALSE
				filled=TRUE                                           '' filled Becomes TRUE
				level=1                                               '' Starting Level Is Set Back To One
				level2=1                                              '' Displayed Level Is Also Set To One
				stage=0                                               '' Game Stage Is Set To Zero
				lives=5                                               '' Lives Is Set To Five
			end if
		end if

		if (filled) then                                              '' Is The Grid Filled In?
			stage = stage + 1                                         '' Increase The Stage
			if (stage>3) then                                         '' Is The Stage Higher Than 3?
				stage=1                                               '' If So, Set The Stage To One
				level = level +1                                      '' Increase The Level
				level2 = level2 +1                                    '' Increase The Displayed Level
				if (level>3) then                                     '' Is The Level Greater Than 3?
					level=3                                           '' If So, Set The Level To 3
					lives = lives +1                                  '' Give The Player A Free Life
					if lives>5 then                                   '' Does The Player Have More Than 5 Lives?
						lives=5                                       '' If So, Set Lives To Five
					end if
				end if
			end if

			ResetObjects()                                           '' Reset Player / Enemy Positions

			for loop1=0 to 10                                        '' Loop Through The Grid X Coordinates
				for loop2=0 to 10                                    '' Loop Through The Grid Y Coordinates
					if (loop1<10) then                               '' If X Coordinate Is Less Than 10
						hline(loop1,loop2)=FALSE                     '' Set The Current Horizontal Value To FALSE
					end if
					if (loop2<10) then                               '' If Y Coordinate Is Less Than 10
						vline(loop1,loop2)=FALSE                     '' Set The Current Vertical Value To FALSE
					end if
				next
			next
		end if

		'' If The Player Hits The Hourglass While It''s Being Displayed On The Screen
		if ((player.fx=hourglass.x*60)  and  (player.fy=hourglass.y*40)  and  (hourglass.fx=1)) then
			'' Play Freeze Enemy Sound
			hourglass.fx=2                                '' Set The hourglass fx Variable To Two
			hourglass.fy=0                                '' Set The hourglass fy Variable To Zero
		end if

		player.spin+=0.5*steps(adjust)                    '' Spin The Player Clockwise
		if (player.spin>360.0) then                       '' Is The spin Value Greater Than 360?
			player.spin-=360                              '' If So, Subtract 360
		end if

		hourglass.spin-=0.25*steps(adjust)                '' Spin The Hourglass Counter Clockwise
		if (hourglass.spin<0.0) then                      '' Is The spin Value Less Than 0?

			hourglass.spin+=360.0                         '' If So, Add 360
		end if

		hourglass.fy+=steps(adjust)                       '' Increase The hourglass fy Variable
		if ((hourglass.fx=0)  and  (hourglass.fy>6000/level)) then  '' Is The hourglass fx Variable Equal To 0 And The fy
			'' Variable Greater Than 6000 Divided By The Current Level?
			hourglass.x = int(rnd*10)+1                   '' Give The Hourglass A Random X Value
			hourglass.y= int(rnd*11)                      '' Give The Hourglass A Random Y Value
			hourglass.fx=1                                '' Set hourglass fx Variable To One (Hourglass Stage)
			hourglass.fy=0                                '' Set hourglass fy Variable To Zero (Counter)
		end if

		if ((hourglass.fx=1)  and  (hourglass.fy>6000/level)) then  '' Is The hourglass fx Variable Equal To 1 And The fy
			'' Variable Greater Than 6000 Divided By The Current Level?
			hourglass.fx=0                                '' If So, Set fx To Zero (Hourglass Will Vanish)
			hourglass.fy=0                                '' Set fy to Zero (Counter Is Reset)
		end if

		if ((hourglass.fx=2)  and  (hourglass.fy>500+(500*level))) then   '' Is The hourglass fx Variable Equal To 2 And The fy
			'' Variable Greater Than 500 Plus 500 Times The Current Level?
			hourglass.fx=0                                '' Set hourglass fx Variable To Zero
			hourglass.fy=0                                '' Set hourglass fy Variable To Zero
		end if
		gdelay = gdelay +1                                '' Increase The Enemy Delay Counter

		'' Keyboard handlers
		if MULTIKEY(FB.SC_A) and not ap then                 '' A Key down
			ap = true
			anti = not anti                               ''  Toggle Antialiasing
		end if
		if not MULTIKEY(FB.SC_A) then ap = false             '' A key up

		flip  '' flip or crash
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend

	glDeleteLists gbase, 256                              '' Delete All 256 Display Lists
	end

'-------------------------------------------------------------------------------
sub ResetObjects()                                         '' Reset Player And Enemies

	player.x=0                                              '' Reset Player X Position To Far Left Of The Screen
	player.y=0                                              '' Reset Player Y Position To The Top Of The Screen
	player.fx=0                                             '' Set Fine X Position To Match
	player.fy=0                                             '' Set Fine Y Position To Match

	for loop1=0 to  (stage*level)-1                         '' Loop Through All The Enemies
		'' randomize timer is called in setup code
		enemy(loop1).x = 5 + int(rnd*6)                     '' Select A Random X Position
		enemy(loop1).y = int(rnd*11)                        '' Select A Random Y Position
		enemy(loop1).fx = enemy(loop1).x*60                 '' Set Fine X To Match
		enemy(loop1).fy = enemy(loop1).y*40                 '' Set Fine Y To Match
	next
end sub

'------------------------------------------------------------------------
sub BuildFont()                                  '' Build Our Font Display List

	dim cx as single                             '' Holds Our X Character Coord
	dim cy as single                             '' Holds Our Y Character Coord

	gbase = glGenLists(256)                      '' Creating 256 Display Lists
	glBindTexture GL_TEXTURE_2D, texture(0)      '' Select Our Font Texture
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
		glTranslated 15, 0, 0                    '' Move To The Right Of The Character
		glEndList                                '' Done Building The Display List
	next                                         '' Loop Until All 256 Are Built
end sub

'------------------------------------------------------------------------
'' Where The Printing Happens
sub glPrint cdecl (byval x as integer, byval y as integer, byval gset as integer, byref fmt as string, ...)
	dim text as string * 256                '' Holds Our String
	dim ap as any ptr                       '' Pointer To List Of Arguments

	if len(fmt) = 0 then                   '' If There's No Text
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

	if gset=0 then                          '' If Set 0 Is Being Used Enlarge Font
		glScalef(1.5, 2.0, 1.0)             '' Enlarge Font Width And Height
	end if

	glCallLists(strlen(text),GL_UNSIGNED_BYTE, strptr(text)) '' Write The Text To The Screen
	glDisable(GL_TEXTURE_2D)                '' Disable Texture Mapping
end sub

