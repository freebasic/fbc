''
''
'' GdiplusTypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusTypes_bi__
#define __win_GdiplusTypes_bi__

type ImageAbort as function (byval as any ptr) as BOOL
type DrawImageAbort as ImageAbort
type GetThumbnailImageAbort as ImageAbort

type EnumerateMetafileProc as function (byval as EmfPlusRecordType, byval as UINT, byval as UINT, byval as UBYTE ptr, byval as any ptr) as BOOL

type REAL as single

#define REAL_MAX FLT_MAX
#define REAL_MIN FLT_MIN
#define REAL_TOLERANCE (FLT_MIN * 100)
#define REAL_EPSILON 1.192092896e-07F

type CSize as Size
type CSizeF as SizeF
type CPoint as Point
type CPointF as PointF
type CRect as Rect
type CRectF as RectF
type CCharacterRange as CharacterRange

enum Status
	Ok = 0
	GenericError = 1
	InvalidParameter = 2
	OutOfMemory = 3
	ObjectBusy = 4
	InsufficientBuffer = 5
	NotImplemented = 6
	Win32Error = 7
	WrongState = 8
	Aborted = 9
	FileNotFound = 10
	ValueOverflow = 11
	AccessDenied = 12
	UnknownImageFormat = 13
	FontFamilyNotFound = 14
	FontStyleNotFound = 15
	NotTrueTypeFont = 16
	UnsupportedGdiplusVersion = 17
	GdiplusNotInitialized = 18
	PropertyNotFound = 19
	PropertyNotSupported = 20
end enum

type SizeF
    declare constructor ()
    declare constructor (byref sz as SizeF)
    declare constructor (byval width as REAL, byval height as REAL)
	declare operator += (byref sz as SizeF)
	declare operator -= (byref sz as SizeF)
	declare function Equals (byref sz as SizeF) as BOOL
	declare function Empty () as BOOL

	Width as REAL
	Height as REAL
end type

declare operator + (byref lhs as SizeF, byref sz as SizeF) as SizeF
declare operator - (byref lhs as SizeF, byref sz as SizeF) as SizeF

private constructor SizeF ()
	this.width = 0
	this.height = 0
end constructor

private constructor SizeF (byref sz as SizeF)
	this.width = sz.width
	this.height = sz.height
end constructor

private constructor SizeF (byval w as REAL, byval h as REAL)
	this.width = w
	this.height = h
end constructor

type Size
    declare constructor ()
    declare constructor (byref sz as Size)
    declare constructor (byval width as INT_, byval height as INT_)
	declare operator += (byref sz as Size)
	declare operator -= (byref sz as Size)
	declare function Equals (byref sz as Size) as BOOL
	declare function Empty () as BOOL

	Width as INT_
	Height as INT_
end type

declare operator + (byref lhs as Size, byref sz as Size) as Size
declare operator - (byref lhs as Size, byref sz as Size) as Size

private constructor Size ()
	this.width = 0
	this.height = 0
end constructor

private constructor Size (byref sz as Size)
	this.width = sz.width
	this.height = sz.height
end constructor

private constructor Size (byval w as INT_, byval h as INT_)
	this.width = w
	this.height = h
end constructor

type PointF
    declare constructor ()
    declare constructor (byref pt as PointF)
    declare constructor (byref sz as SizeF)
    declare constructor (byval x as REAL, byval y as REAL)
	declare operator += (byref pt as PointF)
	declare operator -= (byref pt as PointF)
	declare function Equals (byref pt as PointF) as BOOL
	
	X as REAL
	Y as REAL
end type

declare operator + (byref lhs as PointF, byref pt as PointF) as PointF
declare operator - (byref lhs as PointF, byref pt as PointF) as PointF

private constructor PointF ()
	this.x = 0
	this.y = 0
end constructor

private constructor PointF (byref pt as PointF)
	this.x = pt.x
	this.y = pt.y
end constructor

private constructor PointF (byref sz as SizeF)
	this.x = sz.width
	this.y = sz.height
end constructor

private constructor PointF (byval x as REAL, byval y as REAL)
	this.x = x
	this.y = y
end constructor

type Point
    declare constructor ()
    declare constructor (byref pt as Point)
    declare constructor (byref sz as Size)
    declare constructor (byval x as INT_, byval y as INT_)
	declare operator += (byref pt as Point)
	declare operator -= (byref pt as Point)
	declare function Equals (byref pt as Point) as BOOL
	
	X as INT_
	Y as INT_
end type

declare operator + (byref lhs as Point, byref pt as Point) as Point
declare operator - (byref lhs as Point, byref pt as Point) as Point

private constructor Point ()
	this.x = 0
	this.y = 0
end constructor

private constructor Point (byref pt as Point)
	this.x = pt.x
	this.y = pt.y
end constructor

private constructor Point (byref sz as Size)
	this.x = sz.width
	this.y = sz.height
end constructor

