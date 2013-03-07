-- $Id: Haudio.hs,v 1.154 2013-03-04 13:30:34-08 - - $

module Haudio where

import Data.List
import Data.Maybe
import System.Process

type Frequency = Float
type Volume = Float
type InstNum = Integer

emptyNote :: Notes
emptyNote = Chord []

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

outFile = "tmp/main.csd"
outLog = "tmp/out.log"
errLog = "tmp/err.log"

play :: Notes -> IO ()
play n = do writeFile outFile contents
            (exitStatus,stdout,stderr) <- readProcessWithExitCode cmd args ""
            writeFile outLog stdout
            writeFile errLog stderr where
               contents = (fromJust (fillContents n))
               cmd = "csound"
               args = ["-d","-odac","tmp/main.csd"]

playNoFork :: Notes -> IO ()
playNoFork n = do writeFile outFile contents where
                  contents = (fromJust (fillContents n))

fillContents :: Notes -> Maybe String
fillContents n = do insts <- printCSound (\n i -> Instrument n i) (Chord [n]) 1
                    pflds <- printCSound (\n i -> PField n i) (Chord [n]) 1
                    Just (top ++ insts ++ mid ++ pflds ++ end)
 
printCSound :: (Notes -> InstNum -> CSoundType) -> Notes -> InstNum -> Maybe String
printCSound _ (Chord []) _ = Just ""
printCSound cstype (Chord ((Chord ns):cs)) i = printCSound cstype (Chord (ns ++ cs)) i
printCSound cstype (Chord (n:ns)) i = do rest <- printCSound cstype (Chord ns) (i+1)
                                         Just ((show (cstype n i)) ++ rest)
printCSound _ _ _ = Nothing

-------------------------------------------------------------------------------------

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
   show (Chord (n:ns)) = show n ++ "\n" ++ show ns

instance Show Effects where
   show (Envelope a d s r) = "Envelope"
   show (Time s d) = "Time (Start " ++ show s ++ ") (Duration " ++ show d ++ ")"

instance Num Notes where
   (+) = (\n1 n2 -> Chord (n1:n2:[]))

