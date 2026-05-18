#include "../fb.h"

#ifdef HOST_AMIGAOS
#include <proto/exec.h>
extern struct ExecBase *SysBase;
#endif

FBCALL size_t fb_GetMemAvail(int mode) {
#ifdef HOST_AMIGAOS
    /* mode: 0=largest contiguous block, 1=largest block, 2=total free */
    if (mode == 1) return (size_t)AvailMem(MEMF_ANY | MEMF_LARGEST);
    if (mode == 0) return (size_t)AvailMem(MEMF_ANY | MEMF_LARGEST);
    return (size_t)AvailMem(MEMF_ANY); /* mode 2: total free */
#else
    return 0;
#endif
}
