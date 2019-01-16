import qbs

Module {
    Depends { name: "cpp" }
    cpp.includePaths: qbs.installRoot + "/include/backend"
    cpp.libraryPaths: qbs.installRoot + "/lib"
    cpp.dynamicLibraries: qbs.installRoot + "/lib/" + (qbs.targetOS.contains("windows") ? "phoenix-backend.dll":"libphoenix-backend.so")
}

