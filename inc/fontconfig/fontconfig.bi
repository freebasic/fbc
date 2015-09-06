'' FreeBASIC binding for fontconfig-2.11.1
''
'' based on the C header files:
''   fontconfig/fontconfig/fontconfig.h
''
''   Copyright © 2001 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of the author(s) not be used in
''   advertising or publicity pertaining to distribution of the software without
''   specific, written prior permission.  The authors make no
''   representations about the suitability of this software for any purpose.  It
''   is provided "as is" without express or implied warranty.
''
''   THE AUTHOR(S) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
''   PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/sys/types.bi"
#include once "crt/stdarg.bi"
type stat as stat_  '' TODO: remove as soon as fbc's CRT headers define it

extern "C"

#define _FONTCONFIG_H_
#define FcPublic
type FcChar8 as ubyte
type FcChar16 as ushort
type FcChar32 as ulong
type FcBool as long

const FC_MAJOR = 2
const FC_MINOR = 11
const FC_REVISION = 1
const FC_VERSION = ((FC_MAJOR * 10000) + (FC_MINOR * 100)) + FC_REVISION
#define FC_CACHE_VERSION "4"
const FcTrue = 1
const FcFalse = 0
#define FC_FAMILY "family"
#define FC_STYLE "style"
#define FC_SLANT "slant"
#define FC_WEIGHT "weight"
#define FC_SIZE "size"
#define FC_ASPECT "aspect"
#define FC_PIXEL_SIZE "pixelsize"
#define FC_SPACING "spacing"
#define FC_FOUNDRY "foundry"
#define FC_ANTIALIAS "antialias"
#define FC_HINTING "hinting"
#define FC_HINT_STYLE "hintstyle"
#define FC_VERTICAL_LAYOUT "verticallayout"
#define FC_AUTOHINT "autohint"
#define FC_GLOBAL_ADVANCE "globaladvance"
#define FC_WIDTH "width"
#define FC_FILE "file"
#define FC_INDEX "index"
#define FC_FT_FACE "ftface"
#define FC_RASTERIZER "rasterizer"
#define FC_OUTLINE "outline"
#define FC_SCALABLE "scalable"
#define FC_SCALE "scale"
#define FC_DPI "dpi"
#define FC_RGBA "rgba"
#define FC_MINSPACE "minspace"
#define FC_SOURCE "source"
#define FC_CHARSET "charset"
#define FC_LANG "lang"
#define FC_FONTVERSION "fontversion"
#define FC_FULLNAME "fullname"
#define FC_FAMILYLANG "familylang"
#define FC_STYLELANG "stylelang"
#define FC_FULLNAMELANG "fullnamelang"
#define FC_CAPABILITY "capability"
#define FC_FONTFORMAT "fontformat"
#define FC_EMBOLDEN "embolden"
#define FC_EMBEDDED_BITMAP "embeddedbitmap"
#define FC_DECORATIVE "decorative"
#define FC_LCD_FILTER "lcdfilter"
#define FC_FONT_FEATURES "fontfeatures"
#define FC_NAMELANG "namelang"
#define FC_PRGNAME "prgname"
#define FC_HASH "hash"
#define FC_POSTSCRIPT_NAME "postscriptname"
#define FC_CACHE_SUFFIX ".cache-" FC_CACHE_VERSION
#define FC_DIR_CACHE_FILE "fonts.cache-" FC_CACHE_VERSION
#define FC_USER_CACHE_FILE ".fonts.cache-" FC_CACHE_VERSION
#define FC_CHAR_WIDTH "charwidth"
#define FC_CHAR_HEIGHT "charheight"
#define FC_MATRIX "matrix"
const FC_WEIGHT_THIN = 0
const FC_WEIGHT_EXTRALIGHT = 40
const FC_WEIGHT_ULTRALIGHT = FC_WEIGHT_EXTRALIGHT
const FC_WEIGHT_LIGHT = 50
const FC_WEIGHT_BOOK = 75
const FC_WEIGHT_REGULAR = 80
const FC_WEIGHT_NORMAL = FC_WEIGHT_REGULAR
const FC_WEIGHT_MEDIUM = 100
const FC_WEIGHT_DEMIBOLD = 180
const FC_WEIGHT_SEMIBOLD = FC_WEIGHT_DEMIBOLD
const FC_WEIGHT_BOLD = 200
const FC_WEIGHT_EXTRABOLD = 205
const FC_WEIGHT_ULTRABOLD = FC_WEIGHT_EXTRABOLD
const FC_WEIGHT_BLACK = 210
const FC_WEIGHT_HEAVY = FC_WEIGHT_BLACK
const FC_WEIGHT_EXTRABLACK = 215
const FC_WEIGHT_ULTRABLACK = FC_WEIGHT_EXTRABLACK
const FC_SLANT_ROMAN = 0
const FC_SLANT_ITALIC = 100
const FC_SLANT_OBLIQUE = 110
const FC_WIDTH_ULTRACONDENSED = 50
const FC_WIDTH_EXTRACONDENSED = 63
const FC_WIDTH_CONDENSED = 75
const FC_WIDTH_SEMICONDENSED = 87
const FC_WIDTH_NORMAL = 100
const FC_WIDTH_SEMIEXPANDED = 113
const FC_WIDTH_EXPANDED = 125
const FC_WIDTH_EXTRAEXPANDED = 150
const FC_WIDTH_ULTRAEXPANDED = 200
const FC_PROPORTIONAL = 0
const FC_DUAL = 90
const FC_MONO = 100
const FC_CHARCELL = 110
const FC_RGBA_UNKNOWN = 0
const FC_RGBA_RGB = 1
const FC_RGBA_BGR = 2
const FC_RGBA_VRGB = 3
const FC_RGBA_VBGR = 4
const FC_RGBA_NONE = 5
const FC_HINT_NONE = 0
const FC_HINT_SLIGHT = 1
const FC_HINT_MEDIUM = 2
const FC_HINT_FULL = 3
const FC_LCD_NONE = 0
const FC_LCD_DEFAULT = 1
const FC_LCD_LIGHT = 2
const FC_LCD_LEGACY = 3

