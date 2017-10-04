'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "uuid"
#inclib "dxguid"

extern "C"

extern MEDIATYPE_NULL alias "GUID_NULL" as const IID
extern MEDIASUBTYPE_NULL alias "GUID_NULL" as const IID
extern MEDIASUBTYPE_None as const GUID
extern MEDIATYPE_Video as const GUID
extern MEDIATYPE_Audio as const GUID
extern MEDIATYPE_Text as const GUID
extern MEDIATYPE_Midi as const GUID
extern MEDIATYPE_Stream as const GUID
extern MEDIATYPE_Interleaved as const GUID
extern MEDIATYPE_File as const GUID
extern MEDIATYPE_ScriptCommand as const GUID
extern MEDIATYPE_AUXLine21Data as const GUID
extern MEDIATYPE_VBI as const GUID
extern MEDIATYPE_Timecode as const GUID
extern MEDIATYPE_LMRT as const GUID
extern MEDIATYPE_URL_STREAM as const GUID
extern MEDIASUBTYPE_CLPL as const GUID
extern MEDIASUBTYPE_YUYV as const GUID
extern MEDIASUBTYPE_IYUV as const GUID
extern MEDIASUBTYPE_YVU9 as const GUID
extern MEDIASUBTYPE_Y411 as const GUID
extern MEDIASUBTYPE_Y41P as const GUID
extern MEDIASUBTYPE_YUY2 as const GUID
extern MEDIASUBTYPE_YVYU as const GUID
extern MEDIASUBTYPE_UYVY as const GUID
extern MEDIASUBTYPE_Y211 as const GUID
extern MEDIASUBTYPE_CLJR as const GUID
extern MEDIASUBTYPE_IF09 as const GUID
extern MEDIASUBTYPE_CPLA as const GUID
extern MEDIASUBTYPE_MJPG as const GUID
extern MEDIASUBTYPE_TVMJ as const GUID
extern MEDIASUBTYPE_WAKE as const GUID
extern MEDIASUBTYPE_CFCC as const GUID
extern MEDIASUBTYPE_IJPG as const GUID
extern MEDIASUBTYPE_Plum as const GUID
extern MEDIASUBTYPE_DVCS as const GUID
extern MEDIASUBTYPE_DVSD as const GUID
extern MEDIASUBTYPE_MDVF as const GUID
extern MEDIASUBTYPE_RGB1 as const GUID
extern MEDIASUBTYPE_RGB4 as const GUID
extern MEDIASUBTYPE_RGB8 as const GUID
extern MEDIASUBTYPE_RGB565 as const GUID
extern MEDIASUBTYPE_RGB555 as const GUID
extern MEDIASUBTYPE_RGB24 as const GUID
extern MEDIASUBTYPE_RGB32 as const GUID
extern MEDIASUBTYPE_ARGB1555 as const GUID
extern MEDIASUBTYPE_ARGB4444 as const GUID
extern MEDIASUBTYPE_ARGB32 as const GUID
extern MEDIASUBTYPE_A2R10G10B10 as const GUID
extern MEDIASUBTYPE_A2B10G10R10 as const GUID
extern MEDIASUBTYPE_AYUV as const GUID
extern MEDIASUBTYPE_AI44 as const GUID
extern MEDIASUBTYPE_IA44 as const GUID
extern MEDIASUBTYPE_RGB32_D3D_DX7_RT as const GUID
extern MEDIASUBTYPE_RGB16_D3D_DX7_RT as const GUID
extern MEDIASUBTYPE_ARGB32_D3D_DX7_RT as const GUID
extern MEDIASUBTYPE_ARGB4444_D3D_DX7_RT as const GUID
extern MEDIASUBTYPE_ARGB1555_D3D_DX7_RT as const GUID
extern MEDIASUBTYPE_RGB32_D3D_DX9_RT as const GUID
extern MEDIASUBTYPE_RGB16_D3D_DX9_RT as const GUID
extern MEDIASUBTYPE_ARGB32_D3D_DX9_RT as const GUID
extern MEDIASUBTYPE_ARGB4444_D3D_DX9_RT as const GUID
extern MEDIASUBTYPE_ARGB1555_D3D_DX9_RT as const GUID

