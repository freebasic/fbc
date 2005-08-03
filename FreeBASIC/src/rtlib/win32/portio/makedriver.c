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
 * makedriver.c -- Small program to generate fbportio_driver.h out of fbportio.sys
 *
 * chng: aug/2005 written [lillo]
 *
 */

#include <stdio.h>

#define FBPORTIO_SYS		"i386\\fbportio.sys"
#define FBPORTIO_DRIVER_H	"fbportio_driver.h"


int main()
{
	FILE *f;
	unsigned char *buffer;
	int i, size;
	
	f = fopen(FBPORTIO_SYS, "rb");
	if (!f) {
		fprintf(stderr, "Unable to open " FBPORTIO_SYS " for reading, program aborted\n");
		return -1;
	}
	fseek(f, 0, SEEK_END);
	size = ftell(f);
	fseek(f, 0, SEEK_SET);
	buffer = (unsigned char *)malloc(size);
	fread(buffer, 1, size, f);
	fclose(f);
	
	f = fopen(FBPORTIO_DRIVER_H, "w");
	if (!f) {
		fprintf(stderr, "Unable to open " FBPORTIO_DRIVER_H " for writing, program aborted\n");
		free(buffer);
		return -1;
	}
	fprintf(f, "#define FBPORTIO_DRIVER_SIZE %d\n\n", size);
	fprintf(f, "const unsigned char fbportio_driver[] = {\n\t");
	for (i = 0; i < size; i++) {
		fprintf(f, "%s%x%s", (buffer[i] < 16) ? "0x0" : "0x", buffer[i],
			(i == size - 1) ? "\n};\n" : (((i % 16) == 15) ? ",\n\t" : ", "));
	}
	fclose(f);
	
	free(buffer);
	
	return 0;
}
