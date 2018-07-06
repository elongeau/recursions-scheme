{-# LANGUAGE DeriveFunctor #-}

module Implicit where

import           Explicit              (Name, Size)

import           Data.Functor.Foldable
import           Prelude               hiding (Foldable, succ)

data FileSystemF a =
    FileF Name Size |
    FolderF Name [a]
    deriving (Show, Functor)

type FS = Fix FileSystemF

file :: Name -> Size -> FS
file name size = Fix $ FileF name size

fooF :: FS
fooF = Fix $ FolderF
    "foo"
    [ Fix $ FolderF "bar" [file "hello.txt" 1, file "world.json" 2]
    , file "qux" 3
    , Fix $ FolderF "abc" []
    ]

countFilesF :: FS -> Int

countFilesF = cata alg
  where
    alg (FileF   _ _ ) = 1
    alg (FolderF _ xs) = 1 + sum xs -- xs est une [Int], chaque valeur correspond à la taille d'un fichier sous ce répertoire


flatPrintF :: FS -> String
flatPrintF = cata alg
  where
    alg (FileF   name _ ) = "* " ++ name ++ "\n"
    alg (FolderF name xs) = "+ " ++ name ++ "\n" ++ concat xs -- xs est une [String], donc on concatène chaque élément en une seule String

-- a chaque fois xs contient le résultat de l'application de la fonction alg sur le fileSystem
