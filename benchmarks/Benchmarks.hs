
module Main where

import Criterion.Types (Config(..))
import Criterion.Main (defaultMainWith, bench, whnf, bgroup, defaultConfig)

import Lib

fibs :: Num a => [a]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

fib :: (Num a) => Int -> a
fib n = fibs !! n

config :: Config
config = defaultConfig { reportFile = Just "benchmark.html"}

main :: IO ()
main = defaultMainWith config [
  bgroup "challenge 1" [ bench "challenge_1_base64bytestring" $ whnf challenge_1_base64bytestring inputVector
               ]
  ]