private constructor Point (byval x as INT_, byval y as INT_)
	this.x = x
	this.y = y
end constructor

type RectF
   	declare constructor ()
   	declare constructor (byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL)
   	declare constructor (byref location as PointF, byref sz as SizeF)
	declare function Clone () as RectF ptr
	declare sub GetLocation (byval pt as PointF ptr)
	declare sub GetSize (byval sz as SizeF ptr)
	declare sub GetBounds (byval rect as RectF ptr)
	declare function GetLeft () as REAL
	declare function GetTop () as REAL
	declare function GetRight () as REAL
	declare function GetBottom () as REAL
	declare function IsEmptyArea () as BOOL
	declare function Equals (byref rect as RectF) as BOOL
	declare function Contains (byval x as REAL, byval y as REAL) as BOOL
	declare function Contains (byref pt as PointF) as BOOL
	declare function Contains (byref rect as RectF) as BOOL
	declare sub Inflate (byval dx as REAL, byval dy as REAL)
	declare sub Inflate (byref pt as PointF)
	declare function Intersect (byref rect as RectF) as BOOL
	declare function Intersect (byref c as RectF, byref a as RectF, byref b as RectF) as BOOL
	declare function IntersectsWith (byval rect as RectF) as BOOL
	declare function Union_ (byref c as RectF, byref a as RectF, byref b as RectF) as BOOL
	declare sub Offset (byref pt as PointF)
	declare sub Offset (byval dx as REAL, byval dy as REAL)

	X as REAL
	Y as REAL
	Width as REAL
	Height as REAL
end type

private constructor RectF ()
	this.X = 0
	this.Y = 0
	this.Width = 0
	this.Height = 0
end constructor

private constructor RectF (byval x as REAL, byval y as REAL, byval w as REAL, byval h as REAL)
	this.X = x
	this.Y = y
	this.Width = w
	this.Height = h
end constructor

private constructor RectF (byref location as PointF, byref sz as SizeF)
	this.X = location.x
	this.Y = location.y
	this.Width = sz.width
	this.Height = sz.height
end constructor

type Rect
   	declare constructor ()
   	declare constructor (byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_)
   	declare constructor (byref location as Point, byref sz as Size)
	declare function Clone () as Rect ptr
	declare sub GetLocation (byval pt as Point ptr)
	declare sub GetSize (byval sz as Size ptr)
	declare sub GetBounds (byval rect as Rect ptr)
	declare function GetLeft () as INT_
	declare function GetTop () as INT_
	declare function GetRight () as INT_
	declare function GetBottom () as INT_
	declare function IsEmptyArea () as BOOL
	declare function Equals (byref rect as Rect) as BOOL
	declare function Contains (byval x as INT_, byval y as INT_) as BOOL
	declare function Contains (byref pt as Point) as BOOL
	declare function Contains (byref rect as Rect) as BOOL
	declare sub Inflate (byval dx as INT_, byval dy as INT_)
	declare sub Inflate (byref pt as Point)
	declare function Intersect (byref rect as Rect) as BOOL
	declare function Intersect (byref c as Rect, byref a as Rect, byref b as Rect) as BOOL
	declare function IntersectsWith (byval rect as Rect) as BOOL
	declare function Union_ (byref c as Rect, byref a as Rect, byref b as Rect) as BOOL
	declare sub Offset (byref pt as Point)
	declare sub Offset (byval dx as INT_, byval dy as INT_)

	X as INT_
	Y as INT_
	Width as INT_
	Height as INT_
end type

private constructor Rect ()
	this.X = 0
	this.Y = 0
	this.Width = 0
	this.Height = 0
end constructor

private constructor Rect (byval x as INT_, byval y as INT_, byval w as INT_, byval h as INT_)
	this.X = x
	this.Y = y
	this.Width = w
	this.Height = h
end constructor

private constructor Rect (byref location as Point, byref sz as Size)
	this.X = location.x
	this.Y = location.y
	this.Width = sz.width
	this.Height = sz.height
end constructor

type PathData
	declare constructor ()
	declare destructor ()
	Count as INT_
	Points as PointF ptr
	Types as UBYTE ptr
end type

private constructor PathData()
	Count = 0
    Points = NULL
    Types = NULL
end constructor

private destructor PathData()
	if( Points <> NULL ) then
    '''''delete Points
	end if

	if( Types <> NULL ) then
	'''''delete Types
	end if
end destructor

type CharacterRange
	declare constructor (byval first as INT_, byval length as INT_)
	declare constructor ()
	First as INT_
	Length as INT_
end type

private constructor CharacterRange (byval first as INT_, byval length as INT_)
	this.First = first
	this.Length = length
end constructor

private constructor CharacterRange ()
	this.First = 0
	this.Length = 0
end constructor


'' !!!WRITEME!!! the SizeF, Size, PointF, Point, RectF, Rect, PathData and CharacterRange methods

#endif
