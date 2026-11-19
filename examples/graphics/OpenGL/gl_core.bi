''  Shared plumbing for the gl_core_*.bas examples.
''
''  A core-profile context has no fixed-function pipeline, so these examples
''  use shaders, buffer objects and vertex array objects.  Those entry points
''  are loaded at run time with glfwGetProcAddress(), because opengl32.dll
''  only exports GL 1.1 and no platform promises a link-time address for the
''  rest.  That is also why the examples link nothing but GLFW.
''
''  Include this from a gl_core_*.bas file in this directory; it is not an
''  example by itself.
''
''  Requirements: GLFW 3, and a driver that can provide a 3.3 core context.

#pragma once

#include once "GL/gl.bi"
#include once "GLFW/glfw3.bi"

'' ---------------------------------------------------------------------------
''  Entry points introduced after GL 1.1.  All of them are function pointers
''  filled in by glcInit(); calling one before glcInit() crashes.
'' ---------------------------------------------------------------------------

dim shared glcCreateShader           as PFNGLCREATESHADERPROC
dim shared glcShaderSource           as PFNGLSHADERSOURCEPROC
dim shared glcCompileShader          as PFNGLCOMPILESHADERPROC
dim shared glcGetShaderiv            as PFNGLGETSHADERIVPROC
dim shared glcGetShaderInfoLog       as PFNGLGETSHADERINFOLOGPROC
dim shared glcDeleteShader           as PFNGLDELETESHADERPROC

dim shared glcCreateProgram          as PFNGLCREATEPROGRAMPROC
dim shared glcAttachShader           as PFNGLATTACHSHADERPROC
dim shared glcLinkProgram            as PFNGLLINKPROGRAMPROC
dim shared glcGetProgramiv           as PFNGLGETPROGRAMIVPROC
dim shared glcGetProgramInfoLog      as PFNGLGETPROGRAMINFOLOGPROC
dim shared glcUseProgram             as PFNGLUSEPROGRAMPROC
dim shared glcDeleteProgram          as PFNGLDELETEPROGRAMPROC

dim shared glcGenVertexArrays        as PFNGLGENVERTEXARRAYSPROC
dim shared glcBindVertexArray        as PFNGLBINDVERTEXARRAYPROC
dim shared glcDeleteVertexArrays     as PFNGLDELETEVERTEXARRAYSPROC

dim shared glcGenBuffers             as PFNGLGENBUFFERSPROC
dim shared glcBindBuffer             as PFNGLBINDBUFFERPROC
dim shared glcBufferData             as PFNGLBUFFERDATAPROC
dim shared glcDeleteBuffers          as PFNGLDELETEBUFFERSPROC

dim shared glcEnableVertexAttribArray as PFNGLENABLEVERTEXATTRIBARRAYPROC
dim shared glcVertexAttribPointer    as PFNGLVERTEXATTRIBPOINTERPROC

dim shared glcGetUniformLocation     as PFNGLGETUNIFORMLOCATIONPROC
dim shared glcUniformMatrix4fv       as PFNGLUNIFORMMATRIX4FVPROC
dim shared glcUniform1i              as PFNGLUNIFORM1IPROC
dim shared glcUniform1f              as PFNGLUNIFORM1FPROC

dim shared glcActiveTexture          as PFNGLACTIVETEXTUREPROC
dim shared glcGenerateMipmap         as PFNGLGENERATEMIPMAPPROC

'' ---------------------------------------------------------------------------
''  Loading
'' ---------------------------------------------------------------------------

private function glcProc( byval procname as const zstring ptr ) as any ptr
	dim as any ptr p = cast( any ptr, glfwGetProcAddress( procname ) )
	if( p = 0 ) then
		print "gl_core: the driver does not provide " & *procname
		print "gl_core: a 3.3 core context is required"
		end 1
	end if
	function = p
end function

