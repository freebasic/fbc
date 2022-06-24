/* OpenGL core support functions */

#include "fb_gfx.h"
#include "fb_gfx_gl.h"

#ifdef DISABLE_OPENGL

FBCALL void *fb_GfxGetGLProcAddress(const char *proc)
{
	/* Stub function in case OpenGL support is disabled at compile time */
	return NULL;
}

#else /* DISABLE_OPENGL */

#define FBGL_TEXTURE 0x1
#define FBGL_BLEND   0x2

#ifndef GL_BGRA
#define GL_BGRA   0x80E1
#endif

#ifndef GL_UNSIGNED_SHORT_5_6_5
#define GL_UNSIGNED_SHORT_5_6_5           0x8363
#endif

FB_GL __fb_gl;
FB_GL_PARAMS __fb_gl_params = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, NULL };
static GLfloat texcoords[8];
static GLuint ScreenTex;
static GLfloat map_r[256], map_g[256], map_b[256];

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

FBCALL void *fb_GfxGetGLProcAddress(const char *proc)
{
	void *result;

	FB_GRAPHICS_LOCK( );

	if (__fb_gfx && (__fb_gfx->flags & OPENGL_SUPPORT)) {
		result = fb_hGL_GetProcAddress(proc);
	} else {
		result = NULL;
	}

	FB_GRAPHICS_UNLOCK( );

	return result;
}

int fb_hGL_ExtensionSupported(const char *extension)
{
	ssize_t len;
	char *string = __fb_gl.extensions;

	len = strlen(extension);
	while ((string = strstr(string, extension)) != NULL) {
		string += len;
		if ((*string == ' ') || (*string == '\0'))
			return TRUE;
	}

	return FALSE;
}

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

void fb_hGL_ScreenCreate(void)
{
	int w, h;
	GLuint id;

	w = next_pow2(__fb_gfx->w);
	h = next_pow2(__fb_gfx->h);

	__fb_gl.GenTextures(1, &id);
	__fb_gl.BindTexture(GL_TEXTURE_2D, id);
	__fb_gl.TexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
	__fb_gl.TexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

	switch (__fb_gfx->depth){
	case 32:
	case 24:
		__fb_gl.TexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
		break;
	case 16:
	case 15:
		__fb_gl.TexImage2D(GL_TEXTURE_2D, 0, GL_RGB, w, h, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, 0);
		break;
	case 8:
	case 4:
	case 2:
	case 1:
		__fb_gl.TexImage2D(GL_TEXTURE_2D, 0, GL_RGB, w, h, 0, GL_COLOR_INDEX, GL_UNSIGNED_BYTE, 0);
	}

	GLfloat ratio_w = (GLfloat)__fb_gfx->w / w, ratio_h = (GLfloat)__fb_gfx->h / h;
	texcoords[0] = 0	; texcoords[1] = ratio_h;
	texcoords[2] = 0	; texcoords[3] = 0;
	texcoords[4] = ratio_w	; texcoords[5] = 0;
	texcoords[6] = ratio_w	; texcoords[7] = ratio_h;

	ScreenTex = id;
}

void fb_hGL_ImageDestroy(GLuint id)
{
	__fb_gl.DeleteTextures(1, &id);
}

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

int fb_hGL_Init(FB_DYLIB lib, char *os_extensions)
{
	const char *const gl_funcs[] = { "glEnable", "glDisable", "glEnableClientState", "glDisableClientState",
							   "glGetString", "glViewport", "glMatrixMode",
							   "glLoadIdentity", "glOrtho", "glShadeModel", "glDepthMask", "glClearColor",
							   "glClear", "glGenTextures", "glDeleteTextures", "glBindTexture", 
							   "glTexParameteri", "glTexImage2D", "glTexSubImage2D",
							   "glVertexPointer", "glTexCoordPointer", "glDrawArrays",
							   "glPushMatrix", "glPopMatrix", "glPushAttrib", "glPopAttrib", 
							   "glPushClientAttrib", "glPopClientAttrib", "glPixelStorei",
							   "glPixelTransferi", "glPixelMapfv" };
	FB_GL *funcs = &__fb_gl;
	void **funcs_ptr = (void **)funcs;
	int res = 0, size = FBGL_EXTENSIONS_STRING_SIZE - 1;

	fb_hMemSet(&__fb_gl, 0, sizeof(FB_GL));

	if (fb_hDynLoadAlso(lib, gl_funcs, funcs_ptr, ARRAY_SIZE(gl_funcs)))
		return -1;

	strncpy(__fb_gl.extensions, (char *)__fb_gl.GetString(GL_EXTENSIONS), size);
	size -= strlen(__fb_gl.extensions);
	if (os_extensions)
		strncat(__fb_gl.extensions, os_extensions, size);
	__fb_gl.extensions[FBGL_EXTENSIONS_STRING_SIZE - 1] = '\0';

	res |= !fb_hGL_ExtensionSupported("GL_EXT_bgra");

	return res;
}


