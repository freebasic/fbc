''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 49 ) = _
	{ _
		/' fb_FileOpen( byref s as string, byval mode as integer, byval access as integer,
				        byval lock as integer, byval filenum as integer, _
				        byval len as integer ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenEncod( byref s as string, byval mode as integer, byval access as integer,
				        	 byval lock as integer, byval filenum as integer,
							 byval len as integer, _
							 byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_ENCOD, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenShort( byref mode as string, byval filenum as integer,
		                     byref filename as string, byval len as integer,
		                     byref access_mode as string, _
		                     byref lock_mode as string) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_SHORT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenCons( byref s as string, byval mode as integer, byval access as integer,
				            byval lock as integer, byval filenum as integer,
							byval len as integer, byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_CONS, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenErr( byref s as string, byval mode as integer, byval access as integer,
				           byval lock as integer, byval filenum as integer,
						   byval len as integer, byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_ERR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenPipe( byref s as string, byval mode as integer, byval access as integer,
				            byval lock as integer, byval filenum as integer,
							byval len as integer, _
							byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_PIPE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenScrn( byref s as string, byval mode as integer, byval access as integer,
				            byval lock as integer, byval filenum as integer,
							byval len as integer, _
							byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_SCRN, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenLpt( byref s as string, byval mode as integer, byval access as integer,
				           byval lock as integer, byval filenum as integer,
						   byval len as integer, byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_LPT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileOpenCom( byref s as string, byval mode as integer, byval access as integer,
				           byval lock as integer, byval filenum as integer,
						   byval len as integer, byval encoding as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILEOPEN_COM, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			7, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileClose	( byval filenum as integer ) as integer '/ _
		( _
			@FB_RTL_FILECLOSE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FilePut ( byval filenum as integer, byval offset as uinteger,
						value as any, byval valuelen as integer ) as integer '/ _
		( _
			@FB_RTL_FILEPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FilePutStr ( byval filenum as integer, byval offset as uinteger,
						   byref str as any, byval strlen as integer ) as integer '/ _
		( _
			@FB_RTL_FILEPUTSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FilePutArray ( byval filenum as integer, byval offset as uinteger,
							 array() as any ) as integer '/ _
		( _
			@FB_RTL_FILEPUTARRAY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileGet ( byval filenum as integer, byval offset as uinteger,
						byref value as any, byval valuelen as integer ) as integer '/ _
		( _
			@FB_RTL_FILEGET, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileGetStr ( byval filenum as integer, byval offset as uinteger,
						   byref str as any, byval strlen as integer ) as integer '/ _
		( _
			@FB_RTL_FILEGETSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileGetArray ( byval filenum as integer, byval offset as uinteger,
							 array() as any ) as integer '/ _
		( _
			@FB_RTL_FILEGETARRAY, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYDESC, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileTell ( byval filenum as integer ) as uinteger '/ _
		( _
			@FB_RTL_FILETELL, NULL, _
			FB_DATATYPE_UINT, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileSeek ( byval filenum as integer, byval newpos as uinteger ) as integer '/ _
		( _
			@FB_RTL_FILESEEK, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileStrInput ( byval bytes as integer,
							 byval filenum as integer = 0 ) as string '/ _
		( _
			@FB_RTL_FILESTRINPUT, NULL, _
			FB_DATATYPE_STRING, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_FileLineInput ( byval filenum as integer, _
							  byref dst as any, byval dstlen as integer,
							  byval fillrem as integer = 1 ) as integer '/ _
		( _
			@FB_RTL_FILELINEINPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_FileLineInputWstr ( byval filenum as integer, _
							  	  byval dst as wstring ptr,
							  	  byval maxchars as integer ) as integer '/ _
		( _
			@FB_RTL_FILELINEINPUTWSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_LineInput ( byref text as string, _
						  byref dst as any, byval dstlen as integer,
						  byval fillrem as integer = 1, byval addquestion as integer,
						  byval addnewline as integer ) as integer '/ _
		( _
			@FB_RTL_CONSOLELINEINPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			6, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_LineInputWstr ( byval text as wstring ptr, _
						      byval dst as wstring ptr, byval max_chars as integer,
						      byval addquestion as integer,
						      byval addnewline as integer ) as integer '/ _
		( _
			@FB_RTL_CONSOLELINEINPUTWSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileInput ( byval filenum as integer ) as integer '/ _
		( _
			@FB_RTL_FILEINPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ConsoleInput ( byref text as string,  byval addquestion as integer, _
						     byval addnewline as integer ) as integer '/ _
		( _
			@FB_RTL_CONSOLEINPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputByte ( x as byte ) as void '/ _
		( _
			@FB_RTL_INPUTBYTE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_BYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputUbyte ( x as ubyte ) as void '/ _
		( _
			@FB_RTL_INPUTUBYTE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_UBYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputShort ( x as short ) as void '/ _
		( _
			@FB_RTL_INPUTSHORT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputUshort ( x as ushort ) as void '/ _
		( _
			@FB_RTL_INPUTUSHORT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_USHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputInt ( x as integer ) as void '/ _
		( _
			@FB_RTL_INPUTINT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputUint ( x as uinteger ) as void '/ _
		( _
			@FB_RTL_INPUTUINT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputLongint ( x as longint ) as void '/ _
		( _
			@FB_RTL_INPUTLONGINT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputUlongint ( x as ulongint ) as void '/ _
		( _
			@FB_RTL_INPUTULONGINT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputSingle ( x as single ) as void '/ _
		( _
			@FB_RTL_INPUTSINGLE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputDouble ( x as double ) as void '/ _
		( _
			@FB_RTL_INPUTDOUBLE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_InputString ( x as any, byval strlen as integer, byval islast as integer,
							byval fillrem as integer = 1 ) as void '/ _
		( _
			@FB_RTL_INPUTSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_InputWstr ( byval dst as wstring ptr, byval maxchars as integer,
						  byval islast as integer ) as integer '/ _
		( _
			@FB_RTL_INPUTWSTR, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileLock ( byval inipos as integer, byval endpos as integer ) as integer '/ _
		( _
			@FB_RTL_FILELOCK, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_FileUnlock ( byval inipos as integer, byval endpos as integer ) as integer '/ _
		( _
			@FB_RTL_FILEUNLOCK, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' rename ( byval oldname as zstring ptr, byval newname as zstring ptr ) as integer '/ _
		( _
			@FB_RTL_FILERENAME, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileWstrInput ( byval chars as integer, byval filenum as integer = 0 ) as wstring '/ _
		( _
			@"winput", @"fb_FileWstrInput", _
			FB_DATATYPE_WCHAR, FB_FUNCMODE_STDCALL, _
	 		@rtlMultinput_cb, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' fb_FileFree ( ) as integer '/ _
		( _
			@"freefile", @"fb_FileFree", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' fb_FileEof ( byval filenum as integer ) as integer '/ _
		( _
			@"eof", @"fb_FileEof", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileKill ( s as string ) as integer '/ _
		( _
			@"kill", @"fb_FileKill", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' reset ( ) as void '/ _
		( _
			@"reset", @"fb_FileReset", _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' lof ( byval filenum as integer ) as uinteger '/ _
		( _
			@"lof", @"fb_FileSize", _
			FB_DATATYPE_UINT, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' loc ( byval filenum as integer ) as uinteger '/ _
		( _
			@"loc", @"fb_FileLocation", _
			FB_DATATYPE_UINT, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' lpos( int ) as integer '/ _
		( _
			@"lpos", @"fb_LPos", _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		@rtlPrinter_cb, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }


'':::::
sub rtlFileModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlFileModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlFileOpen _
	( _
		byval filename as ASTNODE ptr, _
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
function rtlFileOpenShort _
	( _
		byval filename as ASTNODE ptr, _
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
function rtlFileClose _
	( _
		byval filenum as ASTNODE ptr, _
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
function rtlFileSeek _
	( _
		byval filenum as ASTNODE ptr, _
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
function rtlFileTell _
	( _
		byval filenum as ASTNODE ptr _
	) as ASTNODE ptr static

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
function rtlFilePut _
	( _
		byval filenum as ASTNODE ptr, _
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
	isstring = symbIsString( dtype )
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
    if( astGetDataType( src ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( src ) ) ) then
            errReportParamWarn( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
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
function rtlFilePutArray _
	( _
		byval filenum as ASTNODE ptr, _
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
    if( astGetDataType( src ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( src ) ) ) then
            errReportParamWarn( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
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
function rtlFileGet _
	( _
		byval filenum as ASTNODE ptr, _
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
	isstring = symbIsString( dtype )
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
    if( astGetDataType( dst ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( dst ) ) ) then
            errReportParamWarn( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
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
function rtlFileGetArray _
	( _
		byval filenum as ASTNODE ptr, _
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
    if( astGetDataType( dst ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetUDTHasPtrField( astGetSubType( dst ) ) ) then
            errReportParamWarn( proc, 3, NULL, FB_WARNINGMSG_POINTERFIELDS )
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
function rtlFileStrInput _
	( _
		byval bytesexpr as ASTNODE ptr, _
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
function rtlFileLineInput _
	( _
		byval isfile as integer, _
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
function rtlFileLineInputWstr _
	( _
		byval isfile as integer, _
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
function rtlFileInput _
	( _
		byval isfile as integer, _
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
function rtlFileInputGet _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval islast as integer _
	) as integer

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
		args = 4

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( INPUTWSTR )
		args = 3

	case FB_DATATYPE_BYTE
		f = PROCLOOKUP( INPUTBYTE )

	case FB_DATATYPE_UBYTE
		f = PROCLOOKUP( INPUTUBYTE )

	case FB_DATATYPE_SHORT
		f = PROCLOOKUP( INPUTSHORT )

	case FB_DATATYPE_USHORT
		f = PROCLOOKUP( INPUTUSHORT )

	case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		f = PROCLOOKUP( INPUTINT )

	case FB_DATATYPE_UINT
		f = PROCLOOKUP( INPUTUINT )

	case FB_DATATYPE_LONGINT
		f = PROCLOOKUP( INPUTLONGINT )

	case FB_DATATYPE_ULONGINT
		f = PROCLOOKUP( INPUTULONGINT )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( INPUTSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( INPUTDOUBLE )

	case else
		if( dtype >= FB_DATATYPE_POINTER ) then	'' non-sense but..
			f = PROCLOOKUP( INPUTINT )
			dstexpr = astNewCONV( FB_DATATYPE_UINT, NULL, dstexpr )

		'' UDT, bit-fields..
		else
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			exit function
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

		'' byval islast as integer
		if( astNewARG( proc, astNewCONSTi( islast, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		if( args > 3 ) then
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
function rtlFileLock _
	( _
		byval islock as integer, _
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
function rtlFileRename _
	( _
		byval filename_new as ASTNODE ptr, _
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
function rtlWidthFile _
	( _
		byval fnum as ASTNODE ptr, _
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


