module Explicit where

type Name = String
type Size = Int
data FileSystem =
    File Name Size |
    Folder Name [FileSystem]

foo :: FileSystem
foo = Folder
    "foo"
    [ Folder "bar" [File "hello.txt" 1, File "world.json" 2]
    , File "qux" 3
    , Folder "abc" []
    ]
-- {
-- compte le nombre de fichier
--}
countFiles :: FileSystem -> Int
countFiles (File   _ _    ) = 1
countFiles (Folder _ files) = 1 + (sum . map countFiles $ files) -- on appelle récursivement countFiles sur les sous-fichiers

flatPrint :: FileSystem -> [String]
flatPrint (File name _) = ["* " ++ name]
flatPrint (Folder name files) =
    let current  = "+ " ++ name
        subFiles = files >>= flatPrint -- on appelle récursivement flatprint pour chaque sous-fichier
    in  current : subFiles
