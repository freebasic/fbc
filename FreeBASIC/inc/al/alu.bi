' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

#ifndef ALU_BI
#define ALU_BI


const BUFFERSIZE        = 48000
const FRACTIONBITS      = 14
CONST FRACTIONMASK      = ((1 SHL FRACTIONBITS) - 1)
const OUTPUTCHANNELS    = 2

'$INCLUDE: 'al/altypes.bi'
#ifdef __FB_WIN32__
'$INCLIB: 'OpenAL32'
'$INCLIB: 'ALut'
#elseif defined(__FB_LINUX__)
'$INCLIB: 'openal'
#else
#error Platform not supported
#endif


' Type Conversion Functions
declare function aluF2L CDECL ALIAS "aluF2L" (byval value as ALfloat) as ALint
declare function aluF2S CDECL ALIAS "aluF2S" (byval value as ALfloat) as ALshort

' Vector Functions
declare sub aluCrossProduct CDECL ALIAS "aluCrossProduct" (byval inVector1 as ALfloat ptr, byval inVector2 as ALfloat ptr, byval outVector as ALfloat ptr)
declare function aluDotProduct CDECL ALIAS "aluDotProduct" (byval inVector1 as ALfloat ptr, byval inVector2 as ALfloat ptr)
declare sub aluNormalise CDECL ALIAS "aluNormalise" (byval inVector as ALfloat ptr)
declare sub aluMatrixVector CDECL ALIAS "aluMatrixVector" (byval matrix as ALfloat ptr ptr, byval vector as ALfloat ptr)
declare sub aluCalculateSourceParameters CDECL ALIAS "aluCalculateSourceParameters" (byval source as ALuint, byval channels as ALuint, byval drysend as ALfloat ptr, byval wetsend as ALfloat ptr, byval pitch as ALfloat ptr)
declare sub aluMixData CDECL ALIAS "aluMixData" (byval context as any ptr, byval buffer as any ptr, byval size as ALsizei, byval format as ALenum)
declare sub aluSetReverb CDECL ALIAS "aluSetReverb" (byval Reverb as any ptr, byval Environment as ALuint)
declare sub aluReverb CDECL ALIAS "aluReverb" (byval Reverb as any ptr, byval Buffer as ALfloat ptr ptr, byval BufferSize as ALsizei)


#endif      ' ndef ALU_BI
