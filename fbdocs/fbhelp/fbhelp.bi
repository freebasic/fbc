#ifndef __FBHELP_BI__
#define __FBHELP_BI__

#define APP_TITLE     "FreeBASIC Manual"
#define APP_NAME      "fbhelp"
#define APP_VERSION   "v0.8b"
#define APP_COPYRIGHT "Copyright (C) 2006-2008 Jeffery R. Marshall"
#define APP_CONTACT   "coder@execulink.com"

#if defined(__FB_DOS__)
#define APP_TARGET "dos"
#endif

#if defined(__FB_LINUX__)
#define APP_TARGET "linux"
#endif

#if defined(__FB_WIN32__)
#define APP_TARGET "win32"
#endif

#if not defined(APP_TARGET)
#error Unsupported target
#endif

#endif