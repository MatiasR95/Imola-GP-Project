/* General Queries for Imola GP Analysis */

/* Task 1: Most Races Won by Driver
   Description: List the top 5 drivers with the most wins at Imola, showing their full names and win counts. */
SELECT TOP 5
	d.forename + ' ' + d.surname AS Driver,
	d.nationality AS Nationality,
	SUM(CASE WHEN r.position = 1 THEN 1 ELSE 0 END) AS TotalWins,
	MAX(ra.date) AS LastWin
FROM results r
JOIN drivers d ON d.driverId = r.driverId
JOIN races ra ON ra.raceId = r.raceId
JOIN circuits c ON c.circuitId = ra.circuitId
WHERE c.location LIKE '%mola%' AND r.position = 1
GROUP BY d.forename, d.surname, d.driverRef, d.nationality
ORDER BY TotalWins DESC;

/* Task 2: Most Pole Positions by Driver
   Description: Identify the top 5 drivers with the most pole positions at Imola, using concatenated full names. */
SELECT TOP 5
	d.forename + ' ' + d.surname AS Driver,
	d.nationality AS Nationality,
	SUM(CASE WHEN q.position = 1 THEN 1 ELSE 0 END) AS TotalPoles,
	MAX(ra.date) AS LastPolePosition
FROM qualifying q
JOIN drivers d ON d.driverId = q.driverId
JOIN races ra ON ra.raceId = q.raceId
JOIN circuits c ON c.circuitId = ra.circuitId
WHERE c.location LIKE '%mola%' AND q.position = 1
GROUP BY d.forename, d.surname, d.nationality
ORDER BY TotalPoles DESC;

/* Task 3: Most Wins by Constructor
   Description: Show the top 5 constructors with the most Imola wins. */
WITH TotalWins AS
	(SELECT 
		SUM(CASE WHEN r.position = 1 THEN 1 ELSE 0 END) AS TotalWins,
		r.constructorId AS Constructor
	FROM results r
	JOIN races ra ON ra.raceId = r.raceId
	WHERE ra.circuitId = 21
	GROUP BY r.constructorId),
LastWin AS(
	SELECT
		MAX(ra.date) AS LastWin,
		constructorId
	FROM races ra
	JOIN results r ON r.raceId = ra.raceId
	WHERE ra.circuitId = 21 AND r.position = 1
	GROUP BY constructorId)
SELECT
	c.name AS Constructor,
	c.nationality AS Nationality,
	tw.TotalWins,
	lw.LastWin
FROM TotalWins tw
JOIN LastWin lw ON lw.constructorId = tw.Constructor
JOIN constructors c ON c.constructorId = tw.Constructor
WHERE tw.TotalWins > 0
ORDER BY tw.TotalWins DESC;

/* Task 8: Constructor Pole-to-Win Conversion
   Description: For constructors with 5+ Imola poles, calculate the percentage of poles converted to wins, rounded to 2 decimals. */
WITH TotalPoles AS
(SELECT
	SUM(CASE WHEN q.position = 1 THEN 1 ELSE 0 END) AS TotalPoles,
	c.constructorId
FROM qualifying q
JOIN results r ON r.raceId = q.raceId
JOIN constructors c ON c.constructorId = r.constructorId
JOIN races ra ON ra.raceId = q.raceId
WHERE ra.circuitId = 21
GROUP BY c.constructorId
HAVING SUM(CASE WHEN q.position = 1 THEN 1 ELSE 0 END) > 5),
TotalWins AS(
	SELECT
		SUM(CASE WHEN r.position = 1 THEN 1 ELSE 0 END) AS TotalWinsFromPole,
		c.constructorId
	FROM results r
	JOIN qualifying q ON q.raceId = r.raceId
	JOIN constructors c ON c.constructorId = r.constructorId
	JOIN races ra ON ra.raceId = r.raceId
	WHERE ra.circuitId = 21 AND q.position = 1
	GROUP BY c.constructorId
	HAVING SUM(CASE WHEN r.position = 1 THEN 1 ELSE 0 END) > 0)
SELECT
	c.name AS Constructor,
	tp.totalpoles,
	tw.TotalWinsFromPole,
	ROUND((CAST(tw.TotalWinsFromPole AS Float) / tp.TotalPoles ) * 100 ,2) AS PercentageOfPolesToWins
FROM TotalPoles tp
JOIN TotalWins tw ON tw.constructorId = tp.constructorId
JOIN constructors c ON c.constructorId = tp.constructorId
ORDER BY PercentageOfPolesToWins DESC;