#define MEDIASUBTYPE_HASALPHA(mt) (((((((((((((mt).subtype = MEDIASUBTYPE_ARGB4444) orelse ((mt).subtype = MEDIASUBTYPE_ARGB32)) orelse ((mt).subtype = MEDIASUBTYPE_AYUV)) orelse ((mt).subtype = MEDIASUBTYPE_AI44)) orelse ((mt).subtype = MEDIASUBTYPE_IA44)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT))
#define MEDIASUBTYPE_HASALPHA7(mt) ((((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT))
#define MEDIASUBTYPE_D3D_DX7_RT(mt) ((((((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_RGB32_D3D_DX7_RT)) orelse ((mt).subtype = MEDIASUBTYPE_RGB16_D3D_DX7_RT))
#define MEDIASUBTYPE_HASALPHA9(mt) ((((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT))
#define MEDIASUBTYPE_D3D_DX9_RT(mt) ((((((mt).subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT) orelse ((mt).subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_RGB32_D3D_DX9_RT)) orelse ((mt).subtype = MEDIASUBTYPE_RGB16_D3D_DX9_RT))

extern MEDIASUBTYPE_YV12 as const GUID
extern MEDIASUBTYPE_NV12 as const GUID
extern MEDIASUBTYPE_IMC1 as const GUID
extern MEDIASUBTYPE_IMC2 as const GUID
extern MEDIASUBTYPE_IMC3 as const GUID
extern MEDIASUBTYPE_IMC4 as const GUID
extern MEDIASUBTYPE_S340 as const GUID
extern MEDIASUBTYPE_S342 as const GUID
extern MEDIASUBTYPE_Overlay as const GUID
extern MEDIASUBTYPE_MPEG1Packet as const GUID
extern MEDIASUBTYPE_MPEG1Payload as const GUID
extern MEDIASUBTYPE_MPEG1AudioPayload as const GUID
extern MEDIATYPE_MPEG1SystemStream as const GUID
extern MEDIASUBTYPE_MPEG1System as const GUID
extern MEDIASUBTYPE_MPEG1VideoCD as const GUID
extern MEDIASUBTYPE_MPEG1Video as const GUID
extern MEDIASUBTYPE_MPEG1Audio as const GUID
extern MEDIASUBTYPE_Avi as const GUID
extern MEDIASUBTYPE_Asf as const GUID
extern MEDIASUBTYPE_QTMovie as const GUID
extern MEDIASUBTYPE_QTRpza as const GUID
extern MEDIASUBTYPE_QTSmc as const GUID
extern MEDIASUBTYPE_QTRle as const GUID
extern MEDIASUBTYPE_QTJpeg as const GUID
extern MEDIASUBTYPE_PCMAudio_Obsolete as const GUID
extern MEDIASUBTYPE_PCM as const GUID
extern MEDIASUBTYPE_WAVE as const GUID
extern MEDIASUBTYPE_AU as const GUID
extern MEDIASUBTYPE_AIFF as const GUID
extern MEDIASUBTYPE_dvsd as const GUID
extern MEDIASUBTYPE_dvhd as const GUID
extern MEDIASUBTYPE_dvsl as const GUID
extern MEDIASUBTYPE_dv25 as const GUID
extern MEDIASUBTYPE_dv50 as const GUID
extern MEDIASUBTYPE_dvh1 as const GUID
extern MEDIASUBTYPE_Line21_BytePair as const GUID
extern MEDIASUBTYPE_Line21_GOPPacket as const GUID
extern MEDIASUBTYPE_Line21_VBIRawData as const GUID
extern MEDIASUBTYPE_TELETEXT as const GUID
extern MEDIASUBTYPE_WSS as const GUID
extern MEDIASUBTYPE_VPS as const GUID
extern MEDIASUBTYPE_DRM_Audio as const GUID
extern MEDIASUBTYPE_IEEE_FLOAT as const GUID
extern MEDIASUBTYPE_DOLBY_AC3_SPDIF as const GUID
extern MEDIASUBTYPE_RAW_SPORT as const GUID
extern MEDIASUBTYPE_SPDIF_TAG_241h as const GUID
extern MEDIASUBTYPE_DssVideo as const GUID
extern MEDIASUBTYPE_DssAudio as const GUID
extern MEDIASUBTYPE_VPVideo as const GUID
extern MEDIASUBTYPE_VPVBI as const GUID
extern CLSID_CaptureGraphBuilder as const GUID
extern CLSID_CaptureGraphBuilder2 as const GUID
extern CLSID_ProtoFilterGraph as const GUID
extern CLSID_SystemClock as const GUID
extern CLSID_FilterMapper as const GUID
extern CLSID_FilterGraph as const GUID
extern CLSID_FilterGraphNoThread as const GUID
extern CLSID_MPEG1Doc as const GUID
extern CLSID_FileSource as const GUID
extern CLSID_MPEG1PacketPlayer as const GUID
extern CLSID_MPEG1Splitter as const GUID
extern CLSID_CMpegVideoCodec as const GUID
extern CLSID_CMpegAudioCodec as const GUID
extern CLSID_TextRender as const GUID
extern CLSID_InfTee as const GUID
extern CLSID_AviSplitter as const GUID
extern CLSID_AviReader as const GUID
extern CLSID_VfwCapture as const GUID
extern CLSID_CaptureProperties as const GUID
extern CLSID_FGControl as const GUID
extern CLSID_MOVReader as const GUID
extern CLSID_QuickTimeParser as const GUID
extern CLSID_QTDec as const GUID
extern CLSID_AVIDoc as const GUID
extern CLSID_VideoRenderer as const GUID
extern CLSID_Colour as const GUID
extern CLSID_Dither as const GUID
extern CLSID_ModexRenderer as const GUID
extern CLSID_AudioRender as const GUID
extern CLSID_AudioProperties as const GUID
extern CLSID_DSoundRender as const GUID
extern CLSID_AudioRecord as const GUID
extern CLSID_AudioInputMixerProperties as const GUID
extern CLSID_AVIDec as const GUID
extern CLSID_AVIDraw as const GUID
extern CLSID_ACMWrapper as const GUID
extern CLSID_AsyncReader as const GUID
extern CLSID_URLReader as const GUID
extern CLSID_PersistMonikerPID as const GUID
extern CLSID_AVICo as const GUID
extern CLSID_FileWriter as const GUID
extern CLSID_AviDest as const GUID
extern CLSID_AviMuxProptyPage as const GUID
extern CLSID_AviMuxProptyPage1 as const GUID
extern CLSID_AVIMIDIRender as const GUID
extern CLSID_WMAsfReader as const GUID
extern CLSID_WMAsfWriter as const GUID
extern CLSID_MPEG2Demultiplexer as const GUID
extern CLSID_MMSPLITTER as const GUID
extern CLSID_StreamBufferSink as const GUID
extern CLSID_StreamBufferSource as const GUID
extern CLSID_StreamBufferConfig as const GUID
extern CLSID_Mpeg2VideoStreamAnalyzer as const GUID
extern CLSID_StreamBufferRecordingAttributes as const GUID
extern CLSID_StreamBufferComposeRecording as const GUID
extern CLSID_DVVideoCodec as const GUID
extern CLSID_DVVideoEnc as const GUID
extern CLSID_DVSplitter as const GUID
extern CLSID_DVMux as const GUID
extern CLSID_SeekingPassThru as const GUID
extern CLSID_Line21Decoder as const GUID
extern CLSID_Line21Decoder2 as const GUID
extern CLSID_OverlayMixer as const GUID
extern CLSID_VBISurfaces as const GUID
extern CLSID_WSTDecoder as const GUID
extern CLSID_MjpegDec as const GUID
extern CLSID_MJPGEnc as const GUID
extern CLSID_SystemDeviceEnum as const GUID
extern CLSID_CDeviceMoniker as const GUID
extern CLSID_VideoInputDeviceCategory as const GUID
extern CLSID_CVidCapClassManager as const GUID
extern CLSID_LegacyAmFilterCategory as const GUID
extern CLSID_CQzFilterClassManager as const GUID
extern CLSID_VideoCompressorCategory as const GUID
extern CLSID_CIcmCoClassManager as const GUID
extern CLSID_AudioCompressorCategory as const GUID
extern CLSID_CAcmCoClassManager as const GUID
extern CLSID_AudioInputDeviceCategory as const GUID
extern CLSID_CWaveinClassManager as const GUID
extern CLSID_AudioRendererCategory as const GUID
extern CLSID_CWaveOutClassManager as const GUID
extern CLSID_MidiRendererCategory as const GUID
extern CLSID_CMidiOutClassManager as const GUID
extern CLSID_TransmitCategory as const GUID
extern CLSID_DeviceControlCategory as const GUID
extern CLSID_ActiveMovieCategories as const GUID
extern CLSID_DVDHWDecodersCategory as const GUID
extern CLSID_MediaEncoderCategory as const GUID
extern CLSID_MediaMultiplexerCategory as const GUID
extern CLSID_FilterMapper2 as const GUID
extern CLSID_MemoryAllocator as const GUID
extern CLSID_MediaPropertyBag as const GUID
extern CLSID_DvdGraphBuilder as const GUID
extern CLSID_DVDNavigator as const GUID
extern CLSID_DVDState as const GUID
extern CLSID_SmartTee as const GUID
extern FORMAT_None as const GUID
extern FORMAT_VideoInfo as const GUID
extern FORMAT_VideoInfo2 as const GUID
extern FORMAT_WaveFormatEx as const GUID
extern FORMAT_MPEGVideo as const GUID
extern FORMAT_MPEGStreams as const GUID
extern FORMAT_DvInfo as const GUID
extern CLSID_DirectDrawProperties as const GUID
extern CLSID_PerformanceProperties as const GUID
extern CLSID_QualityProperties as const GUID
extern IID_IBaseVideoMixer as const GUID
extern IID_IDirectDrawVideo as const GUID
extern IID_IQualProp as const GUID
extern CLSID_VPObject as const GUID
extern IID_IVPObject as const GUID
extern IID_IVPControl as const GUID
extern CLSID_VPVBIObject as const GUID
extern IID_IVPVBIObject as const GUID
extern IID_IVPConfig as const GUID
extern IID_IVPNotify as const GUID
extern IID_IVPNotify2 as const GUID
extern IID_IVPVBIConfig as const GUID
extern IID_IVPVBINotify as const GUID
extern IID_IMixerPinConfig as const GUID
extern IID_IMixerPinConfig2 as const GUID
extern IID_IDDVideoPortContainer as const GUID
extern IID_IDirectDrawKernel as const GUID
extern IID_IDirectDrawSurfaceKernel as const GUID
extern CLSID_ModexProperties as const GUID
extern IID_IFullScreenVideo as const GUID
extern IID_IFullScreenVideoEx as const GUID
extern CLSID_DVDecPropertiesPage as const GUID
extern CLSID_DVEncPropertiesPage as const GUID
extern CLSID_DVMuxPropertyPage as const GUID
extern IID_IAMDirectSound as const GUID
extern IID_IMpegAudioDecoder as const GUID
extern IID_IAMLine21Decoder as const GUID
extern IID_IAMWstDecoder as const GUID
extern CLSID_WstDecoderPropertyPage as const GUID
extern FORMAT_AnalogVideo as const GUID
extern MEDIATYPE_AnalogVideo as const GUID
extern MEDIASUBTYPE_AnalogVideo_NTSC_M as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_B as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_D as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_G as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_H as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_I as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_M as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_N as const GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_N_COMBO as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_B as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_D as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_G as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_H as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_K as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_K1 as const GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_L as const GUID
extern MEDIATYPE_AnalogAudio as const GUID
extern MEDIATYPE_MPEG2_PACK as const GUID
extern MEDIATYPE_MPEG2_PES as const GUID
extern MEDIASUBTYPE_MPEG2_WMDRM_TRANSPORT as const GUID
extern MEDIASUBTYPE_MPEG2_VIDEO as const GUID
extern FORMAT_MPEG2_VIDEO as const GUID
extern FORMAT_VIDEOINFO2 as const GUID
extern MEDIASUBTYPE_MPEG2_PROGRAM as const GUID
extern MEDIASUBTYPE_MPEG2_TRANSPORT as const GUID
extern MEDIASUBTYPE_MPEG2_AUDIO as const GUID
extern MEDIASUBTYPE_DOLBY_AC3 as const GUID
extern MEDIASUBTYPE_DVD_SUBPICTURE as const GUID
extern MEDIASUBTYPE_DVD_LPCM_AUDIO as const GUID
extern MEDIATYPE_DVD_ENCRYPTED_PACK as const GUID
extern MEDIATYPE_DVD_NAVIGATION as const GUID
extern MEDIASUBTYPE_DVD_NAVIGATION_PCI as const GUID
extern MEDIASUBTYPE_DVD_NAVIGATION_DSI as const GUID
extern MEDIASUBTYPE_DVD_NAVIGATION_PROVIDER as const GUID
extern FORMAT_MPEG2Video as const GUID
extern FORMAT_DolbyAC3 as const GUID
extern FORMAT_MPEG2Audio as const GUID
extern FORMAT_DVD_LPCMAudio as const GUID
extern AM_KSPROPSETID_AC3 as const GUID
extern AM_KSPROPSETID_DvdSubPic as const GUID
extern AM_KSPROPSETID_CopyProt as const GUID
extern AM_KSPROPSETID_TSRateChange as const GUID
extern AM_KSPROPSETID_MPEG4_MediaType_Attributes as const GUID
extern AM_KSCATEGORY_CAPTURE as const GUID
extern AM_KSCATEGORY_RENDER as const GUID
extern AM_KSCATEGORY_DATACOMPRESSOR as const GUID
extern AM_KSCATEGORY_AUDIO as const GUID
extern AM_KSCATEGORY_VIDEO as const GUID
extern AM_KSCATEGORY_TVTUNER as const GUID
extern AM_KSCATEGORY_CROSSBAR as const GUID
extern AM_KSCATEGORY_TVAUDIO as const GUID
extern AM_KSCATEGORY_VBICODEC as const GUID
extern AM_KSCATEGORY_SPLITTER as const GUID
extern IID_IKsInterfaceHandler as const GUID
extern IID_IKsDataTypeHandler as const GUID
extern IID_IKsPin as const GUID
extern IID_IKsControl as const GUID
extern IID_IKsPinFactory as const GUID
extern AM_INTERFACESETID_Standard as const GUID

