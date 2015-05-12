/' gdbm.h  -  The include file for dbm users.  '/

/'  This file is part of GDBM, the GNU data base manager, by Philip A. Nelson.
    Copyright (C) 1990, 1991, 1993  Free Software Foundation, Inc.

    GDBM is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
    any later version.

    GDBM is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GDBM; see the file COPYING.  If not, write to
    the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

    You may contact the author by:
       e-mail:  phil@cs.wwu.edu
      us-mail:  Philip A. Nelson
                Computer Science Department
                Western Washington University
                Bellingham, WA 98226
       
************************************************************************'/

/' Protection for multiple includes. '/
#ifndef _GDBM_H_
#define _GDBM_H_

#inclib "gdbm"

Type gdbm_error As Integer		/' For compatibilities sake. '/
Extern gdbm_errno As gdbm_error


/' Parameters to gdbm_open for READERS, WRITERS, and WRITERS who
   can create the database. '/
#define  GDBM_READER  0		/' A reader. '/
#define  GDBM_WRITER  1		/' A writer. '/
#define  GDBM_WRCREAT 2		/' A writer.  Create the db if needed. '/
#define  GDBM_NEWDB   3		/' A writer.  Always create a new db. '/
#define  GDBM_FAST    &H10	/' Write fast! => No fsyncs.  OBSOLETE. '/
#define  GDBM_SYNC    &H20	/' Sync operations to the disk. '/
#define  GDBM_NOLOCK  &H40	/' Don't do file locking operations. '/

/' Parameters to gdbm_store for simple insertion or replacement in the
   case that the key is already in the database. '/
#define  GDBM_INSERT  0		/' Never replace old data with new. '/
#define  GDBM_REPLACE 1		/' Always replace old data with new. '/

/' Parameters to gdbm_setopt, specifing the type of operation to perform. '/
#define  GDBM_CACHESIZE 1       /' Set the cache size. '/
#define  GDBM_FASTMODE  2       /' Toggle fast mode.  OBSOLETE. '/
#define  GDBM_SYNCMODE	3	/' Turn on or off sync operations. '/
#define  GDBM_CENTFREE  4	/' Keep all free blocks in the header. '/
#define  GDBM_COALESCEBLKS 5	/' Attempt to coalesce free blocks. '/

/' The data and key structure.  This structure is defined for compatibility. '/
Type datum
	
  Dim dptr As zstring Ptr
	Dim dsize As Integer

End Type


/' The file information header. This is good enough for most applications. '/
Type _GDBMFILE 
  
  Dim dummy(0 To 9) As Integer

End Type

Type GDBM_FILE As _GDBMFILE Ptr

/' External variable, the gdbm build release string. '/
Extern gdbm_version As ZString Ptr

Extern "C"

/' These are the routines! '/

/'name = name of the file to open
  block_size = block size to use for the file (512 being a good value to use)
  mode = file permissions for the file to create (as when using chmod)
  fatal_func = a function that will get called when something goes wrong.
               you can pass 0 (gdbm will use a default function)
'/
Declare Function gdbm_open (ByVal name As ZString Ptr, ByVal block_size As Integer, _
                            ByVal flags As Integer, ByVal mode As Integer, _
                            ByVal fatal_func As Sub CDECL()) As GDBM_FILE 
Declare Sub gdbm_close(ByVal database As GDBM_FILE)
'In the next declaration, the value of flag should be either GDBM_REPLACE or GDBM_INSERT
Declare Function gdbm_store (ByVal database As GDBM_FILE, ByVal key As datum, _
                             ByVal content As datum, ByVal flag As Integer) As Integer
'gdbm_fetch allocates data for the returned datum using malloc. You have to free this memory
'using free(it's prototype is in inc/crt/stdlib.bi)
Declare Function gdbm_fetch (ByVal database As GDBM_FILE, Byref key As datum) As datum
Declare Function gdbm_delete (ByVal database As GDBM_FILE, ByVal key As datum) As Integer
'gdbm_firstkey allocates data for the returned datum using malloc. You have to free this memory
'using free(it's prototype is in stdlib.bi)
Declare Function gdbm_firstkey (ByVal database As GDBM_FILE) As datum
'gdbm_nextkey allocates data for the returned datum using malloc. You have to free this memory
'using free(it's prototype is in stdlib.bi)
Declare Function gdbm_nextkey (ByVal database As GDBM_FILE, ByVal key As datum) As datum
Declare Function gdbm_reorganize (ByVal database As GDBM_FILE) As Integer
Declare Sub gdbm_sync_(ByVal database As GDBM_FILE)
Declare Function gdbm_exists (ByVal database As GDBM_FILE, ByVal key As datum) As Integer
Declare Function gdbm_setopt (ByVal database As GDBM_FILE, As Integer, As Integer Ptr, As Integer) As Integer
Declare Function gdbm_fdesc (ByVal database As GDBM_FILE) As Integer
Declare Function gdbm_strerror(ByVal error_number As gdbm_error) As ZString Ptr

#define	GDBM_NO_ERROR		0
#define	GDBM_MALLOC_ERROR	1
#define	GDBM_BLOCK_SIZE_ERROR	2
#define	GDBM_FILE_OPEN_ERROR	3
#define	GDBM_FILE_WRITE_ERROR	4
#define	GDBM_FILE_SEEK_ERROR	5
#define	GDBM_FILE_READ_ERROR	6
#define	GDBM_BAD_MAGIC_NUMBER	7
#define	GDBM_EMPTY_DATABASE	8
#define	GDBM_CANT_BE_READER	9
#define	GDBM_CANT_BE_WRITER	10
#define	GDBM_READER_CANT_DELETE	11
#define	GDBM_READER_CANT_STORE	12
#define	GDBM_READER_CANT_REORGANIZE	13
#define	GDBM_UNKNOWN_UPDATE	14
#define	GDBM_ITEM_NOT_FOUND	15
#define	GDBM_REORGANIZE_FAILED	16
#define	GDBM_CANNOT_REPLACE	17
#define	GDBM_ILLEGAL_DATA	18
#define	GDBM_OPT_ALREADY_SET	19
#define	GDBM_OPT_ILLEGAL	20

End Extern



#endif
