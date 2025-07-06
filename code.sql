-- 1

SELECT 
    od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM order_details od;


-- 2

SELECT *
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);


-- 3

SELECT 
    t.order_id,
    AVG(t.quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS t
GROUP BY t.order_id;


-- 4

WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS avg_quantity
FROM temp
GROUP BY temp.order_id;

-- 5

DROP FUNCTION IF EXISTS divide_two_numbers;

DELIMITER //

CREATE FUNCTION divide_two_numbers(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END;
//

DELIMITER ;

SELECT 
    order_id,
    product_id,
    quantity,
    divide_two_numbers(quantity, 4) AS divided_quantity
FROM order_details;