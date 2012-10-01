/' MediaInfo - All info about media files
// Copyright (C) 2002-2009 Jerome Martinez, Zen@MediaArea.net
//
// This library is free software: you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this library. If not, see <http://www.gnu.org/licenses/>.
//
'/
#ifdef __FB_DOS__
#error "MediaInfo not supported on this platform."
#endif

#ifndef __MediaInfo_bi__
#define __MediaInfo_bi__

#ifndef NULL
    #define NULL 0
#endif

enum MediaInfo_stream_t
    MediaInfo_Stream_General
    MediaInfo_Stream_Video
    MediaInfo_Stream_Audio
    MediaInfo_Stream_Text
    MediaInfo_Stream_Chapters
    MediaInfo_Stream_Image
    MediaInfo_Stream_Menu
    MediaInfo_Stream_Max
end enum

enum MediaInfo_info_t
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

enum MediaInfo_infooptions_t
    MediaInfo_InfoOption_ShowInInform
    MediaInfo_InfoOption_Reserved
    MediaInfo_InfoOption_ShowInSupported
    MediaInfo_InfoOption_TypeOfValue
    MediaInfo_InfoOption_Max
end enum

enum MediaInfo_fileoptions_t
    MediaInfo_FileOption_Nothing = &h00
    MediaInfo_FileOption_NoRecursive = &h01
    MediaInfo_FileOption_CloseAll = &h02
    MediaInfo_FileOption_Max = &h04
end enum

#ifdef __FB_WIN32__
extern "Windows-MS"
#else
extern "C"
#endif

declare function MediaInfo_New() as any ptr
declare function MediaInfoList_New() as any ptr

declare sub MediaInfo_Delete( byval as any ptr )
declare sub MediaInfoList_Delete( byval as any ptr )

declare function MediaInfo_Open( byval as any ptr, byval as zstring ptr ) as uinteger
declare function MediaInfoList_Open( byval as any ptr, byval as zstring ptr, byval as MediaInfo_fileoptions_t ) as uinteger
declare function MediaInfo_Open_Buffer_Init( byval as any ptr, byval as ulongint, byval as ulongint ) as uinteger
declare function MediaInfo_Open_Buffer_Continue( byval as any ptr, byval as ubyte ptr, byval as uinteger ) as uinteger
declare function MediaInfo_Open_Buffer_Continue_GoTo_Get( byval as any ptr ) as ulongint
declare function MediaInfo_Open_Buffer_Finalize( byval as any ptr ) as uinteger
declare function MediaInfo_Open_NextPacket( byval as any ptr ) as uinteger

declare sub MediaInfo_Close( byval as any ptr )
declare sub MediaInfoList_Close( byval as any ptr, byval as uinteger )

declare function MediaInfo_Inform( byval as any ptr, byval as uinteger ) as zstring ptr
declare function MediaInfoList_Inform( byval as any ptr, byval as uinteger, byval as uinteger ) as zstring ptr

declare function MediaInfo_GetI( byval as any ptr, byval as MediaInfo_stream_t, byval as uinteger, byval as uinteger, byval as MediaInfo_info_t ) as zstring ptr
declare function MediaInfoList_GetI( byval as any ptr, byval as uinteger, byval as MediaInfo_stream_t, byval as uinteger, byval as uinteger, byval as MediaInfo_info_t ) as zstring ptr
declare function MediaInfo_Get( byval as any ptr, byval as MediaInfo_stream_t, byval as uinteger, byval as zstring ptr, byval as MediaInfo_info_t, byval as MediaInfo_info_t ) as zstring ptr
declare function MediaInfoList_Get( byval as any ptr, byval as uinteger, byval as MediaInfo_stream_t, byval as uinteger, byval as zstring ptr, byval as MediaInfo_info_t, byval as MediaInfo_info_t ) as zstring ptr

declare function MediaInfo_Output_Buffer_Get( byval as any ptr, byval as zstring ptr ) as uinteger
declare function MediaInfo_Output_Buffer_GetI( byval as any ptr, byval as uinteger ) as uinteger

declare function MediaInfo_Option( byval as any ptr, byval as zstring ptr, byval as zstring ptr ) as zstring ptr
declare function MediaInfoList_Option( byval as any ptr, byval as zstring ptr, byval as zstring ptr ) as zstring ptr

declare function MediaInfo_State_Get( byval as any ptr ) as uinteger
declare function MediaInfoList_State_Get( byval as any ptr ) as uinteger

declare function MediaInfo_Count_Get( byval as any ptr, byval as MediaInfo_stream_t, byval as uinteger ) as uinteger
declare function MediaInfoList_Count_Get( byval as any ptr, byval as uinteger, byval as MediaInfo_stream_t, byval as uinteger ) as uinteger
declare function MediaInfo_Count_Get_Files( byval as any ptr ) as uinteger
declare function MediaInfoList_Count_Get_Files( byval as any ptr ) as uinteger

end extern

#inclib "MediaInfo"

#endif
