'' FreeBASIC binding for raylib-3.0.0
''
'' based on the C header files:
''    LICENSE: zlib/libpng
''
''    raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
''    BSD-like license that allows static linking with closed source software:
''
''    Copyright (c) 2013-2020 Ramon Santamaria (@raysan5)
''
''    This software is provided "as-is", without any express or implied warranty. In no event
''    will the authors be held liable for any damages arising from the use of this software.
''
''    Permission is granted to anyone to use this software for any purpose, including commercial
''    applications, and to alter it and redistribute it freely, subject to the following restrictions:
''
''      1. The origin of this software must not be misrepresented; you must not claim that you
''      wrote the original software. If you use this software in a product, an acknowledgment
''      in the product documentation would be appreciated but is not required.
''
''      2. Altered source versions must be plainly marked as such, and must not be misrepresented
''      as being the original software.
''
''      3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "raylib"

#if defined(__FB_CYGWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#inclib "GL"
	#inclib "X11"
#endif

#ifdef __FB_LINUX__
	#inclib "dl"
	#inclib "rt"
#elseif defined(__FB_CYGWIN__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#inclib "Xrandr"
	#inclib "Xinerama"
	#inclib "Xi"
	#inclib "Xxf86vm"
	#inclib "Xcursor"
#elseif defined(__FB_DARWIN__)
	#inclib "OpenGL"
	#inclib "Cocoa"
#elseif defined(__FB_WIN32__)
	#inclib "opengl32"
	#inclib "gdi32"
	#inclib "winmm"
#endif

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

extern "C"

#define RAYLIB_H
const PI = 3.14159265358979323846
const DEG2RAD = PI / 180.0f
const RAD2DEG = 180.0f / PI
const MAX_TOUCH_POINTS = 10
#define RL_MALLOC(sz) malloc(sz)
#define RL_CALLOC(n, sz) calloc(n, sz)
#define RL_REALLOC(ptr, sz) realloc(ptr, sz)
#define RL_FREE(ptr) free(ptr)

#define LIGHTGRAY    type<Color>( 200, 200, 200, 255 )
#define GRAY         type<Color>( 130, 130, 130, 255 )
#define DARKGRAY     type<Color>( 80, 80, 80, 255 )
#define YELLOW       type<Color>( 253, 249, 0, 255 )
#define GOLD         type<Color>( 255, 203, 0, 255 )
#define ORANGE       type<Color>( 255, 161, 0, 255 )
#define PINK         type<Color>( 255, 109, 194, 255 )
#define RED          type<Color>( 230, 41, 55, 255 )
#define MAROON       type<Color>( 190, 33, 55, 255 )
#define GREEN        type<Color>( 0, 228, 48, 255 )
#define LIME         type<Color>( 0, 158, 47, 255 )
#define DARKGREEN    type<Color>( 0, 117, 44, 255 )
#define SKYBLUE      type<Color>( 102, 191, 255, 255 )
#define BLUE         type<Color>( 0, 121, 241, 255 )
#define DARKBLUE     type<Color>( 0, 82, 172, 255 )
#define PURPLE       type<Color>( 200, 122, 255, 255 )
#define VIOLET       type<Color>( 135, 60, 190, 255 )
#define DARKPURPLE   type<Color>( 112, 31, 126, 255 )
#define BEIGE        type<Color>( 211, 176, 131, 255 )
#define BROWN        type<Color>( 127, 106, 79, 255 )
#define DARKBROWN    type<Color>( 76, 63, 47, 255 )
#define WHITE        type<Color>( 255, 255, 255, 255 )
#define BLACK        type<Color>( 0, 0, 0, 255 )
#define BLANK        type<Color>( 0, 0, 0, 0 )
#define MAGENTA      type<Color>( 255, 0, 255, 255 )
#define RAYWHITE     type<Color>( 245, 245, 245, 255 )

#ifndef Vector2
	type Vector2
		x as single
		y as single
	end type
#endif

#ifndef Vector3
	type Vector3
		x as single
		y as single
		z as single
	end type
#endif

type Vector4
	x as single
	y as single
	z as single
	w as single
end type

#ifndef Quaternion
	type Quaternion as Vector4
#endif

#ifndef Matrix
	type Matrix
		m0 as single
		m4 as single
		m8 as single
		m12 as single
		m1 as single
		m5 as single
		m9 as single
		m13 as single
		m2 as single
		m6 as single
		m10 as single
		m14 as single
		m3 as single
		m7 as single
		m11 as single
		m15 as single
	end type
#endif

type Color
	r as ubyte
	g as ubyte
	b as ubyte
	a as ubyte
end type

type Rectangle
	x as single
	y as single
	width as single
	height as single
end type

type Image
	data as any ptr
	width as long
	height as long
	mipmaps as long
	format as long
end type

type Texture2D
	id as ulong
	width as long
	height as long
	mipmaps as long
	format as long
end type

type Texture as Texture2D
type TextureCubemap as Texture2D

type RenderTexture2D
	id as ulong
	texture as Texture2D
	depth as Texture2D
	depthTexture as byte
end type

type RenderTexture as RenderTexture2D

type NPatchInfo
	sourceRec as Rectangle
	left as long
	top as long
	right as long
	bottom as long
	as long type
end type

type CharInfo
	value as long
	offsetX as long
	offsetY as long
	advanceX as long
	image as Image
end type

type Font
	baseSize as long
	charsCount as long
	texture as Texture2D
	recs as Rectangle ptr
	chars as CharInfo ptr
end type

type SpriteFont as Font

type Camera3D
	position as Vector3
	target as Vector3
	up as Vector3
	fovy as single
	as long type
end type

type Camera as Camera3D

type Camera2D
	offset as Vector2
	target as Vector2
	rotation as single
	zoom as single
end type

type Mesh
	vertexCount as long
	triangleCount as long
	vertices as single ptr
	texcoords as single ptr
	texcoords2 as single ptr
	normals as single ptr
	tangents as single ptr
	colors as ubyte ptr
	indices as ushort ptr
	animVertices as single ptr
	animNormals as single ptr
	boneIds as long ptr
	boneWeights as single ptr
	vaoId as ulong
	vboId as ulong ptr
end type

type Shader
	id as ulong
	locs as long ptr
end type

type MaterialMap
	texture as Texture2D
	color as Color
	value as single
end type

type Material
	shader as Shader
	maps as MaterialMap ptr
	params as single ptr
end type

type Transform
	translation as Vector3
	rotation as Quaternion
	scale as Vector3
end type

type BoneInfo
	name as zstring * 32
	parent as long
end type

type Model
	transform as Matrix
	meshCount as long
	meshes as Mesh ptr
	materialCount as long
	materials as Material ptr
	meshMaterial as long ptr
	boneCount as long
	bones as BoneInfo ptr
	bindPose as Transform ptr
end type

type ModelAnimation
	boneCount as long
	bones as BoneInfo ptr
	frameCount as long
	framePoses as Transform ptr ptr
end type

type Ray
	position as Vector3
	direction as Vector3
end type

type RayHitInfo
	hit as byte
	distance as single
	position as Vector3
	normal as Vector3
end type

type BoundingBox
	min as Vector3
	max as Vector3
end type

type Wave
	sampleCount as ulong
	sampleRate as ulong
	sampleSize as ulong
	channels as ulong
	data as any ptr
end type

type rAudioBuffer as rAudioBuffer_

