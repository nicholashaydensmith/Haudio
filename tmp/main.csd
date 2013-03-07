<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>
;Instument 1
instr 1
aout oscil 10000.0, 261.626, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 2
instr 2
aout oscil 10000.0, 311.12753, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 3
instr 3
aout oscil 10000.0, 391.99612, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 4
instr 4
aout oscil 10000.0, 130.813, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 5
instr 5
aout oscil 10000.0, 155.56375, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 6
instr 6
aout oscil 10000.0, 195.99806, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 7
instr 7
aout oscil 10000.0, 349.228, 1
out aout
endin
;Instument 8
instr 8
aout oscil 10000.0, 329.628, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
</CsInstruments>
<CsScore>
;Function
f1 0 1024 10 1

i1 0.0 2.0
i2 0.0 2.0
i3 0.0 2.0
i4 0 5
i5 0 5
i6 0 5
i7 3.0 1.0
i8 2.0 1.0
</CsScore>
</CsoundSynthesizer>
