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

#define _INC_TCPESTATS

#if _WIN32_WINNT >= &h0600
	type _TCP_ESTATS_BANDWIDTH_ROD_v0
		OutboundBandwidth as ULONG64
		InboundBandwidth as ULONG64
		OutboundInstability as ULONG64
		InboundInstability as ULONG64
		OutboundBandwidthPeaked as WINBOOLEAN
		InboundBandwidthPeaked as WINBOOLEAN
	end type

	type TCP_ESTATS_BANDWIDTH_ROD_v0 as _TCP_ESTATS_BANDWIDTH_ROD_v0
	type PTCP_ESTATS_BANDWIDTH_ROD_v0 as _TCP_ESTATS_BANDWIDTH_ROD_v0 ptr

	type _TCP_BOOLEAN_OPTIONAL as long
	enum
		TcpBoolOptDisabled = 0
		TcpBoolOptEnabled = 1
		TcpBoolOptUnchanged = -1
	end enum

	type TCP_BOOLEAN_OPTIONAL as _TCP_BOOLEAN_OPTIONAL

	type _TCP_ESTATS_BANDWIDTH_RW_v0
		EnableCollectionOutbound as TCP_BOOLEAN_OPTIONAL
		EnableCollectionInbound as TCP_BOOLEAN_OPTIONAL
	end type

	type TCP_ESTATS_BANDWIDTH_RW_v0 as _TCP_ESTATS_BANDWIDTH_RW_v0
	type PTCP_ESTATS_BANDWIDTH_RW_v0 as _TCP_ESTATS_BANDWIDTH_RW_v0 ptr

	type _TCP_ESTATS_DATA_ROD_v0
		DataBytesOut as ULONG64
		DataSegsOut as ULONG64
		DataBytesIn as ULONG64
		DataSegsIn as ULONG64
		SegsOut as ULONG64
		SegsIn as ULONG64
		SoftErrors as ULONG
		SoftErrorReason as ULONG
		SndUna as ULONG
		SndNxt as ULONG
		SndMax as ULONG
		ThruBytesAcked as ULONG64
		RcvNxt as ULONG
		ThruBytesReceived as ULONG64
	end type

	type TCP_ESTATS_DATA_ROD_v0 as _TCP_ESTATS_DATA_ROD_v0
	type PTCP_ESTATS_DATA_ROD_v0 as _TCP_ESTATS_DATA_ROD_v0 ptr

	type _TCP_ESTATS_DATA_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_DATA_RW_v0 as _TCP_ESTATS_DATA_RW_v0
	type PTCP_ESTATS_DATA_RW_v0 as _TCP_ESTATS_DATA_RW_v0 ptr

	type _TCP_ESTATS_FINE_RTT_ROD_v0
		RttVar as ULONG
		MaxRtt as ULONG
		MinRtt as ULONG
		SumRtt as ULONG
	end type

	type TCP_ESTATS_FINE_RTT_ROD_v0 as _TCP_ESTATS_FINE_RTT_ROD_v0
	type PTCP_ESTATS_FINE_RTT_ROD_v0 as _TCP_ESTATS_FINE_RTT_ROD_v0 ptr

	type _TCP_ESTATS_FINE_RTT_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_FINE_RTT_RW_v0 as _TCP_ESTATS_FINE_RTT_RW_v0
	type PTCP_ESTATS_FINE_RTT_RW_v0 as _TCP_ESTATS_FINE_RTT_RW_v0 ptr

	type _TCP_ESTATS_OBS_REC_ROD_v0
		CurRwinRcvd as ULONG
		MaxRwinRcvd as ULONG
		MinRwinRcvd as ULONG
		WinScaleRcvd as UCHAR
	end type

	type TCP_ESTATS_OBS_REC_ROD_v0 as _TCP_ESTATS_OBS_REC_ROD_v0
	type PTCP_ESTATS_OBS_REC_ROD_v0 as _TCP_ESTATS_OBS_REC_ROD_v0 ptr

	type _TCP_ESTATS_OBS_REC_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_OBS_REC_RW_v0 as _TCP_ESTATS_OBS_REC_RW_v0
	type PTCP_ESTATS_OBS_REC_RW_v0 as _TCP_ESTATS_OBS_REC_RW_v0 ptr

	type _TCP_ESTATS_PATH_ROD_v0
		FastRetran as ULONG
		Timeouts as ULONG
		SubsequentTimeouts as ULONG
		CurTimeoutCount as ULONG
		AbruptTimeouts as ULONG
		PktsRetrans as ULONG
		BytesRetrans as ULONG
		DupAcksIn as ULONG
		SacksRcvd as ULONG
		SackBlocksRcvd as ULONG
		CongSignals as ULONG
		PreCongSumCwnd as ULONG
		PreCongSumRtt as ULONG
		PostCongSumRtt as ULONG
		PostCongCountRtt as ULONG
		EcnSignals as ULONG
		EceRcvd as ULONG
		SendStall as ULONG
		QuenchRcvd as ULONG
		RetranThresh as ULONG
		SndDupAckEpisodes as ULONG
		SumBytesReordered as ULONG
		NonRecovDa as ULONG
		NonRecovDaEpisodes as ULONG
		AckAfterFr as ULONG
		DsackDups as ULONG
		SampleRtt as ULONG
		SmoothedRtt as ULONG
		RttVar as ULONG
		MaxRtt as ULONG
		MinRtt as ULONG
		SumRtt as ULONG
		CountRtt as ULONG
		CurRto as ULONG
		MaxRto as ULONG
		MinRto as ULONG
		CurMss as ULONG
		MaxMss as ULONG
		MinMss as ULONG
		SpuriousRtoDetections as ULONG
	end type

	type TCP_ESTATS_PATH_ROD_v0 as _TCP_ESTATS_PATH_ROD_v0
	type PTCP_ESTATS_PATH_ROD_v0 as _TCP_ESTATS_PATH_ROD_v0 ptr

	type _TCP_ESTATS_PATH_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_PATH_RW_v0 as _TCP_ESTATS_PATH_RW_v0
	type PTCP_ESTATS_PATH_RW_v0 as _TCP_ESTATS_PATH_RW_v0 ptr

	type _TCP_ESTATS_REC_ROD_v0
		CurRwinSent as ULONG
		MaxRwinSent as ULONG
		MinRwinSent as ULONG
		LimRwin as ULONG
		DupAckEpisodes as ULONG
		DupAcksOut as ULONG
		CeRcvd as ULONG
		EcnSent as ULONG
		EcnNoncesRcvd as ULONG
		CurReasmQueue as ULONG
		MaxReasmQueue as ULONG
		CurAppRQueue as SIZE_T_
		MaxAppRQueue as SIZE_T_
		WinScaleSent as UCHAR
	end type

	type TCP_ESTATS_REC_ROD_v0 as _TCP_ESTATS_REC_ROD_v0
	type PTCP_ESTATS_REC_ROD_v0 as _TCP_ESTATS_REC_ROD_v0 ptr

	type _TCP_ESTATS_REC_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_REC_RW_v0 as _TCP_ESTATS_REC_RW_v0
	type PTCP_ESTATS_REC_RW_v0 as _TCP_ESTATS_REC_RW_v0 ptr

	type _TCP_ESTATS_SEND_BUFF_ROD_v0
		CurRetxQueue as SIZE_T_
		MaxRetxQueue as SIZE_T_
		CurAppWQueue as SIZE_T_
		MaxAppWQueue as SIZE_T_
	end type

	type TCP_ESTATS_SEND_BUFF_ROD_v0 as _TCP_ESTATS_SEND_BUFF_ROD_v0
	type PTCP_ESTATS_SEND_BUFF_ROD_v0 as _TCP_ESTATS_SEND_BUFF_ROD_v0 ptr

	type _TCP_ESTATS_SEND_BUFF_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_SEND_BUFF_RW_v0 as _TCP_ESTATS_SEND_BUFF_RW_v0
	type PTCP_ESTATS_SEND_BUFF_RW_v0 as _TCP_ESTATS_SEND_BUFF_RW_v0 ptr

	type _TCP_ESTATS_SND_CONG_ROD_v0
		SndLimTransRwin as ULONG
		SndLimTimeRwin as ULONG
		SndLimBytesRwin as SIZE_T_
		SndLimTransCwnd as ULONG
		SndLimTimeCwnd as ULONG
		SndLimBytesCwnd as SIZE_T_
		SndLimTransSnd as ULONG
		SndLimTimeSnd as ULONG
		SndLimBytesSnd as SIZE_T_
		SlowStart as ULONG
		CongAvoid as ULONG
		OtherReductions as ULONG
		CurCwnd as ULONG
		MaxSsCwnd as ULONG
		MaxCaCwnd as ULONG
		CurSsthresh as ULONG
		MaxSsthresh as ULONG
		MinSsthresh as ULONG
	end type

	type TCP_ESTATS_SND_CONG_ROD_v0 as _TCP_ESTATS_SND_CONG_ROD_v0
	type PTCP_ESTATS_SND_CONG_ROD_v0 as _TCP_ESTATS_SND_CONG_ROD_v0 ptr

	type _TCP_ESTATS_SND_CONG_ROS_v0
		LimCwnd as ULONG
	end type

	type TCP_ESTATS_SND_CONG_ROS_v0 as _TCP_ESTATS_SND_CONG_ROS_v0
	type PTCP_ESTATS_SND_CONG_ROS_v0 as _TCP_ESTATS_SND_CONG_ROS_v0 ptr

	type _TCP_ESTATS_SND_CONG_RW_v0
		EnableCollection as WINBOOLEAN
	end type

	type TCP_ESTATS_SND_CONG_RW_v0 as _TCP_ESTATS_SND_CONG_RW_v0
	type PTCP_ESTATS_SND_CONG_RW_v0 as _TCP_ESTATS_SND_CONG_RW_v0 ptr

	type _TCP_ESTATS_SYN_OPTS_ROS_v0
		ActiveOpen as WINBOOLEAN
		MssRcvd as ULONG
		MssSent as ULONG
	end type

	type TCP_ESTATS_SYN_OPTS_ROS_v0 as _TCP_ESTATS_SYN_OPTS_ROS_v0
	type PTCP_ESTATS_SYN_OPTS_ROS_v0 as _TCP_ESTATS_SYN_OPTS_ROS_v0 ptr

	type _TCP_ESTATS_TYPE as long
	enum
		TcpConnectionEstatsSynOpts
		TcpConnectionEstatsData
		TcpConnectionEstatsSndCong
		TcpConnectionEstatsPath
		TcpConnectionEstatsSendBuff
		TcpConnectionEstatsRec
		TcpConnectionEstatsObsRec
		TcpConnectionEstatsBandwidth
		TcpConnectionEstatsFineRtt
		TcpConnectionEstatsMaximum
	end enum

	type TCP_ESTATS_TYPE as _TCP_ESTATS_TYPE
#endif
