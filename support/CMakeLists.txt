add_library(support)

target_sources( support PRIVATE
                FileOperationsManager.h
                FileOperationsManager.cpp
                HighDpiScaler.h
                HighDpiScaler.cpp
                ImageProvider.h
                ImageProvider.cpp
                ImagesContainer.h
                ImagesContainer.cpp
                MouseEventHandler.h
                MouseEventHandler.cpp
                CaptureMode.h
                CaptureMode.cpp)

target_include_directories(support PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(support PUBLIC Qt${INSTALLED_QT_VERSION}::Core)
target_link_libraries(support PUBLIC Qt${INSTALLED_QT_VERSION}::Gui)
target_link_libraries(support PUBLIC Qt${INSTALLED_QT_VERSION}::Quick)
