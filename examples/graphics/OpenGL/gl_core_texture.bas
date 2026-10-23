''  gl_core_texture.bas - a textured, spinning quad in OpenGL 3.3 core
''
''  Shows a sampler, UV coordinates and texture upload.  The texture is a
''  checkerboard generated in memory, so the example needs no image file.
''
''  Build:   fbc gl_core_texture.bas
''  Needs:   GLFW 3 and a GPU that can provide a 3.3 core context.
''           Runs on Linux and Windows.  Compile-only on macOS: Apple's OpenGL
''           is a framework and this binding links libGL, which cannot drive
''           a CGL context.  Press ESC or close the window to exit.
''
''  See gl_core.bi for the entry-point loading and the matrix helpers.

#include once "gl_core.bi"

const VERTEX_COUNT  = 4
const VERTEX_FLOATS = 4                 '' x, y, u, v
const VERTEX_BYTES  = VERTEX_COUNT * VERTEX_FLOATS * sizeof( single )

const TEX_SIZE  = 64
const TEX_CELL  = 8
const TEX_BYTES = TEX_SIZE * TEX_SIZE * 4

dim shared as single quad( 0 to VERTEX_COUNT * VERTEX_FLOATS - 1 ) = _
	{ _
		-1.0, -1.0,   0.0, 0.0, _
		 1.0, -1.0,   1.0, 0.0, _
		-1.0,  1.0,   0.0, 1.0, _
		 1.0,  1.0,   1.0, 1.0  _
	}

dim as string vertex_shader = _
	!"#version 330 core\n" & _
	!"layout(location = 0) in vec2 aPos;\n" & _
	!"layout(location = 1) in vec2 aUV;\n" & _
	!"uniform mat4 uMVP;\n" & _
	!"out vec2 vUV;\n" & _
	!"void main()\n" & _
	!"{\n" & _
	!"    vUV = aUV;\n" & _
	!"    gl_Position = uMVP * vec4(aPos, 0.0, 1.0);\n" & _
	!"}\n"

dim as string fragment_shader = _
	!"#version 330 core\n" & _
	!"in vec2 vUV;\n" & _
	!"uniform sampler2D uTex;\n" & _
	!"out vec4 FragColor;\n" & _
	!"void main()\n" & _
	!"{\n" & _
	!"    FragColor = texture(uTex, vUV);\n" & _
	!"}\n"

'' ---------------------------------------------------------------------------

if( glfwInit( ) = 0 ) then
	print "gl_core_texture: glfwInit() failed"
	end 1
end if

glfwWindowHint( GLFW_CONTEXT_VERSION_MAJOR, 3 )
glfwWindowHint( GLFW_CONTEXT_VERSION_MINOR, 3 )
glfwWindowHint( GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE )
#ifdef __FB_DARWIN__
	glfwWindowHint( GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE )
#endif

dim as GLFWwindow ptr win = glfwCreateWindow( 800, 600, "FreeBASIC - GL 3.3 core texture", 0, 0 )
if( win = 0 ) then
	print "gl_core_texture: could not create a 3.3 core context"
	glfwTerminate( )
	end 1
end if

glfwMakeContextCurrent( win )
glcInit( )
glViewport( 0, 0, 800, 600 )

'' Checkerboard, RGBA, generated in memory
dim as ubyte texels( 0 to TEX_BYTES - 1 )
for y as integer = 0 to TEX_SIZE - 1
	for x as integer = 0 to TEX_SIZE - 1
		dim as integer cell = ( ( x \ TEX_CELL ) + ( y \ TEX_CELL ) ) and 1
		dim as integer i = ( y * TEX_SIZE + x ) * 4
		if( cell = 0 ) then
			texels( i + 0 ) = 230 : texels( i + 1 ) = 120 : texels( i + 2 ) = 40
		else
			texels( i + 0 ) = 35  : texels( i + 1 ) = 45  : texels( i + 2 ) = 80
		end if
		texels( i + 3 ) = 255
	next
next

dim as GLuint tex = 0
glGenTextures( 1, @tex )
glBindTexture( GL_TEXTURE_2D, tex )
glPixelStorei( GL_UNPACK_ALIGNMENT, 1 )
glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA8, TEX_SIZE, TEX_SIZE, 0, GL_RGBA, GL_UNSIGNED_BYTE, @texels( 0 ) )
glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR )
glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )
glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT )
glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT )
glcGenerateMipmap( GL_TEXTURE_2D )
glBindTexture( GL_TEXTURE_2D, 0 )

dim as GLuint program = glcProgram( strptr( vertex_shader ), strptr( fragment_shader ) )
dim as GLint  umvp    = glcGetUniformLocation( program, "uMVP" )
dim as GLint  utex    = glcGetUniformLocation( program, "uTex" )

dim as GLuint vao = 0, vbo = 0
glcGenVertexArrays( 1, @vao )
glcBindVertexArray( vao )
glcGenBuffers( 1, @vbo )
glcBindBuffer( GL_ARRAY_BUFFER, vbo )
glcBufferData( GL_ARRAY_BUFFER, cast( GLsizeiptr, VERTEX_BYTES ), @quad( 0 ), GL_STATIC_DRAW )

const VERTEX_STRIDE = VERTEX_FLOATS * sizeof( single )
glcEnableVertexAttribArray( 0 )
glcVertexAttribPointer( 0, 2, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, 0 )
glcEnableVertexAttribArray( 1 )
glcVertexAttribPointer( 1, 2, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, cast( any ptr, 2 * sizeof( single ) ) )

dim as GLC_MAT4 projection = glcPerspective( 45.0 * 3.14159265 / 180.0, 800.0 / 600.0, 0.1, 100.0 )
dim as GLC_MAT4 cam        = glcTranslate( 0.0, 0.0, -3.0 )

dim as double started = timer

do while( glfwWindowShouldClose( win ) = 0 )
	if( glfwGetKey( win, GLFW_KEY_ESCAPE ) = GLFW_PRESS ) then
		glfwSetWindowShouldClose( win, 1 )
	end if
	glfwPollEvents( )

	dim as single t = csng( timer - started )
	dim as GLC_MAT4 model = glcMul( glcRotateZ( t * 0.5 ), glcRotateX( t * 0.27 ) )
	dim as GLC_MAT4 mvp   = glcMul( glcMul( projection, cam ), model )

	glClearColor( 0.07, 0.07, 0.09, 1.0 )
	glClear( GL_COLOR_BUFFER_BIT )

	glcUseProgram( program )
	glcUniformMatrix4fv( umvp, 1, GL_FALSE, @mvp.m( 0 ) )
	glcActiveTexture( GL_TEXTURE0 )
	glBindTexture( GL_TEXTURE_2D, tex )
	glcUniform1i( utex, 0 )
	glcBindVertexArray( vao )
	glDrawArrays( GL_TRIANGLE_STRIP, 0, VERTEX_COUNT )

	glfwSwapBuffers( win )
loop

glDeleteTextures( 1, @tex )
glcDeleteBuffers( 1, @vbo )
glcDeleteVertexArrays( 1, @vao )
glcDeleteProgram( program )
glfwDestroyWindow( win )
glfwTerminate( )
