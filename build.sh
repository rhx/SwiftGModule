#!/bin/sh
#
MODULE=GModule-2.0
module=`echo "${MODULE}" | tr '[:upper:]' '[:lower:]'`
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"
GOBJECT_LIBDIR=`pkg-config --libs-only-L gobject-introspection-1.0 2>/dev/null | tr ' ' '\n' | grep gobject-introspection | tail -n1 | cut -c3-`
GOBJECT_DIR=`dirname "${GOBJECT_LIBDIR}"`
for prefix in $PREFIX GOBJECT_DIR /usr/local /usr ; do
	gir_dir=${prefix}/share/gir-1.0
	gir=${gir_dir}/${MODULE}.gir
	if [ -e "${gir}" ] ; then
		export GIR=${gir}
		export GIR_DIR=${gir_dir}
	fi
done
if [ ! -e "${GIR}" ] ; then
	echo "*** ${GIR} does not exist!"
	echo "Make sure libgirepository1.0-dev is installed"
	echo "and can be found in /usr /usr/local or by pkg-config!"
	exit 1
fi
LINKFLAGS=`pkg-config --libs $module gio-unix-2.0 glib-2.0 | tr ' ' '\n' | sed 's/^/-Xlinker /' | tr '\n' ' '`
CCFLAGS=`pkg-config --cflags $module gio-unix-2.0 glib-2.0 | tr ' ' '\n' | sed 's/^/-Xcc /' | tr '\n' ' ' `
gir2swift -p ${GIR_DIR}/GLib-2.0.gir "${GIR}" | sed -f ${MODULE}.sed > Sources/${MODULE}.swift
echo  > Sources/SwiftGModule.swift "import CGLib"
echo >> Sources/SwiftGModule.swift "import GLib"
echo >> Sources/SwiftGModule.swift ""
grep 'public protocol' Sources/${MODULE}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/public typealias _GModule_\1 = \1/' >> Sources/SwiftGModule.swift
echo >> Sources/SwiftGModule.swift ""
echo >> Sources/SwiftGModule.swift ""
grep 'public class' Sources/${MODULE}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/public typealias _GModule_\1 = \1/' >> Sources/SwiftGModule.swift
echo >> Sources/SwiftGModule.swift ""
echo >> Sources/SwiftGModule.swift "public extension GModule {"
grep 'public protocol' Sources/${MODULE}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/    public typealias \1 = _GModule_\1/' >> Sources/SwiftGModule.swift
echo >> Sources/SwiftGModule.swift ""
grep 'public class' Sources/${MODULE}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/    public typealias \1 = _GModule_\1/' >> Sources/SwiftGModule.swift
grep 'public typealias' Sources/${MODULE}.swift | sed 's/^/    /' >> Sources/SwiftGModule.swift
echo >> Sources/SwiftGModule.swift "}"
exec swift build $CCFLAGS $LINKFLAGS "$@"
