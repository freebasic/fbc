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
 * profile.c -- profiling functions
 *
 * chng: apr/2005 written [lillo]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "fb.h"

#define MAIN_PROC_NAME		"(main)"
#define PROC_TABLE_SIZE		512
#define CALL_TABLE_SIZE		2048
#define PROFILE_FILE		"profile.txt"


typedef struct _PROC {
	const char *name;
	struct _PROC *next;
} PROC;

typedef struct _CALL {
	const char *name;
	const char *fromproc;
	double time;
	double totaltime;
	struct _CALL *next;
} CALL;

static PROC proc_table[PROC_TABLE_SIZE] = { { 0 } };
static CALL call_table[CALL_TABLE_SIZE] = { { 0 } };

static FB_TLSENTRY cur_proc;
static double start_prog_time, end_prog_time;
static char launch_time[32];


/*:::::*/
static void add_proc( const char *procname )
{
	PROC *proc, *last = NULL;
	const char *p;
	int hash = 0;
	
	for( p = procname; *p; p++ )
		hash = ((hash << 3) | (hash >> 29)) ^ (int)(*p);
	hash &= (PROC_TABLE_SIZE - 1);
	proc = &proc_table[hash];
	
	while( (proc) && (proc->name) ) {
		if( !strcmp( procname, proc->name ) )
			return;
		last = proc;
		proc = proc->next;
	}
	if( !proc ) {
		proc = (PROC *)malloc( sizeof(PROC) );
		proc->next = NULL;
		last->next = proc;
	}
	proc->name = procname;
}

/*:::::*/
static CALL *add_call( const char *procname, const char *fromprocname )
{
	CALL *call, *last = NULL;
	const char *p;
	int hash = 0;
	
	for( p = procname; *p; p++ )
		hash = ((hash << 3) | (hash >> 29)) ^ (int)(*p);
	for( p = fromprocname; *p; p++ )
		hash = ((hash << 3) | (hash >> 29)) ^ (int)(*p);
	hash &= (CALL_TABLE_SIZE - 1);
	call = &call_table[hash];
	
	while( (call) && (call->name) ) {
		if( (!strcmp( procname, call->name )) && (!strcmp( fromprocname, call->fromproc )) )
			return call;
		last = call;
		call = call->next;
	}
	if( !call ) {
		call = (CALL *)malloc( sizeof(CALL) );
		call->next = NULL;
		last->next = call;
	}
	call->name = procname;
	call->fromproc = fromprocname;
	call->totaltime = 0.0;
	
	return call;
}

/*:::::*/
static int string_sorter( const void *e1, const void *e2 )
{
	const unsigned char *s1 = *(const unsigned char **)e1;
	const unsigned char *s2 = *(const unsigned char **)e2;
	int len, len1, len2;
	
	len1 = strlen(s1);
	len2 = strlen(s2);
	len = (len1 <= len2) ? len1 : len2;
	
	for( ; len; len--, s1++, s2++ )
		if( *s1 != *s2 )
			return ((*s1 > *s2) ? 1: -1);
	if( len1 != len2 )
		return (len1 < len2? -1: 1);
	else
		return 0;
}

/*:::::*/
static int call_sorter( const void *e1, const void *e2 )
{
	CALL *c1 = (CALL *)e1;
	CALL *c2 = (CALL *)e2;
	
	if (c1->totaltime > c2->totaltime)
		return -1;
	else if (c1->totaltime < c2->totaltime)
		return 1;
	else
		return 0;
}

/*:::::*/
void fb_ProfileSetProc( const char *procname )
{
	if( !procname )
		procname = MAIN_PROC_NAME;
	
	FB_LOCK();
	
	add_proc( procname );
	
	FB_UNLOCK();
	
	FB_TLSSET(cur_proc, procname);
}

/*:::::*/
void *fb_ProfileStartCall( const char *procname )
{
	CALL *c;
	const char *curprocname;
	
	curprocname = (const char *)FB_TLSGET(cur_proc);
	
	FB_LOCK();
	
	c = add_call( procname, curprocname );
	
	FB_TLSSET( cur_proc, procname );
	
	c->time = fb_Timer();
	
	FB_UNLOCK();
	
	return (void *)c;
}

/*:::::*/
void fb_ProfileEndCall( void *call )
{
	CALL *c;
	double end_time;
	
	end_time = fb_Timer();
	
	FB_LOCK();
	
	c = (CALL *)call;
	c->totaltime += ( end_time - c->time );
	FB_TLSSET( cur_proc, c->fromproc );
	
	FB_UNLOCK();
}

