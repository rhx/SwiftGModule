#!/bin/bash

GIR_NAME="GModule-2.0"

function generate_arg-path_arg-g2s-exec_arg-gir-pre_arg-gir-path {
    local PACKAGE_PATH=$1
    local G2S_EXEC=$2
    local GIR_PRE=$3
    local GIR_PATH=$4

    local CALLER=$PWD

    cd $PACKAGE_PATH

    local NAME=$(package_name)
    local GIR_PRE_ARGS=`for FILE in ${GIR_PRE}; do echo -n "-p ${GIR_PATH}/${FILE}.gir "; done`
    
    bash -c "${G2S_EXEC} ${GIR_PRE_ARGS} ${GIR_PATH}/${GIR_NAME}.gir > Sources/${NAME}/${GIR_NAME}.swift"

    echo  > Sources/${NAME}/Swift${NAME}.swift "import CGLib"
    echo >> Sources/${NAME}/Swift${NAME}.swift "import GLib"
    echo >> Sources/${NAME}/Swift${NAME}.swift ""
    grep 'public protocol' Sources/${NAME}/${GIR_NAME}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/public typealias _GModule_\1 = \1/' >> Sources/${NAME}/Swift${NAME}.swift
    echo >> Sources/${NAME}/Swift${NAME}.swift ""
    echo >> Sources/${NAME}/Swift${NAME}.swift ""
    grep '^open class' Sources/${NAME}/${GIR_NAME}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/public typealias _GModule_\1 = \1/' >> Sources/${NAME}/Swift${NAME}.swift
    echo >> Sources/${NAME}/Swift${NAME}.swift ""
    echo >> Sources/${NAME}/Swift${NAME}.swift "public extension ${NAME} {"
    grep 'public protocol' Sources/${NAME}/${GIR_NAME}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/    typealias \1 = _GModule_\1/' >> Sources/${NAME}/Swift${NAME}.swift
    echo >> Sources/${NAME}/Swift${NAME}.swift ""
    grep '^open class' Sources/${NAME}/${GIR_NAME}.swift | cut -d' ' -f3 | cut -d: -f1 | sort -u | sed -e 's/^\(.*\)/    typealias \1 = _GModule_\1/' >> Sources/${NAME}/Swift${NAME}.swift
    grep '^public typealias' Sources/${NAME}/${GIR_NAME}.swift | sed 's/^public/   /' >> Sources/${NAME}/Swift${NAME}.swift
    echo >> Sources/${NAME}/Swift${NAME}.swift "}"

    cd $CALLER
}

case $1 in
gir-name) echo $GIR_NAME;;
generate) echo $(generate_arg-path_arg-g2s-exec_arg-gir-pre_arg-gir-path "$2" "$3" "$4" "$5");;
esac
