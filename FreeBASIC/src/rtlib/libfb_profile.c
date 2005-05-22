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

typedef struct FBPROC {
	const char *name;
	struct FBPROC *parent;
	double time;
	double total_time;
	struct FBPROC *child[MAX_CHILDREN];
	struct FBPROC *next;
} FBPROC;

typedef struct BIN {
	FBPROC fbproc[BIN_SIZE];
	int next_free;
	struct BIN *next;
} BIN;


static BIN *bin_head = NULL;
static FB_TLSENTRY cur_proc;
static FBPROC *main_proc;
static char launch_time[32];


static FBPROC *alloc_proc(void)
{
	BIN *bin;
	FBPROC *proc;
	
	if ((!bin_head) || (bin_head->next_free >= BIN_SIZE)) {
		bin = (BIN *)calloc(1, sizeof(BIN));
		bin->next = bin_head;
		bin_head = bin;
	}
	
	proc = &bin_head->fbproc[bin_head->next_free];
	bin_head->next_free++;

	return proc;
}


/*:::::*/
void *fb_ProfileStartCall( const char *procname )
{
	FBPROC *orig_parent_proc, *parent_proc, *proc;
	const char *p;
	unsigned int i, hash = 0, offset = 1;
	
	orig_parent_proc = parent_proc = (FBPROC *)FB_TLSGET(cur_proc);
	
	FB_LOCK();
	
	for (p = procname; *p; p += 4 )
		hash = ((hash << 3) | (hash >> 29)) ^ (*(unsigned int *)p);
	hash %= MAX_CHILDREN;
	if (hash)
		offset = MAX_CHILDREN - hash;
	for (;;) {
		for (i = 0; i < MAX_CHILDREN; i++) {
			proc = parent_proc->child[hash];
			if (proc) {
				if (!strcmp(proc->name, procname))
					goto fill_proc;
				hash = (hash + offset) % MAX_CHILDREN;
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
		if (!parent_proc->next)
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
void fb_ProfileEndCall( void *p )
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
static int name_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;

	return strcmp(p1->name, p2->name);
}


/*:::::*/
static int time_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;
	
	if (p1->total_time > p2->total_time)
		return -1;
	else if (p1->total_time < p2->total_time)
		return 1;
	else
		return 0;
}


/*:::::*/
static void add_proc(FBPROC ***array, int *size, FBPROC *proc)
{
	FBPROC **a = *array;
	int s = *size;
	a = (FBPROC **)realloc(a, (s + 1) * sizeof(FBPROC *));
	a[s] = proc;
	(*size)++;
	*array = a;
}


/*:::::*/
void fb_ProfileInit( void )
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

  	time( &rawtime );
  	ptm = localtime( &rawtime );

	sprintf( launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );

	main_proc->time = fb_Timer();
}

/*:::::*/
void fb_ProfileEnd( void )
{
	char exename[256];
	int i, j, len;
	FILE *f;
	FBPROC **parent_proc_list = NULL, **proc_list = NULL, *proc;
	int parent_proc_size = 0, proc_size = 0;

	main_proc->total_time = fb_Timer() - main_proc->time;
	
#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	TlsFree(cur_proc);
#elif defined(TARGET_LINUX)
	pthread_key_delete( cur_proc );
#endif
#endif
	
	f = fopen( PROFILE_FILE, "w" );
	fprintf( f, "Profiling results:\n"
			    "------------------\n\n" );
	fb_hGetExeName( exename, 255 );
	fprintf( f, "Executable name: %s\n", exename );
	fprintf( f, "Launched on: %s\n", launch_time );
	fprintf( f, "Total program execution time: %5.4g seconds\n\n", main_proc->total_time );

	fprintf( f, "Per function timings:\n\n" );
	fprintf( f, "        Function:                               Time:         Total%%:   Proc%%:" );
	add_proc(&parent_proc_list, &parent_proc_size, main_proc);
	for (proc = main_proc; proc; proc = proc->next) {
		for (i = 0; i < MAX_CHILDREN; i++) {
			if (proc->child[i])
				add_proc(&parent_proc_list, &parent_proc_size, proc->child[i]);
		}
	}
	printf("%d functions called by main\n", parent_proc_size);
	qsort(parent_proc_list, parent_proc_size, sizeof(FBPROC *), name_sorter);
	for( i = 0; i < parent_proc_size; i++ ) {
		proc = parent_proc_list[i];
		len = fprintf( f, "\n\n%s", proc->name );
		for( len = 50 - len; len; len-- )
			fprintf( f, " " );
		len = fprintf( f, "%5.5f", proc->total_time );
		for( len = 14 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%03.2f%%\n\n", (proc->total_time * 100.0) / main_proc->total_time );
		for (proc = parent_proc_list[i]; proc; proc = proc->next) {
			for (j = 0; j < MAX_CHILDREN; j++) {
				if (proc->child[j])
					add_proc(&proc_list, &proc_size, proc->child[j]);
			}
		}
		qsort(proc_list, proc_size, sizeof(FBPROC *), time_sorter);
		for( j = 0; j < proc_size; j++ ) {
			proc = proc_list[j];
			len = fprintf( f, "        %s", proc->name );
			for( len = 48 - len; len; len-- )
				fprintf( f, " " );
			len = fprintf( f, "%5.5f", proc->total_time );
			for( len = 14 - len; len; len-- )
				fprintf( f, " " );
			len = fprintf( f, "%03.2f%%", (proc->total_time * 100.0) / main_proc->total_time );
			for( len = 10 - len; len; len-- )
				fprintf( f, " " );
			fprintf( f, "%03.2f%%\n", (parent_proc_list[i]->total_time > 0.0) ?
				(proc->total_time * 100.0) / parent_proc_list[i]->total_time : 0.0 );
		}
		free(proc_list);
		proc_list = NULL;
		proc_size = 0;
	}

	fclose( f );



#if 0
	PROFPROC *p, *aux_p;
	CALL *c, *aux_c, *calls = NULL;
	double totaltime, proctime;
	const char **procs = NULL;
	int num_calls = 0, num_procs = 0;
	
	main_proc->total_time = fb_Timer() - main_proc->time;
	
#ifdef MULTITHREADED
#ifdef TARGET_WIN32
	TlsFree(cur_proc);
#elif defined(TARGET_LINUX)
	pthread_key_delete( cur_proc );
#endif
#endif
	
	f = fopen( PROFILE_FILE, "w" );
	fprintf( f, "Profiling results:\n"
			    "------------------\n\n" );
	fb_hGetExeName( exename, 255 );
	fprintf( f, "Executable name: %s\n", exename );
	fprintf( f, "Launched on: %s\n", launch_time );
	fprintf( f, "Total program execution time: %5.4g seconds\n\n", main_proc->totaltime );
	fprintf( f, "Per function timings:\n\n" );
	fprintf( f, "        Function:                               Time:         Total%%:   Proc%%:" );
	
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
		if( strcmp( procs[i], MAIN_PROC_NAME ) ) {
			proctime = 0.0;
			for( j = 0; j < CALL_TABLE_SIZE; j++ ) {
				c = &call_table[j];
				while( (c) && (c->name) ) {
					if( !strcmp( c->name, procs[i] ) )
						proctime += c->totaltime;
					c = c->next;
				}
			}
		}
		else
			proctime = totaltime;
		len = fprintf( f, "\n\n%s", procs[i] );
		for( len = 50 - len; len; len-- )
			fprintf( f, " " );
		len = fprintf( f, "%5.5f", proctime );
		for( len = 14 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%03.2f%%\n\n", (proctime * 100.0) / totaltime );
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
			len = fprintf( f, "%5.5f", calls[j].totaltime );
			for( len = 14 - len; len; len-- )
				fprintf( f, " " );
			len = fprintf( f, "%03.2f%%", (calls[j].totaltime * 100.0) / totaltime );
			for( len = 10 - len; len; len-- )
				fprintf( f, " " );
			fprintf( f, "%03.2f%%\n", (proctime > 0.0) ? (calls[j].totaltime * 100.0) / proctime : 0.0 );
		}
		free( calls );
	}
	free( procs );
	
	fprintf( f, "\n\n\nGlobal timings:\n\n" );
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
			else if( strcmp( c->name, c->fromproc ) )
				calls[j].totaltime += c->totaltime;
			c = c->next;
		}
	}
	qsort( calls, num_calls, sizeof(CALL), call_sorter );
	for( i = 0; i < num_calls; i++ ) {
		len = fprintf( f, "%s", calls[i].name );
		for( len = 48 - len; len; len-- )
			fprintf( f, " " );
		fprintf( f, "%5.5f  (%03.2f%%)\n", calls[i].totaltime, (calls[i].totaltime * 100.0) / totaltime );
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
#endif
}
