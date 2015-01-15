--Brandon Jarvinen
--Collab with: Kevin Stewart

import Data.Char

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

--9. references returns number of citations in a block of text
references :: String -> Int
references n = length (filter (=='[') n)

--10. citeText takes block of text and swaps citations for citation markers.
citeText :: [(String, String, Int)] -> String -> String
citeText cite text = unwords (map (textCiter cite) (words text))

--10a. textCiter is a helper function that does the load of the work that is given to it from citeText.
--digitToInt converts the number in the citation into a Int to be used as a vertex with the list of citations
textCiter :: [(String, String, Int)] -> String -> String
textCiter cites word =
	if '[' `elem` word
		then citeBook (cites !! (digitToInt (word !! 1) - 1)) 
		else word



txt :: String
txt = "[1] and [2] both feature characters who will do whatever it takes to get to their goal, and in the end the thing they want the most ends up destroying them.  In case of [2] this is a whale..."
