-- 1. Add a product to the table with the name of “chair”, price of 44.00, and can_be_returned of false.

INSERT INTO products (name, price, can_be_returned) 
    VALUES ('chair', 44.00, '0');

-- 2. Add a product to the table with the name of “stool”, price of 25.99, and can_be_returned of true.

INSERT INTO products (name, price, can_be_returned) 
    VALUES ('stool', 25.99, '1');

-- 3. Add a product to the table with the name of “table”, price of 124.00, and can_be_returned of false.

INSERT INTO products (name, price, can_be_returned) 
    VALUES ('table', 124.00, '0');

-- 4.Display all of the rows and columns in the table.

SELECT *
    FROM products; 

-- 5. Display all of the names of the products.

SELECT name
    FROM products;

-- 6. Display all of the names and prices of the products.

SELECT name, 
    price
FROM products; 


-- 7, Add a new product - make up whatever you would like!

INSERT INTO products (name, price, can_be_returned) 
    VALUES ('TV', 450.00, '1');


-- 8. Display only the products that can_be_returned

SELECT * 
FROM products 
WHERE can_be_returned = '1'; 

-- 9. Display only the products that have a price less than 44.00.

SELECT *
    FROM products
WHERE  
    price < 44;

-- 10. Display only the products that have a price in between 22.50 and 99.99.

SELECT *
    FROM products
WHERE  
    price BETWEEN 22.50 AND 99.99;


-- 11. There’s a sale going on: Everything is $20 off! Update the database accordingly.

UPDATE products SET price = (price - 20);

-- 12. Because of the sale, everything that costs less than $25 has sold out. Remove all products whose price meets this criteria

DELETE 
    FROM products
WHERE price < 25;

-- 13. And now the sale is over. For the remaining products, increase their price by $20. 

UPDATE products SET price = (price + 20); 


-- 14. There is a new company policy: everything is returnable. Update the database accordingly.

UPDATE products SET can_be_returned = '1';



-- >>>>>>>>>>>>>  PLAYSTORE  >>>>>>>>>>>>>>>>>>>>>>

-- Find the app with an ID of 1880

SELECT app_name
    FROM analytics
WHERE id = 1880;

-- Find the ID and app name for all apps that were last updated on August 01, 2018.

SELECT id, app_name
    FROM analytics
WHERE last_updated = '2018-08-01';

-- Count the number of apps in each category, e.g. “Family | 1972”.

SELECT category, COUNT(id)
    from analytics
GROUP BY 
    category;

-- Find the top 5 most-reviewed apps and the number of reviews for each

SELECT id, app_name, reviews
    FROM analytics
ORDER BY 
    reviews DESC
LIMIT 
    5;

-- Find the app that has the most reviews with a rating greater than equal to 4.8.

SELECT id, app_name, reviews, rating
    FROM analytics
WHERE
    rating >= 4.8
ORDER BY
    reviews DESC 
LIMIT
    1;

-- Find the average rating for each category ordered by the highest rated to lowest rated.

SELECT category, AVG(rating) as average_rating 
FROM analytics
GROUP BY   
    category
ORDER BY
    AVG(rating) DESC;

-- Find the name, price, and rating of the most expensive app with a rating that’s less than 3.

SELECT app_name, price, rating
FROM analytics
WHERE 
    rating < 3
ORDER BY
    price DESC
LIMIT 
    1; 
-- Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first. 

SELECT id, app_name, rating
FROM analytics
WHERE
    min_installs <= 50
AND
    rating >= 1
ORDER BY 
    rating DESC;

-- Find the names of all apps that are rated less than 3 with at least 10000 reviews.

SELECT app_name
FROM analytics
WHERE
    rating < 3
AND
    reviews >= 10000;

-- Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.

SELECT id, app_name, price 
FROM analytics
WHERE
    price >= 0.1 AND price <= 1.00
ORDER BY
    reviews DESC
LIMIT 
    10;

-- Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/

SELECT id, app_name, last_updated
FROM analytics
WHERE
    last_updated = (
        SELECT 
            MIN(last_updated)
        FROM 
            analytics
    );


-- Find the most expensive app (the query is very similar to #11).

SELECT id, app_name, price
FROM analytics
WHERE
    price = (
        SELECT MAX(price) FROM analytics
    )
;
-- Count all the reviews in the Google Play Store.

SELECT SUM(reviews) as amt_reviews
FROM analytics;

-- Find all the categories that have more than 300 apps in them.

SELECT category, COUNT(id) as num_apps
FROM analytics
GROUP BY 
    category
HAVING 
    COUNT(id) > 300    
;

-- Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.

SELECT 
    app_name,
    reviews, 
    min_installs, 
    (reviews / min_installs) as proportion
FROM analytics
WHERE
    min_installs >= 10000
ORDER BU proportion DESC
LIMIT 1; 

-- FS1 Find the name and rating of the top rated apps in each category, among apps that have been installed at least 50,000 times. 

SELECT app_name, 
   rating, 
   category
FROM analytics
    WHERE (rating, category) in (
        SELECT MAX(rating), category FROM analytics
            WHERE min_installs >= 50000
            GROUP BY categroy
    )
    ORDER BY category;

-- FS2. Find all the apps that have a name similar to “facebook”.

SELECT id, app_name
FROM analytics
WHERE 
    app_name ILIKE ('%facebook%');

-- -- FS3. Find all the apps that have more than 1 genre.

-- SELECT id, app_name
-- FROM analytics
-- WHERE
--     (IF (SELECT COUNT(genre) FROM analytics > 1) THEN '1' ELSE '0') = '1'
-- ;




