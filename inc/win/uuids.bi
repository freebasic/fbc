''
''
'' uuids -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_uuids_bi__
#define __win_uuids_bi__

#inclib "uuid"
#inclib "dxguid"

#define MEDIATYPE_NULL       GUID_NULL
#define MEDIASUBTYPE_NULL    GUID_NULL

extern MEDIASUBTYPE_None alias "MEDIASUBTYPE_None" as GUID
extern MEDIATYPE_Video alias "MEDIATYPE_Video" as GUID
extern MEDIATYPE_Audio alias "MEDIATYPE_Audio" as GUID
extern MEDIATYPE_Text alias "MEDIATYPE_Text" as GUID
extern MEDIATYPE_Midi alias "MEDIATYPE_Midi" as GUID
extern MEDIATYPE_Stream alias "MEDIATYPE_Stream" as GUID
extern MEDIATYPE_Interleaved alias "MEDIATYPE_Interleaved" as GUID
extern MEDIATYPE_File alias "MEDIATYPE_File" as GUID
extern MEDIATYPE_ScriptCommand alias "MEDIATYPE_ScriptCommand" as GUID
extern MEDIATYPE_AUXLine21Data alias "MEDIATYPE_AUXLine21Data" as GUID
extern MEDIATYPE_VBI alias "MEDIATYPE_VBI" as GUID
extern MEDIATYPE_Timecode alias "MEDIATYPE_Timecode" as GUID
extern MEDIATYPE_LMRT alias "MEDIATYPE_LMRT" as GUID
extern MEDIATYPE_URL_STREAM alias "MEDIATYPE_URL_STREAM" as GUID
extern MEDIASUBTYPE_CLPL alias "MEDIASUBTYPE_CLPL" as GUID
extern MEDIASUBTYPE_YUYV alias "MEDIASUBTYPE_YUYV" as GUID
extern MEDIASUBTYPE_IYUV alias "MEDIASUBTYPE_IYUV" as GUID
extern MEDIASUBTYPE_YVU9 alias "MEDIASUBTYPE_YVU9" as GUID
extern MEDIASUBTYPE_Y411 alias "MEDIASUBTYPE_Y411" as GUID
extern MEDIASUBTYPE_Y41P alias "MEDIASUBTYPE_Y41P" as GUID
extern MEDIASUBTYPE_YUY2 alias "MEDIASUBTYPE_YUY2" as GUID
extern MEDIASUBTYPE_YVYU alias "MEDIASUBTYPE_YVYU" as GUID
extern MEDIASUBTYPE_UYVY alias "MEDIASUBTYPE_UYVY" as GUID
extern MEDIASUBTYPE_Y211 alias "MEDIASUBTYPE_Y211" as GUID
extern MEDIASUBTYPE_CLJR alias "MEDIASUBTYPE_CLJR" as GUID
extern MEDIASUBTYPE_IF09 alias "MEDIASUBTYPE_IF09" as GUID
extern MEDIASUBTYPE_CPLA alias "MEDIASUBTYPE_CPLA" as GUID
extern MEDIASUBTYPE_MJPG alias "MEDIASUBTYPE_MJPG" as GUID
extern MEDIASUBTYPE_TVMJ alias "MEDIASUBTYPE_TVMJ" as GUID
extern MEDIASUBTYPE_WAKE alias "MEDIASUBTYPE_WAKE" as GUID
extern MEDIASUBTYPE_CFCC alias "MEDIASUBTYPE_CFCC" as GUID
extern MEDIASUBTYPE_IJPG alias "MEDIASUBTYPE_IJPG" as GUID
extern MEDIASUBTYPE_Plum alias "MEDIASUBTYPE_Plum" as GUID
extern MEDIASUBTYPE_DVCS alias "MEDIASUBTYPE_DVCS" as GUID
extern MEDIASUBTYPE_DVSD alias "MEDIASUBTYPE_DVSD" as GUID
extern MEDIASUBTYPE_MDVF alias "MEDIASUBTYPE_MDVF" as GUID
extern MEDIASUBTYPE_RGB1 alias "MEDIASUBTYPE_RGB1" as GUID
extern MEDIASUBTYPE_RGB4 alias "MEDIASUBTYPE_RGB4" as GUID
extern MEDIASUBTYPE_RGB8 alias "MEDIASUBTYPE_RGB8" as GUID
extern MEDIASUBTYPE_RGB565 alias "MEDIASUBTYPE_RGB565" as GUID
extern MEDIASUBTYPE_RGB555 alias "MEDIASUBTYPE_RGB555" as GUID
extern MEDIASUBTYPE_RGB24 alias "MEDIASUBTYPE_RGB24" as GUID
extern MEDIASUBTYPE_RGB32 alias "MEDIASUBTYPE_RGB32" as GUID
extern MEDIASUBTYPE_ARGB1555 alias "MEDIASUBTYPE_ARGB1555" as GUID
extern MEDIASUBTYPE_ARGB4444 alias "MEDIASUBTYPE_ARGB4444" as GUID
extern MEDIASUBTYPE_ARGB32 alias "MEDIASUBTYPE_ARGB32" as GUID
extern MEDIASUBTYPE_A2R10G10B10 alias "MEDIASUBTYPE_A2R10G10B10" as GUID
extern MEDIASUBTYPE_A2B10G10R10 alias "MEDIASUBTYPE_A2B10G10R10" as GUID
extern MEDIASUBTYPE_AYUV alias "MEDIASUBTYPE_AYUV" as GUID
extern MEDIASUBTYPE_AI44 alias "MEDIASUBTYPE_AI44" as GUID
extern MEDIASUBTYPE_IA44 alias "MEDIASUBTYPE_IA44" as GUID
extern MEDIASUBTYPE_RGB32_D3D_DX7_RT alias "MEDIASUBTYPE_RGB32_D3D_DX7_RT" as GUID
extern MEDIASUBTYPE_RGB16_D3D_DX7_RT alias "MEDIASUBTYPE_RGB16_D3D_DX7_RT" as GUID
extern MEDIASUBTYPE_ARGB32_D3D_DX7_RT alias "MEDIASUBTYPE_ARGB32_D3D_DX7_RT" as GUID
extern MEDIASUBTYPE_ARGB4444_D3D_DX7_RT alias "MEDIASUBTYPE_ARGB4444_D3D_DX7_RT" as GUID
extern MEDIASUBTYPE_ARGB1555_D3D_DX7_RT alias "MEDIASUBTYPE_ARGB1555_D3D_DX7_RT" as GUID
extern MEDIASUBTYPE_RGB32_D3D_DX9_RT alias "MEDIASUBTYPE_RGB32_D3D_DX9_RT" as GUID
extern MEDIASUBTYPE_RGB16_D3D_DX9_RT alias "MEDIASUBTYPE_RGB16_D3D_DX9_RT" as GUID
extern MEDIASUBTYPE_ARGB32_D3D_DX9_RT alias "MEDIASUBTYPE_ARGB32_D3D_DX9_RT" as GUID
extern MEDIASUBTYPE_ARGB4444_D3D_DX9_RT alias "MEDIASUBTYPE_ARGB4444_D3D_DX9_RT" as GUID
extern MEDIASUBTYPE_ARGB1555_D3D_DX9_RT alias "MEDIASUBTYPE_ARGB1555_D3D_DX9_RT" as GUID
extern MEDIASUBTYPE_YV12 alias "MEDIASUBTYPE_YV12" as GUID
extern MEDIASUBTYPE_NV12 alias "MEDIASUBTYPE_NV12" as GUID
extern MEDIASUBTYPE_IMC1 alias "MEDIASUBTYPE_IMC1" as GUID
extern MEDIASUBTYPE_IMC2 alias "MEDIASUBTYPE_IMC2" as GUID
extern MEDIASUBTYPE_IMC3 alias "MEDIASUBTYPE_IMC3" as GUID
extern MEDIASUBTYPE_IMC4 alias "MEDIASUBTYPE_IMC4" as GUID
extern MEDIASUBTYPE_S340 alias "MEDIASUBTYPE_S340" as GUID
extern MEDIASUBTYPE_S342 alias "MEDIASUBTYPE_S342" as GUID
extern MEDIASUBTYPE_Overlay alias "MEDIASUBTYPE_Overlay" as GUID
extern MEDIASUBTYPE_MPEG1Packet alias "MEDIASUBTYPE_MPEG1Packet" as GUID
extern MEDIASUBTYPE_MPEG1Payload alias "MEDIASUBTYPE_MPEG1Payload" as GUID
extern MEDIASUBTYPE_MPEG1AudioPayload alias "MEDIASUBTYPE_MPEG1AudioPayload" as GUID
extern MEDIATYPE_MPEG1SystemStream alias "MEDIATYPE_MPEG1SystemStream" as GUID
extern MEDIASUBTYPE_MPEG1System alias "MEDIASUBTYPE_MPEG1System" as GUID
extern MEDIASUBTYPE_MPEG1VideoCD alias "MEDIASUBTYPE_MPEG1VideoCD" as GUID
extern MEDIASUBTYPE_MPEG1Video alias "MEDIASUBTYPE_MPEG1Video" as GUID
extern MEDIASUBTYPE_MPEG1Audio alias "MEDIASUBTYPE_MPEG1Audio" as GUID
extern MEDIASUBTYPE_Avi alias "MEDIASUBTYPE_Avi" as GUID
extern MEDIASUBTYPE_Asf alias "MEDIASUBTYPE_Asf" as GUID
extern MEDIASUBTYPE_QTMovie alias "MEDIASUBTYPE_QTMovie" as GUID
extern MEDIASUBTYPE_QTRpza alias "MEDIASUBTYPE_QTRpza" as GUID
extern MEDIASUBTYPE_QTSmc alias "MEDIASUBTYPE_QTSmc" as GUID
extern MEDIASUBTYPE_QTRle alias "MEDIASUBTYPE_QTRle" as GUID
extern MEDIASUBTYPE_QTJpeg alias "MEDIASUBTYPE_QTJpeg" as GUID
extern MEDIASUBTYPE_PCMAudio_Obsolete alias "MEDIASUBTYPE_PCMAudio_Obsolete" as GUID
extern MEDIASUBTYPE_PCM alias "MEDIASUBTYPE_PCM" as GUID
extern MEDIASUBTYPE_WAVE alias "MEDIASUBTYPE_WAVE" as GUID
extern MEDIASUBTYPE_AU alias "MEDIASUBTYPE_AU" as GUID
extern MEDIASUBTYPE_AIFF alias "MEDIASUBTYPE_AIFF" as GUID
extern MEDIASUBTYPE_dvsd alias "MEDIASUBTYPE_dvsd" as GUID
extern MEDIASUBTYPE_dvhd alias "MEDIASUBTYPE_dvhd" as GUID
extern MEDIASUBTYPE_dvsl alias "MEDIASUBTYPE_dvsl" as GUID
extern MEDIASUBTYPE_dv25 alias "MEDIASUBTYPE_dv25" as GUID
extern MEDIASUBTYPE_dv50 alias "MEDIASUBTYPE_dv50" as GUID
extern MEDIASUBTYPE_dvh1 alias "MEDIASUBTYPE_dvh1" as GUID
extern MEDIASUBTYPE_Line21_BytePair alias "MEDIASUBTYPE_Line21_BytePair" as GUID
extern MEDIASUBTYPE_Line21_GOPPacket alias "MEDIASUBTYPE_Line21_GOPPacket" as GUID
extern MEDIASUBTYPE_Line21_VBIRawData alias "MEDIASUBTYPE_Line21_VBIRawData" as GUID
extern MEDIASUBTYPE_TELETEXT alias "MEDIASUBTYPE_TELETEXT" as GUID
extern MEDIASUBTYPE_WSS alias "MEDIASUBTYPE_WSS" as GUID
extern MEDIASUBTYPE_VPS alias "MEDIASUBTYPE_VPS" as GUID
extern MEDIASUBTYPE_DRM_Audio alias "MEDIASUBTYPE_DRM_Audio" as GUID
extern MEDIASUBTYPE_IEEE_FLOAT alias "MEDIASUBTYPE_IEEE_FLOAT" as GUID
extern MEDIASUBTYPE_DOLBY_AC3_SPDIF alias "MEDIASUBTYPE_DOLBY_AC3_SPDIF" as GUID
extern MEDIASUBTYPE_RAW_SPORT alias "MEDIASUBTYPE_RAW_SPORT" as GUID
extern MEDIASUBTYPE_SPDIF_TAG_241h alias "MEDIASUBTYPE_SPDIF_TAG_241h" as GUID
extern MEDIASUBTYPE_DssVideo alias "MEDIASUBTYPE_DssVideo" as GUID
extern MEDIASUBTYPE_DssAudio alias "MEDIASUBTYPE_DssAudio" as GUID
extern MEDIASUBTYPE_VPVideo alias "MEDIASUBTYPE_VPVideo" as GUID
extern MEDIASUBTYPE_VPVBI alias "MEDIASUBTYPE_VPVBI" as GUID
extern CLSID_CaptureGraphBuilder alias "CLSID_CaptureGraphBuilder" as GUID
extern CLSID_CaptureGraphBuilder2 alias "CLSID_CaptureGraphBuilder2" as GUID
extern CLSID_ProtoFilterGraph alias "CLSID_ProtoFilterGraph" as GUID
extern CLSID_SystemClock alias "CLSID_SystemClock" as GUID
extern CLSID_FilterMapper alias "CLSID_FilterMapper" as GUID
extern CLSID_FilterGraph alias "CLSID_FilterGraph" as GUID
extern CLSID_FilterGraphNoThread alias "CLSID_FilterGraphNoThread" as GUID
extern CLSID_MPEG1Doc alias "CLSID_MPEG1Doc" as GUID
extern CLSID_FileSource alias "CLSID_FileSource" as GUID
extern CLSID_MPEG1PacketPlayer alias "CLSID_MPEG1PacketPlayer" as GUID
extern CLSID_MPEG1Splitter alias "CLSID_MPEG1Splitter" as GUID
extern CLSID_CMpegVideoCodec alias "CLSID_CMpegVideoCodec" as GUID
extern CLSID_CMpegAudioCodec alias "CLSID_CMpegAudioCodec" as GUID
extern CLSID_TextRender alias "CLSID_TextRender" as GUID
extern CLSID_InfTee alias "CLSID_InfTee" as GUID
extern CLSID_AviSplitter alias "CLSID_AviSplitter" as GUID
extern CLSID_AviReader alias "CLSID_AviReader" as GUID
extern CLSID_VfwCapture alias "CLSID_VfwCapture" as GUID
extern CLSID_CaptureProperties alias "CLSID_CaptureProperties" as GUID
extern CLSID_FGControl alias "CLSID_FGControl" as GUID
extern CLSID_MOVReader alias "CLSID_MOVReader" as GUID
extern CLSID_QuickTimeParser alias "CLSID_QuickTimeParser" as GUID
extern CLSID_QTDec alias "CLSID_QTDec" as GUID
extern CLSID_AVIDoc alias "CLSID_AVIDoc" as GUID
extern CLSID_VideoRenderer alias "CLSID_VideoRenderer" as GUID
extern CLSID_Colour alias "CLSID_Colour" as GUID
extern CLSID_Dither alias "CLSID_Dither" as GUID
extern CLSID_ModexRenderer alias "CLSID_ModexRenderer" as GUID
extern CLSID_AudioRender alias "CLSID_AudioRender" as GUID
extern CLSID_AudioProperties alias "CLSID_AudioProperties" as GUID
extern CLSID_DSoundRender alias "CLSID_DSoundRender" as GUID
extern CLSID_AudioRecord alias "CLSID_AudioRecord" as GUID
extern CLSID_AudioInputMixerProperties alias "CLSID_AudioInputMixerProperties" as GUID
extern CLSID_AVIDec alias "CLSID_AVIDec" as GUID
extern CLSID_AVIDraw alias "CLSID_AVIDraw" as GUID
extern CLSID_ACMWrapper alias "CLSID_ACMWrapper" as GUID
extern CLSID_AsyncReader alias "CLSID_AsyncReader" as GUID
extern CLSID_URLReader alias "CLSID_URLReader" as GUID
extern CLSID_PersistMonikerPID alias "CLSID_PersistMonikerPID" as GUID
extern CLSID_AVICo alias "CLSID_AVICo" as GUID
extern CLSID_FileWriter alias "CLSID_FileWriter" as GUID
extern CLSID_AviDest alias "CLSID_AviDest" as GUID
extern CLSID_AviMuxProptyPage alias "CLSID_AviMuxProptyPage" as GUID
extern CLSID_AviMuxProptyPage1 alias "CLSID_AviMuxProptyPage1" as GUID
extern CLSID_AVIMIDIRender alias "CLSID_AVIMIDIRender" as GUID
extern CLSID_WMAsfReader alias "CLSID_WMAsfReader" as GUID
extern CLSID_WMAsfWriter alias "CLSID_WMAsfWriter" as GUID
extern CLSID_MPEG2Demultiplexer alias "CLSID_MPEG2Demultiplexer" as GUID
extern CLSID_MMSPLITTER alias "CLSID_MMSPLITTER" as GUID
extern CLSID_StreamBufferSink alias "CLSID_StreamBufferSink" as GUID
extern CLSID_StreamBufferSource alias "CLSID_StreamBufferSource" as GUID
extern CLSID_StreamBufferConfig alias "CLSID_StreamBufferConfig" as GUID
extern CLSID_Mpeg2VideoStreamAnalyzer alias "CLSID_Mpeg2VideoStreamAnalyzer" as GUID
extern CLSID_StreamBufferRecordingAttributes alias "CLSID_StreamBufferRecordingAttributes" as GUID
extern CLSID_StreamBufferComposeRecording alias "CLSID_StreamBufferComposeRecording" as GUID
extern CLSID_DVVideoCodec alias "CLSID_DVVideoCodec" as GUID
extern CLSID_DVVideoEnc alias "CLSID_DVVideoEnc" as GUID
extern CLSID_DVSplitter alias "CLSID_DVSplitter" as GUID
extern CLSID_DVMux alias "CLSID_DVMux" as GUID
extern CLSID_SeekingPassThru alias "CLSID_SeekingPassThru" as GUID
extern CLSID_Line21Decoder alias "CLSID_Line21Decoder" as GUID
extern CLSID_Line21Decoder2 alias "CLSID_Line21Decoder2" as GUID
extern CLSID_OverlayMixer alias "CLSID_OverlayMixer" as GUID
extern CLSID_VBISurfaces alias "CLSID_VBISurfaces" as GUID
extern CLSID_WSTDecoder alias "CLSID_WSTDecoder" as GUID
extern CLSID_MjpegDec alias "CLSID_MjpegDec" as GUID
extern CLSID_MJPGEnc alias "CLSID_MJPGEnc" as GUID
extern CLSID_SystemDeviceEnum alias "CLSID_SystemDeviceEnum" as GUID
extern CLSID_CDeviceMoniker alias "CLSID_CDeviceMoniker" as GUID
extern CLSID_VideoInputDeviceCategory alias "CLSID_VideoInputDeviceCategory" as GUID
extern CLSID_CVidCapClassManager alias "CLSID_CVidCapClassManager" as GUID
extern CLSID_LegacyAmFilterCategory alias "CLSID_LegacyAmFilterCategory" as GUID
extern CLSID_CQzFilterClassManager alias "CLSID_CQzFilterClassManager" as GUID
extern CLSID_VideoCompressorCategory alias "CLSID_VideoCompressorCategory" as GUID
extern CLSID_CIcmCoClassManager alias "CLSID_CIcmCoClassManager" as GUID
extern CLSID_AudioCompressorCategory alias "CLSID_AudioCompressorCategory" as GUID
extern CLSID_CAcmCoClassManager alias "CLSID_CAcmCoClassManager" as GUID
extern CLSID_AudioInputDeviceCategory alias "CLSID_AudioInputDeviceCategory" as GUID
extern CLSID_CWaveinClassManager alias "CLSID_CWaveinClassManager" as GUID
extern CLSID_AudioRendererCategory alias "CLSID_AudioRendererCategory" as GUID
extern CLSID_CWaveOutClassManager alias "CLSID_CWaveOutClassManager" as GUID
extern CLSID_MidiRendererCategory alias "CLSID_MidiRendererCategory" as GUID
extern CLSID_CMidiOutClassManager alias "CLSID_CMidiOutClassManager" as GUID
extern CLSID_TransmitCategory alias "CLSID_TransmitCategory" as GUID
extern CLSID_DeviceControlCategory alias "CLSID_DeviceControlCategory" as GUID
extern CLSID_ActiveMovieCategories alias "CLSID_ActiveMovieCategories" as GUID
extern CLSID_DVDHWDecodersCategory alias "CLSID_DVDHWDecodersCategory" as GUID
extern CLSID_MediaEncoderCategory alias "CLSID_MediaEncoderCategory" as GUID
extern CLSID_MediaMultiplexerCategory alias "CLSID_MediaMultiplexerCategory" as GUID
extern CLSID_FilterMapper2 alias "CLSID_FilterMapper2" as GUID
extern CLSID_MemoryAllocator alias "CLSID_MemoryAllocator" as GUID
extern CLSID_MediaPropertyBag alias "CLSID_MediaPropertyBag" as GUID
extern CLSID_DvdGraphBuilder alias "CLSID_DvdGraphBuilder" as GUID
extern CLSID_DVDNavigator alias "CLSID_DVDNavigator" as GUID
extern CLSID_DVDState alias "CLSID_DVDState" as GUID
extern CLSID_SmartTee alias "CLSID_SmartTee" as GUID
extern FORMAT_None alias "FORMAT_None" as GUID
extern FORMAT_VideoInfo alias "FORMAT_VideoInfo" as GUID
extern FORMAT_VideoInfo2 alias "FORMAT_VideoInfo2" as GUID
extern FORMAT_WaveFormatEx alias "FORMAT_WaveFormatEx" as GUID
extern FORMAT_MPEGVideo alias "FORMAT_MPEGVideo" as GUID
extern FORMAT_MPEGStreams alias "FORMAT_MPEGStreams" as GUID
extern FORMAT_DvInfo alias "FORMAT_DvInfo" as GUID
extern CLSID_DirectDrawProperties alias "CLSID_DirectDrawProperties" as GUID
extern CLSID_PerformanceProperties alias "CLSID_PerformanceProperties" as GUID
extern CLSID_QualityProperties alias "CLSID_QualityProperties" as GUID
extern IID_IBaseVideoMixer alias "IID_IBaseVideoMixer" as GUID
extern IID_IDirectDrawVideo alias "IID_IDirectDrawVideo" as GUID
extern IID_IQualProp alias "IID_IQualProp" as GUID
extern CLSID_VPObject alias "CLSID_VPObject" as GUID
extern IID_IVPObject alias "IID_IVPObject" as GUID
extern IID_IVPControl alias "IID_IVPControl" as GUID
extern CLSID_VPVBIObject alias "CLSID_VPVBIObject" as GUID
extern IID_IVPVBIObject alias "IID_IVPVBIObject" as GUID
extern IID_IVPConfig alias "IID_IVPConfig" as GUID
extern IID_IVPNotify alias "IID_IVPNotify" as GUID
extern IID_IVPNotify2 alias "IID_IVPNotify2" as GUID
extern IID_IVPVBIConfig alias "IID_IVPVBIConfig" as GUID
extern IID_IVPVBINotify alias "IID_IVPVBINotify" as GUID
extern IID_IMixerPinConfig alias "IID_IMixerPinConfig" as GUID
extern IID_IMixerPinConfig2 alias "IID_IMixerPinConfig2" as GUID
#ifndef IID_IDDVideoPortContainer
extern IID_IDDVideoPortContainer alias "IID_IDDVideoPortContainer" as GUID
#endif
#ifndef IID_IDirectDrawKernel
extern IID_IDirectDrawKernel alias "IID_IDirectDrawKernel" as GUID
extern IID_IDirectDrawSurfaceKernel alias "IID_IDirectDrawSurfaceKernel" as GUID
#endif
extern CLSID_ModexProperties alias "CLSID_ModexProperties" as GUID
extern IID_IFullScreenVideo alias "IID_IFullScreenVideo" as GUID
extern IID_IFullScreenVideoEx alias "IID_IFullScreenVideoEx" as GUID
extern CLSID_DVDecPropertiesPage alias "CLSID_DVDecPropertiesPage" as GUID
extern CLSID_DVEncPropertiesPage alias "CLSID_DVEncPropertiesPage" as GUID
extern CLSID_DVMuxPropertyPage alias "CLSID_DVMuxPropertyPage" as GUID
extern IID_IAMDirectSound alias "IID_IAMDirectSound" as GUID
extern IID_IMpegAudioDecoder alias "IID_IMpegAudioDecoder" as GUID
extern IID_IAMLine21Decoder alias "IID_IAMLine21Decoder" as GUID
extern IID_IAMWstDecoder alias "IID_IAMWstDecoder" as GUID
extern CLSID_WstDecoderPropertyPage alias "CLSID_WstDecoderPropertyPage" as GUID
extern FORMAT_AnalogVideo alias "FORMAT_AnalogVideo" as GUID
extern MEDIATYPE_AnalogVideo alias "MEDIATYPE_AnalogVideo" as GUID
extern MEDIASUBTYPE_AnalogVideo_NTSC_M alias "MEDIASUBTYPE_AnalogVideo_NTSC_M" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_B alias "MEDIASUBTYPE_AnalogVideo_PAL_B" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_D alias "MEDIASUBTYPE_AnalogVideo_PAL_D" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_G alias "MEDIASUBTYPE_AnalogVideo_PAL_G" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_H alias "MEDIASUBTYPE_AnalogVideo_PAL_H" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_I alias "MEDIASUBTYPE_AnalogVideo_PAL_I" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_M alias "MEDIASUBTYPE_AnalogVideo_PAL_M" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_N alias "MEDIASUBTYPE_AnalogVideo_PAL_N" as GUID
extern MEDIASUBTYPE_AnalogVideo_PAL_N_COMBO alias "MEDIASUBTYPE_AnalogVideo_PAL_N_COMBO" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_B alias "MEDIASUBTYPE_AnalogVideo_SECAM_B" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_D alias "MEDIASUBTYPE_AnalogVideo_SECAM_D" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_G alias "MEDIASUBTYPE_AnalogVideo_SECAM_G" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_H alias "MEDIASUBTYPE_AnalogVideo_SECAM_H" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_K alias "MEDIASUBTYPE_AnalogVideo_SECAM_K" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_K1 alias "MEDIASUBTYPE_AnalogVideo_SECAM_K1" as GUID
extern MEDIASUBTYPE_AnalogVideo_SECAM_L alias "MEDIASUBTYPE_AnalogVideo_SECAM_L" as GUID
extern MEDIATYPE_AnalogAudio alias "MEDIATYPE_AnalogAudio" as GUID

