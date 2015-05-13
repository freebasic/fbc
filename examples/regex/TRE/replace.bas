'' PHP-like regex_replace() function, by MisterD

#include "regex.bi"

#ifndef regexmatch
#define regexmatch(match,zeile,n) mid(zeile,1+match(n).rm_so, match(n).rm_eo-match(n).rm_so)
#endif

function regex_replace(byref regex as string, byref replace_pattern as string, byref subject as string) as string
    dim replaced as string, rest as string
    rest=subject
    dim re as regex_t
    if regcomp( @re, regex, REG_EXTENDED or REG_ICASE )<>0 then return ""
    dim match(re.re_nsub) as regmatch_t, n as integer
    while regexec( @re, strptr(rest), re.re_nsub+1, @match(0), 0 )=0
        replaced+=left(rest,match(0).rm_so)
        for n = 1 to len(replace_pattern)
            if mid(replace_pattern,n,1) = "" and _
               mid(replace_pattern,n-1,1)<>"\" and _
               val(mid(replace_pattern,n+1,1)) > 0 and _
               val(mid(replace_pattern,n+1,1)) <= re.re_nsub _
            then
                replaced+=regexmatch(match,rest,val(mid(replace_pattern,n+1,1)))
                n+=1
            else
                replaced+=mid(replace_pattern,n,1)
            end if
        next n
        if match(0).rm_eo=len(rest) then return replaced
        rest=mid(rest,match(0).rm_eo+1)
    wend
    return replaced+rest
end function

print regex_replace("-(.+?)-", "*1*", "Hi -you- strange -user- :D")
