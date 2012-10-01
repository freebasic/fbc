#Ifndef __artprovider_bi__
#Define __artprovider_bi__

#Include Once "common.bi"

Enum ArtID
  wxART_ADD_BOOKMARK = 1,
  wxART_DEL_BOOKMARK,
  wxART_HELP_SIDE_PANEL,
  wxART_HELP_SETTINGS,
  wxART_HELP_BOOK,
  wxART_HELP_FOLDER,
  wxART_HELP_PAGE,
  wxART_GO_BACK,
  wxART_GO_FORWARD,
  wxART_GO_UP,
  wxART_GO_DOWN,
  wxART_GO_TO_PARENT,
  wxART_GO_HOME,
  wxART_FILE_OPEN,
  wxART_PRINT,
  wxART_HELP,
  wxART_TIP,
  wxART_REPORT_VIEW,
  wxART_LIST_VIEW,
  wxART_NEW_DIR,
  wxART_FOLDER,
  wxART_GO_DIR_UP,
  wxART_EXECUTABLE_FILE,
  wxART_NORMAL_FILE,
  wxART_TICK_MARK,
  wxART_CROSS_MARK,
  wxART_ERROR,
  wxART_QUESTION,
  wxART_WARNING,
  wxART_INFORMATION,
  wxART_FILE_SAVE,
  wxART_FILE_SAVE_AS,
  wxART_HARDDISK,
  wxART_FLOPPY,
  wxART_CDROM,
  wxART_REMOVABLE,
  wxART_FOLDER_OPEN,
  wxART_COPY,
  wxART_CUT,
  wxART_PASTE,
  wxART_DELETE,
  wxART_NEW,
  wxART_UNDO,
  wxART_REDO,
  wxART_QUIT,
  wxART_FIND,
  wxART_FIND_AND_REPLACE,

  wxART_MISSING_IMAGE
End Enum
Enum ArtClient
  wxART_TOOLBAR = 1,
  wxART_MENU,
  wxART_FRAME_ICON,
  wxART_CMN_DIALOG,
  wxART_HELP_BROWSER,
  wxART_MESSAGE_BOX,
  wxART_BUTTON,
  wxART_OTHER
End Enum


Declare Function wxArtProvider_GetBitmap WXCALL Alias "wxArtProvider_GetBitmap" (id As ArtId, client As ArtClient, w As wxInt, h As wxInt) As wxBitmap Ptr
Declare Function wxArtProvider_GetIcon WXCALL Alias "wxArtProvider_GetIcon" (id As ArtId, client As ArtClient, w As wxInt, h As wxInt) As wxIcon   Ptr

#EndIf '__artprovider_bi__

