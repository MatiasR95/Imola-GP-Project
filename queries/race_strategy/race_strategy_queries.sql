/* Race Strategy Queries for Franco Colapinto's Imola GP Debut (2025) */

/* Task 10: Rookie Performance Trends
   Description: Analyze historical rookie performances at Imola (drivers in their first Imola race), showing qualifying, race positions, and points. */
WITH DriversResults AS
(SELECT
	d.driverId,
	d.surname + ' ' + d.forename AS Driver,
	ra.year AS Season,
	r.position AS FinishPosition,
	r.points AS Points,
	r.raceId,
	ROW_NUMBER() OVER(PARTITION BY d.surname + ' ' + d.forename ORDER BY ra.year ASC) AS TimesInImola
FROM results r
JOIN races ra ON ra.raceId = r.raceId
JOIN drivers d ON d.driverId = r.driverId
WHERE ra.circuitId = 21 AND r.position IS NOT NULL
)
SELECT
	Driver, 
	Season,
	q.position AS QualyPosition,
	dr.FinishPosition,
	(CAST(q.position AS int) - CAST(dr.finishposition AS int)) AS PositionsGained,
	CASE WHEN dr.Points > 0 THEN 'Points' ELSE 'No Points' END AS PointsYN,
	dr.Points
FROM DriversResults dr
JOIN qualifying q ON q.raceId = dr.raceId AND q.driverId = dr.driverId
WHERE TimesInImola = 1
ORDER BY Season ASC;

/* Task 13: Qualifying Upsets
   Description: Find Imola races where drivers outside the top 5 in qualifying finished in the points, to highlight potential for Colapinto. */
SELECT
	d.forename + ' ' + d.surname AS Driver,
	ra.year AS Season,
	q.position AS QualyPosition,
	r.position AS FinishPosition,
	CASE WHEN r.position <= 3 THEN 'Podium'
		WHEN r.position <= 10 THEN 'Points'
		ELSE 'No Points' END AS PodiumYN,
	(CAST(r.position AS FLOAT) - (CAST(q.position AS float))) AS PositionsGained
FROM qualifying q
JOIN races ra ON ra.raceId = q.raceId
JOIN results r ON r.raceId = q.raceId AND r.driverId = q.driverId
JOIN drivers d ON d.driverId = q.driverId
WHERE ra.circuitId = 21 AND q.position >5
	AND r.position <= 10 AND ra.year >= 2020
ORDER BY ra.year ASC;

/* Task 15: Probability of Scoring Points by Starting Position
   Description: Calculate probability of finishing in points (top 10, 2020 - 2024) by starting position at Imola. */
WITH TotalPositions AS
(SELECT 
	r.raceId,
	r.driverId,
	r.grid,
	CASE WHEN r.grid <= 3 THEN '1-3'
		WHEN r.grid <=6 THEN '4-6'
		WHEN r.grid <=9 THEN '7-9'
		WHEN r.grid <=12 THEN '10-12'
		WHEN r.grid <=15 THEN '13-15'
		WHEN r.grid <=20 THEN '16-20'
		ELSE '20+' END AS StartingGroup,
	CASE WHEN r.position <= 10 THEN 1 ELSE 0 END AS Points
FROM results r
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.year >= 2020 AND ra.circuitId = 21 AND r.grid > 0)
SELECT
	StartingGroup,
	COUNT(*) AS TotalStarts,
	SUM(Points) AS PointsFinishes,
	ROUND(SUM(CAST(Points AS float)) / COUNT(*) * 100, 2) AS PropabilityOfPoints
FROM TotalPositions tp
GROUP BY StartingGroup
ORDER BY PropabilityOfPoints DESC;

/* Task 17: Pit Stop Strategy Evolution (2020 - 2024)
   Description: Analyze the average and fastest pit stop times (in seconds, rounded to 2 decimals) by constructor since 2020. */
SELECT
	c.name AS Constructor,
	ra.year AS Season,
	ROUND(MIN(ps.duration),2) AS FastestPitStop,
	ROUND(AVG(ps.duration),2) AS AVGPitStopDuration
FROM pit_stops ps
JOIN races ra ON ra.raceId = ps.raceId
JOIN drivers d ON d.driverId = ps.driverId
JOIN results r ON r.raceId = ps.raceId AND r.driverId = ps.driverId
JOIN constructors c ON c.constructorId = r.constructorId
WHERE ra.year >= 2020
GROUP BY ra.year, c.name
ORDER BY season ASC;