type AudioStream
	sampleRate as ulong
	sampleSize as ulong
	channels as ulong
	buffer as rAudioBuffer ptr
end type

type Sound
	sampleCount as ulong
	stream as AudioStream
end type

type Music
	ctxType as long
	ctxData as any ptr
	sampleCount as ulong
	loopCount as ulong
	stream as AudioStream
end type

type VrDeviceInfo
	hResolution as long
	vResolution as long
	hScreenSize as single
	vScreenSize as single
	vScreenCenter as single
	eyeToScreenDistance as single
	lensSeparationDistance as single
	interpupillaryDistance as single
	lensDistortionValues(0 to 3) as single
	chromaAbCorrection(0 to 3) as single
end type

type ConfigFlag as long
enum
	FLAG_RESERVED = 1
	FLAG_FULLSCREEN_MODE = 2
	FLAG_WINDOW_RESIZABLE = 4
	FLAG_WINDOW_UNDECORATED = 8
	FLAG_WINDOW_TRANSPARENT = 16
	FLAG_WINDOW_HIDDEN = 128
	FLAG_WINDOW_ALWAYS_RUN = 256
	FLAG_MSAA_4X_HINT = 32
	FLAG_VSYNC_HINT = 64
end enum

type TraceLogType as long
enum
	LOG_ALL = 0
	LOG_TRACE
	LOG_DEBUG
	LOG_INFO
	LOG_WARNING
	LOG_ERROR
	LOG_FATAL
	LOG_NONE
end enum

type KeyboardKey as long
enum
	KEY_APOSTROPHE = 39
	KEY_COMMA = 44
	KEY_MINUS = 45
	KEY_PERIOD = 46
	KEY_SLASH = 47
	KEY_ZERO = 48
	KEY_ONE = 49
	KEY_TWO = 50
	KEY_THREE = 51
	KEY_FOUR = 52
	KEY_FIVE = 53
	KEY_SIX = 54
	KEY_SEVEN = 55
	KEY_EIGHT = 56
	KEY_NINE = 57
	KEY_SEMICOLON = 59
	KEY_EQUAL = 61
	KEY_A = 65
	KEY_B = 66
	KEY_C = 67
	KEY_D = 68
	KEY_E = 69
	KEY_F = 70
	KEY_G = 71
	KEY_H = 72
	KEY_I = 73
	KEY_J = 74
	KEY_K = 75
	KEY_L = 76
	KEY_M = 77
	KEY_N = 78
	KEY_O = 79
	KEY_P = 80
	KEY_Q = 81
	KEY_R = 82
	KEY_S = 83
	KEY_T = 84
	KEY_U = 85
	KEY_V = 86
	KEY_W = 87
	KEY_X = 88
	KEY_Y = 89
	KEY_Z = 90
	KEY_SPACE = 32
	KEY_ESCAPE = 256
	KEY_ENTER = 257
	KEY_TAB = 258
	KEY_BACKSPACE = 259
	KEY_INSERT = 260
	KEY_DELETE = 261
	KEY_RIGHT = 262
	KEY_LEFT = 263
	KEY_DOWN = 264
	KEY_UP = 265
	KEY_PAGE_UP = 266
	KEY_PAGE_DOWN = 267
	KEY_HOME = 268
	KEY_END = 269
	KEY_CAPS_LOCK = 280
	KEY_SCROLL_LOCK = 281
	KEY_NUM_LOCK = 282
	KEY_PRINT_SCREEN = 283
	KEY_PAUSE = 284
	KEY_F1 = 290
	KEY_F2 = 291
	KEY_F3 = 292
	KEY_F4 = 293
	KEY_F5 = 294
	KEY_F6 = 295
	KEY_F7 = 296
	KEY_F8 = 297
	KEY_F9 = 298
	KEY_F10 = 299
	KEY_F11 = 300
	KEY_F12 = 301
	KEY_LEFT_SHIFT = 340
	KEY_LEFT_CONTROL = 341
	KEY_LEFT_ALT = 342
	KEY_LEFT_SUPER = 343
	KEY_RIGHT_SHIFT = 344
	KEY_RIGHT_CONTROL = 345
	KEY_RIGHT_ALT = 346
	KEY_RIGHT_SUPER = 347
	KEY_KB_MENU = 348
	KEY_LEFT_BRACKET = 91
	KEY_BACKSLASH = 92
	KEY_RIGHT_BRACKET = 93
	KEY_GRAVE = 96
	KEY_KP_0 = 320
	KEY_KP_1 = 321
	KEY_KP_2 = 322
	KEY_KP_3 = 323
	KEY_KP_4 = 324
	KEY_KP_5 = 325
	KEY_KP_6 = 326
	KEY_KP_7 = 327
	KEY_KP_8 = 328
	KEY_KP_9 = 329
	KEY_KP_DECIMAL = 330
	KEY_KP_DIVIDE = 331
	KEY_KP_MULTIPLY = 332
	KEY_KP_SUBTRACT = 333
	KEY_KP_ADD = 334
	KEY_KP_ENTER = 335
	KEY_KP_EQUAL = 336
end enum

type AndroidButton as long
enum
	KEY_BACK = 4
	KEY_MENU = 82
	KEY_VOLUME_UP = 24
	KEY_VOLUME_DOWN = 25
end enum

type MouseButton as long
enum
	MOUSE_LEFT_BUTTON = 0
	MOUSE_RIGHT_BUTTON = 1
	MOUSE_MIDDLE_BUTTON = 2
end enum

type GamepadNumber as long
enum
	GAMEPAD_PLAYER1 = 0
	GAMEPAD_PLAYER2 = 1
	GAMEPAD_PLAYER3 = 2
	GAMEPAD_PLAYER4 = 3
end enum

type GamepadButton as long
enum
	GAMEPAD_BUTTON_UNKNOWN = 0
	GAMEPAD_BUTTON_LEFT_FACE_UP
	GAMEPAD_BUTTON_LEFT_FACE_RIGHT
	GAMEPAD_BUTTON_LEFT_FACE_DOWN
	GAMEPAD_BUTTON_LEFT_FACE_LEFT
	GAMEPAD_BUTTON_RIGHT_FACE_UP
	GAMEPAD_BUTTON_RIGHT_FACE_RIGHT
	GAMEPAD_BUTTON_RIGHT_FACE_DOWN
	GAMEPAD_BUTTON_RIGHT_FACE_LEFT
	GAMEPAD_BUTTON_LEFT_TRIGGER_1
	GAMEPAD_BUTTON_LEFT_TRIGGER_2
	GAMEPAD_BUTTON_RIGHT_TRIGGER_1
	GAMEPAD_BUTTON_RIGHT_TRIGGER_2
	GAMEPAD_BUTTON_MIDDLE_LEFT
	GAMEPAD_BUTTON_MIDDLE
	GAMEPAD_BUTTON_MIDDLE_RIGHT
	GAMEPAD_BUTTON_LEFT_THUMB
	GAMEPAD_BUTTON_RIGHT_THUMB
end enum

type GamepadAxis as long
enum
	GAMEPAD_AXIS_UNKNOWN = 0
	GAMEPAD_AXIS_LEFT_X
	GAMEPAD_AXIS_LEFT_Y
	GAMEPAD_AXIS_RIGHT_X
	GAMEPAD_AXIS_RIGHT_Y
	GAMEPAD_AXIS_LEFT_TRIGGER
	GAMEPAD_AXIS_RIGHT_TRIGGER
