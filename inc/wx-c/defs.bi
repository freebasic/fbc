#Ifndef __defs_bi__
#Define __defs_bi__

Enum wxC2S
  wxC2S_NAME        = 1 Shl 0 ' return colour name, when possible
  wxC2S_CSS_SYNTAX  = 1 Shl 1 ' return colour in rgb(r,g,b) syntax
  wxC2S_HTML_SYNTAX = 1 Shl 2 ' return colour in #rrggbb syntax
End Enum

Enum wxLanguage
  ' user's default/preffered language As got from OS
  wxLANGUAGE_DEFAULT
  ' unknown language if wxLocale_GetSystemLanguage fails:
  wxLANGUAGE_UNKNOWN
  wxLANGUAGE_ABKHAZIAN
  wxLANGUAGE_AFAR
  wxLANGUAGE_AFRIKAANS
  wxLANGUAGE_ALBANIAN
  wxLANGUAGE_AMHARIC
  wxLANGUAGE_ARABIC
  wxLANGUAGE_ARABIC_ALGERIA
  wxLANGUAGE_ARABIC_BAHRAIN
  wxLANGUAGE_ARABIC_EGYPT
  wxLANGUAGE_ARABIC_IRAQ
  wxLANGUAGE_ARABIC_JORDAN
  wxLANGUAGE_ARABIC_KUWAIT
  wxLANGUAGE_ARABIC_LEBANON
  wxLANGUAGE_ARABIC_LIBYA
  wxLANGUAGE_ARABIC_MOROCCO
  wxLANGUAGE_ARABIC_OMAN
  wxLANGUAGE_ARABIC_QATAR
  wxLANGUAGE_ARABIC_SAUDI_ARABIA
  wxLANGUAGE_ARABIC_SUDAN
  wxLANGUAGE_ARABIC_SYRIA
  wxLANGUAGE_ARABIC_TUNISIA
  wxLANGUAGE_ARABIC_UAE
  wxLANGUAGE_ARABIC_YEMEN
  wxLANGUAGE_ARMENIAN
  wxLANGUAGE_ASSAMESE
  wxLANGUAGE_AYMARA
  wxLANGUAGE_AZERI
  wxLANGUAGE_AZERI_CYRILLIC
  wxLANGUAGE_AZERI_LATIN
  wxLANGUAGE_BASHKIR
  wxLANGUAGE_BASQUE
  wxLANGUAGE_BELARUSIAN
  wxLANGUAGE_BENGALI
  wxLANGUAGE_BHUTANI
  wxLANGUAGE_BIHARI
  wxLANGUAGE_BISLAMA
  wxLANGUAGE_BRETON
  wxLANGUAGE_BULGARIAN
  wxLANGUAGE_BURMESE,
  wxLANGUAGE_CAMBODIAN
  wxLANGUAGE_CATALAN
  wxLANGUAGE_CHINESE
  wxLANGUAGE_CHINESE_SIMPLIFIED
  wxLANGUAGE_CHINESE_TRADITIONAL
  wxLANGUAGE_CHINESE_HONGKONG
  wxLANGUAGE_CHINESE_MACAU
  wxLANGUAGE_CHINESE_SINGAPORE
  wxLANGUAGE_CHINESE_TAIWAN
  wxLANGUAGE_CORSICAN
  wxLANGUAGE_CROATIAN
  wxLANGUAGE_CZECH
  wxLANGUAGE_DANISH
  wxLANGUAGE_DUTCH
  wxLANGUAGE_DUTCH_BELGIAN
  wxLANGUAGE_ENGLISH
  wxLANGUAGE_ENGLISH_UK
  wxLANGUAGE_ENGLISH_US
  wxLANGUAGE_ENGLISH_AUSTRALIA
  wxLANGUAGE_ENGLISH_BELIZE
  wxLANGUAGE_ENGLISH_BOTSWANA
  wxLANGUAGE_ENGLISH_CANADA
  wxLANGUAGE_ENGLISH_CARIBBEAN
  wxLANGUAGE_ENGLISH_DENMARK
  wxLANGUAGE_ENGLISH_EIRE
  wxLANGUAGE_ENGLISH_JAMAICA
  wxLANGUAGE_ENGLISH_NEW_ZEALAND
  wxLANGUAGE_ENGLISH_PHILIPPINES
  wxLANGUAGE_ENGLISH_SOUTH_AFRICA
  wxLANGUAGE_ENGLISH_TRINIDAD
  wxLANGUAGE_ENGLISH_ZIMBABWE
  wxLANGUAGE_ESPERANTO
  wxLANGUAGE_ESTONIAN
  wxLANGUAGE_FAEROESE
  wxLANGUAGE_FARSI
  wxLANGUAGE_FIJI
  wxLANGUAGE_FINNISH
  wxLANGUAGE_FRENCH
  wxLANGUAGE_FRENCH_BELGIAN
  wxLANGUAGE_FRENCH_CANADIAN
  wxLANGUAGE_FRENCH_LUXEMBOURG
  wxLANGUAGE_FRENCH_MONACO
  wxLANGUAGE_FRENCH_SWISS
  wxLANGUAGE_FRISIAN
  wxLANGUAGE_GALICIAN
  wxLANGUAGE_GEORGIAN
  wxLANGUAGE_GERMAN
  wxLANGUAGE_GERMAN_AUSTRIAN
  wxLANGUAGE_GERMAN_BELGIUM
  wxLANGUAGE_GERMAN_LIECHTENSTEIN
  wxLANGUAGE_GERMAN_LUXEMBOURG
  wxLANGUAGE_GERMAN_SWISS
  wxLANGUAGE_GREEK
  wxLANGUAGE_GREENLANDIC
  wxLANGUAGE_GUARANI
  wxLANGUAGE_GUJARATI
  wxLANGUAGE_HAUSA
  wxLANGUAGE_HEBREW
  wxLANGUAGE_HINDI
  wxLANGUAGE_HUNGARIAN
  wxLANGUAGE_ICELANDIC
  wxLANGUAGE_INDONESIAN
  wxLANGUAGE_INTERLINGUA
  wxLANGUAGE_INTERLINGUE
  wxLANGUAGE_INUKTITUT
  wxLANGUAGE_INUPIAK
  wxLANGUAGE_IRISH
  wxLANGUAGE_ITALIAN
  wxLANGUAGE_ITALIAN_SWISS
  wxLANGUAGE_JAPANESE
  wxLANGUAGE_JAVANESE
  wxLANGUAGE_KANNADA
  wxLANGUAGE_KASHMIRI
  wxLANGUAGE_KASHMIRI_INDIA
  wxLANGUAGE_KAZAKH
  wxLANGUAGE_KERNEWEK
  wxLANGUAGE_KINYARWANDA
  wxLANGUAGE_KIRGHIZ
  wxLANGUAGE_KIRUNDI
  wxLANGUAGE_KONKANI
  wxLANGUAGE_KOREAN
  wxLANGUAGE_KURDISH
  wxLANGUAGE_LAOTHIAN
  wxLANGUAGE_LATIN
  wxLANGUAGE_LATVIAN
  wxLANGUAGE_LINGALA
  wxLANGUAGE_LITHUANIAN
  wxLANGUAGE_MACEDONIAN
  wxLANGUAGE_MALAGASY
  wxLANGUAGE_MALAY
  wxLANGUAGE_MALAYALAM
  wxLANGUAGE_MALAY_BRUNEI_DARUSSALAM
  wxLANGUAGE_MALAY_MALAYSIA
  wxLANGUAGE_MALTESE
  wxLANGUAGE_MANIPURI
  wxLANGUAGE_MAORI
  wxLANGUAGE_MARATHI
  wxLANGUAGE_MOLDAVIAN
  wxLANGUAGE_MONGOLIAN
  wxLANGUAGE_NAURU
  wxLANGUAGE_NEPALI
  wxLANGUAGE_NEPALI_INDIA
  wxLANGUAGE_NORWEGIAN_BOKMAL
  wxLANGUAGE_NORWEGIAN_NYNORSK
  wxLANGUAGE_OCCITAN
  wxLANGUAGE_ORIYA
  wxLANGUAGE_OROMO
  wxLANGUAGE_PASHTO
  wxLANGUAGE_POLISH
  wxLANGUAGE_PORTUGUESE
  wxLANGUAGE_PORTUGUESE_BRAZILIAN
  wxLANGUAGE_PUNJABI
  wxLANGUAGE_QUECHUA
  wxLANGUAGE_RHAETO_ROMANCE
  wxLANGUAGE_ROMANIAN
  wxLANGUAGE_RUSSIAN
  wxLANGUAGE_RUSSIAN_UKRAINE
  wxLANGUAGE_SAMOAN
  wxLANGUAGE_SANGHO
  wxLANGUAGE_SANSKRIT
  wxLANGUAGE_SCOTS_GAELIC
  wxLANGUAGE_SERBIAN
  wxLANGUAGE_SERBIAN_CYRILLIC
  wxLANGUAGE_SERBIAN_LATIN
  wxLANGUAGE_SERBO_CROATIAN
  wxLANGUAGE_SESOTHO
  wxLANGUAGE_SETSWANA
  wxLANGUAGE_SHONA
  wxLANGUAGE_SINDHI
  wxLANGUAGE_SINHALESE
  wxLANGUAGE_SISWATI
  wxLANGUAGE_SLOVAK
  wxLANGUAGE_SLOVENIAN
  wxLANGUAGE_SOMALI
  wxLANGUAGE_SPANISH
  wxLANGUAGE_SPANISH_ARGENTINA
  wxLANGUAGE_SPANISH_BOLIVIA
  wxLANGUAGE_SPANISH_CHILE
  wxLANGUAGE_SPANISH_COLOMBIA
  wxLANGUAGE_SPANISH_COSTA_RICA
  wxLANGUAGE_SPANISH_DOMINICAN_REPUBLIC
  wxLANGUAGE_SPANISH_ECUADOR
  wxLANGUAGE_SPANISH_EL_SALVADOR
  wxLANGUAGE_SPANISH_GUATEMALA
  wxLANGUAGE_SPANISH_HONDURAS
  wxLANGUAGE_SPANISH_MEXICAN
  wxLANGUAGE_SPANISH_MODERN
  wxLANGUAGE_SPANISH_NICARAGUA
  wxLANGUAGE_SPANISH_PANAMA
  wxLANGUAGE_SPANISH_PARAGUAY
  wxLANGUAGE_SPANISH_PERU
  wxLANGUAGE_SPANISH_PUERTO_RICO
  wxLANGUAGE_SPANISH_URUGUAY
  wxLANGUAGE_SPANISH_US
  wxLANGUAGE_SPANISH_VENEZUELA
  wxLANGUAGE_SUNDANESE
  wxLANGUAGE_SWAHILI
  wxLANGUAGE_SWEDISH
  wxLANGUAGE_SWEDISH_FINLAND
  wxLANGUAGE_TAGALOG
  wxLANGUAGE_TAJIK
  wxLANGUAGE_TAMIL
  wxLANGUAGE_TATAR
  wxLANGUAGE_TELUGU
  wxLANGUAGE_THAI
  wxLANGUAGE_TIBETAN
  wxLANGUAGE_TIGRINYA
  wxLANGUAGE_TONGA
  wxLANGUAGE_TSONGA
  wxLANGUAGE_TURKISH
  wxLANGUAGE_TURKMEN
  wxLANGUAGE_TWI
  wxLANGUAGE_UIGHUR
  wxLANGUAGE_UKRAINIAN
  wxLANGUAGE_URDU
  wxLANGUAGE_URDU_INDIA
  wxLANGUAGE_URDU_PAKISTAN
  wxLANGUAGE_UZBEK
  wxLANGUAGE_UZBEK_CYRILLIC
  wxLANGUAGE_UZBEK_LATIN
  wxLANGUAGE_VIETNAMESE
  wxLANGUAGE_VOLAPUK
  wxLANGUAGE_WELSH
  wxLANGUAGE_WOLOF
  wxLANGUAGE_XHOSA
  wxLANGUAGE_YIDDISH
  wxLANGUAGE_YORUBA
  wxLANGUAGE_ZHUANG
  wxLANGUAGE_ZULU

  ' for custom, user-defined languages
  wxLANGUAGE_USER_DEFINED
End Enum

Enum wxPrinterError
  wxPRINTER_NO_ERROR
  wxPRINTER_CANCELLED
  wxPRINTER_ERROR
End Enum

Enum wxPaperSize
  wxPAPER_NONE               '  Use specific dimensions 
  wxPAPER_LETTER             '  Letter 8 1/2 by 11 inches 
  wxPAPER_LEGAL              '  Legal 8 1/2 by 14 inches 
  wxPAPER_A4                 '  A4 Sheet 210 by 297 millimeters 
  wxPAPER_CSHEET             '  C Sheet 17 by 22 inches 
  wxPAPER_DSHEET             '  D Sheet 22 by 34 inches 
  wxPAPER_ESHEET             '  E Sheet 34 by 44 inches 
  wxPAPER_LETTERSMALL        '  Letter Small 8 1/2 by 11 inches 
  wxPAPER_TABLOID            '  Tabloid 11 by 17 inches 
  wxPAPER_LEDGER             '  Ledger 17 by 11 inches 
  wxPAPER_STATEMENT          '  Statement 5 1/2 by 8 1/2 inches 
  wxPAPER_EXECUTIVE          '  Executive 7 1/4 by 10 1/2 inches 
  wxPAPER_A3                 '  A3 sheet 297 by 420 millimeters 
  wxPAPER_A4SMALL            '  A4 small sheet 210 by 297 millimeters 
  wxPAPER_A5                 '  A5 sheet 148 by 210 millimeters 
  wxPAPER_B4                 '  B4 sheet 250 by 354 millimeters 
  wxPAPER_B5                 '  B5 sheet 182-by-257-millimeter paper 
  wxPAPER_FOLIO              '  Folio 8-1/2-by-13-inch paper 
  wxPAPER_QUARTO             '  Quarto 215-by-275-millimeter paper 
  wxPAPER_10X14              '  10-by-14-inch sheet 
  wxPAPER_11X17              '  11-by-17-inch sheet 
  wxPAPER_NOTE               '  Note 8 1/2 by 11 inches 
  wxPAPER_ENV_9              '  #9 Envelope 3 7/8 by 8 7/8 inches 
  wxPAPER_ENV_10             '  #10 Envelope 4 1/8 by 9 1/2 inches 
  wxPAPER_ENV_11             '  #11 Envelope 4 1/2 by 10 3/8 inches 
  wxPAPER_ENV_12             '  #12 Envelope 4 3/4 by 11 inches 
  wxPAPER_ENV_14             '  #14 Envelope 5 by 11 1/2 inches 
  wxPAPER_ENV_DL             '  DL Envelope 110 by 220 millimeters 
  wxPAPER_ENV_C5             '  C5 Envelope 162 by 229 millimeters 
  wxPAPER_ENV_C3             '  C3 Envelope 324 by 458 millimeters 
  wxPAPER_ENV_C4             '  C4 Envelope 229 by 324 millimeters 
  wxPAPER_ENV_C6             '  C6 Envelope 114 by 162 millimeters 
  wxPAPER_ENV_C65            '  C65 Envelope 114 by 229 millimeters 
  wxPAPER_ENV_B4             '  B4 Envelope 250 by 353 millimeters 
  wxPAPER_ENV_B5             '  B5 Envelope 176 by 250 millimeters 
  wxPAPER_ENV_B6             '  B6 Envelope 176 by 125 millimeters 
  wxPAPER_ENV_ITALY          '  Italy Envelope 110 by 230 millimeters 
  wxPAPER_ENV_MONARCH        '  Monarch Envelope 3 7/8 by 7 1/2 inches 
  wxPAPER_ENV_PERSONAL       '  6 3/4 Envelope 3 5/8 by 6 1/2 inches 
  wxPAPER_FANFOLD_US         '  US Std Fanfold 14 7/8 by 11 inches 
  wxPAPER_FANFOLD_STD_GERMAN '  German Std Fanfold 8 1/2 by 12 inches 
  wxPAPER_FANFOLD_LGL_GERMAN '  German Legal Fanfold 8 1/2 by 13 inches 

  wxPAPER_ISO_B4             '  B4 (ISO) 250 x 353 mm 
  wxPAPER_JAPANESE_POSTCARD  '  Japanese Postcard 100 x 148 mm 
  wxPAPER_9X11               '  9 x 11 in 
  wxPAPER_10X11              '  10 x 11 in 
  wxPAPER_15X11              '  15 x 11 in 
  wxPAPER_ENV_INVITE         '  Envelope Invite 220 x 220 mm 
  wxPAPER_LETTER_EXTRA       '  Letter Extra 9 \275 x 12 in 
  wxPAPER_LEGAL_EXTRA        '  Legal Extra 9 \275 x 15 in 
  wxPAPER_TABLOID_EXTRA      '  Tabloid Extra 11.69 x 18 in 
  wxPAPER_A4_EXTRA           '  A4 Extra 9.27 x 12.69 in 
  wxPAPER_LETTER_TRANSVERSE  '  Letter Transverse 8 \275 x 11 in 
  wxPAPER_A4_TRANSVERSE      '  A4 Transverse 210 x 297 mm 
  wxPAPER_LETTER_EXTRA_TRANSVERSE '  Letter Extra Transverse 9\275 x 12 in 
  wxPAPER_A_PLUS             '  SuperA/SuperA/A4 227 x 356 mm 
  wxPAPER_B_PLUS             '  SuperB/SuperB/A3 305 x 487 mm 
  wxPAPER_LETTER_PLUS        '  Letter Plus 8.5 x 12.69 in 
  wxPAPER_A4_PLUS            '  A4 Plus 210 x 330 mm 
  wxPAPER_A5_TRANSVERSE      '  A5 Transverse 148 x 210 mm 
  wxPAPER_B5_TRANSVERSE      '  B5 (JIS) Transverse 182 x 257 mm 
  wxPAPER_A3_EXTRA           '  A3 Extra 322 x 445 mm 
  wxPAPER_A5_EXTRA           '  A5 Extra 174 x 235 mm 
  wxPAPER_B5_EXTRA           '  B5 (ISO) Extra 201 x 276 mm 
  wxPAPER_A2                 '  A2 420 x 594 mm 
  wxPAPER_A3_TRANSVERSE      '  A3 Transverse 297 x 420 mm 
  wxPAPER_A3_EXTRA_TRANSVERSE '  A3 Extra Transverse 322 x 445 mm 

  wxPAPER_DBL_JAPANESE_POSTCARD' Japanese Double Postcard 200 x 148 mm 
  wxPAPER_A6                 ' A6 105 x 148 mm 
  wxPAPER_JENV_KAKU2         ' Japanese Envelope Kaku #2 
  wxPAPER_JENV_KAKU3         ' Japanese Envelope Kaku #3 
  wxPAPER_JENV_CHOU3         ' Japanese Envelope Chou #3 
  wxPAPER_JENV_CHOU4         ' Japanese Envelope Chou #4 
  wxPAPER_LETTER_ROTATED     ' Letter Rotated 11 x 8 1/2 in 
  wxPAPER_A3_ROTATED         ' A3 Rotated 420 x 297 mm 
  wxPAPER_A4_ROTATED         ' A4 Rotated 297 x 210 mm 
  wxPAPER_A5_ROTATED         ' A5 Rotated 210 x 148 mm 
  wxPAPER_B4_JIS_ROTATED     ' B4 (JIS) Rotated 364 x 257 mm 
  wxPAPER_B5_JIS_ROTATED     ' B5 (JIS) Rotated 257 x 182 mm 
  wxPAPER_JAPANESE_POSTCARD_ROTATED' Japanese Postcard Rotated 148 x 100 mm 
  wxPAPER_DBL_JAPANESE_POSTCARD_ROTATED' Double Japanese Postcard Rotated 148 x 200 mm 
  wxPAPER_A6_ROTATED         ' A6 Rotated 148 x 105 mm 
  wxPAPER_JENV_KAKU2_ROTATED ' Japanese Envelope Kaku #2 Rotated 
  wxPAPER_JENV_KAKU3_ROTATED ' Japanese Envelope Kaku #3 Rotated 
  wxPAPER_JENV_CHOU3_ROTATED ' Japanese Envelope Chou #3 Rotated 
  wxPAPER_JENV_CHOU4_ROTATED ' Japanese Envelope Chou #4 Rotated 
  wxPAPER_B6_JIS             ' B6 (JIS) 128 x 182 mm 
  wxPAPER_B6_JIS_ROTATED     ' B6 (JIS) Rotated 182 x 128 mm 
  wxPAPER_12X11              ' 12 x 11 in 
  wxPAPER_JENV_YOU4          ' Japanese Envelope You #4 
  wxPAPER_JENV_YOU4_ROTATED  ' Japanese Envelope You #4 Rotated 
  wxPAPER_P16K               ' PRC 16K 146 x 215 mm 
  wxPAPER_P32K               ' PRC 32K 97 x 151 mm 
  wxPAPER_P32KBIG            ' PRC 32K(Big) 97 x 151 mm 
  wxPAPER_PENV_1             ' PRC Envelope #1 102 x 165 mm 
  wxPAPER_PENV_2             ' PRC Envelope #2 102 x 176 mm 
  wxPAPER_PENV_3             ' PRC Envelope #3 125 x 176 mm 
  wxPAPER_PENV_4             ' PRC Envelope #4 110 x 208 mm 
  wxPAPER_PENV_5             ' PRC Envelope #5 110 x 220 mm 
  wxPAPER_PENV_6             ' PRC Envelope #6 120 x 230 mm 
  wxPAPER_PENV_7             ' PRC Envelope #7 160 x 230 mm 
  wxPAPER_PENV_8             ' PRC Envelope #8 120 x 309 mm 
  wxPAPER_PENV_9             ' PRC Envelope #9 229 x 324 mm 
  wxPAPER_PENV_10            ' PRC Envelope #10 324 x 458 mm 
  wxPAPER_P16K_ROTATED       ' PRC 16K Rotated 
  wxPAPER_P32K_ROTATED       ' PRC 32K Rotated 
  wxPAPER_P32KBIG_ROTATED    ' PRC 32K(Big) Rotated 
  wxPAPER_PENV_1_ROTATED     ' PRC Envelope #1 Rotated 165 x 102 mm 
  wxPAPER_PENV_2_ROTATED     ' PRC Envelope #2 Rotated 176 x 102 mm 
  wxPAPER_PENV_3_ROTATED     ' PRC Envelope #3 Rotated 176 x 125 mm 
  wxPAPER_PENV_4_ROTATED     ' PRC Envelope #4 Rotated 208 x 110 mm 
  wxPAPER_PENV_5_ROTATED     ' PRC Envelope #5 Rotated 220 x 110 mm 
  wxPAPER_PENV_6_ROTATED     ' PRC Envelope #6 Rotated 230 x 120 mm 
  wxPAPER_PENV_7_ROTATED     ' PRC Envelope #7 Rotated 230 x 160 mm 
  wxPAPER_PENV_8_ROTATED     ' PRC Envelope #8 Rotated 309 x 120 mm 
  wxPAPER_PENV_9_ROTATED     ' PRC Envelope #9 Rotated 324 x 229 mm 
  wxPAPER_PENV_10_ROTATED    ' PRC Envelope #10 Rotated 458 x 324 m 
End Enum

Enum wxPrintingOrientation
  wxPORTRAIT  = 1
  wxLANDSCAPE = 2
End Enum

Enum wxDuplexMode
  wxDUPLEX_SIMPLEX   '  Non-duplex 
  wxDUPLEX_HORIZONTAL
  wxDUPLEX_VERTICAL
End Enum

Enum wxPrintQuality
  wxPRINT_QUALITY_HIGH    =-1
  wxPRINT_QUALITY_MEDIUM  =-2
  wxPRINT_QUALITY_LOW     =-3
  wxPRINT_QUALITY_DRAFT   =-4
End Enum

' Print mode (currently PostScript only)
Enum wxPrintMode
  wxPRINT_MODE_NONE    = 0
  wxPRINT_MODE_PREVIEW = 1 ' Preview in external application
  wxPRINT_MODE_FILE    = 2 ' Print to file
  wxPRINT_MODE_PRINTER = 3 ' Send to printer
  wxPRINT_MODE_STREAM  = 4 ' Send postscript data into a stream 
End Enum

Enum wxLayoutOrientation
  wxLAYOUT_HORIZONTAL
  wxLAYOUT_VERTICAL
End Enum

Enum wxRegionContain
  wxOutRegion  = 0
  wxPartRegion = 1
  wxInRegion   = 2
End Enum

Enum wxLayoutAlignment
  wxLAYOUT_NONE
  wxLAYOUT_TOP
  wxLAYOUT_LEFT
  wxLAYOUT_RIGHT
  wxLAYOUT_BOTTOM
End Enum

Enum wxHtmlURLType
  wxHTML_URL_PAGE
  wxHTML_URL_IMAGE
  wxHTML_URL_OTHER
End Enum

Enum wxHtmlOpeningStatus
  wxHTML_OPEN
  wxHTML_BLOCK
  wxHTML_REDIRECT
End Enum

