module Paths_tree_base_lambda (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/kino/.cabal/bin"
libdir     = "/home/kino/.cabal/lib/x86_64-linux-ghc-7.8.4/tree-base-lambda-0.1.0.0"
datadir    = "/home/kino/.cabal/share/x86_64-linux-ghc-7.8.4/tree-base-lambda-0.1.0.0"
libexecdir = "/home/kino/.cabal/libexec"
sysconfdir = "/home/kino/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tree_base_lambda_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tree_base_lambda_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "tree_base_lambda_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tree_base_lambda_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tree_base_lambda_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
