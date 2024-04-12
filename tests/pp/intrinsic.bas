' TEST_MODE : COMPILE_ONLY_OK

'' Test intrinsic defines that are always defined

#ifndef __FB_DEBUG__
#error __FB_DEBUG__ not defined
#endif

#ifndef __FB_ERR__
#error __FB_ERR__ not defined
#endif

#ifndef __FB_MIN_VERSION__
#error __FB_MIN_VERSION__ not defined
#endif

#ifndef __FB_SIGNATURE__
#error __FB_SIGNATURE__ not defined
#endif

#ifndef __FB_VERSION__
#error __FB_VERSION__ not defined
#endif

#ifndef __FB_VER_MAJOR__
#error __FB_VER_MAJOR__ not defined
#endif

#ifndef __FB_VER_MINOR__
#error __FB_VER_MINOR__ not defined
#endif

#ifndef __FB_VER_PATCH__
#error __FB_VER_PATCH__ not defined
#endif

#ifndef __PATH__
#error __PATH__ not defined
#endif

#ifndef __FILE__
#error __FILE__ not defined
#endif

#ifndef __FILE_NQ__
#error __FILE_NQ__ not defined
#endif

#ifndef __FUNCTION__
#error __FUNCTION__ not defined
#endif

#ifndef __FUNCTION_NQ__
#error __FUNCTION_NQ__ not defined
#endif

#ifndef __FB_MT__
#error __FB_MT__ not defined
#endif

#ifndef __FB_OPTION_BYVAL__
#error __FB_OPTION_BYVAL__ not defined
#endif

#ifndef __FB_OPTION_DYNAMIC__
#error __FB_OPTION_DYNAMIC__ not defined
#endif

#ifndef __FB_OPTION_ESCAPE__
#error __FB_OPTION_ESCAPE__ not defined
#endif

#ifndef __FB_OPTION_EXPLICIT__
#error __FB_OPTION_EXPLICIT__ not defined
#endif

#ifndef __FB_OPTION_PRIVATE__
#error __FB_OPTION_PRIVATE__ not defined
#endif

#ifndef __FB_OPTION_GOSUB__
#error __FB_OPTION_GOSUB__ not defined
#endif

#ifndef __FB_OPTION_PROFILE__
#error __FB_OPTION_PROFILE__ not defined
#endif

#ifndef __FB_OUT_DLL__
#error __FB_OUT_DLL__ not defined
#endif

#ifndef __FB_OUT_EXE__
#error __FB_OUT_EXE__ not defined
#endif

#ifndef __FB_OUT_LIB__
#error __FB_OUT_LIB__ not defined
#endif

#ifndef __FB_OUT_OBJ__
#error __FB_OUT_OBJ__ not defined
#endif

#ifndef __LINE__
#error __LINE__ not defined
#endif

#ifndef __DATE__
#error __DATE__ not defined
#endif

#ifndef __DATE_ISO__
#error __FB_LANG__ not defined
#endif

#ifndef __TIME__
#error __TIME__ not defined
#endif

#ifndef __FB_GUI__
#error __FB_GUI__ not defined
#endif

#ifndef __FB_BUILD_DATE__
#error __FB_BUILD_DATE__ not defined
#endif

#ifndef __FB_BUILD_DATE_ISO__
#error __FB_BUILD_DATE_ISO__ not defined
#endif

#ifndef __FB_BUILD_FORK_ID__
#error __FB_BUILD_FORK_ID__ not defined
#endif

#ifndef __FB_GCC__
#error __FB_GCC__ not defined
#endif

#ifndef __FB_BACKEND__
#error __FB_BACKEND__ not defined
#endif

#ifndef __FB_FPU__
#error __FB_FPU__ not defined
#endif

#ifndef __FB_FPMODE__
#error __FB_FPMODE__ not defined
#endif

#ifndef __FB_OPTIMIZE__
#error __FB_OPTIMIZE__ not defined
#endif

#ifndef __FB_PROFILE__
#error __FB_PROFILE__ not defined
#endif

'' Always defined for this test

#ifndef __FB_LANG__
#error __FB_LANG__ not defined
#endif

'' Depends on compiler output.  Not tested.
' __FB_MAIN__

'' Depends on makefile options.  Not tested.
' __FB_BUILD_SHA1__

'' Depends on target.  Not tested.
' __FB_WIN32__
' __FB_LINUX__
' __FB_DOS__
' __FB_CYGWIN__
' __FB_FREEBSD__
' __FB_NETBSD__
' __FB_OPENBSD__
' __FB_DARWIN__
' __FB_DRAGONFLY__
' __FB_SOLARIS__
' __FB_XBOX__
' __FB_BIGENDIAN__
' __FB_PCOS__
' __FB_UNIX__
' __FB_64BIT__
' __FB_ARM__
' __FB_PPC__
' __FB_X86__
' __FB_JS__
' __FB_ANDROID__
' __FB_ASM__
' __FB_SSE__
' __FB_VECTORIZE__