/*:::::*/
void fb_ProfileInit( void )
{
	time_t 		rawtime = { 0 };
  	struct tm	*ptm = { 0 };

#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	cur_proc = TlsAlloc();
#elif defined(TARGET_LINUX)
	pthread_key_create( &cur_proc, NULL );
#endif
#endif

	add_proc( MAIN_PROC_NAME );
	FB_TLSSET( cur_proc, MAIN_PROC_NAME );

  	time( &rawtime );
  	ptm = localtime( &rawtime );

    sprintf( launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );
	
	start_prog_time = fb_Timer();
}


/*:::::*/
void fb_ProfileEnd( void )
{
	char exename[256];
	int i, j, len;
	FILE *f;
	PROC *p, *aux_p;
	CALL *c, *aux_c, *calls = NULL;
	double totaltime;
	const char **procs = NULL;
	int num_calls = 0, num_procs = 0;
	
	end_prog_time = fb_Timer();
	totaltime = end_prog_time - start_prog_time;
	
#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	TlsFree(cur_proc);
#elif defined(TARGET_LINUX)
	pthread_key_delete( &cur_proc );
#endif
#endif
	
	f = fopen( PROFILE_FILE, "w" );
	fprintf( f, "Profiling results:\n"
			    "------------------\n\n" );
	fb_hGetExeName( exename, 255 );
	fprintf( f, "Executable name: %s\n", exename );
	fprintf( f, "Launched on: %s\n", launch_time );
	fprintf( f, "Total program execution time: %5.4g seconds\n\n", totaltime );
	fprintf( f, "Per function timings:\n\n" );
	fprintf( f, "        Function:                               Time:\n" );
	
	for( i = 0; i < PROC_TABLE_SIZE; i++ ) {
		p = &proc_table[i];
		while( (p) && (p->name) ) {
			num_procs++;
			procs = realloc(procs, sizeof(char *) * num_procs);
			procs[num_procs-1] = p->name;
			p = p->next;
		}
	}
	qsort( procs, num_procs, sizeof(char *), string_sorter );
	
	for( i = 0; i < num_procs; i++ ) {
		if( i )
			fprintf( f, "\n" );
		fprintf( f, "%s\n", procs[i] );
		calls = NULL;
		num_calls = 0;
		for( j = 0; j < CALL_TABLE_SIZE; j++ ) {
			c = &call_table[j];
			while( (c) && (c->name) ) {
				if( !strcmp( c->fromproc, procs[i] ) ) {
					num_calls++;
					calls = realloc(calls, sizeof(CALL) * num_calls);
					calls[num_calls-1].name = c->name;
					calls[num_calls-1].totaltime = c->totaltime;
				}
				c = c->next;
			}
		}
		qsort( calls, num_calls, sizeof(CALL), call_sorter );
		for( j = 0; j < num_calls; j++ ) {
			len = fprintf( f, "        %s", calls[j].name );
			for( len = 48 - len; len; len-- )
				fprintf( f, " " );
			fprintf( f, "%5.5f (%03.2f%%)\n", calls[j].totaltime, (calls[j].totaltime * 100.0) / totaltime );
		}
		free( calls );
	}
	free( procs );
	
	fprintf( f, "\n\nGlobal timings:\n\n" );
	calls = NULL;
	num_calls = 0;
	for( i = 0; i < CALL_TABLE_SIZE; i++ ) {
		c = &call_table[i];
		while( (c) && (c->name) ) {
			for( j = 0; j < num_calls; j++ ) {
				if( !strcmp( calls[j].name, c->name ) )
					break;
			}
			if( j == num_calls ) {
				num_calls++;
				calls = realloc(calls, sizeof(CALL) * num_calls);
				calls[num_calls-1].name = c->name;
				calls[num_calls-1].totaltime = c->totaltime;
			}
			else
				calls[j].totaltime += c->totaltime;
			c = c->next;
		}
	}
	qsort( calls, num_calls, sizeof(CALL), call_sorter );
	for( i = 0; i < num_calls; i++ ) {
		len = fprintf( f, "%s", calls[i].name );
		for( len = 48 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%5.5f (%03.2f%%)\n", calls[i].totaltime, (calls[i].totaltime * 100.0) / totaltime );
	}
	free( calls );
	
	fclose( f );

	for( i = 0; i < PROC_TABLE_SIZE; i++ ) {
		p = proc_table[i].next;
		while( p ) {
			aux_p = p->next;
			free( p );
			p = aux_p;
		}
	}
	for( i = 0; i < CALL_TABLE_SIZE; i++ ) {
		c = call_table[i].next;
		while( c ) {
			aux_c = c->next;
			free( c );
			c = aux_c;
		}
	}
}
