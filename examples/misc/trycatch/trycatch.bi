namespace crt
#include once "crt/setjmp.bi"
end namespace

'' example how to implement a try/catch using the C runtime setjmp()/longjmp(), plus the __FB_UNIQUEID_###__() and __FB_ARG_###__() builtin macros

#macro TRY 
	scope
		__FB_UNIQUEID_PUSH__(__tc__)
		dim __FB_UNIQUEID__(__tc__) as TryCatch
		if crt.setjmp(@__FB_UNIQUEID__(__tc__).buf) = 0 then
#endmacro

#macro CATCH ? (x) 
		elseif *cast(object ptr, __FB_UNIQUEID__(__tc__).ex) is __FB_ARG_RIGHTOF__(x, AS) then
			var __FB_ARG_LEFTOF__(x, AS) = cast(__FB_ARG_RIGHTOF__(x, AS) ptr, __FB_UNIQUEID__(__tc__).ex)
#endmacro

#macro THROW ? (x) 
		__FB_UNIQUEID__(__tc__).throw_(x, __FILE__, __FUNCTION__, __LINE__)
#endmacro

#macro END_TRY 
		end if 
		__FB_UNIQUEID_POP__(__tc__)
	end scope
#endmacro

type Exception extends Object
	declare constructor()
	declare constructor(msg as zstring ptr)
	declare destructor()
	declare property message() as string
	declare property file() as string
	declare property file(file as zstring ptr)
	declare property func() as string
	declare property func(func as zstring ptr)
	declare property line() as integer
	declare property line(line as integer)
	declare operator cast() as string
	declare function toString() as string
private:	
	msg			as zstring ptr
	file_ 		as zstring ptr
	func_ 		as zstring ptr
	line_ 		as integer
end type

type TryCatch
	declare constructor()
	declare destructor()
	declare sub throw_(file as zstring ptr, func as zstring ptr, line_ as integer)
	declare sub throw_(msg as zstring ptr, file as zstring ptr, func as zstring ptr, line_ as integer)
	declare sub throw_(ex as Exception ptr, file as zstring ptr, func as zstring ptr, line_ as integer)
	buf			as crt.jmp_buf = any
	ex			as Exception ptr
	prev		as TryCatch ptr
end type