Enum wxHtmlWindowStyle
  wxHW_SCROLLBAR_NEVER = 1 Shl 1
  wxHW_SCROLLBAR_AUTO  = 1 Shl 2
  wxHW_NO_SELECTION    = 1 Shl 3
End Enum

Enum wxHelpSearchMode
  wxHELP_SEARCH_INDEX
  wxHELP_SEARCH_ALL
End Enum

Enum wxIdleMode
  ' Send idle events to all windows
  wxIDLE_PROCESS_ALL
  ' Send idle events to windows that have the wxWS_EX_PROCESS_IDLE flag specified
  wxIDLE_PROCESS_SPECIFIED
End Enum

Enum wxArchiveType
  wxZip
End Enum

Enum wxDataObjectDirection
  wxDO_Get =1
  wxDO_Set
  wxDO_Both
End Enum

Enum wxDataFormatId
  wxDF_INVALID = 0
  wxDF_TEXT
  wxDF_BITMAP
  wxDF_METAFILE
  wxDF_SYLK
  wxDF_DIF
  wxDF_TIFF
  wxDF_OEMTEXT
  wxDF_DIB
  wxDF_PALETTE
  wxDF_PENDATA
  wxDF_RIFF
  wxDF_WAVE
  wxDF_UNICODETEXT
  wxDF_ENHMETAFILE
  wxDF_FILENAME
  wxDF_LOCALE
  
  wxDF_PRIVATE = 20
  
  wxDF_HTML = 30
  wxDF_MAX
End Enum

Enum wxDragResult
  wxDR_Error  ' error prevented the d&d operation from completing
  wxDR_None   ' drag target didn't accept the data
  wxDR_Copy   ' the data was successfully copied
  wxDR_Move   ' the data was successfully moved (MSW only)
  wxDR_Link   ' operation is a drag-link
  wxDR_Cancel ' the operation was cancelled by user (not an error)
End Enum

Enum wxSeekMode
  wxSM_Start
  wxSM_Current
  wxSM_End
End Enum

Enum wxMappingMode
  wxMM_TEXT = 1
  wxMM_LOMETRIC
  wxMM_HIMETRIC
  wxMM_LOENGLISH
  wxMM_HIENGLISH
  wxMM_TWIPS
  wxMM_ISOTROPIC
  wxMM_ANISOTROPIC
  wxMM_POINTS
  wxMM_METRIC
End Enum

Enum wxPlatforms
  wxUNKNOWN_PLATFORM
  wxCURSES
  wxXVIEW_X
  wxMOTIF_X
  wxCOSE_X
  wxNEXTSTEP
  wxMAC
  wxMAC_DARWIN
  wxBEOS
  wxGTK
  wxGTK_WIN32
  wxGTK_OS2
  wxGTK_BEOS
  wxGEOS
  wxOS2_PM
  wxWINDOWS
  wxMICROWINDOWS
  wxPENWINDOWS
  wxWINDOWS_NT
  wxWIN32S
  wxWIN95
  wxWIN386
  wxMGL_UNIX
  wxMGL_X
  wxMGL_WIN32
  wxMGL_OS2
  wxMGL_DOS
  wxWINDOWS_OS2
  wxUNIX
  wxX11
End Enum

#Define wxBIG_ENDIAN  4321
#Define wxLITTLE_ENDIAN 1234
#Define wxPDP_ENDIAN  3412
#Define wxBYTE_ORDER  1234

' Standard menu IDs
Enum wxMenuIDs
  wxID_LOWEST = 4999
  wxID_OPEN
  wxID_CLOSE
  wxID_NEW
  wxID_SAVE
  wxID_SAVEAS
  wxID_REVERT
  wxID_EXIT
  wxID_UNDO
  wxID_REDO
  wxID_HELP
  wxID_PRINT
  wxID_PRINT_SETUP
  wxID_PREVIEW
  wxID_ABOUT
  wxID_HELP_CONTENTS
  wxID_HELP_COMMANDS
  wxID_HELP_PROCEDURES
  wxID_HELP_CONTEXT
  wxID_CLOSE_ALL
  wxID_PREFERENCES
  
  wxID_CUT = 5030
  wxID_COPY
  wxID_PASTE
  wxID_CLEAR
  wxID_FIND
  wxID_DUPLICATE
  wxID_SELECTALL
  wxID_DELETE
  wxID_REPLACE
  wxID_REPLACE_ALL
  wxID_PROPERTIES
  
  wxID_VIEW_DETAILS
  wxID_VIEW_LARGEICONS
  wxID_VIEW_SMALLICONS
  wxID_VIEW_LIST
  wxID_VIEW_SORTDATE
  wxID_VIEW_SORTNAME
  wxID_VIEW_SORTSIZE
  wxID_VIEW_SORTTYPE
  
  wxID_FILE1 = 5050
  wxID_FILE2
  wxID_FILE3
  wxID_FILE4
  wxID_FILE5
  wxID_FILE6
  wxID_FILE7
  wxID_FILE8
  wxID_FILE9
  
  ' Standard button and menu IDs
  wxID_OK = 5100
  wxID_CANCEL
  wxID_APPLY
  wxID_YES
  wxID_NO
  wxID_STATIC
  wxID_FORWARD
  wxID_BACKWARD
  wxID_DEFAULT
  wxID_MORE
  wxID_SETUP
  wxID_RESET
  wxID_CONTEXT_HELP
  wxID_YESTOALL
  wxID_NOTOALL
  wxID_ABORT
  wxID_RETRY
  wxID_IGNORE
  wxID_ADD
  wxID_REMOVE
  
  wxID_UP
  wxID_DOWN
  wxID_HOME
  wxID_REFRESH
  wxID_STOP
  wxID_INDEX
  
  wxID_BOLD
  wxID_ITALIC
  wxID_JUSTIFY_CENTER
  wxID_JUSTIFY_FILL
  wxID_JUSTIFY_RIGHT
  wxID_JUSTIFY_LEFT
  wxID_UNDERLINE
  wxID_INDENT
  wxID_UNINDENT
  wxID_ZOOM_100
  wxID_ZOOM_FIT
  wxID_ZOOM_IN
  wxID_ZOOM_OUT
  wxID_UNDELETE
  wxID_REVERT_TO_SAVED
  
  ' System menu IDs (used by wxUniv)
  wxID_SYSTEM_MENU = 5200
  wxID_CLOSE_FRAME
  wxID_MOVE_FRAME
  wxID_RESIZE_FRAME
  wxID_MAXIMIZE_FRAME
  wxID_ICONIZE_FRAME
  wxID_RESTORE_FRAME
  
  ' IDs used by generic file dialog (13 consecutive starting from this value)
  wxID_FILEDLGG = 5900
  wxID_HIGHEST = 5999
End Enum

Public Enum wxFullscreen
  WXNOMENUBAR   = &H00000001
  WXNOTOOLBAR   = &H00000002
  WXNOSTATUSBAR = &H00000004
  WXNOBORDER    = &H00000008
  WXNOCAPTION   = &H00000010
  WXALL         = &H0000001F
End Enum

' Designators for eys on the keyboard.
Enum wxKeyCode
  WXK_BACK = 8
  WXK_TAB
  WXK_RETURN = 13
  WXK_ESCAPE = 27
  WXK_SPACE = 32
  WXK_DELETE = 127

  WXK_START = 300
  WXK_LBUTTON
  WXK_RBUTTON
  WXK_CANCEL
  WXK_MBUTTON
  WXK_CLEAR
  WXK_SHIFT
  WXK_ALT
  WXK_CONTROL
  WXK_MENU
  WXK_PAUSE
  WXK_CAPITAL
  WXK_END
  WXK_HOME
  WXK_LEFT
  WXK_UP
  WXK_RIGHT
  WXK_DOWN
  WXK_SELECT
  WXK_PRINT
  WXK_EXECUTE
  WXK_SNAPSHOT
  WXK_INSERT
  WXK_HELP
  WXK_NUMPAD0
  WXK_NUMPAD1
  WXK_NUMPAD2
  WXK_NUMPAD3
  WXK_NUMPAD4 
  WXK_NUMPAD5
  WXK_NUMPAD6
  WXK_NUMPAD7
  WXK_NUMPAD8
  WXK_NUMPAD9
  WXK_MULTIPLY
  WXK_ADD
  WXK_SEPARATOR
  WXK_SUBTRACT
  WXK_DECIMAL
  WXK_DIVIDE
  WXK_F1
  WXK_F2
  WXK_F3
  WXK_F4
  WXK_F5
  WXK_F6 
  WXK_F7
  WXK_F8
  WXK_F9
  WXK_F10
  WXK_F11
  WXK_F12
  WXK_F13
  WXK_F14
  WXK_F15
  WXK_F16
  WXK_F17
  WXK_F18
  WXK_F19
  WXK_F20
  WXK_F21
  WXK_F22
  WXK_F23
  WXK_F24
  WXK_NUMLOCK
  WXK_SCROLL
  WXK_PAGEUP
  WXK_PAGEDOWN
  WXK_NUMPAD_SPACE
  WXK_NUMPAD_TAB
  WXK_NUMPAD_ENTER
  WXK_NUMPAD_F1
  WXK_NUMPAD_F2
  WXK_NUMPAD_F3
  WXK_NUMPAD_F4
  WXK_NUMPAD_HOME
  WXK_NUMPAD_LEFT
  WXK_NUMPAD_UP
  WXK_NUMPAD_RIGHT
  WXK_NUMPAD_DOWN
  WXK_NUMPAD_PAGEUP
  WXK_NUMPAD_PAGEDOWN
  WXK_NUMPAD_END
  WXK_NUMPAD_BEGIN
  WXK_NUMPAD_INSERT
  WXK_NUMPAD_DELETE
  WXK_NUMPAD_EQUAL
  WXK_NUMPAD_MULTIPLY
  WXK_NUMPAD_ADD
  WXK_NUMPAD_SEPARATOR
  WXK_NUMPAD_SUBTRACT
  WXK_NUMPAD_DECIMAL
  WXK_NUMPAD_DIVIDE

  WXK_WINDOWS_LEFT
  WXK_WINDOWS_RIGHT
  WXK_WINDOWS_MENU
  WXK_COMMAND

  ' Hardware-specific buttons
  WXK_SPECIAL1 = 193
  WXK_SPECIAL2
  WXK_SPECIAL3
  WXK_SPECIAL4
  WXK_SPECIAL5
  WXK_SPECIAL6
  WXK_SPECIAL7
  WXK_SPECIAL8
  WXK_SPECIAL9
  WXK_SPECIAL10
  WXK_SPECIAL11
  WXK_SPECIAL12
  WXK_SPECIAL13
  WXK_SPECIAL14
  WXK_SPECIAL15
  WXK_SPECIAL16
  WXK_SPECIAL17
  WXK_SPECIAL18
  WXK_SPECIAL19
  WXK_SPECIAL20
End Enum

' This enumerates possible results of Dialog.ShowModal.
Enum wxShowModalResult
  ' YES button has been pressed.
  wxYES = &H00000002
  ' OK button has been pressed.
  wxOK = &H00000004
  ' NO button has been pressed.
  wxNO = &H00000008
  ' CANCEL button has been pressed.
  wxCANCEL = &H00000010
End Enum

' These are the flags that are used in instances of Window (and inheriting classes) to configure appearance and behaviour.
' Some enumeration instances apply to only some classes of windows. 
' The same enumeration value may be used for different enumeration instances.
' This means in general that the enumeration isntances (sharing the same value)
' shall be applied to different classes of windows.

' Note that flags are named similar to their origin in  wxWidgets but they do
' not necessarily bear the same name. Reason: Better navigation with IntelliSence.
' Example: You may Type WindowStyles.BOR to navigate through all styles referring to borders.'/

Enum Alignment
  wxALIGN_NOT = &H0000
  wxALIGN_CENTER_HORIZONTAL = &H0100
  wxALIGN_LEFT = wxALIGN_NOT
  wxALIGN_TOP = wxALIGN_NOT
  wxALIGN_RIGHT = &H0200
  wxALIGN_BOTTOM = &H0400
  wxALIGN_CENTER_VERTICAL   = &H0800
  wxALIGN_CENTER = wxALIGN_CENTER_HORIZONTAL Or wxALIGN_CENTER_VERTICAL
  wxALIGN_MASK = &H0f00
  ' Alternate spellings
  wxALIGN_CENTRE_VERTICAL = wxALIGN_CENTER_VERTICAL
  wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL
  wxALIGN_CENTRE = wxALIGN_CENTER
End Enum

Enum wxAttrKind
  wxAK_AnyAttr
  wxAK_Cell
  wxAK_Row
  wxAK_Col
End Enum

Enum wxGridSelectionModes
  wxGS_Cells
  wxGS_Rows
  wxGS_Columns
  wxGS_RowsOrColumns = wxGS_Columns Or wxGS_Rows
End Enum

Enum wxGeometryCentre
  wxCentre = &H01
  wxCenter = wxCentre
End Enum

' Represents an orientation (e.g. of a sizer)
Enum wxOrientation
  ' Horizontal orientation.
  wxHORIZONTAL = &H04
  ' Vertical orientation.
  wxVERTICAL   = &H08
  ' Both orientations horizontal and vertical.
  wxBOTH = wxVERTICAL Or wxHORIZONTAL
  wxORIENTATION_MASK = wxBOTH 
End Enum

Enum wxWindowVariant
  wxWINDOW_VARIANT_NORMAL
  wxWINDOW_VARIANT_SMALL  
  wxWINDOW_VARIANT_MINI 
  wxWINDOW_VARIANT_LARGE
End Enum

Enum wxBackgroundStyle
  wxBG_STYLE_SYSTEM
  wxBG_STYLE_COLOUR
  wxBG_STYLE_CUSTOM
End Enum

' border styles applicable to all windows.
Enum wxBorderStyle
  wxBORDER_DEFAULT = 0
  wxBORDER_NONE   = &H00200000
  wxBORDER_STATIC = &H01000000
  wxBORDER_SIMPLE = &H02000000
  wxBORDER_RAISED = &H04000000
  wxBORDER_SUNKEN = &H08000000
  wxBORDER_DOUBLE = &H10000000
  wxBORDER_MASK   = &H1f200000
  wxDOUBLE_BORDER = wxBORDER_DOUBLE
  wxSUNKEN_BORDER = wxBORDER_SUNKEN
  wxRAISED_BORDER = wxBORDER_RAISED
  wxBORDER        = wxBORDER_SIMPLE
  wxSIMPLE_BORDER = wxBORDER_SIMPLE
  wxSTATIC_BORDER = wxBORDER_STATIC
  wxNO_BORDER     = wxBORDER_NONE
End Enum

Const wxID_ANY    = -1
Const wxID_OK     = 5100
Const wxID_CANCEL = 5101
Const wxID_YES    = 5103
Const wxID_NO     = 5104
Const wxID_ABOUT  = 5013
    
Const uniqueID = 10000
Enum wxWindowStyles
  ' An empty style definition.
  ' This may be useful for some occasions As default argument.
  ' It is simply an enumeration instance for zero.
  wxNO_STYLE = 0
  
  ' Starting with wxWidgets 2.8.5 you can specify the <c>BORDER_THEME</c> style to have  wxWidgets use a themed border.
  ' Using the default XP theme this is a thin 1-pixel blue border with an extra 1-pixel border in the window
  ' client background colour (usually white) to separate the client area's scrollbars from the border.
  ' If you don't specify a border style for a wxTextCtrl in rich edit mode  wxWidgets now gives the control themed
  ' borders automatically where previously they would take the Windows 95-style sunken border. Other native controls
  ' such As wx.TextCtrl in non-rich edit mode and wxComboBox already paint themed borders where appropriate.
  ' To use themed borders on other windows such As wx.Panel pass the BORDER_THEME style.
   
  ' Note that in  wxWidgets 2.9 and above <c>BORDER_THEME</c> will be used on all platforms to indicate that there
  ' should definitely be a border whose style is determined by  wxWidgets for the current platform.
  ' wxWidgets  2.9 and above will also be better at determining whether there should be a themed border.
  ' Because of the requirements of binary compatibility this automatic border capability could not be put into
  ' wxWidgets 2.8 except for built-in native controls. In 2.8 the border must be specified for custom controls and windows.
  wxBORDER_THEME = &H10000000

  ' Use this to enable tab traversal for non-dialog windows.
  wxTAB_TRAVERSAL = &H00080000

' Use this style to force a complete redraw of the window whenever it is resized
  ' instead of redrawing just the part of the window affected by resizing.
  ' Note that this was the behaviour by default before 2.5.1 release and
  ' that if you experience redraw problems with code which previously used
  ' to work you may want to try this.
  wxFULL_REPAINT_ON_RESIZE = &H00010000

  ' Use this to indicate that the window wants to get all char/key events for all keys - 
  ' even for keys like TAB or ENTER which are usually used for dialog navigation 
  ' and which wouldn't be generated without this style.
  ' If you need to use this style in order to get the arrows or etc. but
  ' would still like to have normal keyboard navigation take place you
  ' should create and send a NavigationKeyEvent in response to the key events for Tab and Shift-Tab.
  wxWANTS_CHARS = &H00040000

  ' Use this style to enable a vertical scrollbar.
  wxVSCROLL = &H80000000
  ' Use this style to enable a horizontal scrollbar.
  wxHSCROLL = &H40000000
  ' If a window has scrollbars disable them instead of hiding them when they are not needed
  ' (i.e. when the size of the window is big enough to not require the scrollbars to navigate it).
  ' This style is currently only implemented for <c>wxMSW</c> and <c>wxUniversal</c>
  ' and does nothing on the other platforms.
  wxALWAYS_SHOW_SB = &H00800000

  ' Use this style to eliminate flicker caused by the background being repainted then children being painted over them.
  wxCLIP_CHILDREN = &H00400000
  wxCLIP_SIBLINGS = &H20000000

  ' The window is transparent that is it will not receive paint events.
  wxTRANSPARENT_WINDOW = &H00100000

  ' Set this flag to create a special popup window:
  ' it will be always shown on top of other windows will capture the mouse
  ' and will be dismissed when the mouse is clicked outside of it or if it
  ' loses focus in any other way.
  wxPOPUP_WINDOW = &H00020000

  ' A mask which can be used to filter (out) all wxWindow-specific styles.
  wxWINDOW_STYLE_MASK = wxVSCROLL Or wxHSCROLL Or wxBORDER_MASK Or wxALWAYS_SHOW_SB _
                      Or wxCLIP_CHILDREN Or wxCLIP_SIBLINGS Or wxTRANSPARENT_WINDOW _
                      Or wxTAB_TRAVERSAL Or wxWANTS_CHARS Or wxPOPUP_WINDOW _
                      Or wxFULL_REPAINT_ON_RESIZE

  ' Puts a caption on the frame. 
  ' Applicable to instances of Frame.
  wxCAPTION = &H20000000
  
  ' Displays a system menu.
  wxSYSTEM_MENU = &H00000800

  ' Display the frame iconized (minimized).
  ' Windows only. Applicable to top level windows.
  wxMINIMIZE = &H4000
  ' Displays a minimize box on the frame.
  ' Applicable to top level windows.
  wxMINIMIZE_BOX = &H00000400
  ' Displays a close box on the frame.
  ' Applicable to top level windows.
  wxCLOSE_BOX = &H1000
  ' Stay on top of all other windows.
  ' Applicable to top level windows. 
  ' Refer also to FRAME_FLOAT_ON_PARENT.
  wxSTAY_ON_TOP = &H8000
  ' Displays the frame maximized. Windows only.
  wxMAXIMIZE = &H2000
  ' Displays a maximize box on the frame.
  wxMAXIMIZE_BOX = &H0200
  ' Displays a resizeable border around the window.
  wxRESIZE_BORDER = &H00000040

  ' Comprises all those styles that apply to a frame by default.
  wxFRAME_DEFAULT_STYLE = wxSYSTEM_MENU Or wxRESIZE_BORDER _
                       Or wxMINIMIZE_BOX Or wxMAXIMIZE_BOX Or wxCAPTION _
                       Or wxCLIP_CHILDREN Or wxCLOSE_BOX

  ' Comprises those styles that apply to dialogs by default.
  wxDIALOG_DEFAULT_STYLE = wxSYSTEM_MENU Or wxCAPTION Or wxCLOSE_BOX

  ' Creates an otherwise normal frame but it does not appear in the taskbar under Windows or GTK+
  ' (note that it will minimize to the desktop window under Windows
  ' which may seem strange to the users and thus it might be better to
  ' use this style only without MINIMIZE_BOX style). In <c>wxGTK</c> the
  ' flag is respected only if GTK+ is at least version 2.2 and the
  ' window manager supports <c>_NET_WM_STATE_SKIP_TASKBAR</c> hint. Has no
  ' effect under other platforms.
  wxFRAME_NO_TASKBAR = &H0002
  ' Causes a frame with a small titlebar to be created;
  ' the frame does not appear in the taskbar under Windows or GTK+.
  wxFRAME_TOOL_WINDOW = &H0004
  ' The frame will always be on top of its parent (unlike STAY_ON_TOP).
  ' A frame created with this style must have a non-NULL parent.
  wxFRAME_FLOAT_ON_PARENT = &H0008
  ' Windows with this style are allowed to have their shape changed with the SetShape method.
  wxFRAME_SHAPED = &H0010
  ' By default a dialog created with a <c>null</c> parent window 
  ' will be given the application's top level window As parent.
  ' Use this style to prevent this from happening and create an orphan dialog.
  ' This is not recommended for modal dialogs.
  wxDIALOG_NO_PARENT = &H0001

  ' Show an YES button.
  ' This shall be used together either with DIALOG_NO or DIALOG_CANCEL.
  ' There is a wxWidgets assertion.
  wxDIALOG_YES = &H00000002
  ' Show an OK button.
  wxDIALOG_OK = &H00000004
  ' Show an NO button.
  ' This shall be used together either with DIALOG_YES.
  ' There is a wxWidgets assertion.
  wxDIALOG_NO = &H00000008
  ' Show an CANCEL button.
  wxDIALOG_CANCEL = &H00000010
  ' Show YES and NO button.
  wxDIALOG_YES_NO = wxDIALOG_YES Or wxDIALOG_NO
  ' Used with <c>DIALOG_YES</c> makes YES button the default - which is the default behaviour.'
  wxDIALOG_YES_DEFAULT = &H00000000
  ' Used with <c>DIALOG_NO</c> makes NO button the default.
  wxDIALOG_NO_DEFAULT = &H00000080

  ' Center the message.
  ' Applicable to message dialog and certain standard dialogs. (Not Windows)
  wxDIALOG_CENTRE = &H001

  ' Refer to DIALOG_CENTRE().
  wxDIALOG_CENTER=wxDIALOG_CENTRE

  ' Shows an exclamation mark icon.
  ' An icon for some standard dialogs.
  wxICON_EXCLAMATION = &H00000100
  ' Shows an error icon. 
  ' An icon for some standard dialogs.
  wxICON_HAND = &H00000200
  ' Shows an exclamation mark icon.
  ' An icon for some standard dialogs.
  wxICON_WARNING = wxICON_EXCLAMATION
  ' Shows an error icon. 
  ' An icon for some standard dialogs.
  wxICON_ERROR = wxICON_HAND
  ' Shows a question mark icon.
  ' An icon for some standard dialogs.
  wxICON_QUESTION = &H00000400
  ' An icon for some standard dialogs.
  wxICON_INFORMATION = &H00000800
  ' An icon for some standard dialogs.
  wxICON_STOP = wxICON_HAND
  ' An icon for some standard dialogs.
  wxICON_ASTERISK = wxICON_INFORMATION
  ' A bit mask for filtering those styles referring to icons.
  ' An icon for some standard dialogs.
  wxICON_MASK = &H00000100 Or &H00000200 Or &H00000400 Or &H00000800
 
  ' Default style bits for instances of wx.SingleChoiceDialog.
  wxCHOICEDLG_STYLE = wxDIALOG_DEFAULT_STYLE Or wxRESIZE_BORDER Or wxDIALOG_OK Or wxDIALOG_CANCEL Or wxDIALOG_CENTRE

  ' Default style bits for instances of wx.MDIParentFrame.
  wxMDI_FRAME_DEFAULT_STYLE = wxFRAME_DEFAULT_STYLE Or wxVSCROLL Or wxHSCROLL

  '  Style for wx.ToolBar wx.ScrollBar wx.Slider wx.RadioBox wx.Gauge wx.SpinCtrl and wx.SpinButton
  wxORIENT_HORIZONTAL = wxOrientation.wxHORIZONTAL
  ' Style for wx.ToolBar wx.ScrollBar wx.Slider wx.RadioBox wx.Gauge wx.SpinCtrl and wx.SpinButton
  wxORIENT_VERTICAL = wxOrientation.wxVERTICAL

  ' Style flag for static text and wx.StatusBar. Static text fields also use alignment flags.
  wxST_NO_AUTORESIZE = &H0001
  
  ' Flags for alignment are also used with wx.StaticText.
  wxALIGN_LEFT   = 0
  wxALIGN_RIGHT  = &H0200
  wxALIGN_CENTRE = &H0900
  wxALIGN_CENTER = wxALIGN_CENTRE
End Enum

