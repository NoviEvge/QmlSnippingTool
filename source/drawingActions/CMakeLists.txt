add_library(drawingActions)

target_sources( drawingActions PRIVATE
                ActionManager.h
                ActionManager.cpp
                PenAction.h
                PenAction.cpp
                HighlighterAction.h
                HighlighterAction.cpp
                ActionTypesEnum.h)

target_include_directories(drawingActions PUBLIC ${CMAKE_CURRENT_LIST_DIR})

target_link_libraries(drawingActions PUBLIC support)
target_link_libraries(drawingActions PUBLIC common)
