' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

#ifndef ALC_BI
#define ALC_BI


'$INCLUDE: 'al/altypes.bi'
'$INCLUDE: 'al/alctypes.bi'


' Maintaining the same form as the original OpenAL headers here... seems
' a bit strange, but maybe there's a reason. -chris
'
type ALCdevice_struct
   placeholder as byte
end type

type ALCcontext_struct
   placeholder as byte
end type

type ALCdevice       as ALCdevice_struct
type ALCcontext  	 as ALCcontext_struct



#ifndef ALC_NO_PROTOTYPES

   ' Device Functions
   declare function alcGetString cdecl ALIAS "alcGetString" (byval device as ALCdevice ptr, byval param as ALCenum) as ALCubyte ptr
   declare sub alcGetIntegerv cdecl ALIAS "alcGetIntegerv" (BYVAL device as ALCdevice ptr, byval param as ALCenum, byval size as ALCsizei, byval dat as ALCint ptr)

   declare function alcOpenDevice cdecl ALIAS "alcOpenDevice" (byval deviceName as ALCubyte ptr) as ALCdevice ptr
   declare sub alcCloseDevice cdecl ALIAS "alcCloseDevice" (byval device as ALCdevice ptr)
   
   ' Context Functions
   declare function alcCreateContext cdecl ALIAS "alcCreateContext" (byval device as ALCdevice ptr, byval attrList as ALCint ptr) as ALCcontext ptr
   declare function alcMakeContextCurrent cdecl ALIAS "alcMakeContextCurrent" (byval context as ALCcontext ptr) as ALCboolean
   declare sub alcProcessContext cdecl ALIAS "alcProcessContext" (byval context as ALCcontext ptr)
   declare function alcGetCurrentContext cdecl ALIAS "alcGetCurrentContext" () as ALCcontext ptr
   declare function alcGetContextsDevice cdecl ALIAS "alcGetContextsDevice" (byval context as ALCcontext ptr) as ALCdevice ptr
   declare sub alcSuspendContext cdecl ALIAS "alcSuspendContext" (byval context as ALCcontext ptr)
   declare sub alcDestroyContext cdecl ALIAS "alcDestroyContext" (byval context as ALCcontext ptr)
   
   ' Error Functions
   declare function alcGetError cdecl ALIAS "alcGetError" (byval device as ALCdevice ptr) as ALCenum
   
   ' Driver Extension Functions
   declare function alcIsExtensionPresent cdecl ALIAS "alcIsExtensionPresent" (byval device as ALCdevice ptr, byval extName as ALCubyte ptr) as ALCboolean
   declare function alcGetProcAddress cdecl ALIAS "alcGetProcAddress" (byval device as ALCdevice ptr, byval funcName as ALCubyte ptr) as any ptr
   declare function alcGetEnumValue cdecl ALIAS "alcGetEnumValue" (byval device as ALCdevice ptr, byval enumName as ALCubyte ptr) as ALCenum
   
   
#else       ' ndef ALC_NO_PROTOTYPES


   ' Device Functions
   type alcGetString as function cdecl (byval device as ALCdevice ptr, byval param as ALCenum)
   type alcGetIntegerv as sub cdecl (BYVAL device as ALCdevice ptr, byval param as ALCenum, byval size as ALCsizei, byval dat as ALCint ptr)

   type alcOpenDevice as function cdecl (byval deviceName as ALCubyte ptr)
   type alcCloseDevice as sub cdecl (byval device as ALCdevice ptr)
   
   ' Context Functions
   type alcCreateContext as function cdecl (byval device as ALCdevice ptr, byval attrList as ALCint ptr)
   type alcMakeContextCurrent as function cdecl (byval context as ALCcontext ptr)
   type alcProcessContext as sub cdecl (byval context as ALCcontext ptr)
   type alcGetCurrentContext as function cdecl ()
   type alcGetContextsDevice as function cdecl (byval context as ALCcontext ptr)
   type alcSuspendContext as sub cdecl (byval context as ALCcontext ptr)
   type alcDestroyContext as sub cdecl (byval context as ALCcontext ptr)
   
   ' Error Functions
   type alcGetError as function cdecl (byval device as ALCdevice ptr)
   
   ' Driver Extension Functions
   type alcIsExtensionPresent as function cdecl (byval device as ALCdevice ptr, byval extName as ALCubyte ptr)
   type alcGetProcAddress as function cdecl (byval device as ALCdevice ptr, byval funcName as ALCubyte ptr)
   type alcGetEnumValue as function cdecl (byval device as ALCdevice ptr, byval enumName as ALCubyte ptr)


#endif      ' ndef ALC_NO_PROTOTYPES


#endif      ' ndef ALC_BI
