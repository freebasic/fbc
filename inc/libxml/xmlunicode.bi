'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/xmlversion.bi"

extern "C"

#define __XML_UNICODE_H__
declare function xmlUCSIsAegeanNumbers(byval code as long) as long
declare function xmlUCSIsAlphabeticPresentationForms(byval code as long) as long
declare function xmlUCSIsArabic(byval code as long) as long
declare function xmlUCSIsArabicPresentationFormsA(byval code as long) as long
declare function xmlUCSIsArabicPresentationFormsB(byval code as long) as long
declare function xmlUCSIsArmenian(byval code as long) as long
declare function xmlUCSIsArrows(byval code as long) as long
declare function xmlUCSIsBasicLatin(byval code as long) as long
declare function xmlUCSIsBengali(byval code as long) as long
declare function xmlUCSIsBlockElements(byval code as long) as long
declare function xmlUCSIsBopomofo(byval code as long) as long
declare function xmlUCSIsBopomofoExtended(byval code as long) as long
declare function xmlUCSIsBoxDrawing(byval code as long) as long
declare function xmlUCSIsBraillePatterns(byval code as long) as long
declare function xmlUCSIsBuhid(byval code as long) as long
declare function xmlUCSIsByzantineMusicalSymbols(byval code as long) as long
declare function xmlUCSIsCJKCompatibility(byval code as long) as long
declare function xmlUCSIsCJKCompatibilityForms(byval code as long) as long
declare function xmlUCSIsCJKCompatibilityIdeographs(byval code as long) as long
declare function xmlUCSIsCJKCompatibilityIdeographsSupplement(byval code as long) as long
declare function xmlUCSIsCJKRadicalsSupplement(byval code as long) as long
declare function xmlUCSIsCJKSymbolsandPunctuation(byval code as long) as long
declare function xmlUCSIsCJKUnifiedIdeographs(byval code as long) as long
declare function xmlUCSIsCJKUnifiedIdeographsExtensionA(byval code as long) as long
declare function xmlUCSIsCJKUnifiedIdeographsExtensionB(byval code as long) as long
declare function xmlUCSIsCherokee(byval code as long) as long
declare function xmlUCSIsCombiningDiacriticalMarks(byval code as long) as long
declare function xmlUCSIsCombiningDiacriticalMarksforSymbols(byval code as long) as long
declare function xmlUCSIsCombiningHalfMarks(byval code as long) as long
declare function xmlUCSIsCombiningMarksforSymbols(byval code as long) as long
declare function xmlUCSIsControlPictures(byval code as long) as long
declare function xmlUCSIsCurrencySymbols(byval code as long) as long
declare function xmlUCSIsCypriotSyllabary(byval code as long) as long
declare function xmlUCSIsCyrillic(byval code as long) as long
declare function xmlUCSIsCyrillicSupplement(byval code as long) as long
declare function xmlUCSIsDeseret(byval code as long) as long
declare function xmlUCSIsDevanagari(byval code as long) as long
declare function xmlUCSIsDingbats(byval code as long) as long
declare function xmlUCSIsEnclosedAlphanumerics(byval code as long) as long
declare function xmlUCSIsEnclosedCJKLettersandMonths(byval code as long) as long
declare function xmlUCSIsEthiopic(byval code as long) as long
declare function xmlUCSIsGeneralPunctuation(byval code as long) as long
declare function xmlUCSIsGeometricShapes(byval code as long) as long
declare function xmlUCSIsGeorgian(byval code as long) as long
declare function xmlUCSIsGothic(byval code as long) as long
declare function xmlUCSIsGreek(byval code as long) as long
declare function xmlUCSIsGreekExtended(byval code as long) as long
declare function xmlUCSIsGreekandCoptic(byval code as long) as long
declare function xmlUCSIsGujarati(byval code as long) as long
declare function xmlUCSIsGurmukhi(byval code as long) as long
declare function xmlUCSIsHalfwidthandFullwidthForms(byval code as long) as long
declare function xmlUCSIsHangulCompatibilityJamo(byval code as long) as long
declare function xmlUCSIsHangulJamo(byval code as long) as long
declare function xmlUCSIsHangulSyllables(byval code as long) as long
declare function xmlUCSIsHanunoo(byval code as long) as long
declare function xmlUCSIsHebrew(byval code as long) as long
declare function xmlUCSIsHighPrivateUseSurrogates(byval code as long) as long
declare function xmlUCSIsHighSurrogates(byval code as long) as long
declare function xmlUCSIsHiragana(byval code as long) as long
declare function xmlUCSIsIPAExtensions(byval code as long) as long
declare function xmlUCSIsIdeographicDescriptionCharacters(byval code as long) as long
declare function xmlUCSIsKanbun(byval code as long) as long
declare function xmlUCSIsKangxiRadicals(byval code as long) as long
declare function xmlUCSIsKannada(byval code as long) as long
declare function xmlUCSIsKatakana(byval code as long) as long
declare function xmlUCSIsKatakanaPhoneticExtensions(byval code as long) as long
declare function xmlUCSIsKhmer(byval code as long) as long
declare function xmlUCSIsKhmerSymbols(byval code as long) as long
declare function xmlUCSIsLao(byval code as long) as long
declare function xmlUCSIsLatin1Supplement(byval code as long) as long
declare function xmlUCSIsLatinExtendedA(byval code as long) as long
declare function xmlUCSIsLatinExtendedB(byval code as long) as long
declare function xmlUCSIsLatinExtendedAdditional(byval code as long) as long
declare function xmlUCSIsLetterlikeSymbols(byval code as long) as long
declare function xmlUCSIsLimbu(byval code as long) as long
declare function xmlUCSIsLinearBIdeograms(byval code as long) as long
declare function xmlUCSIsLinearBSyllabary(byval code as long) as long
declare function xmlUCSIsLowSurrogates(byval code as long) as long
declare function xmlUCSIsMalayalam(byval code as long) as long
declare function xmlUCSIsMathematicalAlphanumericSymbols(byval code as long) as long
declare function xmlUCSIsMathematicalOperators(byval code as long) as long
declare function xmlUCSIsMiscellaneousMathematicalSymbolsA(byval code as long) as long
declare function xmlUCSIsMiscellaneousMathematicalSymbolsB(byval code as long) as long
declare function xmlUCSIsMiscellaneousSymbols(byval code as long) as long
declare function xmlUCSIsMiscellaneousSymbolsandArrows(byval code as long) as long
declare function xmlUCSIsMiscellaneousTechnical(byval code as long) as long
declare function xmlUCSIsMongolian(byval code as long) as long
declare function xmlUCSIsMusicalSymbols(byval code as long) as long
declare function xmlUCSIsMyanmar(byval code as long) as long
declare function xmlUCSIsNumberForms(byval code as long) as long
declare function xmlUCSIsOgham(byval code as long) as long
declare function xmlUCSIsOldItalic(byval code as long) as long
declare function xmlUCSIsOpticalCharacterRecognition(byval code as long) as long
declare function xmlUCSIsOriya(byval code as long) as long
declare function xmlUCSIsOsmanya(byval code as long) as long
declare function xmlUCSIsPhoneticExtensions(byval code as long) as long
declare function xmlUCSIsPrivateUse(byval code as long) as long
declare function xmlUCSIsPrivateUseArea(byval code as long) as long
declare function xmlUCSIsRunic(byval code as long) as long
declare function xmlUCSIsShavian(byval code as long) as long
declare function xmlUCSIsSinhala(byval code as long) as long
declare function xmlUCSIsSmallFormVariants(byval code as long) as long
declare function xmlUCSIsSpacingModifierLetters(byval code as long) as long
declare function xmlUCSIsSpecials(byval code as long) as long
declare function xmlUCSIsSuperscriptsandSubscripts(byval code as long) as long
declare function xmlUCSIsSupplementalArrowsA(byval code as long) as long
declare function xmlUCSIsSupplementalArrowsB(byval code as long) as long
declare function xmlUCSIsSupplementalMathematicalOperators(byval code as long) as long
declare function xmlUCSIsSupplementaryPrivateUseAreaA(byval code as long) as long
declare function xmlUCSIsSupplementaryPrivateUseAreaB(byval code as long) as long
declare function xmlUCSIsSyriac(byval code as long) as long
declare function xmlUCSIsTagalog(byval code as long) as long
declare function xmlUCSIsTagbanwa(byval code as long) as long
declare function xmlUCSIsTags(byval code as long) as long
declare function xmlUCSIsTaiLe(byval code as long) as long
declare function xmlUCSIsTaiXuanJingSymbols(byval code as long) as long
declare function xmlUCSIsTamil(byval code as long) as long
declare function xmlUCSIsTelugu(byval code as long) as long
declare function xmlUCSIsThaana(byval code as long) as long
declare function xmlUCSIsThai(byval code as long) as long
declare function xmlUCSIsTibetan(byval code as long) as long
declare function xmlUCSIsUgaritic(byval code as long) as long
declare function xmlUCSIsUnifiedCanadianAboriginalSyllabics(byval code as long) as long
declare function xmlUCSIsVariationSelectors(byval code as long) as long
declare function xmlUCSIsVariationSelectorsSupplement(byval code as long) as long
declare function xmlUCSIsYiRadicals(byval code as long) as long
declare function xmlUCSIsYiSyllables(byval code as long) as long
declare function xmlUCSIsYijingHexagramSymbols(byval code as long) as long
declare function xmlUCSIsBlock(byval code as long, byval block as const zstring ptr) as long
declare function xmlUCSIsCatC(byval code as long) as long
declare function xmlUCSIsCatCc(byval code as long) as long
declare function xmlUCSIsCatCf(byval code as long) as long
declare function xmlUCSIsCatCo(byval code as long) as long
declare function xmlUCSIsCatCs(byval code as long) as long
declare function xmlUCSIsCatL(byval code as long) as long
declare function xmlUCSIsCatLl(byval code as long) as long
declare function xmlUCSIsCatLm(byval code as long) as long
declare function xmlUCSIsCatLo(byval code as long) as long
declare function xmlUCSIsCatLt(byval code as long) as long
declare function xmlUCSIsCatLu(byval code as long) as long
declare function xmlUCSIsCatM(byval code as long) as long
declare function xmlUCSIsCatMc(byval code as long) as long
declare function xmlUCSIsCatMe(byval code as long) as long
declare function xmlUCSIsCatMn(byval code as long) as long
declare function xmlUCSIsCatN(byval code as long) as long
declare function xmlUCSIsCatNd(byval code as long) as long
declare function xmlUCSIsCatNl(byval code as long) as long
declare function xmlUCSIsCatNo(byval code as long) as long
declare function xmlUCSIsCatP(byval code as long) as long
declare function xmlUCSIsCatPc(byval code as long) as long
declare function xmlUCSIsCatPd(byval code as long) as long
declare function xmlUCSIsCatPe(byval code as long) as long
declare function xmlUCSIsCatPf(byval code as long) as long
declare function xmlUCSIsCatPi(byval code as long) as long
declare function xmlUCSIsCatPo(byval code as long) as long
declare function xmlUCSIsCatPs(byval code as long) as long
declare function xmlUCSIsCatS(byval code as long) as long
declare function xmlUCSIsCatSc(byval code as long) as long
declare function xmlUCSIsCatSk(byval code as long) as long
declare function xmlUCSIsCatSm(byval code as long) as long
declare function xmlUCSIsCatSo(byval code as long) as long
declare function xmlUCSIsCatZ(byval code as long) as long
declare function xmlUCSIsCatZl(byval code as long) as long
declare function xmlUCSIsCatZp(byval code as long) as long
declare function xmlUCSIsCatZs(byval code as long) as long
declare function xmlUCSIsCat(byval code as long, byval cat as const zstring ptr) as long

end extern
