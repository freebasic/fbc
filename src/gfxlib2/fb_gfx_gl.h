/* internal OpenGL gfx definitions */

#ifndef DISABLE_OPENGL

#ifdef HOST_DARWIN
	#include <OpenGL/gl.h>
	/* Mac GL headers don't define APIENTRY, so we do it manually */
	#define APIENTRY
#else
	#include <GL/gl.h>
#endif
#include "../rtlib/fb_private_hdynload.h"

#define FBGL_EXTENSIONS_STRING_SIZE		16384

#ifndef GL_ARB_multisample
#define GL_ARB_multisample
#define GL_MULTISAMPLE_ARB              0x809D
#endif

typedef void (APIENTRY *GLENABLE)(GLenum);
typedef void (APIENTRY *GLDISABLE)(GLenum);
typedef void (APIENTRY *GLENABLECLIENTSTATE)(GLenum);
typedef void (APIENTRY *GLDISABLECLIENTSTATE)(GLenum);
typedef const GLubyte *(APIENTRY *GLGETSTRING)(GLenum);
typedef void (APIENTRY *GLVIEWPORT)(GLint,GLint,GLsizei,GLsizei);
typedef void (APIENTRY *GLMATRIXMODE)(GLenum);
typedef void (APIENTRY *GLLOADIDENTITY)(void);
typedef void (APIENTRY *GLORTHO)(GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble);
typedef void (APIENTRY *GLSHADEMODEL)(GLenum);
typedef void (APIENTRY *GLDEPTHMASK)(GLboolean);
typedef void (APIENTRY *GLCLEARCOLOR)(GLclampf,GLclampf,GLclampf,GLclampf);
typedef void (APIENTRY *GLCLEAR)(GLbitfield);
typedef void (APIENTRY *GLGENTEXTURES)(GLsizei,GLuint *);
typedef void (APIENTRY *GLDELETETEXTURES)(GLsizei,GLuint *);
typedef void (APIENTRY *GLBINDTEXTURE)(GLenum,GLuint);
typedef void (APIENTRY *GLTEXPARAMETERI)(GLenum, GLenum, GLint);
typedef void (APIENTRY *GLTEXIMAGE2D)(GLenum,GLint,GLint,GLsizei,GLsizei,GLint,GLenum,GLenum,const GLvoid *);
typedef void (APIENTRY *GLTEXSUBIMAGE2D)(GLenum,GLint,GLint,GLint,GLsizei,GLsizei,GLenum,GLenum,const GLvoid *);
typedef void (APIENTRY *GLVERTEXPOINTER)(GLint,GLenum,GLsizei, const GLvoid *);
typedef void (APIENTRY *GLTEXCOORDPOINTER)(GLint,GLenum,GLsizei,const GLvoid *);
typedef void (APIENTRY *GLDRAWARRAYS)(GLenum,GLint,GLsizei);
typedef void (APIENTRY *GLPUSHMATRIX)(void);
typedef void (APIENTRY *GLPOPMATRIX)(void);
typedef void (APIENTRY *GLPUSHATTRIB)(GLbitfield);
typedef void (APIENTRY *GLPOPATTRIB)(void);
typedef void (APIENTRY *GLPUSHCLIENTATTRIB)(GLbitfield);
typedef void (APIENTRY *GLPOPCLIENTATTRIB)(void);
typedef void (APIENTRY *GLPIXELSTOREI)(GLenum, GLint);
typedef void (APIENTRY *GLPIXELTRANSFERI)(GLenum, GLint);
typedef void (APIENTRY *GLPIXELMAPFV)(GLenum, GLsizei, const GLfloat *);


typedef struct FB_GL {
	GLENABLE					Enable;
	GLDISABLE					Disable;
	GLENABLECLIENTSTATE			EnableClientState;
	GLDISABLECLIENTSTATE		DisableClientState;
	GLGETSTRING					GetString;
	GLVIEWPORT					Viewport;
	GLMATRIXMODE				MatrixMode;
	GLLOADIDENTITY				LoadIdentity;
	GLORTHO						Ortho;
	GLSHADEMODEL				ShadeModel;
	GLDEPTHMASK					DepthMask;
	GLCLEARCOLOR				ClearColor;
	GLCLEAR						Clear;
	GLGENTEXTURES				GenTextures;
	GLDELETETEXTURES			DeleteTextures;
	GLBINDTEXTURE				BindTexture;
	GLTEXPARAMETERI				TexParameteri;
	GLTEXIMAGE2D				TexImage2D;
	GLTEXSUBIMAGE2D				TexSubImage2D;
	GLVERTEXPOINTER				VertexPointer;
	GLTEXCOORDPOINTER			TexCoordPointer;
	GLDRAWARRAYS				DrawArrays;
	GLPUSHMATRIX				PushMatrix;
	GLPOPMATRIX					PopMatrix;
	GLPUSHATTRIB				PushAttrib;
	GLPOPATTRIB					PopAttrib;
	GLPUSHCLIENTATTRIB			PushClientAttrib;
	GLPOPCLIENTATTRIB			PopClientAttrib;
	GLPIXELSTOREI				PixelStorei;
	GLPIXELTRANSFERI			PixelTransferi;
	GLPIXELMAPFV				PixelMapfv;
	int							state;
    char						extensions[FBGL_EXTENSIONS_STRING_SIZE];
} FB_GL;

typedef struct FB_GL_PARAMS {
	int color_bits;
	int color_red_bits;
	int color_green_bits;
	int color_blue_bits;
	int color_alpha_bits;
	int depth_bits;
	int stencil_bits;
	int accum_bits;
	int accum_red_bits;
	int accum_green_bits;
	int accum_blue_bits;
	int accum_alpha_bits;
	int num_samples;
	int init_mode_2d;
	int mode_2d;
	int init_scale;
	int scale;
	void (*callback)(void);
} FB_GL_PARAMS;

extern FB_GL __fb_gl;
extern FB_GL_PARAMS __fb_gl_params;
extern void fb_hGL_SetPalette(int index, int r, int g, int b);

extern void fb_hGL_NormalizeParameters(int gl_options);
extern int fb_hGL_Init(FB_DYLIB lib, char *os_extensions);
extern int fb_hGL_ExtensionSupported(const char *extension);
extern void *fb_hGL_GetProcAddress(const char *proc);
extern void fb_hGL_SetupProjection(void);
extern void fb_hGL_ScreenCreate(void);

#endif /* not DISABLE_OPENGL */