end enum

type ShaderLocationIndex as long
enum
	LOC_VERTEX_POSITION = 0
	LOC_VERTEX_TEXCOORD01
	LOC_VERTEX_TEXCOORD02
	LOC_VERTEX_NORMAL
	LOC_VERTEX_TANGENT
	LOC_VERTEX_COLOR
	LOC_MATRIX_MVP
	LOC_MATRIX_MODEL
	LOC_MATRIX_VIEW
	LOC_MATRIX_PROJECTION
	LOC_VECTOR_VIEW
	LOC_COLOR_DIFFUSE
	LOC_COLOR_SPECULAR
	LOC_COLOR_AMBIENT
	LOC_MAP_ALBEDO
	LOC_MAP_METALNESS
	LOC_MAP_NORMAL
	LOC_MAP_ROUGHNESS
	LOC_MAP_OCCLUSION
	LOC_MAP_EMISSION
	LOC_MAP_HEIGHT
	LOC_MAP_CUBEMAP
	LOC_MAP_IRRADIANCE
	LOC_MAP_PREFILTER
	LOC_MAP_BRDF
end enum

const LOC_MAP_DIFFUSE = LOC_MAP_ALBEDO
const LOC_MAP_SPECULAR = LOC_MAP_METALNESS

type ShaderUniformDataType as long
enum
	UNIFORM_FLOAT = 0
	UNIFORM_VEC2
	UNIFORM_VEC3
	UNIFORM_VEC4
	UNIFORM_INT
	UNIFORM_IVEC2
	UNIFORM_IVEC3
	UNIFORM_IVEC4
	UNIFORM_SAMPLER2D
end enum

type MaterialMapType as long
enum
	MAP_ALBEDO = 0
	MAP_METALNESS = 1
	MAP_NORMAL = 2
	MAP_ROUGHNESS = 3
	MAP_OCCLUSION
	MAP_EMISSION
	MAP_HEIGHT
	MAP_CUBEMAP
	MAP_IRRADIANCE
	MAP_PREFILTER
	MAP_BRDF
end enum

const MAP_DIFFUSE = MAP_ALBEDO
const MAP_SPECULAR = MAP_METALNESS

type PixelFormat as long
enum
	UNCOMPRESSED_GRAYSCALE = 1
	UNCOMPRESSED_GRAY_ALPHA
	UNCOMPRESSED_R5G6B5
	UNCOMPRESSED_R8G8B8
	UNCOMPRESSED_R5G5B5A1
	UNCOMPRESSED_R4G4B4A4
	UNCOMPRESSED_R8G8B8A8
	UNCOMPRESSED_R32
	UNCOMPRESSED_R32G32B32
	UNCOMPRESSED_R32G32B32A32
	COMPRESSED_DXT1_RGB
	COMPRESSED_DXT1_RGBA
	COMPRESSED_DXT3_RGBA
	COMPRESSED_DXT5_RGBA
	COMPRESSED_ETC1_RGB
	COMPRESSED_ETC2_RGB
	COMPRESSED_ETC2_EAC_RGBA
	COMPRESSED_PVRT_RGB
	COMPRESSED_PVRT_RGBA
	COMPRESSED_ASTC_4x4_RGBA
	COMPRESSED_ASTC_8x8_RGBA
end enum

type TextureFilterMode as long
enum
	FILTER_POINT = 0
	FILTER_BILINEAR
	FILTER_TRILINEAR
	FILTER_ANISOTROPIC_4X
	FILTER_ANISOTROPIC_8X
	FILTER_ANISOTROPIC_16X
end enum

type CubemapLayoutType as long
enum
	CUBEMAP_AUTO_DETECT = 0
	CUBEMAP_LINE_VERTICAL
	CUBEMAP_LINE_HORIZONTAL
	CUBEMAP_CROSS_THREE_BY_FOUR
	CUBEMAP_CROSS_FOUR_BY_THREE
	CUBEMAP_PANORAMA
end enum

type TextureWrapMode as long
enum
	WRAP_REPEAT = 0
	WRAP_CLAMP
	WRAP_MIRROR_REPEAT
	WRAP_MIRROR_CLAMP
end enum

type FontType as long
enum
	FONT_DEFAULT = 0
	FONT_BITMAP
	FONT_SDF
end enum

type BlendMode as long
enum
	BLEND_ALPHA = 0
	BLEND_ADDITIVE
	BLEND_MULTIPLIED
end enum

type GestureType as long
enum
	GESTURE_NONE = 0
	GESTURE_TAP = 1
	GESTURE_DOUBLETAP = 2
	GESTURE_HOLD = 4
	GESTURE_DRAG = 8
	GESTURE_SWIPE_RIGHT = 16
	GESTURE_SWIPE_LEFT = 32
	GESTURE_SWIPE_UP = 64
	GESTURE_SWIPE_DOWN = 128
	GESTURE_PINCH_IN = 256
	GESTURE_PINCH_OUT = 512
end enum

type CameraMode as long
enum
	CAMERA_CUSTOM = 0
	CAMERA_FREE
	CAMERA_ORBITAL
	CAMERA_FIRST_PERSON
	CAMERA_THIRD_PERSON
end enum

type CameraType as long
enum
	CAMERA_PERSPECTIVE = 0
	CAMERA_ORTHOGRAPHIC
end enum

type NPatchType as long
enum
	NPT_9PATCH = 0
	NPT_3PATCH_VERTICAL
	NPT_3PATCH_HORIZONTAL
end enum

