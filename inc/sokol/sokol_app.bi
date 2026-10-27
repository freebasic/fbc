'' FreeBASIC binding for sokol_app
''
'' Generated with fbfrog from sokol_app.h; do not edit by hand.
'' Pinned source: sokol 13554f665ebf (2024-05-13), sokol_app.h
'' sha256 9c8b071e4b1d5f9692cb636216ad688dbf905f99f6fbc920d808a477c9a49437
''
'' Regenerate:
''   fbfrog sokol_app.h -o sokol_app.bi \
''       -fbfroginclude stdbool.h -removeinclude stdbool.h
''
'' sokol is header-only: the application compiles the implementation
'' itself (see examples/graphics/sokol/README.txt).  There is no
'' sokol library to link against, so this binding emits no #inclib.

#pragma once

#include once "crt/stddef.bi"
#include once "crt/stdint.bi"

extern "C"

const SOKOL_APP_INCLUDED = 1
'' TODO: #define SOKOL_APP_API_DECL extern

enum
	SAPP_MAX_TOUCHPOINTS = 8
	SAPP_MAX_MOUSEBUTTONS = 3
	SAPP_MAX_KEYCODES = 512
	SAPP_MAX_ICONIMAGES = 8
end enum

type sapp_event_type as long
enum
	SAPP_EVENTTYPE_INVALID
	SAPP_EVENTTYPE_KEY_DOWN
	SAPP_EVENTTYPE_KEY_UP
	SAPP_EVENTTYPE_CHAR
	SAPP_EVENTTYPE_MOUSE_DOWN
	SAPP_EVENTTYPE_MOUSE_UP
	SAPP_EVENTTYPE_MOUSE_SCROLL
	SAPP_EVENTTYPE_MOUSE_MOVE
	SAPP_EVENTTYPE_MOUSE_ENTER
	SAPP_EVENTTYPE_MOUSE_LEAVE
	SAPP_EVENTTYPE_TOUCHES_BEGAN
	SAPP_EVENTTYPE_TOUCHES_MOVED
	SAPP_EVENTTYPE_TOUCHES_ENDED
	SAPP_EVENTTYPE_TOUCHES_CANCELLED
	SAPP_EVENTTYPE_RESIZED
	SAPP_EVENTTYPE_ICONIFIED
	SAPP_EVENTTYPE_RESTORED
	SAPP_EVENTTYPE_FOCUSED
	SAPP_EVENTTYPE_UNFOCUSED
	SAPP_EVENTTYPE_SUSPENDED
	SAPP_EVENTTYPE_RESUMED
	SAPP_EVENTTYPE_QUIT_REQUESTED
	SAPP_EVENTTYPE_CLIPBOARD_PASTED
	SAPP_EVENTTYPE_FILES_DROPPED
	_SAPP_EVENTTYPE_NUM
	_SAPP_EVENTTYPE_FORCE_U32 = &h7FFFFFFF
end enum

