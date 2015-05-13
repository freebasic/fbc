#Ifndef XMP_BI
#define XMP_BI

#Inclib "xmp"

Extern "C"

#define XMP_VERSION "4.0.4"
#define XMP_VERCODE &h040004
#define XMP_VER_MAJOR 4
#define XMP_VER_MINOR 0
#define XMP_VER_RELEASE 4

#define XMP_NAME_SIZE		64	'/* Size of module name and type */

#define XMP_KEY_OFF		&h81	'/* Note number for key off event */
#define XMP_KEY_CUT		&h82	'/* Note number for key cut event */
#define XMP_KEY_FADE		&h83	'/* Note number for fade event */

'/* mixer parameter macros */

'/* sample format flags */
#define XMP_FORMAT_8BIT		(1 Shl 0) '/* Mix to 8-bit instead of 16 */
#define XMP_FORMAT_UNSIGNED	(1 Shl 1) '/* Mix to unsigned samples */
#define XMP_FORMAT_MONO		(1 Shl 2) '/* Mix to mono instead of stereo */

'/* mixer paramters for xmp_set_player() */
#define XMP_PLAYER_AMP		0	'/* Amplification factor */
#define XMP_PLAYER_MIX		1	'/* Stereo mixing */
#define XMP_PLAYER_INTERP	2	'/* Interpolation type */
#define XMP_PLAYER_DSP		3	'/* DSP effect flags */
#define XMP_PLAYER_FLAGS	4	'/* Player flags */

'/* interpolation types */
#define XMP_INTERP_NEAREST	0	'/* Nearest neighbor */
#define XMP_INTERP_LINEAR	1	'/* Linear (default) */
#define XMP_INTERP_SPLINE	2	'/* Cubic spline */

'/* dsp effect types */
#define XMP_DSP_LOWPASS		(1 Shl 0) '/* Lowpass filter effect */
#define XMP_DSP_ALL		XMP_DSP_LOWPASS

'/* player flags */
#define XMP_FLAGS_VBLANK	(1 Shl 0) '/* Use vblank timing */
#define XMP_FLAGS_FX9BUG	(1 Shl 1) '/* Emulate FX9 bug */
#define XMP_FLAGS_FIXLOOP	(1 Shl 2) '/* Emulate sample loop bug */

'/* limits */
#define XMP_MAX_KEYS		121	'/* Number of valid keys */
#define XMP_MAX_ENV_POINTS	32	'/* Max number of envelope points */
#define XMP_MAX_MOD_LENGTH	256	'/* Max number of patterns in module */
#define XMP_MAX_CHANNELS	64	'/* Max number of channels in module */
#define XMP_MAX_SRATE		48000	'/* max sampling rate (Hz) */
#define XMP_MIN_BPM		20	'/* min BPM */
'/* frame rate = (50 * bpm / 125) Hz */
'/* frame size = (sampling rate * channels * size) / frame rate */
#define XMP_MAX_FRAMESIZE	(5 * XMP_MAX_SRATE * 2 / XMP_MIN_BPM)

'/* error codes */
#define XMP_END			1
#define XMP_ERROR_INTERNAL	2	'/* Internal error */
#define XMP_ERROR_FORMAT	3	'/* Unsupported module format */
#define XMP_ERROR_LOAD		4	'/* Error loading file */
#define XMP_ERROR_DEPACK	5	'/* Error depacking file */
#define XMP_ERROR_SYSTEM	6	'/* System error */
#define XMP_ERROR_INVALID	7	'/* Invalid parameter */

Type xmp_channel
	pan As Integer			'/* Channel pan (0x80 is center) */
	vol As Integer			'/* Channel volume */
	#define XMP_CHANNEL_SYNTH	(1 Shl 0)  '/* Channel is synthesized */
	#define XMP_CHANNEL_MUTE_  	(1 Shl 1)  '/* Channel is muted */
	flg As Integer			'/* Channel flags */
End Type

Type xmp_pattern
	rows As Integer			'/* Number of rows */
	index(0) As Integer			'/* Track index */
End Type

Type xmp_event
	note As UByte		'/* Note number (0 means no note) */
	ins As UByte		'/* Patch number */
	vol As UByte	'/* Volume (0 to basevol) */
	fxt As UByte		'/* Effect type */
	fxp As UByte		'/* Effect parameter */
	f2t As UByte		'/* Secondary effect type */
	f2p As UByte	'/* Secondary effect parameter */
	_flag As UByte		'/* Internal (reserved) flags */
End Type

Type xmp_track
	rows As Integer			'/* Number of rows */
	As xmp_event event(0)	'/* Event data */
End Type

