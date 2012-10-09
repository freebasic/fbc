#ifndef DISABLE_OBJINFO

'' callbacks used when scanning object files for libraries
type FB_CALLBACK_ADDLIB as sub( byval libname as zstring ptr )
type FB_CALLBACK_ADDLIBPATH as sub( byval libpath as zstring ptr )
type FB_CALLBACK_ADDOPTION as sub _
	( _
		byval opt as FB_COMPOPT, _
		byval value as zstring ptr, _
		byref objName as string _
	)

declare sub fbObjInfoReadObj _
	( _
		byref objfile as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

declare sub fbObjInfoReadLibfile _
	( _
		byref libfile as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	)

declare sub fbObjInfoReadLib _
	( _
		byref libname as string, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpaths as TLIST ptr _
	)

#endif
