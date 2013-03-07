# $Id: Makefile,v 1.39 2013-03-06 12:55:33-08 - - $

MKFILE = Makefile
HSRC   = src/Haudio.hs src/NoteTable.hs
HOUT   = tmp/out.hs
HSRCD  = $(HOUT) $(HSRC)
HOBJ   = $(HSRC:.hs=.o) $(HOUT:.hs=.o)
HHI    = $(HSRC:.hs=.hi) $(HOUT:.hs=.o)
HBIN   = tmp/$(HOBJ) tmp/$(HHI)
JUNK   = tmp/$(HOBJ) tmp/$(HHI) $(HEXE)
HEXE   = tmp/out
ISCRPT = src/interactive.command

GHC    = ghc -w
GHCI   = ghci -w
PKGS   = -package ghc

all: cid ghc runHaskell

interactive: cid ghci

ghc:
	$(GHC) $(HSRCD) 

ghci:
	open $(ISCRPT)

runHaskell:
	$(HEXE)

clean:
	rm $(JUNK)

cid:
	cid + $(HSRC) $(MKFILE)

