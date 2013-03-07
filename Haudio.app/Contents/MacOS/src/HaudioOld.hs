-- $Id: Haudio.hs,v 1.154 2013-03-04 13:30:34-08 - - $

module Haudio where

import Data.List

type Frequency = Float
type Volume = Float
type InstNum = Integer

defaultNote = Note 440 100 []

data Notes = Note Frequency Volume [Effects]
           | Chord [Notes]

note :: Frequency -> Volume -> [Effects] -> Notes
note f v es | f >= 0 && v <= 100 && v >= 0  && effect es = Note f v es
            | otherwise = error ("Note frequency or volume out of range or duplicate occurence of effect")

effect :: [Effects] -> Bool
effect es = checkDouble es 0 0

checkDouble :: [Effects] -> Integer -> Integer -> Bool
checkDouble [] env tim | env < 2 && tim < 2 = True
                       | otherwise = False
checkDouble (Envelope _ _ _ _:es) env tim = checkDouble es (env+1) tim
checkDouble ((Time _ _):es) env tim = checkDouble es env (tim+1)

type Attack = Float
type Decay = Float
type Sustain = Float
type Release = Float
type Start = Float
type Duration = Float

data Effects = Envelope Attack Decay Sustain Release
             | Time Start Duration

(&) :: Notes -> Effects -> Notes
(&) (Note f v es) e = note f v (e:es)
(&) (Chord ns) e = Chord (map (& e) ns)

-----------------------------------------------------------

data CSoundType = Instrument Notes InstNum
                | PField Notes InstNum

top = "<CsoundSynthesizer>\n<CsOptions>\n-odac -d\n</CsOptions>\n<CsInstruments>\n"
mid = "</CsInstruments>\n<CsScore>\n;Function\nf1 0 1024 10 1\n\n"
end = "</CsScore>\n</CsoundSynthesizer>\n"

printPlayList :: [Notes] -> IO ()
printPlayList ns = do putStr top
                      printCSound (\n i -> Instrument n i) ns 1
                      putStr mid
                      printCSound (\n i -> PField n i) ns 1
                      putStr end

printCSound :: (Notes -> InstNum -> CSoundType) -> [Notes] -> InstNum -> IO ()
printCSound _ [] _ = putStr ""
printCSound cstype ((Chord ns):cs) i = printCSound cstype (ns ++ cs) i
printCSound cstype (n:ns) i = do print (cstype n i)
                                 printCSound cstype ns (i+1)

showEnvelope :: [Effects] -> String
showEnvelope [] = "out aout\n"
showEnvelope ((Envelope a d s r):es) = "aenv adsr " ++ show a ++ ", " ++ show d ++ ", " ++
                                       show s ++ ", " ++ show r ++ "\nout aout*aenv\n"
showEnvelope (e:es) = showEnvelope es

showTime :: [Effects] -> String
showTime [] = " 0 5\n"
showTime ((Time s d):es) = " " ++ show s ++ " " ++ show d ++ "\n"
showTime (e:es) = showTime es

instance Show CSoundType where
  show (Instrument (Note f v es) i) = (";Instument " ++ show i ++ 
                                       "\ninstr " ++ show i ++
                                       "\naout oscil " ++ show (v * 100) ++ ", " ++
                                       show f ++ ", 1\n"  ++ showEnvelope es ++ "endin\n")
  show (PField (Note _ _ es) i) = ("i" ++ show i ++ showTime es)


instance Show Notes where
   show (Note f v es) = ("Note \n   Frequency   " ++ show f ++ "\n   Volume      " ++
                                show v ++ "\n   Effects     " ++ show es)

instance Show Effects where
   show (Envelope a d s r) = "Envelope"
   show (Time s d) = "Time (Start " ++ show s ++ ") (Duration " ++ show d ++ ")"

instance Num Notes where
   (+) = (\n1 n2 -> Chord (n1:n2:[]))