type sapp_keycode as long
enum
	SAPP_KEYCODE_INVALID = 0
	SAPP_KEYCODE_SPACE = 32
	SAPP_KEYCODE_APOSTROPHE = 39
	SAPP_KEYCODE_COMMA = 44
	SAPP_KEYCODE_MINUS = 45
	SAPP_KEYCODE_PERIOD = 46
	SAPP_KEYCODE_SLASH = 47
	SAPP_KEYCODE_0 = 48
	SAPP_KEYCODE_1 = 49
	SAPP_KEYCODE_2 = 50
	SAPP_KEYCODE_3 = 51
	SAPP_KEYCODE_4 = 52
	SAPP_KEYCODE_5 = 53
	SAPP_KEYCODE_6 = 54
	SAPP_KEYCODE_7 = 55
	SAPP_KEYCODE_8 = 56
	SAPP_KEYCODE_9 = 57
	SAPP_KEYCODE_SEMICOLON = 59
	SAPP_KEYCODE_EQUAL = 61
	SAPP_KEYCODE_A = 65
	SAPP_KEYCODE_B = 66
	SAPP_KEYCODE_C = 67
	SAPP_KEYCODE_D = 68
	SAPP_KEYCODE_E = 69
	SAPP_KEYCODE_F = 70
	SAPP_KEYCODE_G = 71
	SAPP_KEYCODE_H = 72
	SAPP_KEYCODE_I = 73
	SAPP_KEYCODE_J = 74
	SAPP_KEYCODE_K = 75
	SAPP_KEYCODE_L = 76
	SAPP_KEYCODE_M = 77
	SAPP_KEYCODE_N = 78
	SAPP_KEYCODE_O = 79
	SAPP_KEYCODE_P = 80
	SAPP_KEYCODE_Q = 81
	SAPP_KEYCODE_R = 82
	SAPP_KEYCODE_S = 83
	SAPP_KEYCODE_T = 84
	SAPP_KEYCODE_U = 85
	SAPP_KEYCODE_V = 86
	SAPP_KEYCODE_W = 87
	SAPP_KEYCODE_X = 88
	SAPP_KEYCODE_Y = 89
	SAPP_KEYCODE_Z = 90
	SAPP_KEYCODE_LEFT_BRACKET = 91
	SAPP_KEYCODE_BACKSLASH = 92
	SAPP_KEYCODE_RIGHT_BRACKET = 93
	SAPP_KEYCODE_GRAVE_ACCENT = 96
	SAPP_KEYCODE_WORLD_1 = 161
	SAPP_KEYCODE_WORLD_2 = 162
	SAPP_KEYCODE_ESCAPE = 256
	SAPP_KEYCODE_ENTER = 257
	SAPP_KEYCODE_TAB = 258
	SAPP_KEYCODE_BACKSPACE = 259
	SAPP_KEYCODE_INSERT = 260
	SAPP_KEYCODE_DELETE = 261
	SAPP_KEYCODE_RIGHT = 262
	SAPP_KEYCODE_LEFT = 263
	SAPP_KEYCODE_DOWN = 264
	SAPP_KEYCODE_UP = 265
	SAPP_KEYCODE_PAGE_UP = 266
	SAPP_KEYCODE_PAGE_DOWN = 267
	SAPP_KEYCODE_HOME = 268
	SAPP_KEYCODE_END = 269
	SAPP_KEYCODE_CAPS_LOCK = 280
	SAPP_KEYCODE_SCROLL_LOCK = 281
	SAPP_KEYCODE_NUM_LOCK = 282
	SAPP_KEYCODE_PRINT_SCREEN = 283
	SAPP_KEYCODE_PAUSE = 284
	SAPP_KEYCODE_F1 = 290
	SAPP_KEYCODE_F2 = 291
	SAPP_KEYCODE_F3 = 292
	SAPP_KEYCODE_F4 = 293
	SAPP_KEYCODE_F5 = 294
	SAPP_KEYCODE_F6 = 295
	SAPP_KEYCODE_F7 = 296
	SAPP_KEYCODE_F8 = 297
	SAPP_KEYCODE_F9 = 298
	SAPP_KEYCODE_F10 = 299
	SAPP_KEYCODE_F11 = 300
	SAPP_KEYCODE_F12 = 301
	SAPP_KEYCODE_F13 = 302
	SAPP_KEYCODE_F14 = 303
	SAPP_KEYCODE_F15 = 304
	SAPP_KEYCODE_F16 = 305
	SAPP_KEYCODE_F17 = 306
	SAPP_KEYCODE_F18 = 307
	SAPP_KEYCODE_F19 = 308
	SAPP_KEYCODE_F20 = 309
	SAPP_KEYCODE_F21 = 310
	SAPP_KEYCODE_F22 = 311
	SAPP_KEYCODE_F23 = 312
	SAPP_KEYCODE_F24 = 313
	SAPP_KEYCODE_F25 = 314
	SAPP_KEYCODE_KP_0 = 320
	SAPP_KEYCODE_KP_1 = 321
	SAPP_KEYCODE_KP_2 = 322
	SAPP_KEYCODE_KP_3 = 323
	SAPP_KEYCODE_KP_4 = 324
	SAPP_KEYCODE_KP_5 = 325
	SAPP_KEYCODE_KP_6 = 326
	SAPP_KEYCODE_KP_7 = 327
	SAPP_KEYCODE_KP_8 = 328
	SAPP_KEYCODE_KP_9 = 329
	SAPP_KEYCODE_KP_DECIMAL = 330
	SAPP_KEYCODE_KP_DIVIDE = 331
	SAPP_KEYCODE_KP_MULTIPLY = 332
	SAPP_KEYCODE_KP_SUBTRACT = 333
	SAPP_KEYCODE_KP_ADD = 334
	SAPP_KEYCODE_KP_ENTER = 335
	SAPP_KEYCODE_KP_EQUAL = 336
	SAPP_KEYCODE_LEFT_SHIFT = 340
	SAPP_KEYCODE_LEFT_CONTROL = 341
	SAPP_KEYCODE_LEFT_ALT = 342
	SAPP_KEYCODE_LEFT_SUPER = 343
	SAPP_KEYCODE_RIGHT_SHIFT = 344
	SAPP_KEYCODE_RIGHT_CONTROL = 345
	SAPP_KEYCODE_RIGHT_ALT = 346
	SAPP_KEYCODE_RIGHT_SUPER = 347
	SAPP_KEYCODE_MENU = 348
end enum

type sapp_android_tooltype as long
enum
	SAPP_ANDROIDTOOLTYPE_UNKNOWN = 0
	SAPP_ANDROIDTOOLTYPE_FINGER = 1
	SAPP_ANDROIDTOOLTYPE_STYLUS = 2
	SAPP_ANDROIDTOOLTYPE_MOUSE = 3
end enum

type sapp_touchpoint
	identifier as uinteger
	pos_x as single
	pos_y as single
	android_tooltype as sapp_android_tooltype
	changed as byte
end type

