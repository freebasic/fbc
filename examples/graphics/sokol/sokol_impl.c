/*
 * sokol implementation for the FreeBASIC example, Windows / Linux.
 *
 * sokol is header-only: this translation unit provides the symbols that the
 * generated inc/sokol/*.bi files declare.  Build it as C here; macOS uses
 * sokol_impl.m instead, because the Metal backend needs Objective-C.
 *
 * The program calls sapp_run() itself, so sokol_app must not hijack main():
 * SOKOL_NO_ENTRY below.
 */
#define SOKOL_NO_ENTRY
#define SOKOL_IMPL
#if defined(_WIN32)
    #define SOKOL_D3D11
#else
    #define SOKOL_GLCORE
#endif
#include "sokol_gfx.h"
#include "sokol_app.h"
#include "sokol_log.h"