Enum wxTextCtrtlStyle
  wxTE_NO_VSCROLL  = &H0002
  wxTE_AUTO_SCROLL = &H0008
  ' The text will not be user-editable. For instances of wx.TextCtrtl.
  wxTE_READONLY = &H0010
  ' The text control allows multiple lines. For instances of wx.TextCtrtl.
  wxTE_MULTILINE = &H0020
  ' The control will receive <c>wxEVT_CHAR</c> events for TAB pressed - normally 
  ' TAB is used for passing to the next control in a dialog instead.
  ' For the control created with this style you can still use
  ' Ctrl-Enter to pass to the next control from the keyboard. For instances of wx.TextCtrtl.
  wxTE_PROCESS_TAB = &H0040
  ' The text in the control will be left-justified (default). For instances of wx.TextCtrtl.
  wxTE_LEFT = &H0000
  ' The text in the control will be centered (currently <c>wxMSW</c> and <c>wxGTK2</c> only). For instances of wx.TextCtrtl.
  wxTE_CENTER = Alignment.wxALIGN_CENTER
  ' The text in the control will be right-justified (currently wxMSW and wxGTK2 only). 
  wxTE_RIGHT = Alignment.wxALIGN_RIGHT
  ' Use rich text control under Win32 this allows to have more than 64KB of text in the control even under Win9x.
  wxTE_RICH = &H0080
  ' The control will generate the event <c>wxEVT_COMMAND_TEXT_ENTER</c>
  ' (otherwise pressing Enter key is either processed internally by the control or used for navigation between dialog controls). 
  wxTE_PROCESS_ENTER = &H0400
  ' The text will be echoed As asterisks. For instances of wx.TextCtrtl.
  wxTE_PASSWORD   = &H0800
  ' Highlight the URLs and generate the TextUrlEvents when mouse events occur over them.
  ' This style is only supported for <c>TE_RICH</c> Win32 and multi-line <c>wxGTK2</c> text controls. 
  wxTE_AUTO_URL = &H1000
  ' Show selection even if not focussed.
  ' By default the Windows text control doesn't show the selection
  ' when it doesn't have focus - use this style to force it to always show it.
  ' It doesn't do anything under other platforms. 
  wxTE_NOHIDESEL = &H2000
  ' Wrap the lines at word boundaries or at any other character if there are words longer than the window width (this is the default). 
  wxTE_BESTWRAP = 0
  ' Tells a wx.TextCtrl to wrap lines that are too long to be displayed in the control.
  ' This is another name for the standard behaviour. Refer also to <c>TE_BESTWRAP</c>.
  wxTE_LINEWRAP = wxTE_BESTWRAP
  ' Same As <c>HSCROLL</c> style: don't wrap at all show horizontal scrollbar instead.
  wxTE_DONTWRAP   = wxWindowStyles.wxHSCROLL
  ' Wrap the lines too long to be shown entirely at any position (<c>wxUniv</c> and <c>wxGTK2</c> only). 
  wxTE_CHARWRAP = &H4000
  ' Wrap the lines too long to be shown entirely at word boundaries (<c>wxUniv</c> and <c>wxGTK2</c> only). 
  wxTE_WORDWRAP = &H0001
  ' Use rich text control version 2.0 or 3.0 under Win32.
  wxTE_RICH2 = &H8000
  ' Default style bits for instances of wx.TextEntryDialog.
  wxTE_DIALOG_STYLE = wxDIALOG_OK Or wxDIALOG_CANCEL Or wxDIALOG_CENTRE
End Enum

Enum wxTextCtrlHitTestResult
  wxTE_HT_UNKNOWN = -2 ' this means HitTest() is simply not implemented
  wxTE_HT_BEFORE       ' either to the left or upper
  wxTE_HT_ON_TEXT      ' directly on
  wxTE_HT_BELOW        ' below [the last line]
  wxTE_HT_BEYOND       ' after [the end of line]
End Enum

Enum wxTextAttrAlignment
  wxTEXT_ALIGNMENT_DEFAULT
  wxTEXT_ALIGNMENT_LEFT
  wxTEXT_ALIGNMENT_CENTER
  wxTEXT_ALIGNMENT_RIGHT
  wxTEXT_ALIGNMENT_JUSTIFIED
End Enum

Enum wxBitmapType
  wxBITMAP_TYPE_INVALID = 0
  wxBITMAP_TYPE_BMP
  wxBITMAP_TYPE_BMP_RESOURCE
  wxBITMAP_TYPE_RESOURCE = wxBITMAP_TYPE_BMP_RESOURCE
  wxBITMAP_TYPE_ICO
  wxBITMAP_TYPE_ICO_RESOURCE
  wxBITMAP_TYPE_CUR
  wxBITMAP_TYPE_CUR_RESOURCE
  wxBITMAP_TYPE_XBM
  wxBITMAP_TYPE_XBM_DATA
  wxBITMAP_TYPE_XPM
  wxBITMAP_TYPE_XPM_DATA
  wxBITMAP_TYPE_TIF
  wxBITMAP_TYPE_TIF_RESOURCE
  wxBITMAP_TYPE_GIF
  wxBITMAP_TYPE_GIF_RESOURCE
  wxBITMAP_TYPE_PNG
  wxBITMAP_TYPE_PNG_RESOURCE
  wxBITMAP_TYPE_JPEG
  wxBITMAP_TYPE_JPEG_RESOURCE
  wxBITMAP_TYPE_PNM
  wxBITMAP_TYPE_PNM_RESOURCE
  wxBITMAP_TYPE_PCX
  wxBITMAP_TYPE_PCX_RESOURCE
  wxBITMAP_TYPE_PICT
  wxBITMAP_TYPE_PICT_RESOURCE
  wxBITMAP_TYPE_ICON
  wxBITMAP_TYPE_ICON_RESOURCE
  wxBITMAP_TYPE_ANI
  wxBITMAP_TYPE_IFF
  wxBITMAP_TYPE_MACCURSOR
  wxBITMAP_TYPE_MACCURSOR_RESOURCE
  wxBITMAP_TYPE_ANY = 50
End Enum

Enum wxListBoxStyle
  wxLB_SORT      = &H0010
  wxLB_SINGLE    = &H0020
  wxLB_MULTIPLE  = &H0040
  wxLB_EXTENDED  = &H0080
  wxLB_OWNERDRAW = &H0100
  wxLB_NEED_SB   = &H0200
  wxLB_ALWAYS_SB = &H0400
  wxLB_HSCROLL   = wxHSCROLL
  wxLB_INT_HEIGHT = &H0800
End Enum

Enum wxSplahScreenStyle
  wxSS_CENTRE_ON_PARENT = &H01
  wxSS_CENTRE_ON_SCREEN = &H02
  wxSS_NO_CENTRE = &H00
  wxSS_TIMEOUT = &H04
  wxSS_NO_TIMEOUT = &H00
  ' The bits defining the default style for wx.SplahScreen.
  wxSS_DEFAULT = wxBORDER_SIMPLE Or wxFRAME_NO_TASKBAR Or wxSTAY_ON_TOP
End Enum  

Enum wxListCtrlStyle
  ' Draws light vertical rules between columns in report mode.
  wxLC_VRULES = &H0001
  ' Draws light horizontal rules between rows in report mode. 
  wxLC_HRULES = &H0002

  ' Large icon view with optional labels. 
  wxLC_ICON = &H0004
  ' Small icon view with optional labels. 
  wxLC_SMALL_ICON = &H0008
  ' Multicolumn list view with optional small icons.
  ' Columns are computed automatically i.e. you don't set columns As in wx.wxWindowStyles.LC_REPORT.
  ' In other words the list wraps unlike a wx.ListBox. Style for wx.ListCtrl.
  wxLC_LIST = &H0010
  ' Single or multicolumn report view with optional header. 
  wxLC_REPORT = &H0020
  ' Icons align to the top. Win32 default Win32 only. 
  wxLC_ALIGN_TOP = &H0040
  ' Icons align to the left. 
  wxLC_ALIGN_LEFT = &H0080
  ' Icons arrange themselves. Win32 only.
  wxLC_AUTO_ARRANGE = &H0100
  ' The application provides items text on demand.
  ' May only be used with wx.WindowsStyles.LC_REPORT. 
  wxLC_VIRTUAL = &H0200
  ' Labels are editable: the application will be notified when editing starts. 
  wxLC_EDIT_LABELS = &H0400
  ' No header in report mode. 
  wxLC_NO_HEADER = &H0800
  wxLC_NO_SORT_HEADER = &H1000
  ' Single selection (default is multiple). 
  wxLC_SINGLE_SEL = &H2000
  ' Sort in ascending order (must still supply a comparison callback in wx.ListCtrl.SortItems()). 
  wxLC_SORT_ASCENDING = &H4000
  ' Sort in descending order (must still supply a comparison callback in wx.ListCtrl.SortItems). 
  wxLC_SORT_DESCENDING = &H8000
  ' Mask of style bits defining the kind of presentation in instances of wx.ListCtrl.
  wxLC_MASK_TYPE = wxLC_ICON Or wxLC_SMALL_ICON Or wxLC_LIST Or wxLC_REPORT
  ' Mask of style bits referring to the alignment in instances of wx.ListCtrl.
  wxLC_MASK_ALIGN = wxLC_ALIGN_TOP Or wxLC_ALIGN_LEFT
  ' Mask of styles referring to sorting instances of wx.ListCtrl.
  wxLC_MASK_SORT = wxLC_SORT_ASCENDING Or wxLC_SORT_DESCENDING
End Enum


Enum wxToolBarStyle
  wxTB_3DBUTTONS = &H0010
  wxTB_FLAT      = &H0020
  wxTB_DOCKABLE  = &H0040
  wxTB_NOICONS   = &H0080
  wxTB_TEXT      = &H0100
  wxTB_NODIVIDER = &H0200
  wxTB_NOALIGN   = &H0400
End Enum

Enum wxSashWindowStyle
  wxSW_NOBORDER  = &H0000
  wxSW_BORDER    = &H0020
  wxSW_3DSASH    = &H0040
  wxSW_3DBORDER  = &H0080
  wxSW_3D = wxSW_3DSASH Or wxSW_3DBORDER
End Enum

#Define wxSASH_DRAG_NONE       0
#Define wxSASH_DRAG_DRAGGING   1
#Define wxSASH_DRAG_LEFT_DOWN  2

Enum wxSashEdgePosition
  wxSEP_TOP = 0
  wxSEP_RIGHT
  wxSEP_BOTTOM
  wxSEP_LEFT
  wxSEP_NONE = 100
End Enum

Enum wxSashDragStatus
  wxSDS_STATUS_OK
  wxSDS_STATUS_OUT_OF_RANGE
End Enum

Enum wxGaugeStyle
  wxGA_PROGRESSBAR = &H0010
  wxGA_SMOOTH = &H0020
End Enum

Enum wxSliderStyle
  wxSL_NOTIFY_DRAG = &H0000
  wxSL_TICKS       = &H0010
  wxSL_AUTOTICKS   = wxSL_TICKS
  wxSL_LABELS      = &H0020
  wxSL_LEFT        = &H0040
  wxSL_TOP         = &H0080
  wxSL_RIGHT       = &H0100
  wxSL_BOTTOM      = &H0200
  wxSL_BOTH        = &H0400
  wxSL_SELRANGE    = &H0800
End Enum

Enum wxRadioBoxStyle
  wxRA_LEFTTORIGHT  = &H0001
  wxRA_TOPTOBOTTOM  = &H0002
  wxRA_SPECIFY_COLS = wxOrientation.wxHORIZONTAL
  wxRA_SPECIFY_ROWS = wxOrientation.wxVERTICAL
End Enum

' SpinCtrl and SpinButton
Enum wxSpinCtrlStyle
  ' The user can use arrow keys to change the value. 
  wxSP_ARROW_KEYS = &H1000
  ' The value wraps at the minimum and maximum.
  wxSP_WRAP       = &H2000
End Enum

Enum wxSplitterWindowStyle
  ' A style for the turning on 3D effect for the sash.
  ' <c>SP_3D</c> combines this with  <c>SP_3BORDER</c> to turn on both 3D effects.
  wxSP_3DSASH      = &H00000100
  ' A style for the wx.SplitterWindow turning on 3D effect for borders.
  wxSP_3DBORDER    = &H00000200
  ' A style for the wx.SplitterWindow.
  wxSP_LIVE_UPDATE = &H00000080
  ' A style for the wx.SplitterWindow turning on 3D effect for borders and sash.
  wxSP_3D = wxSP_3DBORDER Or wxSP_3DSASH
End Enum
  
Enum wxCalendarCtrlStyle
  wxCC_SUNDAY_FIRST               = &H0000
  wxCC_MONDAY_FIRST               = &H0001
  wxCC_SHOW_HOLIDAYS              = &H0002
  wxCC_NO_YEAR_CHANGE             = &H0004
  wxCC_NO_MONTH_CHANGE            = &H000c
  wxCC_SEQUENTIAL_MONTH_SELECTION = &H0010
  wxCC_SHOW_SURROUNDING_WEEKS     = &H0020
End Enum

Enum wxCalendarDateBorder
  wxCDB_BORDER_NONE
  wxCDB_BORDER_SQUARE
  wxCDB_BORDER_ROUND
End Enum

Enum wxCalendarHitTestResult
  wxCHTR_HITTEST_NOWHERE
  wxCHTR_HITTEST_HEADER
  wxCHTR_HITTEST_DAY
  wxCHTR_HITTEST_INCMONTH
  wxCHTR_HITTEST_DECMONTH
  wxCHTR_HITTEST_SURROUNDING_WEEK
  wxCHTR_HITTEST_WEEK
End Enum

Enum wxProgressDialogStyle
  wxPD_CAN_ABORT      = &H0001
  wxPD_APP_MODAL      = &H0002
  wxPD_AUTO_HIDE      = &H0004
  wxPD_ELAPSED_TIME   = &H0008
  wxPD_ESTIMATED_TIME = &H0010
  wxPD_REMAINING_TIME = &H0040
End Enum

Enum wxRadioButtonStyle
  wxRB_GROUP  = &H0004
  wxRB_SINGLE = &H0008
End Enum

Enum wxNotebookStyle
  wxNB_TOP        = &H0000 ' Place tabs on the top side.
  wxNB_FIXEDWIDTH = &H0010 ' (Windows only) All tabs will have same width.
  wxNB_LEFT       = &H0020 ' Place tabs on the left side.
  wxNB_RIGHT      = &H0040 ' Place tabs on the right side.
  wxNB_BOTTOM     = &H0080 ' Place tabs under instead of above the notebook pages.
  wxNB_MULTILINE  = &H0100 ' (Windows only) There can be several rows of tabs.
End Enum
 
Enum wxTreeCtrlStyle
  ' For convenience to document that no buttons are to be drawn.
  wxTR_NO_BUTTONS         = &H0000
  ' Use this style to show + and - buttons to the left of parent items. 
  wxTR_HAS_BUTTONS        = &H0001
  ' Style for wx.TreeCtrl.
  wxTR_TWIST_BUTTONS      = &H0010
  ' Use this style to hide vertical level connectors. 
  wxTR_NO_LINES           = &H0004
  ' Use this style to show lines between root nodes.
  wxTR_LINES_AT_ROOT      = &H0008
  ' Deprecated style for wx.TreeCtrl.
  wxTR_MAC_BUTTONS        = 0
  ' Deprecated style for wx.TreeCtrl.
  wxTR_AQUA_BUTTONS       = 0
  ' This defines single selection and is standard behaviour.
  wxTR_SINGLE             = &H0000
  ' Use this style to allow a range of items to be selected.
  ' If a second range is selected the current range if any is deselected. 
  wxTR_MULTIPLE           = &H0020
  ' Use this style to allow disjoint items to be selected.
  ' (Only partially implemented; may not work in all cases.) 
  wxTR_EXTENDED           = &H0040
  ' Use this style to have the background colour and the selection highlight 
  ' extend over the entire horizontal row of the tree control window.
  ' (This flag is ignored under Windows unless you specify <c>TR_NO_LINES</c> As well.) 
  wxTR_FULL_ROW_HIGHLIGHT = &H2000
  ' Use this style if you wish the user to be able to edit labels in the tree control. 
  wxTR_EDIT_LABELS        = &H0200
  ' Use this style to draw a contrasting border between displayed rows. 
  wxTR_ROW_LINES          = &H0400
  ' Use this style to suppress the display of the root node effectively causing the first-level nodes to appear As a series of root nodes. 
  wxTR_HIDE_ROOT          = &H0800
  ' Use this style to cause row heights to be just big enough to fit the content.
  ' If not set all rows use the largest row height.
  ' Style for wx.TreeCtrl. The default is that this flag is unset. Generic only.
  wxTR_HAS_VARIABLE_ROW_HEIGHT = &H0080
End Enum

Enum wxFontCtrlStyle
  ' Turns on text edit field for point size.
  wxFONTCTRL_EDIT_POINT_SIZE  = &H0001
  ' Turns on text edit field for font family.
  wxFONTCTRL_EDIT_FONT_FAMILY = &H0002
  ' Turns on text edit field for font weight.
  wxFONTCTRL_EDIT_FONT_WEIGHT = &H0004
  ' Turns on text edit field for font style.
  wxFONTCTRL_EDIT_FONT_STYLE  = &H0008
  ' Turns on text edit field for text colour.
  wxFONTCTRL_EDIT_FONT_COLOUR = &H0010
  ' Turns on all edit fields.
  wxFONTCTRL_EDIT_ALL         = &H001f
End Enum

' Style for wx.FileDialog and wx.FileSelector
Enum wxFileDialogStyle
  ' This is a dialog requesting a file to be opened. 
  wxFD_OPEN             = &H0001
  ' This is a save dialog.
  wxFD_SAVE             = &H0002
  ' For save dialog only: prompt for a confirmation if a file will be overwritten. 
  wxFD_OVERWRITE_PROMPT = &H0004
  ' Do not display the checkbox to toggle display of read-only files.
  wxFD_HIDE_READONLY    = &H0008
  ' The user may only select files that actually exist. 
  wxFD_FILE_MUST_EXIST  = &H0010
  ' For open dialog only: allows selecting multiple files. 
  wxFD_MULTIPLE         = &H0020
  ' Show the preview of the selected files (currently only supported by wxGTK using GTK+ 2.4 or later). 
  wxFD_PREVIEW          = &H0100
  ' Two different meanings in wx.FileDialog and wx.FileSeletor.
  ' wx.FileDialog Change the current working directory to the directory where the file(s) chosen by the user are.
  ' wx.FileSelector Select a directory rather than a file.
  wxFD_CHANGE_DIR       = &H0040
End Enum

Enum wxFindReplaceDialogStyle
  ' Inititializes replace dialog (otherwise find dialog).
  wxFR_REPLACEDIALOG = 1
  ' Don't allow changing the search direction.
  ' If this is set controls for changing search direction will be disabled.
  wxFR_NOUPDOWN = 2
  ' Don't allow case sensitive searching.
  ' If this is set controls for changing relevance of letter case will be disabled.
  wxFR_NOMATCHCASE = 4
  ' don't allow whole word searching 
  ' Style flag for wx.FindReplaceDialog.
  ' If this is set controls for defining search for whole words only will be disabled.
  wxFR_NOWHOLEWORD = 8
End Enum

Enum  ' Style for wx.Choice wx.ComboBox etc.
  wxCB_SIMPLE   = &H0004
  ' Sorts the entries in the list alphabetically.
  wxCB_SORT     = &H0008
  ' Text will not be editable.
  wxCB_READONLY = &H0010
  wxCB_DROPDOWN = &H0020
End Enum

Enum wxComboCtrlStyle
  ' Button is preferred outside the border (GTK style).
  wxCC_BUTTON_OUTSIDE_BORDER = &H0001
  ' Style for wx.ComboCtrl: Show popup on mouse up instead of mouse down (which is the Windows style)'/
  wxCC_POPUP_ON_MOUSE_UP     = &H0002
  ' Style for wx.ComboCtrl: All text is not automatically selected on click
  wxCC_NO_TEXT_AUTO_SELECT   = &H0004
End Enum

Enum wxStatusBarStyle
  wxSB_NORMAL   = &H000
  wxSB_FLAT     = &H001
  wxSB_RAISED   = &H002
  wxSB_SIZEGRIP = &H010
End Enum

' Style flag for wx.Button and wx.BitmapButton.
Enum wxButtonStyle
  wxBU_EXACTFIT = &H0001
  wxBU_AUTODRAW = &H0004 ' Style flag for instances of wx.BitmapButton.
  wxBU_LEFT     = &H0040
  wxBU_TOP      = &H0080
  wxBU_RIGHT    = &H0100
  wxBU_BOTTOM   = &H0200
End Enum

' This defines the wx.GridSelectionMode of a wx.Grid.
Enum wxGridSelectionMode
  wxGRID_SELECT_CELLS   = 0
  wxGRID_SELECT_ROWS    = 1
  wxGRID_SELECT_COLUMNS = 2
End Enum

Enum wxGeneric
  ' wx.GenericForm.GenericFormPanel.
  ' Specifies that a generic form will not be user-editable. 
  wxGENERICFORM_READONLY = &H0010
End Enum

Enum wxDatePickerCtrlStyle
  ' Default style on this platform either <c>DP_SPIN</c> or <c>DP_DROPDOWN</c>.
  wxDP_DEFAULT = 0
  ' A spin control-like date picker (not supported in generic version)
  wxDP_SPIN = 1
  ' A combobox-like date picker (not supported in mac version)
  wxDP_DROPDOWN = 2
  ' Always show century in the default date display
  ' (otherwise it depends on the system date format which may include the century or not)
  wxDP_SHOWCENTURY = 4
  ' Allow not having any valid date in the control
  ' (by default it always has some date today initially if no valid date specified in ctor)
  wxDP_ALLOWNONE = 8
End Enum

Enum wxColourPickerCtrlStyle
  wxCLRP_DEFAULT_STYLE = 0
  ' Creates a text control to the left of the picker button which is completely managed by the wx.ColourPickerCtrl
  ' and which can be used by the user to specify a colour (see <c>SetColour</c>).
  ' The text control is automatically synchronized with button's value.
  wxCLRP_USE_TEXTCTRL = 2
  ' Shows the colour in HTML form (AABBCC) As colour button label (instead of no label at all).
  wxCLRP_SHOW_LABEL = 8
End Enum

Enum wxFontPickerCtrlStyle
  ' Keeps the label of the button updated with the fontface name and font size.
  ' E.g. choosing "Times New Roman bold italic with size 10" from the fontdialog
  ' updates the button label (overwriting any previous label)
  ' with the "Times New Roman 10" text (only fontface + fontsize is displayed to avoid extralong labels).
  wxFNTP_FONTDESC_AS_LABEL = 8
  ' Uses the currently selected font to draw the label of the button.
  wxFNTP_USEFONT_FOR_LABEL = &H0010
  ' Creates a text control to the left of the picker button which is completely managed by the wx.FontPickerCtrl
  ' and which can be used by the user to specify a font. The text control is automatically synchronized with button's value.
  wxFNTP_USE_TEXTCTRL = 2

  ' Default style for wx.FontPickerCtrl.
  ' Currently <c>FNTP_FONTDESC_AS_LABEL</c> or FNTP_USEFONT_FOR_LABEL i.e. if <c>FNTP_USE_TEXTCTRL</c> is active
  ' then use a textual description of the font As label and display it in the selected font.'/
  wxFNTP_DEFAULT_STYLE = wxFNTP_FONTDESC_AS_LABEL Or wxFNTP_USEFONT_FOR_LABEL
End Enum

Enum wxDirDialogFlag
  ' Equivalent to a combination of DEFAULT_DIALOG_STYLE and RESIZE_BORDER (the last one is not used under wxWinCE).
  wxDD_DEFAULT_STYLE = wxDIALOG_DEFAULT_STYLE Or wxRESIZE_BORDER
  ' The dialog will allow the user to choose only an existing folder. When this style is not given a "Create new directory"
  ' button is added to the dialog (on Windows) or some other way is provided to the user to Type the name of a new folder.
  wxDD_DIR_MUST_EXIST = &H0200
  ' Change the current working directory to the directory chosen by the user.
  wxDD_CHANGE_DIR = &H0100
End Enum

Enum wxCheckBoxState
  ' Create a 2-state checkbox. This is the default.  
  wxCHK_2STATE = &H0000
  ' Create a 3-state checkbox. Not implemented in wxMGL wxOS2 and wxGTK built against GTK+ 1.2.  
  wxCHK_3STATE = &H1000
  ' By default a user can't set a 3-state checkbox to the third state. It can only be done from code. Using this flags allows the user to set the checkbox to the third state by clicking.  
  wxCHK_ALLOW_3RD_STATE_FOR_USER = &H2000
  ' Makes the text appear on the left of the checkbox.  
  wxCHK_ALIGN_RIGHT=Alignment.wxALIGN_RIGHT
End Enum

