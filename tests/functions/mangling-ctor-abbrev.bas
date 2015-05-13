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

''constructor FBQObject(byval parent as FBQObject ptr)
''end constructor
sub FBQObject_ctor cdecl alias "_ZN9FBQObjectC1EPS_"(byref this_ as FBQObject, byval parent as FBQObject ptr)
end sub

''constructor FBQLCDNumber(byval parent as FBQWidget ptr)
''end constructor
sub FBQLCDNumber_ctor cdecl alias "_ZN12FBQLCDNumberC1EP9FBQWidget"(byref this_ as FBQLCDNumber, byval parent as FBQWidget ptr)
end sub

dim xobject as FBQObject
dim xlcdnumber as FBQLCDNumber
