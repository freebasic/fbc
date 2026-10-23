''  gl_core_cube.bas - an indexed, depth-tested cube in OpenGL 3.3 core
''
''  Shows the three things a core-profile 3D program needs beyond the
''  triangle example: an element buffer (glDrawElements), a vertex shader
''  fed by a model-view-projection matrix, and a depth buffer.
''
''  Build:   fbc gl_core_cube.bas
''  Needs:   GLFW 3 and a GPU that can provide a 3.3 core context.
''           Runs on Linux and Windows.  Compile-only on macOS: Apple's OpenGL
''           is a framework and this binding links libGL, which cannot drive
''           a CGL context.  Press ESC or close the window to exit.
''
''  See gl_core.bi for the entry-point loading and the matrix helpers.

#include once "gl_core.bi"

const VERTEX_COUNT  = 8
const VERTEX_FLOATS = 6                 '' x, y, z, r, g, b
const VERTEX_BYTES  = VERTEX_COUNT * VERTEX_FLOATS * sizeof( single )
const INDEX_COUNT   = 36
const INDEX_BYTES   = INDEX_COUNT * sizeof( ushort )

dim shared as single cube( 0 to VERTEX_COUNT * VERTEX_FLOATS - 1 ) = _
	{ _
		-1.0, -1.0, -1.0,   1.0, 0.2, 0.2, _
		 1.0, -1.0, -1.0,   0.2, 1.0, 0.3, _
		 1.0,  1.0, -1.0,   0.3, 0.4, 1.0, _
		-1.0,  1.0, -1.0,   1.0, 0.9, 0.2, _
		-1.0, -1.0,  1.0,   1.0, 0.3, 1.0, _
		 1.0, -1.0,  1.0,   0.2, 1.0, 1.0, _
		 1.0,  1.0,  1.0,   1.0, 1.0, 1.0, _
		-1.0,  1.0,  1.0,   0.6, 0.6, 0.6  _
	}

'' Two triangles per face, counter-clockwise seen from outside.
dim shared as ushort cube_indices( 0 to INDEX_COUNT - 1 ) = _
	{ _
		 4, 5, 6,  4, 6, 7, _   '' +Z
		 1, 2, 6,  1, 6, 5, _   '' +X
		 0, 3, 2,  0, 2, 1, _   '' -Z
		 0, 4, 7,  0, 7, 3, _   '' -X
		 3, 7, 6,  3, 6, 2, _   '' +Y
		 0, 1, 5,  0, 5, 4  _   '' -Y
	}

dim as string vertex_shader = _
	!"#version 330 core\n" & _
	!"layout(location = 0) in vec3 aPos;\n" & _
	!"layout(location = 1) in vec3 aColor;\n" & _
	!"uniform mat4 uMVP;\n" & _
	!"out vec3 vColor;\n" & _
	!"void main()\n" & _
	!"{\n" & _
	!"    vColor = aColor;\n" & _
	!"    gl_Position = uMVP * vec4(aPos, 1.0);\n" & _
	!"}\n"

dim as string fragment_shader = _
	!"#version 330 core\n" & _
	!"in vec3 vColor;\n" & _
	!"out vec4 FragColor;\n" & _
	!"void main()\n" & _
	!"{\n" & _
	!"    FragColor = vec4(vColor, 1.0);\n" & _
	!"}\n"

'' ---------------------------------------------------------------------------

if( glfwInit( ) = 0 ) then
	print "gl_core_cube: glfwInit() failed"
	end 1
end if

glfwWindowHint( GLFW_CONTEXT_VERSION_MAJOR, 3 )
glfwWindowHint( GLFW_CONTEXT_VERSION_MINOR, 3 )
glfwWindowHint( GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE )
#ifdef __FB_DARWIN__
	glfwWindowHint( GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE )
#endif

dim as GLFWwindow ptr win = glfwCreateWindow( 800, 600, "FreeBASIC - GL 3.3 core cube", 0, 0 )
if( win = 0 ) then
	print "gl_core_cube: could not create a 3.3 core context"
	glfwTerminate( )
	end 1
end if

glfwMakeContextCurrent( win )
glcInit( )
glViewport( 0, 0, 800, 600 )

dim as GLuint program = glcProgram( strptr( vertex_shader ), strptr( fragment_shader ) )
dim as GLint  umvp    = glcGetUniformLocation( program, "uMVP" )

dim as GLuint vao = 0, vbo = 0, ibo = 0
glcGenVertexArrays( 1, @vao )
glcBindVertexArray( vao )

glcGenBuffers( 1, @vbo )
glcBindBuffer( GL_ARRAY_BUFFER, vbo )
glcBufferData( GL_ARRAY_BUFFER, cast( GLsizeiptr, VERTEX_BYTES ), @cube( 0 ), GL_STATIC_DRAW )

glcGenBuffers( 1, @ibo )
glcBindBuffer( GL_ELEMENT_ARRAY_BUFFER, ibo )
glcBufferData( GL_ELEMENT_ARRAY_BUFFER, cast( GLsizeiptr, INDEX_BYTES ), @cube_indices( 0 ), GL_STATIC_DRAW )

const VERTEX_STRIDE = VERTEX_FLOATS * sizeof( single )
glcEnableVertexAttribArray( 0 )
glcVertexAttribPointer( 0, 3, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, 0 )
glcEnableVertexAttribArray( 1 )
glcVertexAttribPointer( 1, 3, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, cast( any ptr, 3 * sizeof( single ) ) )

glEnable( GL_DEPTH_TEST )

'' Fixed camera, rotating model: P * T * RY * RX
dim as GLC_MAT4 projection = glcPerspective( 45.0 * 3.14159265 / 180.0, 800.0 / 600.0, 0.1, 100.0 )
dim as GLC_MAT4 cam        = glcTranslate( 0.0, 0.0, -6.0 )

dim as double started = timer

do while( glfwWindowShouldClose( win ) = 0 )
	if( glfwGetKey( win, GLFW_KEY_ESCAPE ) = GLFW_PRESS ) then
		glfwSetWindowShouldClose( win, 1 )
	end if
	glfwPollEvents( )

	dim as single t = csng( timer - started )
	dim as GLC_MAT4 model = glcMul( glcRotateY( t ), glcRotateX( t * 0.6 ) )
	dim as GLC_MAT4 mvp   = glcMul( glcMul( projection, cam ), model )

	glClearColor( 0.07, 0.07, 0.09, 1.0 )
	glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT )

	glcUseProgram( program )
	glcUniformMatrix4fv( umvp, 1, GL_FALSE, @mvp.m( 0 ) )
	glcBindVertexArray( vao )
	glDrawElements( GL_TRIANGLES, INDEX_COUNT, GL_UNSIGNED_SHORT, 0 )

	glfwSwapBuffers( win )
loop

glcDeleteBuffers( 1, @ibo )
glcDeleteBuffers( 1, @vbo )
glcDeleteVertexArrays( 1, @vao )
glcDeleteProgram( program )
glfwDestroyWindow( win )
glfwTerminate( )