' Represent a direction. Used to specify dynamic layouts.
Enum wxDirection
  wxLEFT   = &H0010
  wxRIGHT  = &H0020
  wxUP     = &H0040
  wxDOWN   = &H0080
  wxTOP    = wxUP
  wxBOTTOM = wxDOWN
  wxNORTH  = wxUP
  wxSOUTH  = wxDOWN
  wxWEST   = wxLEFT
  wxEAST   = wxRIGHT
  wxALL    = wxUP Or wxDOWN Or wxRIGHT Or wxLEFT
  wxDIRECTION_MASK = wxALL
End Enum

' Used to define how polygons will be filled. cf. wx.DC.
Enum wxFillRule
  wxODDEVEN_RULE = 1
  wxWINDING_RULE
End Enum

' Used to define the background mode in wx.DC.
Enum wxBackgroundMode
  wxSOLID       = 100
  wxTRANSPARENT = 106
End Enum

Enum wxFontStyle
  wxDEFAULT    = 70
  wxDECORATIVE
  wxROMAN
  wxSCRIPT
  wxSWISS
  wxMODERN
  wxTELETYPE

  wxVARIABLE   = 80
  wxFIXED

  wxNORMAL     = 90
  wxLIGHT
  wxBOLD
  wxITALIC
  wxSLANT
End Enum

Enum wxPenStyle
  wxSOLID = 100
  wxDOT
  wxLONG_DASH
  wxSHORT_DASH
  wxDOT_DASH
  wxUSER_DASH
  wxTRANSPARENT
  wxSTIPPLE_MASK_OPAQUE
  wxSTIPPLE_MASK

  wxSTIPPLE = 110
  wxBDIAGONAL_HATCH
  wxCROSSDIAG_HATCH
  wxFDIAGONAL_HATCH
  wxCROSS_HATCH
  wxHORIZONTAL_HATCH
  wxVERTICAL_HATCH
  wxFIRST_HATCH = wxBDIAGONAL_HATCH
  wxLAST_HATCH  = wxVERTICAL_HATCH
End Enum

Enum wxJoinStyle
  wxJOIN_BEVEL = 120
  wxJOIN_MITER
  wxJOIN_ROUND
End Enum

Enum wxCapStyle
  wxCAP_ROUND = 130
  wxCAP_PROJECTING
  wxCAP_BUTT
End Enum

Enum wxPolygonFillStyle
  wxODDEVEN_RULE = 1
  wxWINDING_RULE
End Enum

' Operations to merge pixels for instance on blitting an image onto another.
Enum wxRASTEROPS
  wxCLEAR
  wxROP_BLACK        = wxCLEAR
  wxBLIT_BLACKNESS   = wxCLEAR       ' 0
  wxXOR
  wxROP_XORPEN       = wxXOR
  wxBLIT_SRCINVERT   = wxXOR         ' src XOR dst
  wxINVERT
  wxROP_NOT          = wxINVERT
  wxBLIT_DSTINVERT   = wxINVERT      ' NOT dst
  wxOR_REVERSE
  wxROP_MERGEPENNOT  = wxOR_REVERSE
  wxBLIT_00DD0228    = wxOR_REVERSE  ' src OR (NOT dst)
  wxAND_REVERSE
  wxROP_MASKPENNOT   = wxAND_REVERSE
  wxBLIT_SRCERASE    = wxAND_REVERSE ' src AND (NOT dst)
  wxCOPY     
  wxROP_COPYPEN      = wxCOPY
  wxBLIT_SRCCOPY     = wxCOPY        ' src
  wxAND    
  wxROP_MASKPEN      = wxAND
  wxBLIT_SRCAND      = wxAND         ' src AND dst
  wxAND_INVERT 
  wxROP_MASKNOTPEN   = wxAND_INVERT 
  wxBLIT_00220326    = wxAND_INVERT  ' (NOT src) AND dst
  wxNO_OP    
  wxROP_NOP          = wxNO_OP
  wxBLIT_00AA0029    = wxNO_OP       ' dst
  wxNOR    
  wxROP_NOTMERGEPEN  = wxNOR
  wxBLIT_NOTSRCERASE = wxNOR         ' (NOT src) AND (NOT dst)
  wxEQUIV    
  wxROP_NOTXORPEN    = wxEQUIV
  wxBLIT_00990066    = wxEQUIV       ' (NOT src) XOR dst
  wxSRC_INVERT 
  wxROP_NOTCOPYPEN   = wxSRC_INVERT
  wxBLIT_NOTSCRCOPY  = wxSRC_INVERT  ' (NOT src)
  wxOR_INVERT  
  wxROP_MERGENOTPEN  = wxOR_INVERT
  wxBLIT_MERGEPAINT  = wxOR_INVERT   ' (NOT src) OR dst
  wxNAND     
  wxROP_NOTMASKPEN   = wxNAND
  wxBLIT_007700E6    = wxNAND        ' (NOT src) OR (NOT dst)
  wxOR     
  wxROP_MERGEPEN     = wxOR
  wxBLIT_SRCPAINT    = wxOR          ' src OR dst
  wxSET    
  wxROP_WHITE        = wxSET
  wxBLIT_WHITENESS   = wxSET         ' 1
End Enum

' Stretching behaviour in dynamic layouts. Refer to wx.Sizer.
Enum wxStretchStyle
  wxSTRETCH_NOT     = &H0000
  wxSHRINK          = &H1000
  wxGROW            = &H2000
  wxEXPAND          = wxGROW
  wxSHAPED          = &H4000
  wxFIXED_MINSIZE   = &H8000
  wxTILE            = &Hc000
 ' changed in wxWidgets 2.5.2 see discussion on wx-dev
  wxADJUST_MINSIZE  = &H0000
End Enum

' Flags from <c>wx.Stretch</c> <c>wx.Direction</c> and <c>wx.Alignment</c>.
' This will be used in instances of wx.Sizer when adding new windows.
Enum wxSizerStyle
  ' No flag at all. If unique specifies default behaviour.
  wxNo_FLAG = 0
  wxLEFT =  wxDirection.wxLEFT
  wxRIGHT = wxDirection.wxRIGHT
  wxUP = wxDirection.wxUP
  wxDOWN = wxDirection.wxDOWN
  wxTOP = wxDirection.wxUP
  wxBOTTOM = wxDirection.wxBOTTOM
  wxNORTH = wxDirection.wxUP
  wxSOUTH = wxDirection.wxDOWN
  wxWEST = wxLEFT
  wxEAST = wxRIGHT
  wxALL = wxUP Or wxDOWN Or wxRIGHT Or wxLEFT
  wxSTRETCH_NOT = wxStretchStyle.wxSTRETCH_NOT
  wxSHRINK = wxStretchStyle.wxSHRINK
  wxGROW = wxStretchStyle.wxGROW
  wxEXPAND = wxStretchStyle.wxEXPAND
  wxSHAPED = wxStretchStyle.wxSHAPED
  wxFIXED_MINSIZE = wxStretchStyle.wxFIXED_MINSIZE
  wxTILE = wxStretchStyle.wxTILE

  ' This is a flag on stretching. refer to Stretch.
  ' changed in wxWidgets 2.5.2 see discussion on wx-dev
  wxADJUST_MINSIZE = &H0000

  ' This flag is on alignment. Refer to Alignment.
  wxALIGN_NOT = Alignment.wxALIGN_NOT
  wxALIGN_CENTER_HORIZONTAL = Alignment.wxALIGN_CENTRE_HORIZONTAL
  wxALIGN_LEFT = Alignment.wxALIGN_NOT
  wxALIGN_TOP = Alignment.wxALIGN_NOT
  wxALIGN_RIGHT = Alignment.wxALIGN_RIGHT
  wxALIGN_BOTTOM = Alignment.wxALIGN_BOTTOM
  wxALIGN_CENTER_VERTICAL = Alignment.wxALIGN_CENTRE_VERTICAL
  wxALIGN_CENTER = wxALIGN_CENTER_HORIZONTAL Or wxALIGN_CENTER_VERTICAL
  wxALIGN_MASK = Alignment.wxALIGN_MASK
  wxALIGN_CENTRE_VERTICAL = Alignment.wxALIGN_CENTER_VERTICAL
  wxALIGN_CENTRE_HORIZONTAL = Alignment.wxALIGN_CENTER_HORIZONTAL
  wxALIGN_CENTRE = Alignment.wxALIGN_CENTER
End Enum

Enum wxItemKind
  wxITEM_SEPARATOR = -1
  wxITEM_NORMAL
  wxITEM_CHECK
  wxITEM_RADIO
  wxITEM_MAX
End Enum

Enum wxFloodStyle
  wxFLOOD_SURFACE = 1
  wxFLOOD_BORDER  = 2
End Enum
  
' Enumeration of mouse buttons.
Enum wxMouseButton
  wxANYBUTTON = -1
  wxNONE      = 0
  wxLeft      = 1
  wxMIDDLE    = 2
  wxRight     = 3
End Enum

Enum wxUpdateUIMode
  ' Send UI update events to all windows
  wxUPDATE_UI_PROCESS_ALL
  ' Send UI update events to windows that have
  ' the wxWS_EX_PROCESS_UI_UPDATES flag specified
  wxUPDATE_UI_PROCESS_SPECIFIED
End Enum

Enum wxFontFamily
  wxFONTFAMILY_DEFAULT    = wxDEFAULT
  wxFONTFAMILY_DECORATIVE = wxDECORATIVE
  wxFONTFAMILY_ROMAN      = wxROMAN
  wxFONTFAMILY_SCRIPT     = wxSCRIPT
  wxFONTFAMILY_SWISS      = wxSWISS
  wxFONTFAMILY_MODERN     = wxMODERN
  wxFONTFAMILY_TELETYPE   = wxTELETYPE
  wxFONTFAMILY_MAX
End Enum

Enum wxFontWeight
  wxFONTWEIGHT_NORMAL = wxNORMAL
  wxFONTWEIGHT_LIGHT  = wxLIGHT
  wxFONTWEIGHT_BOLD   = wxBOLD
  wxFONTWEIGHT_MAX
End Enum

Enum wxFontFlags
  ' no special flags: font with default weight/slant/anti-aliasing
  wxFONTFLAG_DEFAULT          = 0
  ' slant flags (default: no slant)
  wxFONTFLAG_ITALIC           = 1 Shl 0
  wxFONTFLAG_SLANT            = 1 Shl 1
  ' weight flags (default: medium)
  wxFONTFLAG_LIGHT            = 1 Shl 2
  wxFONTFLAG_BOLD             = 1 Shl 3
  ' anti-aliasing flag: force on or off (default: the current system default)
  wxFONTFLAG_ANTIALIASED      = 1 Shl 4
  wxFONTFLAG_NOT_ANTIALIASED  = 1 Shl 5
  ' underlined/strikethrough flags (default: no lines)
  wxFONTFLAG_UNDERLINED       = 1 Shl 6
  wxFONTFLAG_STRIKETHROUGH    = 1 Shl 7
End Enum

Enum wxFontEncoding
  wxFONTENCODING_SYSTEM = -1 ' system default
  wxFONTENCODING_DEFAULT     ' current default encoding

  ' ISO8859 standard defines a number of single-byte charsets
  wxFONTENCODING_ISO8859_1   ' West European (Latin1)
  wxFONTENCODING_ISO8859_2   ' Central and East European (Latin2)
  wxFONTENCODING_ISO8859_3   ' Esperanto (Latin3)
  wxFONTENCODING_ISO8859_4   ' Baltic (old) (Latin4)
  wxFONTENCODING_ISO8859_5   ' Cyrillic
  wxFONTENCODING_ISO8859_6   ' Arabic
  wxFONTENCODING_ISO8859_7   ' Greek
  wxFONTENCODING_ISO8859_8   ' Hebrew
  wxFONTENCODING_ISO8859_9   ' Turkish (Latin5)
  wxFONTENCODING_ISO8859_10  ' Variation of Latin4 (Latin6)
  wxFONTENCODING_ISO8859_11  ' Thai
  wxFONTENCODING_ISO8859_12  ' doesn't exist currently but put it
          ' here anyhow to make all ISO8859
          ' consecutive numbers
  wxFONTENCODING_ISO8859_13  ' Baltic (Latin7)
  wxFONTENCODING_ISO8859_14  ' Latin8
  wxFONTENCODING_ISO8859_15  ' Latin9 (a.k.a. Latin0 includes euro)
  wxFONTENCODING_ISO8859_MAX

  ' Cyrillic charset soup (see http:'czyborra.com/charsets/cyrillic.html)
  wxFONTENCODING_KOI8    ' we don't support any of KOI8 variants
  wxFONTENCODING_ALTERNATIVE ' same As MS-DOS CP866
  wxFONTENCODING_BULGARIAN   ' used under Linux in Bulgaria

  ' what would we do without Microsoft? They have their own encodings
  ' for DOS
  wxFONTENCODING_CP437     ' original MS-DOS codepage
  wxFONTENCODING_CP850     ' CP437 merged with Latin1
  wxFONTENCODING_CP852     ' CP437 merged with Latin2
  wxFONTENCODING_CP855     ' another cyrillic encoding
  wxFONTENCODING_CP866     ' and another one
  ' and for Windows
  wxFONTENCODING_CP874     ' WinThai
  wxFONTENCODING_CP1250    ' WinLatin2
  wxFONTENCODING_CP1251    ' WinCyrillic
  wxFONTENCODING_CP1252    ' WinLatin1
  wxFONTENCODING_CP1253    ' WinGreek (8859-7)
  wxFONTENCODING_CP1254    ' WinTurkish
  wxFONTENCODING_CP1255    ' WinHebrew
  wxFONTENCODING_CP1256    ' WinArabic
  wxFONTENCODING_CP1257    ' WinBaltic (same As Latin 7)
  wxFONTENCODING_CP12_MAX

  wxFONTENCODING_UTF7      ' UTF-7 Unicode encoding
  wxFONTENCODING_UTF8      ' UTF-8 Unicode encoding

  wxFONTENCODING_UNICODE   ' Unicode - currently used only by wxEncodingConverter class
  wxFONTENCODING_MAX
End Enum

Enum wxSystemFont
  wxSYS_OEM_FIXED_FONT = 10
  wxSYS_ANSI_FIXED_FONT
  wxSYS_ANSI_VAR_FONT
  wxSYS_SYSTEM_FONT
  wxSYS_DEVICE_DEFAULT_FONT
  wxSYS_DEFAULT_PALETTE
  wxSYS_SYSTEM_FIXED_FONT
  wxSYS_DEFAULT_GUI_FONT
End Enum

Enum wxSystemColour
  wxSYS_COLOUR_SCROLLBAR
  wxSYS_COLOUR_BACKGROUND
  wxSYS_COLOUR_DESKTOP = wxSYS_COLOUR_BACKGROUND
  wxSYS_COLOUR_ACTIVECAPTION
  wxSYS_COLOUR_INACTIVECAPTION
  wxSYS_COLOUR_MENU
  wxSYS_COLOUR_WINDOW
  wxSYS_COLOUR_WINDOWFRAME
  wxSYS_COLOUR_MENUTEXT
  wxSYS_COLOUR_WINDOWTEXT
  wxSYS_COLOUR_CAPTIONTEXT
  wxSYS_COLOUR_ACTIVEBORDER
  wxSYS_COLOUR_INACTIVEBORDER
  wxSYS_COLOUR_APPWORKSPACE
  wxSYS_COLOUR_HIGHLIGHT
  wxSYS_COLOUR_HIGHLIGHTTEXT
  wxSYS_COLOUR_BTNFACE
  wxSYS_COLOUR_3DFACE = wxSYS_COLOUR_BTNFACE
  wxSYS_COLOUR_BTNSHADOW
  wxSYS_COLOUR_3DSHADOW = wxSYS_COLOUR_BTNSHADOW
  wxSYS_COLOUR_GRAYTEXT
  wxSYS_COLOUR_BTNTEXT
  wxSYS_COLOUR_INACTIVECAPTIONTEXT
  wxSYS_COLOUR_BTNHIGHLIGHT
  wxSYS_COLOUR_BTNHILIGHT  = wxSYS_COLOUR_BTNHIGHLIGHT
  wxSYS_COLOUR_3DHIGHLIGHT = wxSYS_COLOUR_BTNHIGHLIGHT
  wxSYS_COLOUR_3DHILIGHT   = wxSYS_COLOUR_BTNHIGHLIGHT
  wxSYS_COLOUR_3DDKSHADOW
  wxSYS_COLOUR_3DLIGHT
  wxSYS_COLOUR_INFOTEXT
  wxSYS_COLOUR_INFOBK
  wxSYS_COLOUR_LISTBOX
  wxSYS_COLOUR_HOTLIGHT
  wxSYS_COLOUR_GRADIENTACTIVECAPTION
  wxSYS_COLOUR_GRADIENTINACTIVECAPTION
  wxSYS_COLOUR_MENUHILIGHT
  wxSYS_COLOUR_MENUBAR

  wxSYS_COLOUR_MAX
End Enum

Enum wxSystemMetric
  wxSYS_MOUSE_BUTTONS = 1
  wxSYS_BORDER_X
  wxSYS_BORDER_Y
  wxSYS_CURSOR_X
  wxSYS_CURSOR_Y
  wxSYS_DCLICK_X
  wxSYS_DCLICK_Y
  wxSYS_DRAG_X
  wxSYS_DRAG_Y
  wxSYS_EDGE_X
  wxSYS_EDGE_Y
  wxSYS_HSCROLL_ARROW_X
  wxSYS_HSCROLL_ARROW_Y
  wxSYS_HTHUMB_X
  wxSYS_ICON_X
  wxSYS_ICON_Y
  wxSYS_ICONSPACING_X
  wxSYS_ICONSPACING_Y
  wxSYS_WINDOWMIN_X
  wxSYS_WINDOWMIN_Y
  wxSYS_SCREEN_X
  wxSYS_SCREEN_Y
  wxSYS_FRAMESIZE_X
  wxSYS_FRAMESIZE_Y
  wxSYS_SMALLICON_X
  wxSYS_SMALLICON_Y
  wxSYS_HSCROLL_Y
  wxSYS_VSCROLL_X
  wxSYS_VSCROLL_ARROW_X
  wxSYS_VSCROLL_ARROW_Y
  wxSYS_VTHUMB_Y
  wxSYS_CAPTION_Y
  wxSYS_MENU_Y
  wxSYS_NETWORK_PRESENT
  wxSYS_PENWINDOWS_PRESENT
  wxSYS_SHOW_SOUNDS
  wxSYS_SWAP_BUTTONS
End Enum

Enum wxSystemFeature
  wxSYS_CAN_DRAW_FRAME_DECORATIONS = 1
  wxSYS_CAN_ICONIZE_FRAME
End Enum

Enum wxSystemScreenType
  wxSYS_SCREEN_NONE = 0
  wxSYS_SCREEN_TINY
  wxSYS_SCREEN_PDA
  wxSYS_SCREEN_SMALL
  wxSYS_SCREEN_DESKTOP
End Enum

' ----------------------------------------------------------------------
'  STC constants generated section {{{

#Define wxSTC_INVALID_POSITION -1

'  Define start of Scintilla messages To be greater than all Windows edit (EM_*) messages
'  As many EM_ messages can be used although that use Is deprecated.
#Define wxSTC_START 2000
#Define wxSTC_OPTIONAL_START 3000
#Define wxSTC_LEXER_START 4000
#Define wxSTC_WS_INVISIBLE 0
#Define wxSTC_WS_VISIBLEALWAYS 1
#Define wxSTC_WS_VISIBLEAFTERINDENT 2
#Define wxSTC_EOL_CRLF 0
#Define wxSTC_EOL_CR 1
#Define wxSTC_EOL_LF 2

'  The SC_CP_UTF8 value can be used To enter Unicode mode.
'  This Is the same value As CP_UTF8 in Windows
#Define wxSTC_CP_UTF8 65001

'  The SC_CP_DBCS value can be used To indicate a DBCS mode For GTK+.
#Define wxSTC_CP_DBCS 1
#Define wxSTC_MARKER_MAX 31
#Define wxSTC_MARK_CIRCLE 0
#Define wxSTC_MARK_ROUNDRECT 1
#Define wxSTC_MARK_ARROW 2
#Define wxSTC_MARK_SMALLRECT 3
#Define wxSTC_MARK_SHORTARROW 4
#Define wxSTC_MARK_EMPTY 5
#Define wxSTC_MARK_ARROWDOWN 6
#Define wxSTC_MARK_MINUS 7
#Define wxSTC_MARK_PLUS 8

'  Shapes used For outlining column.
#Define wxSTC_MARK_VLINE 9
#Define wxSTC_MARK_LCORNER 10
#Define wxSTC_MARK_TCORNER 11
#Define wxSTC_MARK_BOXPLUS 12
#Define wxSTC_MARK_BOXPLUSCONNECTED 13
#Define wxSTC_MARK_BOXMINUS 14
#Define wxSTC_MARK_BOXMINUSCONNECTED 15
#Define wxSTC_MARK_LCORNERCURVE 16
#Define wxSTC_MARK_TCORNERCURVE 17
#Define wxSTC_MARK_CIRCLEPLUS 18
#Define wxSTC_MARK_CIRCLEPLUSCONNECTED 19
#Define wxSTC_MARK_CIRCLEMINUS 20
#Define wxSTC_MARK_CIRCLEMINUSCONNECTED 21

'  Invisible mark that only sets the Line background color.
#Define wxSTC_MARK_BACKGROUND 22
#Define wxSTC_MARK_DOTDOTDOT 23
#Define wxSTC_MARK_ARROWS 24
#Define wxSTC_MARK_PIXMAP 25
#Define wxSTC_MARK_FULLRECT 26
#Define wxSTC_MARK_LEFTRECT 27
#Define wxSTC_MARK_AVAILABLE 28
#Define wxSTC_MARK_UNDERLINE 29
#Define wxSTC_MARK_CHARACTER 10000

'  Markers used For outlining column.
#Define wxSTC_MARKNUM_FOLDEREND 25
#Define wxSTC_MARKNUM_FOLDEROPENMID 26
#Define wxSTC_MARKNUM_FOLDERMIDTAIL 27
#Define wxSTC_MARKNUM_FOLDERTAIL 28
#Define wxSTC_MARKNUM_FOLDERSUB 29
#Define wxSTC_MARKNUM_FOLDER 30
#Define wxSTC_MARKNUM_FOLDEROPEN 31
#Define wxSTC_MASK_FOLDERS &hFE000000
#Define wxSTC_MARGIN_SYMBOL 0
#Define wxSTC_MARGIN_NUMBER 1
#Define wxSTC_MARGIN_BACK 2
#Define wxSTC_MARGIN_FORE 3
#Define wxSTC_MARGIN_TEXT 4
#Define wxSTC_MARGIN_RTEXT 5

'  Styles in range 32..38 are predefined For parts of the UI And are Not used As normal styles.
'  Style 39 Is For future use.
#Define wxSTC_STYLE_DEFAULT 32
#Define wxSTC_STYLE_LINENUMBER 33
#Define wxSTC_STYLE_BRACELIGHT 34
#Define wxSTC_STYLE_BRACEBAD 35
#Define wxSTC_STYLE_CONTROLCHAR 36
#Define wxSTC_STYLE_INDENTGUIDE 37
#Define wxSTC_STYLE_CALLTIP 38
#Define wxSTC_STYLE_LASTPREDEFINED 39
#Define wxSTC_STYLE_MAX 255

'  Character set identifiers are used in StyleSetCharacterSet.
'  The values are the same As the Windows *_CHARSET values.
#Define wxSTC_CHARSET_ANSI 0
#Define wxSTC_CHARSET_DEFAULT 1
#Define wxSTC_CHARSET_BALTIC 186
#Define wxSTC_CHARSET_CHINESEBIG5 136
#Define wxSTC_CHARSET_EASTEUROPE 238
#Define wxSTC_CHARSET_GB2312 134
#Define wxSTC_CHARSET_GREEK 161
#Define wxSTC_CHARSET_HANGUL 129
#Define wxSTC_CHARSET_MAC 77
#Define wxSTC_CHARSET_OEM 255
#Define wxSTC_CHARSET_RUSSIAN 204
#Define wxSTC_CHARSET_CYRILLIC 1251
#Define wxSTC_CHARSET_SHIFTJIS 128
#Define wxSTC_CHARSET_SYMBOL 2
#Define wxSTC_CHARSET_TURKISH 162
#Define wxSTC_CHARSET_JOHAB 130
#Define wxSTC_CHARSET_HEBREW 177
#Define wxSTC_CHARSET_ARABIC 178
#Define wxSTC_CHARSET_VIETNAMESE 163
#Define wxSTC_CHARSET_THAI 222
#Define wxSTC_CHARSET_8859_15 1000
#Define wxSTC_CASE_MIXED 0
#Define wxSTC_CASE_UPPER 1
#Define wxSTC_CASE_LOWER 2

'  Indicator style enumeration And some constants
#Define wxSTC_INDIC_PLAIN 0
#Define wxSTC_INDIC_SQUIGGLE 1
#Define wxSTC_INDIC_TT 2
#Define wxSTC_INDIC_DIAGONAL 3
#Define wxSTC_INDIC_STRIKE 4
#Define wxSTC_INDIC_HIDDEN 5
#Define wxSTC_INDIC_BOX 6
#Define wxSTC_INDIC_ROUNDBOX 7
#Define wxSTC_INDIC_MAX 31
#Define wxSTC_INDIC_CONTAINER 8
#Define wxSTC_INDIC0_MASK &h20
#Define wxSTC_INDIC1_MASK &h40
#Define wxSTC_INDIC2_MASK &h80
#Define wxSTC_INDICS_MASK &hE0
#Define wxSTC_IV_NONE 0
#Define wxSTC_IV_REAL 1
#Define wxSTC_IV_LOOKFORWARD 2
#Define wxSTC_IV_LOOKBOTH 3

