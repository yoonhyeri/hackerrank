WITH DATE_DIFF AS (
    SELECT *, TIMESTAMPDIFF(DAY, START_DATE, END_DATE) + 1 AS DIFF
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
), DATE_DIFF_DURATION_TYPE AS (
    SELECT *, CASE
            WHEN DIFF < 7 THEN 0
            WHEN DIFF >= 7 AND DIFF < 30  THEN '7일 이상'
            WHEN DIFF >= 30 AND DIFF < 90  THEN  '30일 이상'
            WHEN DIFF >= 90 THEN  '90일 이상'
            END AS DURATION_TYPE
    FROM DATE_DIFF JOIN CAR_RENTAL_COMPANY_CAR USING(CAR_ID)
)
, DATE_DIFF_DURATION_TYPE_DISCOUNT_RATE AS (
            SELECT HISTORY_ID, A.CAR_TYPE, DAILY_FEE, DIFF, IF(A.DURATION_TYPE = 0, 0, DISCOUNT_RATE) AS DISCOUNT_RATE
            FROM DATE_DIFF_DURATION_TYPE A JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN B 
                ON(A.CAR_TYPE = B.CAR_TYPE) 
            WHERE (A.DURATION_TYPE = 0) OR (A.DURATION_TYPE = B.DURATION_TYPE)
)

# SELECT *
SELECT HISTORY_ID, FLOOR(DAILY_FEE * DIFF * (1 - DISCOUNT_RATE/100)) AS FEE
FROM DATE_DIFF_DURATION_TYPE_DISCOUNT_RATE
WHERE CAR_TYPE = '트럭'
GROUP BY HISTORY_ID
ORDER BY FEE DESC, HISTORY_ID DESC

