{-# LANGUAGE OverloadedStrings #-}

import Test.Tasty
import Test.Tasty.HUnit

import Data.ByteString(ByteString)
import qualified Data.ByteString as BS

import Lib

main :: IO ()
main = defaultMain $ testGroup "Tests" [unitTests]

check_1_1 :: (ByteString -> ByteString) -> Assertion
check_1_1 f = f input @?= expected
  where input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
        expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

check_1_2 :: (ByteString -> ByteString -> ByteString) -> Assertion
check_1_2 f = f xorString1 xorString2 @?= expected
  where xorString1 = "1c0111001f010100061a024b53535009181c"
        xorString2 = "686974207468652062756c6c277320657965"
        expected = "746865206b696420646f6e277420706c6179"



unitTests = testGroup "Challenge 1"
  [ testCase "1. Using base16 and base64 libraries"
      (check_1_1 challenge_1_base64bytestring),
    testCase "2. Using Data.Bits and Vector"
      (check_1_2 challenge_2_xor)
  ]
