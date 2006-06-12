#ifndef __FILE_BI__
#define __FILE_BI__

#ifdef __FB_MT__
# if __FB_MT__
#  inclib "fbxmt"
# else
#  inclib "fbx"
# endif
#else
# inclib "fbx"
#endif

declare function FileCopy        alias "fb_FileCopy" _
          ( source as string, _
            destination as string ) as integer

#endif
