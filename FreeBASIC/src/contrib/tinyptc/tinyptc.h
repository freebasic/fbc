//
// TinyPTC by Gaffer
// www.gaffer.org/tinyptc
//

#ifndef __TINYPTC_H__
#define __TINYPTC_H__

#define HAVE_CONFIG_H 1
#include "../../rtlib/fb.h"
#include "../../gfxlib2/fb_gfx.h"

#ifdef DRIVER_LOCK
#undef DRIVER_LOCK
#define DRIVER_LOCK()
#endif

#ifdef DRIVER_UNLOCK
#undef DRIVER_UNLOCK
#define DRIVER_UNLOCK()
#endif

#if defined(TARGET_WIN32) || defined(TARGET_XBOX)
#include "win32/tinyptc_win32.h"
#elif defined(TARGET_DOS)
#include "dos/tinyptc_dos.h"
#elif defined(TARGET_LINUX) || defined(TARGET_CYGWIN)
#include "linux/tinyptc_linux.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

// tinyptc api
extern int ptc_open(char *title,int width,int height);
extern int ptc_update(void *buffer);
extern void ptc_close();

void fb_hTinyPtcPostKey(int key);
void fb_hTinyPtcPostKey_End(void);
int fb_TinyPtcGetkey(void);
int fb_TinyPtcKeyHit(void);
FBSTRING *fb_TinyPtcInkey(void);

#ifdef __cplusplus
}
#endif

#endif
