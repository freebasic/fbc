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
 * vars.c -- all global variables are defined here
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

MODE *fb_mode = NULL;
void *(*fb_hMemCpy)(void *dest, const void *src, size_t size) = memcpy;
void *(*fb_hMemSet)(void *dest, int value, size_t size) = memset;
void (*fb_hPutPixel)(int x, int y, unsigned int color) = NULL;
unsigned int (*fb_hGetPixel)(int x, int y) = NULL;
void *(*fb_hPixelCpy)(void *dest, const void *src, size_t size) = NULL;
void *(*fb_hPixelSet)(void *dest, int color, size_t size) = NULL;
unsigned int *fb_color_conv_16to32 = NULL;
char *__fb_window_title = NULL;

