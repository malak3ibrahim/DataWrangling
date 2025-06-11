-- Select rows
SELECT * FROM flights LIMIT 5;

-- Get average delay per airline
SELECT AIRLINE, AVG(ARR_DELAY) AS avg_delay
FROM flights
WHERE CANCELLED = 0
GROUP BY AIRLINE
ORDER BY avg_delay DESC;

-- Count cancellations by reason
SELECT CANCELLATION_CODE, COUNT(*) AS total
FROM flights
WHERE CANCELLED = 1
GROUP BY CANCELLATION_CODE;


CREATE TABLE airlines (
    airline_code TEXT PRIMARY KEY,
    airline_name TEXT
);

INSERT INTO airlines VALUES 
('WN', 'Southwest Airlines'),
('AA', 'American Airlines'),
('DL', 'Delta Air Lines');


SELECT f.FL_DATE, f.AIRLINE, a.airline_name, f.ARR_DELAY
FROM flights f
JOIN airlines a ON f.AIRLINE_CODE = a.airline_code
WHERE f.CANCELLED = 0
ORDER BY f.ARR_DELAY DESC
LIMIT 10;


