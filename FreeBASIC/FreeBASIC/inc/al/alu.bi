''
''
'' alu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __al_alu_bi__
#define __al_alu_bi__

#ifdef __FB_WIN32__
# inclib "OpenAL32"
#elseif defined(__FB_LINUX__)
# inclib "openal"
#else
# error Platform not supported
#endif

#define BUFFERSIZE 48000
#define FRACTIONBITS 14
#define FRACTIONMASK ((1L shl 14) -1)
#define OUTPUTCHANNELS 2

#include once "altypes.bi"

declare function aluF2L (byval value as ALfloat) as ALint
declare function aluF2S (byval value as ALfloat) as ALshort
declare sub aluCrossproduct (byval inVector1 as ALfloat ptr, byval inVector2 as ALfloat ptr, byval outVector as ALfloat ptr)
declare function aluDotproduct (byval inVector1 as ALfloat ptr, byval inVector2 as ALfloat ptr) as ALfloat
declare sub aluNormalize (byval inVector as ALfloat ptr)
declare sub aluMatrixVector (byval vector as ALfloat ptr, byval matrix as ALfloat ptr ptr ptr)
declare sub aluCalculateSourceParameters (byval source as ALuint, byval channels as ALuint, byval drysend as ALfloat ptr, byval wetsend as ALfloat ptr, byval pitch as ALfloat ptr)
declare sub aluMixData (byval context as ALvoid ptr, byval buffer as ALvoid ptr, byval size as ALsizei, byval format as ALenum)

#endif
