import Haudio hiding (CSoundType)

import NoteTable

env = Envelope 0.2 1 1 0.2

twoSecs = Time 0 2

c = note c4 100 []

a = note a4 100 []

cmaj = majorChord c

playList = (cmaj) & twoSecs & env

playList :: Notes

main :: IO ()
main = playNoFork playList