#include <windows.h>
#include <cstdlib>

#if _WIN64
#define __decorate(__func) WINAPI __imp_##__func
#else
#define __decorate(__func) WINAPI _imp__##__func
#endif

extern "C" {

BOOL __decorate(SetInformationJobObject)(
    HANDLE hJob,
    JOBOBJECTINFOCLASS JobObjectInformationClass,
    LPVOID lpJobObjectInformation,
    DWORD cbJobObjectInformationLength) {
  std::abort();
  return false;
}

HANDLE __decorate(
    CreateJobObjectW)(LPSECURITY_ATTRIBUTES lpJobAttributes, LPCTSTR lpName) {
  std::abort();
  return 0;
}

BOOL __decorate(AssignProcessToJobObject)(HANDLE hJob, HANDLE hProcess) {
  std::abort();
  return false;
}

/*

typedef struct _PROCESS_INFORMATION {
  HANDLE hProcess;
  HANDLE hThread;
  DWORD dwProcessId;
  DWORD dwThreadId;
} PROCESS_INFORMATION, *PPROCESS_INFORMATION, *LPPROCESS_INFORMATION;

typedef struct _STARTUPINFOW {
  DWORD cb;
  LPWSTR lpReserved;
  LPWSTR lpDesktop;
  LPWSTR lpTitle;
  DWORD dwX;
  DWORD dwY;
  DWORD dwXSize;
  DWORD dwYSize;
  DWORD dwXCountChars;
  DWORD dwYCountChars;
  DWORD dwFillAttribute;
  DWORD dwFlags;
  WORD wShowWindow;
  WORD cbReserved2;
  LPBYTE lpReserved2;
  HANDLE hStdInput;
  HANDLE hStdOutput;
  HANDLE hStdError;
} STARTUPINFOW, *LPSTARTUPINFOW; */

BOOL __decorate(CreateProcessW)(
    LPCWSTR lpApplicationName,
    LPWSTR lpCommandLine,
    LPSECURITY_ATTRIBUTES lpProcessAttributes,
    LPSECURITY_ATTRIBUTES lpThreadAttributes,
    BOOL bInheritHandles,
    DWORD dwCreationFlags,
    LPVOID lpEnvironment,
    LPCWSTR lpCurrentDirectory,
    LPSTARTUPINFOW lpStartupInfo,
    LPPROCESS_INFORMATION lpProcessInformation) {
  std::abort();
  return false;
}

BOOL __decorate(GetExitCodeProcess)(HANDLE hProcess, LPDWORD lpExitCode) {
  std::abort();
  return false;
}

DWORD __decorate(SearchPathW)(
    LPCWSTR lpPath,
    LPCWSTR lpFileName,
    LPCWSTR lpExtension,
    DWORD nBufferLength,
    LPWSTR lpBuffer,
    LPWSTR *lpFilePart) {
  std::abort();
  return 0;
}

BOOL __decorate(SetConsoleTextAttribute)(
    _In_ HANDLE hConsoleOutput,
    _In_ WORD wAttributes) {
  std::abort();
  return false;
}

/*
typedef struct _SMALL_RECT {
  SHORT Left;
  SHORT Top;
  SHORT Right;
  SHORT Bottom;
} SMALL_RECT, *PSMALL_RECT;

typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
  COORD dwSize;
  COORD dwCursorPosition;
  WORD wAttributes;
  SMALL_RECT srWindow;
  COORD dwMaximumWindowSize;
} CONSOLE_SCREEN_BUFFER_INFO, *PCONSOLE_SCREEN_BUFFER_INFO;*/

BOOL __decorate(GetConsoleScreenBufferInfo)(
    _In_ HANDLE hConsoleOutput,
    _Out_ PCONSOLE_SCREEN_BUFFER_INFO lpConsoleScreenBufferInfo) {
  // std::abort();
  // This is called on LLVM init.
  return false;
}

BOOL __decorate(SetConsoleMode)(_In_ HANDLE hConsoleHandle, _In_ DWORD dwMode) {
  std::abort();
  return false;
}

BOOL __decorate(GetConsoleMode)(_In_ HANDLE hConsoleHandle, _Out_ LPDWORD lpMode) {
  std::abort();
  return false;
}

BOOL __decorate(GetProcessTimes)(
    HANDLE hProcess,
    LPFILETIME lpCreationTime,
    LPFILETIME lpExitTime,
    LPFILETIME lpKernelTime,
    LPFILETIME lpUserTime) {
  std::abort();
  return false;
}

HANDLE WINAPI __decorate(GetStdHandle)(_In_ DWORD nStdHandle) {
  // std::abort();
  return 0;
}

BOOL WINAPI __decorate(SetConsoleCtrlHandler)(
    _In_opt_ PHANDLER_ROUTINE HandlerRoutine,
    _In_ BOOL Add) {
  std::abort();
  return false;
}

HMODULE __decorate(LoadLibraryW)(LPCTSTR lpLibFileName) {
  std::abort();
  return 0;
}

UINT __decorate(SetErrorMode)(UINT uMode) {
  std::abort();
  return 0;
}

DWORD __decorate(ExpandEnvironmentStringsW)(
    LPCWSTR lpSrc,
    LPWSTR lpDst,
    DWORD nSize) {
  std::abort();
  return 0;
}

VOID __decorate(RtlCaptureContext)(PCONTEXT ContextRecord) {
  std::abort();
  return;
}

BOOL __decorate(CreateHardLinkW)(
    LPTSTR lpFileName,
    LPTSTR lpExistingFileName,
    LPSECURITY_ATTRIBUTES lpSecurityAttributes) {
  std::abort();
  return false;
}

LPVOID __decorate(MapViewOfFile)(
    HANDLE hFileMappingObject,
    DWORD dwDesiredAccess,
    DWORD dwFileOffsetHigh,
    DWORD dwFileOffsetLow,
    SIZE_T dwNumberOfBytesToMap) {
  std::abort();
  return nullptr;
}

HANDLE __decorate(CreateFileMappingW)(
    HANDLE hFile,
    LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
    DWORD flProtect,
    DWORD dwMaximumSizeHigh,
    DWORD dwMaximumSizeLow,
    LPCTSTR lpName) {
  std::abort();
  return 0;
}

BOOL __decorate(GetVolumePathNameW)(
    LPCWSTR lpszFileName,
    LPWSTR lpszVolumePathName,
    DWORD cchBufferLength) {
  std::abort();
  return false;
}

/*
typedef struct _BY_HANDLE_FILE_INFORMATION {
  DWORD dwFileAttributes;
  FILETIME ftCreationTime;
  FILETIME ftLastAccessTime;
  FILETIME ftLastWriteTime;
  DWORD dwVolumeSerialNumber;
  DWORD nFileSizeHigh;
  DWORD nFileSizeLow;
  DWORD nNumberOfLinks;
  DWORD nFileIndexHigh;
  DWORD nFileIndexLow;
} BY_HANDLE_FILE_INFORMATION, *PBY_HANDLE_FILE_INFORMATION,
    *LPBY_HANDLE_FILE_INFORMATION; */

BOOL __decorate(GetFileInformationByHandle)(
    HANDLE hFile,
    LPBY_HANDLE_FILE_INFORMATION lpFileInformation) {
  std::abort();
  return false;
}

UINT __decorate(GetDriveTypeW)(LPTSTR lpRootPathName) {
  std::abort();
  return 0;
}

HANDLE __decorate(CreateFileW)(
    LPTSTR lpFileName,
    DWORD dwDesiredAccess,
    DWORD dwShareMode,
    LPSECURITY_ATTRIBUTES lpSecurityAttributes,
    DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes,
    HANDLE hTemplateFile) {
  std::abort();
  return 0;
}

DWORD __decorate(GetEnvironmentVariableW)(
    LPCTSTR lpName,
    LPTSTR lpBuffer,
    DWORD nSize) {
  std::abort();
  return 0;
}

BOOL __decorate(WriteConsoleW)(
    _In_ HANDLE hConsoleOutput,
    _In_ const VOID *lpBuffer,
    _In_ DWORD nNumberOfCharsToWrite,
    _Out_ LPDWORD lpNumberOfCharsWritten,
    _Reserved_ LPVOID lpReserved) {
  std::abort();
  return false;
}

BOOL __decorate(VerifyVersionInfoW)(
    LPOSVERSIONINFOEXW lpVersionInformation,
    DWORD dwTypeMask,
    DWORDLONG dwlConditionMask) {
  std::abort();
  return false;
}

ULONGLONG __decorate(VerSetConditionMask)(
    ULONGLONG ConditionMask,
    DWORD TypeMask,
    BYTE Condition) {
  std::abort();
  return 0;
}

BOOL __decorate(GetThreadTimes)(
    HANDLE hThread,
    LPFILETIME lpCreationTime,
    LPFILETIME lpExitTime,
    LPFILETIME lpKernelTime,
    LPFILETIME lpUserTime) {
  // std::abort();
  // This is called from RAIITimer in Hermes.. for sampling profiler.
  return false;
}

}