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
aout oscil 10000.0, 329.62814, 1
aenv adsr 0.2, 1.0, 1.0, 0.2
out aout*aenv
endin
;Instument 3
instr 3
aout oscil 10000.0, 391.99612, 1
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
</CsScore>
</CsoundSynthesizer>
