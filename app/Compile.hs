{-# LANGUAGE ConstraintKinds  #-}
{-# LANGUAGE DataKinds        #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs            #-}
{-# LANGUAGE TemplateHaskell  #-}
{-# LANGUAGE TypeApplications #-}

module Compile where

import           Codec.Serialise
import qualified Data.ByteString.Lazy     as BSL
import           Data.ByteString.Short    (ShortByteString, toShort)
import           Flat                     (flat)

import qualified Plutus.V1.Ledger.Scripts as P
import qualified PlutusTx                 as P
import qualified PlutusTx.Prelude         as P

import           BasicValidators

-- Cabal dependencies need to be resolved to be able to use this
--import           Cardano.Api              (writeFileTextEnvelope)

equal :: P.Data -> P.Data -> P.Data -> ()
equal datum redeemer _ = if datum P.== redeemer then () else (P.error ())

convert :: P.CompiledCode a -> BSL.ByteString
convert  = serialise . flat . P.fromCompiledCode

main :: IO ()
main = print $ convert $ $$(P.compile [|| equal ||])
