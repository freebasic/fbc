//
// TinyPTC by Gaffer
// www.gaffer.org/tinyptc
//

#ifndef __TINYPTC_WINDOWS_H__
#define __TINYPTC_WINDOWS_H__


// integer types
typedef unsigned int          int32;
typedef unsigned short        int16;
typedef unsigned short        short16;
typedef unsigned char         char8;

// tinyptc api
extern int ptc_open(char *title,int width,int height);
extern int ptc_update(void *buffer);
extern void ptc_close();

// display target
#define __PTC_DDRAW__
//#define __PTC_GDI__
//#define __PTC_VFW__

// configuration
#ifdef PTC_USE_WINDOW
#  define __PTC_WINDOWED__
#endif

#define __PTC_CENTER_WINDOW__
/* #define __PTC_RESIZE_WINDOW__ */
/* #define __PTC_SYSTEM_MENU__ */
/* #define __PTC_ICON__ "IDI_MAIN" */
/* #define __PTC_ALLOW_CLOSE__ */
/* #define __PTC_CLOSE_ON_ESCAPE__ */
#define __PTC_DISABLE_SCREENSAVER__

// converter configuration
#define __PTC_CONVERTER_32_TO_32_RGB888
#define __PTC_CONVERTER_32_TO_32_BGR888
#define __PTC_CONVERTER_32_TO_24_RGB888
#define __PTC_CONVERTER_32_TO_24_BGR888
#define __PTC_CONVERTER_32_TO_16_RGB565
#define __PTC_CONVERTER_32_TO_16_BGR565
#define __PTC_CONVERTER_32_TO_16_RGB555
#define __PTC_CONVERTER_32_TO_16_BGR555

// endian configuration
#define __PTC_LITTLE_ENDIAN__

// optimization
#define __PTC_MMX__
#define __PTC_MEMCPY__

#endif
