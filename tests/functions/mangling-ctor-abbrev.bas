' TEST_MODE : COMPILE_AND_RUN_OK

'' regression test for abbreviation mangling under -gen gcc

extern "C++"

type FBQObject
	declare constructor(byval as FBQObject ptr = 0)
	as any ptr d_ptr
end type

type FBQWidget extends FBQObject
	enum RenderFlag
		DrawWindowBackground = &h1
	end enum
	as RenderFlag RenderFlags
end type

type FBQLCDNumber extends FBQObject
	declare constructor(byval as FBQWidget ptr = 0)
end type

end extern

type DigitalClock extends FBQLCDNumber
	declare constructor(byval as FBQWidget ptr = 0)
end type

constructor DigitalClock(byval parent as FBQWidget ptr)
end constructor

'' fbc version 1.10.0 added __thiscall calling convention which is the default win32/g++
'' Even though version 1.09.0 and earlier passed the test, interop with g++ libraries
'' would have had the wrong calling convention.

#if __FB_VERSION__ >= "1.10.0"
	#if defined( __FB_WIN32__ ) andalso not defined( __FB_64BIT__ )
		#define ctorCallConvention __thiscall
	#else
		#define ctorCallConvention cdecl
	#endif
#else
	#define ctorCallConvention cdecl
#endif

''constructor FBQObject(byval parent as FBQObject ptr)
''end constructor
sub FBQObject_ctor ctorCallConvention alias "_ZN9FBQObjectC1EPS_"(byref this_ as FBQObject, byval parent as FBQObject ptr)
end sub

''constructor FBQLCDNumber(byval parent as FBQWidget ptr)
''end constructor
sub FBQLCDNumber_ctor ctorCallConvention alias "_ZN12FBQLCDNumberC1EP9FBQWidget"(byref this_ as FBQLCDNumber, byval parent as FBQWidget ptr)
end sub

dim xobject as FBQObject
dim xlcdnumber as FBQLCDNumber
