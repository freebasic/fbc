/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * list.c -- generic internal lists based on static arrays
 *
 * chng: oct/2004 written [v1ctor]
 *       feb/2005 moved into a separated generic module [lillo]
 *
 */

#include <malloc.h>
#include "fb.h"

static FB_STR_TMPDESCLIST tmpdsList = { 0 };

static FB_STR_TMPDESC fb_tmpdsTB[FB_STR_TMPDESCRIPTORS] = { 0 };

/*:::::*/
void fb_hListInit( FB_LIST *list, void *table, int elem_size, int size )
{
	int i;
	FB_LISTELEM *next;
	unsigned char *elem = (unsigned char *)table;
	
	list->head = NULL;
	list->tail = NULL;
	list->fhead = (FB_LISTELEM *)elem;
	list->cnt = 0;
	
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

/*:::::*/
FB_LISTELEM *fb_hListAllocElem( FB_LIST *list )
{
	FB_LISTELEM *elem;

	/* take from free list */
	elem = list->fhead;
	if( elem == NULL )
		return NULL;

	list->fhead = elem->next;

	/* add to entry used list */
	if( list->tail != NULL )
		list->tail->next = elem;
	else
		list->head = elem;

	elem->prev = list->tail;
	elem->next = NULL;

	list->tail = elem;

	++list->cnt;

	return elem;
}

/*:::::*/
void fb_hListFreeElem( FB_LIST *list, FB_LISTELEM *elem )
{
	/* del from used list */
	if( elem->prev != NULL )
		elem->prev->next = elem->next;
	else
		list->head = elem->next;

	if( elem->next != NULL )
		elem->next->prev = elem->prev;
	else
		list->tail = elem->prev;

	/* add to free list */
	elem->prev = NULL;
	elem->next = list->fhead;
	list->fhead = elem;

	--list->cnt;
}
