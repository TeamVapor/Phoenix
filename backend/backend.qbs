import qbs
Project{
    name:"phoenix-backend"
    property string deployDir: "/build/"
    Product{
        type:["dynamiclibrary"]
        name:"phoenix-backend"


        Depends{name:'cpp'}
        Depends {
            name: "Qt"
            submodules: {
                var modules = [ "qml", "quick", "multimedia" ];
                if ( qbs.targetOS.contains( "osx" ) ) {
                    modules.push( "platformsupport-private" );
                }
                return modules;
            }
        }

        Group { qbs.install: true; fileTagsFilter: product.type;}

        Export { Depends { name: "cpp" } cpp.includePaths: [ "." ] }

        cpp.includePaths: {
            var paths = [ ".", ".." ]

            // Include out stuff
            paths = paths.concat( ["/usr/include/","/usr/include/SDL2/", "consumer", "control", "core", "input", "pipeline", "util" ] )

            if ( qbs.targetOS.contains( "osx" ) ) {
                paths = paths.concat( [ "/usr/local/include",

                                "/usr/local/include/SDL2", // Homebrew
                                "/opt/local/include/SDL2", // MacPorts

                                ".",
                                "..",
                                "../externals/quazip/quazip",

                                // Include our stuff
                                "consumer", "control", "core", "input", "pipeline", "util" ] )

            }
            return paths;
        }

        cpp.libraryPaths: {
            var paths = ["/usr/local/lib"];
            if ( qbs.targetOS.contains( "osx" ) ) {
                paths = paths.concat( [ "/usr/local/lib" ] );
            }
            return paths;
        }

//        files: [
//            "*.h", "*/*.h",
//            "*.cpp", "*/*.cpp",
//            "util/*.mm",

//            "input/*.qrc",
//        ];

        cpp.dynamicLibraries: {
            var libs = [];
            if ( qbs.toolchain.contains( "msvc" ) ) {
                libs.push( "libsamplerate-0.lib" )
            } else {
                libs = libs.concat( [ "quazip", "SDL2", "samplerate", "z" ] );
                if ( qbs.targetOS.contains( "windows" ) ) {
                    libs = libs.push( "SDL2main" );
                }
                return libs;
            }
        }

        cpp.cxxLanguageVersion: "c++11";
        Group  {
            name: "phoenix_consumer"
            prefix:"consumer/"
            files: [
                "audiobuffer.h",
                "audiooutput.h",
                "videooutput.h",
                "videooutputnode.h",
                "audiobuffer.cpp",
                "audiooutput.cpp",
                "videooutput.cpp",
                "videooutputnode.cpp",
            ]
        }
        Group  {
            name: "phoenix_control"
            prefix:"control/"
            files: [
                "controloutput.cpp",
                "controloutput.h",
                "gameconsole.cpp",
                "gameconsole.h",
            ]
        }
        Group  {
            name: "phoenix_core"
            prefix:"core/"
            files: [
                "core.cpp",
                "core.h",
                "libretro.h",
                "libretrocore.cpp",
                "libretrocore.h",
                "libretroloader.cpp",
                "libretroloader.h",
                "libretrorunner.cpp",
                "libretrorunner.h",
                "libretrosymbols.cpp",
                "libretrosymbols.h",
                "libretrovariable.cpp",
                "libretrovariable.h",
                "libretrovariableforwarder.cpp",
                "libretrovariableforwarder.h",
                "libretrovariablemodel.cpp",
                "libretrovariablemodel.h",
            ]
        }
        Group  {
            name: "phoenix_pipeline"
            prefix:"pipeline/"
            files: [
                "node.cpp",
                "node.h",
                "pipelinecommon.h",
            ]
        }
        Group  {
            name: "phoenix_input"
            prefix:"input/"
            files: [
                "SDL_GameControllerDB/gamecontrollerdb.txt",
                "controllerdb.qrc",
                "gamepadstate.cpp",
                "gamepadstate.h",
                "globalgamepad.cpp",
                "globalgamepad.h",
                "keyboardstate.cpp",
                "keyboardstate.h",
                "mousestate.cpp",
                "mousestate.h",
                "remapper.cpp",
                "remapper.h",
                "remappermodel.cpp",
                "remappermodel.h",
                "sdlmanager.cpp",
                "sdlmanager.h",
                "sdlunloader.cpp",
                "sdlunloader.h",
            ]
        }
        Group {
            qbs.install: true
            fileTagsFilter: "dynamiclibrary"
            qbs.installDir: "/lib"
        }
        Group  {
            name: "phoenix_util"
            prefix:"util/"
            files: [
                "logging.cpp",
                "logging.h",
                "microtimer.cpp",
                "microtimer.h",
                "phoenixwindow.cpp",
                "phoenixwindow.h",
                "phoenixwindownode.cpp",
                "phoenixwindownode.h",
            ]
        }
        Group{
            files:["backendplugin.h"]
            qbs.installDir:  this.deployDir + "include/backend"
            qbs.install:  qbs.targetOS.contains("linux") && (qbs.configurationName == "Desktop")
        }

        cpp.defines:['PHOENIX_BACKEND']
        files:[
            "backendplugin.cpp",
        ]
    }
}
