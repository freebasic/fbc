#ifndef __FB_OBJ_BI__
#define __FB_OBJ_BI__

'' callbcks used when scanning object files for libraries
type FB_CALLBACK_ADDLIB as sub _
	( _
		byval libName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDLIBPATH as sub _
	( _
		byval pathName as zstring ptr, _
		byval objName as zstring ptr _
	)

type FB_CALLBACK_ADDOPTION as sub _
	( _
		byval opt as FB_COMPOPT, _
		byval value as zstring ptr, _
		byval objName as zstring ptr _
	)

declare function fbObjInfoWriteObj _
	( _
		byval liblist as TLIST ptr, _
		byval libpathlist as TLIST ptr _
	) as integer

declare function fbObjInfoReadObj _
	( _
		byval objName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION _
	) as integer

declare function fbObjInfoReadLib _
	( _
		byval libName as zstring ptr, _
		byval addLib as FB_CALLBACK_ADDLIB, _
		byval addLibPath as FB_CALLBACK_ADDLIBPATH, _
		byval addOption as FB_CALLBACK_ADDOPTION, _
		byval libpathlist as TLIST ptr _
	) as integer

#endif '' __FB_OBJ_BI__
