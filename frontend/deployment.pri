# Targets

##
## Phoenix executable (default target)
##

    TARGET = Phoenix

    # App icon, metadata
    win32: RC_FILE = phoenix.rc

    macx {
        ICON = phoenix.icns
        QMAKE_TARGET_BUNDLE_PREFIX = vg.phoenix
    }

##
## Common
##
    PWD_NATIVE = $$PWD
    OUT_PWD_NATIVE = $$OUT_PWD

    !win32 | defined( PHX_CROSS_COMPILE, var ) {
        PWD_UNIX = $$PWD_NATIVE
        OUT_PWD_UNIX = $$OUT_PWD_NATIVE

        isEmpty( PREFIX ) { PREFIX = $$OUT_PWD_NATIVE/../dist }

        # On OS X, write directly to within the .app folder as that's where the executable lives
        macx: OSX_BUNDLE_PATH = "$$sprintf( "%1/%2.app", $$OUT_PWD_NATIVE, $$TARGET )"
        macx: OUT_PWD_UNIX = "$$OSX_BUNDLE_PATH/Contents/MacOS"
        macx: OSX_BINARY_PATH_PREFIX = "$$sprintf( "%1/%2.app", $$PREFIX, $$TARGET )/Contents/MacOS"
    }

    # On Windows, the native DOS-style paths must be converted to Unix paths as the GNU coreutils we'll be using expect that
    # The default prefix is a folder called "dist" at the root of the build folder
    else {
        PWD_UNIX = $$system( cygpath -u \"$$PWD_NATIVE\" )
        OUT_PWD_UNIX = $$system( cygpath -u \"$$OUT_PWD_NATIVE\" )

        isEmpty( PREFIX ) { PREFIX = $$system( cygpath -u \"$$OUT_PWD_NATIVE\..\dist\" ) }
        else { PREFIX = $$system( cygpath -u \"$$PREFIX\" ) }
    }

    # Force the Phoenix binary to be relinked if the backend code has changed
    win32: TARGETDEPS += ../backend/libphoenix-backend.a ../externals/quazip/quazip/libquazip.a
    macx: TARGETDEPS += ../backend/libphoenix-backend.a ../externals/quazip/quazip/libquazip.a
    unix: !macx: TARGETDEPS += ../backend/libphoenix-backend.a ../externals/quazip/quazip/libquazip.a

    # Make sure it gets installed
    target.path = "$$PREFIX"
    unix: !macx: target.path = "$$PREFIX/bin"
    INSTALLS += target

##
## Make sure that the portable file gets made in the build folder
##

    PORTABLE_FILENAME = PHOENIX-PORTABLE

    # For the default target (...and anything that depends on it)
    QMAKE_POST_LINK += touch \"$$OUT_PWD_UNIX/$$PORTABLE_FILENAME\"

    # Delete it from the prefix if doing a make install
    portablefile.path = "$$PREFIX"
    portablefile.extra = rm -f \"$$PREFIX/$$PORTABLE_FILENAME\"

    # Make qmake aware that this target exists
    QMAKE_EXTRA_TARGETS += portablefile

##
## Portable distribution: Copy just the files needed for a portable build to the given prefix so it can be archived
## and distributed
##

    portable.depends = first portablefile

    # Make qmake aware that this target exists
    QMAKE_EXTRA_TARGETS += portable

    # On OS X, just copy the whole .app folder to the prefix
    macx {
        portable.commands += mkdir -p \"$$PREFIX/\" &&\
                             cp -p -R -f \"$$OSX_BUNDLE_PATH\" \"$$PREFIX\"
    }

    # Everywhere else, copy the structure verbatim into the prefix
    !macx {
        TARGET_NAME=$$TARGET
        defined( PHX_CROSS_COMPILE, var ): TARGET_NAME = $${TARGET}.exe
        # Phoenix executable and the file that sets it to portable mode
        portable.commands += mkdir -p \"$$PREFIX/\" &&\
                             cp -p -f \"$$OUT_PWD_UNIX/$$TARGET_NAME\" \"$$PREFIX/$$TARGET_NAME\" &&\
                             cp -p -f \"$$OUT_PWD_UNIX/$$PORTABLE_FILENAME\" \"$$PREFIX/$$PORTABLE_FILENAME\" &&\

        # Metadata databases
        portable.commands += mkdir -p \"$$PREFIX/Metadata/\" &&\
                             cp -p -f \"$$OUT_PWD_UNIX/Metadata/openvgdb.sqlite\" \"$$PREFIX/Metadata/openvgdb.sqlite\" &&\
                             cp -p -f \"$$OUT_PWD_UNIX/Metadata/libretro.sqlite\" \"$$PREFIX/Metadata/libretro.sqlite\"
    }

##
## Metadata database targets
##

    # Ideally these files should come from the build folder, however, qmake will not generate rules for them if they don't
    # already exist
    metadb.depends += "$$PWD_NATIVE/metadata/openvgdb.sqlite" \
                      "$$PWD_NATIVE/metadata/libretro.sqlite"

    # For the default target (...and anything that depends on it)
    metadb.commands += mkdir -p \"$$OUT_PWD_UNIX/Metadata/\" &&\
                       cp -p -f \"$$PWD_UNIX/metadata/openvgdb.sqlite\" \"$$OUT_PWD_UNIX/Metadata/openvgdb.sqlite\" &&\
                       cp -p -f \"$$PWD_UNIX/metadata/libretro.sqlite\" \"$$OUT_PWD_UNIX/Metadata/libretro.sqlite\"
    POST_TARGETDEPS += metadb

    # For make install
    metadb.files += "$$PWD_NATIVE/metadata/openvgdb.sqlite" \
                    "$$PWD_NATIVE/metadata/libretro.sqlite"
    metadb.path = "$$PREFIX/Metadata"
    unix: metadb.path = "$$PREFIX/share/phoenix/Metadata"
    INSTALLS += metadb

    # Make qmake aware that this target exists
    QMAKE_EXTRA_TARGETS += metadb

##
## Linux icon
##

    unix: !macx {
        # Ideally these files should come from the build folder, however, qmake will not generate rules for them if they don't
        # already exist
        linuxicon.depends += "$$PWD_NATIVE/phoenix.png"

        # For make install
        linuxicon.files += "$$PWD_NATIVE/phoenix.png"

        linuxicon.path = "$$PREFIX/share/pixmaps"
        INSTALLS += linuxicon

        # Make qmake aware that this target exists
        QMAKE_EXTRA_TARGETS += linuxicon
    }

##
## Linux .desktop entry
##

    unix: !macx {
        # Ideally these files should come from the build folder, however, qmake will not generate rules for them if they don't
        # already exist
        linuxdesktopentry.depends += "$$PWD_NATIVE/phoenix.desktop"

        # For make install
        linuxdesktopentry.files += "$$PWD_NATIVE/phoenix.desktop"

        linuxdesktopentry.path = "$$PREFIX/share/applications"
        INSTALLS += linuxdesktopentry

        # Make qmake aware that this target exists
        QMAKE_EXTRA_TARGETS += linuxdesktopentry
    }

##
## On OS X, ignore all of the above when it comes to make install and just copy the whole .app folder verbatim
##

    macx {
        macxinstall.path = "$$PREFIX/"
        macxinstall.extra = mkdir -p \"$$PREFIX\" &&\
                            cp -p -R \"$$OSX_BUNDLE_PATH\" \"$$PREFIX\" &&\
                            rm -f \"$$OSX_BINARY_PATH_PREFIX/$$PORTABLE_FILENAME\"

        # Note the lack of +
        INSTALLS = macxinstall
    }

##
## Debugging info
##

#    win32 {
#        !build_pass: message( PWD_NATIVE: $$PWD_NATIVE )
#        !build_pass: message( OUT_PWD_NATIVE: $$OUT_PWD_NATIVE )
#    }
#    !build_pass: message( PWD_UNIX: $$PWD_UNIX )
#    !build_pass: message( OUT_PWD_UNIX: $$OUT_PWD_UNIX )
#    !build_pass: message( TARGET: $$TARGET )
#    macx {
#        !build_pass: message( OSX_BUNDLE_PATH: $$OSX_BUNDLE_PATH )
#        !build_pass: message( OSX_BINARY_PATH_PREFIX: $$OSX_BINARY_PATH_PREFIX )
#    }
#    win32 {
#        !build_pass: message( PREFIX: $$PREFIX )
#    }

