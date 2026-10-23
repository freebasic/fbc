''  gl_core_triangle.bas - the smallest OpenGL 3.3 core program
''
''  One triangle, one shader pair, one vertex array object.  It exists to show
''  what a core-profile program needs that a fixed-function one does not:
''  shaders, buffer objects, verified compile/link, and the 2.0+ entry points
''  loaded at run time (see gl_core.bi).
''
''  Build:   fbc gl_core_triangle.bas
''  Needs:   GLFW 3 and a GPU that can provide a 3.3 core context.
''           Runs on Linux and Windows.  On macOS it builds but does not
''           render: Apple ships OpenGL as a framework, and this binding links
''           Mesa's libGL, which cannot drive the CGL context GLFW creates.
''           Press ESC or close the window to exit.
''
''  Compare with examples/graphics/OpenGL/NeHe/, which use the fixed-function
''  pipeline that a core context removed.

#include once "gl_core.bi"

const VERTEX_COUNT  = 3
const VERTEX_FLOATS = 5
const VERTEX_BYTES  = VERTEX_COUNT * VERTEX_FLOATS * sizeof( single )

'' Interleaved: x, y, r, g, b
dim shared as single triangle( 0 to VERTEX_COUNT * VERTEX_FLOATS - 1 ) = _
	{ _
		 0.0,  0.55,  1.0, 0.25, 0.25, _
		-0.55, -0.45, 0.25, 1.0, 0.35, _
		 0.55, -0.45, 0.30, 0.45, 1.0 _
	}

dim as string vertex_shader = _
	!"#version 330 core\n" & _
	!"layout(location = 0) in vec2 aPos;\n" & _
	!"layout(location = 1) in vec3 aColor;\n" & _
	!"out vec3 vColor;\n" & _
	!"uniform float uTime;\n" & _
	!"void main()\n" & _
	!"{\n" & _
	!"    float c = cos(uTime);\n" & _
	!"    float s = sin(uTime);\n" & _
	!"    vColor = aColor;\n" & _
	!"    gl_Position = vec4(c * aPos.x - s * aPos.y,\n" & _
	!"                       s * aPos.x + c * aPos.y,\n" & _
	!"                       0.0, 1.0);\n" & _
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
	print "gl_core_triangle: glfwInit() failed"
	end 1
end if

glfwWindowHint( GLFW_CONTEXT_VERSION_MAJOR, 3 )
glfwWindowHint( GLFW_CONTEXT_VERSION_MINOR, 3 )
glfwWindowHint( GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE )
#ifdef __FB_DARWIN__
	'' macOS only grants a core context when forward compatibility is requested
	glfwWindowHint( GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE )
#endif

dim as GLFWwindow ptr win = glfwCreateWindow( 800, 600, "FreeBASIC - GL 3.3 core triangle", 0, 0 )
if( win = 0 ) then
	print "gl_core_triangle: could not create a 3.3 core context"
	glfwTerminate( )
	end 1
end if

glfwMakeContextCurrent( win )
glcInit( )
glViewport( 0, 0, 800, 600 )

dim as GLuint program = glcProgram( strptr( vertex_shader ), strptr( fragment_shader ) )
dim as GLint  utime   = glcGetUniformLocation( program, "uTime" )

dim as GLuint vao = 0, vbo = 0
glcGenVertexArrays( 1, @vao )
glcBindVertexArray( vao )

glcGenBuffers( 1, @vbo )
glcBindBuffer( GL_ARRAY_BUFFER, vbo )
glcBufferData( GL_ARRAY_BUFFER, cast( GLsizeiptr, VERTEX_BYTES ), @triangle( 0 ), GL_STATIC_DRAW )

const VERTEX_STRIDE = 5 * sizeof( single )
glcEnableVertexAttribArray( 0 )
glcVertexAttribPointer( 0, 2, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, 0 )
glcEnableVertexAttribArray( 1 )
glcVertexAttribPointer( 1, 3, GL_FLOAT, GL_FALSE, VERTEX_STRIDE, cast( any ptr, 2 * sizeof( single ) ) )

dim as double started = timer

do while( glfwWindowShouldClose( win ) = 0 )
	if( glfwGetKey( win, GLFW_KEY_ESCAPE ) = GLFW_PRESS ) then
		glfwSetWindowShouldClose( win, 1 )
	end if
	glfwPollEvents( )

	glClearColor( 0.07, 0.07, 0.09, 1.0 )
	glClear( GL_COLOR_BUFFER_BIT )

	glcUseProgram( program )
	glcUniform1f( utime, csng( timer - started ) )
	glcBindVertexArray( vao )
	glDrawArrays( GL_TRIANGLES, 0, 3 )

	glfwSwapBuffers( win )
loop

glcDeleteBuffers( 1, @vbo )
glcDeleteVertexArrays( 1, @vao )
glcDeleteProgram( program )
glfwDestroyWindow( win )
glfwTerminate( )