'' Call after glfwMakeContextCurrent().
sub glcInit( )
	glcCreateShader           = cast( PFNGLCREATESHADERPROC,            glcProc( "glCreateShader" ) )
	glcShaderSource           = cast( PFNGLSHADERSOURCEPROC,            glcProc( "glShaderSource" ) )
	glcCompileShader          = cast( PFNGLCOMPILESHADERPROC,           glcProc( "glCompileShader" ) )
	glcGetShaderiv            = cast( PFNGLGETSHADERIVPROC,             glcProc( "glGetShaderiv" ) )
	glcGetShaderInfoLog       = cast( PFNGLGETSHADERINFOLOGPROC,        glcProc( "glGetShaderInfoLog" ) )
	glcDeleteShader           = cast( PFNGLDELETESHADERPROC,            glcProc( "glDeleteShader" ) )

	glcCreateProgram          = cast( PFNGLCREATEPROGRAMPROC,           glcProc( "glCreateProgram" ) )
	glcAttachShader           = cast( PFNGLATTACHSHADERPROC,            glcProc( "glAttachShader" ) )
	glcLinkProgram            = cast( PFNGLLINKPROGRAMPROC,             glcProc( "glLinkProgram" ) )
	glcGetProgramiv           = cast( PFNGLGETPROGRAMIVPROC,            glcProc( "glGetProgramiv" ) )
	glcGetProgramInfoLog      = cast( PFNGLGETPROGRAMINFOLOGPROC,       glcProc( "glGetProgramInfoLog" ) )
	glcUseProgram             = cast( PFNGLUSEPROGRAMPROC,              glcProc( "glUseProgram" ) )
	glcDeleteProgram          = cast( PFNGLDELETEPROGRAMPROC,           glcProc( "glDeleteProgram" ) )

	glcGenVertexArrays        = cast( PFNGLGENVERTEXARRAYSPROC,         glcProc( "glGenVertexArrays" ) )
	glcBindVertexArray        = cast( PFNGLBINDVERTEXARRAYPROC,         glcProc( "glBindVertexArray" ) )
	glcDeleteVertexArrays     = cast( PFNGLDELETEVERTEXARRAYSPROC,      glcProc( "glDeleteVertexArrays" ) )

	glcGenBuffers             = cast( PFNGLGENBUFFERSPROC,              glcProc( "glGenBuffers" ) )
	glcBindBuffer             = cast( PFNGLBINDBUFFERPROC,              glcProc( "glBindBuffer" ) )
	glcBufferData             = cast( PFNGLBUFFERDATAPROC,              glcProc( "glBufferData" ) )
	glcDeleteBuffers          = cast( PFNGLDELETEBUFFERSPROC,           glcProc( "glDeleteBuffers" ) )

	glcEnableVertexAttribArray = cast( PFNGLENABLEVERTEXATTRIBARRAYPROC, glcProc( "glEnableVertexAttribArray" ) )
	glcVertexAttribPointer    = cast( PFNGLVERTEXATTRIBPOINTERPROC,     glcProc( "glVertexAttribPointer" ) )

	glcGetUniformLocation     = cast( PFNGLGETUNIFORMLOCATIONPROC,      glcProc( "glGetUniformLocation" ) )
	glcUniformMatrix4fv       = cast( PFNGLUNIFORMMATRIX4FVPROC,        glcProc( "glUniformMatrix4fv" ) )
	glcUniform1i              = cast( PFNGLUNIFORM1IPROC,               glcProc( "glUniform1i" ) )
	glcUniform1f              = cast( PFNGLUNIFORM1FPROC,               glcProc( "glUniform1f" ) )

	glcActiveTexture          = cast( PFNGLACTIVETEXTUREPROC,           glcProc( "glActiveTexture" ) )
	glcGenerateMipmap         = cast( PFNGLGENERATEMIPMAPPROC,          glcProc( "glGenerateMipmap" ) )
end sub

'' ---------------------------------------------------------------------------
''  Shaders
'' ---------------------------------------------------------------------------

private function glcCompile( byval kind as GLenum, byval source as const zstring ptr ) as GLuint
	dim as GLuint shader = glcCreateShader( kind )
	dim as const zstring ptr p = source
	dim as GLint status = 0
	dim as GLint loglen = 0

	glcShaderSource( shader, 1, @p, 0 )
	glcCompileShader( shader )
	glcGetShaderiv( shader, GL_COMPILE_STATUS, @status )
	if( status = 0 ) then
		glcGetShaderiv( shader, GL_INFO_LOG_LENGTH, @loglen )
		if( loglen > 0 and loglen < 4096 ) then
			dim as zstring * 4096 logtext = any
			glcGetShaderInfoLog( shader, loglen, 0, logtext )
			print "gl_core: shader compilation failed"
			print logtext
		else
			print "gl_core: shader compilation failed (no log)"
		end if
		end 1
	end if
	function = shader
