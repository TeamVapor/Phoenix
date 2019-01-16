 
import qbs

Project {
    minimumQbsVersion: "1.7.1"
    qbsSearchPaths: "include_libs"

    CppApplication {
        name:"phoenix-frontend"
        Depends{name:'cpp'}
        Depends {
            name: "Qt";
            submodules:["core", "gui", "qml", "quick", "sql", "multimedia", "network", "concurrent", "svg" ]
        }
        Depends{
            name:'phoenix-backend'
        }

        // Additional import path used to resolve QML modules in Qt Creator's code model
        property pathList qmlImportPaths: ["qml/"]


        cpp.includePaths: ["/usr/include/SDL2/",this.deployDir + "include/backend",
                           "cpp/","cpp/library/","cpp/library/database","cpp/library/fileinfo", "cpp/library/model",
                           "cpp/library/scanner","../externals/quazip/quazip"]
        cpp.cxxLanguageVersion: "c++11"
        cpp.libraryPaths:[ this.deployDir + "lib" ];
        cpp.dynamicLibraries: ["quazip", "SDL2", "samplerate", 'z' ]
        cpp.defines: [
            // The following define makes your compiler emit warnings if you use
            // any feature of Qt which as been marked deprecated (the exact warnings
            // depend on your compiler). Please consult the documentation of the
            // deprecated API in order to know how to port your code away from it.
            "QT_DEPRECATED_WARNINGS"

            // You can also make your code fail to compile if you use deprecated APIs.
            // In order to do so, uncomment the following line.
            // You can also select to disable deprecated APIs only up to a certain version of Qt.
            //"QT_DISABLE_DEPRECATED_BEFORE=0x060000" // disables all the APIs deprecated before Qt 6.0.0
        ]
        Group{
            name:"phoenix_library_main"
            prefix:"cpp/library/"
            files:[
                "cuefile.cpp",
                "cuefile.h",
                "gamelauncher.cpp",
                "gamelauncher.h",
                "imagecacher.cpp",
                "imagecacher.h",
                "librarytypes.cpp",
                "librarytypes.h",
                "phxpaths.cpp",
                "phxpaths.h",
            ]
        }
        Group{
            name:"phoenix_database"
            prefix:"cpp/library/database/"
            files:[
                "databasehelper.cpp",
                "databasehelper.h",
            ]
        }
        Group{
            name:"phoenix_fileinfo"
            prefix:"cpp/library/fileinfo/"
            files:[
                "archivefile.cpp",
                "archivefile.h",
                "cryptohash.h",
                "cryptohash.cpp",
            ]
        }
        Group{
            name:"phoenix_scanner"
            prefix:"cpp/library/scanner/"
            files:[
                "gamehasher.cpp",
                "gamehasher.h",
                "gamehashercontroller.cpp",
                "gamehashercontroller.h",
                "mapfunctor.cpp",
                "mapfunctor.h",
                "reducefunctor.cpp",
                "reducefunctor.h",
                "scannerutil.cpp",
                "scannerutil.h",
            ]
        }
        Group{
            name:"phoenix_model"
            prefix:"cpp/library/model/"
            files:[
                "coremodel.cpp",
                "coremodel.h",
                "databasesettings.cpp",
                "databasesettings.h",
                "sqlcolumn.cpp",
                "sqlcolumn.h",
                "sqlmodel.cpp",
                "sqlmodel.h",
                "sqlthreadedmodel.cpp",
                "sqlthreadedmodel.h",
            ]
        }
        files: [
            "cpp/cmdlineargs.cpp",
            "cpp/cmdlineargs.h",
            "cpp/debughandler.h",
            "cpp/frontendcommon.h",
            "cpp/logging.cpp",
            "cpp/logging.h",
            "cpp/main.cpp",
            "qml/Emulator/ActionBar.qml",
            "qml/Emulator/qmldir",
            "qml/Frontend/GameGrid.qml",
            "qml/Frontend/Library.qml",
            "qml/Frontend/LibraryHeader.qml",
            "qml/Frontend/MinimizedGame.qml",
            "qml/Frontend/Sidebar.qml",
            "qml/Frontend/SystemList.qml",
            "qml/Frontend/WindowControls.qml",
            "qml/Frontend/qmldir",
            "qml/Phoenix/Emulator.qml",
            "qml/Phoenix/Frontend.qml",
            "qml/Phoenix/Phoenix.qml",
            "qml/Phoenix/TestUI.qml",
            "qml/Settings/InputSettings.qml",
            "qml/Settings/LibretroCoreSettings.qml",
            "qml/Settings/SettingsList.qml",
            "qml/Settings/qmldir",
            "qml/Theme/PhxComboBox.qml",
            "qml/Theme/PhxGridView.qml",
            "qml/Theme/PhxListView.qml",
            "qml/Theme/PhxScrollBar.qml",
            "qml/Theme/PhxScrollView.qml",
            "qml/Theme/PhxSearchBar.qml",
            "qml/Theme/PhxTheme.qml",
            "qml/Theme/qmldir",
            "qml/Util/MarqueeText.qml",
            "qml/Util/PhoenixLogo.qml",
            "qml/Util/qmldir",
            "qml/assets/add.svg",
            "qml/assets/add2.svg",
            "qml/assets/bg-t.jpg",
            "qml/assets/bg.svg",
            "qml/assets/bg0.png",
            "qml/assets/bg1.svg",
            "qml/assets/bg2.png",
            "qml/assets/bg3.png",
            "qml/assets/blur.svg",
            "qml/assets/close.svg",
            "qml/assets/collections.svg",
            "qml/assets/core.svg",
            "qml/assets/default.svg",
            "qml/assets/del.svg",
            "qml/assets/fullscreen.svg",
            "qml/assets/games.png",
            "qml/assets/games.svg",
            "qml/assets/minimize.svg",
            "qml/assets/noartwork.png",
            "qml/assets/pause.svg",
            "qml/assets/pause2.svg",
            "qml/assets/phoenix.png",
            "qml/assets/play.svg",
            "qml/assets/playstationController.svg",
            "qml/assets/resume.svg",
            "qml/assets/search.svg",
            "qml/assets/settings.svg",
            "qml/assets/shutdown.svg",
            "qml/assets/suspend.svg",
            "qml/assets/swap.svg",
            "qml/assets/systems/All.svg",
            "qml/assets/systems/Game Boy Advance.svg",
            "qml/assets/systems/Game Boy Color.svg",
            "qml/assets/systems/Game Boy.svg",
            "qml/assets/systems/Nintendo 64.svg",
            "qml/assets/systems/Nintendo DS.svg",
            "qml/assets/systems/Nintendo.svg",
            "qml/assets/systems/Sony PlayStation.svg",
            "qml/assets/systems/Super Nintendo.svg",
            "qml/assets/tv.svg",
            "qml/assets/tv169.svg",
            "qml/assets/tv43.svg",
            "qml/assets/volume.svg",
            "qml/assets/volumehalf.svg",
            "qml/assets/volumemute.svg",
            "qml/assets/window.svg",
        ]


    }

}
