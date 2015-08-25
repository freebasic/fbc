'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _DLGSH_INCLUDED_
const ctlFirst = &h0400
const ctlLast = &h04ff
const psh1 = &h0400
const psh2 = &h0401
const psh3 = &h0402
const psh4 = &h0403
const psh5 = &h0404
const psh6 = &h0405
const psh7 = &h0406
const psh8 = &h0407
const psh9 = &h0408
const psh10 = &h0409
const psh11 = &h040a
const psh12 = &h040b
const psh13 = &h040c
const psh14 = &h040d
const psh15 = &h040e
const pshHelp = psh15
const psh16 = &h040f
const chx1 = &h0410
const chx2 = &h0411
const chx3 = &h0412
const chx4 = &h0413
const chx5 = &h0414
const chx6 = &h0415
const chx7 = &h0416
const chx8 = &h0417
const chx9 = &h0418
const chx10 = &h0419
const chx11 = &h041a
const chx12 = &h041b
const chx13 = &h041c
const chx14 = &h041d
const chx15 = &h041e
const chx16 = &h041f
const rad1 = &h0420
const rad2 = &h0421
const rad3 = &h0422
const rad4 = &h0423
const rad5 = &h0424
const rad6 = &h0425
const rad7 = &h0426
const rad8 = &h0427
const rad9 = &h0428
const rad10 = &h0429
const rad11 = &h042a
const rad12 = &h042b
const rad13 = &h042c
const rad14 = &h042d
const rad15 = &h042e
const rad16 = &h042f
const grp1 = &h0430
const grp2 = &h0431
const grp3 = &h0432
const grp4 = &h0433
const frm1 = &h0434
const frm2 = &h0435
const frm3 = &h0436
const frm4 = &h0437
const rct1 = &h0438
const rct2 = &h0439
const rct3 = &h043a
const rct4 = &h043b
const ico1 = &h043c
const ico2 = &h043d
const ico3 = &h043e
const ico4 = &h043f
const stc1 = &h0440
const stc2 = &h0441
const stc3 = &h0442
const stc4 = &h0443
const stc5 = &h0444
const stc6 = &h0445
const stc7 = &h0446
const stc8 = &h0447
const stc9 = &h0448
const stc10 = &h0449
const stc11 = &h044a
const stc12 = &h044b
const stc13 = &h044c
const stc14 = &h044d
const stc15 = &h044e
const stc16 = &h044f
const stc17 = &h0450
const stc18 = &h0451
const stc19 = &h0452
const stc20 = &h0453
const stc21 = &h0454
const stc22 = &h0455
const stc23 = &h0456
const stc24 = &h0457
const stc25 = &h0458
const stc26 = &h0459
const stc27 = &h045a
const stc28 = &h045b
const stc29 = &h045c
const stc30 = &h045d
const stc31 = &h045e
const stc32 = &h045f
const lst1 = &h0460
const lst2 = &h0461
const lst3 = &h0462
const lst4 = &h0463
const lst5 = &h0464
const lst6 = &h0465
const lst7 = &h0466
const lst8 = &h0467
const lst9 = &h0468
const lst10 = &h0469
const lst11 = &h046a
const lst12 = &h046b
const lst13 = &h046c
const lst14 = &h046d
const lst15 = &h046e
const lst16 = &h046f
const cmb1 = &h0470
const cmb2 = &h0471
const cmb3 = &h0472
const cmb4 = &h0473
const cmb5 = &h0474
const cmb6 = &h0475
const cmb7 = &h0476
const cmb8 = &h0477
const cmb9 = &h0478
const cmb10 = &h0479
const cmb11 = &h047a
const cmb12 = &h047b
const cmb13 = &h047c
const cmb14 = &h047d
const cmb15 = &h047e
const cmb16 = &h047f
const edt1 = &h0480
const edt2 = &h0481
const edt3 = &h0482
const edt4 = &h0483
const edt5 = &h0484
const edt6 = &h0485
const edt7 = &h0486
const edt8 = &h0487
const edt9 = &h0488
const edt10 = &h0489
const edt11 = &h048a
const edt12 = &h048b
const edt13 = &h048c
const edt14 = &h048d
const edt15 = &h048e
const edt16 = &h048f
const scr1 = &h0490
const scr2 = &h0491
const scr3 = &h0492
const scr4 = &h0493
const scr5 = &h0494
const scr6 = &h0495
const scr7 = &h0496
const scr8 = &h0497
const ctl1 = &h04A0
const FILEOPENORD = 1536
const MULTIFILEOPENORD = 1537
const PRINTDLGORD = 1538
const PRNSETUPDLGORD = 1539
const FINDDLGORD = 1540
const REPLACEDLGORD = 1541
const FONTDLGORD = 1542
const FORMATDLGORD31 = 1543
const FORMATDLGORD30 = 1544
const RUNDLGORD = 1545
const PAGESETUPDLGORD = 1546
const NEWFILEOPENORD = 1547
const PRINTDLGEXORD = 1549
const PAGESETUPDLGORDMOTIF = 1550
const COLORMGMTDLGORD = 1551
const NEWFILEOPENV2ORD = 1552

type tagCRGB
	bRed as UBYTE
	bGreen as UBYTE
	bBlue as UBYTE
	bExtra as UBYTE
end type

type CRGB as tagCRGB
