select * from track;
select * from genre;
-- 1--
 select g.Name as genre_name,t.genreId ,t.Name as track_Name from track t
inner join genre g on t.GenreId = g.GenreId;
-- 2--
SELECT t.trackId, t.name AS track_name, g.name AS genre_name,g.genreid
FROM track t
LEFT JOIN genre g ON t.GenreId = g.GenreId
where t.TrackId IS NULL;

/*3*/
    SELECT 
    t.TrackId,
    t.Name AS track_name,
    g.Name AS genre_name,
    g.GenreId
    FROM 
    genre g
   LEFT JOIN 
    track t ON t.GenreId = g.GenreId
   WHERE 
    t.TrackId IS NULL;
    /*4*/
    select t.Name as trackname , g.Name as genrename
    from track t
    cross join genre g ;
     /*5*/
    select t.Name as trackName
    from track t where t.Milliseconds > 300000 or t.UnitPrice > 0.99;
    
   /*6*/
SELECT t.Name AS trackName
FROM track t
WHERE t.Milliseconds > 300000

UNION ALL

SELECT t.Name AS trackName
FROM track t
WHERE t.UnitPrice > 0.99;

  /*7*/
  SELECT t.Name AS trackName, g.Name as genreName
FROM track t
JOIN genre g ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock';

/*8*/
SELECT g.Name AS genreName, COUNT(t.TrackId) AS trackCount
FROM genre g
LEFT JOIN track t ON g.GenreId = t.GenreId
GROUP BY g.Name;

  /*9*/
 select g.name as Ganrename ,t.Name as trackName from genre g 
 left join  track t on g.GenreId = t.GenreId
 where t.TrackId is null;
  
  /*10*/
 
 SELECT sub.Genrename AS GenreName, sub.trackName AS TrackName
FROM track t
CROSS JOIN (
    SELECT g.GenreId, g.Name AS Genrename, t.Name AS trackName
    FROM genre g
    LEFT JOIN track t ON g.GenreId = t.GenreId
    WHERE t.TrackId IS NULL
) AS sub;


select * from titanic;
  -- 11 --
  select first_name 
  from titanic where fare > (select avg(fare) from titanic );
  
   -- 12 --
SELECT *
FROM Titanic
WHERE class = (
    SELECT class
    FROM Titanic
    WHERE first_name = 'Julia' AND last_name = 'Patel'
);

   -- 13 --
SELECT *
FROM titanic
WHERE embark_town = (
    SELECT embark_town
    FROM titanic
    GROUP BY embark_town
    ORDER BY COUNT(Passenger_No) DESC
    LIMIT 1
);
   -- 14 --
select *
 from titanic
WHERE survived = 1 
and age  < 
(select avg(age ) from titanic
);
   -- 15 --
   
   SELECT *
FROM Titanic
ORDER BY fare DESC
LIMIT 10;

   -- 16 --
SELECT *
FROM Titanic
WHERE class IN (
    SELECT class
    FROM Titanic
    GROUP BY class
    HAVING AVG(survived) > (
        SELECT AVG(survived)
        FROM Titanic
    )
);
   -- 17 --
SELECT *
FROM Titanic
WHERE deck IN (
    SELECT deck
    FROM Titanic
    GROUP BY deck
    HAVING AVG(fare) = (
        SELECT MIN(avg_fare)
        FROM (
            SELECT deck, AVG(fare) AS avg_fare
            FROM Titanic
            GROUP BY deck
        ) AS deck_avg
    )
);
-- How can we list passengers whose fare was higher than the average fare of their travel  class--
   -- 18 --

SELECT *
FROM titanic t1
WHERE fare > (
    SELECT AVG(fare)
    FROM titanic t2
    WHERE t2.class = t1.class
);
   -- 19--
SELECT *
FROM titanic t1
WHERE age = (
    SELECT AVG(age)
    FROM titanic t2
    WHERE t2.embarked = t1.embarked
);
   -- 20--
SELECT *
FROM titanic
WHERE deck = (
    SELECT deck
    FROM titanic
    GROUP BY deck
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
   
    -- Window function--
  -- 21--

SELECT 
  Passenger_No, 
  class,
  LEAD(Passenger_No) OVER (PARTITION BY class ORDER BY Passenger_No) AS nextpno
FROM titanic;
  -- 22--

SELECT 
  Passenger_No, 
  class,
  fare,
  LAG(fare) OVER (PARTITION BY class ORDER BY Passenger_No) AS presal
FROM titanic;
     -- 23--
SELECT 
  Passenger_No, 
  class,
  fare,
  rank() OVER (PARTITION BY class ORDER BY fare desc) AS rnk
FROM titanic;
-- 24--
SELECT 
  Passenger_No, 
  class,
  age,
  dense_rank() OVER (PARTITION BY class ORDER BY age desc) AS Dnk
FROM titanic;

-- 25--
SELECT 
  Passenger_No, 
  embark_town,
  row_number() OVER (PARTITION BY embark_town ORDER BY Passenger_No) AS rn
FROM titanic;

-- 26--
SELECT 
  Passenger_No, 
  class,
  sex,
  LEAD(Passenger_No) OVER (PARTITION BY class ORDER BY Passenger_No) AS fseq
FROM (
  SELECT * FROM titanic WHERE sex LIKE 'f%'
) AS females;


-- 27--
SELECT 
  Passenger_No, 
  class,
  age,
  sex,
  LAG(age) OVER (PARTITION BY class order by   Passenger_No  ) AS fseq
FROM (
  SELECT * FROM titanic WHERE sex LIKE 'm%'
) AS male;
 -- 28--
SELECT 
  Passenger_No, 
  class,
  fare,
  sex,
  rank() OVER (PARTITION BY class ORDER BY fare desc) AS rnk
FROM (
  SELECT * FROM titanic WHERE sex LIKE 'f%'
) AS females;
 -- 29--
 SELECT 
  Passenger_No, 
  class,
  age,
  dense_rank() OVER (PARTITION BY class ORDER BY age desc) AS Dnk
FROM( select * from titanic
where survived =1 
);
 -- 30--
SELECT 
  Passenger_No, 
  first_name,
  embark_town,
  ROW_NUMBER() OVER (ORDER BY Passenger_No) AS rn
FROM titanic
WHERE embark_town = 'Southampton';



