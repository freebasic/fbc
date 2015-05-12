''------------------------------------------------------------------------------
''               Based On Lesson 6
''               =================
''
'' All Code Is The Same, Except For Where I Have ( NEW )
'' ( CHANGE ) Means I Have Changed The Line For This Tutorial.
''------------------------------------------------------------------------------

'' Setup our booleans
const false = 0
const true  = not false
const null = 0


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                       '' for Scan code constants

#include once "tgaloader.bi"

declare function LoadGLTextures () as integer

dim shared spin as single                      '' Spin Variable
dim shared texture(2) as structTexture         '' Storage For 2 Textures ( NEW )

	dim as integer iLoop = 0
	windowtitle "NeHe & Evan 'terminate' Pipho's TGA Loading Tutorial"      '' Set window title
	screen 18, 32, , 2

	'' Initialize The GL Window
	glViewport 0, 0, 640, 480                  '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                 '' Select The Projection Matrix
	glLoadIdentity                             '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 1.0, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                  '' Select The Modelview Matrix
	glLoadIdentity                             '' Reset The Projection Matrix

	'' All Setup For OpenGL Goes Here
	''  Jump To Texture Loading Routine ( NEW )
	if  not  LoadGLTextures () then
		end                                    '' If Texture Didn't Load quit
	end if

	glEnable (GL_TEXTURE_2D)                   '' Enable Texture Mapping ( NEW )
	glShadeModel (GL_SMOOTH)                   '' Enable Smooth Shading
	glClearColor (0.0f, 0.0f, 0.0f, 0.5f)      '' Black Background
	glClearDepth (1.0f)                        '' Depth Buffer Setup
	glEnable (GL_DEPTH_TEST)                   '' Enables Depth Testing
	glDepthFunc (GL_LEQUAL)                    '' The Type Of Depth Testing To Do
	glHint (GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)      '' Really Nice Perspective Calculations

	do
		'' Here's Where We Do All The Drawing
		glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)    '' Clear The Screen And The Depth Buffer
		glLoadIdentity ()                                       '' Reset The Modelview Matrix
		glTranslatef (0.0f, 0.0f, - 10.0f)                      '' Translate 20 Units Into The Screen

		spin += 0.05f                                           '' Increase Spin

		''  Loop Of 20
		for iLoop = 0 to 19
			glPushMatrix ()                                      '' Push The Matrix
				glRotatef (spin + iLoop*18.0f, 1.0f, 0.0f, 0.0f) '' Rotate On The X-Axis (Up - Down)
				glTranslatef (- 2.0f, 2.0f, 0.0f)                '' Translate 2 Units Left And 2 Up

				glBindTexture (GL_TEXTURE_2D, texture(0).texID)  '' ( CHANGE )
				glBegin (GL_QUADS)                               '' Draw Our Quad
					glTexCoord2f (0.0f, 1.0f) : glVertex3f (- 1.0f, 1.0f, 0.0f)
					glTexCoord2f (1.0f, 1.0f) : glVertex3f (1.0f, 1.0f, 0.0f)
					glTexCoord2f (1.0f, 0.0f) : glVertex3f (1.0f, - 1.0f, 0.0f)
					glTexCoord2f (0.0f, 0.0f) : glVertex3f (- 1.0f, - 1.0f, 0.0f)
				glEnd ()                                         '' Done Drawing The Quad
			glPopMatrix ()                                       '' Pop The Matrix
			glPushMatrix ()                                      '' Push The Matrix
				glTranslatef (2.0f, 0.0f, 0.0f)                  '' Translate 2 Units To The Right
				glRotatef (spin + iLoop*36.0f, 0.0f, 1.0f, 0.0f) '' Rotate On The Y-Axis (Left - Right)
				glTranslatef (1.0f, 0.0f, 0.0f)                  '' Move One Unit Right

				glBindTexture (GL_TEXTURE_2D, texture(1).texID)  '' ( CHANGE )
				glBegin (GL_QUADS)                               '' Draw Our Quad
					glTexCoord2f (0.0f, 0.0f) : glVertex3f (- 1.0f, 1.0f, 0.0f)
					glTexCoord2f (1.0f, 0.0f) : glVertex3f (1.0f, 1.0f, 0.0f)
					glTexCoord2f (1.0f, 1.0f) : glVertex3f (1.0f, - 1.0f, 0.0f)
					glTexCoord2f (0.0f, 1.0f) : glVertex3f (- 1.0f, - 1.0f, 0.0f)
				glEnd ()                                         '' Done Drawing The Quad
			glPopMatrix ()                                       '' Pop The Matrix
		next
        flip
		if inkey = chr(255)+"k" then exit do    '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while inkey <> "": wend

	end

'------------------------------------------------------------------------
function LoadGLTextures () as integer                    '' Load Bitmaps And Convert To Textures
	dim as integer Status = FALSE                        '' Status Indicator
	dim as integer iLoop = 0

	''  Load The Bitmap, Check For Errors.
	if LoadTGA (@texture(0), exepath + "/data/Uncompressed.tga") and _
	LoadTGA (@texture(1), exepath + "/data/Compressed.tga") then
		Status = TRUE                                    '' Set The Status To TRUE

		''  Loop Through Both Textures
		for iLoop = 0 to 1
			''  Typical Texture Generation Using Data From The TGA ( CHANGE )
			glGenTextures (1, @texture(iLoop).texID)     '' Create The Texture ( CHANGE )
			glBindTexture (GL_TEXTURE_2D, texture(iLoop).texID)
			glTexImage2D (GL_TEXTURE_2D, 0, texture(iLoop).bpp \ 8, texture(iLoop).texwidth, texture(iLoop).height, 0, texture(iLoop).textype, GL_UNSIGNED_BYTE, texture(iLoop).imageData)
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)

			''  If Texture Image Exists ( CHANGE )
			if texture(iLoop).imageData then
				deallocate (texture(iLoop).imageData)    '' Free The Texture Image Memory ( CHANGE )
			end if
		next
	end if
	return Status                                        '' Return The Status
end function
