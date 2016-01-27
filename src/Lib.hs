{-# LANGUAGE OverloadedStrings #-}

module Lib where

import Data.ByteString(ByteString)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Base64 as Base64
import qualified Data.ByteString.Base16 as Base16


inputVector :: ByteString
inputVector = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

targetVector :: ByteString
targetVector = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

challenge_1_base64bytestring :: ByteString -> ByteString
challenge_1_base64bytestring = Base64.encode . fst . Base16.decode
