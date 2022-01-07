add_library(snippingActions)

target_sources( snippingActions PRIVATE
                SnippingAreaManager.h
                SnippingAreaManager.cpp
                FreeFormSnippingArea.h
                FreeFormSnippingArea.cpp
                RectangleSnippingArea.h
                RectangleSnippingArea.cpp
                SnippingAreaEnum.h)

target_include_directories(snippingActions PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(snippingActions PUBLIC support)
target_link_libraries(snippingActions PUBLIC common)
