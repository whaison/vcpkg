function(vcpkg_install_cmake)
    cmake_parse_arguments(_bc "MSVC_64_TOOLSET;DISABLE_PARALLEL" "" "" ${ARGN})

    set(MSVC_EXTRA_ARGS)

    # Specifies the architecture of the toolset, NOT the architecture of the produced binary
    if (_bc_MSVC_64_TOOLSET)
        list(APPEND MSVC_EXTRA_ARGS "/p:PreferredToolArchitecture=x64")
    endif()

    if (NOT _bc_DISABLE_PARALLEL)
        list(APPEND MSVC_EXTRA_ARGS "/m")
    endif()

    message(STATUS "Package ${TARGET_TRIPLET}-rel")
    vcpkg_execute_required_process(
        COMMAND ${CMAKE_COMMAND} --build . --config Release --target install -- /p:VCPkgLocalAppDataDisabled=true ${MSVC_EXTRA_ARGS}
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel
        LOGNAME package-${TARGET_TRIPLET}-rel
    )
    message(STATUS "Package ${TARGET_TRIPLET}-rel done")

    message(STATUS "Package ${TARGET_TRIPLET}-dbg")
    vcpkg_execute_required_process(
        COMMAND ${CMAKE_COMMAND} --build . --config Debug --target install -- /p:VCPkgLocalAppDataDisabled=true ${MSVC_EXTRA_ARGS}
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg
        LOGNAME package-${TARGET_TRIPLET}-dbg
    )
    message(STATUS "Package ${TARGET_TRIPLET}-dbg done")
endfunction()
