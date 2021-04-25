'' FreeBASIC binding for libmediainfo_0.7.77
''
'' based on the C header files:
''      Copyright (c) 2002-2015 MediaArea.net SARL. All rights reserved.
''
''      Redistribution and use in source and binary forms, with or without
''      modification, are permitted provided that the following conditions are
''      met:
''        * Redistributions of source code must retain the above copyright
''          notice, this list of conditions and the following disclaimer.
''        * Redistributions in binary form must reproduce the above copyright
''          notice, this list of conditions and the following disclaimer in the
''          documentation and/or other materials provided with the
''          distribution.
''
''      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
''      IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
''      TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
''      PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
''      HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
''      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
''      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
''      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
''      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "MediaInfo"

#include once "crt/limits.bi"

#ifdef __FB_UNIX__
	extern "C"
#else
	extern "Windows"
#endif

#define MediaInfoDLL_StaticH
type MediaInfo_int8u as ubyte
type MediaInfo_int64u as ulongint

type MediaInfo_stream_t as long
enum
	MediaInfo_Stream_General
	MediaInfo_Stream_Video
	MediaInfo_Stream_Audio
	MediaInfo_Stream_Text
	MediaInfo_Stream_Other
	MediaInfo_Stream_Image
	MediaInfo_Stream_Menu
	MediaInfo_Stream_Max
end enum

type MediaInfo_stream_C as MediaInfo_stream_t

type MediaInfo_info_t as long
enum
	MediaInfo_Info_Name
	MediaInfo_Info_Text
	MediaInfo_Info_Measure
	MediaInfo_Info_Options
	MediaInfo_Info_Name_Text
	MediaInfo_Info_Measure_Text
	MediaInfo_Info_Info
	MediaInfo_Info_HowTo
	MediaInfo_Info_Max
end enum

type MediaInfo_info_C as MediaInfo_info_t

type MediaInfo_infooptions_t as long
enum
	MediaInfo_InfoOption_ShowInInform
	MediaInfo_InfoOption_Reserved
	MediaInfo_InfoOption_ShowInSupported
	MediaInfo_InfoOption_TypeOfValue
	MediaInfo_InfoOption_Max
end enum

type MediaInfo_infooptions_C as MediaInfo_infooptions_t

type MediaInfo_fileoptions_t as long
enum
	MediaInfo_FileOption_Nothing = &h00
	MediaInfo_FileOption_NoRecursive = &h01
	MediaInfo_FileOption_CloseAll = &h02
	MediaInfo_FileOption_Max = &h04
end enum

type MediaInfo_fileoptions_C as MediaInfo_fileoptions_t

