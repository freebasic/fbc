#include once "AL/al.bi"
#inclib "alut"

#ifndef __alut_bi__
#define __alut_bi__

#define ALUT_API_MAJOR_VERSION 1
#define ALUT_API_MINOR_VERSION 1
#define ALUT_ERROR_NO_ERROR 0
#define ALUT_ERROR_OUT_OF_MEMORY &h200
#define ALUT_ERROR_INVALID_ENUM &h201
#define ALUT_ERROR_INVALID_VALUE &h202
#define ALUT_ERROR_INVALID_OPERATION &h203
#define ALUT_ERROR_NO_CURRENT_CONTEXT &h204
#define ALUT_ERROR_AL_ERROR_ON_ENTRY &h205
#define ALUT_ERROR_ALC_ERROR_ON_ENTRY &h206
#define ALUT_ERROR_OPEN_DEVICE &h207
#define ALUT_ERROR_CLOSE_DEVICE &h208
#define ALUT_ERROR_CREATE_CONTEXT &h209
#define ALUT_ERROR_MAKE_CONTEXT_CURRENT &h20A
#define ALUT_ERROR_DESTROY_CONTEXT &h20B
#define ALUT_ERROR_GEN_BUFFERS &h20C
#define ALUT_ERROR_BUFFER_DATA &h20D
#define ALUT_ERROR_IO_ERROR &h20E
#define ALUT_ERROR_UNSUPPORTED_FILE_TYPE &h20F
#define ALUT_ERROR_UNSUPPORTED_FILE_SUBTYPE &h210
#define ALUT_ERROR_CORRUPT_OR_TRUNCATED_DATA &h211
#define ALUT_WAVEFORM_SINE &h100
#define ALUT_WAVEFORM_SQUARE &h101
#define ALUT_WAVEFORM_SAWTOOTH &h102
#define ALUT_WAVEFORM_WHITENOISE &h103
#define ALUT_WAVEFORM_IMPULSE &h104
#define ALUT_LOADER_BUFFER &h300
#define ALUT_LOADER_MEMORY &h301

extern "C"

declare function alutInit (byval argcp as integer ptr, byval argv as byte ptr ptr) as ALboolean
declare function alutInitWithoutContext (byval argcp as integer ptr, byval argv as byte ptr ptr) as ALboolean
declare function alutExit () as ALboolean
declare function alutGetError () as ALenum
declare function alutGetErrorString (byval error as ALenum) as zstring ptr
declare function alutCreateBufferFromFile (byval fileName as zstring ptr) as ALuint
declare function alutCreateBufferFromFileImage (byval data as ALvoid ptr, byval length as ALsizei) as ALuint
declare function alutCreateBufferHelloWorld () as ALuint
declare function alutCreateBufferWaveform (byval waveshape as ALenum, byval frequency as ALfloat, byval phase as ALfloat, byval duration as ALfloat) as ALuint
declare function alutLoadMemoryFromFile (byval fileName as zstring ptr, byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as ALvoid ptr
declare function alutLoadMemoryFromFileImage (byval data as ALvoid ptr, byval length as ALsizei, byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as ALvoid ptr
declare function alutLoadMemoryHelloWorld (byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as ALvoid ptr
declare function alutLoadMemoryWaveform (byval waveshape as ALenum, byval frequency as ALfloat, byval phase as ALfloat, byval duration as ALfloat, byval format as ALenum ptr, byval size as ALsizei ptr, byval freq as ALfloat ptr) as ALvoid ptr
declare function alutGetMIMETypes (byval loader as ALenum) as zstring ptr
declare function alutGetMajorVersion () as ALint
declare function alutGetMinorVersion () as ALint
declare function alutSleep (byval duration as ALfloat) as ALboolean

end extern

#endif