'  PrintColourMode - use same colours As screen.
#Define wxSTC_PRINT_NORMAL 0

'  PrintColourMode - invert the light value of each style For printing.
#Define wxSTC_PRINT_INVERTLIGHT 1

'  PrintColourMode - force black text On white background For printing.
#Define wxSTC_PRINT_BLACKONWHITE 2

'  PrintColourMode - text stays coloured, but all background Is forced To be white For printing.
#Define wxSTC_PRINT_COLOURONWHITE 3

'  PrintColourMode - only the default-background Is forced To be white For printing.
#Define wxSTC_PRINT_COLOURONWHITEDEFAULTBG 4
#Define wxSTC_FIND_WHOLEWORD 2
#Define wxSTC_FIND_MATCHCASE 4
#Define wxSTC_FIND_WORDSTART &h00100000
#Define wxSTC_FIND_REGEXP &h00200000
#Define wxSTC_FIND_POSIX &h00400000
#Define wxSTC_FOLDLEVELBASE &h400
#Define wxSTC_FOLDLEVELWHITEFLAG &h1000
#Define wxSTC_FOLDLEVELHEADERFLAG &h2000
#Define wxSTC_FOLDLEVELNUMBERMASK &h0FFF
#Define wxSTC_FOLDFLAG_LINEBEFORE_EXPANDED &h0002
#Define wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED &h0004
#Define wxSTC_FOLDFLAG_LINEAFTER_EXPANDED &h0008
#Define wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED &h0010
#Define wxSTC_FOLDFLAG_LEVELNUMBERS &h0040
#Define wxSTC_TIME_FOREVER 10000000
#Define wxSTC_WRAP_NONE 0
#Define wxSTC_WRAP_WORD 1
#Define wxSTC_WRAP_CHAR 2
#Define wxSTC_WRAPVISUALFLAG_NONE &h0000
#Define wxSTC_WRAPVISUALFLAG_END &h0001
#Define wxSTC_WRAPVISUALFLAG_START &h0002
#Define wxSTC_WRAPVISUALFLAGLOC_DEFAULT &h0000
#Define wxSTC_WRAPVISUALFLAGLOC_END_BY_TEXT &h0001
#Define wxSTC_WRAPVISUALFLAGLOC_START_BY_TEXT &h0002
#Define wxSTC_WRAPINDENT_FIXED 0
#Define wxSTC_WRAPINDENT_SAME 1
#Define wxSTC_WRAPINDENT_INDENT 2
#Define wxSTC_CACHE_NONE 0
#Define wxSTC_CACHE_CARET 1
#Define wxSTC_CACHE_PAGE 2
#Define wxSTC_CACHE_DOCUMENT 3

'  Control font anti-aliasing.
#Define wxSTC_EFF_QUALITY_MASK &hF
#Define wxSTC_EFF_QUALITY_DEFAULT 0
#Define wxSTC_EFF_QUALITY_NON_ANTIALIASED 1
#Define wxSTC_EFF_QUALITY_ANTIALIASED 2
#Define wxSTC_EFF_QUALITY_LCD_OPTIMIZED 3
#Define wxSTC_EDGE_NONE 0
#Define wxSTC_EDGE_LINE 1
#Define wxSTC_EDGE_BACKGROUND 2
#Define wxSTC_STATUS_OK 0
#Define wxSTC_STATUS_FAILURE 1
#Define wxSTC_STATUS_BADALLOC 2
#Define wxSTC_CURSORNORMAL -1
#Define wxSTC_CURSORWAIT 4

'  Constants For use With SetVisiblePolicy, similar To SetCaretPolicy.
#Define wxSTC_VISIBLE_SLOP &h01
#Define wxSTC_VISIBLE_STRICT &h04

'  Caret policy, used by SetXCaretPolicy And SetYCaretPolicy.
'  If CARET_SLOP Is set, we can define a slop value: caretSlop.
'  This value defines an unwanted zone (UZ) where the caret is... unwanted.
'  This zone Is Defined As a number of pixels near the vertical margins,
'  And As a number of lines near the horizontal margins.
'  By keeping the caret away from the edges, it Is seen within its context,
'  so it Is likely that the identifier that the caret Is On can be completely seen,
'  And that the current Line Is seen With some of the lines following it which are
'  often dependent On that line.
#Define wxSTC_CARET_SLOP &h01

'  If CARET_STRICT Is set, the policy Is enforced... strictly.
'  The caret Is centred On the display If slop Is Not set,
'  And cannot go in the UZ If slop Is set.
#Define wxSTC_CARET_STRICT &h04

'  If CARET_JUMPS Is set, the display Is moved more energetically
'  so the caret can move in the same direction longer before the policy Is applied again.
#Define wxSTC_CARET_JUMPS &h10

'  If CARET_EVEN Is Not set, instead of having symmetrical UZs,
'  the Left And bottom UZs are extended up To Right And top UZs respectively.
'  This way, we favour the displaying of useful information: the begining of lines,
'  where most code reside, And the lines after the caret, eg. the body of a function.
#Define wxSTC_CARET_EVEN &h08
#Define wxSTC_SEL_STREAM 0
#Define wxSTC_SEL_RECTANGLE 1
#Define wxSTC_SEL_LINES 2
#Define wxSTC_SEL_THIN 3
#Define wxSTC_ALPHA_TRANSPARENT 0
#Define wxSTC_ALPHA_OPAQUE 255
#Define wxSTC_ALPHA_NOALPHA 256
#Define wxSTC_CARETSTYLE_INVISIBLE 0
#Define wxSTC_CARETSTYLE_LINE 1
#Define wxSTC_CARETSTYLE_BLOCK 2
#Define wxSTC_ANNOTATION_HIDDEN 0
#Define wxSTC_ANNOTATION_STANDARD 1
#Define wxSTC_ANNOTATION_BOXED 2
#Define wxSTC_UNDO_MAY_COALESCE 1
#Define wxSTC_SCVS_NONE 0
#Define wxSTC_SCVS_RECTANGULARSELECTION 1
#Define wxSTC_SCVS_USERACCESSIBLE 2

'  Maximum value of keywordSet parameter of SetKeyWords.
#Define wxSTC_KEYWORDSET_MAX 8

'  Notifications
'  Type of modification And the action which caused the modification.
'  These are Defined As a Bit mask To make it easy To specify which notifications are wanted.
'  One Bit Is set from each of SC_MOD_* And SC_PERFORMED_*.
#Define wxSTC_MOD_INSERTTEXT &h1
#Define wxSTC_MOD_DELETETEXT &h2
#Define wxSTC_MOD_CHANGESTYLE &h4
#Define wxSTC_MOD_CHANGEFOLD &h8
#Define wxSTC_PERFORMED_USER &h10
#Define wxSTC_PERFORMED_UNDO &h20
#Define wxSTC_PERFORMED_REDO &h40
#Define wxSTC_MULTISTEPUNDOREDO &h80
#Define wxSTC_LASTSTEPINUNDOREDO &h100
#Define wxSTC_MOD_CHANGEMARKER &h200
#Define wxSTC_MOD_BEFOREINSERT &h400
#Define wxSTC_MOD_BEFOREDELETE &h800
#Define wxSTC_MULTILINEUNDOREDO &h1000
#Define wxSTC_STARTACTION &h2000
#Define wxSTC_MOD_CHANGEINDICATOR &h4000
#Define wxSTC_MOD_CHANGELINESTATE &h8000
#Define wxSTC_MOD_CHANGEMARGIN &h10000
#Define wxSTC_MOD_CHANGEANNOTATION &h20000
#Define wxSTC_MOD_CONTAINER &h40000
#Define wxSTC_MODEVENTMASKALL &h7FFFF

'  Symbolic key codes And modifier flags.
'  ASCII And other printable characters below 256.
'  Extended keys above 300.
#Define wxSTC_KEY_DOWN 300
#Define wxSTC_KEY_UP 301
#Define wxSTC_KEY_LEFT 302
#Define wxSTC_KEY_RIGHT 303
#Define wxSTC_KEY_HOME 304
#Define wxSTC_KEY_END 305
#Define wxSTC_KEY_PRIOR 306
#Define wxSTC_KEY_NEXT 307
#Define wxSTC_KEY_DELETE 308
#Define wxSTC_KEY_INSERT 309
#Define wxSTC_KEY_ESCAPE 7
#Define wxSTC_KEY_BACK 8
#Define wxSTC_KEY_TAB 9
#Define wxSTC_KEY_RETURN 13
#Define wxSTC_KEY_ADD 310
#Define wxSTC_KEY_SUBTRACT 311
#Define wxSTC_KEY_DIVIDE 312
#Define wxSTC_KEY_WIN 313
#Define wxSTC_KEY_RWIN 314
#Define wxSTC_KEY_MENU 315
#Define wxSTC_SCMOD_NORM 0
#Define wxSTC_SCMOD_SHIFT 1
#Define wxSTC_SCMOD_CTRL 2
#Define wxSTC_SCMOD_ALT 4
#Define wxSTC_SCMOD_SUPER 8

'  For SciLexer.h
#Define wxSTC_LEX_CONTAINER 0
#Define wxSTC_LEX_NULL 1
#Define wxSTC_LEX_PYTHON 2
#Define wxSTC_LEX_CPP 3
#Define wxSTC_LEX_HTML 4
#Define wxSTC_LEX_XML 5
#Define wxSTC_LEX_PERL 6
#Define wxSTC_LEX_SQL 7
#Define wxSTC_LEX_VB 8
#Define wxSTC_LEX_PROPERTIES 9
#Define wxSTC_LEX_ERRORLIST 10
#Define wxSTC_LEX_MAKEFILE 11
#Define wxSTC_LEX_BATCH 12
#Define wxSTC_LEX_XCODE 13
#Define wxSTC_LEX_LATEX 14
#Define wxSTC_LEX_LUA 15
#Define wxSTC_LEX_DIFF 16
#Define wxSTC_LEX_CONF 17
#Define wxSTC_LEX_PASCAL 18
#Define wxSTC_LEX_AVE 19
#Define wxSTC_LEX_ADA 20
#Define wxSTC_LEX_LISP 21
#Define wxSTC_LEX_RUBY 22
#Define wxSTC_LEX_EIFFEL 23
#Define wxSTC_LEX_EIFFELKW 24
#Define wxSTC_LEX_TCL 25
#Define wxSTC_LEX_NNCRONTAB 26
#Define wxSTC_LEX_BULLANT 27
#Define wxSTC_LEX_VBSCRIPT 28
#Define wxSTC_LEX_BAAN 31
#Define wxSTC_LEX_MATLAB 32
#Define wxSTC_LEX_SCRIPTOL 33
#Define wxSTC_LEX_ASM 34
#Define wxSTC_LEX_CPPNOCASE 35
#Define wxSTC_LEX_FORTRAN 36
#Define wxSTC_LEX_F77 37
#Define wxSTC_LEX_CSS 38
#Define wxSTC_LEX_POV 39
#Define wxSTC_LEX_LOUT 40
#Define wxSTC_LEX_ESCRIPT 41
#Define wxSTC_LEX_PS 42
#Define wxSTC_LEX_NSIS 43
#Define wxSTC_LEX_MMIXAL 44
#Define wxSTC_LEX_CLW 45
#Define wxSTC_LEX_CLWNOCASE 46
#Define wxSTC_LEX_LOT 47
#Define wxSTC_LEX_YAML 48
#Define wxSTC_LEX_TEX 49
#Define wxSTC_LEX_METAPOST 50
#Define wxSTC_LEX_POWERBASIC 51
#Define wxSTC_LEX_FORTH 52
#Define wxSTC_LEX_ERLANG 53
#Define wxSTC_LEX_OCTAVE 54
#Define wxSTC_LEX_MSSQL 55
#Define wxSTC_LEX_VERILOG 56
#Define wxSTC_LEX_KIX 57
#Define wxSTC_LEX_GUI4CLI 58
#Define wxSTC_LEX_SPECMAN 59
#Define wxSTC_LEX_AU3 60
#Define wxSTC_LEX_APDL 61
#Define wxSTC_LEX_BASH 62
#Define wxSTC_LEX_ASN1 63
#Define wxSTC_LEX_VHDL 64
#Define wxSTC_LEX_CAML 65
#Define wxSTC_LEX_BLITZBASIC 66
#Define wxSTC_LEX_PUREBASIC 67
#Define wxSTC_LEX_HASKELL 68
#Define wxSTC_LEX_PHPSCRIPT 69
#Define wxSTC_LEX_TADS3 70
#Define wxSTC_LEX_REBOL 71
#Define wxSTC_LEX_SMALLTALK 72
#Define wxSTC_LEX_FLAGSHIP 73
#Define wxSTC_LEX_CSOUND 74
#Define wxSTC_LEX_FREEBASIC 75
#Define wxSTC_LEX_INNOSETUP 76
#Define wxSTC_LEX_OPAL 77
#Define wxSTC_LEX_SPICE 78
#Define wxSTC_LEX_D 79
#Define wxSTC_LEX_CMAKE 80
#Define wxSTC_LEX_GAP 81
#Define wxSTC_LEX_PLM 82
#Define wxSTC_LEX_PROGRESS 83
#Define wxSTC_LEX_ABAQUS 84
#Define wxSTC_LEX_ASYMPTOTE 85
#Define wxSTC_LEX_R 86
#Define wxSTC_LEX_MAGIK 87
#Define wxSTC_LEX_POWERSHELL 88
#Define wxSTC_LEX_MYSQL 89
#Define wxSTC_LEX_PO 90
#Define wxSTC_LEX_TAL 91
#Define wxSTC_LEX_COBOL 92
#Define wxSTC_LEX_TACL 93
#Define wxSTC_LEX_SORCUS 94
#Define wxSTC_LEX_POWERPRO 95
#Define wxSTC_LEX_NIMROD 96
#Define wxSTC_LEX_SML 97
#Define wxSTC_LEX_MARKDOWN 98

'  When a lexer specifies its language As SCLEX_AUTOMATIC it receives a
'  value assigned in sequence from SCLEX_AUTOMATIC+1.
#Define wxSTC_LEX_AUTOMATIC 1000

'  Lexical states For SCLEX_PYTHON
#Define wxSTC_P_DEFAULT 0
#Define wxSTC_P_COMMENTLINE 1
#Define wxSTC_P_NUMBER 2
#Define wxSTC_P_STRING 3
#Define wxSTC_P_CHARACTER 4
#Define wxSTC_P_WORD 5
#Define wxSTC_P_TRIPLE 6
#Define wxSTC_P_TRIPLEDOUBLE 7
#Define wxSTC_P_CLASSNAME 8
#Define wxSTC_P_DEFNAME 9
#Define wxSTC_P_OPERATOR 10
#Define wxSTC_P_IDENTIFIER 11
#Define wxSTC_P_COMMENTBLOCK 12
#Define wxSTC_P_STRINGEOL 13
#Define wxSTC_P_WORD2 14
#Define wxSTC_P_DECORATOR 15

'  Lexical states For SCLEX_CPP
#Define wxSTC_C_DEFAULT 0
#Define wxSTC_C_COMMENT 1
#Define wxSTC_C_COMMENTLINE 2
#Define wxSTC_C_COMMENTDOC 3
#Define wxSTC_C_NUMBER 4
#Define wxSTC_C_WORD 5
#Define wxSTC_C_STRING 6
#Define wxSTC_C_CHARACTER 7
#Define wxSTC_C_UUID 8
#Define wxSTC_C_PREPROCESSOR 9
#Define wxSTC_C_OPERATOR 10
#Define wxSTC_C_IDENTIFIER 11
#Define wxSTC_C_STRINGEOL 12
#Define wxSTC_C_VERBATIM 13
#Define wxSTC_C_REGEX 14
#Define wxSTC_C_COMMENTLINEDOC 15
#Define wxSTC_C_WORD2 16
#Define wxSTC_C_COMMENTDOCKEYWORD 17
#Define wxSTC_C_COMMENTDOCKEYWORDERROR 18
#Define wxSTC_C_GLOBALCLASS 19

'  Lexical states For SCLEX_D
#Define wxSTC_D_DEFAULT 0
#Define wxSTC_D_COMMENT 1
#Define wxSTC_D_COMMENTLINE 2
#Define wxSTC_D_COMMENTDOC 3
#Define wxSTC_D_COMMENTNESTED 4
#Define wxSTC_D_NUMBER 5
#Define wxSTC_D_WORD 6
#Define wxSTC_D_WORD2 7
#Define wxSTC_D_WORD3 8
#Define wxSTC_D_TYPEDEF 9
#Define wxSTC_D_STRING 10
#Define wxSTC_D_STRINGEOL 11
#Define wxSTC_D_CHARACTER 12
#Define wxSTC_D_OPERATOR 13
#Define wxSTC_D_IDENTIFIER 14
#Define wxSTC_D_COMMENTLINEDOC 15
#Define wxSTC_D_COMMENTDOCKEYWORD 16
#Define wxSTC_D_COMMENTDOCKEYWORDERROR 17
#Define wxSTC_D_STRINGB 18
#Define wxSTC_D_STRINGR 19
#Define wxSTC_D_WORD5 20
#Define wxSTC_D_WORD6 21
#Define wxSTC_D_WORD7 22

'  Lexical states For SCLEX_TCL
#Define wxSTC_TCL_DEFAULT 0
#Define wxSTC_TCL_COMMENT 1
#Define wxSTC_TCL_COMMENTLINE 2
#Define wxSTC_TCL_NUMBER 3
#Define wxSTC_TCL_WORD_IN_QUOTE 4
#Define wxSTC_TCL_IN_QUOTE 5
#Define wxSTC_TCL_OPERATOR 6
#Define wxSTC_TCL_IDENTIFIER 7
#Define wxSTC_TCL_SUBSTITUTION 8
#Define wxSTC_TCL_SUB_BRACE 9
#Define wxSTC_TCL_MODIFIER 10
#Define wxSTC_TCL_EXPAND 11
#Define wxSTC_TCL_WORD 12
#Define wxSTC_TCL_WORD2 13
#Define wxSTC_TCL_WORD3 14
#Define wxSTC_TCL_WORD4 15
#Define wxSTC_TCL_WORD5 16
#Define wxSTC_TCL_WORD6 17
#Define wxSTC_TCL_WORD7 18
#Define wxSTC_TCL_WORD8 19
#Define wxSTC_TCL_COMMENT_BOX 20
#Define wxSTC_TCL_BLOCK_COMMENT 21

'  Lexical states For SCLEX_HTML, SCLEX_XML
#Define wxSTC_H_DEFAULT 0
#Define wxSTC_H_TAG 1
#Define wxSTC_H_TAGUNKNOWN 2
#Define wxSTC_H_ATTRIBUTE 3
#Define wxSTC_H_ATTRIBUTEUNKNOWN 4
#Define wxSTC_H_NUMBER 5
#Define wxSTC_H_DOUBLESTRING 6
#Define wxSTC_H_SINGLESTRING 7
#Define wxSTC_H_OTHER 8
#Define wxSTC_H_COMMENT 9
#Define wxSTC_H_ENTITY 10

'  XML And ASP
#Define wxSTC_H_TAGEND 11
#Define wxSTC_H_XMLSTART 12
#Define wxSTC_H_XMLEND 13
#Define wxSTC_H_SCRIPT 14
#Define wxSTC_H_ASP 15
#Define wxSTC_H_ASPAT 16
#Define wxSTC_H_CDATA 17
#Define wxSTC_H_QUESTION 18

'  More HTML
#Define wxSTC_H_VALUE 19

'  X-Code
#Define wxSTC_H_XCCOMMENT 20

'  SGML
#Define wxSTC_H_SGML_DEFAULT 21
#Define wxSTC_H_SGML_COMMAND 22
#Define wxSTC_H_SGML_1ST_PARAM 23
#Define wxSTC_H_SGML_DOUBLESTRING 24
#Define wxSTC_H_SGML_SIMPLESTRING 25
#Define wxSTC_H_SGML_ERROR 26
#Define wxSTC_H_SGML_SPECIAL 27
#Define wxSTC_H_SGML_ENTITY 28
#Define wxSTC_H_SGML_COMMENT 29
#Define wxSTC_H_SGML_1ST_PARAM_COMMENT 30
#Define wxSTC_H_SGML_BLOCK_DEFAULT 31

'  Embedded Javascript
#Define wxSTC_HJ_START 40
#Define wxSTC_HJ_DEFAULT 41
#Define wxSTC_HJ_COMMENT 42
#Define wxSTC_HJ_COMMENTLINE 43
#Define wxSTC_HJ_COMMENTDOC 44
#Define wxSTC_HJ_NUMBER 45
#Define wxSTC_HJ_WORD 46
#Define wxSTC_HJ_KEYWORD 47
#Define wxSTC_HJ_DOUBLESTRING 48
#Define wxSTC_HJ_SINGLESTRING 49
#Define wxSTC_HJ_SYMBOLS 50
#Define wxSTC_HJ_STRINGEOL 51
#Define wxSTC_HJ_REGEX 52

'  ASP Javascript
#Define wxSTC_HJA_START 55
#Define wxSTC_HJA_DEFAULT 56
#Define wxSTC_HJA_COMMENT 57
#Define wxSTC_HJA_COMMENTLINE 58
#Define wxSTC_HJA_COMMENTDOC 59
#Define wxSTC_HJA_NUMBER 60
#Define wxSTC_HJA_WORD 61
#Define wxSTC_HJA_KEYWORD 62
#Define wxSTC_HJA_DOUBLESTRING 63
#Define wxSTC_HJA_SINGLESTRING 64
#Define wxSTC_HJA_SYMBOLS 65
#Define wxSTC_HJA_STRINGEOL 66
#Define wxSTC_HJA_REGEX 67

'  Embedded VBScript
#Define wxSTC_HB_START 70
#Define wxSTC_HB_DEFAULT 71
#Define wxSTC_HB_COMMENTLINE 72
#Define wxSTC_HB_NUMBER 73
#Define wxSTC_HB_WORD 74
#Define wxSTC_HB_STRING 75
#Define wxSTC_HB_IDENTIFIER 76
#Define wxSTC_HB_STRINGEOL 77

'  ASP VBScript
#Define wxSTC_HBA_START 80
#Define wxSTC_HBA_DEFAULT 81
#Define wxSTC_HBA_COMMENTLINE 82
#Define wxSTC_HBA_NUMBER 83
#Define wxSTC_HBA_WORD 84
#Define wxSTC_HBA_STRING 85
#Define wxSTC_HBA_IDENTIFIER 86
#Define wxSTC_HBA_STRINGEOL 87

'  Embedded Python
#Define wxSTC_HP_START 90
#Define wxSTC_HP_DEFAULT 91
#Define wxSTC_HP_COMMENTLINE 92
#Define wxSTC_HP_NUMBER 93
#Define wxSTC_HP_STRING 94
#Define wxSTC_HP_CHARACTER 95
#Define wxSTC_HP_WORD 96
#Define wxSTC_HP_TRIPLE 97
#Define wxSTC_HP_TRIPLEDOUBLE 98
#Define wxSTC_HP_CLASSNAME 99
#Define wxSTC_HP_DEFNAME 100
#Define wxSTC_HP_OPERATOR 101
#Define wxSTC_HP_IDENTIFIER 102

'  PHP
#Define wxSTC_HPHP_COMPLEX_VARIABLE 104

'  ASP Python
#Define wxSTC_HPA_START 105
#Define wxSTC_HPA_DEFAULT 106
#Define wxSTC_HPA_COMMENTLINE 107
#Define wxSTC_HPA_NUMBER 108
#Define wxSTC_HPA_STRING 109
#Define wxSTC_HPA_CHARACTER 110
#Define wxSTC_HPA_WORD 111
#Define wxSTC_HPA_TRIPLE 112
#Define wxSTC_HPA_TRIPLEDOUBLE 113
#Define wxSTC_HPA_CLASSNAME 114
#Define wxSTC_HPA_DEFNAME 115
#Define wxSTC_HPA_OPERATOR 116
#Define wxSTC_HPA_IDENTIFIER 117

'  PHP
#Define wxSTC_HPHP_DEFAULT 118
#Define wxSTC_HPHP_HSTRING 119
#Define wxSTC_HPHP_SIMPLESTRING 120
#Define wxSTC_HPHP_WORD 121
#Define wxSTC_HPHP_NUMBER 122
#Define wxSTC_HPHP_VARIABLE 123
#Define wxSTC_HPHP_COMMENT 124
#Define wxSTC_HPHP_COMMENTLINE 125
#Define wxSTC_HPHP_HSTRING_VARIABLE 126
#Define wxSTC_HPHP_OPERATOR 127