type TraceLogCallback as sub(byval logType as long, byval text as const zstring ptr, byval args as va_list)
declare sub InitWindow(byval width as long, byval height as long, byval title as const zstring ptr)
declare function WindowShouldClose() as byte
declare sub CloseWindow()
declare function IsWindowReady() as byte
declare function IsWindowMinimized() as byte
declare function IsWindowResized() as byte
declare function IsWindowHidden() as byte
declare function IsWindowFullscreen() as byte
declare sub ToggleFullscreen()
declare sub UnhideWindow()
declare sub ShowWindow alias "UnhideWindow"()
declare sub HideWindow()
declare sub SetWindowIcon(byval image as Image)
declare sub SetWindowTitle(byval title as const zstring ptr)
declare sub SetWindowPosition(byval x as long, byval y as long)
declare sub SetWindowMonitor(byval monitor as long)
declare sub SetWindowMinSize(byval width as long, byval height as long)
declare sub SetWindowSize(byval width as long, byval height as long)
declare function GetWindowHandle() as any ptr
declare function GetScreenWidth() as long
declare function GetScreenHeight() as long
declare function GetMonitorCount() as long
declare function GetMonitorWidth(byval monitor as long) as long
declare function GetMonitorHeight(byval monitor as long) as long
declare function GetMonitorPhysicalWidth(byval monitor as long) as long
declare function GetMonitorPhysicalHeight(byval monitor as long) as long
declare function GetWindowPosition() as Vector2
declare function GetMonitorName(byval monitor as long) as const zstring ptr
declare function GetClipboardText() as const zstring ptr
declare sub SetClipboardText(byval text as const zstring ptr)
declare sub ShowCursor()
declare sub HideCursor()
declare function IsCursorHidden() as byte
declare sub EnableCursor()
declare sub DisableCursor()
declare sub ClearBackground(byval color as Color)
declare sub BeginDrawing()
declare sub EndDrawing()
declare sub BeginMode2D(byval camera as Camera2D)
declare sub EndMode2D()
declare sub BeginMode3D(byval camera as Camera3D)
declare sub EndMode3D()
declare sub BeginTextureMode(byval target as RenderTexture2D)
declare sub EndTextureMode()
declare sub BeginScissorMode(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub EndScissorMode()
declare function GetMouseRay(byval mousePosition as Vector2, byval camera as Camera) as Ray
declare function GetCameraMatrix(byval camera as Camera) as Matrix
declare function GetCameraMatrix2D(byval camera as Camera2D) as Matrix
declare function GetWorldToScreen(byval position as Vector3, byval camera as Camera) as Vector2
declare function GetWorldToScreenEx(byval position as Vector3, byval camera as Camera, byval width as long, byval height as long) as Vector2
declare function GetWorldToScreen2D(byval position as Vector2, byval camera as Camera2D) as Vector2
declare function GetScreenToWorld2D(byval position as Vector2, byval camera as Camera2D) as Vector2
declare sub SetTargetFPS(byval fps as long)
declare function GetFPS() as long
declare function GetFrameTime() as single
declare function GetTime() as double
declare function ColorToInt(byval color as Color) as long
declare function ColorNormalize(byval color as Color) as Vector4
declare function ColorFromNormalized(byval normalized as Vector4) as Color
declare function ColorToHSV(byval color as Color) as Vector3
declare function ColorFromHSV(byval hsv as Vector3) as Color
declare function GetColor(byval hexValue as long) as Color
declare function Fade(byval color as Color, byval alpha as single) as Color
declare sub SetConfigFlags(byval flags as ulong)
declare sub SetTraceLogLevel(byval logType as long)
declare sub SetTraceLogExit(byval logType as long)
declare sub SetTraceLogCallback(byval callback as TraceLogCallback)
declare sub TraceLog(byval logType as long, byval text as const zstring ptr, ...)
declare sub TakeScreenshot(byval fileName as const zstring ptr)
declare function GetRandomValue(byval min as long, byval max as long) as long
declare function LoadFileData(byval fileName as const zstring ptr, byval bytesRead as ulong ptr) as ubyte ptr
declare sub SaveFileData(byval fileName as const zstring ptr, byval data as any ptr, byval bytesToWrite as ulong)
declare function LoadFileText(byval fileName as const zstring ptr) as zstring ptr
declare function LoadText alias "LoadFileText"(byval fileName as const zstring ptr) as zstring ptr
declare sub SaveFileText(byval fileName as const zstring ptr, byval text as zstring ptr)
declare function FileExists(byval fileName as const zstring ptr) as byte
declare function IsFileExtension(byval fileName as const zstring ptr, byval ext as const zstring ptr) as byte
declare function DirectoryExists(byval dirPath as const zstring ptr) as byte
declare function GetExtension(byval fileName as const zstring ptr) as const zstring ptr
declare function GetFileName(byval filePath as const zstring ptr) as const zstring ptr
declare function GetFileNameWithoutExt(byval filePath as const zstring ptr) as const zstring ptr
declare function GetDirectoryPath(byval filePath as const zstring ptr) as const zstring ptr
declare function GetPrevDirectoryPath(byval dirPath as const zstring ptr) as const zstring ptr
declare function GetWorkingDirectory() as const zstring ptr
declare function GetDirectoryFiles(byval dirPath as const zstring ptr, byval count as long ptr) as zstring ptr ptr
declare sub ClearDirectoryFiles()
declare function ChangeDirectory(byval dir as const zstring ptr) as byte
declare function IsFileDropped() as byte
declare function GetDroppedFiles(byval count as long ptr) as zstring ptr ptr
declare sub ClearDroppedFiles()
declare function GetFileModTime(byval fileName as const zstring ptr) as clong
declare function CompressData(byval data as ubyte ptr, byval dataLength as long, byval compDataLength as long ptr) as ubyte ptr
declare function DecompressData(byval compData as ubyte ptr, byval compDataLength as long, byval dataLength as long ptr) as ubyte ptr
declare sub SaveStorageValue(byval position as ulong, byval value as long)
declare function LoadStorageValue(byval position as ulong) as long
declare sub OpenURL(byval url as const zstring ptr)
declare function IsKeyPressed(byval key as long) as byte
declare function IsKeyDown(byval key as long) as byte
declare function IsKeyReleased(byval key as long) as byte
declare function IsKeyUp(byval key as long) as byte
declare sub SetExitKey(byval key as long)
declare function GetKeyPressed() as long
declare function IsGamepadAvailable(byval gamepad as long) as byte
declare function IsGamepadName(byval gamepad as long, byval name as const zstring ptr) as byte
declare function GetGamepadName(byval gamepad as long) as const zstring ptr
declare function IsGamepadButtonPressed(byval gamepad as long, byval button as long) as byte
declare function IsGamepadButtonDown(byval gamepad as long, byval button as long) as byte
declare function IsGamepadButtonReleased(byval gamepad as long, byval button as long) as byte
declare function IsGamepadButtonUp(byval gamepad as long, byval button as long) as byte
declare function GetGamepadButtonPressed() as long
declare function GetGamepadAxisCount(byval gamepad as long) as long
declare function GetGamepadAxisMovement(byval gamepad as long, byval axis as long) as single
declare function IsMouseButtonPressed(byval button as long) as byte
declare function IsMouseButtonDown(byval button as long) as byte
declare function IsMouseButtonReleased(byval button as long) as byte
declare function IsMouseButtonUp(byval button as long) as byte
declare function GetMouseX() as long
declare function GetMouseY() as long
declare function GetMousePosition() as Vector2
declare sub SetMousePosition(byval x as long, byval y as long)
declare sub SetMouseOffset(byval offsetX as long, byval offsetY as long)
declare sub SetMouseScale(byval scaleX as single, byval scaleY as single)
declare function GetMouseWheelMove() as long
declare function GetTouchX() as long
declare function GetTouchY() as long
declare function GetTouchPosition(byval index as long) as Vector2
declare sub SetGesturesEnabled(byval gestureFlags as ulong)
declare function IsGestureDetected(byval gesture as long) as byte
declare function GetGestureDetected() as long
declare function GetTouchPointsCount() as long
declare function GetGestureHoldDuration() as single
declare function GetGestureDragVector() as Vector2
declare function GetGestureDragAngle() as single
declare function GetGesturePinchVector() as Vector2
declare function GetGesturePinchAngle() as single
declare sub SetCameraMode(byval camera as Camera, byval mode as long)
declare sub UpdateCamera(byval camera as Camera ptr)
declare sub SetCameraPanControl(byval panKey as long)
declare sub SetCameraAltControl(byval altKey as long)
declare sub SetCameraSmoothZoomControl(byval szKey as long)
declare sub SetCameraMoveControls(byval frontKey as long, byval backKey as long, byval rightKey as long, byval leftKey as long, byval upKey as long, byval downKey as long)
declare sub DrawPixel(byval posX as long, byval posY as long, byval color as Color)
declare sub DrawPixelV(byval position as Vector2, byval color as Color)
declare sub DrawLine(byval startPosX as long, byval startPosY as long, byval endPosX as long, byval endPosY as long, byval color as Color)
declare sub DrawLineV(byval startPos as Vector2, byval endPos as Vector2, byval color as Color)
declare sub DrawLineEx(byval startPos as Vector2, byval endPos as Vector2, byval thick as single, byval color as Color)
declare sub DrawLineBezier(byval startPos as Vector2, byval endPos as Vector2, byval thick as single, byval color as Color)
declare sub DrawLineStrip(byval points as Vector2 ptr, byval numPoints as long, byval color as Color)
declare sub DrawCircle(byval centerX as long, byval centerY as long, byval radius as single, byval color as Color)
declare sub DrawCircleSector(byval center as Vector2, byval radius as single, byval startAngle as long, byval endAngle as long, byval segments as long, byval color as Color)
declare sub DrawCircleSectorLines(byval center as Vector2, byval radius as single, byval startAngle as long, byval endAngle as long, byval segments as long, byval color as Color)
declare sub DrawCircleGradient(byval centerX as long, byval centerY as long, byval radius as single, byval color1 as Color, byval color2 as Color)
declare sub DrawCircleV(byval center as Vector2, byval radius as single, byval color as Color)
declare sub DrawCircleLines(byval centerX as long, byval centerY as long, byval radius as single, byval color as Color)
declare sub DrawEllipse(byval centerX as long, byval centerY as long, byval radiusH as single, byval radiusV as single, byval color as Color)
declare sub DrawEllipseLines(byval centerX as long, byval centerY as long, byval radiusH as single, byval radiusV as single, byval color as Color)
declare sub DrawRing(byval center as Vector2, byval innerRadius as single, byval outerRadius as single, byval startAngle as long, byval endAngle as long, byval segments as long, byval color as Color)
declare sub DrawRingLines(byval center as Vector2, byval innerRadius as single, byval outerRadius as single, byval startAngle as long, byval endAngle as long, byval segments as long, byval color as Color)
declare sub DrawRectangle(byval posX as long, byval posY as long, byval width as long, byval height as long, byval color as Color)
declare sub DrawRectangleV(byval position as Vector2, byval size as Vector2, byval color as Color)
declare sub DrawRectangleRec(byval rec as Rectangle, byval color as Color)
declare sub DrawRectanglePro(byval rec as Rectangle, byval origin as Vector2, byval rotation as single, byval color as Color)
declare sub DrawRectangleGradientV(byval posX as long, byval posY as long, byval width as long, byval height as long, byval color1 as Color, byval color2 as Color)
declare sub DrawRectangleGradientH(byval posX as long, byval posY as long, byval width as long, byval height as long, byval color1 as Color, byval color2 as Color)
declare sub DrawRectangleGradientEx(byval rec as Rectangle, byval col1 as Color, byval col2 as Color, byval col3 as Color, byval col4 as Color)
declare sub DrawRectangleLines(byval posX as long, byval posY as long, byval width as long, byval height as long, byval color as Color)
declare sub DrawRectangleLinesEx(byval rec as Rectangle, byval lineThick as long, byval color as Color)
declare sub DrawRectangleRounded(byval rec as Rectangle, byval roundness as single, byval segments as long, byval color as Color)
declare sub DrawRectangleRoundedLines(byval rec as Rectangle, byval roundness as single, byval segments as long, byval lineThick as long, byval color as Color)
declare sub DrawTriangle(byval v1 as Vector2, byval v2 as Vector2, byval v3 as Vector2, byval color as Color)
declare sub DrawTriangleLines(byval v1 as Vector2, byval v2 as Vector2, byval v3 as Vector2, byval color as Color)
declare sub DrawTriangleFan(byval points as Vector2 ptr, byval numPoints as long, byval color as Color)
declare sub DrawTriangleStrip(byval points as Vector2 ptr, byval pointsCount as long, byval color as Color)
declare sub DrawPoly(byval center as Vector2, byval sides as long, byval radius as single, byval rotation as single, byval color as Color)
declare sub DrawPolyLines(byval center as Vector2, byval sides as long, byval radius as single, byval rotation as single, byval color as Color)
declare function CheckCollisionRecs(byval rec1 as Rectangle, byval rec2 as Rectangle) as byte
declare function CheckCollisionCircles(byval center1 as Vector2, byval radius1 as single, byval center2 as Vector2, byval radius2 as single) as byte
declare function CheckCollisionCircleRec(byval center as Vector2, byval radius as single, byval rec as Rectangle) as byte
declare function GetCollisionRec(byval rec1 as Rectangle, byval rec2 as Rectangle) as Rectangle
declare function CheckCollisionPointRec(byval point as Vector2, byval rec as Rectangle) as byte
declare function CheckCollisionPointCircle(byval point as Vector2, byval center as Vector2, byval radius as single) as byte
declare function CheckCollisionPointTriangle(byval point as Vector2, byval p1 as Vector2, byval p2 as Vector2, byval p3 as Vector2) as byte
declare function LoadImage(byval fileName as const zstring ptr) as Image
declare function LoadImageEx(byval pixels as Color ptr, byval width as long, byval height as long) as Image
declare function LoadImagePro(byval data as any ptr, byval width as long, byval height as long, byval format as long) as Image
declare function LoadImageRaw(byval fileName as const zstring ptr, byval width as long, byval height as long, byval format as long, byval headerSize as long) as Image
declare sub UnloadImage(byval image as Image)
declare sub ExportImage(byval image as Image, byval fileName as const zstring ptr)
declare sub ExportImageAsCode(byval image as Image, byval fileName as const zstring ptr)
declare function GetImageData(byval image as Image) as Color ptr
declare function GetImageDataNormalized(byval image as Image) as Vector4 ptr
declare function GenImageColor(byval width as long, byval height as long, byval color as Color) as Image
declare function GenImageGradientV(byval width as long, byval height as long, byval top as Color, byval bottom as Color) as Image
declare function GenImageGradientH(byval width as long, byval height as long, byval left as Color, byval right as Color) as Image
declare function GenImageGradientRadial(byval width as long, byval height as long, byval density as single, byval inner as Color, byval outer as Color) as Image
declare function GenImageChecked(byval width as long, byval height as long, byval checksX as long, byval checksY as long, byval col1 as Color, byval col2 as Color) as Image
declare function GenImageWhiteNoise(byval width as long, byval height as long, byval factor as single) as Image
declare function GenImagePerlinNoise(byval width as long, byval height as long, byval offsetX as long, byval offsetY as long, byval scale as single) as Image
declare function GenImageCellular(byval width as long, byval height as long, byval tileSize as long) as Image
declare function ImageCopy(byval image as Image) as Image
declare function ImageFromImage(byval image as Image, byval rec as Rectangle) as Image
declare function ImageText(byval text as const zstring ptr, byval fontSize as long, byval color as Color) as Image
declare function ImageTextEx(byval font as Font, byval text as const zstring ptr, byval fontSize as single, byval spacing as single, byval tint as Color) as Image
declare sub ImageToPOT(byval image as Image ptr, byval fillColor as Color)
declare sub ImageFormat(byval image as Image ptr, byval newFormat as long)
declare sub ImageAlphaMask(byval image as Image ptr, byval alphaMask as Image)
declare sub ImageAlphaClear(byval image as Image ptr, byval color as Color, byval threshold as single)
declare sub ImageAlphaCrop(byval image as Image ptr, byval threshold as single)
declare sub ImageAlphaPremultiply(byval image as Image ptr)
declare sub ImageCrop(byval image as Image ptr, byval crop as Rectangle)
declare sub ImageResize(byval image as Image ptr, byval newWidth as long, byval newHeight as long)
declare sub ImageResizeNN(byval image as Image ptr, byval newWidth as long, byval newHeight as long)
declare sub ImageResizeCanvas(byval image as Image ptr, byval newWidth as long, byval newHeight as long, byval offsetX as long, byval offsetY as long, byval color as Color)
declare sub ImageMipmaps(byval image as Image ptr)
declare sub ImageDither(byval image as Image ptr, byval rBpp as long, byval gBpp as long, byval bBpp as long, byval aBpp as long)
declare sub ImageFlipVertical(byval image as Image ptr)
declare sub ImageFlipHorizontal(byval image as Image ptr)
declare sub ImageRotateCW(byval image as Image ptr)
declare sub ImageRotateCCW(byval image as Image ptr)
declare sub ImageColorTint(byval image as Image ptr, byval color as Color)
declare sub ImageColorInvert(byval image as Image ptr)
declare sub ImageColorGrayscale(byval image as Image ptr)
declare sub ImageColorContrast(byval image as Image ptr, byval contrast as single)
declare sub ImageColorBrightness(byval image as Image ptr, byval brightness as long)
declare sub ImageColorReplace(byval image as Image ptr, byval color as Color, byval replace as Color)
declare function ImageExtractPalette(byval image as Image, byval maxPaletteSize as long, byval extractCount as long ptr) as Color ptr
declare function GetImageAlphaBorder(byval image as Image, byval threshold as single) as Rectangle
declare sub ImageClearBackground(byval dst as Image ptr, byval color as Color)
declare sub ImageDrawPixel(byval dst as Image ptr, byval posX as long, byval posY as long, byval color as Color)
declare sub ImageDrawPixelV(byval dst as Image ptr, byval position as Vector2, byval color as Color)
declare sub ImageDrawLine(byval dst as Image ptr, byval startPosX as long, byval startPosY as long, byval endPosX as long, byval endPosY as long, byval color as Color)
declare sub ImageDrawLineV(byval dst as Image ptr, byval start as Vector2, byval end_ as Vector2, byval color as Color)
declare sub ImageDrawCircle(byval dst as Image ptr, byval centerX as long, byval centerY as long, byval radius as long, byval color as Color)
declare sub ImageDrawCircleV(byval dst as Image ptr, byval center as Vector2, byval radius as long, byval color as Color)
declare sub ImageDrawRectangle(byval dst as Image ptr, byval posX as long, byval posY as long, byval width as long, byval height as long, byval color as Color)
declare sub ImageDrawRectangleV(byval dst as Image ptr, byval position as Vector2, byval size as Vector2, byval color as Color)
declare sub ImageDrawRectangleRec(byval dst as Image ptr, byval rec as Rectangle, byval color as Color)
declare sub ImageDrawRectangleLines(byval dst as Image ptr, byval rec as Rectangle, byval thick as long, byval color as Color)
declare sub ImageDraw(byval dst as Image ptr, byval src as Image, byval srcRec as Rectangle, byval dstRec as Rectangle, byval tint as Color)
declare sub ImageDrawText(byval dst as Image ptr, byval position as Vector2, byval text as const zstring ptr, byval fontSize as long, byval color as Color)
declare sub ImageDrawTextEx(byval dst as Image ptr, byval position as Vector2, byval font as Font, byval text as const zstring ptr, byval fontSize as single, byval spacing as single, byval color as Color)
declare function LoadTexture(byval fileName as const zstring ptr) as Texture2D
declare function LoadTextureFromImage(byval image as Image) as Texture2D
declare function LoadTextureCubemap(byval image as Image, byval layoutType as long) as TextureCubemap
declare function LoadRenderTexture(byval width as long, byval height as long) as RenderTexture2D
declare sub UnloadTexture(byval texture as Texture2D)
declare sub UnloadRenderTexture(byval target as RenderTexture2D)
declare sub UpdateTexture(byval texture as Texture2D, byval pixels as const any ptr)
declare function GetTextureData(byval texture as Texture2D) as Image
declare function GetScreenData() as Image
declare sub GenTextureMipmaps(byval texture as Texture2D ptr)
declare sub SetTextureFilter(byval texture as Texture2D, byval filterMode as long)
declare sub SetTextureWrap(byval texture as Texture2D, byval wrapMode as long)
declare sub DrawTexture(byval texture as Texture2D, byval posX as long, byval posY as long, byval tint as Color)
declare sub DrawTextureV(byval texture as Texture2D, byval position as Vector2, byval tint as Color)
declare sub DrawTextureEx(byval texture as Texture2D, byval position as Vector2, byval rotation as single, byval scale as single, byval tint as Color)
declare sub DrawTextureRec(byval texture as Texture2D, byval sourceRec as Rectangle, byval position as Vector2, byval tint as Color)
declare sub DrawTextureQuad(byval texture as Texture2D, byval tiling as Vector2, byval offset as Vector2, byval quad as Rectangle, byval tint as Color)
declare sub DrawTexturePro(byval texture as Texture2D, byval sourceRec as Rectangle, byval destRec as Rectangle, byval origin as Vector2, byval rotation as single, byval tint as Color)
declare sub DrawTextureNPatch(byval texture as Texture2D, byval nPatchInfo as NPatchInfo, byval destRec as Rectangle, byval origin as Vector2, byval rotation as single, byval tint as Color)
declare function GetPixelDataSize(byval width as long, byval height as long, byval format as long) as long
declare function GetFontDefault() as Font
declare function LoadFont(byval fileName as const zstring ptr) as Font
declare function LoadFontEx(byval fileName as const zstring ptr, byval fontSize as long, byval fontChars as long ptr, byval charsCount as long) as Font
declare function LoadFontFromImage(byval image as Image, byval key as Color, byval firstChar as long) as Font
declare function LoadFontData(byval fileName as const zstring ptr, byval fontSize as long, byval fontChars as long ptr, byval charsCount as long, byval type as long) as CharInfo ptr
declare function GenImageFontAtlas(byval chars as const CharInfo ptr, byval recs as Rectangle ptr ptr, byval charsCount as long, byval fontSize as long, byval padding as long, byval packMethod as long) as Image
declare sub UnloadFont(byval font as Font)
declare sub DrawFPS(byval posX as long, byval posY as long)
declare sub DrawText(byval text as const zstring ptr, byval posX as long, byval posY as long, byval fontSize as long, byval color as Color)
declare sub DrawTextEx(byval font as Font, byval text as const zstring ptr, byval position as Vector2, byval fontSize as single, byval spacing as single, byval tint as Color)
declare sub DrawTextRec(byval font as Font, byval text as const zstring ptr, byval rec as Rectangle, byval fontSize as single, byval spacing as single, byval wordWrap as byte, byval tint as Color)
declare sub DrawTextRecEx(byval font as Font, byval text as const zstring ptr, byval rec as Rectangle, byval fontSize as single, byval spacing as single, byval wordWrap as byte, byval tint as Color, byval selectStart as long, byval selectLength as long, byval selectTint as Color, byval selectBackTint as Color)
declare sub DrawTextCodepoint(byval font as Font, byval codepoint as long, byval position as Vector2, byval scale as single, byval tint as Color)
declare function MeasureText(byval text as const zstring ptr, byval fontSize as long) as long
declare function MeasureTextEx(byval font as Font, byval text as const zstring ptr, byval fontSize as single, byval spacing as single) as Vector2
declare function GetGlyphIndex(byval font as Font, byval codepoint as long) as long
declare function TextCopy(byval dst as zstring ptr, byval src as const zstring ptr) as long
declare function TextIsEqual(byval text1 as const zstring ptr, byval text2 as const zstring ptr) as byte
declare function TextLength(byval text as const zstring ptr) as ulong
declare function TextFormat(byval text as const zstring ptr, ...) as const zstring ptr
declare function FormatText alias "TextFormat"(byval text as const zstring ptr, ...) as const zstring ptr
declare function TextSubtext(byval text as const zstring ptr, byval position as long, byval length as long) as const zstring ptr
declare function SubText alias "TextSubtext"(byval text as const zstring ptr, byval position as long, byval length as long) as const zstring ptr
declare function TextReplace(byval text as zstring ptr, byval replace as const zstring ptr, byval by as const zstring ptr) as zstring ptr
declare function TextInsert(byval text as const zstring ptr, byval insert as const zstring ptr, byval position as long) as zstring ptr
declare function TextJoin(byval textList as const zstring ptr ptr, byval count as long, byval delimiter as const zstring ptr) as const zstring ptr
declare function TextSplit(byval text as const zstring ptr, byval delimiter as byte, byval count as long ptr) as const zstring ptr ptr
declare sub TextAppend(byval text as zstring ptr, byval append as const zstring ptr, byval position as long ptr)
declare function TextFindIndex(byval text as const zstring ptr, byval find as const zstring ptr) as long
declare function TextToUpper(byval text as const zstring ptr) as const zstring ptr
declare function TextToLower(byval text as const zstring ptr) as const zstring ptr
declare function TextToPascal(byval text as const zstring ptr) as const zstring ptr
declare function TextToInteger(byval text as const zstring ptr) as long
declare function TextToUtf8(byval codepoints as long ptr, byval length as long) as zstring ptr
declare function GetCodepoints(byval text as const zstring ptr, byval count as long ptr) as long ptr
declare function GetCodepointsCount(byval text as const zstring ptr) as long
declare function GetNextCodepoint(byval text as const zstring ptr, byval bytesProcessed as long ptr) as long
declare function CodepointToUtf8(byval codepoint as long, byval byteLength as long ptr) as const zstring ptr
declare sub DrawLine3D(byval startPos as Vector3, byval endPos as Vector3, byval color as Color)
declare sub DrawPoint3D(byval position as Vector3, byval color as Color)
declare sub DrawCircle3D(byval center as Vector3, byval radius as single, byval rotationAxis as Vector3, byval rotationAngle as single, byval color as Color)
declare sub DrawCube(byval position as Vector3, byval width as single, byval height as single, byval length as single, byval color as Color)
declare sub DrawCubeV(byval position as Vector3, byval size as Vector3, byval color as Color)
declare sub DrawCubeWires(byval position as Vector3, byval width as single, byval height as single, byval length as single, byval color as Color)
declare sub DrawCubeWiresV(byval position as Vector3, byval size as Vector3, byval color as Color)
declare sub DrawCubeTexture(byval texture as Texture2D, byval position as Vector3, byval width as single, byval height as single, byval length as single, byval color as Color)
declare sub DrawSphere(byval centerPos as Vector3, byval radius as single, byval color as Color)
declare sub DrawSphereEx(byval centerPos as Vector3, byval radius as single, byval rings as long, byval slices as long, byval color as Color)
declare sub DrawSphereWires(byval centerPos as Vector3, byval radius as single, byval rings as long, byval slices as long, byval color as Color)
declare sub DrawCylinder(byval position as Vector3, byval radiusTop as single, byval radiusBottom as single, byval height as single, byval slices as long, byval color as Color)
declare sub DrawCylinderWires(byval position as Vector3, byval radiusTop as single, byval radiusBottom as single, byval height as single, byval slices as long, byval color as Color)
declare sub DrawPlane(byval centerPos as Vector3, byval size as Vector2, byval color as Color)
declare sub DrawRay(byval ray as Ray, byval color as Color)
declare sub DrawGrid(byval slices as long, byval spacing as single)
declare sub DrawGizmo(byval position as Vector3)
declare function LoadModel(byval fileName as const zstring ptr) as Model
declare function LoadModelFromMesh(byval mesh as Mesh) as Model
declare sub UnloadModel(byval model as Model)
declare function LoadMeshes(byval fileName as const zstring ptr, byval meshCount as long ptr) as Mesh ptr
declare sub ExportMesh(byval mesh as Mesh, byval fileName as const zstring ptr)
declare sub UnloadMesh(byval mesh as Mesh)
declare function LoadMaterials(byval fileName as const zstring ptr, byval materialCount as long ptr) as Material ptr
declare function LoadMaterialDefault() as Material
declare sub UnloadMaterial(byval material as Material)
declare sub SetMaterialTexture(byval material as Material ptr, byval mapType as long, byval texture as Texture2D)
declare sub SetModelMeshMaterial(byval model as Model ptr, byval meshId as long, byval materialId as long)
declare function LoadModelAnimations(byval fileName as const zstring ptr, byval animsCount as long ptr) as ModelAnimation ptr
declare sub UpdateModelAnimation(byval model as Model, byval anim as ModelAnimation, byval frame as long)
declare sub UnloadModelAnimation(byval anim as ModelAnimation)
declare function IsModelAnimationValid(byval model as Model, byval anim as ModelAnimation) as byte
declare function GenMeshPoly(byval sides as long, byval radius as single) as Mesh
declare function GenMeshPlane(byval width as single, byval length as single, byval resX as long, byval resZ as long) as Mesh
declare function GenMeshCube(byval width as single, byval height as single, byval length as single) as Mesh
declare function GenMeshSphere(byval radius as single, byval rings as long, byval slices as long) as Mesh
declare function GenMeshHemiSphere(byval radius as single, byval rings as long, byval slices as long) as Mesh
declare function GenMeshCylinder(byval radius as single, byval height as single, byval slices as long) as Mesh
declare function GenMeshTorus(byval radius as single, byval size as single, byval radSeg as long, byval sides as long) as Mesh
declare function GenMeshKnot(byval radius as single, byval size as single, byval radSeg as long, byval sides as long) as Mesh
declare function GenMeshHeightmap(byval heightmap as Image, byval size as Vector3) as Mesh
declare function GenMeshCubicmap(byval cubicmap as Image, byval cubeSize as Vector3) as Mesh
declare function MeshBoundingBox(byval mesh as Mesh) as BoundingBox
declare sub MeshTangents(byval mesh as Mesh ptr)
declare sub MeshBinormals(byval mesh as Mesh ptr)
declare sub DrawModel(byval model as Model, byval position as Vector3, byval scale as single, byval tint as Color)
declare sub DrawModelEx(byval model as Model, byval position as Vector3, byval rotationAxis as Vector3, byval rotationAngle as single, byval scale as Vector3, byval tint as Color)
declare sub DrawModelWires(byval model as Model, byval position as Vector3, byval scale as single, byval tint as Color)
declare sub DrawModelWiresEx(byval model as Model, byval position as Vector3, byval rotationAxis as Vector3, byval rotationAngle as single, byval scale as Vector3, byval tint as Color)
declare sub DrawBoundingBox(byval box as BoundingBox, byval color as Color)
declare sub DrawBillboard(byval camera as Camera, byval texture as Texture2D, byval center as Vector3, byval size as single, byval tint as Color)
declare sub DrawBillboardRec(byval camera as Camera, byval texture as Texture2D, byval sourceRec as Rectangle, byval center as Vector3, byval size as single, byval tint as Color)
declare function CheckCollisionSpheres(byval centerA as Vector3, byval radiusA as single, byval centerB as Vector3, byval radiusB as single) as byte
declare function CheckCollisionBoxes(byval box1 as BoundingBox, byval box2 as BoundingBox) as byte
declare function CheckCollisionBoxSphere(byval box as BoundingBox, byval center as Vector3, byval radius as single) as byte
declare function CheckCollisionRaySphere(byval ray as Ray, byval center as Vector3, byval radius as single) as byte
declare function CheckCollisionRaySphereEx(byval ray as Ray, byval center as Vector3, byval radius as single, byval collisionPoint as Vector3 ptr) as byte
declare function CheckCollisionRayBox(byval ray as Ray, byval box as BoundingBox) as byte
declare function GetCollisionRayModel(byval ray as Ray, byval model as Model) as RayHitInfo
declare function GetCollisionRayTriangle(byval ray as Ray, byval p1 as Vector3, byval p2 as Vector3, byval p3 as Vector3) as RayHitInfo
declare function GetCollisionRayGround(byval ray as Ray, byval groundHeight as single) as RayHitInfo
declare function LoadShader(byval vsFileName as const zstring ptr, byval fsFileName as const zstring ptr) as Shader
declare function LoadShaderCode(byval vsCode as const zstring ptr, byval fsCode as const zstring ptr) as Shader
declare sub UnloadShader(byval shader as Shader)
declare function GetShaderDefault() as Shader
declare function GetTextureDefault() as Texture2D
declare function GetShapesTexture() as Texture2D
declare function GetShapesTextureRec() as Rectangle
declare sub SetShapesTexture(byval texture as Texture2D, byval source as Rectangle)
declare function GetShaderLocation(byval shader as Shader, byval uniformName as const zstring ptr) as long
declare sub SetShaderValue(byval shader as Shader, byval uniformLoc as long, byval value as const any ptr, byval uniformType as long)
declare sub SetShaderValueV(byval shader as Shader, byval uniformLoc as long, byval value as const any ptr, byval uniformType as long, byval count as long)
declare sub SetShaderValueMatrix(byval shader as Shader, byval uniformLoc as long, byval mat as Matrix)
declare sub SetShaderValueTexture(byval shader as Shader, byval uniformLoc as long, byval texture as Texture2D)
declare sub SetMatrixProjection(byval proj as Matrix)
declare sub SetMatrixModelview(byval view as Matrix)
declare function GetMatrixModelview() as Matrix
declare function GetMatrixProjection() as Matrix
declare function GenTextureCubemap(byval shader as Shader, byval map as Texture2D, byval size as long) as Texture2D
declare function GenTextureIrradiance(byval shader as Shader, byval cubemap as Texture2D, byval size as long) as Texture2D
declare function GenTexturePrefilter(byval shader as Shader, byval cubemap as Texture2D, byval size as long) as Texture2D
declare function GenTextureBRDF(byval shader as Shader, byval size as long) as Texture2D
declare sub BeginShaderMode(byval shader as Shader)
declare sub EndShaderMode()
declare sub BeginBlendMode(byval mode as long)
declare sub EndBlendMode()
declare sub InitVrSimulator()
declare sub CloseVrSimulator()
declare sub UpdateVrTracking(byval camera as Camera ptr)
declare sub SetVrConfiguration(byval info as VrDeviceInfo, byval distortion as Shader)
declare function IsVrSimulatorReady() as byte
declare sub ToggleVrMode()
declare sub BeginVrDrawing()
declare sub EndVrDrawing()
declare sub InitAudioDevice()
declare sub CloseAudioDevice()
declare function IsAudioDeviceReady() as byte
declare sub SetMasterVolume(byval volume as single)
declare function LoadWave(byval fileName as const zstring ptr) as Wave
declare function LoadSound(byval fileName as const zstring ptr) as Sound
declare function LoadSoundFromWave(byval wave as Wave) as Sound
declare sub UpdateSound(byval sound as Sound, byval data as const any ptr, byval samplesCount as long)
declare sub UnloadWave(byval wave as Wave)
declare sub UnloadSound(byval sound as Sound)
declare sub ExportWave(byval wave as Wave, byval fileName as const zstring ptr)
declare sub ExportWaveAsCode(byval wave as Wave, byval fileName as const zstring ptr)
declare sub PlaySound(byval sound as Sound)
declare sub StopSound(byval sound as Sound)
declare sub PauseSound(byval sound as Sound)
declare sub ResumeSound(byval sound as Sound)
declare sub PlaySoundMulti(byval sound as Sound)
declare sub StopSoundMulti()
declare function GetSoundsPlaying() as long
declare function IsSoundPlaying(byval sound as Sound) as byte
declare sub SetSoundVolume(byval sound as Sound, byval volume as single)
declare sub SetSoundPitch(byval sound as Sound, byval pitch as single)
declare sub WaveFormat(byval wave as Wave ptr, byval sampleRate as long, byval sampleSize as long, byval channels as long)
declare function WaveCopy(byval wave as Wave) as Wave
declare sub WaveCrop(byval wave as Wave ptr, byval initSample as long, byval finalSample as long)
declare function GetWaveData(byval wave as Wave) as single ptr
declare function LoadMusicStream(byval fileName as const zstring ptr) as Music
declare sub UnloadMusicStream(byval music as Music)
declare sub PlayMusicStream(byval music as Music)
declare sub UpdateMusicStream(byval music as Music)
declare sub StopMusicStream(byval music as Music)
declare sub PauseMusicStream(byval music as Music)
declare sub ResumeMusicStream(byval music as Music)
declare function IsMusicPlaying(byval music as Music) as byte
declare sub SetMusicVolume(byval music as Music, byval volume as single)
declare sub SetMusicPitch(byval music as Music, byval pitch as single)
declare sub SetMusicLoopCount(byval music as Music, byval count as long)
declare function GetMusicTimeLength(byval music as Music) as single
declare function GetMusicTimePlayed(byval music as Music) as single
declare function InitAudioStream(byval sampleRate as ulong, byval sampleSize as ulong, byval channels as ulong) as AudioStream
declare sub UpdateAudioStream(byval stream as AudioStream, byval data as const any ptr, byval samplesCount as long)
declare sub CloseAudioStream(byval stream as AudioStream)
declare function IsAudioStreamProcessed(byval stream as AudioStream) as byte
declare sub PlayAudioStream(byval stream as AudioStream)
declare sub PauseAudioStream(byval stream as AudioStream)
declare sub ResumeAudioStream(byval stream as AudioStream)
declare function IsAudioStreamPlaying(byval stream as AudioStream) as byte
declare sub StopAudioStream(byval stream as AudioStream)
declare sub SetAudioStreamVolume(byval stream as AudioStream, byval volume as single)
declare sub SetAudioStreamPitch(byval stream as AudioStream, byval pitch as single)
declare sub SetAudioStreamBufferSizeDefault(byval size as long)

end extern
