#!/bin/bash
DIR="$( dirname "$0" )"
BASEDIR="$( dirname "$DIR" )"
cd "$BASEDIR"
ghci -w tmp/out.hs src/Haudio.hs src/NoteTable.hs -package ghc