'  Lexical states For SCLEX_PERL
#Define wxSTC_PL_DEFAULT 0
#Define wxSTC_PL_ERROR 1
#Define wxSTC_PL_COMMENTLINE 2
#Define wxSTC_PL_POD 3
#Define wxSTC_PL_NUMBER 4
#Define wxSTC_PL_WORD 5
#Define wxSTC_PL_STRING 6
#Define wxSTC_PL_CHARACTER 7
#Define wxSTC_PL_PUNCTUATION 8
#Define wxSTC_PL_PREPROCESSOR 9
#Define wxSTC_PL_OPERATOR 10
#Define wxSTC_PL_IDENTIFIER 11
#Define wxSTC_PL_SCALAR 12
#Define wxSTC_PL_ARRAY 13
#Define wxSTC_PL_HASH 14
#Define wxSTC_PL_SYMBOLTABLE 15
#Define wxSTC_PL_VARIABLE_INDEXER 16
#Define wxSTC_PL_REGEX 17
#Define wxSTC_PL_REGSUBST 18
#Define wxSTC_PL_LONGQUOTE 19
#Define wxSTC_PL_BACKTICKS 20
#Define wxSTC_PL_DATASECTION 21
#Define wxSTC_PL_HERE_DELIM 22
#Define wxSTC_PL_HERE_Q 23
#Define wxSTC_PL_HERE_QQ 24
#Define wxSTC_PL_HERE_QX 25
#Define wxSTC_PL_STRING_Q 26
#Define wxSTC_PL_STRING_QQ 27
#Define wxSTC_PL_STRING_QX 28
#Define wxSTC_PL_STRING_QR 29
#Define wxSTC_PL_STRING_QW 30
#Define wxSTC_PL_POD_VERB 31
#Define wxSTC_PL_SUB_PROTOTYPE 40
#Define wxSTC_PL_FORMAT_IDENT 41
#Define wxSTC_PL_FORMAT 42

'  Lexical states For SCLEX_RUBY
#Define wxSTC_RB_DEFAULT 0
#Define wxSTC_RB_ERROR 1
#Define wxSTC_RB_COMMENTLINE 2
#Define wxSTC_RB_POD 3
#Define wxSTC_RB_NUMBER 4
#Define wxSTC_RB_WORD 5
#Define wxSTC_RB_STRING 6
#Define wxSTC_RB_CHARACTER 7
#Define wxSTC_RB_CLASSNAME 8
#Define wxSTC_RB_DEFNAME 9
#Define wxSTC_RB_OPERATOR 10
#Define wxSTC_RB_IDENTIFIER 11
#Define wxSTC_RB_REGEX 12
#Define wxSTC_RB_GLOBAL 13
#Define wxSTC_RB_SYMBOL 14
#Define wxSTC_RB_MODULE_NAME 15
#Define wxSTC_RB_INSTANCE_VAR 16
#Define wxSTC_RB_CLASS_VAR 17
#Define wxSTC_RB_BACKTICKS 18
#Define wxSTC_RB_DATASECTION 19
#Define wxSTC_RB_HERE_DELIM 20
#Define wxSTC_RB_HERE_Q 21
#Define wxSTC_RB_HERE_QQ 22
#Define wxSTC_RB_HERE_QX 23
#Define wxSTC_RB_STRING_Q 24
#Define wxSTC_RB_STRING_QQ 25
#Define wxSTC_RB_STRING_QX 26
#Define wxSTC_RB_STRING_QR 27
#Define wxSTC_RB_STRING_QW 28
#Define wxSTC_RB_WORD_DEMOTED 29
#Define wxSTC_RB_STDIN 30
#Define wxSTC_RB_STDOUT 31
#Define wxSTC_RB_STDERR 40
#Define wxSTC_RB_UPPER_BOUND 41

'  Lexical states For SCLEX_VB, SCLEX_VBSCRIPT, SCLEX_POWERBASIC
#Define wxSTC_B_DEFAULT 0
#Define wxSTC_B_COMMENT 1
#Define wxSTC_B_NUMBER 2
#Define wxSTC_B_KEYWORD 3
#Define wxSTC_B_STRING 4
#Define wxSTC_B_PREPROCESSOR 5
#Define wxSTC_B_OPERATOR 6
#Define wxSTC_B_IDENTIFIER 7
#Define wxSTC_B_DATE 8
#Define wxSTC_B_STRINGEOL 9
#Define wxSTC_B_KEYWORD2 10
#Define wxSTC_B_KEYWORD3 11
#Define wxSTC_B_KEYWORD4 12
#Define wxSTC_B_CONSTANT 13
#Define wxSTC_B_ASM 14
#Define wxSTC_B_LABEL 15
#Define wxSTC_B_ERROR 16
#Define wxSTC_B_HEXNUMBER 17
#Define wxSTC_B_BINNUMBER 18

'  Lexical states For SCLEX_PROPERTIES
#Define wxSTC_PROPS_DEFAULT 0
#Define wxSTC_PROPS_COMMENT 1
#Define wxSTC_PROPS_SECTION 2
#Define wxSTC_PROPS_ASSIGNMENT 3
#Define wxSTC_PROPS_DEFVAL 4
#Define wxSTC_PROPS_KEY 5

'  Lexical states For SCLEX_LATEX
#Define wxSTC_L_DEFAULT 0
#Define wxSTC_L_COMMAND 1
#Define wxSTC_L_TAG 2
#Define wxSTC_L_MATH 3
#Define wxSTC_L_COMMENT 4

'  Lexical states For SCLEX_LUA
#Define wxSTC_LUA_DEFAULT 0
#Define wxSTC_LUA_COMMENT 1
#Define wxSTC_LUA_COMMENTLINE 2
#Define wxSTC_LUA_COMMENTDOC 3
#Define wxSTC_LUA_NUMBER 4
#Define wxSTC_LUA_WORD 5
#Define wxSTC_LUA_STRING 6
#Define wxSTC_LUA_CHARACTER 7
#Define wxSTC_LUA_LITERALSTRING 8
#Define wxSTC_LUA_PREPROCESSOR 9
#Define wxSTC_LUA_OPERATOR 10
#Define wxSTC_LUA_IDENTIFIER 11
#Define wxSTC_LUA_STRINGEOL 12
#Define wxSTC_LUA_WORD2 13
#Define wxSTC_LUA_WORD3 14
#Define wxSTC_LUA_WORD4 15
#Define wxSTC_LUA_WORD5 16
#Define wxSTC_LUA_WORD6 17
#Define wxSTC_LUA_WORD7 18
#Define wxSTC_LUA_WORD8 19

'  Lexical states For SCLEX_ERRORLIST
#Define wxSTC_ERR_DEFAULT 0
#Define wxSTC_ERR_PYTHON 1
#Define wxSTC_ERR_GCC 2
#Define wxSTC_ERR_MS 3
#Define wxSTC_ERR_CMD 4
#Define wxSTC_ERR_BORLAND 5
#Define wxSTC_ERR_PERL 6
#Define wxSTC_ERR_NET 7
#Define wxSTC_ERR_LUA 8
#Define wxSTC_ERR_CTAG 9
#Define wxSTC_ERR_DIFF_CHANGED 10
#Define wxSTC_ERR_DIFF_ADDITION 11
#Define wxSTC_ERR_DIFF_DELETION 12
#Define wxSTC_ERR_DIFF_MESSAGE 13
#Define wxSTC_ERR_PHP 14
#Define wxSTC_ERR_ELF 15
#Define wxSTC_ERR_IFC 16
#Define wxSTC_ERR_IFORT 17
#Define wxSTC_ERR_ABSF 18
#Define wxSTC_ERR_TIDY 19
#Define wxSTC_ERR_JAVA_STACK 20
#Define wxSTC_ERR_VALUE 21

'  Lexical states For SCLEX_BATCH
#Define wxSTC_BAT_DEFAULT 0
#Define wxSTC_BAT_COMMENT 1
#Define wxSTC_BAT_WORD 2
#Define wxSTC_BAT_LABEL 3
#Define wxSTC_BAT_HIDE 4
#Define wxSTC_BAT_COMMAND 5
#Define wxSTC_BAT_IDENTIFIER 6
#Define wxSTC_BAT_OPERATOR 7

'  Lexical states For SCLEX_MAKEFILE
#Define wxSTC_MAKE_DEFAULT 0
#Define wxSTC_MAKE_COMMENT 1
#Define wxSTC_MAKE_PREPROCESSOR 2
#Define wxSTC_MAKE_IDENTIFIER 3
#Define wxSTC_MAKE_OPERATOR 4
#Define wxSTC_MAKE_TARGET 5
#Define wxSTC_MAKE_IDEOL 9

'  Lexical states For SCLEX_DIFF
#Define wxSTC_DIFF_DEFAULT 0
#Define wxSTC_DIFF_COMMENT 1
#Define wxSTC_DIFF_COMMAND 2
#Define wxSTC_DIFF_HEADER 3
#Define wxSTC_DIFF_POSITION 4
#Define wxSTC_DIFF_DELETED 5
#Define wxSTC_DIFF_ADDED 6
#Define wxSTC_DIFF_CHANGED 7

'  Lexical states For SCLEX_CONF (Apache Configuration Files Lexer)
#Define wxSTC_CONF_DEFAULT 0
#Define wxSTC_CONF_COMMENT 1
#Define wxSTC_CONF_NUMBER 2
#Define wxSTC_CONF_IDENTIFIER 3
#Define wxSTC_CONF_EXTENSION 4
#Define wxSTC_CONF_PARAMETER 5
#Define wxSTC_CONF_STRING 6
#Define wxSTC_CONF_OPERATOR 7
#Define wxSTC_CONF_IP 8
#Define wxSTC_CONF_DIRECTIVE 9

'  Lexical states For SCLEX_AVE, Avenue
#Define wxSTC_AVE_DEFAULT 0
#Define wxSTC_AVE_COMMENT 1
#Define wxSTC_AVE_NUMBER 2
#Define wxSTC_AVE_WORD 3
#Define wxSTC_AVE_STRING 6
#Define wxSTC_AVE_ENUM 7
#Define wxSTC_AVE_STRINGEOL 8
#Define wxSTC_AVE_IDENTIFIER 9
#Define wxSTC_AVE_OPERATOR 10
#Define wxSTC_AVE_WORD1 11
#Define wxSTC_AVE_WORD2 12
#Define wxSTC_AVE_WORD3 13
#Define wxSTC_AVE_WORD4 14
#Define wxSTC_AVE_WORD5 15
#Define wxSTC_AVE_WORD6 16

'  Lexical states For SCLEX_ADA
#Define wxSTC_ADA_DEFAULT 0
#Define wxSTC_ADA_WORD 1
#Define wxSTC_ADA_IDENTIFIER 2
#Define wxSTC_ADA_NUMBER 3
#Define wxSTC_ADA_DELIMITER 4
#Define wxSTC_ADA_CHARACTER 5
#Define wxSTC_ADA_CHARACTEREOL 6
#Define wxSTC_ADA_STRING 7
#Define wxSTC_ADA_STRINGEOL 8
#Define wxSTC_ADA_LABEL 9
#Define wxSTC_ADA_COMMENTLINE 10
#Define wxSTC_ADA_ILLEGAL 11

'  Lexical states For SCLEX_BAAN
#Define wxSTC_BAAN_DEFAULT 0
#Define wxSTC_BAAN_COMMENT 1
#Define wxSTC_BAAN_COMMENTDOC 2
#Define wxSTC_BAAN_NUMBER 3
#Define wxSTC_BAAN_WORD 4
#Define wxSTC_BAAN_STRING 5
#Define wxSTC_BAAN_PREPROCESSOR 6
#Define wxSTC_BAAN_OPERATOR 7
#Define wxSTC_BAAN_IDENTIFIER 8
#Define wxSTC_BAAN_STRINGEOL 9
#Define wxSTC_BAAN_WORD2 10

'  Lexical states For SCLEX_LISP
#Define wxSTC_LISP_DEFAULT 0
#Define wxSTC_LISP_COMMENT 1
#Define wxSTC_LISP_NUMBER 2
#Define wxSTC_LISP_KEYWORD 3
#Define wxSTC_LISP_KEYWORD_KW 4
#Define wxSTC_LISP_SYMBOL 5
#Define wxSTC_LISP_STRING 6
#Define wxSTC_LISP_STRINGEOL 8
#Define wxSTC_LISP_IDENTIFIER 9
#Define wxSTC_LISP_OPERATOR 10
#Define wxSTC_LISP_SPECIAL 11
#Define wxSTC_LISP_MULTI_COMMENT 12

'  Lexical states For SCLEX_EIFFEL And SCLEX_EIFFELKW
#Define wxSTC_EIFFEL_DEFAULT 0
#Define wxSTC_EIFFEL_COMMENTLINE 1
#Define wxSTC_EIFFEL_NUMBER 2
#Define wxSTC_EIFFEL_WORD 3
#Define wxSTC_EIFFEL_STRING 4
#Define wxSTC_EIFFEL_CHARACTER 5
#Define wxSTC_EIFFEL_OPERATOR 6
#Define wxSTC_EIFFEL_IDENTIFIER 7
#Define wxSTC_EIFFEL_STRINGEOL 8

'  Lexical states For SCLEX_NNCRONTAB (nnCron crontab Lexer)
#Define wxSTC_NNCRONTAB_DEFAULT 0
#Define wxSTC_NNCRONTAB_COMMENT 1
#Define wxSTC_NNCRONTAB_TASK 2
#Define wxSTC_NNCRONTAB_SECTION 3
#Define wxSTC_NNCRONTAB_KEYWORD 4
#Define wxSTC_NNCRONTAB_MODIFIER 5
#Define wxSTC_NNCRONTAB_ASTERISK 6
#Define wxSTC_NNCRONTAB_NUMBER 7
#Define wxSTC_NNCRONTAB_STRING 8
#Define wxSTC_NNCRONTAB_ENVIRONMENT 9
#Define wxSTC_NNCRONTAB_IDENTIFIER 10

'  Lexical states For SCLEX_FORTH (Forth Lexer)
#Define wxSTC_FORTH_DEFAULT 0
#Define wxSTC_FORTH_COMMENT 1
#Define wxSTC_FORTH_COMMENT_ML 2
#Define wxSTC_FORTH_IDENTIFIER 3
#Define wxSTC_FORTH_CONTROL 4
#Define wxSTC_FORTH_KEYWORD 5
#Define wxSTC_FORTH_DEFWORD 6
#Define wxSTC_FORTH_PREWORD1 7
#Define wxSTC_FORTH_PREWORD2 8
#Define wxSTC_FORTH_NUMBER 9
#Define wxSTC_FORTH_STRING 10
#Define wxSTC_FORTH_LOCALE 11

'  Lexical states For SCLEX_MATLAB
#Define wxSTC_MATLAB_DEFAULT 0
#Define wxSTC_MATLAB_COMMENT 1
#Define wxSTC_MATLAB_COMMAND 2
#Define wxSTC_MATLAB_NUMBER 3
#Define wxSTC_MATLAB_KEYWORD 4

'  Single quoted String
#Define wxSTC_MATLAB_STRING 5
#Define wxSTC_MATLAB_OPERATOR 6
#Define wxSTC_MATLAB_IDENTIFIER 7
#Define wxSTC_MATLAB_DOUBLEQUOTESTRING 8

'  Lexical states For SCLEX_SCRIPTOL
#Define wxSTC_SCRIPTOL_DEFAULT 0
#Define wxSTC_SCRIPTOL_WHITE 1
#Define wxSTC_SCRIPTOL_COMMENTLINE 2
#Define wxSTC_SCRIPTOL_PERSISTENT 3
#Define wxSTC_SCRIPTOL_CSTYLE 4
#Define wxSTC_SCRIPTOL_COMMENTBLOCK 5
#Define wxSTC_SCRIPTOL_NUMBER 6
#Define wxSTC_SCRIPTOL_STRING 7
#Define wxSTC_SCRIPTOL_CHARACTER 8
#Define wxSTC_SCRIPTOL_STRINGEOL 9
#Define wxSTC_SCRIPTOL_KEYWORD 10
#Define wxSTC_SCRIPTOL_OPERATOR 11
#Define wxSTC_SCRIPTOL_IDENTIFIER 12
#Define wxSTC_SCRIPTOL_TRIPLE 13
#Define wxSTC_SCRIPTOL_CLASSNAME 14
#Define wxSTC_SCRIPTOL_PREPROCESSOR 15

'  Lexical states For SCLEX_ASM
#Define wxSTC_ASM_DEFAULT 0
#Define wxSTC_ASM_COMMENT 1
#Define wxSTC_ASM_NUMBER 2
#Define wxSTC_ASM_STRING 3
#Define wxSTC_ASM_OPERATOR 4
#Define wxSTC_ASM_IDENTIFIER 5
#Define wxSTC_ASM_CPUINSTRUCTION 6
#Define wxSTC_ASM_MATHINSTRUCTION 7
#Define wxSTC_ASM_REGISTER 8
#Define wxSTC_ASM_DIRECTIVE 9
#Define wxSTC_ASM_DIRECTIVEOPERAND 10
#Define wxSTC_ASM_COMMENTBLOCK 11
#Define wxSTC_ASM_CHARACTER 12
#Define wxSTC_ASM_STRINGEOL 13
#Define wxSTC_ASM_EXTINSTRUCTION 14

'  Lexical states For SCLEX_FORTRAN
#Define wxSTC_F_DEFAULT 0
#Define wxSTC_F_COMMENT 1
#Define wxSTC_F_NUMBER 2
#Define wxSTC_F_STRING1 3
#Define wxSTC_F_STRING2 4
#Define wxSTC_F_STRINGEOL 5
#Define wxSTC_F_OPERATOR 6
#Define wxSTC_F_IDENTIFIER 7
#Define wxSTC_F_WORD 8
#Define wxSTC_F_WORD2 9
#Define wxSTC_F_WORD3 10
#Define wxSTC_F_PREPROCESSOR 11
#Define wxSTC_F_OPERATOR2 12
#Define wxSTC_F_LABEL 13
#Define wxSTC_F_CONTINUATION 14

'  Lexical states For SCLEX_CSS
#Define wxSTC_CSS_DEFAULT 0
#Define wxSTC_CSS_TAG 1
#Define wxSTC_CSS_CLASS 2
#Define wxSTC_CSS_PSEUDOCLASS 3
#Define wxSTC_CSS_UNKNOWN_PSEUDOCLASS 4
#Define wxSTC_CSS_OPERATOR 5
#Define wxSTC_CSS_IDENTIFIER 6
#Define wxSTC_CSS_UNKNOWN_IDENTIFIER 7
#Define wxSTC_CSS_VALUE 8
#Define wxSTC_CSS_COMMENT 9
#Define wxSTC_CSS_ID 10
#Define wxSTC_CSS_IMPORTANT 11
#Define wxSTC_CSS_DIRECTIVE 12
#Define wxSTC_CSS_DOUBLESTRING 13
#Define wxSTC_CSS_SINGLESTRING 14
#Define wxSTC_CSS_IDENTIFIER2 15
#Define wxSTC_CSS_ATTRIBUTE 16
#Define wxSTC_CSS_IDENTIFIER3 17
#Define wxSTC_CSS_PSEUDOELEMENT 18
#Define wxSTC_CSS_EXTENDED_IDENTIFIER 19
#Define wxSTC_CSS_EXTENDED_PSEUDOCLASS 20
#Define wxSTC_CSS_EXTENDED_PSEUDOELEMENT 21

'  Lexical states For SCLEX_POV
#Define wxSTC_POV_DEFAULT 0
#Define wxSTC_POV_COMMENT 1
#Define wxSTC_POV_COMMENTLINE 2
#Define wxSTC_POV_NUMBER 3
#Define wxSTC_POV_OPERATOR 4
#Define wxSTC_POV_IDENTIFIER 5
#Define wxSTC_POV_STRING 6
#Define wxSTC_POV_STRINGEOL 7
#Define wxSTC_POV_DIRECTIVE 8
#Define wxSTC_POV_BADDIRECTIVE 9
#Define wxSTC_POV_WORD2 10
#Define wxSTC_POV_WORD3 11
#Define wxSTC_POV_WORD4 12
#Define wxSTC_POV_WORD5 13
#Define wxSTC_POV_WORD6 14
#Define wxSTC_POV_WORD7 15
#Define wxSTC_POV_WORD8 16

'  Lexical states For SCLEX_LOUT
#Define wxSTC_LOUT_DEFAULT 0
#Define wxSTC_LOUT_COMMENT 1
#Define wxSTC_LOUT_NUMBER 2
#Define wxSTC_LOUT_WORD 3
#Define wxSTC_LOUT_WORD2 4
#Define wxSTC_LOUT_WORD3 5
#Define wxSTC_LOUT_WORD4 6
#Define wxSTC_LOUT_STRING 7
#Define wxSTC_LOUT_OPERATOR 8
#Define wxSTC_LOUT_IDENTIFIER 9
#Define wxSTC_LOUT_STRINGEOL 10

'  Lexical states For SCLEX_ESCRIPT
#Define wxSTC_ESCRIPT_DEFAULT 0
#Define wxSTC_ESCRIPT_COMMENT 1
#Define wxSTC_ESCRIPT_COMMENTLINE 2
#Define wxSTC_ESCRIPT_COMMENTDOC 3
#Define wxSTC_ESCRIPT_NUMBER 4
#Define wxSTC_ESCRIPT_WORD 5
#Define wxSTC_ESCRIPT_STRING 6
#Define wxSTC_ESCRIPT_OPERATOR 7
#Define wxSTC_ESCRIPT_IDENTIFIER 8
#Define wxSTC_ESCRIPT_BRACE 9
#Define wxSTC_ESCRIPT_WORD2 10
#Define wxSTC_ESCRIPT_WORD3 11

'  Lexical states For SCLEX_PS
#Define wxSTC_PS_DEFAULT 0
#Define wxSTC_PS_COMMENT 1
#Define wxSTC_PS_DSC_COMMENT 2
#Define wxSTC_PS_DSC_VALUE 3
#Define wxSTC_PS_NUMBER 4
#Define wxSTC_PS_NAME 5
#Define wxSTC_PS_KEYWORD 6
#Define wxSTC_PS_LITERAL 7
#Define wxSTC_PS_IMMEVAL 8
#Define wxSTC_PS_PAREN_ARRAY 9
#Define wxSTC_PS_PAREN_DICT 10
#Define wxSTC_PS_PAREN_PROC 11
#Define wxSTC_PS_TEXT 12
#Define wxSTC_PS_HEXSTRING 13
#Define wxSTC_PS_BASE85STRING 14
#Define wxSTC_PS_BADSTRINGCHAR 15

'  Lexical states For SCLEX_NSIS
#Define wxSTC_NSIS_DEFAULT 0
#Define wxSTC_NSIS_COMMENT 1
#Define wxSTC_NSIS_STRINGDQ 2
#Define wxSTC_NSIS_STRINGLQ 3
#Define wxSTC_NSIS_STRINGRQ 4
#Define wxSTC_NSIS_FUNCTION 5
#Define wxSTC_NSIS_VARIABLE 6
#Define wxSTC_NSIS_LABEL 7
#Define wxSTC_NSIS_USERDEFINED 8
#Define wxSTC_NSIS_SECTIONDEF 9
#Define wxSTC_NSIS_SUBSECTIONDEF 10
#Define wxSTC_NSIS_IFDEFINEDEF 11
#Define wxSTC_NSIS_MACRODEF 12
#Define wxSTC_NSIS_STRINGVAR 13
#Define wxSTC_NSIS_NUMBER 14
#Define wxSTC_NSIS_SECTIONGROUP 15
#Define wxSTC_NSIS_PAGEEX 16
#Define wxSTC_NSIS_FUNCTIONDEF 17
#Define wxSTC_NSIS_COMMENTBOX 18

'  Lexical states For SCLEX_MMIXAL
#Define wxSTC_MMIXAL_LEADWS 0
#Define wxSTC_MMIXAL_COMMENT 1
#Define wxSTC_MMIXAL_LABEL 2
#Define wxSTC_MMIXAL_OPCODE 3
#Define wxSTC_MMIXAL_OPCODE_PRE 4
#Define wxSTC_MMIXAL_OPCODE_VALID 5
#Define wxSTC_MMIXAL_OPCODE_UNKNOWN 6
#Define wxSTC_MMIXAL_OPCODE_POST 7
#Define wxSTC_MMIXAL_OPERANDS 8
#Define wxSTC_MMIXAL_NUMBER 9
#Define wxSTC_MMIXAL_REF 10
#Define wxSTC_MMIXAL_CHAR 11
#Define wxSTC_MMIXAL_STRING 12
#Define wxSTC_MMIXAL_REGISTER 13
#Define wxSTC_MMIXAL_HEX 14
#Define wxSTC_MMIXAL_OPERATOR 15
#Define wxSTC_MMIXAL_SYMBOL 16
#Define wxSTC_MMIXAL_INCLUDE 17

