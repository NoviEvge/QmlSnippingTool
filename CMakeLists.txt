cmake_minimum_required(VERSION 3.21)
project(QmlSnippingTool)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS_DEBUG  "-g -Wall -Wextra -Wpedantic -Werror")
set(CMAKE_CXX_FLAGS_RELEASE  "-s -O3")

set(INSTALLED_QT_VERSION 6)

find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Qml REQUIRED)
find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Gui REQUIRED)
find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Core REQUIRED)
find_package(Qt${INSTALLED_QT_VERSION} COMPONENTS Quick REQUIRED)

add_subdirectory(common)
add_subdirectory(support)
add_subdirectory(imageProvider)
add_subdirectory(snippingActions)
add_subdirectory(drawingActions)

if(${INSTALLED_QT_VERSION} LESS 6)
    qt5_add_resources( RESOURCES qml/qml.qrc)
else()
    qt_add_resources( RESOURCES qml/qml.qrc)
endif()

add_executable(${CMAKE_PROJECT_NAME} main.cpp ${RESOURCES})

target_sources( ${CMAKE_PROJECT_NAME}
                PUBLIC
                    QmlSnippingTool.h
                PRIVATE
                    QmlSnippingTool.cpp)

target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Qml)
target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Core)
target_link_libraries(${CMAKE_PROJECT_NAME} Qt${INSTALLED_QT_VERSION}::Gui)

target_link_libraries(${CMAKE_PROJECT_NAME} common)
target_link_libraries(${CMAKE_PROJECT_NAME} support)
target_link_libraries(${CMAKE_PROJECT_NAME} imageProvider)
target_link_libraries(${CMAKE_PROJECT_NAME} snippingActions)
target_link_libraries(${CMAKE_PROJECT_NAME} drawingActions)

set(BINARY_PATH ${CMAKE_SOURCE_DIR}/build/bin/${CMAKE_BUILD_TYPE})
set(RUNTIME_OUTPUT_DIRECTORY_TYPE "RUNTIME_OUTPUT_DIRECTORY_${CMAKE_BUILD_TYPE}")
string(TOUPPER ${RUNTIME_OUTPUT_DIRECTORY_TYPE} RUNTIME_OUTPUT_DIRECTORY_TYPE)

set_target_properties(QmlSnippingTool PROPERTIES ${RUNTIME_OUTPUT_DIRECTORY_TYPE} ${BINARY_PATH})

set(DEPLOYMENT_FILE "Deployment${CMAKE_SYSTEM_NAME}.json")
configure_file("${CMAKE_SOURCE_DIR}/cmake/${DEPLOYMENT_FILE}.in" "${CMAKE_BINARY_DIR}/${DEPLOYMENT_FILE}")

if(CMAKE_BUILD_TYPE STREQUAL "Release")
	add_custom_command(TARGET ${CMAKE_PROJECT_NAME}
					POST_BUILD
					COMMAND cqtdeployer
					-confFile "${CMAKE_BINARY_DIR}/${DEPLOYMENT_FILE}"
					-icon $<$<PLATFORM_ID:Linux>:${CMAKE_SOURCE_DIR}/icons/icon.png>
						  $<$<PLATFORM_ID:Windows>:${CMAKE_SOURCE_DIR}/icons/icon.ico>)
endif()