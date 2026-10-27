'' FreeBASIC binding for sokol_log
''
'' Generated with fbfrog from sokol_log.h; do not edit by hand.
'' Pinned source: sokol 79611ab0d5e9 (2024-05-11), sokol_log.h
'' sha256 008999c5cd000adfbce47866423b751180ca24d2acf00db81d842747aad88152
''
'' Regenerate:
''   fbfrog sokol_log.h -o sokol_log.bi \
''       -fbfroginclude stdbool.h -removeinclude stdbool.h
''
'' sokol is header-only: the application compiles the implementation
'' itself (see examples/graphics/sokol/README.txt).  There is no
'' sokol library to link against, so this binding emits no #inclib.

#pragma once

#include once "crt/stdint.bi"

extern "C"

const SOKOL_LOG_INCLUDED = 1
'' TODO: #define SOKOL_LOG_API_DECL extern
declare sub slog_func(byval tag as const zstring ptr, byval log_level as ulong, byval log_item as ulong, byval message as const zstring ptr, byval line_nr as ulong, byval filename as const zstring ptr, byval user_data as any ptr)

end extern