void fb_hGL_SetPalette(int index, int r, int g, int b){
	map_r[index]=(float)r/256.0;
	map_g[index]=(float)g/256.0;
	map_b[index]=(float)b/256.0;
}


void fb_hGL_SetupProjection(void)
{
	/*
	INFO ONLY: Prior to oGLfbgfx changes, this is the projection set-up

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
	*/

	const GLfloat vert[] = {-1,-1,-1,1,1,1,1,-1};

	__fb_gl.PushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS);
	__fb_gl.PushAttrib(GL_ALL_ATTRIB_BITS);
	__fb_gl.Viewport(0, 0, __fb_gfx->w * __fb_gl_params.scale, __fb_gfx->h * __fb_gl_params.scale);
	__fb_gl.MatrixMode(GL_PROJECTION);
	__fb_gl.PushMatrix();
	__fb_gl.LoadIdentity();

	__fb_gl.Ortho(-1, 1, -1, 1, -1, 1);
	__fb_gl.MatrixMode(GL_MODELVIEW);
	__fb_gl.PushMatrix();
	__fb_gl.LoadIdentity();
	__fb_gl.ShadeModel(GL_FLAT);
	__fb_gl.Disable(GL_DEPTH_TEST);
	__fb_gl.DepthMask(GL_FALSE);
	__fb_gl.EnableClientState( GL_VERTEX_ARRAY );
	__fb_gl.EnableClientState( GL_TEXTURE_COORD_ARRAY );
	__fb_gl.DisableClientState(GL_NORMAL_ARRAY);
	__fb_gl.DisableClientState(GL_COLOR_ARRAY);

	__fb_gl.VertexPointer(2, GL_FLOAT, 0, vert);
	__fb_gl.TexCoordPointer(2, GL_FLOAT, 0, texcoords);

	//__fb_gl.ActiveTexture(GL_TEXTURE0);
	__fb_gl.BindTexture(GL_TEXTURE_2D, ScreenTex);
	switch(__fb_gfx->depth){
	case 32:
	case 24:
		__fb_gl.TexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, __fb_gfx->w, __fb_gfx->h, GL_BGRA, GL_UNSIGNED_BYTE, (unsigned char *)__fb_gfx->framebuffer);
		break;
	case 16:
	case 15:
		__fb_gl.PixelStorei(GL_UNPACK_ALIGNMENT, 1);
		__fb_gl.TexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, __fb_gfx->w, __fb_gfx->h, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, (unsigned char *)__fb_gfx->framebuffer);
		break;
	case 8:
	case 4:
	case 2:
	case 1:
		__fb_gl.PixelStorei(GL_UNPACK_ALIGNMENT, 1);
		__fb_gl.PixelTransferi(GL_MAP_COLOR, GL_TRUE );
		__fb_gl.PixelMapfv(GL_PIXEL_MAP_I_TO_R,256, map_r);
		__fb_gl.PixelMapfv(GL_PIXEL_MAP_I_TO_G,256, map_g);
		__fb_gl.PixelMapfv(GL_PIXEL_MAP_I_TO_B,256, map_b);

		__fb_gl.TexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, __fb_gfx->w, __fb_gfx->h, GL_COLOR_INDEX, GL_UNSIGNED_BYTE, (unsigned char *)__fb_gfx->framebuffer);

	}

	__fb_gl.Enable(GL_TEXTURE_2D);
	__fb_gl.DrawArrays(GL_TRIANGLE_FAN,0,4);

	__fb_gl.PopMatrix(); /* GL_MODELVIEW */
	__fb_gl.MatrixMode(GL_PROJECTION);
	__fb_gl.PopMatrix();
	__fb_gl.PopAttrib();
	__fb_gl.PopClientAttrib();

}

#endif /* DISABLE_OPENGL */
