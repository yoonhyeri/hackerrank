SELECT CATEGORY, PRICE, PRODUCT_NAME
FROM (
    SELECT CATEGORY, PRICE, PRODUCT_NAME,
           ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY PRICE DESC) AS R
    FROM FOOD_PRODUCT
    WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
) INLLINE
WHERE R = 1
ORDER BY PRICE DESC;


/*
CATEGORY	PRICE	PRODUCT_NAME
김치	16950	맛있는백김치
식용유	4880	맛있는콩기름
국	2400	맛있는미역국
과자	1500	맛있는포카칩
*/