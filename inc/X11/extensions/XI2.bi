'' FreeBASIC binding for inputproto-2.3.1

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
#macro XISetMask(ptr, event)
	scope
		cptr(ubyte ptr, (ptr))[(event) shr 3] or= (1 shl ((event) and 7))
	end scope
#endmacro
#macro XIClearMask(ptr, event)
	scope
		cptr(ubyte ptr, (ptr))[(event) shr 3] and= not (1 shl ((event) and 7))
	end scope
#endmacro
#define XIMaskIsSet(ptr, event) (cptr(ubyte ptr, (ptr))[((event) shr 3)] and (1 shl ((event) and 7)))
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
#define XI_LASTEVENT XI_BarrierLeave
#define XI_DeviceChangedMask (1 shl XI_DeviceChanged)
#define XI_KeyPressMask (1 shl XI_KeyPress)
#define XI_KeyReleaseMask (1 shl XI_KeyRelease)
#define XI_ButtonPressMask (1 shl XI_ButtonPress)
#define XI_ButtonReleaseMask (1 shl XI_ButtonRelease)
#define XI_MotionMask (1 shl XI_Motion)
#define XI_EnterMask (1 shl XI_Enter)
#define XI_LeaveMask (1 shl XI_Leave)
#define XI_FocusInMask (1 shl XI_FocusIn)
#define XI_FocusOutMask (1 shl XI_FocusOut)
#define XI_HierarchyChangedMask (1 shl XI_HierarchyChanged)
#define XI_PropertyEventMask (1 shl XI_PropertyEvent)
#define XI_RawKeyPressMask (1 shl XI_RawKeyPress)
#define XI_RawKeyReleaseMask (1 shl XI_RawKeyRelease)
#define XI_RawButtonPressMask (1 shl XI_RawButtonPress)
#define XI_RawButtonReleaseMask (1 shl XI_RawButtonRelease)
#define XI_RawMotionMask (1 shl XI_RawMotion)
#define XI_TouchBeginMask (1 shl XI_TouchBegin)
#define XI_TouchEndMask (1 shl XI_TouchEnd)
#define XI_TouchOwnershipChangedMask (1 shl XI_TouchOwnership)
#define XI_TouchUpdateMask (1 shl XI_TouchUpdate)
#define XI_RawTouchBeginMask (1 shl XI_RawTouchBegin)
#define XI_RawTouchEndMask (1 shl XI_RawTouchEnd)
#define XI_RawTouchUpdateMask (1 shl XI_RawTouchUpdate)
#define XI_BarrierHitMask (1 shl XI_BarrierHit)
#define XI_BarrierLeaveMask (1 shl XI_BarrierLeave)