#if _WIN32_WINNT >= &h0600
	extern MEDIATYPE_MPEG2_SECTIONS as const GUID
	extern MEDIASUBTYPE_MPEG2_VERSIONED_TABLES as const GUID
	extern MEDIASUBTYPE_ATSC_SI as const GUID
	extern MEDIASUBTYPE_DVB_SI as const GUID
	extern MEDIASUBTYPE_ISDB_SI as const GUID
	extern MEDIASUBTYPE_TIF_SI as const GUID
	extern MEDIASUBTYPE_MPEG2DATA as const GUID
#endif

#if _WIN32_WINNT >= &h0501
	extern MEDIASUBTYPE_MPEG2_TRANSPORT_STRIDE as const GUID
	extern MEDIASUBTYPE_MPEG2_UDCR_TRANSPORT as const GUID
	extern MEDIASUBTYPE_MPEG2_PBDA_TRANSPORT_RAW as const GUID
	extern MEDIASUBTYPE_MPEG2_PBDA_TRANSPORT_PROCESSED as const GUID
	extern MEDIASUBTYPE_DTS as const GUID
	extern MEDIASUBTYPE_SDDS as const GUID
	extern AM_KSPROPSETID_DVD_RateChange as const GUID
	extern AM_KSPROPSETID_DvdKaraoke as const GUID
	extern AM_KSPROPSETID_FrameStep as const GUID
