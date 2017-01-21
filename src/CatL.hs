module CatL where
import           GCat
import           Math.Combinat.Trees
import           System.Random

-- Compressed de Bruijn terms are defined and represented as data type.
data Bruijn a = Vb | Lb (Bruijn a) | Ab (Bruijn a) (Bruijn a) deriving (Eq,Show,Read)

-- Using Vb | Lb compressed terms.
data Compress a = Vx a a | Ax a (Compress a) (Compress a) deriving (Eq,Show,Read)

-- Set up a closed term. This func definition tries to check each
-- compressed de Bruijn term Vx | Ax within the lambda tree by
-- trying to find a lambda binding via every index from the tree.
-- e.g we can check via:
-- CatL> isCLosedTerm(Vx 2 1) -> True.
-- CatL> isCLosedTerm(Vx 2 2) -> False.
isCLosedTerm :: Cat a => X a -> Bool
isCLosedTerm t = f t e where
  f (Vx k n) d = LT==comp n (add d k)
  f (Ax k x y) d = f x d' && f y d' where d' = add d k

-- Convert ordinary de Bruijn terms into compressed de Bruijn terms.
-- CatL> convertDeBruijn (Lb (Ab (Lb (Ab (Vb 1) (Ab (Vb 0) (Vb 0)))) (Lb (Ab (Vb 1) (Ab (Vb 0) (Vb 0))))))
convertDeBruijn :: (Cat a) => Bruijn a -> Compressed a
convertDeBruijn (Vb x) = Vx e x
convertDeBruijn (Ab x y) = Ax e (convertDeBruijn x) (convertDeBruijn y)
convertDeBruijn (Lb x) = f e x where
  f k (Ab x y) = Ax (s k) (convertDeBruijn x) (convertDeBruijn y)
  f k (Vb x) = Vx (s k) x
  f k (Lb x) = f (s k) x

-- Convert from compressed de Bruijn terms
-- CatL> map (convertDeBruijn.fromCompDeBruijn) [0...15]
fromCompDeBruijn :: (Cat a) => X a -> B a
fromCompDeBruijn (Vx k x)  = iterLam k (Vb x)
fromCompDeBruijn (Ax k x y) = iterLam k (Ab (fromCompDeBruijn x) (fromCompDeBruijn y))

-- Iterate and perform the operation and the func s'(step) returns the decrements.
iterLam :: Cat a => a -> B a -> B a
iterLam k x | e_ k = x
iterLam k x = iterLam (s' k) (Lb x)

-- Define bijunction function that tests wether a term in de Bruijn notation is closed.
isClosedBruijn :: Cat a => B a -> Bool
isClosedBruijn = isCLosedTerm . convertDeBruijn

-- Begin func for ranking de Bruijn terms. Reason for ranking is to encode
-- terms into corresponding leaves and branches. c denotes constructor for
-- constructing a tree of either c=C or c=M whereby the result is a size
-- proportionate compressed de Bruijn tree of terms.
rankCompTerms :: Cat a => X a -> a
rankCompTerms (Vx k n) | e_ k && e_ n = n
rankCompTerms (Vx k n) = c (s' (s' (c (n,k))),e)
rankCompTerms (Ax k a b) = c (k,q) where q = c (rankCompTerms a, rankCompTerms b)

-- Reverse steps of encoding compressed de Bruijn terms with the following func below.
-- CatL> unrankCompTerms 123456
-- CatL> rankCompTerms 123456
unrankCompTerms :: Cat a => a -> X a
unrankCompTerms x | e_ x = Vx x x
unrankCompTerms z = f y where
  (x,y) = c' z
  f y | e_ y = Vx k n where (n,k) = c' (s (s x))
  f y | c_ y = Ax x (unrankCompTerms a) (unrankCompTerms b) where (a,b) = c' y