type _FcType as long
enum
	FcTypeUnknown = -1
	FcTypeVoid
	FcTypeInteger
	FcTypeDouble
	FcTypeString
	FcTypeBool
	FcTypeMatrix
	FcTypeCharSet
	FcTypeFTFace
	FcTypeLangSet
end enum

type FcType as _FcType

type _FcMatrix
	xx as double
	xy as double
	yx as double
	yy as double
end type

type FcMatrix as _FcMatrix
#macro FcMatrixInit(m)
	scope
		(m)->xx = 1
		(m)->yy = 1
		(m)->xy = 0
		(m)->yx = 0
	end scope
#endmacro
type FcCharSet as _FcCharSet

type _FcObjectType
	object as const zstring ptr
	as FcType type
end type

type FcObjectType as _FcObjectType

type _FcConstant
	name as const FcChar8 ptr
	object as const zstring ptr
	value as long
end type

type FcConstant as _FcConstant

type _FcResult as long
enum
	FcResultMatch
	FcResultNoMatch
	FcResultTypeMismatch
	FcResultNoId
	FcResultOutOfMemory
end enum

type FcResult as _FcResult
type FcPattern as _FcPattern
type FcLangSet as _FcLangSet

union _FcValue_u
	s as const FcChar8 ptr
	i as long
	b as FcBool
	d as double
	m as const FcMatrix ptr
	c as const FcCharSet ptr
	f as any ptr
	l as const FcLangSet ptr
end union

type _FcValue
	as FcType type
	u as _FcValue_u
end type

type FcValue as _FcValue

type _FcFontSet
	nfont as long
	sfont as long
	fonts as FcPattern ptr ptr
end type

type FcFontSet as _FcFontSet

type _FcObjectSet
	nobject as long
	sobject as long
	objects as const zstring ptr ptr
end type

type FcObjectSet as _FcObjectSet

type _FcMatchKind as long
enum
	FcMatchPattern
	FcMatchFont
	FcMatchScan
end enum

type FcMatchKind as _FcMatchKind

type _FcLangResult as long
enum
	FcLangEqual = 0
	FcLangDifferentCountry = 1
	FcLangDifferentTerritory = 1
	FcLangDifferentLang = 2
end enum

type FcLangResult as _FcLangResult

type _FcSetName as long
enum
	FcSetSystem = 0
	FcSetApplication = 1
end enum

type FcSetName as _FcSetName
type FcAtomic as _FcAtomic
#define _FCFUNCPROTOBEGIN
#define _FCFUNCPROTOEND

type FcEndian as long
enum
	FcEndianBig
	FcEndianLittle