type sapp_mousebutton as long
enum
	SAPP_MOUSEBUTTON_LEFT = &h0
	SAPP_MOUSEBUTTON_RIGHT = &h1
	SAPP_MOUSEBUTTON_MIDDLE = &h2
	SAPP_MOUSEBUTTON_INVALID = &h100
end enum

enum
	SAPP_MODIFIER_SHIFT = &h1
	SAPP_MODIFIER_CTRL = &h2
	SAPP_MODIFIER_ALT = &h4
	SAPP_MODIFIER_SUPER = &h8
	SAPP_MODIFIER_LMB = &h100
	SAPP_MODIFIER_RMB = &h200
	SAPP_MODIFIER_MMB = &h400
end enum

type sapp_event
	frame_count as ulongint
	as sapp_event_type type
	key_code as sapp_keycode
	char_code as ulong
	key_repeat as byte
	modifiers as ulong
	mouse_button as sapp_mousebutton
	mouse_x as single
	mouse_y as single
	mouse_dx as single
	mouse_dy as single
	scroll_x as single
	scroll_y as single
	num_touches as long
	touches(0 to SAPP_MAX_TOUCHPOINTS - 1) as sapp_touchpoint
	window_width as long
	window_height as long
	framebuffer_width as long
	framebuffer_height as long
end type

type sapp_range
	ptr as const any ptr
	size as uinteger
end type

'' TODO: #define SAPP_RANGE(x) (sapp_range){ &x, sizeof(x) }

type sapp_image_desc
	width as long
	height as long
	pixels as sapp_range
end type

type sapp_icon_desc
	sokol_default as byte
	images(0 to SAPP_MAX_ICONIMAGES - 1) as sapp_image_desc
end type

type sapp_allocator
	alloc_fn as function(byval size as uinteger, byval user_data as any ptr) as any ptr
	free_fn as sub(byval ptr as any ptr, byval user_data as any ptr)
	user_data as any ptr
end type

