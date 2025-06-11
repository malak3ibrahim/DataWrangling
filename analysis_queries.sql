-- SQL Analysis for Flights Dataset

-- Query 1: Average arrival delay per airline
-- Computes the average ARR_DELAY for each airline (excluding cancelled flights)
SELECT AIRLINE, AVG(ARR_DELAY) AS avg_arrival_delay
FROM flights
WHERE CANCELLED = 0
GROUP BY AIRLINE
ORDER BY avg_arrival_delay DESC;

-- Query 2: Top 10 most delayed routes
-- Lists routes (origin to destination) with the highest average arrival delays
SELECT ORIGIN, DEST, COUNT(*) AS num_flights, AVG(ARR_DELAY) AS avg_delay
FROM flights
WHERE CANCELLED = 0
GROUP BY ORIGIN, DEST
ORDER BY avg_delay DESC
LIMIT 10;

-- Query 3: Count of cancellations by reason code
-- Aggregates the number of cancellations by each reason code (A, B, C, D, or None)
SELECT CANCELLATION_CODE, COUNT(*) AS cancellation_count
FROM flights
WHERE CANCELLED = 1
GROUP BY CANCELLATION_CODE
ORDER BY cancellation_count DESC;

-- Query 4: Average delay by day of the week
-- Shows average arrival delay per weekday to identify trends
SELECT DAY_OF_WEEK, ROUND(AVG(ARR_DELAY), 2) AS avg_delay
FROM flights
WHERE CANCELLED = 0
GROUP BY DAY_OF_WEEK
ORDER BY avg_delay DESC;

-- Query 5: Count of diverted vs. non-diverted flights
-- Summarizes how many flights were diverted (DIVERTED = 1) vs not (0)
SELECT DIVERTED, COUNT(*) AS flight_count
FROM flights
GROUP BY DIVERTED;

-- Query 6: Total flights and average delay per airline joined with full names
-- Requires a lookup table 'airlines' containing airline_code and airline_name
SELECT a.airline_name, COUNT(*) AS total_flights, AVG(f.ARR_DELAY) AS avg_arrival_delay
FROM flights f
JOIN airlines a ON f.AIRLINE_CODE = a.airline_code
WHERE f.CANCELLED = 0
GROUP BY a.airline_name
ORDER BY avg_arrival_delay DESC;
