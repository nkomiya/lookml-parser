#/bin/bash

readonly base_dir=$(dirname $0)/..

cd ${base_dir}

# build antlr4 grammar
cd src/grammar
antlr4 -Dlanguage=JavaScript -visitor -o ../generated *.g4
