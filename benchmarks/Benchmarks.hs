
module Main where

import Criterion.Types (Config(..))
import Criterion.Main (defaultMainWith, bench, whnf, bgroup, defaultConfig)


import qualified Data.ByteString.Base64 as Base64
import qualified Data.ByteString.Base16 as Base16

import Inputs
import Lib

config :: Config
config = defaultConfig { reportFile = Just "benchmark.html"}

challenge_1_1_benchmarks =
  [ bench "challenge_1_base64bytestring" $ whnf challenge_1_base64bytestring challenge_1_1_input]

challenge_1_2_benchmarks =
  [ bench "challenge_2_xor"              $ whnf (challenge_2_xor xorString1) xorString2
  , bench "challenge_2_xor_kernel"       $ whnf (challenge_2_xor_kernel ivector1) ivector2]
  where ivector1 =  byteStringToVector . fst . Base16.decode $ xorString1
        ivector2 =  byteStringToVector . fst . Base16.decode $ xorString2

main :: IO ()
main = defaultMainWith config [
  bgroup "challenge 1" challenge_1_1_benchmarks,
  bgroup "challenge 2" challenge_1_2_benchmarks
  ]
