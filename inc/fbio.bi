#pragma once

'' IsRedirected(FALSE) = check stdout
'' IsRedirected(TRUE) = check stdin
declare function IsRedirected alias "fb_IsRedirected"(byval is_input as long = 0) as long
