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
 * profile.c -- profiling functions
 *
 * chng: apr/2005 written [lillo]
 *       may/2005 rewritten to properly support recursive calls [lillo]
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "fb.h"

#define MAIN_PROC_NAME		"(main)  "
#define PROFILE_FILE		"profile.txt"
#define MAX_CHILDREN		257
#define BIN_SIZE			1024

#ifdef TARGET_LINUX
#define PATH_SEP		"/"
#else
#define PATH_SEP		"\\"
#endif


typedef struct _FBPROC {
	const char *name;
	struct _FBPROC *parent;
	double time;
	double total_time;
	struct _FBPROC *child[MAX_CHILDREN];
	struct _FBPROC *next;
} FBPROC;

typedef struct _BIN {
	FBPROC fbproc[BIN_SIZE];
	int next_free;
	struct _BIN *next;
} BIN;


static BIN *bin_head = NULL;
static FB_TLSENTRY cur_proc;
static FBPROC *main_proc;
static char launch_time[32];


/*:::::*/
static int strcmp4(const char *s1, const char *s2)
{
	
	while ((*s1) && (*s2)) {
		if (*(int *)s1 != *(int *)s2)
			return -1;
		s1 += 4;
		s2 += 4;
	}
	if ((*s1) || (*s2))
		return -1;
	return 0;
}


/*:::::*/
static FBPROC *alloc_proc( void )
{
	BIN *bin;
	FBPROC *proc;
	
	if ( ( !bin_head ) || ( bin_head->next_free >= BIN_SIZE ) ) {
		bin = (BIN *)calloc( 1, sizeof(BIN) );
		bin->next = bin_head;
		bin_head = bin;
	}
	
	proc = &bin_head->fbproc[bin_head->next_free];
	bin_head->next_free++;

	return proc;
}


/*:::::*/
static int name_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;

	return strcmp( p1->name, p2->name );
}


/*:::::*/
static int time_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;
	
	if ( p1->total_time > p2->total_time )
		return -1;
	else if ( p1->total_time < p2->total_time )
		return 1;
	else
		return 0;
}


/*:::::*/
static void add_proc( FBPROC ***array, int *size, FBPROC *proc )
{
	FBPROC **a = *array;
	int s = *size;
	a = (FBPROC **)realloc( a, (s + 1) * sizeof(FBPROC *) );
	a[s] = proc;
	(*size)++;
	*array = a;
}


/*:::::*/
static void find_all_procs( FBPROC *proc, FBPROC ***array, int *size )
{
	FBPROC *p, **a;
	int add_self = TRUE;
	int i;
	
	a = *array;
	for ( i = 0; i < *size; i++ ) {
		if ( !strcmp4( a[i]->name, proc->name ) )
			add_self = FALSE;
	}
	if ( add_self )
		add_proc( array, size, proc );
	for ( p = proc; p; p = p->next ) {
		for ( i = 0; i < MAX_CHILDREN; i++ ) {
			if ( p->child[i] )
				find_all_procs( p->child[i], array, size );
		}
	}
}


/*:::::*/
FBCALL void *fb_ProfileBeginCall( const char *procname )
{
	FBPROC *orig_parent_proc, *parent_proc, *proc;
	const char *p;
	unsigned int i, hash = 0, offset = 1;
	
	orig_parent_proc = parent_proc = (FBPROC *)FB_TLSGET( cur_proc );
	
	FB_LOCK();
	
	for ( p = procname; *p; p += 4 )
		hash = ( (hash << 3) | (hash >> 29) ) ^ ( *(unsigned int *)p );
	hash %= MAX_CHILDREN;
	if ( hash )
		offset = MAX_CHILDREN - hash;
	for (;;) {
		for ( i = 0; i < MAX_CHILDREN; i++ ) {
			proc = parent_proc->child[hash];
			if ( proc ) {
				if ( !strcmp4( proc->name, procname ) )
					goto fill_proc;
				hash = ( hash + offset ) % MAX_CHILDREN;
			}
			else {
				proc = alloc_proc();
				proc->name = procname;
				proc->total_time = 0.0;
				proc->parent = orig_parent_proc;
				parent_proc->child[hash] = proc;
				goto fill_proc;
			}
		}
		if ( !parent_proc->next )
			parent_proc->next = alloc_proc();
		parent_proc = parent_proc->next;
	}
fill_proc:

	FB_TLSSET( cur_proc, proc );
	
	proc->time = fb_Timer();
	
	FB_UNLOCK();
	
	return (void *)proc;
}


/*:::::*/
FBCALL void fb_ProfileEndCall( void *p )
{
	FBPROC *proc;
	double end_time;
	
	end_time = fb_Timer();
	
	FB_LOCK();
	
	proc = (FBPROC *)p;
	proc->total_time += ( end_time - proc->time );
	FB_TLSSET( cur_proc, proc->parent );
	
	FB_UNLOCK();
}


