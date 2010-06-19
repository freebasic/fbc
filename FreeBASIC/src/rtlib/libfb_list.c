/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * list.c -- generic internal lists based on static arrays
 *
 * chng: oct/2004 written [v1ctor]
 *       feb/2005 moved into a separated generic module [lillo]
 *
 */

#include <stdlib.h>
#include "fb.h"

/** Initializes a list.
 *
 * This list implementation is based on a static array.
 *
 * @param list      Pointer to list structure to initialize.
 * @param table     Pointer to the pool of available list elements.
 * @param elem_size Size of elements in the array.
 * @param size      Number of elements in the array.
 */
void fb_hListInit( FB_LIST *list, void *table, int elem_size, int size )
{
	int i;
	FB_LISTELEM *next;
    unsigned char *elem = (unsigned char *)table;

    fb_hListDynInit( list );
	
	list->fhead = (FB_LISTELEM *)elem;
	
	for( i = 0; i < size; i++ )
	{
		if( i < size-1 )
			next = (FB_LISTELEM *)(elem + elem_size);
		else
			next = NULL;
		((FB_LISTELEM *)elem)->prev = NULL;
		((FB_LISTELEM *)elem)->next = next;
		
		elem += elem_size;
	}
}

/** Allocate a new list element.
 *
 * This function gets an element from the list of free elements
 * ( struct _FB_LIST::fhead ) and adds to the tail. It also increases the
 * number of used elements ( struct _FB_LIST::cnt ).
 *
 * @param list      Pointer to the list structure.
 *
 * @return A new element.
 */
FB_LISTELEM *fb_hListAllocElem( FB_LIST *list )
{
	FB_LISTELEM *elem;

	/* take from free list */
	elem = list->fhead;
	if( elem == NULL )
		return NULL;

	list->fhead = elem->next;

    /* add to entry used list */
    fb_hListDynElemAdd( list, elem );

	return elem;
}

/** Free a list element.
 *
 * This function frees a list element by removing it from the list of
 * used elements and adding it to the list of free elements
 * ( struct _FB_LIST::fhead ). It also decreses the number of used
 * elements ( struct _FB_LIST::cnt ).
 *
 * @param list      Pointer to the list structure.
 * @param elem      List element to add to the list of free elements.
 */
void fb_hListFreeElem( FB_LIST *list, FB_LISTELEM *elem )
{
    /* remove entry from the list of used elements */
    fb_hListDynElemRemove( list, elem );

	/* add to free list */
	elem->next = list->fhead;
	list->fhead = elem;
}
