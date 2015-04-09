'' FreeBASIC binding for fixesproto-5.0

#pragma once

#include once "crt/long.bi"

#define _XFIXESWIRE_H_
#define XFIXES_NAME "XFIXES"
const XFIXES_MAJOR = 5
const XFIXES_MINOR = 0
const X_XFixesQueryVersion = 0
const X_XFixesChangeSaveSet = 1
const X_XFixesSelectSelectionInput = 2
const X_XFixesSelectCursorInput = 3
const X_XFixesGetCursorImage = 4
const X_XFixesCreateRegion = 5
const X_XFixesCreateRegionFromBitmap = 6
const X_XFixesCreateRegionFromWindow = 7
const X_XFixesCreateRegionFromGC = 8
const X_XFixesCreateRegionFromPicture = 9
const X_XFixesDestroyRegion = 10
const X_XFixesSetRegion = 11
const X_XFixesCopyRegion = 12
const X_XFixesUnionRegion = 13
const X_XFixesIntersectRegion = 14
const X_XFixesSubtractRegion = 15
const X_XFixesInvertRegion = 16
const X_XFixesTranslateRegion = 17
const X_XFixesRegionExtents = 18
const X_XFixesFetchRegion = 19
const X_XFixesSetGCClipRegion = 20
const X_XFixesSetWindowShapeRegion = 21
const X_XFixesSetPictureClipRegion = 22
const X_XFixesSetCursorName = 23
const X_XFixesGetCursorName = 24
const X_XFixesGetCursorImageAndName = 25
const X_XFixesChangeCursor = 26
const X_XFixesChangeCursorByName = 27
const X_XFixesExpandRegion = 28
const X_XFixesHideCursor = 29
const X_XFixesShowCursor = 30
const X_XFixesCreatePointerBarrier = 31
const X_XFixesDestroyPointerBarrier = 32
#define XFixesNumberRequests (X_XFixesDestroyPointerBarrier + 1)
const XFixesSelectionNotify = 0
const XFixesSetSelectionOwnerNotify = 0
const XFixesSelectionWindowDestroyNotify = 1
const XFixesSelectionClientCloseNotify = 2
const XFixesSetSelectionOwnerNotifyMask = cast(clong, 1) shl 0
const XFixesSelectionWindowDestroyNotifyMask = cast(clong, 1) shl 1
const XFixesSelectionClientCloseNotifyMask = cast(clong, 1) shl 2
const XFixesCursorNotify = 1
const XFixesDisplayCursorNotify = 0
const XFixesDisplayCursorNotifyMask = cast(clong, 1) shl 0
const XFixesNumberEvents = 2
const BadRegion = 0
const BadBarrier = 1
#define XFixesNumberErrors (BadBarrier + 1)
const SaveSetNearest = 0
const SaveSetRoot = 1
const SaveSetMap = 0
const SaveSetUnmap = 1
const WindowRegionBounding = 0
const WindowRegionClip = 1
const BarrierPositiveX = cast(clong, 1) shl 0
const BarrierPositiveY = cast(clong, 1) shl 1
const BarrierNegativeX = cast(clong, 1) shl 2
const BarrierNegativeY = cast(clong, 1) shl 3
