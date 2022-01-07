add_library(imageProvider)

target_sources( imageProvider PRIVATE
                ImageProvider.h
                ImageProvider.cpp
                ImageProviderEnum.h)

target_include_directories(imageProvider PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(imageProvider PUBLIC Qt${INSTALLED_QT_VERSION}::Gui)
target_link_libraries(imageProvider PUBLIC Qt${INSTALLED_QT_VERSION}::Quick)