Type xmp_envelope
	#define XMP_ENVELOPE_ON		(1 Shl 0)  '/* Envelope is enabled */
	#define XMP_ENVELOPE_SUS	(1 Shl 1)  '/* Envelope has sustain point */
	#define XMP_ENVELOPE_LOOP	(1 Shl 2)  '/* Envelope has loop */
	#define XMP_ENVELOPE_FLT	(1 Shl 3)  '/* Envelope is used for filter */
	#define XMP_ENVELOPE_SLOOP	(1 Shl 4)  '/* Envelope has sustain loop */
	#define XMP_ENVELOPE_CARRY	(1 Shl 5)  '/* Don't reset envelope position */
	flg As Integer			'/* Flags */
	npt As Integer			'/* Number of envelope points */
	scl As Integer			'/* Envelope scaling */
	sus As Integer			'/* Sustain start point */
	sue As Integer			'/* Sustain end point */
	lps As Integer			'/* Loop start point */
	lpe As Integer			'/* Loop end point */
	Data(XMP_MAX_ENV_POINTS * 2-1) As Short
End Type

Type xmp_subinstrument

	As Integer vol'		/* Default volume */
	As Integer gvl'		/* Global volume */
	As Integer pan'		/* Pan */
	As Integer xpo'		/* Transpose */
	As Integer fin'		/* Finetune */
	As Integer vwf'		/* Vibrato waveform */
	As Integer vde'		/* Vibrato depth */
	As Integer vra'		/* Vibrato rate */
	As Integer vsw'		/* Vibrato sweep */
	As Integer rvv'		/* Random volume variation (IT) */
	As Integer sid'		/* Sample number */
	#define XMP_INST_NNA_CUT	&h00
	#define XMP_INST_NNA_CONT	&h01
	#define XMP_INST_NNA_OFF	&h02
	#define XMP_INST_NNA_FADE	&h03
	As Integer nna'		/* New note action */
	#define XMP_INST_DCT_OFF	&h00
	#define XMP_INST_DCT_NOTE	&h01
	#define XMP_INST_DCT_SMP	&h02
	#define XMP_INST_DCT_INST	&h03
	As Integer dct'		/* Duplicate check type */
	#define XMP_INST_DCA_CUT	XMP_INST_NNA_CUT
	#define XMP_INST_DCA_OFF	XMP_INST_NNA_OFF
	#define XMP_INST_DCA_FADE	XMP_INST_NNA_FADE
	As Integer dca'		/* Duplicate check action */
	As Integer ifc'		/* Initial filter cutoff */
	As Integer ifr'		/* Initial filter resonance */

End Type
Type xmp_instrumentad
	ins As UByte
	xpo As Byte
End Type
Type xmp_instrument
	As ZString*32 Name'			/* Instrument name */
	As Integer vol'			/* Instrument volume */
	As Integer nsm'			/* Number of samples */
	As Integer rls'			/* Release (fadeout) */
	aei As xmp_envelope '	/* Amplitude envelope info */
	pei As xmp_envelope '	/* Pan envelope info */
	fei As xmp_envelope '	/* Frequency envelope info */

	As xmp_subinstrument Ptr sub_
	As xmp_instrumentad map(XMP_MAX_KEYS-1)


	As Any Ptr extra'			/* Extra fields */
End Type

Type xmp_sample
	As ZString*32 Name'			/* Sample name */
	As Integer Len'			/* Sample length */
	As Integer lps'			/* Loop start */
	As Integer lpe'			/* Loop end */
	#define XMP_SAMPLE_16BIT	(1 Shl 0)  '/* 16bit sample */
	#define XMP_SAMPLE_LOOP		(1 Shl 1)  '/* Sample is looped */
	#define XMP_SAMPLE_LOOP_BIDIR	(1 Shl 2)  '/* Bidirectional sample loop */
	#define XMP_SAMPLE_LOOP_REVERSE	(1 Shl 3)  '/* Backwards sample loop */
	#define XMP_SAMPLE_LOOP_FULL	(1 Shl 4)  '/* Play full sample before looping */
	#define XMP_SAMPLE_SYNTH	(1 Shl 15) '/* Data contains synth patch */
	As Integer flg'			/* Flags */
	As UByte Ptr Data'		/* Sample data */
End Type

Type xmp_sequence
	As Integer entry_point
	As Integer duration
End Type

Type xmp_module
	As ZString*XMP_NAME_SIZE Name'	/* Module title */
	As ZString*XMP_NAME_SIZE Type'	/* Module format */
	As Integer pat'			/* Number of patterns */
	As Integer trk'			/* Number of tracks */
	As Integer chn'			/* Tracks per pattern */
	As Integer ins'			/* Number of instruments */
	As Integer smp'			/* Number of samples */
	As Integer spd'			/* Initial speed */
	As Integer bpm'			/* Initial BPM */
	As Integer Len'			/* Module length in patterns */
	As Integer rst'			/* Restart position */
	As Integer gvl'			/* Global volume */

	As xmp_pattern Ptr Ptr xxp'	/* Patterns */
	As xmp_track Ptr Ptr xxt'		/* Tracks */
	As xmp_instrument Ptr xxi'	/* Instruments */
	As xmp_sample Ptr xxs'		/* Samples */
	As xmp_channel xxc(64)'	/* Channel info */
	As ZString*XMP_MAX_MOD_LENGTH xxo'	/* Orders */