#endif

#if _WIN32_WINNT >= &h0600
	extern AM_KSCATEGORY_VBICODEC_MI as const GUID
#endif

extern TIME_FORMAT_NONE as const GUID
extern TIME_FORMAT_FRAME as const GUID
extern TIME_FORMAT_BYTE as const GUID
extern TIME_FORMAT_SAMPLE as const GUID
extern TIME_FORMAT_FIELD as const GUID
extern TIME_FORMAT_MEDIA_TIME as const GUID
extern AMPROPSETID_Pin as const GUID
extern PIN_CATEGORY_CAPTURE as const GUID
extern PIN_CATEGORY_PREVIEW as const GUID
extern PIN_CATEGORY_ANALOGVIDEOIN as const GUID
extern PIN_CATEGORY_VBI as const GUID
extern PIN_CATEGORY_VIDEOPORT as const GUID
extern PIN_CATEGORY_NABTS as const GUID
extern PIN_CATEGORY_EDS as const GUID
extern PIN_CATEGORY_TELETEXT as const GUID
extern PIN_CATEGORY_CC as const GUID
extern PIN_CATEGORY_STILL as const GUID
extern PIN_CATEGORY_TIMECODE as const GUID
extern PIN_CATEGORY_VIDEOPORT_VBI as const GUID
extern LOOK_UPSTREAM_ONLY as const GUID
extern LOOK_DOWNSTREAM_ONLY as const GUID
extern CLSID_TVTunerFilterPropertyPage as const GUID
extern CLSID_CrossbarFilterPropertyPage as const GUID
extern CLSID_TVAudioFilterPropertyPage as const GUID
extern CLSID_VideoProcAmpPropertyPage as const GUID
extern CLSID_CameraControlPropertyPage as const GUID
extern CLSID_AnalogVideoDecoderPropertyPage as const GUID
extern CLSID_VideoStreamConfigPropertyPage as const GUID
extern CLSID_AudioRendererAdvancedProperties as const GUID
extern CLSID_VideoMixingRenderer as const GUID
extern CLSID_VideoRendererDefault as const GUID
extern CLSID_AllocPresenter as const GUID
extern CLSID_AllocPresenterDDXclMode as const GUID
extern CLSID_VideoPortManager as const GUID
extern CLSID_VideoMixingRenderer9 as const GUID
extern CLSID_ATSCNetworkProvider as const GUID
extern CLSID_ATSCNetworkPropertyPage as const GUID
extern CLSID_DVBSNetworkProvider as const GUID
extern CLSID_DVBTNetworkProvider as const GUID
extern CLSID_DVBCNetworkProvider as const GUID
extern CLSID_DShowTVEFilter as const GUID
extern CLSID_TVEFilterTuneProperties as const GUID
extern CLSID_TVEFilterCCProperties as const GUID
extern CLSID_TVEFilterStatsProperties as const GUID
extern CLSID_IVideoEncoderProxy as const GUID
extern CLSID_ICodecAPIProxy as const GUID
extern CLSID_IVideoEncoderCodecAPIProxy as const GUID
#define __ENCODER_API_GUIDS__
extern ENCAPIPARAM_BITRATE as const GUID
extern ENCAPIPARAM_PEAK_BITRATE as const GUID
extern ENCAPIPARAM_BITRATE_MODE as const GUID
extern CODECAPI_CHANGELISTS as const GUID
extern CODECAPI_VIDEO_ENCODER as const GUID
extern CODECAPI_AUDIO_ENCODER as const GUID
extern CODECAPI_SETALLDEFAULTS as const GUID
extern CODECAPI_ALLSETTINGS as const GUID
extern CODECAPI_SUPPORTSEVENTS as const GUID
extern CODECAPI_CURRENTCHANGELIST as const GUID

end extern
