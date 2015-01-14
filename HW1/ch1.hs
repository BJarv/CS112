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

--7 bibliography_foldl
bibliography_foldl :: [(String, String, Int)] -> String
bibliography_foldl xs = foldl (\bib x -> bib ++ citeBook x ++ "\n") "" xs