'' TODO: #define _SAPP_LOG_ITEMS _SAPP_LOGITEM_XMACRO(OK, "Ok") _SAPP_LOGITEM_XMACRO(MALLOC_FAILED, "memory allocation failed") _SAPP_LOGITEM_XMACRO(MACOS_INVALID_NSOPENGL_PROFILE, "macos: invalid NSOpenGLProfile (valid choices are 1.0, 3.2 and 4.1)") _SAPP_LOGITEM_XMACRO(WIN32_LOAD_OPENGL32_DLL_FAILED, "failed loading opengl32.dll") _SAPP_LOGITEM_XMACRO(WIN32_CREATE_HELPER_WINDOW_FAILED, "failed to create helper window") _SAPP_LOGITEM_XMACRO(WIN32_HELPER_WINDOW_GETDC_FAILED, "failed to get helper window DC") _SAPP_LOGITEM_XMACRO(WIN32_DUMMY_CONTEXT_SET_PIXELFORMAT_FAILED, "failed to set pixel format for dummy GL context") _SAPP_LOGITEM_XMACRO(WIN32_CREATE_DUMMY_CONTEXT_FAILED, "failed to create dummy GL context") _SAPP_LOGITEM_XMACRO(WIN32_DUMMY_CONTEXT_MAKE_CURRENT_FAILED, "failed to make dummy GL context current") _SAPP_LOGITEM_XMACRO(WIN32_GET_PIXELFORMAT_ATTRIB_FAILED, "failed to get WGL pixel format attribute") _SAPP_LOGITEM_XMACRO(WIN32_WGL_FIND_PIXELFORMAT_FAILED, "failed to find matching WGL pixel format") _SAPP_LOGITEM_XMACRO(WIN32_WGL_DESCRIBE_PIXELFORMAT_FAILED, "failed to get pixel format descriptor") _SAPP_LOGITEM_XMACRO(WIN32_WGL_SET_PIXELFORMAT_FAILED, "failed to set selected pixel format") _SAPP_LOGITEM_XMACRO(WIN32_WGL_ARB_CREATE_CONTEXT_REQUIRED, "ARB_create_context required") _SAPP_LOGITEM_XMACRO(WIN32_WGL_ARB_CREATE_CONTEXT_PROFILE_REQUIRED, "ARB_create_context_profile required") _SAPP_LOGITEM_XMACRO(WIN32_WGL_OPENGL_3_2_NOT_SUPPORTED, "OpenGL 3.2 not supported by GL driver (ERROR_INVALID_VERSION_ARB)") _SAPP_LOGITEM_XMACRO(WIN32_WGL_OPENGL_PROFILE_NOT_SUPPORTED, "requested OpenGL profile not support by GL driver (ERROR_INVALID_PROFILE_ARB)") _SAPP_LOGITEM_XMACRO(WIN32_WGL_INCOMPATIBLE_DEVICE_CONTEXT, "CreateContextAttribsARB failed with ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB") _SAPP_LOGITEM_XMACRO(WIN32_WGL_CREATE_CONTEXT_ATTRIBS_FAILED_OTHER, "CreateContextAttribsARB failed for other reason") _SAPP_LOGITEM_XMACRO(WIN32_D3D11_CREATE_DEVICE_AND_SWAPCHAIN_WITH_DEBUG_FAILED, "D3D11CreateDeviceAndSwapChain() with D3D11_CREATE_DEVICE_DEBUG failed, retrying without debug flag.") _SAPP_LOGITEM_XMACRO(WIN32_D3D11_GET_IDXGIFACTORY_FAILED, "could not obtain IDXGIFactory object") _SAPP_LOGITEM_XMACRO(WIN32_D3D11_GET_IDXGIADAPTER_FAILED, "could not obtain IDXGIAdapter object") _SAPP_LOGITEM_XMACRO(WIN32_D3D11_QUERY_INTERFACE_IDXGIDEVICE1_FAILED, "could not obtain IDXGIDevice1 interface") _SAPP_LOGITEM_XMACRO(WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_LOCK, "RegisterRawInputDevices() failed (on mouse lock)") _SAPP_LOGITEM_XMACRO(WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_UNLOCK, "RegisterRawInputDevices() failed (on mouse unlock)") _SAPP_LOGITEM_XMACRO(WIN32_GET_RAW_INPUT_DATA_FAILED, "GetRawInputData() failed") _SAPP_LOGITEM_XMACRO(LINUX_GLX_LOAD_LIBGL_FAILED, "failed to load libGL") _SAPP_LOGITEM_XMACRO(LINUX_GLX_LOAD_ENTRY_POINTS_FAILED, "failed to load GLX entry points") _SAPP_LOGITEM_XMACRO(LINUX_GLX_EXTENSION_NOT_FOUND, "GLX extension not found") _SAPP_LOGITEM_XMACRO(LINUX_GLX_QUERY_VERSION_FAILED, "failed to query GLX version") _SAPP_LOGITEM_XMACRO(LINUX_GLX_VERSION_TOO_LOW, "GLX version too low (need at least 1.3)") _SAPP_LOGITEM_XMACRO(LINUX_GLX_NO_GLXFBCONFIGS, "glXGetFBConfigs() returned no configs") _SAPP_LOGITEM_XMACRO(LINUX_GLX_NO_SUITABLE_GLXFBCONFIG, "failed to find a suitable GLXFBConfig") _SAPP_LOGITEM_XMACRO(LINUX_GLX_GET_VISUAL_FROM_FBCONFIG_FAILED, "glXGetVisualFromFBConfig failed") _SAPP_LOGITEM_XMACRO(LINUX_GLX_REQUIRED_EXTENSIONS_MISSING, "GLX extensions ARB_create_context and ARB_create_context_profile missing") _SAPP_LOGITEM_XMACRO(LINUX_GLX_CREATE_CONTEXT_FAILED, "Failed to create GL context via glXCreateContextAttribsARB") _SAPP_LOGITEM_XMACRO(LINUX_GLX_CREATE_WINDOW_FAILED, "glXCreateWindow() failed") _SAPP_LOGITEM_XMACRO(LINUX_X11_CREATE_WINDOW_FAILED, "XCreateWindow() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_BIND_OPENGL_API_FAILED, "eglBindAPI(EGL_OPENGL_API) failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_BIND_OPENGL_ES_API_FAILED, "eglBindAPI(EGL_OPENGL_ES_API) failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_GET_DISPLAY_FAILED, "eglGetDisplay() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_INITIALIZE_FAILED, "eglInitialize() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_NO_CONFIGS, "eglChooseConfig() returned no configs") _SAPP_LOGITEM_XMACRO(LINUX_EGL_NO_NATIVE_VISUAL, "eglGetConfigAttrib() for EGL_NATIVE_VISUAL_ID failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_GET_VISUAL_INFO_FAILED, "XGetVisualInfo() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_CREATE_WINDOW_SURFACE_FAILED, "eglCreateWindowSurface() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_CREATE_CONTEXT_FAILED, "eglCreateContext() failed") _SAPP_LOGITEM_XMACRO(LINUX_EGL_MAKE_CURRENT_FAILED, "eglMakeCurrent() failed") _SAPP_LOGITEM_XMACRO(LINUX_X11_OPEN_DISPLAY_FAILED, "XOpenDisplay() failed") _SAPP_LOGITEM_XMACRO(LINUX_X11_QUERY_SYSTEM_DPI_FAILED, "failed to query system dpi value, assuming default 96.0") _SAPP_LOGITEM_XMACRO(LINUX_X11_DROPPED_FILE_URI_WRONG_SCHEME, "dropped file URL doesn't start with 'file://'") _SAPP_LOGITEM_XMACRO(ANDROID_UNSUPPORTED_INPUT_EVENT_INPUT_CB, "unsupported input event encountered in _sapp_android_input_cb()") _SAPP_LOGITEM_XMACRO(ANDROID_UNSUPPORTED_INPUT_EVENT_MAIN_CB, "unsupported input event encountered in _sapp_android_main_cb()") _SAPP_LOGITEM_XMACRO(ANDROID_READ_MSG_FAILED, "failed to read message in _sapp_android_main_cb()") _SAPP_LOGITEM_XMACRO(ANDROID_WRITE_MSG_FAILED, "failed to write message in _sapp_android_msg") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_CREATE, "MSG_CREATE") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_RESUME, "MSG_RESUME") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_PAUSE, "MSG_PAUSE") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_FOCUS, "MSG_FOCUS") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_NO_FOCUS, "MSG_NO_FOCUS") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_SET_NATIVE_WINDOW, "MSG_SET_NATIVE_WINDOW") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_SET_INPUT_QUEUE, "MSG_SET_INPUT_QUEUE") _SAPP_LOGITEM_XMACRO(ANDROID_MSG_DESTROY, "MSG_DESTROY") _SAPP_LOGITEM_XMACRO(ANDROID_UNKNOWN_MSG, "unknown msg type received") _SAPP_LOGITEM_XMACRO(ANDROID_LOOP_THREAD_STARTED, "loop thread started") _SAPP_LOGITEM_XMACRO(ANDROID_LOOP_THREAD_DONE, "loop thread done") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONSTART, "NativeActivity onStart()") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONRESUME, "NativeActivity onResume") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONSAVEINSTANCESTATE, "NativeActivity onSaveInstanceState") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONWINDOWFOCUSCHANGED, "NativeActivity onWindowFocusChanged") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONPAUSE, "NativeActivity onPause") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONSTOP, "NativeActivity onStop()") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWCREATED, "NativeActivity onNativeWindowCreated") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWDESTROYED, "NativeActivity onNativeWindowDestroyed") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUECREATED, "NativeActivity onInputQueueCreated") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUEDESTROYED, "NativeActivity onInputQueueDestroyed") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONCONFIGURATIONCHANGED, "NativeActivity onConfigurationChanged") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONLOWMEMORY, "NativeActivity onLowMemory") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONDESTROY, "NativeActivity onDestroy") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_DONE, "NativeActivity done") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_ONCREATE, "NativeActivity onCreate") _SAPP_LOGITEM_XMACRO(ANDROID_CREATE_THREAD_PIPE_FAILED, "failed to create thread pipe") _SAPP_LOGITEM_XMACRO(ANDROID_NATIVE_ACTIVITY_CREATE_SUCCESS, "NativeActivity successfully created") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_SURFACE_FAILED, "wgpu: failed to create surface for swapchain") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_SWAPCHAIN_FAILED, "wgpu: failed to create swapchain object") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_TEXTURE_FAILED, "wgpu: failed to create depth-stencil texture for swapchain") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_VIEW_FAILED, "wgpu: failed to create view object for swapchain depth-stencil texture") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_MSAA_TEXTURE_FAILED, "wgpu: failed to create msaa texture for swapchain") _SAPP_LOGITEM_XMACRO(WGPU_SWAPCHAIN_CREATE_MSAA_VIEW_FAILED, "wgpu: failed to create view object for swapchain msaa texture") _SAPP_LOGITEM_XMACRO(WGPU_REQUEST_DEVICE_STATUS_ERROR, "wgpu: requesting device failed with status 'error'") _SAPP_LOGITEM_XMACRO(WGPU_REQUEST_DEVICE_STATUS_UNKNOWN, "wgpu: requesting device failed with status 'unknown'") _SAPP_LOGITEM_XMACRO(WGPU_REQUEST_ADAPTER_STATUS_UNAVAILABLE, "wgpu: requesting adapter failed with 'unavailable'") _SAPP_LOGITEM_XMACRO(WGPU_REQUEST_ADAPTER_STATUS_ERROR, "wgpu: requesting adapter failed with status 'error'") _SAPP_LOGITEM_XMACRO(WGPU_REQUEST_ADAPTER_STATUS_UNKNOWN, "wgpu: requesting adapter failed with status 'unknown'") _SAPP_LOGITEM_XMACRO(WGPU_CREATE_INSTANCE_FAILED, "wgpu: failed to create instance") _SAPP_LOGITEM_XMACRO(IMAGE_DATA_SIZE_MISMATCH, "image data size mismatch (must be width*height*4 bytes)") _SAPP_LOGITEM_XMACRO(DROPPED_FILE_PATH_TOO_LONG, "dropped file path too long (sapp_desc.max_dropped_filed_path_length)") _SAPP_LOGITEM_XMACRO(CLIPBOARD_STRING_TOO_BIG, "clipboard string didn't fit into clipboard buffer")
'' TODO: #define _SAPP_LOGITEM_XMACRO(item,msg) SAPP_LOGITEM_##item,

