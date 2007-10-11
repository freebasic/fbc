#ifndef __DIR_BI__
#define __DIR_BI__

#define fbReadOnly		&h01
#define fbHidden		&h02
#define fbSystem		&h04
#define fbDirectory		&h10
#define fbArchive		&h20
#define fbNormal		(fbReadOnly or fbArchive)

#endif