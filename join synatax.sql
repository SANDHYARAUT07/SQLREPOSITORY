SELECT COLUMNS
FROM TABLE1
INNER JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN;

SELECT COLUMNS
FROM TABLE1
LEFT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN;

SELECT COLUMNS
FROM TABLE1
RIGHT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN;

SELECT COLUMNS 
FROM TABLE1
LEFT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN
UNION
SELECT COLUMNS
FROM TABLE1
RIGHT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN;

LEFT EXCLUSIVE JOIN
SELECT COLUMNS
FROM TABLE1
LEFT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN
WHERE TABLE2.COLUMN IS NULL;

RIGHT EXCLUSIVE JOIN
SELECT COLUMNS
FROM TABLE1
RIGHT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN
WHERE TABLE1.COLUMN IS NULL

FULL EXCLUSIVE JOIN
SELECT COLUMNS
FROM TABLE1
LEFT JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN
WHERE TABLE2.COLUMN IS NULL
UNION
SELECT COLUMNS
FROM TABLE1
RIGHT JOIN TABLE2
ON TABLE1'COLUMN=TABLE2.COLUMN
WHERE TABLE1.COLUMN IS NULL

SELF JOIN
SELECT COLUMN
FROM TABLE1
JOIN TABLE2
ON TABLE1.COLUMN=TABLE2.COLUMN;


CROSS JOIN
SELECT COLUMN 
FROM TABLE1
CROSS JOIN TABLE2;