/*:::::*/
FBCALL void fb_InitProfile( void )
{
	time_t rawtime = { 0 };
  	struct tm *ptm = { 0 };

#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	cur_proc = TlsAlloc();
#elif defined(TARGET_LINUX)
	pthread_key_create( &cur_proc, NULL );
#endif
#endif

	main_proc = alloc_proc();
	main_proc->name = MAIN_PROC_NAME;
	
	FB_TLSSET( cur_proc, main_proc );

    /* guard by global lock because time/localtime might not be thread-safe */
    FB_LOCK();
  	time( &rawtime );
    ptm = localtime( &rawtime );
	sprintf( launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );
    FB_UNLOCK();

	main_proc->time = fb_Timer();
}


/*:::::*/
FBCALL void fb_EndProfile( void )
{
	char buffer[MAX_PATH], *p;
	int i, j, len, skip_proc;
	BIN *bin;
	FILE *f;
	FBPROC **parent_proc_list = NULL, **proc_list = NULL, *proc, *parent_proc;
	int parent_proc_size = 0, proc_size = 0;

	main_proc->total_time = fb_Timer() - main_proc->time;
	
#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	TlsFree( cur_proc );
#elif defined(TARGET_LINUX)
	pthread_key_delete( cur_proc );
#endif
#endif
	
	p = fb_hGetExePath( buffer, MAX_PATH-1 );
	if( !p )
		p = PROFILE_FILE;
	else {
		strcat( buffer, PATH_SEP PROFILE_FILE );
		p = buffer;
	}
	f = fopen( p, "w" );
	fprintf( f, "Profiling results:\n"
			    "------------------\n\n" );
	fb_hGetExeName( buffer, MAX_PATH-1 );
	fprintf( f, "Executable name: %s\n", buffer );
	p = fb_hGetCommandLine( );
#ifdef TARGET_WIN32
	/* exe paths with white-spaces are quoted on Windows */
	if( p[0] == '"' )
	{
		p = strchr( &p[1], '"' );
		if( p )
			p++;
	}
#endif
	if( p ) {
		/* skip argv[0] */
		p = strchr( p, ' ' );
		if( p )
			p++;
	}
	if( ( p ) && ( *p ) )
		fprintf( f, "Passed argument(s): %s\n", p );
	fprintf( f, "Launched on: %s\n", launch_time );
	fprintf( f, "Total program execution time: %5.4g seconds\n\n", main_proc->total_time );

	fprintf( f, "Per function timings:\n\n" );
	fprintf( f, "        Function:                               Time:         Total%%:   Proc%%:" );
	find_all_procs( main_proc, &parent_proc_list, &parent_proc_size );
	qsort( parent_proc_list, parent_proc_size, sizeof(FBPROC *), name_sorter );
	for( i = 0; i < parent_proc_size; i++ ) {
		parent_proc = parent_proc_list[i];
		skip_proc = TRUE;
		for ( proc = parent_proc; proc; proc = proc->next ) {
			for ( j = 0; j < MAX_CHILDREN; j++ ) {
				if ( proc->child[j] ) {
					add_proc( &proc_list, &proc_size, proc->child[j] );
					skip_proc = FALSE;
				}
			}
		}
		if ( skip_proc )
			continue;
		len = fprintf( f, "\n\n%s", parent_proc->name );
		for( len = 50 - len; len; len-- )
			fprintf( f, " " );
		len = fprintf( f, "%5.5f", parent_proc->total_time );
		for( len = 14 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%03.2f%%\n\n", (parent_proc->total_time * 100.0) / main_proc->total_time );
		qsort( proc_list, proc_size, sizeof(FBPROC *), time_sorter );
		for( j = 0; j < proc_size; j++ ) {
			proc = proc_list[j];
			len = fprintf( f, "        %s", proc->name );
			for( len = 48 - len; len; len-- )
				fprintf( f, " " );
			len = fprintf( f, "%5.5f", proc->total_time );
			for( len = 14 - len; len; len-- )
				fprintf( f, " " );
			len = fprintf( f, "%03.2f%%", ( proc->total_time * 100.0 ) / main_proc->total_time );
			for( len = 10 - len; len; len-- )
				fprintf( f, " " );
			fprintf( f, "%03.2f%%\n", ( parent_proc_list[i]->total_time > 0.0 ) ?
				( proc->total_time * 100.0 ) / parent_proc_list[i]->total_time : 0.0 );
		}
		free( proc_list );
		proc_list = NULL;
		proc_size = 0;
	}
	
	fprintf( f, "\n\n\nGlobal timings:\n\n" );
	qsort( parent_proc_list, parent_proc_size, sizeof(FBPROC *), time_sorter );
	for( i = 0; i < parent_proc_size; i++ ) {
		proc = parent_proc_list[i];
		len = fprintf( f, "%s", proc->name );
		for( len = 48 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%5.5f  (%03.2f%%)\n", proc->total_time, ( proc->total_time * 100.0 ) / main_proc->total_time );
	}
	
	free( parent_proc_list );
	fclose( f );

	while ( bin_head ) {
		bin = bin_head->next;
		free( bin_head );
		bin_head = bin;
	}
}
