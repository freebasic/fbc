''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' intrinsic runtime lib file functions (OPEN, CLOSE, SEEK, GET, PUT, ... )
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

''
'' fb_FileOpen( byref s as string, byval mode as integer, byval access as integer,
''		        byval lock as integer, byval filenum as integer, byval len as integer ) as integer
data @FB_RTL_FILEOPEN,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenEncod( byref s as string, byval mode as integer, byval access as integer,
''		        	 byval lock as integer, byval filenum as integer,
''					 byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_ENCOD,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenShort( mode as string, byval filenum as integer,
''                   filename as string, byval len as integer,
''                   access_mode as string, lock_mode as string) as integer
data @FB_RTL_FILEOPEN_SHORT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 6, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE

'' fb_FileOpenCons( s as string, byval mode as integer, byval access as integer,
''		            byval lock as integer, byval filenum as integer,
''					byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_CONS,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenErr( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer,
''				   byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_ERR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenPipe( s as string, byval mode as integer, byval access as integer,
''		            byval lock as integer, byval filenum as integer,
''					byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_PIPE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenScrn( s as string, byval mode as integer, byval access as integer,
''		            byval lock as integer, byval filenum as integer,
''					byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_SCRN,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenLpt( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer,
''				   byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_LPT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileOpenCom( s as string, byval mode as integer, byval access as integer,
''		           byval lock as integer, byval filenum as integer,
''				   byval len as integer, byval encoding as zstring ptr ) as integer
data @FB_RTL_FILEOPEN_COM,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 7, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileClose	( byval filenum as integer ) as integer
data @FB_RTL_FILECLOSE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FilePut ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data @FB_RTL_FILEPUT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FilePutStr ( byval filenum as integer, byval offset as uinteger, str as any, byval strlen as integer ) as integer
data @FB_RTL_FILEPUTSTR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FilePutArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data @FB_RTL_FILEPUTARRAY,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE

'' fb_FileGet ( byval filenum as integer, byval offset as uinteger, value as any, byval valuelen as integer ) as integer
data @FB_RTL_FILEGET,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileGetStr ( byval filenum as integer, byval offset as uinteger, str as any, byval strlen as integer ) as integer
data @FB_RTL_FILEGETSTR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileGetArray ( byval filenum as integer, byval offset as uinteger, array() as any ) as integer
data @FB_RTL_FILEGETARRAY,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYDESC, FALSE

'' fb_FileTell ( byval filenum as integer ) as uinteger
data @FB_RTL_FILETELL,"", _
	 FB_DATATYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileSeek ( byval filenum as integer, byval newpos as uinteger ) as integer
data @FB_RTL_FILESEEK,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_UINT,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileStrInput ( byval bytes as integer, byval filenum as integer = 0 ) as string
data @FB_RTL_FILESTRINPUT, "", _
	 FB_DATATYPE_STRING,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0

'' fb_FileLineInput ( byval filenum as integer, _
''					  dst as any, byval dstlen as integer, byval fillrem as integer = 1 ) as integer
data @FB_RTL_FILELINEINPUT, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,1

'' fb_FileLineInputWstr ( byval filenum as integer, _
''					  	  byval dst as wstring ptr, byval maxchars as integer ) as integer
data @FB_RTL_FILELINEINPUTWSTR, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_LineInput ( text as string, _
''				  dst as any, byval dstlen as integer, byval fillrem as integer = 1, _
''				  byval addquestion as integer, byval addnewline as integer ) as integer
data @FB_RTL_CONSOLELINEINPUT, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 6, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,1

'' fb_LineInputWstr ( byval text as wstring ptr, _
''				      byval dst as wstring ptr, byval max_chars as integer,
''				      byval addquestion as integer, byval addnewline as integer ) as integer
data @FB_RTL_CONSOLELINEINPUTWSTR, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileInput ( byval filenum as integer ) as integer
data @FB_RTL_FILEINPUT, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ConsoleInput ( text as string,  byval addquestion as integer, _
''				     byval addnewline as integer ) as integer
data @FB_RTL_CONSOLEINPUT, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_InputByte ( x as byte ) as void
data @FB_RTL_INPUTBYTE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_BYTE,FB_PARAMMODE_BYREF, FALSE

'' fb_InputShort ( x as short ) as void
data @FB_RTL_INPUTSHORT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_SHORT,FB_PARAMMODE_BYREF, FALSE

'' fb_InputInt ( x as integer ) as void
data @FB_RTL_INPUTINT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYREF, FALSE

'' fb_InputLongint ( x as longint ) as void
data @FB_RTL_INPUTLONGINT,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_LONGINT,FB_PARAMMODE_BYREF, FALSE

'' fb_InputSingle ( x as single ) as void
data @FB_RTL_INPUTSINGLE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_SINGLE,FB_PARAMMODE_BYREF, FALSE

'' fb_InputDouble ( x as double ) as void
data @FB_RTL_INPUTDOUBLE,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_DOUBLE,FB_PARAMMODE_BYREF, FALSE

'' fb_InputString ( x as any, byval strlen as integer, byval fillrem as integer = 1 ) as void
data @FB_RTL_INPUTSTR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,1

'' fb_InputWstr ( byval dst as wstring ptr, byval maxchars as integer ) as integer
data @FB_RTL_INPUTWSTR,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileLock ( byval inipos as integer, byval endpos as integer ) as integer
data @FB_RTL_FILELOCK,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0

'' fb_FileUnlock ( byval inipos as integer, byval endpos as integer ) as integer
data @FB_RTL_FILEUNLOCK,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0

'' rename ( byval oldname as zstring ptr, byval newname as zstring ptr ) as integer
data @FB_RTL_FILERENAME,"", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileWstrInput ( byval chars as integer, byval filenum as integer = 0 ) as wstring
data @"winput", "fb_FileWstrInput", _
	 FB_DATATYPE_WCHAR,FB_FUNCMODE_STDCALL, _
	 @rtlMultinput_cb, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0

'' fb_FileFree ( ) as integer
data @"freefile", "fb_FileFree", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_FileEof ( byval filenum as integer ) as integer
data @"eof", "fb_FileEof", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_FileKill ( s as string ) as integer
data @"kill", "fb_FileKill", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_STRING,FB_PARAMMODE_BYREF, FALSE

'' reset ( ) as void
data @"reset","fb_FileReset", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' lof ( byval filenum as integer ) as uinteger
data @"lof","fb_FileSize", _
	 FB_DATATYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' loc ( byval filenum as integer ) as uinteger
data @"loc","fb_FileLocation", _
	 FB_DATATYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' lpos( int ) as integer
data @"lpos", "fb_LPos", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 @rtlPrinter_cb, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' EOL
data NULL


'':::::
sub rtlFileModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlFileModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlFileOpen( byval filename as ASTNODE ptr, _
					  byval fmode as ASTNODE ptr, _
					  byval faccess as ASTNODE ptr, _
				      byval flock as ASTNODE ptr, _
				      byval filenum as ASTNODE ptr, _
				      byval flen as ASTNODE ptr, _
				      byval fencoding as ASTNODE ptr, _
				      byval isfunc as integer, _
                      byval openkind as FBOPENKIND _
                    ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, reslabel
    dim as integer doencoding

	function = NULL

	''
	doencoding = TRUE

	select case openkind
	case FB_FILE_TYPE_FILE
		if( fencoding = NULL ) then
			f = PROCLOOKUP( FILEOPEN )
			doencoding = FALSE
		else
			f = PROCLOOKUP( FILEOPEN_ENCOD )
		end if

    case FB_FILE_TYPE_CONS
		f = PROCLOOKUP( FILEOPEN_CONS )

    case FB_FILE_TYPE_ERR
		f = PROCLOOKUP( FILEOPEN_ERR )

    case FB_FILE_TYPE_PIPE
		f = PROCLOOKUP( FILEOPEN_PIPE )

    case FB_FILE_TYPE_SCRN
		f = PROCLOOKUP( FILEOPEN_SCRN )

    case FB_FILE_TYPE_LPT
		f = PROCLOOKUP( FILEOPEN_LPT )

    case FB_FILE_TYPE_COM
		f = PROCLOOKUP( FILEOPEN_COM )
	end select

	proc = astNewCALL( f )

	'' filename as string
	if( astNewARG( proc, filename ) = NULL ) then
		exit function
	end if

	'' byval mode as integer
	if( astNewARG( proc, fmode ) = NULL ) then
		exit function
	end if

	'' byval access as integer
	if( astNewARG( proc, faccess ) = NULL ) then
		exit function
	end if

	'' byval lock as integer
	if( astNewARG( proc, flock ) = NULL ) then
		exit function
	end if

	'' byval filenum as integer
	if( astNewARG( proc, filenum ) = NULL ) then
		exit function
	end if

	'' byval len as integer
	if( astNewARG( proc, flen ) = NULL ) then
		exit function
	end if

	if( doencoding ) then
		'' byval encoding as zstring ptr
		if( fencoding = NULL ) then
			fencoding = astNewCONSTi( 0, FB_DATATYPE_POINTER+FB_DATATYPE_CHAR )
		end if
		if( astNewARG( proc, fencoding ) = NULL ) then
			exit function
		end if
	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileOpenShort( byval filename as ASTNODE ptr, _
					  	   byval fmode as ASTNODE ptr, _
					  	   byval faccess as ASTNODE ptr, _
				      	   byval flock as ASTNODE ptr, _
				           byval filenum as ASTNODE ptr, _
				           byval flen as ASTNODE ptr, _
				           byval isfunc as integer _
				         ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f, reslabel

	function = NULL

	'' this is the short form of the OPEN command
	proc = astNewCALL( PROCLOOKUP( FILEOPEN_SHORT ) )

	'' mode as string
	if( astNewARG( proc, fmode ) = NULL ) then
		exit function
	end if

	'' byval filenum as integer
	if( astNewARG( proc, filenum ) = NULL ) then
		exit function
	end if

	'' filename as string
	if( astNewARG( proc, filename ) = NULL ) then
		exit function
	end if

	'' byval len as integer
	if( astNewARG( proc, flen ) = NULL ) then
		exit function
	end if

	'' faccess as string
	if( astNewARG( proc, faccess ) = NULL ) then
		exit function
	end if

	'' flock as string
	if( astNewARG( proc, flock ) = NULL ) then
		exit function
	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileClose( byval filenum as ASTNODE ptr, _
					   byval isfunc as integer _
					 ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILECLOSE ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileSeek( byval filenum as ASTNODE ptr, _
					  byval newpos as ASTNODE ptr _
					) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = FALSE

	''
    proc = astNewCALL( PROCLOOKUP( FILESEEK ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval newpos as integer
    if( astNewARG( proc, newpos ) = NULL ) then
 		exit function
 	end if

    ''
    if( env.clopt.resumeerr ) then
    	reslabel = symbAddLabel( NULL )
    	astAdd( astNewLABEL( reslabel ) )
    else
    	reslabel = NULL
    end if

    ''
    function = rtlErrorCheck( proc, reslabel, lexLineNum( ) )

end function

'':::::
function rtlFileTell( byval filenum as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILETELL ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlFilePut( byval filenum as ASTNODE ptr, _
					 byval offset as ASTNODE ptr, _
					 byval src as ASTNODE ptr, _
					 byval elements as ASTNODE ptr, _
					 byval isfunc as integer _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc, bytes
    dim as integer dtype, lgt, isstring
    dim as FBSYMBOL ptr f, reslabel

    function = NULL

	''
	dtype = astGetDataType( src )
	isstring = hIsString( dtype )
	if( isstring ) then
		f = PROCLOOKUP( FILEPUTSTR )
	else
		f = PROCLOOKUP( FILEPUT )
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	lgt = rtlCalcStrLen( src, dtype )
    else
    	lgt = rtlCalcExprLen( src )
    end if

    if( elements = NULL ) then
    	bytes = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )
    else
    	bytes = astNewBOP( AST_OP_MUL, elements, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )
    end if

    '' any pointer fields?
    if( astGetDataType( src ) = FB_DATATYPE_USERDEF ) then
    	if( symbGetUDTPtrCnt( astGetSubType( src ) ) <> 0 ) then
            hReportParamWarning( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
    end if

    '' value as any | s as string
    if( astNewARG( proc, src ) = NULL ) then
 		exit function
 	end if

    '' byval bytes as integer
   	if( astNewARG( proc, bytes ) = NULL ) then
		exit function
	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFilePutArray( byval filenum as ASTNODE ptr, _
						  byval offset as ASTNODE ptr, _
						  byval src as ASTNODE ptr, _
					 	  byval isfunc as integer _
					 	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

    function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILEPUTARRAY ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' any pointer fields?
    if( astGetDataType( src ) = FB_DATATYPE_USERDEF ) then
    	if( symbGetUDTPtrCnt( astGetSubType( src ) ) <> 0 ) then
            hReportParamWarning( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
    end if

    '' array() as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
	    	reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileGet( byval filenum as ASTNODE ptr, _
					 byval offset as ASTNODE ptr, _
					 byval dst as ASTNODE ptr, _
					 byval elements as ASTNODE ptr, _
					 byval isfunc as integer _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr proc, bytes
    dim as integer dtype, lgt, isstring
    dim as FBSYMBOL ptr f, reslabel

    function = NULL

	''
	dtype = astGetDataType( dst )
	isstring = hIsString( dtype )
	if( isstring ) then
		f = PROCLOOKUP( FILEGETSTR )
	else
		f = PROCLOOKUP( FILEGET )
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
    if( isstring ) then
    	lgt = rtlCalcStrLen( dst, dtype )
    else
    	lgt = rtlCalcExprLen( dst )
    end if

    if( elements = NULL ) then
    	bytes = astNewCONSTi( lgt, FB_DATATYPE_INTEGER )
    else
    	bytes = astNewBOP( AST_OP_MUL, elements, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ) )
    end if

    '' any pointer fields?
    if( astGetDataType( dst ) = FB_DATATYPE_USERDEF ) then
    	if( symbGetUDTPtrCnt( astGetSubType( dst ) ) <> 0 ) then
            hReportParamWarning( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
    end if

    '' value as any
    if( astNewARG( proc, dst ) = NULL ) then
 		exit function
 	end if

    '' byval bytes as integer
    if( astNewARG( proc, bytes ) = NULL ) then
 		exit function
 	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileGetArray( byval filenum as ASTNODE ptr, _
						  byval offset as ASTNODE ptr, _
						  byval dst as ASTNODE ptr, _
					 	  byval isfunc as integer _
					 	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILEGETARRAY ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    '' any pointer fields?
    if( astGetDataType( dst ) = FB_DATATYPE_USERDEF ) then
    	if( symbGetUDTPtrCnt( astGetSubType( dst ) ) <> 0 ) then
            hReportParamWarning( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
    	end if
    end if

    '' array() as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileStrInput( byval bytesexpr as ASTNODE ptr, _
						  byval filenum as ASTNODE ptr _
						) as ASTNODE ptr static

    dim as ASTNODE ptr proc

    function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILESTRINPUT ) )

    '' byval bytes as integer
    if( astNewARG( proc, bytesexpr ) = NULL ) then
 		exit function
 	end if

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    ''
    function = proc

end function

'':::::
function rtlFileLineInput( byval isfile as integer, _
						   byval expr as ASTNODE ptr, _
						   byval dstexpr as ASTNODE ptr, _
					       byval addquestion as integer, _
					       byval addnewline as integer _
					     ) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, lgt, dtype

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILELINEINPUT )
		args = 4
	else
		f = PROCLOOKUP( CONSOLELINEINPUT )
		args = 6
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "text as string "
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocStrConst( "", 0 ), 0, FB_DATATYPE_CHAR )
	end if

    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
	dtype = astGetDataType( dstexpr )
	lgt = rtlCalcStrLen( dstexpr, dtype )

	'' dst as any
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	'' byval dstlen as integer
	if( astNewARG( proc, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

	'' byval fillrem as integer
	if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_FIXSTR, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    if( args = 6 ) then
    	'' byval addquestion as integer
 		if( astNewARG( proc, astNewCONSTi( addquestion, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewARG( proc, astNewCONSTi( addnewline, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileLineInputWstr( byval isfile as integer, _
						   	   byval expr as ASTNODE ptr, _
						   	   byval dstexpr as ASTNODE ptr, _
					       	   byval addquestion as integer, _
					       	   byval addnewline as integer _
					       	 ) as integer static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, lgt, dtype

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILELINEINPUTWSTR )
		args = 3
	else
		f = PROCLOOKUP( CONSOLELINEINPUTWSTR )
		args = 5
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "byval text as wstring ptr"
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocWStrConst( "", 0 ), 0, FB_DATATYPE_WCHAR )
	end if

    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    '' always calc len before pushing the param
	dtype = astGetDataType( dstexpr )
	lgt = rtlCalcStrLen( dstexpr, dtype )

	'' byval dst as wstring ptr
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

	'' byval max_chars as integer
	if( astNewARG( proc, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
 		exit function
 	end if

    if( args = 5 ) then
    	'' byval addquestion as integer
 		if( astNewARG( proc, astNewCONSTi( addquestion, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewARG( proc, astNewCONSTi( addnewline, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInput( byval isfile as integer, _
					   byval expr as ASTNODE ptr, _
				       byval addquestion as integer, _
				       byval addnewline as integer _
				     ) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args

	function = FALSE

	''
	if( isfile ) then
		f = PROCLOOKUP( FILEINPUT )
		args = 1
	else
		f = PROCLOOKUP( CONSOLEINPUT )
		args = 3
	end if

    proc = astNewCALL( f )

    '' "byval filenum as integer" or "text as string "
    if( (isfile = FALSE) and (expr = NULL) ) then
		expr = astNewVAR( symbAllocStrConst( "", 0 ), 0, FB_DATATYPE_CHAR )
	end if

	if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

    if( args = 3 ) then
    	'' byval addquestion as integer
    	if( astNewARG( proc, astNewCONSTi( addquestion, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if

    	'' byval addnewline as integer
    	if( astNewARG( proc, astNewCONSTi( addnewline, FB_DATATYPE_INTEGER ) ) = NULL ) then
 			exit function
 		end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileInputGet( byval dstexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as integer args, lgt, dtype

	function = FALSE

	''
	args = 1
	dtype = astGetDataType( dstexpr )
	select case as const dtype
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
		f = PROCLOOKUP( INPUTSTR )
		args = 3

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( INPUTWSTR )
		args = 2

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE
		f = PROCLOOKUP( INPUTBYTE )

	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
		f = PROCLOOKUP( INPUTSHORT )

	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		f = PROCLOOKUP( INPUTINT )

	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		f = PROCLOOKUP( INPUTLONGINT )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( INPUTSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( INPUTDOUBLE )

	case FB_DATATYPE_USERDEF
		exit function							'' illegal

	case else
		if( dtype >= FB_DATATYPE_POINTER ) then	'' non-sense but..
			f = PROCLOOKUP( INPUTINT )
			dstexpr = astNewCONV( INVALID, FB_DATATYPE_UINT, NULL, dstexpr )
		end if
	end select

    proc = astNewCALL( f )

    '' always calc len before pushing the param
    if( args > 1 ) then
		lgt = rtlCalcStrLen( dstexpr, dtype )
	end if

    '' byref dst as any | byval dst as wstring ptr
    if( astNewARG( proc, dstexpr ) = NULL ) then
 		exit function
 	end if

    if( args > 1 ) then
		'' byval dstlen as integer
		if( astNewARG( proc, astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_FIXSTR, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    			exit function
    		end if
    	end if
    end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileLock( byval islock as integer, _
					  byval filenum as ASTNODE ptr, _
					  byval iniexpr as ASTNODE ptr, _
					  byval endexpr as ASTNODE ptr _
					) as integer

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f

	function = FALSE

	''
	if( islock ) then
		f = PROCLOOKUP( FILELOCK )
	else
		f = PROCLOOKUP( FILEUNLOCK )
	end if

    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval inipos as integer
    if( astNewARG( proc, iniexpr ) = NULL ) then
 		exit function
 	end if

    '' byval endpos as integer
    if( astNewARG( proc, endexpr ) = NULL ) then
 		exit function
 	end if

    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlFileRename( byval filename_new as ASTNODE ptr, _
                        byval filename_old as ASTNODE ptr, _
                        byval isfunc as integer _
                      ) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr reslabel

	function = NULL

    proc = astNewCALL( PROCLOOKUP( FILERENAME ) )

    '' byval filename_old as string
    if( astNewARG( proc, filename_old ) = NULL ) then
 		exit function
 	end if

    '' byval filename_new as integer
    if( astNewARG( proc, filename_new ) = NULL ) then
 		exit function
 	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlWidthFile ( byval fnum as ASTNODE ptr, _
					    byval width_arg as ASTNODE ptr, _
                        byval isfunc as integer _
                      ) as ASTNODE ptr

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( WIDTHFILE ) )

    '' byval fnum as integer
    if( astNewARG( proc, fnum ) = NULL ) then
    	exit function
    end if

    '' byval width_arg as integer
    if( astNewARG( proc, width_arg ) = NULL ) then
    	exit function
    end if

    if( isfunc = FALSE ) then
    	dim reslabel as FBSYMBOL ptr

    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if
end function


