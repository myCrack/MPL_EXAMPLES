#!/bin/bash

rm -rf "./output"
mkdir output

echo "Compilation. Please wait..."
echo "C++"
mplc ./MPL/common.mpl -ndebug -begin_func startUp -end_func tearDown -o output/common.ll -I ./sl -I ./MPL -I ./MPL/linux
clang ./bubbleSort/bubbleSortCpp/test.cpp         ./output/common.ll -o output/bubbleSortCpp     -I ./Cpp -Wno-override-module -std=c++20 -D NDEBUG -O3 -Wall
clang ./fibonacciCycle/fibonacciCycleCpp/test.cpp ./output/common.ll -o output/fibonacciCycleCpp -I ./Cpp -Wno-override-module -std=c++20 -D NDEBUG -O3 -Wall
clang ./fibonacciRec/fibonacciRecCpp/test.cpp     ./output/common.ll -o output/fibonacciRecCpp   -I ./Cpp -Wno-override-module -std=c++20 -D NDEBUG -O3 -Wall
clang ./ip/ipCpp/test.cpp                         ./output/common.ll -o output/ipCpp             -I ./Cpp -Wno-override-module -std=c++20 -D NDEBUG -O3 -Wall
clang ./table/tableCpp/test.cpp                   ./output/common.ll -o output/tableCpp          -I ./Cpp -Wno-override-module -std=c++20 -D NDEBUG -O3 -Wall

echo "mplc"
mplc ./bubbleSort/bubbleSortMpl/test.mpl         -I ./sl -I ./MPL -I ./MPL/linux -o output/bubbleSortMpl.ll     -ndebug
mplc ./fibonacciCycle/fibonacciCycleMpl/test.mpl -I ./sl -I ./MPL -I ./MPL/linux -o output/fibonacciCycleMpl.ll -ndebug
mplc ./fibonacciRec/fibonacciRecMpl/test.mpl     -I ./sl -I ./MPL -I ./MPL/linux -o output/fibonacciRecMpl.ll   -ndebug
mplc ./ip/ipMpl/test.mpl                         -I ./sl -I ./MPL -I ./MPL/linux -o output/ipMpl.ll             -ndebug
mplc ./table/tableMpl/test.mpl                   -I ./sl -I ./MPL -I ./MPL/linux -o output/tableMpl.ll          -ndebug

echo "clang/link"
clang ./output/bubbleSortMpl.ll     -o output/bubbleSortMpl     -Wno-override-module -O3
clang ./output/fibonacciCycleMpl.ll -o output/fibonacciCycleMpl -Wno-override-module -O3
clang ./output/fibonacciRecMpl.ll   -o output/fibonacciRecMpl   -Wno-override-module -O3
clang ./output/ipMpl.ll             -o output/ipMpl             -Wno-override-module -O3
clang ./output/tableMpl.ll          -o output/tableMpl          -Wno-override-module -O3

echo
echo "Testing. Please wait..."
echo
echo "MPL"
./output/bubbleSortMpl     > /dev/null
./output/fibonacciCycleMpl > /dev/null
./output/fibonacciRecMpl   > /dev/null
./output/ipMpl             > /dev/null
./output/tableMpl          > /dev/null

echo
echo "C++"
./output/bubbleSortCpp     > /dev/null
./output/fibonacciCycleCpp > /dev/null
./output/fibonacciRecCpp   > /dev/null
./output/ipCpp             > /dev/null
./output/tableCpp          > /dev/null

echo
echo "Python"
bubbleSort=$( { time python ./bubbleSort/bubbleSortPython/test.py -OO > /dev/null; } 2>&1 )
fibonacciCycle=$( { time python ./fibonacciCycle/fibonacciCyclePython/test.py -OO > /dev/null; } 2>&1 )
fibonacciRec=$( { time python ./fibonacciRec/fibonacciRecPython/test.py -OO > /dev/null; } 2>&1 )
ip=$( { time python ./ip/ipPython/test.py -OO > /dev/null; } 2>&1 )
table=$( { time python ./table/tablePython/test.py -OO > /dev/null; } 2>&1 )

echo -e "bubbleSort\t${bubbleSort}"
echo -e "fibonacciCycle\t${fibonacciCycle}"
echo -e "fibonacciRec\t${fibonacciRec}"
echo -e "ip\t\t${ip}"
echo -e "table\t\t${table}"