type sapp_log_item as long
enum
	SAPP_LOGITEM_OK
	SAPP_LOGITEM_MALLOC_FAILED
	SAPP_LOGITEM_MACOS_INVALID_NSOPENGL_PROFILE
	SAPP_LOGITEM_WIN32_LOAD_OPENGL32_DLL_FAILED
	SAPP_LOGITEM_WIN32_CREATE_HELPER_WINDOW_FAILED
	SAPP_LOGITEM_WIN32_HELPER_WINDOW_GETDC_FAILED
	SAPP_LOGITEM_WIN32_DUMMY_CONTEXT_SET_PIXELFORMAT_FAILED
	SAPP_LOGITEM_WIN32_CREATE_DUMMY_CONTEXT_FAILED
	SAPP_LOGITEM_WIN32_DUMMY_CONTEXT_MAKE_CURRENT_FAILED
	SAPP_LOGITEM_WIN32_GET_PIXELFORMAT_ATTRIB_FAILED
	SAPP_LOGITEM_WIN32_WGL_FIND_PIXELFORMAT_FAILED
	SAPP_LOGITEM_WIN32_WGL_DESCRIBE_PIXELFORMAT_FAILED
	SAPP_LOGITEM_WIN32_WGL_SET_PIXELFORMAT_FAILED
	SAPP_LOGITEM_WIN32_WGL_ARB_CREATE_CONTEXT_REQUIRED
	SAPP_LOGITEM_WIN32_WGL_ARB_CREATE_CONTEXT_PROFILE_REQUIRED
	SAPP_LOGITEM_WIN32_WGL_OPENGL_3_2_NOT_SUPPORTED
	SAPP_LOGITEM_WIN32_WGL_OPENGL_PROFILE_NOT_SUPPORTED
	SAPP_LOGITEM_WIN32_WGL_INCOMPATIBLE_DEVICE_CONTEXT
	SAPP_LOGITEM_WIN32_WGL_CREATE_CONTEXT_ATTRIBS_FAILED_OTHER
	SAPP_LOGITEM_WIN32_D3D11_CREATE_DEVICE_AND_SWAPCHAIN_WITH_DEBUG_FAILED
	SAPP_LOGITEM_WIN32_D3D11_GET_IDXGIFACTORY_FAILED
	SAPP_LOGITEM_WIN32_D3D11_GET_IDXGIADAPTER_FAILED
	SAPP_LOGITEM_WIN32_D3D11_QUERY_INTERFACE_IDXGIDEVICE1_FAILED
	SAPP_LOGITEM_WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_LOCK
	SAPP_LOGITEM_WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_UNLOCK
	SAPP_LOGITEM_WIN32_GET_RAW_INPUT_DATA_FAILED
	SAPP_LOGITEM_LINUX_GLX_LOAD_LIBGL_FAILED
	SAPP_LOGITEM_LINUX_GLX_LOAD_ENTRY_POINTS_FAILED
	SAPP_LOGITEM_LINUX_GLX_EXTENSION_NOT_FOUND
	SAPP_LOGITEM_LINUX_GLX_QUERY_VERSION_FAILED
	SAPP_LOGITEM_LINUX_GLX_VERSION_TOO_LOW
	SAPP_LOGITEM_LINUX_GLX_NO_GLXFBCONFIGS
	SAPP_LOGITEM_LINUX_GLX_NO_SUITABLE_GLXFBCONFIG
	SAPP_LOGITEM_LINUX_GLX_GET_VISUAL_FROM_FBCONFIG_FAILED
	SAPP_LOGITEM_LINUX_GLX_REQUIRED_EXTENSIONS_MISSING
	SAPP_LOGITEM_LINUX_GLX_CREATE_CONTEXT_FAILED
	SAPP_LOGITEM_LINUX_GLX_CREATE_WINDOW_FAILED
	SAPP_LOGITEM_LINUX_X11_CREATE_WINDOW_FAILED
	SAPP_LOGITEM_LINUX_EGL_BIND_OPENGL_API_FAILED
	SAPP_LOGITEM_LINUX_EGL_BIND_OPENGL_ES_API_FAILED
	SAPP_LOGITEM_LINUX_EGL_GET_DISPLAY_FAILED
	SAPP_LOGITEM_LINUX_EGL_INITIALIZE_FAILED
	SAPP_LOGITEM_LINUX_EGL_NO_CONFIGS
	SAPP_LOGITEM_LINUX_EGL_NO_NATIVE_VISUAL
	SAPP_LOGITEM_LINUX_EGL_GET_VISUAL_INFO_FAILED
	SAPP_LOGITEM_LINUX_EGL_CREATE_WINDOW_SURFACE_FAILED
	SAPP_LOGITEM_LINUX_EGL_CREATE_CONTEXT_FAILED
	SAPP_LOGITEM_LINUX_EGL_MAKE_CURRENT_FAILED
	SAPP_LOGITEM_LINUX_X11_OPEN_DISPLAY_FAILED
	SAPP_LOGITEM_LINUX_X11_QUERY_SYSTEM_DPI_FAILED
	SAPP_LOGITEM_LINUX_X11_DROPPED_FILE_URI_WRONG_SCHEME
	SAPP_LOGITEM_ANDROID_UNSUPPORTED_INPUT_EVENT_INPUT_CB
	SAPP_LOGITEM_ANDROID_UNSUPPORTED_INPUT_EVENT_MAIN_CB
	SAPP_LOGITEM_ANDROID_READ_MSG_FAILED
	SAPP_LOGITEM_ANDROID_WRITE_MSG_FAILED
	SAPP_LOGITEM_ANDROID_MSG_CREATE
	SAPP_LOGITEM_ANDROID_MSG_RESUME
	SAPP_LOGITEM_ANDROID_MSG_PAUSE
	SAPP_LOGITEM_ANDROID_MSG_FOCUS
	SAPP_LOGITEM_ANDROID_MSG_NO_FOCUS
	SAPP_LOGITEM_ANDROID_MSG_SET_NATIVE_WINDOW
	SAPP_LOGITEM_ANDROID_MSG_SET_INPUT_QUEUE
	SAPP_LOGITEM_ANDROID_MSG_DESTROY
	SAPP_LOGITEM_ANDROID_UNKNOWN_MSG
	SAPP_LOGITEM_ANDROID_LOOP_THREAD_STARTED
	SAPP_LOGITEM_ANDROID_LOOP_THREAD_DONE
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONSTART
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONRESUME
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONSAVEINSTANCESTATE
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONWINDOWFOCUSCHANGED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONPAUSE
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONSTOP
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWCREATED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWDESTROYED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUECREATED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUEDESTROYED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONCONFIGURATIONCHANGED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONLOWMEMORY
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONDESTROY
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_DONE
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_ONCREATE
	SAPP_LOGITEM_ANDROID_CREATE_THREAD_PIPE_FAILED
	SAPP_LOGITEM_ANDROID_NATIVE_ACTIVITY_CREATE_SUCCESS
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_SURFACE_FAILED
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_SWAPCHAIN_FAILED
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_TEXTURE_FAILED
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_VIEW_FAILED
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_MSAA_TEXTURE_FAILED
	SAPP_LOGITEM_WGPU_SWAPCHAIN_CREATE_MSAA_VIEW_FAILED
	SAPP_LOGITEM_WGPU_REQUEST_DEVICE_STATUS_ERROR
	SAPP_LOGITEM_WGPU_REQUEST_DEVICE_STATUS_UNKNOWN
	SAPP_LOGITEM_WGPU_REQUEST_ADAPTER_STATUS_UNAVAILABLE
	SAPP_LOGITEM_WGPU_REQUEST_ADAPTER_STATUS_ERROR
	SAPP_LOGITEM_WGPU_REQUEST_ADAPTER_STATUS_UNKNOWN
	SAPP_LOGITEM_WGPU_CREATE_INSTANCE_FAILED
	SAPP_LOGITEM_IMAGE_DATA_SIZE_MISMATCH
	SAPP_LOGITEM_DROPPED_FILE_PATH_TOO_LONG
	SAPP_LOGITEM_CLIPBOARD_STRING_TOO_BIG