#define MEDIASUBTYPE_HASALPHA(mt) ( (mt.subtype = MEDIASUBTYPE_ARGB4444)            or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB32)              or _
                                    (mt.subtype = MEDIASUBTYPE_AYUV)                or _
                                    (mt.subtype = MEDIASUBTYPE_AI44)                or _
                                    (mt.subtype = MEDIASUBTYPE_IA44)                or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB1555)            or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT)   or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT) or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT) or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT)   or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT) or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT) )

#define MEDIASUBTYPE_HASALPHA7(mt) ((mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT)   or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT) or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT) )

#define MEDIASUBTYPE_D3D_DX7_RT(mt) ((mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX7_RT)   or _
                                     (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX7_RT) or _
                                     (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX7_RT) or _
                                     (mt.subtype = MEDIASUBTYPE_RGB32_D3D_DX7_RT)    or _
                                     (mt.subtype = MEDIASUBTYPE_RGB16_D3D_DX7_RT))

#define MEDIASUBTYPE_HASALPHA9(mt) ((mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT)   or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT) or _
                                    (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT) )


#define MEDIASUBTYPE_D3D_DX9_RT(mt) ((mt.subtype = MEDIASUBTYPE_ARGB32_D3D_DX9_RT)   or _
                                     (mt.subtype = MEDIASUBTYPE_ARGB4444_D3D_DX9_RT) or _
                                     (mt.subtype = MEDIASUBTYPE_ARGB1555_D3D_DX9_RT) or _
                                     (mt.subtype = MEDIASUBTYPE_RGB32_D3D_DX9_RT)    or _
                                     (mt.subtype = MEDIASUBTYPE_RGB16_D3D_DX9_RT))

