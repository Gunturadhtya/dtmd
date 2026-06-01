module Main where

import Data.Time (defaultTimeLocale, formatTime, getCurrentTime, getCurrentTimeZone, utcToLocalTime)
import Options.Applicative
import System.Directory (createDirectoryIfMissing)

newtype Options = Options {folderName :: String}

optionsParser :: Parser Options
optionsParser = Options <$> strArgument (metavar "FOLDER_NAME" <> help "The base name for the new directory")

opts :: ParserInfo Options
opts = info (optionsParser <**> helper) (fullDesc <> progDesc "Create a directory prefixed with today's date (YYYYMMDD-FOLDER_NAME)" <> header "dtmd - Date Time Make Directory")

main :: IO ()
main = do
  options <- execParser opts
  now <- getCurrentTime
  tz <- getCurrentTimeZone

  let localTime = utcToLocalTime tz now
      dateStr = formatTime defaultTimeLocale "%Y%m%d" localTime
      fullFolderName = dateStr ++ "-" ++ folderName options

  createDirectoryIfMissing False fullFolderName
  putStrLn $ "Created Directory: " ++ fullFolderName
