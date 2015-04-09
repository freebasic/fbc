'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#include once "crt/long.bi"

#define _SHAPECONST_H_
#define SHAPENAME "SHAPE"
const SHAPE_MAJOR_VERSION = 1
const SHAPE_MINOR_VERSION = 1
const ShapeSet = 0
const ShapeUnion = 1
const ShapeIntersect = 2
const ShapeSubtract = 3
const ShapeInvert = 4
const ShapeBounding = 0
const ShapeClip = 1
const ShapeInput = 2
const ShapeNotifyMask = cast(clong, 1) shl 0
const ShapeNotify = 0
#define ShapeNumberEvents (ShapeNotify + 1)
