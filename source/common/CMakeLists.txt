add_library(common)

target_sources( common PRIVATE
                BaseAction.h
                BaseAction.cpp
                IMouseEvents.h)

target_include_directories(common PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(common PUBLIC imageProvider)