end enum

#undef _SAPP_LOGITEM_XMACRO

type sapp_logger
	func as sub(byval tag as const zstring ptr, byval log_level as ulong, byval log_item_id as ulong, byval message_or_null as const zstring ptr, byval line_nr as ulong, byval filename_or_null as const zstring ptr, byval user_data as any ptr)
	user_data as any ptr
end type

type sapp_desc
	init_cb as sub()
	frame_cb as sub()
	cleanup_cb as sub()
	event_cb as sub(byval as const sapp_event ptr)
	user_data as any ptr
	init_userdata_cb as sub(byval as any ptr)
	frame_userdata_cb as sub(byval as any ptr)
	cleanup_userdata_cb as sub(byval as any ptr)
	event_userdata_cb as sub(byval as const sapp_event ptr, byval as any ptr)
	width as long
	height as long
	sample_count as long
	swap_interval as long
	high_dpi as byte
	fullscreen as byte
	alpha as byte
	window_title as const zstring ptr
	enable_clipboard as byte
	clipboard_size as long
	enable_dragndrop as byte
	max_dropped_files as long
	max_dropped_file_path_length as long
	icon as sapp_icon_desc
	allocator as sapp_allocator
	logger as sapp_logger
	gl_major_version as long
	gl_minor_version as long
	win32_console_utf8 as byte
	win32_console_create as byte
	win32_console_attach as byte
	html5_canvas_name as const zstring ptr
	html5_canvas_resize as byte
	html5_preserve_drawing_buffer as byte
	html5_premultiplied_alpha as byte
	html5_ask_leave_site as byte
	html5_bubble_mouse_events as byte
	html5_bubble_touch_events as byte
	html5_bubble_wheel_events as byte
	html5_bubble_key_events as byte
	html5_bubble_char_events as byte
	html5_use_emsc_set_main_loop as byte
	html5_emsc_set_main_loop_simulate_infinite_loop as byte
	ios_keyboard_resizes_canvas as byte
