/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * dynload.c -- Dynamic library functions loading
 *
 * chng: feb/2006 written [lillo]
 *
 */

#include <stdlib.h>
#include <dlfcn.h>


/*:::::*/
void *fb_hDynLoad(const char *libname, const char **funcname, void **funcptr)
{
	void *lib;
	int i;
	
	/* First look if library was already statically linked with current executable */
	if (!(lib = dlopen(NULL, RTLD_LAZY)))
		return NULL;
	if (!dlsym(lib, funcname[0])) {
		dlclose(lib);
		if (!(lib = dlopen(libname, RTLD_LAZY)))
			return NULL;
	}
	
	/* Load functions */
	for (i = 0; funcname[i]; i++) {
		funcptr[i] = dlsym(lib, funcname[i]);
		if (!funcptr[i]) {
			dlclose(lib);
			return NULL;
		}
	}
	
	return lib;
}


/*:::::*/
void fb_hDynUnload(void **lib)
{
    if (*lib) {
    	dlclose(*lib);
	    *lib = NULL;
	}
}
