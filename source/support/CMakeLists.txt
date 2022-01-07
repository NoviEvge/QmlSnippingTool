add_library(support)

target_sources( support PRIVATE
                FileOperationsManager.h
                FileOperationsManager.cpp
                HighDpi.h
                HighDpi.cpp)

target_include_directories(support PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(support PUBLIC Qt${INSTALLED_QT_VERSION}::Core)

target_link_libraries(support PUBLIC imageProvider)
