# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

set(source_files
  dllmain.cpp
  stubs.cpp
)

add_hermes_library(hermesPlatformUWP STATIC ${source_files})