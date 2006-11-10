/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * opengl.c -- OpenGL core support functions
 *
 * chng: nov/2006 written [lillo]
 *
 */

#include "fb_gfx.h"
#include <GL/gl.h>


FB_GL fb_gl;


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
void fb_hGL_SetState(int state)
{
	int diffs;
	
	diffs = state ^ fb_gl.state;
	fb_gl.state = state;
	
	if (diffs & FBGL_TEXTURE) {
		if (state & FBGL_TEXTURE)
			fb_gl.Enable(GL_TEXTURE_2D);
		else
			fb_gl.Disable(GL_TEXTURE_2D);
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
	fb_gl.GenTextures(1, &id);
	fb_gl.BindTexture(GL_TEXTURE_2D, id);
	fb_gl.TexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_BGRA, GL_UNSIGNED_BYTE, data);
	free(data);
	
	return id;
}


void fb_hGL_ImageDestroy(GLuint id)
{
	fb_gl.DeleteTextures(1, &id);
}


/*:::::*/
int fb_hGL_Init(FB_DYLIB lib)
{
	const char *gl_funcs[] = { "glEnable", "glDisable", "glGetString", "glViewport", "glMatrixMode",
							   "glLoadIdentity", "glOrtho", "glShadeModel", "glDepthMask", "glClearColor",
							   "glClear", "glGenTextures", "glDeleteTextures", "glBindTexture",
							   "glTexImage2D" };
	int res = 0;
	
	fb_hMemSet(&fb_gl, 0, sizeof(FB_GL));
	
	if (fb_hDynLoadAlso(lib, gl_funcs, (void **)&fb_gl, sizeof(gl_funcs) / sizeof(const char *)))
		return -1;
	
	fb_gl.extensions = (char *)fb_gl.GetString(GL_EXTENSIONS);
	
	res |= !fb_hGL_ExtensionSupported("GL_EXT_bgra");
	
	return res;
}


/*:::::*/
void fb_hGL_SetupProjection(void)
{
	fb_gl.Viewport(0, 0, fb_mode->w, fb_mode->h);
	fb_gl.MatrixMode(GL_PROJECTION);
	fb_gl.LoadIdentity();
	fb_gl.Ortho(-0.325, fb_mode->w - 0.325, fb_mode->h - 0.325, -0.325, -1.0, 1.0);
	fb_gl.MatrixMode(GL_MODELVIEW);
	fb_gl.LoadIdentity();
	fb_gl.ShadeModel(GL_FLAT);
	fb_gl.Disable(GL_DEPTH_TEST);
	fb_gl.DepthMask(GL_FALSE);
	fb_gl.ClearColor(0.0, 0.0, 0.0, 1.0);
	fb_gl.Clear(GL_COLOR_BUFFER_BIT);
}
