'' FreeBASIC binding for libSM-1.2.2

#pragma once

#define _SM_H_
const SmProtoMajor = 1
const SmProtoMinor = 0
const SmInteractStyleNone = 0
const SmInteractStyleErrors = 1
const SmInteractStyleAny = 2
const SmDialogError = 0
const SmDialogNormal = 1
const SmSaveGlobal = 0
const SmSaveLocal = 1
const SmSaveBoth = 2
const SmRestartIfRunning = 0
const SmRestartAnyway = 1
const SmRestartImmediately = 2
const SmRestartNever = 3
#define SmCloneCommand "CloneCommand"
#define SmCurrentDirectory "CurrentDirectory"
#define SmDiscardCommand "DiscardCommand"
#define SmEnvironment "Environment"
#define SmProcessID "ProcessID"
#define SmProgram "Program"
#define SmRestartCommand "RestartCommand"
#define SmResignCommand "ResignCommand"
#define SmRestartStyleHint "RestartStyleHint"
#define SmShutdownCommand "ShutdownCommand"
#define SmUserID "UserID"
#define SmCARD8 "CARD8"
#define SmARRAY8 "ARRAY8"
#define SmLISTofARRAY8 "LISTofARRAY8"
const SM_Error = 0
const SM_RegisterClient = 1
const SM_RegisterClientReply = 2
const SM_SaveYourself = 3
const SM_SaveYourselfRequest = 4
const SM_InteractRequest = 5
const SM_Interact = 6
const SM_InteractDone = 7
const SM_SaveYourselfDone = 8
const SM_Die = 9
const SM_ShutdownCancelled = 10
const SM_CloseConnection = 11
const SM_SetProperties = 12
const SM_DeleteProperties = 13
const SM_GetProperties = 14
const SM_PropertiesReply = 15
const SM_SaveYourselfPhase2Request = 16
const SM_SaveYourselfPhase2 = 17
const SM_SaveComplete = 18
