
module Main where

import Criterion.Types (Config(..))
import Criterion.Main (defaultMainWith, bench, whnf, bgroup, defaultConfig)

fib :: Int -> Int
fib m = go m
  where
    go 0 = 0
    go 1 = 1
    go n = go (n-1) + go (n-2)

config :: Config
config = defaultConfig { reportFile = Just "benchmark.html"}

main :: IO ()
main = defaultMainWith config [
  bgroup "fib" [ bench "1"  $ whnf fib 1
               , bench "5"  $ whnf fib 5
               , bench "9"  $ whnf fib 9
               , bench "11" $ whnf fib 11
               ]
  ]
