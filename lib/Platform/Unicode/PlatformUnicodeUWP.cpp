/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include "hermes/Platform/Unicode/PlatformUnicode.h"

#if HERMES_PLATFORM_UNICODE == HERMES_PLATFORM_UNICODE_UWP

#include "hermes/Platform/Unicode/icu.h"

#include <time.h>

#include <chrono>
#include <ctime>
#include <iomanip>
#include <sstream>

namespace hermes {
namespace platform_unicode {

int localeCompare(
    llvm::ArrayRef<char16_t> left,
    llvm::ArrayRef<char16_t> right) {
   std::wstring str1((const UChar *)left.data(), left.size());
  std::wstring str2((const UChar *)right.data(), right.size());
  return str1.compare(str2);
}

void dateFormat(
    double unixtimeMs,
    bool formatDate,
    bool formatTime,
    llvm::SmallVectorImpl<char16_t> &buf) {

    // Sample output : "Jan 2, 1970, 5:47:04 PM"

  std::time_t time_t = std::chrono::system_clock::to_time_t(
      std::chrono::system_clock::time_point(
          std::chrono::milliseconds(static_cast<uint64_t>(unixtimeMs))));
  std::tm tm = *std::localtime(&time_t);

  std::stringstream ss;
  std::string format;
  if (formatDate & formatTime) {
    format = "%b %e, %Y, %T";
  } else if (formatDate) {
    format = "%b %e, %Y";
  } else if (formatTime) {
    format = "%T";
  }

  ss << std::put_time(&tm, format.c_str());

  std::string sstr = ss.str();
  std::wstring wsstr = std::wstring(sstr.begin(), sstr.end());

  int idx = 0;
  buf.resize(wsstr.length() * sizeof(wchar_t));
  for (wchar_t wc : wsstr) {
    buf[idx++] = wc;
  }
}

void convertToCase(
    llvm::SmallVectorImpl<char16_t> &buf,
    CaseConversion targetCase,
    bool useCurrentLocale) {
    if (targetCase == CaseConversion::ToUpper)
    for (auto c : buf) {
      c = std::toupper(c);
    }
  /*std::for_each(
      buf.begin(), buf.end(), [](wchar_t &c) { c = std::toupper(c); });*/
  else

    for (auto c : buf) {
      c = std::tolower(c);
    }
  /*std::for_each(
      buf.begin(), buf.end(), [](wchar_t &c) { c = std::tolower(c); });*/
}

void normalize(llvm::SmallVectorImpl<char16_t> &buf, NormalizationForm form) {
  // NOPE
}

} // namespace platform_unicode
} // namespace hermes

#endif // HERMES_PLATFORM_UNICODE_ICU