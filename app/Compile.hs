{-# LANGUAGE ConstraintKinds  #-}
{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs            #-}
{-# LANGUAGE TemplateHaskell  #-}
{-# LANGUAGE TypeApplications #-}

module Compile where

import           Data.ByteString.Short    (ShortByteString, toShort)
import           Flat                     (flat)

import qualified Plutus.V1.Ledger.Scripts as P
import qualified PlutusTx                 as P
import qualified PlutusTx.Prelude         as P

equal :: P.Data -> P.Data -> ()
equal d1 d2 = if d1 P.== d2 then () else (P.error ())

convert :: P.CompiledCode a -> ShortByteString
convert  = toShort . flat . P.fromCompiledCode

main :: IO ()
main = print $ convert $ $$(P.compile [|| equal ||])
