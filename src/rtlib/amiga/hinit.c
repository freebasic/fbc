/* libfb init/end for AmigaOS - DOSBase opened by startup.s */
#include "../fb.h"

void fb_hInit(void) { }
void fb_hEnd(int errlevel) {
    (void)errlevel;
#if defined(HOST_AMIGAOS)
    extern void fb_hIntlExit(void);
    fb_hIntlExit();
#endif
}

#if defined(HOST_AMIGAOS)
#include <proto/exec.h>
#include <proto/intuition.h>
extern struct ExecBase *SysBase;
#endif

FBCALL void fb_Beep(void) {
#if defined(HOST_AMIGAOS)
    /* Open intuition.library transiently for DisplayBeep */
    struct IntuitionBase *ib = (struct IntuitionBase *)OpenLibrary("intuition.library", 36);
    if (ib) {
        DisplayBeep(NULL);
        CloseLibrary((struct Library *)ib);
    }
#endif
}
