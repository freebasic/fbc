'' FreeBASIC binding for inputproto-2.3.1
''
'' based on the C header files:
''   Copyright © 2009 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define _XI2_H_
const XInput_2_0 = 7
const XI_2_Major = 2
const XI_2_Minor = 3
const XIPropertyDeleted = 0
const XIPropertyCreated = 1
const XIPropertyModified = 2
const XIPropModeReplace = 0
const XIPropModePrepend = 1
const XIPropModeAppend = 2
const XIAnyPropertyType = cast(clong, 0)
const XINotifyNormal = 0
const XINotifyGrab = 1
const XINotifyUngrab = 2
const XINotifyWhileGrabbed = 3
const XINotifyPassiveGrab = 4
const XINotifyPassiveUngrab = 5
const XINotifyAncestor = 0
const XINotifyVirtual = 1
const XINotifyInferior = 2
const XINotifyNonlinear = 3
const XINotifyNonlinearVirtual = 4
const XINotifyPointer = 5
const XINotifyPointerRoot = 6
const XINotifyDetailNone = 7
const XIGrabModeSync = 0
const XIGrabModeAsync = 1
const XIGrabModeTouch = 2
const XIGrabSuccess = 0
const XIAlreadyGrabbed = 1
const XIGrabInvalidTime = 2
const XIGrabNotViewable = 3
const XIGrabFrozen = 4
#define XIOwnerEvents True
#define XINoOwnerEvents False
const XIGrabtypeButton = 0
const XIGrabtypeKeycode = 1
const XIGrabtypeEnter = 2
const XIGrabtypeFocusIn = 3
const XIGrabtypeTouchBegin = 4
const XIAnyModifier = culng(1u shl 31)
const XIAnyButton = 0
const XIAnyKeycode = 0
const XIAsyncDevice = 0
const XISyncDevice = 1
const XIReplayDevice = 2
const XIAsyncPairedDevice = 3
const XIAsyncPair = 4
const XISyncPair = 5
const XIAcceptTouch = 6
const XIRejectTouch = 7
const XISlaveSwitch = 1
const XIDeviceChange = 2
const XIMasterAdded = 1 shl 0
const XIMasterRemoved = 1 shl 1
const XISlaveAdded = 1 shl 2
const XISlaveRemoved = 1 shl 3
const XISlaveAttached = 1 shl 4
const XISlaveDetached = 1 shl 5
const XIDeviceEnabled = 1 shl 6
const XIDeviceDisabled = 1 shl 7
const XIAddMaster = 1
const XIRemoveMaster = 2
const XIAttachSlave = 3
const XIDetachSlave = 4
const XIAttachToMaster = 1
const XIFloating = 2
const XIModeRelative = 0
const XIModeAbsolute = 1
const XIMasterPointer = 1
const XIMasterKeyboard = 2
const XISlavePointer = 3
const XISlaveKeyboard = 4
const XIFloatingSlave = 5
const XIKeyClass = 0
const XIButtonClass = 1
const XIValuatorClass = 2
const XIScrollClass = 3
const XITouchClass = 8
const XIScrollTypeVertical = 1
const XIScrollTypeHorizontal = 2
const XIScrollFlagNoEmulation = 1 shl 0
const XIScrollFlagPreferred = 1 shl 1
const XIKeyRepeat = 1 shl 16
const XIPointerEmulated = 1 shl 16
const XITouchPendingEnd = 1 shl 16
const XITouchEmulatingPointer = 1 shl 17
const XIBarrierPointerReleased = 1 shl 0
const XIBarrierDeviceIsGrabbed = 1 shl 1
const XIDirectTouch = 1
const XIDependentTouch = 2
#define XISetMask(ptr_, event) scope : cptr(ubyte ptr, (ptr_))[((event) shr 3)] or= 1 shl ((event) and 7) : end scope
#define XIClearMask(ptr_, event) scope : cptr(ubyte ptr, (ptr_))[((event) shr 3)] and= not (1 shl ((event) and 7)) : end scope
#define XIMaskIsSet(ptr_, event) (cptr(ubyte ptr, (ptr_))[((event) shr 3)] and (1 shl ((event) and 7)))
#define XIMaskLen(event) (((event) shr 3) + 1)
const XIAllDevices = 0
const XIAllMasterDevices = 1
const XI_DeviceChanged = 1
const XI_KeyPress = 2
const XI_KeyRelease = 3
const XI_ButtonPress = 4
const XI_ButtonRelease = 5
const XI_Motion = 6
const XI_Enter = 7
const XI_Leave = 8
const XI_FocusIn = 9
const XI_FocusOut = 10
const XI_HierarchyChanged = 11
const XI_PropertyEvent = 12
const XI_RawKeyPress = 13
const XI_RawKeyRelease = 14
const XI_RawButtonPress = 15
const XI_RawButtonRelease = 16
const XI_RawMotion = 17
const XI_TouchBegin = 18
const XI_TouchUpdate = 19
const XI_TouchEnd = 20
const XI_TouchOwnership = 21
const XI_RawTouchBegin = 22
const XI_RawTouchUpdate = 23
const XI_RawTouchEnd = 24
const XI_BarrierHit = 25
const XI_BarrierLeave = 26
const XI_LASTEVENT = XI_BarrierLeave
const XI_DeviceChangedMask = 1 shl XI_DeviceChanged
const XI_KeyPressMask = 1 shl XI_KeyPress
const XI_KeyReleaseMask = 1 shl XI_KeyRelease
const XI_ButtonPressMask = 1 shl XI_ButtonPress
const XI_ButtonReleaseMask = 1 shl XI_ButtonRelease
const XI_MotionMask = 1 shl XI_Motion
const XI_EnterMask = 1 shl XI_Enter
const XI_LeaveMask = 1 shl XI_Leave
const XI_FocusInMask = 1 shl XI_FocusIn
const XI_FocusOutMask = 1 shl XI_FocusOut
const XI_HierarchyChangedMask = 1 shl XI_HierarchyChanged
const XI_PropertyEventMask = 1 shl XI_PropertyEvent
const XI_RawKeyPressMask = 1 shl XI_RawKeyPress
const XI_RawKeyReleaseMask = 1 shl XI_RawKeyRelease
const XI_RawButtonPressMask = 1 shl XI_RawButtonPress
const XI_RawButtonReleaseMask = 1 shl XI_RawButtonRelease
const XI_RawMotionMask = 1 shl XI_RawMotion
const XI_TouchBeginMask = 1 shl XI_TouchBegin
const XI_TouchEndMask = 1 shl XI_TouchEnd
const XI_TouchOwnershipChangedMask = 1 shl XI_TouchOwnership
const XI_TouchUpdateMask = 1 shl XI_TouchUpdate
const XI_RawTouchBeginMask = 1 shl XI_RawTouchBegin
const XI_RawTouchEndMask = 1 shl XI_RawTouchEnd
const XI_RawTouchUpdateMask = 1 shl XI_RawTouchUpdate
const XI_BarrierHitMask = 1 shl XI_BarrierHit
const XI_BarrierLeaveMask = 1 shl XI_BarrierLeave
