/* error message buffer shared by fb_Die() and fb_Assert() functions */

#include "fb.h"

char __fb_errmsg[FB_ERRMSG_SIZE] = "";