end enum

type FcConfig as _FcConfig
type FcFileCache as _FcGlobalCache
type FcBlanks as _FcBlanks
type FcStrList as _FcStrList
type FcStrSet as _FcStrSet
type FcCache as _FcCache

declare function FcBlanksCreate() as FcBlanks ptr
declare sub FcBlanksDestroy(byval b as FcBlanks ptr)
declare function FcBlanksAdd(byval b as FcBlanks ptr, byval ucs4 as FcChar32) as FcBool
declare function FcBlanksIsMember(byval b as FcBlanks ptr, byval ucs4 as FcChar32) as FcBool
declare function FcCacheDir(byval c as const FcCache ptr) as const FcChar8 ptr
declare function FcCacheCopySet(byval c as const FcCache ptr) as FcFontSet ptr
declare function FcCacheSubdir(byval c as const FcCache ptr, byval i as long) as const FcChar8 ptr
declare function FcCacheNumSubdir(byval c as const FcCache ptr) as long
declare function FcCacheNumFont(byval c as const FcCache ptr) as long
declare function FcDirCacheUnlink(byval dir as const FcChar8 ptr, byval config as FcConfig ptr) as FcBool
declare function FcDirCacheValid(byval cache_file as const FcChar8 ptr) as FcBool
declare function FcDirCacheClean(byval cache_dir as const FcChar8 ptr, byval verbose as FcBool) as FcBool
declare sub FcCacheCreateTagFile(byval config as const FcConfig ptr)
declare function FcConfigHome() as FcChar8 ptr
declare function FcConfigEnableHome(byval enable as FcBool) as FcBool
declare function FcConfigFilename(byval url as const FcChar8 ptr) as FcChar8 ptr
declare function FcConfigCreate() as FcConfig ptr
declare function FcConfigReference(byval config as FcConfig ptr) as FcConfig ptr
declare sub FcConfigDestroy(byval config as FcConfig ptr)
declare function FcConfigSetCurrent(byval config as FcConfig ptr) as FcBool
declare function FcConfigGetCurrent() as FcConfig ptr
declare function FcConfigUptoDate(byval config as FcConfig ptr) as FcBool
declare function FcConfigBuildFonts(byval config as FcConfig ptr) as FcBool
declare function FcConfigGetFontDirs(byval config as FcConfig ptr) as FcStrList ptr
declare function FcConfigGetConfigDirs(byval config as FcConfig ptr) as FcStrList ptr
declare function FcConfigGetConfigFiles(byval config as FcConfig ptr) as FcStrList ptr
declare function FcConfigGetCache(byval config as FcConfig ptr) as FcChar8 ptr
declare function FcConfigGetBlanks(byval config as FcConfig ptr) as FcBlanks ptr
declare function FcConfigGetCacheDirs(byval config as const FcConfig ptr) as FcStrList ptr
declare function FcConfigGetRescanInterval(byval config as FcConfig ptr) as long
declare function FcConfigSetRescanInterval(byval config as FcConfig ptr, byval rescanInterval as long) as FcBool
declare function FcConfigGetFonts(byval config as FcConfig ptr, byval set as FcSetName) as FcFontSet ptr
declare function FcConfigAppFontAddFile(byval config as FcConfig ptr, byval file as const FcChar8 ptr) as FcBool
declare function FcConfigAppFontAddDir(byval config as FcConfig ptr, byval dir as const FcChar8 ptr) as FcBool
declare sub FcConfigAppFontClear(byval config as FcConfig ptr)
declare function FcConfigSubstituteWithPat(byval config as FcConfig ptr, byval p as FcPattern ptr, byval p_pat as FcPattern ptr, byval kind as FcMatchKind) as FcBool
declare function FcConfigSubstitute(byval config as FcConfig ptr, byval p as FcPattern ptr, byval kind as FcMatchKind) as FcBool
declare function FcConfigGetSysRoot(byval config as const FcConfig ptr) as const FcChar8 ptr
declare sub FcConfigSetSysRoot(byval config as FcConfig ptr, byval sysroot as const FcChar8 ptr)
declare function FcCharSetCreate() as FcCharSet ptr
declare function FcCharSetNew() as FcCharSet ptr
declare sub FcCharSetDestroy(byval fcs as FcCharSet ptr)
declare function FcCharSetAddChar(byval fcs as FcCharSet ptr, byval ucs4 as FcChar32) as FcBool
declare function FcCharSetDelChar(byval fcs as FcCharSet ptr, byval ucs4 as FcChar32) as FcBool
declare function FcCharSetCopy(byval src as FcCharSet ptr) as FcCharSet ptr
declare function FcCharSetEqual(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcBool
declare function FcCharSetIntersect(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcCharSet ptr
declare function FcCharSetUnion(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcCharSet ptr
declare function FcCharSetSubtract(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcCharSet ptr
declare function FcCharSetMerge(byval a as FcCharSet ptr, byval b as const FcCharSet ptr, byval changed as FcBool ptr) as FcBool
declare function FcCharSetHasChar(byval fcs as const FcCharSet ptr, byval ucs4 as FcChar32) as FcBool
declare function FcCharSetCount(byval a as const FcCharSet ptr) as FcChar32
declare function FcCharSetIntersectCount(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcChar32
declare function FcCharSetSubtractCount(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcChar32
declare function FcCharSetIsSubset(byval a as const FcCharSet ptr, byval b as const FcCharSet ptr) as FcBool
const FC_CHARSET_MAP_SIZE = 256 / 32
const FC_CHARSET_DONE = cast(FcChar32, -1)
declare function FcCharSetFirstPage(byval a as const FcCharSet ptr, byval map as FcChar32 ptr, byval next as FcChar32 ptr) as FcChar32
declare function FcCharSetNextPage(byval a as const FcCharSet ptr, byval map as FcChar32 ptr, byval next as FcChar32 ptr) as FcChar32
declare function FcCharSetCoverage(byval a as const FcCharSet ptr, byval page as FcChar32, byval result as FcChar32 ptr) as FcChar32
declare sub FcValuePrint(byval v as const FcValue)
declare sub FcPatternPrint(byval p as const FcPattern ptr)
declare sub FcFontSetPrint(byval s as const FcFontSet ptr)
declare function FcGetDefaultLangs() as FcStrSet ptr
declare sub FcDefaultSubstitute(byval pattern as FcPattern ptr)
declare function FcFileIsDir(byval file as const FcChar8 ptr) as FcBool
declare function FcFileScan(byval set as FcFontSet ptr, byval dirs as FcStrSet ptr, byval cache as FcFileCache ptr, byval blanks as FcBlanks ptr, byval file as const FcChar8 ptr, byval force as FcBool) as FcBool
declare function FcDirScan(byval set as FcFontSet ptr, byval dirs as FcStrSet ptr, byval cache as FcFileCache ptr, byval blanks as FcBlanks ptr, byval dir as const FcChar8 ptr, byval force as FcBool) as FcBool
declare function FcDirSave(byval set as FcFontSet ptr, byval dirs as FcStrSet ptr, byval dir as const FcChar8 ptr) as FcBool
declare function FcDirCacheLoad(byval dir as const FcChar8 ptr, byval config as FcConfig ptr, byval cache_file as FcChar8 ptr ptr) as FcCache ptr
declare function FcDirCacheRescan(byval dir as const FcChar8 ptr, byval config as FcConfig ptr) as FcCache ptr
declare function FcDirCacheRead(byval dir as const FcChar8 ptr, byval force as FcBool, byval config as FcConfig ptr) as FcCache ptr
declare function FcDirCacheLoadFile(byval cache_file as const FcChar8 ptr, byval file_stat as stat ptr) as FcCache ptr
declare sub FcDirCacheUnload(byval cache as FcCache ptr)
declare function FcFreeTypeQuery(byval file as const FcChar8 ptr, byval id as long, byval blanks as FcBlanks ptr, byval count as long ptr) as FcPattern ptr
declare function FcFontSetCreate() as FcFontSet ptr
declare sub FcFontSetDestroy(byval s as FcFontSet ptr)
declare function FcFontSetAdd(byval s as FcFontSet ptr, byval font as FcPattern ptr) as FcBool
declare function FcInitLoadConfig() as FcConfig ptr
declare function FcInitLoadConfigAndFonts() as FcConfig ptr
declare function FcInit() as FcBool
declare sub FcFini()
declare function FcGetVersion() as long
declare function FcInitReinitialize() as FcBool
declare function FcInitBringUptoDate() as FcBool
declare function FcGetLangs() as FcStrSet ptr
declare function FcLangNormalize(byval lang as const FcChar8 ptr) as FcChar8 ptr
declare function FcLangGetCharSet(byval lang as const FcChar8 ptr) as const FcCharSet ptr
declare function FcLangSetCreate() as FcLangSet ptr
declare sub FcLangSetDestroy(byval ls as FcLangSet ptr)
declare function FcLangSetCopy(byval ls as const FcLangSet ptr) as FcLangSet ptr
declare function FcLangSetAdd(byval ls as FcLangSet ptr, byval lang as const FcChar8 ptr) as FcBool
declare function FcLangSetDel(byval ls as FcLangSet ptr, byval lang as const FcChar8 ptr) as FcBool
declare function FcLangSetHasLang(byval ls as const FcLangSet ptr, byval lang as const FcChar8 ptr) as FcLangResult
declare function FcLangSetCompare(byval lsa as const FcLangSet ptr, byval lsb as const FcLangSet ptr) as FcLangResult
declare function FcLangSetContains(byval lsa as const FcLangSet ptr, byval lsb as const FcLangSet ptr) as FcBool
declare function FcLangSetEqual(byval lsa as const FcLangSet ptr, byval lsb as const FcLangSet ptr) as FcBool
declare function FcLangSetHash(byval ls as const FcLangSet ptr) as FcChar32
declare function FcLangSetGetLangs(byval ls as const FcLangSet ptr) as FcStrSet ptr
declare function FcLangSetUnion(byval a as const FcLangSet ptr, byval b as const FcLangSet ptr) as FcLangSet ptr
declare function FcLangSetSubtract(byval a as const FcLangSet ptr, byval b as const FcLangSet ptr) as FcLangSet ptr
declare function FcObjectSetCreate() as FcObjectSet ptr
declare function FcObjectSetAdd(byval os as FcObjectSet ptr, byval object as const zstring ptr) as FcBool
declare sub FcObjectSetDestroy(byval os as FcObjectSet ptr)
declare function FcObjectSetVaBuild(byval first as const zstring ptr, byval va as va_list) as FcObjectSet ptr
declare function FcObjectSetBuild(byval first as const zstring ptr, ...) as FcObjectSet ptr
declare function FcFontSetList(byval config as FcConfig ptr, byval sets as FcFontSet ptr ptr, byval nsets as long, byval p as FcPattern ptr, byval os as FcObjectSet ptr) as FcFontSet ptr
declare function FcFontList(byval config as FcConfig ptr, byval p as FcPattern ptr, byval os as FcObjectSet ptr) as FcFontSet ptr
declare function FcAtomicCreate(byval file as const FcChar8 ptr) as FcAtomic ptr
declare function FcAtomicLock(byval atomic as FcAtomic ptr) as FcBool
declare function FcAtomicNewFile(byval atomic as FcAtomic ptr) as FcChar8 ptr
declare function FcAtomicOrigFile(byval atomic as FcAtomic ptr) as FcChar8 ptr
declare function FcAtomicReplaceOrig(byval atomic as FcAtomic ptr) as FcBool
declare sub FcAtomicDeleteNew(byval atomic as FcAtomic ptr)
declare sub FcAtomicUnlock(byval atomic as FcAtomic ptr)
declare sub FcAtomicDestroy(byval atomic as FcAtomic ptr)
declare function FcFontSetMatch(byval config as FcConfig ptr, byval sets as FcFontSet ptr ptr, byval nsets as long, byval p as FcPattern ptr, byval result as FcResult ptr) as FcPattern ptr
declare function FcFontMatch(byval config as FcConfig ptr, byval p as FcPattern ptr, byval result as FcResult ptr) as FcPattern ptr
declare function FcFontRenderPrepare(byval config as FcConfig ptr, byval pat as FcPattern ptr, byval font as FcPattern ptr) as FcPattern ptr
declare function FcFontSetSort(byval config as FcConfig ptr, byval sets as FcFontSet ptr ptr, byval nsets as long, byval p as FcPattern ptr, byval trim as FcBool, byval csp as FcCharSet ptr ptr, byval result as FcResult ptr) as FcFontSet ptr
declare function FcFontSort(byval config as FcConfig ptr, byval p as FcPattern ptr, byval trim as FcBool, byval csp as FcCharSet ptr ptr, byval result as FcResult ptr) as FcFontSet ptr
declare sub FcFontSetSortDestroy(byval fs as FcFontSet ptr)
declare function FcMatrixCopy(byval mat as const FcMatrix ptr) as FcMatrix ptr
declare function FcMatrixEqual(byval mat1 as const FcMatrix ptr, byval mat2 as const FcMatrix ptr) as FcBool
declare sub FcMatrixMultiply(byval result as FcMatrix ptr, byval a as const FcMatrix ptr, byval b as const FcMatrix ptr)
declare sub FcMatrixRotate(byval m as FcMatrix ptr, byval c as double, byval s as double)
declare sub FcMatrixScale(byval m as FcMatrix ptr, byval sx as double, byval sy as double)
declare sub FcMatrixShear(byval m as FcMatrix ptr, byval sh as double, byval sv as double)
declare function FcNameRegisterObjectTypes(byval types as const FcObjectType ptr, byval ntype as long) as FcBool
declare function FcNameUnregisterObjectTypes(byval types as const FcObjectType ptr, byval ntype as long) as FcBool
declare function FcNameGetObjectType(byval object as const zstring ptr) as const FcObjectType ptr
declare function FcNameRegisterConstants(byval consts as const FcConstant ptr, byval nconsts as long) as FcBool
declare function FcNameUnregisterConstants(byval consts as const FcConstant ptr, byval nconsts as long) as FcBool
declare function FcNameGetConstant(byval string as const FcChar8 ptr) as const FcConstant ptr
declare function FcNameConstant(byval string as const FcChar8 ptr, byval result as long ptr) as FcBool
declare function FcNameParse(byval name as const FcChar8 ptr) as FcPattern ptr
declare function FcNameUnparse(byval pat as FcPattern ptr) as FcChar8 ptr
declare function FcPatternCreate() as FcPattern ptr
declare function FcPatternDuplicate(byval p as const FcPattern ptr) as FcPattern ptr
declare sub FcPatternReference(byval p as FcPattern ptr)
declare function FcPatternFilter(byval p as FcPattern ptr, byval os as const FcObjectSet ptr) as FcPattern ptr
declare sub FcValueDestroy(byval v as FcValue)
declare function FcValueEqual(byval va as FcValue, byval vb as FcValue) as FcBool
declare function FcValueSave(byval v as FcValue) as FcValue
declare sub FcPatternDestroy(byval p as FcPattern ptr)
declare function FcPatternEqual(byval pa as const FcPattern ptr, byval pb as const FcPattern ptr) as FcBool
declare function FcPatternEqualSubset(byval pa as const FcPattern ptr, byval pb as const FcPattern ptr, byval os as const FcObjectSet ptr) as FcBool
declare function FcPatternHash(byval p as const FcPattern ptr) as FcChar32
declare function FcPatternAdd(byval p as FcPattern ptr, byval object as const zstring ptr, byval value as FcValue, byval append as FcBool) as FcBool
declare function FcPatternAddWeak(byval p as FcPattern ptr, byval object as const zstring ptr, byval value as FcValue, byval append as FcBool) as FcBool
declare function FcPatternGet(byval p as const FcPattern ptr, byval object as const zstring ptr, byval id as long, byval v as FcValue ptr) as FcResult
declare function FcPatternDel(byval p as FcPattern ptr, byval object as const zstring ptr) as FcBool
declare function FcPatternRemove(byval p as FcPattern ptr, byval object as const zstring ptr, byval id as long) as FcBool
declare function FcPatternAddInteger(byval p as FcPattern ptr, byval object as const zstring ptr, byval i as long) as FcBool
declare function FcPatternAddDouble(byval p as FcPattern ptr, byval object as const zstring ptr, byval d as double) as FcBool
declare function FcPatternAddString(byval p as FcPattern ptr, byval object as const zstring ptr, byval s as const FcChar8 ptr) as FcBool
declare function FcPatternAddMatrix(byval p as FcPattern ptr, byval object as const zstring ptr, byval s as const FcMatrix ptr) as FcBool
declare function FcPatternAddCharSet(byval p as FcPattern ptr, byval object as const zstring ptr, byval c as const FcCharSet ptr) as FcBool
declare function FcPatternAddBool(byval p as FcPattern ptr, byval object as const zstring ptr, byval b as FcBool) as FcBool
declare function FcPatternAddLangSet(byval p as FcPattern ptr, byval object as const zstring ptr, byval ls as const FcLangSet ptr) as FcBool
declare function FcPatternGetInteger(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval i as long ptr) as FcResult
declare function FcPatternGetDouble(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval d as double ptr) as FcResult
declare function FcPatternGetString(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval s as FcChar8 ptr ptr) as FcResult
declare function FcPatternGetMatrix(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval s as FcMatrix ptr ptr) as FcResult
declare function FcPatternGetCharSet(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval c as FcCharSet ptr ptr) as FcResult
declare function FcPatternGetBool(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval b as FcBool ptr) as FcResult
declare function FcPatternGetLangSet(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval ls as FcLangSet ptr ptr) as FcResult
declare function FcPatternVaBuild(byval p as FcPattern ptr, byval va as va_list) as FcPattern ptr
declare function FcPatternBuild(byval p as FcPattern ptr, ...) as FcPattern ptr
declare function FcPatternFormat(byval pat as FcPattern ptr, byval format as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrCopy(byval s as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrCopyFilename(byval s as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrPlus(byval s1 as const FcChar8 ptr, byval s2 as const FcChar8 ptr) as FcChar8 ptr
declare sub FcStrFree(byval s as FcChar8 ptr)

#define FcIsUpper(c) ((&o101 <= (c)) andalso ((c) <= &o132))
#define FcIsLower(c) ((&o141 <= (c)) andalso ((c) <= &o172))
#define FcToLower(c) iif(FcIsUpper(c), ((c) - &o101) + &o141, (c))

declare function FcStrDowncase(byval s as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrCmpIgnoreCase(byval s1 as const FcChar8 ptr, byval s2 as const FcChar8 ptr) as long
declare function FcStrCmp(byval s1 as const FcChar8 ptr, byval s2 as const FcChar8 ptr) as long
declare function FcStrStrIgnoreCase(byval s1 as const FcChar8 ptr, byval s2 as const FcChar8 ptr) as const FcChar8 ptr
declare function FcStrStr(byval s1 as const FcChar8 ptr, byval s2 as const FcChar8 ptr) as const FcChar8 ptr
declare function FcUtf8ToUcs4(byval src_orig as const FcChar8 ptr, byval dst as FcChar32 ptr, byval len as long) as long
declare function FcUtf8Len(byval string as const FcChar8 ptr, byval len as long, byval nchar as long ptr, byval wchar as long ptr) as FcBool
const FC_UTF8_MAX_LEN = 6
declare function FcUcs4ToUtf8(byval ucs4 as FcChar32, byval dest as FcChar8 ptr) as long
declare function FcUtf16ToUcs4(byval src_orig as const FcChar8 ptr, byval endian as FcEndian, byval dst as FcChar32 ptr, byval len as long) as long
declare function FcUtf16Len(byval string as const FcChar8 ptr, byval endian as FcEndian, byval len as long, byval nchar as long ptr, byval wchar as long ptr) as FcBool
declare function FcStrDirname(byval file as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrBasename(byval file as const FcChar8 ptr) as FcChar8 ptr
declare function FcStrSetCreate() as FcStrSet ptr
declare function FcStrSetMember(byval set as FcStrSet ptr, byval s as const FcChar8 ptr) as FcBool
declare function FcStrSetEqual(byval sa as FcStrSet ptr, byval sb as FcStrSet ptr) as FcBool
declare function FcStrSetAdd(byval set as FcStrSet ptr, byval s as const FcChar8 ptr) as FcBool
declare function FcStrSetAddFilename(byval set as FcStrSet ptr, byval s as const FcChar8 ptr) as FcBool
declare function FcStrSetDel(byval set as FcStrSet ptr, byval s as const FcChar8 ptr) as FcBool
declare sub FcStrSetDestroy(byval set as FcStrSet ptr)
declare function FcStrListCreate(byval set as FcStrSet ptr) as FcStrList ptr
declare sub FcStrListFirst(byval list as FcStrList ptr)
declare function FcStrListNext(byval list as FcStrList ptr) as FcChar8 ptr
declare sub FcStrListDone(byval list as FcStrList ptr)
declare function FcConfigParseAndLoad(byval config as FcConfig ptr, byval file as const FcChar8 ptr, byval complain as FcBool) as FcBool
#undef FC_ATTRIBUTE_SENTINEL
#define FcConfigGetRescanInverval FcConfigGetRescanInverval_REPLACE_BY_FcConfigGetRescanInterval
#define FcConfigSetRescanInverval FcConfigSetRescanInverval_REPLACE_BY_FcConfigSetRescanInterval

end extern
