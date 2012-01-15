#Ifndef __reflectconfig_bi__
#Define __reflectconfig_bi__

#Include Once "common.bi"

Declare Function ReflectConfig_CheckWxMSW WXCALL Alias "ReflectConfig_CheckWxMSW" () As wxBool
Declare Function ReflectConfig_CheckWxMAC WXCALL Alias "ReflectConfig_CheckWxMAC" () As wxBool
Declare Function ReflectConfig_CheckWxGTK WXCALL Alias "ReflectConfig_CheckWxGTK" () As wxBool
Declare Function ReflectConfig_CheckUseUnicode WXCALL Alias "ReflectConfig_CheckUseUnicode" () As wxBool
Declare Function ReflectConfig_CheckWxWinCompatibility24 WXCALL Alias "ReflectConfig_CheckWxWinCompatibility24" () As wxBool
Declare Function ReflectConfig_CheckWxWinCompatibility26 WXCALL Alias "ReflectConfig_CheckWxWinCompatibility26" () As wxBool
Declare Function ReflectConfig_CheckWxWinVersion26 WXCALL Alias "ReflectConfig_CheckWxWinVersion26" () As wxBool
Declare Function ReflectConfig_CheckWxWinVersion28 WXCALL Alias "ReflectConfig_CheckWxWinVersion28" () As wxBool
Declare Function ReflectConfig_CheckUseTabDialog WXCALL Alias "ReflectConfig_CheckUseTabDialog" () As wxBool

#EndIf ' __reflectconfig_bi__

