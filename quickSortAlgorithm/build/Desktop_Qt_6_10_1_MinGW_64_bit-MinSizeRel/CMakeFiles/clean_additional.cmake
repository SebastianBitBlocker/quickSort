# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "MinSizeRel")
  file(REMOVE_RECURSE
  "CMakeFiles\\appquickSortAlgorithm_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appquickSortAlgorithm_autogen.dir\\ParseCache.txt"
  "appquickSortAlgorithm_autogen"
  )
endif()
