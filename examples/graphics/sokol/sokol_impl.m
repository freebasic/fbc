/*
 * sokol implementation for the FreeBASIC example, macOS / Metal.
 *
 * sokol is header-only: this translation unit provides the symbols that the
 * generated .bi files in inc/sokol declare.  It has to be Objective-C because
 * the Metal backends of sokol_gfx and sokol_app use Objective-C message sends.
 *
 * The program calls sapp_run() itself, so sokol_app must not hijack main():
 * SOKOL_NO_ENTRY below.
 */
#define SOKOL_NO_ENTRY
#define SOKOL_IMPL
#define SOKOL_METAL
#include "sokol_gfx.h"
#include "sokol_app.h"
#include "sokol_log.h"
