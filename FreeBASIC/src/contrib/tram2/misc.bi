declare function strReplace _
    ( _
        byref text as string, _
        byref a as string, _
        byref b as string _
    ) as string
declare sub strSplit _
    ( _
        byref s as string, _
        byref delimiter as string, _
        byref l as string, _
        byref r as string _
    )
declare function fileExists(byref file as string) as bool
