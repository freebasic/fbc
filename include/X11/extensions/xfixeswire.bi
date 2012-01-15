''
''
'' xfixeswire -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xfixeswire_bi__
#define __xfixeswire_bi__

#define XFIXES_NAME "XFIXES"
#define XFIXES_MAJOR 4
#define XFIXES_MINOR 0
#define X_XFixesQueryVersion 0
#define X_XFixesChangeSaveSet 1
#define X_XFixesSelectSelectionInput 2
#define X_XFixesSelectCursorInput 3
#define X_XFixesGetCursorImage 4
#define X_XFixesCreateRegion 5
#define X_XFixesCreateRegionFromBitmap 6
#define X_XFixesCreateRegionFromWindow 7
#define X_XFixesCreateRegionFromGC 8
#define X_XFixesCreateRegionFromPicture 9
#define X_XFixesDestroyRegion 10
#define X_XFixesSetRegion 11
#define X_XFixesCopyRegion 12
#define X_XFixesUnionRegion 13
#define X_XFixesIntersectRegion 14
#define X_XFixesSubtractRegion 15
#define X_XFixesInvertRegion 16
#define X_XFixesTranslateRegion 17
#define X_XFixesRegionExtents 18
#define X_XFixesFetchRegion 19
#define X_XFixesSetGCClipRegion 20
#define X_XFixesSetWindowShapeRegion 21
#define X_XFixesSetPictureClipRegion 22
#define X_XFixesSetCursorName 23
#define X_XFixesGetCursorName 24
#define X_XFixesGetCursorImageAndName 25
#define X_XFixesChangeCursor 26
#define X_XFixesChangeCursorByName 27
#define X_XFixesExpandRegion 28
#define X_XFixesHideCursor 29
#define X_XFixesShowCursor 30
#define XFixesNumberRequests (30+1)
#define XFixesSelectionNotify 0
#define XFixesSetSelectionOwnerNotify 0
#define XFixesSelectionWindowDestroyNotify 1
#define XFixesSelectionClientCloseNotify 2
#define XFixesSetSelectionOwnerNotifyMask (1L shl 0)
#define XFixesSelectionWindowDestroyNotifyMask (1L shl 1)
#define XFixesSelectionClientCloseNotifyMask (1L shl 2)
#define XFixesCursorNotify 1
#define XFixesDisplayCursorNotify 0
#define XFixesDisplayCursorNotifyMask (1L shl 0)
#define XFixesNumberEvents (2)
#define BadRegion 0
#define XFixesNumberErrors (0+1)
#define SaveSetNearest 0
#define SaveSetRoot 1
#define SaveSetMap 0
#define SaveSetUnmap 1
#define WindowRegionBounding 0
#define WindowRegionClip 1

#endif
