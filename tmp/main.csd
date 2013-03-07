<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>
;Instument 1
instr 1
aout oscil 10000.0, 261.626, 1
out aout
endin
</CsInstruments>
<CsScore>
;Function
f1 0 1024 10 1

i1 0 5
</CsScore>
</CsoundSynthesizer>
