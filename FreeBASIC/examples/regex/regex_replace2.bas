#include "regex.bi"
 
declare function regex_replace( byval pattern as string, byval replacement as string, byval subject as string) as string
 
print regex_replace( "_(.*?)(\.)?_", "*$1*$2", "FreeBASIC is _free_ and _open-source._" )
'' should output "FreeBASIC is *free* and *open-source*."
print regex_replace( "([0-9]) dollars", "$$$1", "FreeBASIC costs 0 dollars." )
'' should output "FreeBASIC costs $0."
 
function regex_replace( byval pattern as string, byval replacement as string, byval subject as string) as string
  if len(subject) = 0 then return ""
 
  dim as regex_t re
  dim as string replaced, rest = subject
 
  '' compile the pattern
  if regcomp( @re, pattern, REG_EXTENDED or REG_ICASE ) then return ""
 
  dim match( re.re_nsub ) as regmatch_t, n as integer
 
  do while regexec( @re, strptr(rest), re.re_nsub + 1, @match( 0 ), 0 ) = 0
    replaced += left(rest, match( 0 ).rm_so)
    for n = 1 to len(replacement)
      if mid(replacement, n, 1) = "$" then
        dim as integer r = val(mid(replacement, n + 1, 1))
        if mid(replacement, n + 1, 1) = "$" then
          replaced += "$"
          n += 1
        elseif r > 0 and r <= re.re_nsub then
          replaced += mid(rest, 1 + match( r ).rm_so, match( r ).rm_eo-match(r).rm_so)
          n += 1
        else
          replaced += "$"
        end if
      else
        replaced += mid(replacement, n, 1)
      end if
    next n
    if match( 0 ).rm_eo = len(rest) then return replaced
    rest = mid(rest, match( 0 ).rm_eo + 1)
  loop
 
  '' free the context
  regfree( @re )
 
  return replaced & rest
end function
