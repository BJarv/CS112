--Brandon Jarvinen

--2. citeAuthor "Herman" "Melville" -- -> "Melville, Herman"
citeAuthor :: String -> String -> String
citeAuthor a b = b ++ ", " ++ a

--3. initials "Herman" "Melville" -- -> "H.M." 
initials :: String -> String -> String
initials a b = (take 1 a) ++ "." ++ (take 1 b) ++ "."

--4. title ("Herman Melville", "Moby Dick", 1851) -- -> "Moby Dick"
title :: (String, String, Int) -> String
title (_, t, _) = t

--5. citeBook ("Herman Melville", "Moby Dick", 1851) -- -> "Moby Dick (Herman Melville, 1851)" 
citeBook :: (String, String, Int) -> String
citeBook (a, t, y) = t ++ " (" ++ a ++ ", " ++ show y ++ ")"

--6. bibliography_rec [("Bob Smith", "Book Title", 9000), ("Bob Smith", "Book Title 2", 9001)] -- -> "Book Title (Bob Smith, 9000)\nBook Title 2 (Bob Smite, 9001)\n"
bibliography_rec :: [(String, String, Int)] -> String
bibliography_rec [] = ""
bibliography_rec (x:xs) = citeBook x ++ "\n" ++ bibliography_rec xs

--7. bibliography_foldl same as bibliography_rec
bibliography_foldl :: [(String, String, Int)] -> String
bibliography_foldl xs = foldl (\bib x -> bib ++ citeBook x ++ "\n") "" xs

--8. averageYear [("", "", 1), ("", "", 3)] -- -> 2
averageYear :: [(String, String, Int)] -> Int
averageYear x = sum (years x) `div` length x

--8a. years [("", "", 1), ("", "", 3)] -- -> [1, 3] 
years :: [(String, String, Int)] -> [Int]
years ys = [ y | (_, _, y) <- ys ]

--9. references
references :: String -> Int
references n = length (filter (=='[') n)

--10. citeText
citeText :: [(String, String, Int)] -> String -> String
citeText c b = filter' (== "[" ++ _ ++ "]") (words b) c

filter' :: (a -> Bool) -> [String] -> [(String, String, Int)] -> [String]  
filter' _ [] _ = []  
filter' p (x:xs) ys
    | p x       = b : filter' p xs ys -- prepend b
    | otherwise = x : filter' p xs ys -- prepend whatever failed the filter
    where b = citeBook (ys !! ((read (take 1 (drop 1 x)) :: Int) - 1)) 
    -- take the number from inside the citation, read it to an int, subtract one for list vertices, and rather than add the citation bracket, add the citation selected by vertex
    -- doesn't compile
