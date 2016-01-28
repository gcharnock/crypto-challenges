{-# LANGUAGE OverloadedStrings #-}

module Lib where

import Data.ByteString(ByteString)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Base64 as Base64
import qualified Data.ByteString.Base16 as Base16

import qualified Data.ByteString.Unsafe as BS

import Foreign.C.Types
import System.IO.Unsafe
import Data.Word8
import Data.Vector(Vector)
import qualified Data.Vector.Storable as V
import Foreign.ForeignPtr
import Data.Bits

inputVector :: ByteString
inputVector = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

targetVector :: ByteString
targetVector = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

challenge_1_base64bytestring :: ByteString -> ByteString
challenge_1_base64bytestring = Base64.encode . fst . Base16.decode

xorString1 :: ByteString
xorString1 = "1c0111001f010100061a024b53535009181c"

xorString2 :: ByteString
xorString2 = "686974207468652062756c6c277320657965"

xorTarget :: ByteString
xorTarget = "746865206b696420646f6e277420706c6179"

byteStringToVector :: ByteString -> V.Vector CChar
byteStringToVector bs = unsafePerformIO $ do
  BS.unsafeUseAsCStringLen bs $ \(ptr, len) -> do
    fptr <- newForeignPtr_ ptr
    return $ V.unsafeFromForeignPtr0 fptr len

vectorToByteString :: V.Vector CChar -> ByteString
vectorToByteString v = unsafePerformIO $ do
  let (fptr, len) = V.unsafeToForeignPtr0 v
  withForeignPtr fptr $ \ptr ->
    BS.packCStringLen (ptr, len)


challenge_2_xor :: ByteString -> ByteString -> ByteString
challenge_2_xor s1 s2 = vectorToByteString $ V.zipWith xor (decode s1) (decode s2)
 where decode = byteStringToVector . fst . Base16.decode
       
