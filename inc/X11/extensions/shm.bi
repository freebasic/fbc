#pragma once

#define _SHM_H_
#define SHMNAME "MIT-SHM"
const SHM_MAJOR_VERSION = 1
const SHM_MINOR_VERSION = 2
const ShmCompletion = 0
#define ShmNumberEvents (ShmCompletion + 1)
const BadShmSeg = 0
#define ShmNumberErrors (BadShmSeg + 1)
