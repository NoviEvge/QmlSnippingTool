cmake_minimum_required(VERSION 3.21)
project(QmlSnippingTool)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(INSTALLED_QT_VERSION 6)

add_executable(${CMAKE_PROJECT_NAME} main.cpp )

target_sources( ${CMAKE_PROJECT_NAME}
                PUBLIC
                    QmlSnippingTool.h
                PRIVATE
                    QmlSnippingTool.cpp)

add_subdirectory(support)
add_subdirectory(snippingAreas)

find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Qml REQUIRED)
find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Gui REQUIRED)

target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Qml)
target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Core)
target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Gui)

qt_add_resources(QRC_BUILT_SRCS RESOURCES qml.qrc)
