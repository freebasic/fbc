''
''
'' audevcod -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_audevcod_bi__
#define __win_audevcod_bi__

#define EC_SND_DEVICE_ERROR_BASE &h0200

enum SNDDEV_ERR
	SNDDEV_ERROR_Open = 1
	SNDDEV_ERROR_Close = 2
	SNDDEV_ERROR_GetCaps = 3
	SNDDEV_ERROR_PrepareHeader = 4
	SNDDEV_ERROR_UnprepareHeader = 5
	SNDDEV_ERROR_Reset = 6
	SNDDEV_ERROR_Restart = 7
	SNDDEV_ERROR_GetPosition = 8
	SNDDEV_ERROR_Write = 9
	SNDDEV_ERROR_Pause = 10
	SNDDEV_ERROR_Stop = 11
	SNDDEV_ERROR_Start = 12
	SNDDEV_ERROR_AddBuffer = 13
	SNDDEV_ERROR_Query = 14
end enum

#define EC_SNDDEV_IN_ERROR (&h0200+&h00)
#define EC_SNDDEV_OUT_ERROR (&h0200+&h01)

#endif