#include once "win/ksuuids.bi"

extern TIME_FORMAT_NONE alias "TIME_FORMAT_NONE" as GUID
extern TIME_FORMAT_FRAME alias "TIME_FORMAT_FRAME" as GUID
extern TIME_FORMAT_BYTE alias "TIME_FORMAT_BYTE" as GUID
extern TIME_FORMAT_SAMPLE alias "TIME_FORMAT_SAMPLE" as GUID
extern TIME_FORMAT_FIELD alias "TIME_FORMAT_FIELD" as GUID
extern TIME_FORMAT_MEDIA_TIME alias "TIME_FORMAT_MEDIA_TIME" as GUID
extern AMPROPSETID_Pin alias "AMPROPSETID_Pin" as GUID
extern PIN_CATEGORY_CAPTURE alias "PIN_CATEGORY_CAPTURE" as GUID
extern PIN_CATEGORY_PREVIEW alias "PIN_CATEGORY_PREVIEW" as GUID
extern PIN_CATEGORY_ANALOGVIDEOIN alias "PIN_CATEGORY_ANALOGVIDEOIN" as GUID
extern PIN_CATEGORY_VBI alias "PIN_CATEGORY_VBI" as GUID
extern PIN_CATEGORY_VIDEOPORT alias "PIN_CATEGORY_VIDEOPORT" as GUID
extern PIN_CATEGORY_NABTS alias "PIN_CATEGORY_NABTS" as GUID
extern PIN_CATEGORY_EDS alias "PIN_CATEGORY_EDS" as GUID
extern PIN_CATEGORY_TELETEXT alias "PIN_CATEGORY_TELETEXT" as GUID
extern PIN_CATEGORY_CC alias "PIN_CATEGORY_CC" as GUID
extern PIN_CATEGORY_STILL alias "PIN_CATEGORY_STILL" as GUID
extern PIN_CATEGORY_TIMECODE alias "PIN_CATEGORY_TIMECODE" as GUID
extern PIN_CATEGORY_VIDEOPORT_VBI alias "PIN_CATEGORY_VIDEOPORT_VBI" as GUID
extern LOOK_UPSTREAM_ONLY alias "LOOK_UPSTREAM_ONLY" as GUID
extern LOOK_DOWNSTREAM_ONLY alias "LOOK_DOWNSTREAM_ONLY" as GUID
extern CLSID_TVTunerFilterPropertyPage alias "CLSID_TVTunerFilterPropertyPage" as GUID
extern CLSID_CrossbarFilterPropertyPage alias "CLSID_CrossbarFilterPropertyPage" as GUID
extern CLSID_TVAudioFilterPropertyPage alias "CLSID_TVAudioFilterPropertyPage" as GUID
extern CLSID_VideoProcAmpPropertyPage alias "CLSID_VideoProcAmpPropertyPage" as GUID
extern CLSID_CameraControlPropertyPage alias "CLSID_CameraControlPropertyPage" as GUID
extern CLSID_AnalogVideoDecoderPropertyPage alias "CLSID_AnalogVideoDecoderPropertyPage" as GUID
extern CLSID_VideoStreamConfigPropertyPage alias "CLSID_VideoStreamConfigPropertyPage" as GUID
extern CLSID_AudioRendererAdvancedProperties alias "CLSID_AudioRendererAdvancedProperties" as GUID
extern CLSID_VideoMixingRenderer alias "CLSID_VideoMixingRenderer" as GUID
extern CLSID_VideoRendererDefault alias "CLSID_VideoRendererDefault" as GUID
extern CLSID_AllocPresenter alias "CLSID_AllocPresenter" as GUID
extern CLSID_AllocPresenterDDXclMode alias "CLSID_AllocPresenterDDXclMode" as GUID
extern CLSID_VideoPortManager alias "CLSID_VideoPortManager" as GUID
extern CLSID_VideoMixingRenderer9 alias "CLSID_VideoMixingRenderer9" as GUID
extern CLSID_ATSCNetworkProvider alias "CLSID_ATSCNetworkProvider" as GUID
extern CLSID_ATSCNetworkPropertyPage alias "CLSID_ATSCNetworkPropertyPage" as GUID
extern CLSID_DVBSNetworkProvider alias "CLSID_DVBSNetworkProvider" as GUID
extern CLSID_DVBTNetworkProvider alias "CLSID_DVBTNetworkProvider" as GUID
extern CLSID_DVBCNetworkProvider alias "CLSID_DVBCNetworkProvider" as GUID
extern CLSID_DShowTVEFilter alias "CLSID_DShowTVEFilter" as GUID
extern CLSID_TVEFilterTuneProperties alias "CLSID_TVEFilterTuneProperties" as GUID
extern CLSID_TVEFilterCCProperties alias "CLSID_TVEFilterCCProperties" as GUID
extern CLSID_TVEFilterStatsProperties alias "CLSID_TVEFilterStatsProperties" as GUID
extern CLSID_IVideoEncoderProxy alias "CLSID_IVideoEncoderProxy" as GUID
extern CLSID_ICodecAPIProxy alias "CLSID_ICodecAPIProxy" as GUID
extern CLSID_IVideoEncoderCodecAPIProxy alias "CLSID_IVideoEncoderCodecAPIProxy" as GUID
extern ENCAPIPARAM_BITRATE alias "ENCAPIPARAM_BITRATE" as GUID
extern ENCAPIPARAM_PEAK_BITRATE alias "ENCAPIPARAM_PEAK_BITRATE" as GUID
extern ENCAPIPARAM_BITRATE_MODE alias "ENCAPIPARAM_BITRATE_MODE" as GUID
extern CODECAPI_CHANGELISTS alias "CODECAPI_CHANGELISTS" as GUID
extern CODECAPI_VIDEO_ENCODER alias "CODECAPI_VIDEO_ENCODER" as GUID
extern CODECAPI_AUDIO_ENCODER alias "CODECAPI_AUDIO_ENCODER" as GUID
extern CODECAPI_SETALLDEFAULTS alias "CODECAPI_SETALLDEFAULTS" as GUID
extern CODECAPI_ALLSETTINGS alias "CODECAPI_ALLSETTINGS" as GUID
extern CODECAPI_SUPPORTSEVENTS alias "CODECAPI_SUPPORTSEVENTS" as GUID
extern CODECAPI_CURRENTCHANGELIST alias "CODECAPI_CURRENTCHANGELIST" as GUID

