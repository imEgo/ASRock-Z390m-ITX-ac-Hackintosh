#!/bin/sh

CUR_ROOT=$(cd `dirname $0`; pwd)

usage() {
    echo "\nACPI Assembler|Disassembler script by imEgo\n"
    echo "--------------------\n"
    echo "Usage:"
    echo "    $0 <-a|-assemble> <ACPI directory path>"
    echo "    $0 <-d|-disassemble> <ACPI directory path>"
    echo "\n"
    echo "Example:"
    echo "    $0 -d ./ACPI_Dump"
    echo "\n"

    exit 1
}

run() {
    # run <aml|dsl> <ACPI directory path>

    if [ ! -d $2 ]; then
        echo "$2 is not exist!"
        usage
    fi

    ACPI_ROOT=$(cd $2; pwd)
    DEST_ROOT=""
    # DEST_SUFFIX="_$(date "+%Y%m%d")"
    case $1 in
        aml)
            DEST_ROOT="$ACPI_ROOT/DSL"
        ;;
        dsl)
            DEST_ROOT="$ACPI_ROOT/AML"
        ;;
        *)
            echo "Invalid params: $1"
            return 1
        ;;
    esac

    FILES=`find $ACPI_ROOT -depth 1 -name "*.$1"`
    if [ "$FILES" == "" ]; then
        echo "Nothing to do..."
        return 2
    fi

    if [ ! -d $DEST_ROOT ]; then
        mkdir -p $DEST_ROOT
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    cd $ACPI_ROOT

    COUNT=0
    for FILE in *.$1
    do
        if [ -f $FILE ]; then
            $CUR_ROOT/iasl -p $DEST_ROOT/${FILE%%.*} $FILE
            if [ $? -ne 0 ]; then
                exit 1
            fi
            let COUNT++
        fi
    done

    echo "\n$COUNT files has been processed.\n"

    cd ~-
}

if [ "$2" == "" ]; then
    usage
fi

case $1 in
    -d|-disassemble)
        run aml $2
    ;;
    -a|-assemble)
        run dsl $2
    ;;
    *)
        usage
    ;;
esac
