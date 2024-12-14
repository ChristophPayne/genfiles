--numbers.csv
--Sum all columns and produce a total column

SELECT DISTINCT
	(SELECT SUM(Year_1) FROM numbers) AS C1,
	(SELECT SUM(Year_2) FROM numbers) AS C2,
	(SELECT SUM(Year_3) FROM numbers) AS C3,
	(SELECT SUM(Year_4) FROM numbers) AS C4,
	(SELECT SUM(Year_5) FROM numbers) AS C5,
	(SELECT SUM(Year_6) FROM numbers) AS C6,
	SUM(Year_1 + Year_2 + Year_3 + Year_4 + Year_5 + Year_6) AS Total
FROM numbers
