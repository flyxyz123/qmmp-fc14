# references:
# https://github.com/cspiegel/qmmp-adplug
# https://github.com/cspiegel/qmmp-openmpt

HEADERS += decoderfc14factory.h \
           decoder_fc14.h \
           fc14helper.h

SOURCES += decoderfc14factory.cpp \
           decoder_fc14.cpp \
           fc14helper.cpp \
           libfc14/Dump.cpp \
           libfc14/FC.cpp \
           libfc14/FC_Data.cpp \
           libfc14/fc14audiodecoder.cpp \
           libfc14/LamePaulaMixer.cpp \
           libfc14/LamePaulaVoice.cpp \
           libfc14/Paula.cpp

INCLUDEPATH += $$PWD/libfc14

CONFIG += warn_on plugin link_pkgconfig

TEMPLATE = lib

QMAKE_CLEAN += lib$${TARGET}.so

unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += qmmp
	
	QMMP_PREFIX = $$system(pkg-config qmmp --variable=prefix)
	PLUGIN_DIR = $$system(pkg-config qmmp --variable=plugindir)/Input
	LOCAL_INCLUDES = $${QMMP_PREFIX}/include
	LOCAL_INCLUDES -= $$QMAKE_DEFAULT_INCDIRS
	INCLUDEPATH += $$LOCAL_INCLUDES
	
	plugin.path = $${PLUGIN_DIR}
	plugin.files = lib$${TARGET}.so
	INSTALLS += plugin
}
