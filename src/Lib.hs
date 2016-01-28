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

{-

The maths for base16 to base64 convertions is as follows:

Each input group of 3 inputs symbols (x0, x1, x2) produces 2
output symbols

y0 = x0        + (x1 << 4) % 64
y1 = (x1 >> 2) + (x2 << 2) % 64

Remembering that x0 is the least significant symbol

-}


challenge_1_base64bytestring :: ByteString -> ByteString
challenge_1_base64bytestring = Base64.encode . fst . Base16.decode

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
challenge_2_xor s1 s2 = Base16.encode $ vectorToByteString $ V.zipWith xor (decode s1) (decode s2)
 where decode = byteStringToVector . fst . Base16.decode
