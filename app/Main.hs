module Main where

newtype Options = Options {folderName :: String}

main :: IO ()
main = putStrLn "Hello, Haskell!"
