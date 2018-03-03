TEMPLATE = app

QT += quick mvvmquick mvvmdatasyncquick widgets

TARGET = DataSyncSampleQuick

SOURCES += main.cpp

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/mvvmdatasyncquick/$$TARGET
INSTALLS += target

#not found by linker?
linux:!android {
	LIBS += -L$$OUT_PWD/../../../lib #required to make this the first place to search
	LIBS += -L$$[QT_INSTALL_LIBS] -licudata
	LIBS += -L$$[QT_INSTALL_LIBS] -licui18n
	LIBS += -L$$[QT_INSTALL_LIBS] -licuuc
}

#add lib dir to rpath
mac: QMAKE_LFLAGS += '-Wl,-rpath,\'$$OUT_PWD/../../../lib\''

#link to core lib
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/release/ -lDataSyncSampleCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/debug/ -lDataSyncSampleCore
else:unix: LIBS += -L$$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/ -lDataSyncSampleCore

INCLUDEPATH += $$PWD/../../mvvmdatasynccore/DataSyncSampleCore
DEPENDPATH += $$PWD/../../mvvmdatasynccore/DataSyncSampleCore

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/release/libDataSyncSampleCore.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/debug/libDataSyncSampleCore.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/release/DataSyncSampleCore.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/debug/DataSyncSampleCore.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../../mvvmdatasynccore/DataSyncSampleCore/libDataSyncSampleCore.a

# thanks to qmlc files, only the import path must be fixed
samples_in_build {
	QML_IMPORT_PATH = $$OUT_PWD/../../../qml
	DEFINES += QML_PATH=\\\"$$QML_IMPORT_PATH\\\"
}
