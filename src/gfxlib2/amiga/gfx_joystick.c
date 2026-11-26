/* AmigaOS joystick via lowlevel.library */
#include "../fb_gfx.h"

#if defined(HOST_AMIGAOS)
#include <proto/exec.h>
#include <proto/lowlevel.h>
#include <libraries/lowlevel.h>

extern struct ExecBase *SysBase;
struct Library *LowLevelBase;

FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3,
                      float *a4, float *a5, float *a6, float *a7, float *a8) {
    if (id < 0 || id > 1) {
        *buttons = 0; *a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = 0.0f;
        return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    }

    if (!LowLevelBase) {
        LowLevelBase = OpenLibrary("lowlevel.library", 40);
        if (!LowLevelBase) {
            *buttons = 0; *a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = 0.0f;
            return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        }
    }

    ULONG state = ReadJoyPort(id);

    /* Buttons */
    *buttons = 0;
    if (state & JPF_BUTTON_RED)   *buttons |= 1;
    if (state & JPF_BUTTON_BLUE)  *buttons |= 2;
    if (state & JPF_BUTTON_GREEN) *buttons |= 4;

    /* Axes: digital joystick mapped to -1/0/+1 */
    *a1 = 0.0f; *a2 = 0.0f;
    if (state & JPF_JOY_LEFT)  *a1 = -1.0f;
    if (state & JPF_JOY_RIGHT) *a1 =  1.0f;
    if (state & JPF_JOY_UP)    *a2 = -1.0f;
    if (state & JPF_JOY_DOWN)  *a2 =  1.0f;

    /* Unused axes */
    *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = 0.0f;

    return fb_ErrorSetNum(FB_RTERROR_OK);
}

#else
/* AROS/MorphOS - stub */
FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3,
                      float *a4, float *a5, float *a6, float *a7, float *a8) {
    if (buttons) *buttons = -1;
    if (a1) *a1 = -1000.0f;
    if (a2) *a2 = -1000.0f;
    if (a3) *a3 = -1000.0f;
    if (a4) *a4 = -1000.0f;
    if (a5) *a5 = -1000.0f;
    if (a6) *a6 = -1000.0f;
    if (a7) *a7 = -1000.0f;
    if (a8) *a8 = -1000.0f;
    return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
#endif

void fb_GfxJoystickExit(void) {
#if defined(HOST_AMIGAOS)
    if (LowLevelBase) { CloseLibrary(LowLevelBase); LowLevelBase = NULL; }
#endif
}
