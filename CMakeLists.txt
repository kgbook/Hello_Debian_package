cmake_minimum_required(VERSION 3.25)
project(Hello_Debian_package)

set(CMAKE_CXX_STANDARD 11)

add_executable(${PROJECT_NAME} main.cpp)
