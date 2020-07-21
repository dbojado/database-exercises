USE albums_db;

#The name of all albums by Pink Floyd
SELECT name as 'Albums by Pink Floyd'
FROM albums where artist = 'Pink Floyd';

#The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date as "Release Date Sgt. Pepper's Lonely Hearts Club Band"
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';


#The genre for the album Nevermind
SELECT genre as "Genre for Nevermind"
FROM albums 
where name = "Nevermind";


#Which albums were released in the 1990s
SELECT artist, name as "Albums Released in the 1900s"
FROM albums
where release_date between 1990 and 1999;

#Which albums had less than 20 million certified sales
SELECT name AS "Albums with Less Than 20 million certified sales"
FROM albums
WHERE sales < 20;

#All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT*
FROM albums 
WHERE genre LIKE "%rock%";

