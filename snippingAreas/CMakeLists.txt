add_library(snippingAreas)

target_sources( snippingAreas PRIVATE
                    BaseSnippingArea.h
                    BaseSnippingArea.cpp
                    FreeFormSnippingArea.h
                    FreeFormSnippingArea.cpp
                    FullscreenSnippingArea.h
                    FullscreenSnippingArea.cpp
                    RectangleSnippingArea.h
                    RectangleSnippingArea.cpp)

target_include_directories(snippingAreas PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(snippingAreas PUBLIC support)
