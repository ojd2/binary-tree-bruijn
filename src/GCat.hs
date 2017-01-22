module GCat where
-- import Visuals

data T = E | C T T deriving (Eq,Show,Read)
newtype M = F [M] deriving (Eq,Show,Read)

class (Show a,Read a,Eq a) => Cat a where
  e :: a

  c :: (a,a) -> a
  c' :: a -> (a,a)

  e_ :: a -> Bool
  e_ a = a == e

  c_ :: a -> Bool
  c_ a = a /= e

instance Cat T where
  e = E

  c (x,y) = C x y

  c' (C x y) = (x,y)

instance Cat M where
  e = F []
  c (x,F xs) = F (x:xs)
  c' (F (x:xs)) = (x,F xs)

type N = Integer
instance Cat Integer where
  e = 0

  c (i,j) | i>=0 && j>=0 = 2^(i+1)*(j+d)-d where
    d = mod (j+1) 2

  c' k | k>0 = (max 0 (x-1),ys) where
    b = mod k 2
    (i,j) = dyadicVal (k+b)
    (x,ys) = (i,j-b)

    dyadicVal k | even k = (1+i,j) where
      (i,j) = dyadicVal (div k 2)
    dyadicVal k = (0,k)

view :: (Cat a, Cat b) => a -> b
view z | e_ z = e
view z | c_ z = c (view x,view y) where (x,y) = c' z

n :: Cat a => a->N
n = view

t :: Cat a => a->T
t = view

m :: Cat a => a->M
m = view

toList :: Cat a => a -> [a]
toList x | e_ x = []
toList x | c_ x  = h:hs where
    (h,t) = c' x
    hs = toList t

fromList :: Cat a => [a] -> a
fromList [] = e
fromList (x:xs) = c (x,fromList xs)

catShow :: Cat a => a -> Str
catShow x | e_ x = "()"
catShow x | c_ x = r where
    xs = toList x
    r = "(" ++ (concatMap catShow xs ++ ) ")"