end type

type sapp_html5_fetch_error as long
enum
	SAPP_HTML5_FETCH_ERROR_NO_ERROR
	SAPP_HTML5_FETCH_ERROR_BUFFER_TOO_SMALL
	SAPP_HTML5_FETCH_ERROR_OTHER
end enum

type sapp_html5_fetch_response
	succeeded as byte
	error_code as sapp_html5_fetch_error
	file_index as long
	data as sapp_range
	buffer as sapp_range
	user_data as any ptr
end type

type sapp_html5_fetch_request
	dropped_file_index as long
	callback as sub(byval as const sapp_html5_fetch_response ptr)
	buffer as sapp_range
	user_data as any ptr
end type

type sapp_mouse_cursor as long
enum
	SAPP_MOUSECURSOR_DEFAULT = 0
	SAPP_MOUSECURSOR_ARROW
	SAPP_MOUSECURSOR_IBEAM
	SAPP_MOUSECURSOR_CROSSHAIR
	SAPP_MOUSECURSOR_POINTING_HAND
	SAPP_MOUSECURSOR_RESIZE_EW
	SAPP_MOUSECURSOR_RESIZE_NS
	SAPP_MOUSECURSOR_RESIZE_NWSE
	SAPP_MOUSECURSOR_RESIZE_NESW
	SAPP_MOUSECURSOR_RESIZE_ALL
	SAPP_MOUSECURSOR_NOT_ALLOWED
	_SAPP_MOUSECURSOR_NUM
