--Brandon Jarvinen
--Collab with: Logan Collingwood


--1
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl func start [] = start;
myFoldl func start (head:tail) = myFoldl func (func start head) tail
--myFoldl (+) 0 [2, 1, 2]


--2
myReverse :: [a] -> [a]
myReverse x = foldl (flip (:) ) [] x


--3
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr func start arr = foldl (\g b x -> g (func b x)) id arr start
--myFoldr (-) 0 [3, 2, 6]


--4
myFoldl2 :: (a -> b -> a) -> a -> [b] -> a
myFoldl2 func start arr = foldr (\b g x -> g (func x b)) id arr start

--5
isUpper :: Char -> Bool
isUpper = (`elem` ['A'..'Z'])

--6
onlyCapitals1 :: String -> String
onlyCapitals1 [] = ""
onlyCapitals1 (head:tail) = if (isUpper head) then head : onlyCapitals1 tail else onlyCapitals1 tail

--7
onlyCapitals2 :: String -> String
onlyCapitals2 xs = [x | x <- xs, isUpper x]

--8
--onlyCapitals3 :: String -> String

--9 
divRemainder :: Int -> Int -> (Int, Int)
divRemainder a b = (a `div` b, a `mod` b)

--10
digitSum :: Int -> Int
digitSum x
	| x == 0    = 0
	| otherwise = (x `mod` 10) + (digitSum (x `div` 10))







