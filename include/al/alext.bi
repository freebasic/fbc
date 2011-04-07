''
''
'' alext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __alext_bi__
#define __alext_bi__
 
#define AL_FORMAT_IMA_ADPCM_MONO16_EXT &h10000
#define AL_FORMAT_IMA_ADPCM_STEREO16_EXT &h10001
#define AL_FORMAT_WAVE_EXT &h10002
#define AL_FORMAT_VORBIS_EXT &h10003
#define AL_FORMAT_QUAD8_LOKI &h10004
#define AL_FORMAT_QUAD16_LOKI &h10005
#define AL_GAIN_LINEAR_LOKI &h20000
 
type WaveFMT
	encoding as ALushort
	channels as ALushort
	frequency as ALuint
	byterate as ALuint
	blockalign as ALushort
	bitspersample as ALushort
end type
 
type alWaveFMT_LOKI as WaveFMT
 
type _MS_ADPCM_decodestate
	hPredictor as ALubyte
	iDelta as ALushort
	iSamp1 as ALshort
	iSamp2 as ALshort
end type
 
type alMSADPCM_decodestate_LOKI as _MS_ADPCM_decodestate
 
type MS_ADPCM_decoder
	wavefmt as alWaveFMT_LOKI
	wSamplesPerBlock as ALushort
	wNumCoef as ALushort
	aCoeff(0 to 7-1, 0 to 2-1) as ALshort ptr
	state(0 to 2-1) as alMSADPCM_decodestate_LOKI
end type
 
type alMSADPCM_state_LOKI as MS_ADPCM_decoder
 
type IMA_ADPCM_decodestate_s
	valprev as ALint
	index as ALbyte
end type
 
type alIMAADPCM_decodestate_LOKI as IMA_ADPCM_decodestate_s
 
type IMA_ADPCM_decoder
	wavefmt as alWaveFMT_LOKI
	wSamplesPerBlock as ALushort
	state(0 to 2-1) as alIMAADPCM_decodestate_LOKI
end type
 
type alIMAADPCM_state_LOKI as IMA_ADPCM_decoder
 
#define ALC_SOURCES_LOKI &h200000
#define ALC_BUFFERS_LOKI &h200001
#define ALC_CHAN_MAIN_LOKI &h300000
#define ALC_CHAN_PCM_LOKI &h300001
#define ALC_CHAN_CD_LOKI &h300002
 