end enum

declare function sokol_main(byval argc as long, byval argv as zstring ptr ptr) as sapp_desc
declare function sapp_isvalid() as byte
declare function sapp_width() as long
declare function sapp_widthf() as single
declare function sapp_height() as long
declare function sapp_heightf() as single
declare function sapp_color_format() as long
declare function sapp_depth_format() as long
declare function sapp_sample_count() as long
declare function sapp_high_dpi() as byte
declare function sapp_dpi_scale() as single
declare sub sapp_show_keyboard(byval show as byte)
declare function sapp_keyboard_shown() as byte
declare function sapp_is_fullscreen() as byte
declare sub sapp_toggle_fullscreen()
declare sub sapp_show_mouse(byval show as byte)
declare function sapp_mouse_shown() as byte
declare sub sapp_lock_mouse(byval lock as byte)
declare function sapp_mouse_locked() as byte
declare sub sapp_set_mouse_cursor(byval cursor as sapp_mouse_cursor)
declare function sapp_get_mouse_cursor() as sapp_mouse_cursor
declare function sapp_userdata() as any ptr
declare function sapp_query_desc() as sapp_desc
declare sub sapp_request_quit()
declare sub sapp_cancel_quit()
declare sub sapp_quit()
declare sub sapp_consume_event()
declare function sapp_frame_count() as ulongint
declare function sapp_frame_duration() as double
declare sub sapp_set_clipboard_string(byval str as const zstring ptr)
declare function sapp_get_clipboard_string() as const zstring ptr
declare sub sapp_set_window_title(byval str as const zstring ptr)
declare sub sapp_set_icon(byval icon_desc as const sapp_icon_desc ptr)
declare function sapp_get_num_dropped_files() as long
declare function sapp_get_dropped_file_path(byval index as long) as const zstring ptr
declare sub sapp_run(byval desc as const sapp_desc ptr)
declare function sapp_egl_get_display() as const any ptr
declare function sapp_egl_get_context() as const any ptr
declare sub sapp_html5_ask_leave_site(byval ask as byte)
declare function sapp_html5_get_dropped_file_size(byval index as long) as ulong
declare sub sapp_html5_fetch_dropped_file(byval request as const sapp_html5_fetch_request ptr)
declare function sapp_metal_get_device() as const any ptr
declare function sapp_metal_get_current_drawable() as const any ptr
declare function sapp_metal_get_depth_stencil_texture() as const any ptr
declare function sapp_metal_get_msaa_color_texture() as const any ptr
declare function sapp_macos_get_window() as const any ptr
declare function sapp_ios_get_window() as const any ptr
declare function sapp_d3d11_get_device() as const any ptr
declare function sapp_d3d11_get_device_context() as const any ptr
declare function sapp_d3d11_get_swap_chain() as const any ptr
declare function sapp_d3d11_get_render_view() as const any ptr
declare function sapp_d3d11_get_resolve_view() as const any ptr
declare function sapp_d3d11_get_depth_stencil_view() as const any ptr
declare function sapp_win32_get_hwnd() as const any ptr
declare function sapp_wgpu_get_device() as const any ptr
declare function sapp_wgpu_get_render_view() as const any ptr
declare function sapp_wgpu_get_resolve_view() as const any ptr
declare function sapp_wgpu_get_depth_stencil_view() as const any ptr
declare function sapp_gl_get_framebuffer() as ulong
declare function sapp_gl_get_major_version() as long
declare function sapp_gl_get_minor_version() as long
declare function sapp_android_get_native_activity() as const any ptr

end extern
