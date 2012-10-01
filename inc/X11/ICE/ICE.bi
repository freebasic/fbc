''
''
'' ICE -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ICE_bi__
#define __ICE_bi__

#define IceProtoMajor 1
#define IceProtoMinor 0
#define IceLSBfirst 0
#define IceMSBfirst 1
#define ICE_Error 0
#define ICE_ByteOrder 1
#define ICE_ConnectionSetup 2
#define ICE_AuthRequired 3
#define ICE_AuthReply 4
#define ICE_AuthNextPhase 5
#define ICE_ConnectionReply 6
#define ICE_ProtocolSetup 7
#define ICE_ProtocolReply 8
#define ICE_Ping 9
#define ICE_PingReply 10
#define ICE_WantToClose 11
#define ICE_NoClose 12
#define IceCanContinue 0
#define IceFatalToProtocol 1
#define IceFatalToConnection 2
#define IceBadMinor &h8000
#define IceBadState &h8001
#define IceBadLength &h8002
#define IceBadValue &h8003
#define IceBadMajor 0
#define IceNoAuth 1
#define IceNoVersion 2
#define IceSetupFailed 3
#define IceAuthRejected 4
#define IceAuthFailed 5
#define IceProtocolDuplicate 6
#define IceMajorOpcodeDuplicate 7
#define IceUnknownProtocol 8

#endif
