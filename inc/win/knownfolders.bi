'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "winapifamily.bi"

extern "C"

extern FOLDERID_AccountPictures as const GUID
extern FOLDERID_AddNewPrograms as const GUID
extern FOLDERID_AdminTools as const GUID
extern FOLDERID_AppsFolder as const GUID
extern FOLDERID_ApplicationShortcuts as const GUID
extern FOLDERID_AppUpdates as const GUID
extern FOLDERID_CDBurning as const GUID
extern FOLDERID_ChangeRemovePrograms as const GUID
extern FOLDERID_CommonAdminTools as const GUID
extern FOLDERID_CommonOEMLinks as const GUID
extern FOLDERID_CommonPrograms as const GUID
extern FOLDERID_CommonStartMenu as const GUID
extern FOLDERID_CommonStartup as const GUID
extern FOLDERID_CommonTemplates as const GUID
extern FOLDERID_ComputerFolder as const GUID
extern FOLDERID_ConflictFolder as const GUID
extern FOLDERID_ConnectionsFolder as const GUID
extern FOLDERID_Contacts as const GUID
extern FOLDERID_ControlPanelFolder as const GUID
extern FOLDERID_Cookies as const GUID
extern FOLDERID_Desktop as const GUID
extern FOLDERID_DeviceMetadataStore as const GUID
extern FOLDERID_Documents as const GUID
extern FOLDERID_DocumentsLibrary as const GUID
extern FOLDERID_Downloads as const GUID
extern FOLDERID_Favorites as const GUID
extern FOLDERID_Fonts as const GUID
extern FOLDERID_Games as const GUID
extern FOLDERID_GameTasks as const GUID
extern FOLDERID_History as const GUID
extern FOLDERID_HomeGroup as const GUID
extern FOLDERID_HomeGroupCurrentUser as const GUID
extern FOLDERID_ImplicitAppShortcuts as const GUID
extern FOLDERID_InternetCache as const GUID
extern FOLDERID_InternetFolder as const GUID
extern FOLDERID_Libraries as const GUID
extern FOLDERID_Links as const GUID
extern FOLDERID_LocalAppData as const GUID
extern FOLDERID_LocalAppDataLow as const GUID
extern FOLDERID_LocalizedResourcesDir as const GUID
extern FOLDERID_Music as const GUID
extern FOLDERID_MusicLibrary as const GUID
extern FOLDERID_NetHood as const GUID
extern FOLDERID_NetworkFolder as const GUID
extern FOLDERID_OriginalImages as const GUID
extern FOLDERID_PhotoAlbums as const GUID
extern FOLDERID_Pictures as const GUID
extern FOLDERID_PicturesLibrary as const GUID
extern FOLDERID_Playlists as const GUID
extern FOLDERID_PrintHood as const GUID
extern FOLDERID_PrintersFolder as const GUID
extern FOLDERID_Profile as const GUID
extern FOLDERID_ProgramData as const GUID
extern FOLDERID_ProgramFiles as const GUID
extern FOLDERID_ProgramFilesX64 as const GUID
extern FOLDERID_ProgramFilesX86 as const GUID
extern FOLDERID_ProgramFilesCommon as const GUID
extern FOLDERID_ProgramFilesCommonX64 as const GUID
extern FOLDERID_ProgramFilesCommonX86 as const GUID
extern FOLDERID_Programs as const GUID
extern FOLDERID_Public as const GUID
extern FOLDERID_PublicDesktop as const GUID
extern FOLDERID_PublicDocuments as const GUID
extern FOLDERID_PublicDownloads as const GUID
extern FOLDERID_PublicGameTasks as const GUID
extern FOLDERID_PublicLibraries as const GUID
extern FOLDERID_PublicMusic as const GUID
extern FOLDERID_PublicPictures as const GUID
extern FOLDERID_PublicRingtones as const GUID
extern FOLDERID_PublicUserTiles as const GUID
extern FOLDERID_PublicVideos as const GUID
extern FOLDERID_QuickLaunch as const GUID
extern FOLDERID_Recent as const GUID
extern FOLDERID_RecordedTVLibrary as const GUID
extern FOLDERID_RecycleBinFolder as const GUID
extern FOLDERID_ResourceDir as const GUID
extern FOLDERID_Ringtones as const GUID
extern FOLDERID_RoamingAppData as const GUID
extern FOLDERID_RoamingTiles as const GUID
extern FOLDERID_RoamedTileImages as const GUID
extern FOLDERID_SampleMusic as const GUID
extern FOLDERID_SamplePictures as const GUID
extern FOLDERID_SamplePlaylists as const GUID
extern FOLDERID_SampleVideos as const GUID
extern FOLDERID_SavedGames as const GUID
extern FOLDERID_SavedSearches as const GUID
extern FOLDERID_Screenshots as const GUID
extern FOLDERID_SEARCH_MAPI as const GUID
extern FOLDERID_SEARCH_CSC as const GUID
extern FOLDERID_SearchHome as const GUID
extern FOLDERID_SendTo as const GUID
extern FOLDERID_SidebarDefaultParts as const GUID
extern FOLDERID_SidebarParts as const GUID
extern FOLDERID_StartMenu as const GUID
extern FOLDERID_Startup as const GUID
extern FOLDERID_SyncManagerFolder as const GUID
extern FOLDERID_SyncResultsFolder as const GUID
extern FOLDERID_SyncSetupFolder as const GUID
extern FOLDERID_System as const GUID
extern FOLDERID_SystemX86 as const GUID
extern FOLDERID_Templates as const GUID
extern FOLDERID_UserPinned as const GUID
extern FOLDERID_UserProfiles as const GUID
extern FOLDERID_UserProgramFiles as const GUID
extern FOLDERID_UserProgramFilesCommon as const GUID
extern FOLDERID_UsersFiles as const GUID
extern FOLDERID_UsersLibraries as const GUID
extern FOLDERID_Videos as const GUID
extern FOLDERID_VideosLibrary as const GUID
extern FOLDERID_Windows as const GUID

end extern
