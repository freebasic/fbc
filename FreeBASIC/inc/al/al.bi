' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

'$INCLUDE: 'al/altypes.bi'

#ifndef AL_BI
#define AL_BI

#define OPENAL

#ifdef __FB_WIN32__
'$INCLIB: 'OpenAL32'
#elseif defined(__FB_LINUX__)
'$INCLIB: 'openal'
#else
#error Platform not supported
#endif

#ifndef AL_NO_PROTOTYPES

   ' State Management
   declare sub alEnable cdecl ALIAS "alEnable" (byval capability as ALenum)
   declare sub alDisable cdecl ALIAS "alDisable" (byval capability as ALenum)
   declare function alIsEnabled cdecl ALIAS "alIsEnabled" (byval capability as ALenum) as ALboolean
   
   ' Application Preferences for Driver Performance Choices
   declare sub alHint cdecl ALIAS "alHint" (target as ALenum, mode as ALenum)
   
   ' State Retrieval
   declare function alGetBoolean cdecl ALIAS "alGetBoolean" (byval param as ALenum) as ALboolean
   declare function alGetInteger cdecl ALIAS "alGetInteger" (byval param as ALenum) As ALint
   declare function alGetFloat cdecl ALIAS "alGetFloat" (byval param as ALenum) as ALfloat
   declare function alGetDouble cdecl ALIAS "alGetDouble" (byval param as ALenum) as ALdouble
   declare sub alGetBooleanv cdecl ALIAS "alGetBooleanv" (byval param as ALenum, byval dst as ALboolean ptr)
   declare sub alGetIntegerv cdecl ALIAS "alGetIntegerv" (byval param as ALenum, byval dst as ALint ptr)
   declare sub alGetFloatv cdecl ALIAS "alGetFloatv" (byval param as ALenum, byval dst as ALfloat ptr)
   declare sub alGetDoublev cdecl ALIAS "alGetDoublev" (byval param as ALenum, byval dst as ALfloat ptr)
   declare function alGetString cdecl ALIAS "alGetString" (byval param as ALenum) as ALubyte ptr
   
   ' Error Support
   declare function alGetError cdecl ALIAS "alGetError" () as ALenum
   
   ' Extension Support
   declare function alIsExtensionPresent cdecl ALIAS "alIsExtensionPresent" (byval fname as ALubyte ptr) as ALboolean
   declare function alGetProcAddress cdecl ALIAS "alGetProcAddress" (byval fname as ALubyte ptr) as any ptr
   declare function alGetEnumValue cdecl ALIAS "alGetEnumValue" (byval ename as ALubyte ptr) as ALenum
   
   
   ' Listener Functions
   declare sub alListeneri cdecl ALIAS "alListeneri" (byval param as ALenum, byval value as ALint)
   declare sub alListenerf cdecl ALIAS "alListenerf" (byval param as ALenum, byval value as ALfloat)
   declare sub alListener3f cdecl ALIAS "alListener3f" (byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   declare sub alListenerfv cdecl ALIAS "alListenerfv" (byval param as ALenum, byval values as ALfloat ptr)
   
   declare sub alGetListeneri cdecl ALIAS "alGetListeneri" (byval param as ALenum, byval value as ALint ptr)
   declare sub alGetListenerf cdecl ALIAS "alGetListenerf" (byval param as ALenum, byval value as ALfloat ptr)
   declare sub alGetListener3f cdecl ALIAS "alGetListener3f" (byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   declare sub alGetListenerfv cdecl ALIAS "alGetListenerfv" (byval param as ALenum, byval values as ALfloat ptr)
   
   
   ' Source Functions
   declare sub alGenSources cdecl ALIAS "alGenSources" (byval n as ALsizei, byval sources as ALuint ptr)
   declare sub alDeleteSources cdecl ALIAS "alDeleteSources" (byval n as ALsizei, byval source as ALuint ptr)
   
   declare function alIsSource cdecl ALIAS "alIsSource" (byval id as ALuint) as ALboolean
   
   declare sub alSourcei cdecl ALIAS "alSourcei" (byval source as ALuint, byval param as ALenum, byval value as ALint)
   declare sub alSourcef cdecl ALIAS "alSourcef" (byval source as ALuint, byval param as ALenum, byval value as ALfloat)
   declare sub alSource3f cdecl ALIAS "alSource3f" (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   declare sub alSourcefv cdecl ALIAS "alSourcefv" (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   declare sub alGetSourcei cdecl ALIAS "alGetSourcei" (byval source as ALuint, byval param as ALenum, byval value as ALint ptr)
   declare sub alGetSourcef cdecl ALIAS "alGetSourcef" (byval source as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   declare sub alGetSource3f cdecl ALIAS "alGetSource3f" (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   declare sub alGetSourcefv cdecl ALIAS "alGetSourcefb" (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   declare sub alSourcePlayv cdecl ALIAS "alSourcePlayv" (byval n as ALsizei, byval sources as ALuint ptr)
   declare sub alSourcePausev cdecl ALIAS "alSourcePausev" (byval n as ALsizei, byval sources as ALuint ptr)
   declare sub alSourceStopv cdecl ALIAS "alSourceStopv" (byval n as ALsizei, byval sources as ALuint ptr)
   declare sub alSourceRewindv cdecl ALIAS "alSourceRewindv" (byval n as ALsizei, byval sources as ALuint ptr)
   
   declare sub alSourcePlay cdecl ALIAS "alSourcePlay" (byval source as ALuint)
   declare sub alSourcePause cdecl ALIAS "alSourcePause" (byval source as ALuint)
   declare sub alSourceStop cdecl ALIAS "alSourceStop" (byval source as ALuint)
   declare sub alSourceRewind cdecl ALIAS "alSourceRewind" (byval source as ALuint)
   
   
   ' Buffer Functions
   declare sub alGenBuffers cdecl ALIAS "alGenBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
   declare sub alDeleteBuffers cdecl ALIAS "alDeleteBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
   declare function alIsBuffer cdecl ALIAS "alIsBuffer" (byval buffer as ALuint) as ALboolean
   
   declare sub alBufferData cdecl ALIAS "alBufferData" (byval buffer as ALuint, byval format as ALenum, byval dat as any ptr, byval size as ALsizei, byval freq as ALsizei)
   
   declare sub alGetBufferi cdecl ALIAS "alGetBufferi" (byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
   declare sub alGetBufferf cdecl ALIAS "alGetBufferf" (byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   
   
   ' Queue Functions
   declare sub alSourceQueueBuffers cdecl ALIAS "alSourceQueueBuffers" (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   declare sub alSourceUnqueueBuffers cdecl ALIAS "alSourceUnqueueBuffers" (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   
   
   ' Tweaker Functions
   declare sub alDistanceModel cdecl ALIAS "alDistanceModel" (byval value as ALenum)
   declare sub alDopplerFactor cdecl ALIAS "alDopplerFactor" (byval value as ALfloat)
   declare sub alDopplerVelocity cdecl ALIAS "alDopplerVelocity" (byval value as ALfloat)
   
   
#else       ' ndef AL_NO_PROTOTYPES


   ' State Management
   type alEnable as sub cdecl (byval capability as ALenum)
   type alDisable as sub cdecl (byval capability as ALenum)
   type alIsEnabled as function cdecl (byval capability as ALenum)
   
   ' Application Preferences for Driver Performance Choices
   type alHint as sub cdecl (target as ALenum, mode as ALenum)
   
   ' State Retrieval
   type alGetBoolean as function cdecl (byval param as ALenum)
   type alGetInteger as function cdecl (byval param as ALenum)
   type alGetFloat as function cdecl (byval param as ALenum)
   type alGetDouble as function cdecl (byval param as ALenum)
   type alGetBooleanv as sub cdecl (byval param as ALenum, byval dst as ALboolean ptr)
   type alGetIntegerv as sub cdecl (byval param as ALenum, byval dst as ALint ptr)
   type alGetFloatv as sub cdecl (byval param as ALenum, byval dst as ALfloat ptr)
   type alGetDoublev as sub cdecl (byval param as ALenum, byval dst as ALfloat ptr)
   type alGetString as function cdecl (byval param as ALenum)
   
   ' Error Support
   type alGetError as function cdecl ()
   
   ' Extension Support
   type alIsExtensionPresent as function cdecl (byval fname as ALubyte ptr)
   type alGetProcAddress as function cdecl (byval fname as ALubyte ptr)
   type alGetEnumValue as function cdecl (byval ename as ALubyte ptr)
   
   
   ' Listener Functions
   type alListeneri as sub cdecl (byval param as ALenum, byval value as ALint)
   type alListenerf as sub cdecl (byval param as ALenum, byval value as ALfloat)
   type alListener3f as sub cdecl (byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   type alListenerfv as sub cdecl (byval param as ALenum, byval values as ALfloat ptr)
   
   type alGetListeneri as sub cdecl (byval param as ALenum, byval value as ALint ptr)
   type alGetListenerf as sub cdecl (byval param as ALenum, byval value as ALfloat ptr)
   type alGetListener3f as sub cdecl (byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   type alGetListenerfv as sub cdecl (byval param as ALenum, byval values as ALfloat ptr)
   
   
   ' Source Functions
   type alGenSources as sub cdecl (byval n as ALsizei, byval sources as ALuint ptr)
   type alDeleteSources as sub cdecl (byval n as ALsizei, byval source as ALuint ptr)
   
   type alIsSource as function cdecl (byval id as ALuint)
   
   type alSourcei as sub cdecl (byval source as ALuint, byval param as ALenum, byval value as ALint)
   type alSourcef as sub cdecl (byval source as ALuint, byval param as ALenum, byval value as ALfloat)
   type alSource3f as sub cdecl (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   type alSourcefv as sub cdecl (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   type alGetSourcei as sub cdecl (byval source as ALuint, byval param as ALenum, byval value as ALint ptr)
   type alGetSourcef as sub cdecl (byval source as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   type alGetSource3f as sub cdecl (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   type alGetSourcefv as sub cdecl (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   type alSourcePlayv as sub cdecl (byval n as ALsizei, byval sources as ALuint ptr)
   type alSourcePausev as sub cdecl (byval n as ALsizei, byval sources as ALuint ptr)
   type alSourceStopv as sub cdecl (byval n as ALsizei, byval sources as ALuint ptr)
   type alSourceRewindv as sub cdecl (byval n as ALsizei, byval sources as ALuint ptr)
   
   type alSourcePlay as sub cdecl (byval source as ALuint)
   type alSourcePause as sub cdecl (byval source as ALuint)
   type alSourceStop as sub cdecl (byval source as ALuint)
   type alSourceRewind as sub cdecl (byval source as ALuint)
   
   
   ' Buffer Functions
   type alGenBuffers as sub cdecl (byval n as ALsizei, byval buffers as ALuint ptr)
   type alDeleteBuffers as sub cdecl (byval n as ALsizei, byval buffers as ALuint ptr)
   type alIsBuffer as function cdecl (byval buffer as ALuint)
   
   type alBufferData as sub cdecl (byval buffer as ALuint, byval format as ALenum, byval dat as any ptr, byval size as ALsizei, byval freq as ALsizei)
   
   type alGetBufferi as sub cdecl (byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
   type alGetBufferf as sub cdecl (byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   
   
   ' Queue Functions
   type alSourceQueueBuffers as sub cdecl (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   type alSourceUnqueueBuffers as sub cdecl (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   
   
   ' Tweaker Functions
   type alDistanceModel as sub cdecl (byval value as ALenum)
   type alDopplerFactor as sub cdecl (byval value as ALfloat)
   type alDopplerVelocity as sub cdecl (byval value as ALfloat)
   

#endif      ' ndef AL_NO_PROTOTYPES

#endif      ' ndef AL_BI
