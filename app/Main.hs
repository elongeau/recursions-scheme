module Main where

import           Explicit
import           Implicit

main :: IO ()
main = do
    putStrLn "explicit recursion:"
    print $ countFiles foo
    putStrLn $ unlines (flatPrint foo)
    putStrLn "implicit recursion:"
    print $ countFilesF fooF
    putStrLn $ (flatPrintF fooF)
