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

#ifdef FB__WIN32
'$INCLIB: 'OpenAL32'
#elseif defined(FB__LINUX)
'$INCLIB: 'openal'
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
   dim alEnable as sub (byval capability as ALenum)
   dim alDisable as sub (byval capability as ALenum)
   dim alIsEnabled as function (byval capability as ALenum)
   
   ' Application Preferences for Driver Performance Choices
   dim alHint as sub (target as ALenum, mode as ALenum)
   
   ' State Retrieval
   dim alGetBoolean as function (byval param as ALenum)
   dim alGetInteger as function (byval param as ALenum)
   dim alGetFloat as function (byval param as ALenum)
   dim alGetDouble as function (byval param as ALenum)
   dim alGetBooleanv as sub (byval param as ALenum, byval dst as ALboolean ptr)
   dim alGetIntegerv as sub (byval param as ALenum, byval dst as ALint ptr)
   dim alGetFloatv as sub (byval param as ALenum, byval dst as ALfloat ptr)
   dim alGetDoublev as sub (byval param as ALenum, byval dst as ALfloat ptr)
   dim alGetString as function (byval param as ALenum)
   
   ' Error Support
   dim alGetError as function ()
   
   ' Extension Support
   dim alIsExtensionPresent as function (byval fname as ALubyte ptr)
   dim alGetProcAddress as function (byval fname as ALubyte ptr)
   dim alGetEnumValue as function (byval ename as ALubyte ptr)
   
   
   ' Listener Functions
   dim alListeneri as sub (byval param as ALenum, byval value as ALint)
   dim alListenerf as sub (byval param as ALenum, byval value as ALfloat)
   dim alListener3f as sub (byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   dim alListenerfv as sub (byval param as ALenum, byval values as ALfloat ptr)
   
   dim alGetListeneri as sub (byval param as ALenum, byval value as ALint ptr)
   dim alGetListenerf as sub (byval param as ALenum, byval value as ALfloat ptr)
   dim alGetListener3f as sub (byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   dim alGetListenerfv as sub (byval param as ALenum, byval values as ALfloat ptr)
   
   
   ' Source Functions
   dim alGenSources as sub (byval n as ALsizei, byval sources as ALuint ptr)
   dim alDeleteSources as sub (byval n as ALsizei, byval source as ALuint ptr)
   
   dim alIsSource as function (byval id as ALuint)
   
   dim alSourcei as sub (byval source as ALuint, byval param as ALenum, byval value as ALint)
   dim alSourcef as sub (byval source as ALuint, byval param as ALenum, byval value as ALfloat)
   dim alSource3f as sub (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat, byval v2 as ALfloat, byval v3 as ALfloat)
   dim alSourcefv as sub (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   dim alGetSourcei as sub (byval source as ALuint, byval param as ALenum, byval value as ALint ptr)
   dim alGetSourcef as sub (byval source as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   dim alGetSource3f as sub (byval source as ALuint, byval param as ALenum, byval v1 as ALfloat ptr, byval v2 as ALfloat ptr, byval v3 as ALfloat ptr)
   dim alGetSourcefv as sub (byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
   
   dim alSourcePlayv as sub (byval n as ALsizei, byval sources as ALuint ptr)
   dim alSourcePausev as sub (byval n as ALsizei, byval sources as ALuint ptr)
   dim alSourceStopv as sub (byval n as ALsizei, byval sources as ALuint ptr)
   dim alSourceRewindv as sub (byval n as ALsizei, byval sources as ALuint ptr)
   
   dim alSourcePlay as sub (byval source as ALuint)
   dim alSourcePause as sub (byval source as ALuint)
   dim alSourceStop as sub (byval source as ALuint)
   dim alSourceRewind as sub (byval source as ALuint)
   
   
   ' Buffer Functions
   dim alGenBuffers as sub (byval n as ALsizei, byval buffers as ALuint ptr)
   dim alDeleteBuffers as sub (byval n as ALsizei, byval buffers as ALuint ptr)
   dim alIsBuffer as function (byval buffer as ALuint)
   
   dim alBufferData as sub (byval buffer as ALuint, byval format as ALenum, byval dat as any ptr, byval size as ALsizei, byval freq as ALsizei)
   
   dim alGetBufferi as sub (byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
   dim alGetBufferf as sub (byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
   
   
   ' Queue Functions
   dim alSourceQueueBuffers as sub (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   dim alSourceUnqueueBuffers as sub (byval source as ALuint, byval n as ALsizei, byval buffers as ALuint ptr)
   
   
   ' Tweaker Functions
   dim alDistanceModel as sub (byval value as ALenum)
   dim alDopplerFactor as sub (byval value as ALfloat)
   dim alDopplerVelocity as sub (byval value as ALfloat)
   

#endif      ' ndef AL_NO_PROTOTYPES

#endif      ' ndef AL_BI