'  Lexical states For SCLEX_CLW
#Define wxSTC_CLW_DEFAULT 0
#Define wxSTC_CLW_LABEL 1
#Define wxSTC_CLW_COMMENT 2
#Define wxSTC_CLW_STRING 3
#Define wxSTC_CLW_USER_IDENTIFIER 4
#Define wxSTC_CLW_INTEGER_CONSTANT 5
#Define wxSTC_CLW_REAL_CONSTANT 6
#Define wxSTC_CLW_PICTURE_STRING 7
#Define wxSTC_CLW_KEYWORD 8
#Define wxSTC_CLW_COMPILER_DIRECTIVE 9
#Define wxSTC_CLW_RUNTIME_EXPRESSIONS 10
#Define wxSTC_CLW_BUILTIN_PROCEDURES_FUNCTION 11
#Define wxSTC_CLW_STRUCTURE_DATA_TYPE 12
#Define wxSTC_CLW_ATTRIBUTE 13
#Define wxSTC_CLW_STANDARD_EQUATE 14
#Define wxSTC_CLW_ERROR 15
#Define wxSTC_CLW_DEPRECATED 16

'  Lexical states For SCLEX_LOT
#Define wxSTC_LOT_DEFAULT 0
#Define wxSTC_LOT_HEADER 1
#Define wxSTC_LOT_BREAK 2
#Define wxSTC_LOT_SET 3
#Define wxSTC_LOT_PASS 4
#Define wxSTC_LOT_FAIL 5
#Define wxSTC_LOT_ABORT 6

'  Lexical states For SCLEX_YAML
#Define wxSTC_YAML_DEFAULT 0
#Define wxSTC_YAML_COMMENT 1
#Define wxSTC_YAML_IDENTIFIER 2
#Define wxSTC_YAML_KEYWORD 3
#Define wxSTC_YAML_NUMBER 4
#Define wxSTC_YAML_REFERENCE 5
#Define wxSTC_YAML_DOCUMENT 6
#Define wxSTC_YAML_TEXT 7
#Define wxSTC_YAML_ERROR 8
#Define wxSTC_YAML_OPERATOR 9

'  Lexical states For SCLEX_TEX
#Define wxSTC_TEX_DEFAULT 0
#Define wxSTC_TEX_SPECIAL 1
#Define wxSTC_TEX_GROUP 2
#Define wxSTC_TEX_SYMBOL 3
#Define wxSTC_TEX_COMMAND 4
#Define wxSTC_TEX_TEXT 5
#Define wxSTC_METAPOST_DEFAULT 0
#Define wxSTC_METAPOST_SPECIAL 1
#Define wxSTC_METAPOST_GROUP 2
#Define wxSTC_METAPOST_SYMBOL 3
#Define wxSTC_METAPOST_COMMAND 4
#Define wxSTC_METAPOST_TEXT 5
#Define wxSTC_METAPOST_EXTRA 6

'  Lexical states For SCLEX_ERLANG
#Define wxSTC_ERLANG_DEFAULT 0
#Define wxSTC_ERLANG_COMMENT 1
#Define wxSTC_ERLANG_VARIABLE 2
#Define wxSTC_ERLANG_NUMBER 3
#Define wxSTC_ERLANG_KEYWORD 4
#Define wxSTC_ERLANG_STRING 5
#Define wxSTC_ERLANG_OPERATOR 6
#Define wxSTC_ERLANG_ATOM 7
#Define wxSTC_ERLANG_FUNCTION_NAME 8
#Define wxSTC_ERLANG_CHARACTER 9
#Define wxSTC_ERLANG_MACRO 10
#Define wxSTC_ERLANG_RECORD 11
#Define wxSTC_ERLANG_PREPROC 12
#Define wxSTC_ERLANG_NODE_NAME 13
#Define wxSTC_ERLANG_COMMENT_FUNCTION 14
#Define wxSTC_ERLANG_COMMENT_MODULE 15
#Define wxSTC_ERLANG_COMMENT_DOC 16
#Define wxSTC_ERLANG_COMMENT_DOC_MACRO 17
#Define wxSTC_ERLANG_ATOM_QUOTED 18
#Define wxSTC_ERLANG_MACRO_QUOTED 19
#Define wxSTC_ERLANG_RECORD_QUOTED 20
#Define wxSTC_ERLANG_NODE_NAME_QUOTED 21
#Define wxSTC_ERLANG_BIFS 22
#Define wxSTC_ERLANG_MODULES 23
#Define wxSTC_ERLANG_MODULES_ATT 24
#Define wxSTC_ERLANG_UNKNOWN 31

'  Lexical states For SCLEX_OCTAVE are identical To MatLab
'  Lexical states For SCLEX_MSSQL
#Define wxSTC_MSSQL_DEFAULT 0
#Define wxSTC_MSSQL_COMMENT 1
#Define wxSTC_MSSQL_LINE_COMMENT 2
#Define wxSTC_MSSQL_NUMBER 3
#Define wxSTC_MSSQL_STRING 4
#Define wxSTC_MSSQL_OPERATOR 5
#Define wxSTC_MSSQL_IDENTIFIER 6
#Define wxSTC_MSSQL_VARIABLE 7
#Define wxSTC_MSSQL_COLUMN_NAME 8
#Define wxSTC_MSSQL_STATEMENT 9
#Define wxSTC_MSSQL_DATATYPE 10
#Define wxSTC_MSSQL_SYSTABLE 11
#Define wxSTC_MSSQL_GLOBAL_VARIABLE 12
#Define wxSTC_MSSQL_FUNCTION 13
#Define wxSTC_MSSQL_STORED_PROCEDURE 14
#Define wxSTC_MSSQL_DEFAULT_PREF_DATATYPE 15
#Define wxSTC_MSSQL_COLUMN_NAME_2 16

'  Lexical states For SCLEX_VERILOG
#Define wxSTC_V_DEFAULT 0
#Define wxSTC_V_COMMENT 1
#Define wxSTC_V_COMMENTLINE 2
#Define wxSTC_V_COMMENTLINEBANG 3
#Define wxSTC_V_NUMBER 4
#Define wxSTC_V_WORD 5
#Define wxSTC_V_STRING 6
#Define wxSTC_V_WORD2 7
#Define wxSTC_V_WORD3 8
#Define wxSTC_V_PREPROCESSOR 9
#Define wxSTC_V_OPERATOR 10
#Define wxSTC_V_IDENTIFIER 11
#Define wxSTC_V_STRINGEOL 12
#Define wxSTC_V_USER 19

'  Lexical states For SCLEX_KIX
#Define wxSTC_KIX_DEFAULT 0
#Define wxSTC_KIX_COMMENT 1
#Define wxSTC_KIX_STRING1 2
#Define wxSTC_KIX_STRING2 3
#Define wxSTC_KIX_NUMBER 4
#Define wxSTC_KIX_VAR 5
#Define wxSTC_KIX_MACRO 6
#Define wxSTC_KIX_KEYWORD 7
#Define wxSTC_KIX_FUNCTIONS 8
#Define wxSTC_KIX_OPERATOR 9
#Define wxSTC_KIX_IDENTIFIER 31

'  Lexical states For SCLEX_GUI4CLI
#Define wxSTC_GC_DEFAULT 0
#Define wxSTC_GC_COMMENTLINE 1
#Define wxSTC_GC_COMMENTBLOCK 2
#Define wxSTC_GC_GLOBAL 3
#Define wxSTC_GC_EVENT 4
#Define wxSTC_GC_ATTRIBUTE 5
#Define wxSTC_GC_CONTROL 6
#Define wxSTC_GC_COMMAND 7
#Define wxSTC_GC_STRING 8
#Define wxSTC_GC_OPERATOR 9

'  Lexical states For SCLEX_SPECMAN
#Define wxSTC_SN_DEFAULT 0
#Define wxSTC_SN_CODE 1
#Define wxSTC_SN_COMMENTLINE 2
#Define wxSTC_SN_COMMENTLINEBANG 3
#Define wxSTC_SN_NUMBER 4
#Define wxSTC_SN_WORD 5
#Define wxSTC_SN_STRING 6
#Define wxSTC_SN_WORD2 7
#Define wxSTC_SN_WORD3 8
#Define wxSTC_SN_PREPROCESSOR 9
#Define wxSTC_SN_OPERATOR 10
#Define wxSTC_SN_IDENTIFIER 11
#Define wxSTC_SN_STRINGEOL 12
#Define wxSTC_SN_REGEXTAG 13
#Define wxSTC_SN_SIGNAL 14
#Define wxSTC_SN_USER 19

'  Lexical states For SCLEX_AU3
#Define wxSTC_AU3_DEFAULT 0
#Define wxSTC_AU3_COMMENT 1
#Define wxSTC_AU3_COMMENTBLOCK 2
#Define wxSTC_AU3_NUMBER 3
#Define wxSTC_AU3_FUNCTION 4
#Define wxSTC_AU3_KEYWORD 5
#Define wxSTC_AU3_MACRO 6
#Define wxSTC_AU3_STRING 7
#Define wxSTC_AU3_OPERATOR 8
#Define wxSTC_AU3_VARIABLE 9
#Define wxSTC_AU3_SENT 10
#Define wxSTC_AU3_PREPROCESSOR 11
#Define wxSTC_AU3_SPECIAL 12
#Define wxSTC_AU3_EXPAND 13
#Define wxSTC_AU3_COMOBJ 14
#Define wxSTC_AU3_UDF 15

'  Lexical states For SCLEX_APDL
#Define wxSTC_APDL_DEFAULT 0
#Define wxSTC_APDL_COMMENT 1
#Define wxSTC_APDL_COMMENTBLOCK 2
#Define wxSTC_APDL_NUMBER 3
#Define wxSTC_APDL_STRING 4
#Define wxSTC_APDL_OPERATOR 5
#Define wxSTC_APDL_WORD 6
#Define wxSTC_APDL_PROCESSOR 7
#Define wxSTC_APDL_COMMAND 8
#Define wxSTC_APDL_SLASHCOMMAND 9
#Define wxSTC_APDL_STARCOMMAND 10
#Define wxSTC_APDL_ARGUMENT 11
#Define wxSTC_APDL_FUNCTION 12

'  Lexical states For SCLEX_BASH
#Define wxSTC_SH_DEFAULT 0
#Define wxSTC_SH_ERROR 1
#Define wxSTC_SH_COMMENTLINE 2
#Define wxSTC_SH_NUMBER 3
#Define wxSTC_SH_WORD 4
#Define wxSTC_SH_STRING 5
#Define wxSTC_SH_CHARACTER 6
#Define wxSTC_SH_OPERATOR 7
#Define wxSTC_SH_IDENTIFIER 8
#Define wxSTC_SH_SCALAR 9
#Define wxSTC_SH_PARAM 10
#Define wxSTC_SH_BACKTICKS 11
#Define wxSTC_SH_HERE_DELIM 12
#Define wxSTC_SH_HERE_Q 13

'  Lexical states For SCLEX_ASN1
#Define wxSTC_ASN1_DEFAULT 0
#Define wxSTC_ASN1_COMMENT 1
#Define wxSTC_ASN1_IDENTIFIER 2
#Define wxSTC_ASN1_STRING 3
#Define wxSTC_ASN1_OID 4
#Define wxSTC_ASN1_SCALAR 5
#Define wxSTC_ASN1_KEYWORD 6
#Define wxSTC_ASN1_ATTRIBUTE 7
#Define wxSTC_ASN1_DESCRIPTOR 8
#Define wxSTC_ASN1_TYPE 9
#Define wxSTC_ASN1_OPERATOR 10

'  Lexical states For SCLEX_VHDL
#Define wxSTC_VHDL_DEFAULT 0
#Define wxSTC_VHDL_COMMENT 1
#Define wxSTC_VHDL_COMMENTLINEBANG 2
#Define wxSTC_VHDL_NUMBER 3
#Define wxSTC_VHDL_STRING 4
#Define wxSTC_VHDL_OPERATOR 5
#Define wxSTC_VHDL_IDENTIFIER 6
#Define wxSTC_VHDL_STRINGEOL 7
#Define wxSTC_VHDL_KEYWORD 8
#Define wxSTC_VHDL_STDOPERATOR 9
#Define wxSTC_VHDL_ATTRIBUTE 10
#Define wxSTC_VHDL_STDFUNCTION 11
#Define wxSTC_VHDL_STDPACKAGE 12
#Define wxSTC_VHDL_STDTYPE 13
#Define wxSTC_VHDL_USERWORD 14

'  Lexical states For SCLEX_CAML
#Define wxSTC_CAML_DEFAULT 0
#Define wxSTC_CAML_IDENTIFIER 1
#Define wxSTC_CAML_TAGNAME 2
#Define wxSTC_CAML_KEYWORD 3
#Define wxSTC_CAML_KEYWORD2 4
#Define wxSTC_CAML_KEYWORD3 5
#Define wxSTC_CAML_LINENUM 6
#Define wxSTC_CAML_OPERATOR 7
#Define wxSTC_CAML_NUMBER 8
#Define wxSTC_CAML_CHAR 9
#Define wxSTC_CAML_WHITE 10
#Define wxSTC_CAML_STRING 11
#Define wxSTC_CAML_COMMENT 12
#Define wxSTC_CAML_COMMENT1 13
#Define wxSTC_CAML_COMMENT2 14
#Define wxSTC_CAML_COMMENT3 15

'  Lexical states For SCLEX_HASKELL
#Define wxSTC_HA_DEFAULT 0
#Define wxSTC_HA_IDENTIFIER 1
#Define wxSTC_HA_KEYWORD 2
#Define wxSTC_HA_NUMBER 3
#Define wxSTC_HA_STRING 4
#Define wxSTC_HA_CHARACTER 5
#Define wxSTC_HA_CLASS 6
#Define wxSTC_HA_MODULE 7
#Define wxSTC_HA_CAPITAL 8
#Define wxSTC_HA_DATA 9
#Define wxSTC_HA_IMPORT 10
#Define wxSTC_HA_OPERATOR 11
#Define wxSTC_HA_INSTANCE 12
#Define wxSTC_HA_COMMENTLINE 13
#Define wxSTC_HA_COMMENTBLOCK 14
#Define wxSTC_HA_COMMENTBLOCK2 15
#Define wxSTC_HA_COMMENTBLOCK3 16

'  Lexical states of SCLEX_TADS3
#Define wxSTC_T3_DEFAULT 0
#Define wxSTC_T3_X_DEFAULT 1
#Define wxSTC_T3_PREPROCESSOR 2
#Define wxSTC_T3_BLOCK_COMMENT 3
#Define wxSTC_T3_LINE_COMMENT 4
#Define wxSTC_T3_OPERATOR 5
#Define wxSTC_T3_KEYWORD 6
#Define wxSTC_T3_NUMBER 7
#Define wxSTC_T3_IDENTIFIER 8
#Define wxSTC_T3_S_STRING 9
#Define wxSTC_T3_D_STRING 10
#Define wxSTC_T3_X_STRING 11
#Define wxSTC_T3_LIB_DIRECTIVE 12
#Define wxSTC_T3_MSG_PARAM 13
#Define wxSTC_T3_HTML_TAG 14
#Define wxSTC_T3_HTML_DEFAULT 15
#Define wxSTC_T3_HTML_STRING 16
#Define wxSTC_T3_USER1 17
#Define wxSTC_T3_USER2 18
#Define wxSTC_T3_USER3 19
#Define wxSTC_T3_BRACE 20

'  Lexical states For SCLEX_REBOL
#Define wxSTC_REBOL_DEFAULT 0
#Define wxSTC_REBOL_COMMENTLINE 1
#Define wxSTC_REBOL_COMMENTBLOCK 2
#Define wxSTC_REBOL_PREFACE 3
#Define wxSTC_REBOL_OPERATOR 4
#Define wxSTC_REBOL_CHARACTER 5
#Define wxSTC_REBOL_QUOTEDSTRING 6
#Define wxSTC_REBOL_BRACEDSTRING 7
#Define wxSTC_REBOL_NUMBER 8
#Define wxSTC_REBOL_PAIR 9
#Define wxSTC_REBOL_TUPLE 10
#Define wxSTC_REBOL_BINARY 11
#Define wxSTC_REBOL_MONEY 12
#Define wxSTC_REBOL_ISSUE 13
#Define wxSTC_REBOL_TAG 14
#Define wxSTC_REBOL_FILE 15
#Define wxSTC_REBOL_EMAIL 16
#Define wxSTC_REBOL_URL 17
#Define wxSTC_REBOL_DATE 18
#Define wxSTC_REBOL_TIME 19
#Define wxSTC_REBOL_IDENTIFIER 20
#Define wxSTC_REBOL_WORD 21
#Define wxSTC_REBOL_WORD2 22
#Define wxSTC_REBOL_WORD3 23
#Define wxSTC_REBOL_WORD4 24
#Define wxSTC_REBOL_WORD5 25
#Define wxSTC_REBOL_WORD6 26
#Define wxSTC_REBOL_WORD7 27
#Define wxSTC_REBOL_WORD8 28

'  Lexical states For SCLEX_SQL
#Define wxSTC_SQL_DEFAULT 0
#Define wxSTC_SQL_COMMENT 1
#Define wxSTC_SQL_COMMENTLINE 2
#Define wxSTC_SQL_COMMENTDOC 3
#Define wxSTC_SQL_NUMBER 4
#Define wxSTC_SQL_WORD 5
#Define wxSTC_SQL_STRING 6
#Define wxSTC_SQL_CHARACTER 7
#Define wxSTC_SQL_SQLPLUS 8
#Define wxSTC_SQL_SQLPLUS_PROMPT 9
#Define wxSTC_SQL_OPERATOR 10
#Define wxSTC_SQL_IDENTIFIER 11
#Define wxSTC_SQL_SQLPLUS_COMMENT 13
#Define wxSTC_SQL_COMMENTLINEDOC 15
#Define wxSTC_SQL_WORD2 16
#Define wxSTC_SQL_COMMENTDOCKEYWORD 17
#Define wxSTC_SQL_COMMENTDOCKEYWORDERROR 18
#Define wxSTC_SQL_USER1 19
#Define wxSTC_SQL_USER2 20
#Define wxSTC_SQL_USER3 21
#Define wxSTC_SQL_USER4 22
#Define wxSTC_SQL_QUOTEDIDENTIFIER 23

'  Lexical states For SCLEX_SMALLTALK
#Define wxSTC_ST_DEFAULT 0
#Define wxSTC_ST_STRING 1
#Define wxSTC_ST_NUMBER 2
#Define wxSTC_ST_COMMENT 3
#Define wxSTC_ST_SYMBOL 4
#Define wxSTC_ST_BINARY 5
#Define wxSTC_ST_BOOL 6
#Define wxSTC_ST_SELF 7
#Define wxSTC_ST_SUPER 8
#Define wxSTC_ST_NIL 9
#Define wxSTC_ST_GLOBAL 10
#Define wxSTC_ST_RETURN 11
#Define wxSTC_ST_SPECIAL 12
#Define wxSTC_ST_KWSEND 13
#Define wxSTC_ST_ASSIGN 14
#Define wxSTC_ST_CHARACTER 15
#Define wxSTC_ST_SPEC_SEL 16

'  Lexical states For SCLEX_FLAGSHIP (clipper)
#Define wxSTC_FS_DEFAULT 0
#Define wxSTC_FS_COMMENT 1
#Define wxSTC_FS_COMMENTLINE 2
#Define wxSTC_FS_COMMENTDOC 3
#Define wxSTC_FS_COMMENTLINEDOC 4
#Define wxSTC_FS_COMMENTDOCKEYWORD 5
#Define wxSTC_FS_COMMENTDOCKEYWORDERROR 6
#Define wxSTC_FS_KEYWORD 7
#Define wxSTC_FS_KEYWORD2 8
#Define wxSTC_FS_KEYWORD3 9
#Define wxSTC_FS_KEYWORD4 10
#Define wxSTC_FS_NUMBER 11
#Define wxSTC_FS_STRING 12
#Define wxSTC_FS_PREPROCESSOR 13
#Define wxSTC_FS_OPERATOR 14
#Define wxSTC_FS_IDENTIFIER 15
#Define wxSTC_FS_DATE 16
#Define wxSTC_FS_STRINGEOL 17
#Define wxSTC_FS_CONSTANT 18
#Define wxSTC_FS_ASM 19
#Define wxSTC_FS_LABEL 20
#Define wxSTC_FS_ERROR 21
#Define wxSTC_FS_HEXNUMBER 22
#Define wxSTC_FS_BINNUMBER 23

'  Lexical states For SCLEX_CSOUND
#Define wxSTC_CSOUND_DEFAULT 0
#Define wxSTC_CSOUND_COMMENT 1
#Define wxSTC_CSOUND_NUMBER 2
#Define wxSTC_CSOUND_OPERATOR 3
#Define wxSTC_CSOUND_INSTR 4
#Define wxSTC_CSOUND_IDENTIFIER 5
#Define wxSTC_CSOUND_OPCODE 6
#Define wxSTC_CSOUND_HEADERSTMT 7
#Define wxSTC_CSOUND_USERKEYWORD 8
#Define wxSTC_CSOUND_COMMENTBLOCK 9
#Define wxSTC_CSOUND_PARAM 10
#Define wxSTC_CSOUND_ARATE_VAR 11
#Define wxSTC_CSOUND_KRATE_VAR 12
#Define wxSTC_CSOUND_IRATE_VAR 13
#Define wxSTC_CSOUND_GLOBAL_VAR 14
#Define wxSTC_CSOUND_STRINGEOL 15

'  Lexical states For SCLEX_INNOSETUP
#Define wxSTC_INNO_DEFAULT 0
#Define wxSTC_INNO_COMMENT 1
#Define wxSTC_INNO_KEYWORD 2
#Define wxSTC_INNO_PARAMETER 3
#Define wxSTC_INNO_SECTION 4
#Define wxSTC_INNO_PREPROC 5
#Define wxSTC_INNO_INLINE_EXPANSION 6
#Define wxSTC_INNO_COMMENT_PASCAL 7
#Define wxSTC_INNO_KEYWORD_PASCAL 8
#Define wxSTC_INNO_KEYWORD_USER 9
#Define wxSTC_INNO_STRING_DOUBLE 10
#Define wxSTC_INNO_STRING_SINGLE 11
#Define wxSTC_INNO_IDENTIFIER 12

'  Lexical states For SCLEX_OPAL
#Define wxSTC_OPAL_SPACE 0
#Define wxSTC_OPAL_COMMENT_BLOCK 1
#Define wxSTC_OPAL_COMMENT_LINE 2
#Define wxSTC_OPAL_INTEGER 3
#Define wxSTC_OPAL_KEYWORD 4
#Define wxSTC_OPAL_SORT 5
#Define wxSTC_OPAL_STRING 6
#Define wxSTC_OPAL_PAR 7
#Define wxSTC_OPAL_BOOL_CONST 8
#Define wxSTC_OPAL_DEFAULT 32

'  Lexical states For SCLEX_SPICE
#Define wxSTC_SPICE_DEFAULT 0
#Define wxSTC_SPICE_IDENTIFIER 1
#Define wxSTC_SPICE_KEYWORD 2
#Define wxSTC_SPICE_KEYWORD2 3
#Define wxSTC_SPICE_KEYWORD3 4
#Define wxSTC_SPICE_NUMBER 5
#Define wxSTC_SPICE_DELIMITER 6
#Define wxSTC_SPICE_VALUE 7
#Define wxSTC_SPICE_COMMENTLINE 8

'  Lexical states For SCLEX_CMAKE
#Define wxSTC_CMAKE_DEFAULT 0
#Define wxSTC_CMAKE_COMMENT 1
#Define wxSTC_CMAKE_STRINGDQ 2
#Define wxSTC_CMAKE_STRINGLQ 3
#Define wxSTC_CMAKE_STRINGRQ 4
#Define wxSTC_CMAKE_COMMANDS 5
#Define wxSTC_CMAKE_PARAMETERS 6
#Define wxSTC_CMAKE_VARIABLE 7
#Define wxSTC_CMAKE_USERDEFINED 8
#Define wxSTC_CMAKE_WHILEDEF 9
#Define wxSTC_CMAKE_FOREACHDEF 10
#Define wxSTC_CMAKE_IFDEFINEDEF 11
#Define wxSTC_CMAKE_MACRODEF 12
#Define wxSTC_CMAKE_STRINGVAR 13
#Define wxSTC_CMAKE_NUMBER 14

'  Lexical states For SCLEX_GAP
#Define wxSTC_GAP_DEFAULT 0
#Define wxSTC_GAP_IDENTIFIER 1
#Define wxSTC_GAP_KEYWORD 2
#Define wxSTC_GAP_KEYWORD2 3
#Define wxSTC_GAP_KEYWORD3 4
#Define wxSTC_GAP_KEYWORD4 5
#Define wxSTC_GAP_STRING 6
#Define wxSTC_GAP_CHAR 7
#Define wxSTC_GAP_OPERATOR 8
#Define wxSTC_GAP_COMMENT 9
#Define wxSTC_GAP_NUMBER 10
#Define wxSTC_GAP_STRINGEOL 11

'  Lexical state For SCLEX_PLM
#Define wxSTC_PLM_DEFAULT 0
#Define wxSTC_PLM_COMMENT 1
#Define wxSTC_PLM_STRING 2
#Define wxSTC_PLM_NUMBER 3
#Define wxSTC_PLM_IDENTIFIER 4
#Define wxSTC_PLM_OPERATOR 5
#Define wxSTC_PLM_CONTROL 6
#Define wxSTC_PLM_KEYWORD 7

