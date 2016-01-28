{-# LANGUAGE OverloadedStrings #-}
module Inputs where

import Data.ByteString (ByteString)

challenge_1_1_input :: ByteString
challenge_1_1_input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

xorString1 :: ByteString
xorString1 = "1c0111001f010100061a024b53535009181c"

xorString2 :: ByteString
xorString2 = "686974207468652062756c6c277320657965"