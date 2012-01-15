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
  SOLID       = 100
  TRANSPARENT = 106
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

#EndIf ' __defs_bi__