end function

'' Compile and link a vertex/fragment pair; exits with the driver's log on error.
function glcProgram( byval vertexsource as const zstring ptr, byval fragmentsource as const zstring ptr ) as GLuint
	dim as GLuint vs = glcCompile( GL_VERTEX_SHADER, vertexsource )
	dim as GLuint fs = glcCompile( GL_FRAGMENT_SHADER, fragmentsource )
	dim as GLuint program = glcCreateProgram( )
	dim as GLint status = 0
	dim as GLint loglen = 0

	glcAttachShader( program, vs )
	glcAttachShader( program, fs )
	glcLinkProgram( program )
	glcGetProgramiv( program, GL_LINK_STATUS, @status )
	if( status = 0 ) then
		glcGetProgramiv( program, GL_INFO_LOG_LENGTH, @loglen )
		if( loglen > 0 and loglen < 4096 ) then
			dim as zstring * 4096 logtext = any
			glcGetProgramInfoLog( program, loglen, 0, logtext )
			print "gl_core: program link failed"
			print logtext
		else
			print "gl_core: program link failed (no log)"
		end if
		end 1
	end if

	glcDeleteShader( vs )
	glcDeleteShader( fs )
	function = program
end function

'' ---------------------------------------------------------------------------
''  Column-major 4x4 matrices, the layout glUniformMatrix4fv() expects with
''  transpose = GL_FALSE.  Enough for a model-view-projection demo.
'' ---------------------------------------------------------------------------

type GLC_MAT4
	m( 0 to 15 ) as single
end type

function glcIdentity( ) as GLC_MAT4
	dim r as GLC_MAT4
	r.m(  0 ) = 1.0
	r.m(  5 ) = 1.0
	r.m( 10 ) = 1.0
	r.m( 15 ) = 1.0
	function = r
end function

function glcMul( byref a as const GLC_MAT4, byref b as const GLC_MAT4 ) as GLC_MAT4
	dim r as GLC_MAT4
	for col as integer = 0 to 3
		for row as integer = 0 to 3
			dim as single s = 0.0
			for k as integer = 0 to 3
				s += a.m( k * 4 + row ) * b.m( col * 4 + k )
			next
			r.m( col * 4 + row ) = s
		next
	next
	function = r
end function

function glcTranslate( byval x as single, byval y as single, byval z as single ) as GLC_MAT4
	dim r as GLC_MAT4 = glcIdentity( )
	r.m( 12 ) = x
	r.m( 13 ) = y
	r.m( 14 ) = z
	function = r
end function

function glcRotateX( byval radians as single ) as GLC_MAT4
	dim r as GLC_MAT4 = glcIdentity( )
	dim as single c = cos( radians ), s = sin( radians )
	r.m(  5 ) =  c
	r.m(  6 ) =  s
	r.m(  9 ) = -s
	r.m( 10 ) =  c
	function = r
end function

function glcRotateY( byval radians as single ) as GLC_MAT4
	dim r as GLC_MAT4 = glcIdentity( )
	dim as single c = cos( radians ), s = sin( radians )
	r.m(  0 ) =  c
	r.m(  2 ) = -s
	r.m(  8 ) =  s
	r.m( 10 ) =  c
	function = r
end function

function glcRotateZ( byval radians as single ) as GLC_MAT4
	dim r as GLC_MAT4 = glcIdentity( )
	dim as single c = cos( radians ), s = sin( radians )
	r.m(  0 ) =  c
	r.m(  1 ) =  s
	r.m(  4 ) = -s
	r.m(  5 ) =  c
	function = r
end function

'' Right-handed perspective projection, looking down -Z.
function glcPerspective( byval fovyradians as single, byval aspect as single, byval znear as single, byval zfar as single ) as GLC_MAT4
	dim r as GLC_MAT4
	dim as single f = 1.0 / tan( fovyradians / 2.0 )

	r.m(  0 ) = f / aspect
	r.m(  5 ) = f
	r.m( 10 ) = ( zfar + znear ) / ( znear - zfar )
	r.m( 11 ) = -1.0
	r.m( 14 ) = ( 2.0 * zfar * znear ) / ( znear - zfar )
	function = r
end function
