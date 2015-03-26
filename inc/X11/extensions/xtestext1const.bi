#pragma once

const _XTESTEXT1CONST_H = 1
const XTestMAX_ACTION_LIST_SIZE = 64
const XTestACTIONS_SIZE = 28
const XTestPRESS = 1 shl 0
const XTestRELEASE = 1 shl 1
const XTestSTROKE = 1 shl 2
const XTestSTROKE_DELAY_TIME = 10
const XTestEXCLUSIVE = 1 shl 0
const XTestPACKED_ACTIONS = 1 shl 1
const XTestPACKED_MOTION = 1 shl 2
const XTestFAKE_ACK_NOT_NEEDED = 0
const XTestFAKE_ACK_REQUEST = 1
#define XTestEXTENSION_NAME "XTestExtension1"
const XTestEVENT_COUNT = 2
const XTestACTION_TYPE_MASK = &h03
const XTestKEY_STATE_MASK = &h04
const XTestX_SIGN_BIT_MASK = &h04
const XTestY_SIGN_BIT_MASK = &h08
const XTestDEVICE_ID_MASK = &hf0
const XTestMAX_DEVICE_ID = &h0f
#define XTestPackDeviceID(x) (((x) and XTestMAX_DEVICE_ID) shl 4)
#define XTestUnpackDeviceID(x) (((x) and XTestDEVICE_ID_MASK) shr 4)
const XTestDELAY_ACTION = 0
const XTestKEY_ACTION = 1
const XTestMOTION_ACTION = 2
const XTestJUMP_ACTION = 3
const XTestKEY_UP = &h04
const XTestKEY_DOWN = &h00
const XTestMOTION_MAX = 15
const XTestMOTION_MIN = -15
const XTestX_NEGATIVE = &h04
const XTestY_NEGATIVE = &h08
const XTestX_MOTION_MASK = &h0f
const XTestY_MOTION_MASK = &hf0
#define XTestPackXMotionValue(x) ((x) and XTestX_MOTION_MASK)
#define XTestPackYMotionValue(x) (((x) shl 4) and XTestY_MOTION_MASK)
#define XTestUnpackXMotionValue(x) ((x) and XTestX_MOTION_MASK)
#define XTestUnpackYMotionValue(x) (((x) and XTestY_MOTION_MASK) shr 4)
const XTestSHORT_DELAY_TIME = &hffff
const XTestDELAY_DEVICE_ID = &h0f