'  Lexical state For SCLEX_PROGRESS
#Define wxSTC_4GL_DEFAULT 0
#Define wxSTC_4GL_NUMBER 1
#Define wxSTC_4GL_WORD 2
#Define wxSTC_4GL_STRING 3
#Define wxSTC_4GL_CHARACTER 4
#Define wxSTC_4GL_PREPROCESSOR 5
#Define wxSTC_4GL_OPERATOR 6
#Define wxSTC_4GL_IDENTIFIER 7
#Define wxSTC_4GL_BLOCK 8
#Define wxSTC_4GL_END 9
#Define wxSTC_4GL_COMMENT1 10
#Define wxSTC_4GL_COMMENT2 11
#Define wxSTC_4GL_COMMENT3 12
#Define wxSTC_4GL_COMMENT4 13
#Define wxSTC_4GL_COMMENT5 14
#Define wxSTC_4GL_COMMENT6 15
#Define wxSTC_4GL_DEFAULT_ 16
#Define wxSTC_4GL_NUMBER_ 17
#Define wxSTC_4GL_WORD_ 18
#Define wxSTC_4GL_STRING_ 19
#Define wxSTC_4GL_CHARACTER_ 20
#Define wxSTC_4GL_PREPROCESSOR_ 21
#Define wxSTC_4GL_OPERATOR_ 22
#Define wxSTC_4GL_IDENTIFIER_ 23
#Define wxSTC_4GL_BLOCK_ 24
#Define wxSTC_4GL_END_ 25
#Define wxSTC_4GL_COMMENT1_ 26
#Define wxSTC_4GL_COMMENT2_ 27
#Define wxSTC_4GL_COMMENT3_ 28
#Define wxSTC_4GL_COMMENT4_ 29
#Define wxSTC_4GL_COMMENT5_ 30
#Define wxSTC_4GL_COMMENT6_ 31

'  Lexical states For SCLEX_ABAQUS
#Define wxSTC_ABAQUS_DEFAULT 0
#Define wxSTC_ABAQUS_COMMENT 1
#Define wxSTC_ABAQUS_COMMENTBLOCK 2
#Define wxSTC_ABAQUS_NUMBER 3
#Define wxSTC_ABAQUS_STRING 4
#Define wxSTC_ABAQUS_OPERATOR 5
#Define wxSTC_ABAQUS_WORD 6
#Define wxSTC_ABAQUS_PROCESSOR 7
#Define wxSTC_ABAQUS_COMMAND 8
#Define wxSTC_ABAQUS_SLASHCOMMAND 9
#Define wxSTC_ABAQUS_STARCOMMAND 10
#Define wxSTC_ABAQUS_ARGUMENT 11
#Define wxSTC_ABAQUS_FUNCTION 12

'  Lexical states For SCLEX_ASYMPTOTE
#Define wxSTC_ASY_DEFAULT 0
#Define wxSTC_ASY_COMMENT 1
#Define wxSTC_ASY_COMMENTLINE 2
#Define wxSTC_ASY_NUMBER 3
#Define wxSTC_ASY_WORD 4
#Define wxSTC_ASY_STRING 5
#Define wxSTC_ASY_CHARACTER 6
#Define wxSTC_ASY_OPERATOR 7
#Define wxSTC_ASY_IDENTIFIER 8
#Define wxSTC_ASY_STRINGEOL 9
#Define wxSTC_ASY_COMMENTLINEDOC 10
#Define wxSTC_ASY_WORD2 11

'  Lexical states For SCLEX_R
#Define wxSTC_R_DEFAULT 0
#Define wxSTC_R_COMMENT 1
#Define wxSTC_R_KWORD 2
#Define wxSTC_R_BASEKWORD 3
#Define wxSTC_R_OTHERKWORD 4
#Define wxSTC_R_NUMBER 5
#Define wxSTC_R_STRING 6
#Define wxSTC_R_STRING2 7
#Define wxSTC_R_OPERATOR 8
#Define wxSTC_R_IDENTIFIER 9
#Define wxSTC_R_INFIX 10
#Define wxSTC_R_INFIXEOL 11

'  Lexical state For SCLEX_MAGIKSF
#Define wxSTC_MAGIK_DEFAULT 0
#Define wxSTC_MAGIK_COMMENT 1
#Define wxSTC_MAGIK_HYPER_COMMENT 16
#Define wxSTC_MAGIK_STRING 2
#Define wxSTC_MAGIK_CHARACTER 3
#Define wxSTC_MAGIK_NUMBER 4
#Define wxSTC_MAGIK_IDENTIFIER 5
#Define wxSTC_MAGIK_OPERATOR 6
#Define wxSTC_MAGIK_FLOW 7
#Define wxSTC_MAGIK_CONTAINER 8
#Define wxSTC_MAGIK_BRACKET_BLOCK 9
#Define wxSTC_MAGIK_BRACE_BLOCK 10
#Define wxSTC_MAGIK_SQBRACKET_BLOCK 11
#Define wxSTC_MAGIK_UNKNOWN_KEYWORD 12
#Define wxSTC_MAGIK_KEYWORD 13
#Define wxSTC_MAGIK_PRAGMA 14
#Define wxSTC_MAGIK_SYMBOL 15

'  Lexical state For SCLEX_POWERSHELL
#Define wxSTC_POWERSHELL_DEFAULT 0
#Define wxSTC_POWERSHELL_COMMENT 1
#Define wxSTC_POWERSHELL_STRING 2
#Define wxSTC_POWERSHELL_CHARACTER 3
#Define wxSTC_POWERSHELL_NUMBER 4
#Define wxSTC_POWERSHELL_VARIABLE 5
#Define wxSTC_POWERSHELL_OPERATOR 6
#Define wxSTC_POWERSHELL_IDENTIFIER 7
#Define wxSTC_POWERSHELL_KEYWORD 8
#Define wxSTC_POWERSHELL_CMDLET 9
#Define wxSTC_POWERSHELL_ALIAS 10

'  Lexical state For SCLEX_MYSQL
#Define wxSTC_MYSQL_DEFAULT 0
#Define wxSTC_MYSQL_COMMENT 1
#Define wxSTC_MYSQL_COMMENTLINE 2
#Define wxSTC_MYSQL_VARIABLE 3
#Define wxSTC_MYSQL_SYSTEMVARIABLE 4
#Define wxSTC_MYSQL_KNOWNSYSTEMVARIABLE 5
#Define wxSTC_MYSQL_NUMBER 6
#Define wxSTC_MYSQL_MAJORKEYWORD 7
#Define wxSTC_MYSQL_KEYWORD 8
#Define wxSTC_MYSQL_DATABASEOBJECT 9
#Define wxSTC_MYSQL_PROCEDUREKEYWORD 10
#Define wxSTC_MYSQL_STRING 11
#Define wxSTC_MYSQL_SQSTRING 12
#Define wxSTC_MYSQL_DQSTRING 13
#Define wxSTC_MYSQL_OPERATOR 14
#Define wxSTC_MYSQL_FUNCTION 15
#Define wxSTC_MYSQL_IDENTIFIER 16
#Define wxSTC_MYSQL_QUOTEDIDENTIFIER 17
#Define wxSTC_MYSQL_USER1 18
#Define wxSTC_MYSQL_USER2 19
#Define wxSTC_MYSQL_USER3 20
#Define wxSTC_MYSQL_HIDDENCOMMAND 21

'  Lexical state For SCLEX_PO
#Define wxSTC_PO_DEFAULT 0
#Define wxSTC_PO_COMMENT 1
#Define wxSTC_PO_MSGID 2
#Define wxSTC_PO_MSGID_TEXT 3
#Define wxSTC_PO_MSGSTR 4
#Define wxSTC_PO_MSGSTR_TEXT 5
#Define wxSTC_PO_MSGCTXT 6
#Define wxSTC_PO_MSGCTXT_TEXT 7
#Define wxSTC_PO_FUZZY 8

'  Lexical states For SCLEX_PASCAL
#Define wxSTC_PAS_DEFAULT 0
#Define wxSTC_PAS_IDENTIFIER 1
#Define wxSTC_PAS_COMMENT 2
#Define wxSTC_PAS_COMMENT2 3
#Define wxSTC_PAS_COMMENTLINE 4
#Define wxSTC_PAS_PREPROCESSOR 5
#Define wxSTC_PAS_PREPROCESSOR2 6
#Define wxSTC_PAS_NUMBER 7
#Define wxSTC_PAS_HEXNUMBER 8
#Define wxSTC_PAS_WORD 9
#Define wxSTC_PAS_STRING 10
#Define wxSTC_PAS_STRINGEOL 11
#Define wxSTC_PAS_CHARACTER 12
#Define wxSTC_PAS_OPERATOR 13
#Define wxSTC_PAS_ASM 14

'  Lexical state For SCLEX_SORCUS
#Define wxSTC_SORCUS_DEFAULT 0
#Define wxSTC_SORCUS_COMMAND 1
#Define wxSTC_SORCUS_PARAMETER 2
#Define wxSTC_SORCUS_COMMENTLINE 3
#Define wxSTC_SORCUS_STRING 4
#Define wxSTC_SORCUS_STRINGEOL 5
#Define wxSTC_SORCUS_IDENTIFIER 6
#Define wxSTC_SORCUS_OPERATOR 7
#Define wxSTC_SORCUS_NUMBER 8
#Define wxSTC_SORCUS_CONSTANT 9

'  Lexical state For SCLEX_POWERPRO
#Define wxSTC_POWERPRO_DEFAULT 0
#Define wxSTC_POWERPRO_COMMENTBLOCK 1
#Define wxSTC_POWERPRO_COMMENTLINE 2
#Define wxSTC_POWERPRO_NUMBER 3
#Define wxSTC_POWERPRO_WORD 4
#Define wxSTC_POWERPRO_WORD2 5
#Define wxSTC_POWERPRO_WORD3 6
#Define wxSTC_POWERPRO_WORD4 7
#Define wxSTC_POWERPRO_DOUBLEQUOTEDSTRING 8
#Define wxSTC_POWERPRO_SINGLEQUOTEDSTRING 9
#Define wxSTC_POWERPRO_LINECONTINUE 10
#Define wxSTC_POWERPRO_OPERATOR 11
#Define wxSTC_POWERPRO_IDENTIFIER 12
#Define wxSTC_POWERPRO_STRINGEOL 13
#Define wxSTC_POWERPRO_VERBATIM 14
#Define wxSTC_POWERPRO_ALTQUOTE 15
#Define wxSTC_POWERPRO_FUNCTION 16

'  Lexical states For SCLEX_SML
#Define wxSTC_SML_DEFAULT 0
#Define wxSTC_SML_IDENTIFIER 1
#Define wxSTC_SML_TAGNAME 2
#Define wxSTC_SML_KEYWORD 3
#Define wxSTC_SML_KEYWORD2 4
#Define wxSTC_SML_KEYWORD3 5
#Define wxSTC_SML_LINENUM 6
#Define wxSTC_SML_OPERATOR 7
#Define wxSTC_SML_NUMBER 8
#Define wxSTC_SML_CHAR 9
#Define wxSTC_SML_STRING 11
#Define wxSTC_SML_COMMENT 12
#Define wxSTC_SML_COMMENT1 13
#Define wxSTC_SML_COMMENT2 14
#Define wxSTC_SML_COMMENT3 15

'  Lexical state For SCLEX_MARKDOWN
#Define wxSTC_MARKDOWN_DEFAULT 0
#Define wxSTC_MARKDOWN_LINE_BEGIN 1
#Define wxSTC_MARKDOWN_STRONG1 2
#Define wxSTC_MARKDOWN_STRONG2 3
#Define wxSTC_MARKDOWN_EM1 4
#Define wxSTC_MARKDOWN_EM2 5
#Define wxSTC_MARKDOWN_HEADER1 6
#Define wxSTC_MARKDOWN_HEADER2 7
#Define wxSTC_MARKDOWN_HEADER3 8
#Define wxSTC_MARKDOWN_HEADER4 9
#Define wxSTC_MARKDOWN_HEADER5 10
#Define wxSTC_MARKDOWN_HEADER6 11
#Define wxSTC_MARKDOWN_PRECHAR 12
#Define wxSTC_MARKDOWN_ULIST_ITEM 13
#Define wxSTC_MARKDOWN_OLIST_ITEM 14
#Define wxSTC_MARKDOWN_BLOCKQUOTE 15
#Define wxSTC_MARKDOWN_STRIKEOUT 16
#Define wxSTC_MARKDOWN_HRULE 17
#Define wxSTC_MARKDOWN_LINK 18
#Define wxSTC_MARKDOWN_CODE 19
#Define wxSTC_MARKDOWN_CODE2 20
#Define wxSTC_MARKDOWN_CODEBK 21

' }}}
' ----------------------------------------------------------------------

' ----------------------------------------------------------------------
'  Commands that can be bound To keystrokes section {{{


'  Redoes the Next action On the undo history.
#Define wxSTC_CMD_REDO 2011

'  Select all the text in the document.
#Define wxSTC_CMD_SELECTALL 2013

'  Undo one action in the undo history.
#Define wxSTC_CMD_UNDO 2176

'  Cut the selection To the clipboard.
#Define wxSTC_CMD_CUT 2177

'  Copy the selection To the clipboard.
#Define wxSTC_CMD_COPY 2178

'  Paste the contents of the clipboard into the document replacing the selection.
#Define wxSTC_CMD_PASTE 2179

'  Clear the selection.
#Define wxSTC_CMD_CLEAR 2180

'  Move caret down one line.
#Define wxSTC_CMD_LINEDOWN 2300

'  Move caret down one Line extending selection To New caret position.
#Define wxSTC_CMD_LINEDOWNEXTEND 2301

'  Move caret up one line.
#Define wxSTC_CMD_LINEUP 2302

'  Move caret up one Line extending selection To New caret position.
#Define wxSTC_CMD_LINEUPEXTEND 2303

'  Move caret Left one character.
#Define wxSTC_CMD_CHARLEFT 2304

'  Move caret Left one character extending selection To New caret position.
#Define wxSTC_CMD_CHARLEFTEXTEND 2305

'  Move caret Right one character.
#Define wxSTC_CMD_CHARRIGHT 2306

'  Move caret Right one character extending selection To New caret position.
#Define wxSTC_CMD_CHARRIGHTEXTEND 2307

'  Move caret Left one word.
#Define wxSTC_CMD_WORDLEFT 2308

'  Move caret Left one word extending selection To New caret position.
#Define wxSTC_CMD_WORDLEFTEXTEND 2309

'  Move caret Right one word.
#Define wxSTC_CMD_WORDRIGHT 2310

'  Move caret Right one word extending selection To New caret position.
#Define wxSTC_CMD_WORDRIGHTEXTEND 2311

'  Move caret To first position On line.
#Define wxSTC_CMD_HOME 2312

'  Move caret To first position On Line extending selection To New caret position.
#Define wxSTC_CMD_HOMEEXTEND 2313

'  Move caret To last position On line.
#Define wxSTC_CMD_LINEEND 2314

'  Move caret To last position On Line extending selection To New caret position.
#Define wxSTC_CMD_LINEENDEXTEND 2315

'  Move caret To first position in document.
#Define wxSTC_CMD_DOCUMENTSTART 2316

'  Move caret To first position in document extending selection To New caret position.
#Define wxSTC_CMD_DOCUMENTSTARTEXTEND 2317

'  Move caret To last position in document.
#Define wxSTC_CMD_DOCUMENTEND 2318

'  Move caret To last position in document extending selection To New caret position.
#Define wxSTC_CMD_DOCUMENTENDEXTEND 2319

'  Move caret one page up.
#Define wxSTC_CMD_PAGEUP 2320

'  Move caret one page up extending selection To New caret position.
#Define wxSTC_CMD_PAGEUPEXTEND 2321

'  Move caret one page down.
#Define wxSTC_CMD_PAGEDOWN 2322

'  Move caret one page down extending selection To New caret position.
#Define wxSTC_CMD_PAGEDOWNEXTEND 2323

'  Switch from insert To overtype mode Or the reverse.
#Define wxSTC_CMD_EDITTOGGLEOVERTYPE 2324

'  Cancel Any modes such As Call tip Or auto-completion list display.
#Define wxSTC_CMD_CANCEL 2325

'  Delete the selection Or If no selection, the character before the caret.
#Define wxSTC_CMD_DELETEBACK 2326

'  If selection Is empty Or all On one Line replace the selection With a Tab character.
'  If more than one Line selected, indent the lines.
#Define wxSTC_CMD_TAB 2327

'  Dedent the selected lines.
#Define wxSTC_CMD_BACKTAB 2328

'  Insert a New Line, may use a CRLF, CR Or LF depending On EOL mode.
#Define wxSTC_CMD_NEWLINE 2329

'  Insert a Form Feed character.
#Define wxSTC_CMD_FORMFEED 2330

'  Move caret To before first visible character On line.
'  If already there move To first character On line.
#Define wxSTC_CMD_VCHOME 2331

'  Like VCHome but extending selection To New caret position.
#Define wxSTC_CMD_VCHOMEEXTEND 2332

'  Magnify the displayed text by increasing the sizes by 1 point.
#Define wxSTC_CMD_ZOOMIN 2333

'  Make the displayed text smaller by decreasing the sizes by 1 point.
#Define wxSTC_CMD_ZOOMOUT 2334

'  Delete the word To the Left of the caret.
#Define wxSTC_CMD_DELWORDLEFT 2335

'  Delete the word To the Right of the caret.
#Define wxSTC_CMD_DELWORDRIGHT 2336

'  Delete the word To the Right of the caret, but Not the trailing non-word characters.
#Define wxSTC_CMD_DELWORDRIGHTEND 2518

'  Cut the Line containing the caret.
#Define wxSTC_CMD_LINECUT 2337

'  Delete the Line containing the caret.
#Define wxSTC_CMD_LINEDELETE 2338

'  Switch the current Line With the previous.
#Define wxSTC_CMD_LINETRANSPOSE 2339

'  Duplicate the current line.
#Define wxSTC_CMD_LINEDUPLICATE 2404

'  Transform the selection To lower case.
#Define wxSTC_CMD_LOWERCASE 2340

'  Transform the selection To upper case.
#Define wxSTC_CMD_UPPERCASE 2341

'  Scroll the document down, keeping the caret visible.
#Define wxSTC_CMD_LINESCROLLDOWN 2342

'  Scroll the document up, keeping the caret visible.
#Define wxSTC_CMD_LINESCROLLUP 2343

'  Delete the selection Or If no selection, the character before the caret.
'  Will Not Delete the character before at the start of a line.
#Define wxSTC_CMD_DELETEBACKNOTLINE 2344

'  Move caret To first position On display line.
#Define wxSTC_CMD_HOMEDISPLAY 2345

'  Move caret To first position On display Line extending selection To
'  New caret position.
#Define wxSTC_CMD_HOMEDISPLAYEXTEND 2346

'  Move caret To last position On display line.
#Define wxSTC_CMD_LINEENDDISPLAY 2347

'  Move caret To last position On display Line extending selection To New
'  caret position.
#Define wxSTC_CMD_LINEENDDISPLAYEXTEND 2348

'  These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
'  except they behave differently when word-wrap Is enabled:
'  They go first To the start / End of the display Line, like (Home|LineEnd)Display
'  The difference Is that, the cursor Is already at the Point, it goes On To the start
'  Or End of the document Line, As appropriate For (Home|LineEnd|VCHome)(Extend)?.
#Define wxSTC_CMD_HOMEWRAP 2349
#Define wxSTC_CMD_HOMEWRAPEXTEND 2450
#Define wxSTC_CMD_LINEENDWRAP 2451
#Define wxSTC_CMD_LINEENDWRAPEXTEND 2452
#Define wxSTC_CMD_VCHOMEWRAP 2453
#Define wxSTC_CMD_VCHOMEWRAPEXTEND 2454

'  Copy the Line containing the caret.
#Define wxSTC_CMD_LINECOPY 2455

'  Move To the previous change in capitalisation.
#Define wxSTC_CMD_WORDPARTLEFT 2390

'  Move To the previous change in capitalisation extending selection
'  To New caret position.
#Define wxSTC_CMD_WORDPARTLEFTEXTEND 2391

'  Move To the change Next in capitalisation.
#Define wxSTC_CMD_WORDPARTRIGHT 2392

'  Move To the Next change in capitalisation extending selection
'  To New caret position.
#Define wxSTC_CMD_WORDPARTRIGHTEXTEND 2393

'  Delete back from the current position To the start of the line.
#Define wxSTC_CMD_DELLINELEFT 2395

'  Delete forwards from the current position To the End of the line.
#Define wxSTC_CMD_DELLINERIGHT 2396

'  Move caret between paragraphs (delimited by empty lines).
#Define wxSTC_CMD_PARADOWN 2413
#Define wxSTC_CMD_PARADOWNEXTEND 2414
#Define wxSTC_CMD_PARAUP 2415
#Define wxSTC_CMD_PARAUPEXTEND 2416

'  Move caret down one Line, extending rectangular selection To New caret position.
#Define wxSTC_CMD_LINEDOWNRECTEXTEND 2426

'  Move caret up one Line, extending rectangular selection To New caret position.
#Define wxSTC_CMD_LINEUPRECTEXTEND 2427

'  Move caret Left one character, extending rectangular selection To New caret position.
#Define wxSTC_CMD_CHARLEFTRECTEXTEND 2428

'  Move caret Right one character, extending rectangular selection To New caret position.
#Define wxSTC_CMD_CHARRIGHTRECTEXTEND 2429

'  Move caret To first position On Line, extending rectangular selection To New caret position.
#Define wxSTC_CMD_HOMERECTEXTEND 2430

'  Move caret To before first visible character On line.
'  If already there move To first character On line.
'  In either Case, extend rectangular selection To New caret position.
#Define wxSTC_CMD_VCHOMERECTEXTEND 2431

'  Move caret To last position On Line, extending rectangular selection To New caret position.
#Define wxSTC_CMD_LINEENDRECTEXTEND 2432

'  Move caret one page up, extending rectangular selection To New caret position.
#Define wxSTC_CMD_PAGEUPRECTEXTEND 2433

'  Move caret one page down, extending rectangular selection To New caret position.
#Define wxSTC_CMD_PAGEDOWNRECTEXTEND 2434

'  Move caret To top of page, Or one page up If already at top of page.
#Define wxSTC_CMD_STUTTEREDPAGEUP 2435

'  Move caret To top of page, Or one page up If already at top of page, extending selection To New caret position.
#Define wxSTC_CMD_STUTTEREDPAGEUPEXTEND 2436

'  Move caret To bottom of page, Or one page down If already at bottom of page.
#Define wxSTC_CMD_STUTTEREDPAGEDOWN 2437

'  Move caret To bottom of page, Or one page down If already at bottom of page, extending selection To New caret position.
#Define wxSTC_CMD_STUTTEREDPAGEDOWNEXTEND 2438

'  Move caret Left one word, position cursor at End of word.
#Define wxSTC_CMD_WORDLEFTEND 2439

'  Move caret Left one word, position cursor at End of word, extending selection To New caret position.
#Define wxSTC_CMD_WORDLEFTENDEXTEND 2440

'  Move caret Right one word, position cursor at End of word.
#Define wxSTC_CMD_WORDRIGHTEND 2441

'  Move caret Right one word, position cursor at End of word, extending selection To New caret position.
#Define wxSTC_CMD_WORDRIGHTENDEXTEND 2442

' }}}
' ----------------------------------------------------------------------

    Enum
        wxEVT_STC_CHANGE,
        wxEVT_STC_STYLENEEDED,
        wxEVT_STC_CHARADDED,
        wxEVT_STC_SAVEPOINTREACHED,
        wxEVT_STC_SAVEPOINTLEFT,
        wxEVT_STC_ROMODIFYATTEMPT,
        wxEVT_STC_KEY,
        wxEVT_STC_DOUBLECLICK,
        wxEVT_STC_UPDATEUI,
        wxEVT_STC_MODIFIED,
        wxEVT_STC_MACRORECORD,
        wxEVT_STC_MARGINCLICK,
        wxEVT_STC_NEEDSHOWN,
        wxEVT_STC_PAINTED,
        wxEVT_STC_USERLISTSELECTION,
        wxEVT_STC_URIDROPPED,
        wxEVT_STC_DWELLSTART,
        wxEVT_STC_DWELLEND,
        wxEVT_STC_START_DRAG,
        wxEVT_STC_DRAG_OVER,
        wxEVT_STC_DO_DROP,
        wxEVT_STC_ZOOM,
        wxEVT_STC_HOTSPOT_CLICK,
        wxEVT_STC_HOTSPOT_DCLICK,
        wxEVT_STC_CALLTIP_CLICK,
        wxEVT_STC_AUTOCOMP_SELECTION,
        wxEVT_STC_INDICATOR_CLICK,
        wxEVT_STC_INDICATOR_RELEASE,
        wxEVT_STC_AUTOCOMP_CANCELLED,
        wxEVT_STC_AUTOCOMP_CHAR_DELETED
    End Enum

#EndIf ' __defs_bi__
