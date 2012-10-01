/''
 ' This example shows how you can simulate getting a class method pointer, 
 ' until support is properly implemented in the compiler.
 '
 ' When this is supported, you will only need to remove the static wrapper
 ' function presented here, to maintain compatibility. 
 '/

type MyFavoriteType
	declare function myFavoriteMethod(byval number as integer) as integer
	declare static function myFavoriteMethod(byref this as MyFavoriteType, byval number as integer) as integer

	dim as integer myFavoriteNumber = 420
end type

function MyFavoriteType.myFavoriteMethod(byval number as integer) as integer
	return myFavoriteNumber + number
end function

function MyFavoriteType.myFavoriteMethod(byref this as MyFavoriteType, byval number as integer) as integer
	return this.myFavoriteMethod(number)
end function

dim methodPointer as function(byref as MyFavoriteType, byval as integer) as integer
methodPointer = ProcPtr(MyFavoriteType.myFavoriteMethod)

dim as MyFavoriteType obj

print methodPointer(obj, 69) '' prints 489
