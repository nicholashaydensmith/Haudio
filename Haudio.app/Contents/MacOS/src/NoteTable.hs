-- $Id: NoteTable.hs,v 1.25 2013-03-04 18:20:24-08 - - $


module NoteTable where

import Haudio

type KeyNum = Float
type Step = Float

--Takes a piano key number and converts it to its respective frequency
getFreq :: KeyNum -> Frequency
getFreq i = 2**((i-49) / 12) * 440

--Takes a frequency and returns a piano key value
getKey :: Frequency -> KeyNum
getKey i = 12 * (logBase 2 (i / 440)) + 49

--Calculates the minor third above the inputted root note 
minorThird :: Frequency->Frequency
minorThird i = getFreq ((getKey i) + 3)

--Calculates the major third above the inputted root note
majorThird :: Frequency->Frequency
majorThird i = getFreq ((getKey i) + 4)

--Calculates the frequency of n half steps above the inputted root note
getStep :: Step->Frequency->Frequency
getStep s i = getFreq ((getKey i) + s)

step :: Notes->Step->Notes
step (Note f v es) s = Note (getStep s f) v es

--Creates a chord with a root note, minor third and fifth
minorChord :: Notes->Notes
minorChord (Note f v e) = Chord (root:third:fifth:[]) where
                          root = Note f v e
                          thirdFreq = minorThird f
                          third = Note thirdFreq v e
                          fifthFreq = majorThird thirdFreq
                          fifth = Note fifthFreq v e

majorChord :: Notes->Notes
majorChord (Note f v e) = Chord (root:third:fifth:[]) where
                          root = Note f v e
                          thirdFreq = majorThird f
                          third = Note thirdFreq v e
                          fifthFreq = minorThird thirdFreq
                          fifth = Note fifthFreq v e

c8 :: Float
c8 = 4186.01

b7 :: Float
b7 = 3951.07

aS7 :: Float
aS7 = 3729.31

a7 :: Float
a7 = 3520.00

gS7 :: Float
gS7 = 3322.44

g7 :: Float
g7 = 3135.96

fS7 :: Float
fS7 = 2959.96

f7 :: Float
f7 = 2793.83

e7 :: Float
e7 = 2637.02

dS7 :: Float
dS7 = 2489.02

d7 :: Float
d7 = 2349.32

cS7 :: Float
cS7 = 2217.46

c7 :: Float
c7 = 2093.00

b6 :: Float
b6 = 1975.53

aS6 :: Float
aS6 = 1864.66

a6 :: Float
a6 = 1760.00

gS6 :: Float
gS6 = 1661.22

g6 :: Float
g6 = 1567.98

fS6 :: Float
fS6 = 1479.98

f6 :: Float
f6 = 1396.91

e6 :: Float
e6 = 1318.51

dS6 :: Float
dS6 = 1244.51

d6 :: Float
d6 = 1174.66

cS6 :: Float
cS6 = 1108.73

c6 :: Float
c6 = 1046.50

b5 :: Float
b5 = 987.767

aS5 :: Float
aS5 = 932.328

a5 :: Float
a5 = 880.000

gS5 :: Float
gS5 = 830.609

g5 :: Float
g5 = 783.991

fS5 :: Float
fS5 = 739.989

f5 :: Float
f5 = 698.456

e5 :: Float
e5 = 659.255

dS5 :: Float
dS5 = 622.254

d5 :: Float
d5 = 587.330

cS5 :: Float
cS5 = 554.365

c5 :: Float
c5 = 523.251

b4 :: Float
b4 = 493.883

aS4 :: Float
aS4 = 466.164

a4 :: Float
a4 = 440.000

gS4 :: Float
gS4 = 415.305

g4 :: Float
g4 = 391.995

fS4 :: Float
fS4 = 369.994

f4 :: Float
f4 = 349.228

e4 :: Float
e4 = 329.628

dS4 :: Float
dS4 = 311.127

d4 :: Float
d4 = 293.665

cS4 :: Float
cS4 = 277.183

c4 :: Float
c4 = 261.626

b3 :: Float
b3 = 246.942

aS3 :: Float
aS3 = 233.082

a3 :: Float
a3 = 220.000

gS3 :: Float
gS3 = 207.652

g3 :: Float
g3 = 195.998

fS3 :: Float
fS3 = 184.997

f3 :: Float
f3 = 174.614

e3 :: Float
e3 = 164.814

dS3 :: Float
dS3 = 155.563

d3 :: Float
d3 = 146.832

cS3 :: Float
cS3 = 138.591

c3 :: Float
c3 = 130.813

b2 :: Float
b2 = 123.471

aS2 :: Float
aS2 = 116.541

a2 :: Float
a2 = 110.000

gS2 :: Float
gS2 = 103.826

g2 :: Float
g2 = 97.9989

fS2 :: Float
fS2 = 92.4986

f2 :: Float
f2 = 87.3071

e2 :: Float
e2 = 82.4069

dS2 :: Float
dS2 = 77.7817

d2 :: Float
d2 = 73.4162

cS2 :: Float
cS2 = 69.2957

c2 :: Float
c2 = 65.4064

b1 :: Float
b1 = 61.7354

aS1 :: Float
aS1 = 58.2705

a1 :: Float
a1 = 55.0000

gS1 :: Float
gS1 = 51.9139

g1 :: Float
g1 = 48.9994

fS1 :: Float
fS1 = 46.2493

f1 :: Float
f1 = 43.6545

e1 :: Float
e1 = 41.2034

dS1 :: Float
dS1 = 38.8909

d1 :: Float
d1 = 36.7081

cS1 :: Float
cS1 = 34.6478

c1 :: Float
c1 = 32.7032

b0 :: Float
b0 = 30.8677

aS0 :: Float
aS0 = 29.1352

a0 :: Float
a0 = 27.5000