#ifndef CLSID_DirectDraw
extern CLSID_DirectDraw alias "CLSID_DirectDraw" as GUID
extern CLSID_DirectDraw7 alias "CLSID_DirectDraw7" as GUID
extern CLSID_DirectDrawClipper alias "CLSID_DirectDrawClipper" as GUID
extern IID_IDirectDraw alias "IID_IDirectDraw" as GUID
extern IID_IDirectDraw2 alias "IID_IDirectDraw2" as GUID
extern IID_IDirectDraw4 alias "IID_IDirectDraw4" as GUID
extern IID_IDirectDraw7 alias "IID_IDirectDraw7" as GUID
extern IID_IDirectDrawSurface alias "IID_IDirectDrawSurface" as GUID
extern IID_IDirectDrawSurface2 alias "IID_IDirectDrawSurface2" as GUID
extern IID_IDirectDrawSurface3 alias "IID_IDirectDrawSurface3" as GUID
extern IID_IDirectDrawSurface4 alias "IID_IDirectDrawSurface4" as GUID
extern IID_IDirectDrawSurface7 alias "IID_IDirectDrawSurface7" as GUID
extern IID_IDirectDrawPalette alias "IID_IDirectDrawPalette" as GUID
extern IID_IDirectDrawClipper alias "IID_IDirectDrawClipper" as GUID
extern IID_IDirectDrawColorControl alias "IID_IDirectDrawColorControl" as GUID
extern IID_IDirectDrawGammaControl alias "IID_IDirectDrawGammaControl" as GUID
#endif

#endif
