import Haudio hiding (CSoundType,Notes)

import NoteTable

env = Envelope 0.2 1 1 0.2

c = note c4 100 [Time 0 2]

d = note d4 100 [Time 1 1]

e = note e4 100 [Time 2 1]

f = note f4 100 [Time 3 1]

chrd = minorChord c

chrd1 = minorChord (Note c3 100 [])

playList = (chrd + chrd1)&env + f + e&env

main :: IO ()
main = play playList
