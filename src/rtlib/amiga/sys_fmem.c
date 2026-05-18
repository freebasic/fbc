#include "../fb.h"

#ifdef HOST_AMIGAOS
#include <proto/exec.h>
extern struct ExecBase *SysBase;
#endif

FBCALL size_t fb_GetMemAvail(int mode) {
#ifdef HOST_AMIGAOS
    /* FB FRE: mode 0 = largest free block, mode 2 = total free memory */
    if (mode == 0 || mode == 1)
        return (size_t)AvailMem(MEMF_ANY | MEMF_LARGEST);
    return (size_t)AvailMem(MEMF_ANY); /* total free */
#else
    return 0;
#endif
}