declare function alcGetAudioChannel_LOKI cdecl alias "alcGetAudioChannel_LOKI" (byval channel as ALuint) as ALfloat
declare sub alcSetAudioChannel_LOKI cdecl alias "alcSetAudioChannel_LOKI" (byval channel as ALuint, byval volume as ALfloat)
declare sub alBombOnError_LOKI cdecl alias "alBombOnError_LOKI" ()
declare sub alBufferi_LOKI cdecl alias "alBufferi_LOKI" (byval bid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alBufferDataWithCallback_LOKI cdecl alias "alBufferDataWithCallback_LOKI" (byval bid as ALuint, byval Callback as function cdecl(byval as ALuint, byval as ALuint, byval as ALshort ptr, byval as ALenum, byval as ALint, byval as ALint) as integer)
declare sub alBufferWriteData_LOKI cdecl alias "alBufferWriteData_LOKI" (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei, byval internalFormat as ALenum)
declare sub alGenStreamingBuffers_LOKI cdecl alias "alGenStreamingBuffers_LOKI" (byval n as ALsizei, byval samples as ALuint ptr)
declare function alBufferAppendData_LOKI cdecl alias "alBufferAppendData_LOKI" (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei) as ALsizei
declare function alBufferAppendWriteData_LOKI cdecl alias "alBufferAppendWriteData_LOKI" (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei, byval internalFormat as ALenum) as ALsizei
declare function alBufferAppendData cdecl alias "alBufferAppendData" (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei) as ALsizei
declare sub alReverbScale_LOKI cdecl alias "alReverbScale_LOKI" (byval sid as ALuint, byval param as ALfloat)
declare sub alReverbDelay_LOKI cdecl alias "alReverbDelay_LOKI" (byval sid as ALuint, byval param as ALfloat)
declare function alCaptureInit_EXT cdecl alias "alCaptureInit_EXT" (byval format as ALenum, byval rate as ALuint, byval bufferSize as ALsizei) as ALboolean
declare function alCaptureDestroy_EXT cdecl alias "alCaptureDestroy_EXT" () as ALboolean
declare function alCaptureStart_EXT cdecl alias "alCaptureStart_EXT" () as ALboolean
declare function alCaptureStop_EXT cdecl alias "alCaptureStop_EXT" () as ALboolean
declare function alCaptureGetData_EXT cdecl alias "alCaptureGetData_EXT" (byval data as ALvoid ptr, byval n as ALsizei, byval format as ALenum, byval rate as ALuint) as ALsizei
declare function alutLoadVorbis_LOKI cdecl alias "alutLoadVorbis_LOKI" (byval bid as ALuint, byval data as ALvoid ptr, byval size as ALint) as ALboolean
declare function alutLoadMP3_LOKI cdecl alias "alutLoadMP3_LOKI" (byval bid as ALuint, byval data as ALvoid ptr, byval size as ALint) as ALboolean
 
type PFNALCGETAUDIOCHANNELPROC as function cdecl(byval as ALuint) as ALfloat
type PFNALCSETAUDIOCHANNELPROC as sub cdecl(byval as ALuint, byval as ALfloat)
type PFNALBOMBONERRORPROC as sub cdecl()
type PFNALBUFFERIPROC as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint)
type PFNALBUFFERDATAWITHCALLBACKPROC as sub cdecl(byval as ALuint, byval as function cdecl(byval as ALuint, byval as ALuint, byval as ALshort ptr, byval as ALenum, byval as ALint, byval as ALint) as integer)
type PFNALBUFFERWRITEDATAPROC as sub cdecl(byval as ALuint, byval as ALenum, byval as ALvoid ptr, byval as ALsizei, byval as ALsizei, byval as ALenum)
type PFNALGENSTREAMINGBUFFERSPROC as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type PFNALBUFFERAPPENDDATAPROC as function cdecl(byval as ALuint, byval as ALenum, byval as ALvoid ptr, byval as ALsizei, byval as ALsizei) as ALsizei
type PFNALBUFFERAPPENDWRITEDATAPROC as function cdecl(byval as ALuint, byval as ALenum, byval as ALvoid ptr, byval as ALsizei, byval as ALsizei, byval as ALenum) as ALsizei
type PFNALCAPTUREINITPROC as function cdecl(byval as ALenum, byval as ALuint, byval as ALsizei) as ALboolean
type PFNALCAPTUREDESTROYPROC as function cdecl() as ALboolean
type PFNALCAPTURESTARTPROC as function cdecl() as ALboolean
type PFNALCAPTURESTOPPROC as function cdecl() as ALboolean
type PFNALCAPTUREGETDATAPROC as function cdecl(byval as ALvoid ptr, byval as ALsizei, byval as ALenum, byval as ALuint) as ALsizei
type PFNALUTLOADVORBISPROC as function cdecl(byval as ALuint, byval as ALvoid ptr, byval as ALint) as ALboolean
type PFNALUTLOADRAW_ADPCMDATAPROC as function cdecl(byval as ALuint, byval as ALvoid ptr, byval as ALuint, byval as ALuint, byval as ALenum) as ALboolean
type ALUTLOADIMA_ADPCMDATAPROC as function cdecl(byval as ALuint, byval as ALvoid ptr, byval as ALuint, byval as alIMAADPCM_state_LOKI ptr) as ALboolean
type ALUTLOADMS_ADPCMDATAPROC as function cdecl(byval as ALuint, byval as any ptr, byval as integer, byval as alMSADPCM_state_LOKI ptr) as ALboolean
type PFNALREVERBSCALEPROC as sub cdecl(byval as ALuint, byval as ALfloat)
type PFNALREVERBDELAYPROC as sub cdecl(byval as ALuint, byval as ALfloat)
 
#endif