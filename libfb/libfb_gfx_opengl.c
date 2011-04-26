/*
 * opengl.c -- OpenGL core support functions
 *
 * chng: nov/2006 written [lillo]
 *
 */

#include "fb_gfx.h"
#include <GL/gl.h>


FB_GL __fb_gl;
FB_GL_PARAMS __fb_gl_params = { 0 };


/*:::::*/
static int next_pow2(int n)
{
	n--;
	n |= (n >> 1);
	n |= (n >> 2);
	n |= (n >> 4);
	n |= (n >> 8);
	n |= (n >> 16);
	n++;
	
	return n;
}


/*:::::*/
FBCALL void *fb_GfxGetGLProcAddress(const char *proc)
{
	if ((!__fb_gfx) || (!(__fb_gfx->flags & OPENGL_SUPPORT)))
		return NULL;
	return fb_hGL_GetProcAddress(proc);
}


/*:::::*/
int fb_hGL_ExtensionSupported(const char *extension)
{
	int len;
	char *string = __fb_gl.extensions;
	
	len = strlen(extension);
	while ((string = strstr(string, extension)) != NULL) {
		string += len;
		if ((*string == ' ') || (*string == '\0'))
			return TRUE;
	}
	
	return FALSE;
}


/*:::::*/
void fb_hGL_SetState(int state)
{
	int diffs;
	
	diffs = state ^ __fb_gl.state;
	__fb_gl.state = state;
	
	if (diffs & FBGL_TEXTURE) {
		if (state & FBGL_TEXTURE)
			__fb_gl.Enable(GL_TEXTURE_2D);
		else
			__fb_gl.Disable(GL_TEXTURE_2D);
	}
	if (diffs & FBGL_BLEND) {
		
	}
}


GLuint fb_hGL_ImageCreate(PUT_HEADER *image, unsigned int color)
{
	int w, h;
	GLuint id;
	unsigned char *data;
		
	w = next_pow2(image->width);
	h = next_pow2(image->height);
	data = (unsigned char *)calloc(1, w * h * 4);
	fb_hPixelSet(data, color, w * h);
	__fb_gl.GenTextures(1, &id);
	__fb_gl.BindTexture(GL_TEXTURE_2D, id);
	__fb_gl.TexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_BGRA, GL_UNSIGNED_BYTE, data);
	free(data);
	
	return id;
}


void fb_hGL_ImageDestroy(GLuint id)
{
	__fb_gl.DeleteTextures(1, &id);
}


/*:::::*/
void fb_hGL_NormalizeParameters(int gl_options)
{
	int default_color_bits[4] = { 0, 5, 8, 8 };
	int default_alpha_bits[4] = { 0, 0, 0, 8 };
	int bpp;
	
	if (!__fb_gl_params.color_bits) {
		__fb_gl_params.color_bits = __fb_gl_params.color_red_bits +
									__fb_gl_params.color_green_bits +
									__fb_gl_params.color_blue_bits +
									__fb_gl_params.color_alpha_bits;
		if (!__fb_gl_params.color_bits)
			__fb_gl_params.color_bits = __fb_gfx->depth;
	}
	bpp = BYTES_PER_PIXEL(__fb_gl_params.color_bits) - 1;
	if (bpp > 3) bpp = 3;
	if (!__fb_gl_params.color_red_bits)
		__fb_gl_params.color_red_bits = default_color_bits[bpp];
	if (!__fb_gl_params.color_green_bits)
		__fb_gl_params.color_green_bits = default_color_bits[bpp];
	if (!__fb_gl_params.color_blue_bits)
		__fb_gl_params.color_blue_bits = default_color_bits[bpp];
	if (!__fb_gl_params.color_alpha_bits)
		__fb_gl_params.color_alpha_bits = default_alpha_bits[bpp];
	
	if (!__fb_gl_params.accum_bits) {
		__fb_gl_params.accum_bits = __fb_gl_params.accum_red_bits +
									__fb_gl_params.accum_green_bits +
									__fb_gl_params.accum_blue_bits +
									__fb_gl_params.accum_alpha_bits;
	}
	bpp = BYTES_PER_PIXEL(__fb_gl_params.accum_bits) - 1;
	if (bpp > 3) bpp = 3;
	if ((bpp < 0) && (gl_options & HAS_ACCUMULATION_BUFFER)) {
		__fb_gl_params.accum_bits = 32;
		bpp = 3;
	}
	if (bpp >= 0) {
		if (!__fb_gl_params.accum_red_bits)
			__fb_gl_params.accum_red_bits = default_color_bits[bpp];
		if (!__fb_gl_params.accum_green_bits)
			__fb_gl_params.accum_green_bits = default_color_bits[bpp];
		if (!__fb_gl_params.accum_blue_bits)
			__fb_gl_params.accum_blue_bits = default_color_bits[bpp];
		if (!__fb_gl_params.accum_alpha_bits)
			__fb_gl_params.accum_alpha_bits = default_alpha_bits[bpp];
	}
	
	if (!__fb_gl_params.depth_bits)
		__fb_gl_params.depth_bits = 16;
	
	if ((!__fb_gl_params.stencil_bits) && (gl_options & HAS_STENCIL_BUFFER))
		__fb_gl_params.stencil_bits = 8;
	
	if ((!__fb_gl_params.num_samples) && (gl_options & HAS_MULTISAMPLE))
		__fb_gl_params.num_samples = 4;
}


/*:::::*/
int fb_hGL_Init(FB_DYLIB lib, char *os_extensions)
{
	const char *gl_funcs[] = { "glEnable", "glDisable", "glGetString", "glViewport", "glMatrixMode",
							   "glLoadIdentity", "glOrtho", "glShadeModel", "glDepthMask", "glClearColor",
							   "glClear", "glGenTextures", "glDeleteTextures", "glBindTexture",
							   "glTexImage2D" };
	FB_GL *funcs = &__fb_gl;
	void **funcs_ptr = (void **)funcs;
	int res = 0, size = FBGL_EXTENSIONS_STRING_SIZE - 1;
	
	fb_hMemSet(&__fb_gl, 0, sizeof(FB_GL));
	
	if (fb_hDynLoadAlso(lib, gl_funcs, funcs_ptr, sizeof(gl_funcs) / sizeof(const char *)))
		return -1;
	
	strncpy(__fb_gl.extensions, (char *)__fb_gl.GetString(GL_EXTENSIONS), size);
	size -= strlen(__fb_gl.extensions);
	if (os_extensions)
		strncat(__fb_gl.extensions, os_extensions, size);
	__fb_gl.extensions[FBGL_EXTENSIONS_STRING_SIZE - 1] = '\0';
	
	res |= !fb_hGL_ExtensionSupported("GL_EXT_bgra");
	
	return res;
}


/*:::::*/
void fb_hGL_SetupProjection(void)
{
	__fb_gl.Viewport(0, 0, __fb_gfx->w, __fb_gfx->h);
	__fb_gl.MatrixMode(GL_PROJECTION);
	__fb_gl.LoadIdentity();
	__fb_gl.Ortho(-0.325, __fb_gfx->w - 0.325, __fb_gfx->h - 0.325, -0.325, -1.0, 1.0);
	__fb_gl.MatrixMode(GL_MODELVIEW);
	__fb_gl.LoadIdentity();
	__fb_gl.ShadeModel(GL_FLAT);
	__fb_gl.Disable(GL_DEPTH_TEST);
	__fb_gl.DepthMask(GL_FALSE);
	__fb_gl.ClearColor(0.0, 0.0, 0.0, 1.0);
	__fb_gl.Clear(GL_COLOR_BUFFER_BIT);
}