#ifdef UNICODE
	declare function MediaInfo_New() as any ptr
	declare function MediaInfo_New_Quick(byval File as const wstring ptr, byval Options as const wstring ptr) as any ptr
	declare sub MediaInfo_Delete(byval Handle as any ptr)
	declare function MediaInfo_Open(byval Handle as any ptr, byval File as const wstring ptr) as uinteger
	declare function MediaInfo_Open_Buffer(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger
	declare function MediaInfo_Open_Buffer_Init(byval Handle as any ptr, byval File_Size as MediaInfo_int64u, byval File_Offset as MediaInfo_int64u) as uinteger
	declare function MediaInfo_Open_Buffer_Continue(byval Handle as any ptr, byval Buffer as MediaInfo_int8u ptr, byval Buffer_Size as uinteger) as uinteger
	declare function MediaInfo_Open_Buffer_Continue_GoTo_Get(byval Handle as any ptr) as MediaInfo_int64u
	declare function MediaInfo_Open_Buffer_Finalize(byval Handle as any ptr) as uinteger
	declare function MediaInfo_Open_NextPacket(byval Handle as any ptr) as uinteger
	declare function MediaInfo_Save(byval Handle as any ptr) as uinteger
	declare sub MediaInfo_Close(byval Handle as any ptr)
	declare function MediaInfo_Inform(byval Handle as any ptr, byval Reserved as uinteger) as const wstring ptr
	declare function MediaInfo_GetI(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const wstring ptr
	declare function MediaInfo_Get(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const wstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const wstring ptr
	declare function MediaInfo_SetI(byval Handle as any ptr, byval ToSet as const wstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const wstring ptr) as uinteger
	declare function MediaInfo_Set(byval Handle as any ptr, byval ToSet as const wstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const wstring ptr, byval OldParameter as const wstring ptr) as uinteger
	declare function MediaInfo_Output_Buffer_Get(byval Handle as any ptr, byval Value as const wstring ptr) as uinteger
	declare function MediaInfo_Output_Buffer_GetI(byval Handle as any ptr, byval Pos as uinteger) as uinteger
	declare function MediaInfo_Option(byval Handle as any ptr, byval Option as const wstring ptr, byval Value as const wstring ptr) as const wstring ptr
	declare function MediaInfo_State_Get(byval Handle as any ptr) as uinteger
	declare function MediaInfo_Count_Get(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger
#endif

declare function MediaInfoA_New() as any ptr

#ifndef UNICODE
	declare function MediaInfo_New alias "MediaInfoA_New"() as any ptr
#endif

declare function MediaInfoA_New_Quick(byval File as const zstring ptr, byval Options as const zstring ptr) as any ptr

#ifndef UNICODE
	declare function MediaInfo_New_Quick alias "MediaInfoA_New_Quick"(byval File as const zstring ptr, byval Options as const zstring ptr) as any ptr
#endif

declare sub MediaInfoA_Delete(byval Handle as any ptr)

#ifndef UNICODE
	declare sub MediaInfo_Delete alias "MediaInfoA_Delete"(byval Handle as any ptr)
#endif

declare function MediaInfoA_Open(byval Handle as any ptr, byval File as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open alias "MediaInfoA_Open"(byval Handle as any ptr, byval File as const zstring ptr) as uinteger
#endif

declare function MediaInfoA_Open_Buffer(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open_Buffer alias "MediaInfoA_Open_Buffer"(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger
#endif

declare function MediaInfoA_Open_Buffer_Init(byval Handle as any ptr, byval File_Size as MediaInfo_int64u, byval File_Offset as MediaInfo_int64u) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open_Buffer_Init alias "MediaInfoA_Open_Buffer_Init"(byval Handle as any ptr, byval File_Size as MediaInfo_int64u, byval File_Offset as MediaInfo_int64u) as uinteger
#endif

declare function MediaInfoA_Open_Buffer_Continue(byval Handle as any ptr, byval Buffer as MediaInfo_int8u ptr, byval Buffer_Size as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open_Buffer_Continue alias "MediaInfoA_Open_Buffer_Continue"(byval Handle as any ptr, byval Buffer as MediaInfo_int8u ptr, byval Buffer_Size as uinteger) as uinteger
#endif

declare function MediaInfoA_Open_Buffer_Continue_GoTo_Get(byval Handle as any ptr) as MediaInfo_int64u

#ifndef UNICODE
	declare function MediaInfo_Open_Buffer_Continue_GoTo_Get alias "MediaInfoA_Open_Buffer_Continue_GoTo_Get"(byval Handle as any ptr) as MediaInfo_int64u
#endif

declare function MediaInfoA_Open_Buffer_Finalize(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open_Buffer_Finalize alias "MediaInfoA_Open_Buffer_Finalize"(byval Handle as any ptr) as uinteger
#endif

declare function MediaInfoA_Open_NextPacket(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Open_NextPacket alias "MediaInfoA_Open_NextPacket"(byval Handle as any ptr) as uinteger
#endif

declare function MediaInfoA_Save(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Save alias "MediaInfoA_Save"(byval Handle as any ptr) as uinteger
#endif

declare sub MediaInfoA_Close(byval Handle as any ptr)

#ifndef UNICODE
	declare sub MediaInfo_Close alias "MediaInfoA_Close"(byval Handle as any ptr)
#endif

declare function MediaInfoA_Inform(byval Handle as any ptr, byval Reserved as uinteger) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfo_Inform alias "MediaInfoA_Inform"(byval Handle as any ptr, byval Reserved as uinteger) as const zstring ptr
#endif

declare function MediaInfoA_GetI(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfo_GetI alias "MediaInfoA_GetI"(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const zstring ptr
#endif

declare function MediaInfoA_Get(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfo_Get alias "MediaInfoA_Get"(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const zstring ptr
#endif

declare function MediaInfoA_SetI(byval Handle as any ptr, byval ToSet as const zstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_SetI alias "MediaInfoA_SetI"(byval Handle as any ptr, byval ToSet as const zstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const zstring ptr) as uinteger
#endif

declare function MediaInfoA_Set(byval Handle as any ptr, byval ToSet as const zstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval OldParameter as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Set alias "MediaInfoA_Set"(byval Handle as any ptr, byval ToSet as const zstring ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval OldParameter as const zstring ptr) as uinteger
#endif

declare function MediaInfoA_Output_Buffer_Get(byval Handle as any ptr, byval Value as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Output_Buffer_Get alias "MediaInfoA_Output_Buffer_Get"(byval Handle as any ptr, byval Value as const zstring ptr) as uinteger
#endif

declare function MediaInfoA_Output_Buffer_GetI(byval Handle as any ptr, byval Pos as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfo_Output_Buffer_GetI alias "MediaInfoA_Output_Buffer_GetI"(byval Handle as any ptr, byval Pos as uinteger) as uinteger
#endif

declare function MediaInfoA_Option(byval Handle as any ptr, byval Option as const zstring ptr, byval Value as const zstring ptr) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfo_Option alias "MediaInfoA_Option"(byval Handle as any ptr, byval Option as const zstring ptr, byval Value as const zstring ptr) as const zstring ptr
#endif

declare function MediaInfoA_State_Get(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfo_State_Get alias "MediaInfoA_State_Get"(byval Handle as any ptr) as uinteger
#endif

declare function MediaInfoA_Count_Get(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger

#ifdef UNICODE
	declare function MediaInfoList_New() as any ptr
	declare function MediaInfoList_New_Quick(byval Files as const wstring ptr, byval Config as const wstring ptr) as any ptr
	declare sub MediaInfoList_Delete(byval Handle as any ptr)
	declare function MediaInfoList_Open(byval Handle as any ptr, byval Files as const wstring ptr, byval Options as const MediaInfo_fileoptions_C) as uinteger
	declare function MediaInfoList_Open_Buffer(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger
	declare function MediaInfoList_Save(byval Handle as any ptr, byval FilePos as uinteger) as uinteger
	declare sub MediaInfoList_Close(byval Handle as any ptr, byval FilePos as uinteger)
	declare function MediaInfoList_Inform(byval Handle as any ptr, byval FilePos as uinteger, byval Reserved as uinteger) as const wstring ptr
	declare function MediaInfoList_GetI(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const wstring ptr
	declare function MediaInfoList_Get(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const wstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const wstring ptr
	declare function MediaInfoList_SetI(byval Handle as any ptr, byval ToSet as const wstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const wstring ptr) as uinteger
	declare function MediaInfoList_Set(byval Handle as any ptr, byval ToSet as const wstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const wstring ptr, byval OldParameter as const wstring ptr) as uinteger
	declare function MediaInfoList_Option(byval Handle as any ptr, byval Option as const wstring ptr, byval Value as const wstring ptr) as const wstring ptr
	declare function MediaInfoList_State_Get(byval Handle as any ptr) as uinteger
	declare function MediaInfoList_Count_Get(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger
	declare function MediaInfoList_Count_Get_Files(byval Handle as any ptr) as uinteger
#else
	declare function MediaInfo_Count_Get alias "MediaInfoA_Count_Get"(byval Handle as any ptr, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger
	#define MediaInfoList_Save_All MediaInfoListA_Save_All
	#define MediaInfoList_Close_All MediaInfoListA_Close_All
	#define MediaInfoList_Inform_All MediaInfoListA_Inform_All
#endif

declare function MediaInfo_Info_Version() as const zstring ptr
declare function MediaInfoListA_New() as any ptr

#ifndef UNICODE
	declare function MediaInfoList_New alias "MediaInfoListA_New"() as any ptr
#endif

declare function MediaInfoListA_New_Quick(byval Files as const zstring ptr, byval Config as const zstring ptr) as any ptr

#ifndef UNICODE
	declare function MediaInfoList_New_Quick alias "MediaInfoListA_New_Quick"(byval Files as const zstring ptr, byval Config as const zstring ptr) as any ptr
#endif

declare sub MediaInfoListA_Delete(byval Handle as any ptr)

#ifndef UNICODE
	declare sub MediaInfoList_Delete alias "MediaInfoListA_Delete"(byval Handle as any ptr)
#endif

declare function MediaInfoListA_Open(byval Handle as any ptr, byval Files as const zstring ptr, byval Options as const MediaInfo_fileoptions_C) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Open alias "MediaInfoListA_Open"(byval Handle as any ptr, byval Files as const zstring ptr, byval Options as const MediaInfo_fileoptions_C) as uinteger
#endif

declare function MediaInfoListA_Open_Buffer(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Open_Buffer alias "MediaInfoListA_Open_Buffer"(byval Handle as any ptr, byval Begin as const ubyte ptr, byval Begin_Size as uinteger, byval End as const ubyte ptr, byval End_Size as uinteger) as uinteger
#endif

declare function MediaInfoListA_Save(byval Handle as any ptr, byval FilePos as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Save alias "MediaInfoListA_Save"(byval Handle as any ptr, byval FilePos as uinteger) as uinteger
#endif

declare sub MediaInfoListA_Close(byval Handle as any ptr, byval FilePos as uinteger)

#ifndef UNICODE
	declare sub MediaInfoList_Close alias "MediaInfoListA_Close"(byval Handle as any ptr, byval FilePos as uinteger)
#endif

declare function MediaInfoListA_Inform(byval Handle as any ptr, byval FilePos as uinteger, byval Reserved as uinteger) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfoList_Inform alias "MediaInfoListA_Inform"(byval Handle as any ptr, byval FilePos as uinteger, byval Reserved as uinteger) as const zstring ptr
#endif

declare function MediaInfoListA_GetI(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfoList_GetI alias "MediaInfoListA_GetI"(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval InfoKind as MediaInfo_info_C) as const zstring ptr
#endif

declare function MediaInfoListA_Get(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfoList_Get alias "MediaInfoListA_Get"(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval InfoKind as MediaInfo_info_C, byval SearchKind as MediaInfo_info_C) as const zstring ptr
#endif

declare function MediaInfoListA_SetI(byval Handle as any ptr, byval ToSet as const zstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_SetI alias "MediaInfoListA_SetI"(byval Handle as any ptr, byval ToSet as const zstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as uinteger, byval OldParameter as const zstring ptr) as uinteger
#endif

declare function MediaInfoListA_Set(byval Handles as any ptr, byval ToSet as const zstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval OldParameter as const zstring ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Set alias "MediaInfoListA_Set"(byval Handles as any ptr, byval ToSet as const zstring ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger, byval Parameter as const zstring ptr, byval OldParameter as const zstring ptr) as uinteger
#endif

declare function MediaInfoListA_Option(byval Handle as any ptr, byval Option as const zstring ptr, byval Value as const zstring ptr) as const zstring ptr

#ifndef UNICODE
	declare function MediaInfoList_Option alias "MediaInfoListA_Option"(byval Handle as any ptr, byval Option as const zstring ptr, byval Value as const zstring ptr) as const zstring ptr
#endif

declare function MediaInfoListA_State_Get(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_State_Get alias "MediaInfoListA_State_Get"(byval Handle as any ptr) as uinteger
#endif

declare function MediaInfoListA_Count_Get(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Count_Get alias "MediaInfoListA_Count_Get"(byval Handle as any ptr, byval FilePos as uinteger, byval StreamKind as MediaInfo_stream_C, byval StreamNumber as uinteger) as uinteger
#endif

declare function MediaInfoListA_Count_Get_Files(byval Handle as any ptr) as uinteger

#ifndef UNICODE
	declare function MediaInfoList_Count_Get_Files alias "MediaInfoListA_Count_Get_Files"(byval Handle as any ptr) as uinteger
#endif

end extern
