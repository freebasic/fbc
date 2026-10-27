'' FreeBASIC binding for sokol_time
''
'' Generated with fbfrog from sokol_time.h; do not edit by hand.
'' Pinned source: sokol 79611ab0d5e9 (2024-05-11), sokol_time.h
'' sha256 0eeb8c1bc9ac2ec4438090f68e2ab0eb85d1daf10643158dec11383a8e8b1872
''
'' Regenerate:
''   fbfrog sokol_time.h -o sokol_time.bi \
''       -fbfroginclude stdbool.h -removeinclude stdbool.h
''
'' sokol is header-only: the application compiles the implementation
'' itself (see examples/graphics/sokol/README.txt).  There is no
'' sokol library to link against, so this binding emits no #inclib.

#pragma once

#include once "crt/stdint.bi"

extern "C"

const SOKOL_TIME_INCLUDED = 1
'' TODO: #define SOKOL_TIME_API_DECL extern
declare sub stm_setup()
declare function stm_now() as ulongint
declare function stm_diff(byval new_ticks as ulongint, byval old_ticks as ulongint) as ulongint
declare function stm_since(byval start_ticks as ulongint) as ulongint
declare function stm_laptime(byval last_time as ulongint ptr) as ulongint
declare function stm_round_to_common_refresh_rate(byval frame_ticks as ulongint) as ulongint
declare function stm_sec(byval ticks as ulongint) as double
declare function stm_ms(byval ticks as ulongint) as double
declare function stm_us(byval ticks as ulongint) as double
declare function stm_ns(byval ticks as ulongint) as double

end extern