End Type

Type xmp_test_info
	As ZString*XMP_NAME_SIZE Name'	/* Module title */
	As ZString*XMP_NAME_SIZE Type'	/* Module format */
End Type

#define XMP_PERIOD_BASE	6847		'/* C4 period */

Type xmp_module_info
	As ZString*16 md5'		/* MD5 message digest */
	As Integer vol_base'			/* Volume scale */
	As xmp_module Ptr Mod_'		/* Pointer to module data */
	As ZString Ptr comment'			/* Comment text, if any */
	As Integer num_sequences'		/* Number of valid sequences */
	As xmp_sequence Ptr seq_data'	/* Pointer to sequence data */
End Type

Type xmp_channel_info '/* Current channel information */
	As UInteger period'	/* Sample period */
	As UInteger position'	/* Sample position */
	As Short pitchbend'	/* Linear bend from base note*/
	As UByte note'	/* Current base note number */
	As UByte instrument' /* Current instrument number */
	As UByte sample'	/* Current sample number */
	As UByte volume'	/* Current volume */
	As UByte pan'	/* Current stereo pan */
	As UByte reserved'	/* Reserved */
	As xmp_event event'	/* Current track event */
End Type

Type xmp_frame_info '			/* Current frame information */
	As Integer Pos'			/* Current position */
	As Integer pattern'			/* Current pattern */
	As Integer row'			/* Current row in pattern */
	As Integer num_rows'			/* Number of rows in current pattern */
	As Integer frame'			/* Current frame */
	As Integer speed'			/* Current replay speed */
	As Integer bpm'			/* Current bpm */
	As Integer Time'			/* Current module time in ms */
	As Integer total_time'			/* Estimated replay time in ms*/
	As Integer frame_time'			/* Frame replay time in us */
	As Any Ptr buffer'			/* Pointer to sound buffer */
	As Integer buffer_size'		/* Used buffer size */
	As Integer total_size'			/* Total buffer size */
	As Integer volume'			/* Current master volume */
	As Integer loop_count'			/* Loop counter */
	As Integer virt_channels'		/* Number of virtual channels */
	As Integer virt_used'			/* Used virtual channels */
	As Integer sequence'			/* Current sequence */
	As xmp_channel_info channel_info(XMP_MAX_CHANNELS-1)
End Type


Type xmp_context As ZString Ptr

Declare Function xmp_create_context() As xmp_context
Declare Sub        xmp_free_context    (As xmp_context)
Declare Function         xmp_test_module     (As ZString Ptr, As xmp_test_info Ptr)As Integer
Declare Function         xmp_load_module     (As xmp_context, As ZString Ptr)As Integer
Declare Sub        xmp_scan_module     (As xmp_context)
Declare Sub        xmp_release_module  (As xmp_context)
Declare Function         xmp_start_player    (As xmp_context, As Integer, As Integer)As Integer
Declare Function         xmp_play_frame      (As xmp_context)As Integer
Declare Sub        xmp_get_frame_info  (As xmp_context, As xmp_frame_info Ptr)
Declare Sub        xmp_end_player      (As xmp_context)
Declare Sub        xmp_inject_event    (As xmp_context, As Integer, As xmp_event Ptr)
Declare Sub        xmp_get_module_info (As xmp_context, As xmp_module_info Ptr)
Declare Function   xmp_get_format_list () As ZString Ptr Ptr
Declare Function         xmp_next_position   (As xmp_context)As Integer
Declare Function         xmp_prev_position   (As xmp_context)As Integer
Declare Function         xmp_set_position    (As xmp_context, As Integer)As Integer
Declare Sub        xmp_stop_module     (As xmp_context)
Declare Sub        xmp_restart_module  (As xmp_context)
Declare Function         xmp_seek_time       (As xmp_context, As Integer)As Integer
Declare Function         xmp_channel_mute    (As xmp_context, As Integer,As Integer)As Integer
Declare Function         xmp_channel_vol     (As xmp_context, As Integer, As Integer)As Integer
Declare Function         xmp_set_player      (As xmp_context, As Integer, As Integer)As Integer
Declare Function         xmp_get_player      (As xmp_context,As Integer)As Integer
Declare Function         xmp_set_instrument_path (As xmp_context, As ZString Ptr)As Integer

End Extern
#EndIf	'/* XMP_BI */
