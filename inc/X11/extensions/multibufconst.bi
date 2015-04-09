'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "crt/long.bi"

#define _MULTIBUFCONST_H_
#define MULTIBUFFER_PROTOCOL_NAME "Multi-Buffering"
const MULTIBUFFER_MAJOR_VERSION = 1
const MULTIBUFFER_MINOR_VERSION = 1
const MultibufferUpdateActionUndefined = 0
const MultibufferUpdateActionBackground = 1
const MultibufferUpdateActionUntouched = 2
const MultibufferUpdateActionCopied = 3
const MultibufferUpdateHintFrequent = 0
const MultibufferUpdateHintIntermittent = 1
const MultibufferUpdateHintStatic = 2
const MultibufferWindowUpdateHint = cast(clong, 1) shl 0
const MultibufferBufferEventMask = cast(clong, 1) shl 0
const MultibufferModeMono = 0
const MultibufferModeStereo = 1
const MultibufferSideMono = 0
const MultibufferSideLeft = 1
const MultibufferSideRight = 2
const MultibufferUnclobbered = 0
const MultibufferPartiallyClobbered = 1
const MultibufferFullyClobbered = 2
const MultibufferClobberNotifyMask = &h02000000
const MultibufferUpdateNotifyMask = &h04000000
const MultibufferClobberNotify = 0
const MultibufferUpdateNotify = 1
#define MultibufferNumberEvents (MultibufferUpdateNotify + 1)
const MultibufferBadBuffer = 0
#define MultibufferNumberErrors (MultibufferBadBuffer + 1)
