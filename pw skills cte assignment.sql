-- 1.Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NFa.

To identify a table in the Sakila database that violates the First Normal Form (1NF), we must understand the requirements of 1NF. A table violates 1NF if:

It has repeating groups or arrays.
It has multi-valued attributes.
It does not have a primary key.
Let's examine a potential table that violates 1NF and discuss how to normalize it.

Example: film Table
In the Sakila database, the film table may violate 1NF due to its special_features and actors attributes:

special_features: This column often stores multiple features as a comma-separated string (e.g., "Trailers,Commentaries").
actors: This could represent a list of actors involved in the film, which is not in 1NF if stored as a list.
Normalizing to Achieve 1NF
To normalize the film table and ensure it meets 1NF, we must remove these repeating or multi-valued attributes and create new tables that store these values as individual rows.

Remove special_features column and create a film_special_features table:

film Table:

Remove the special_features column.
Retain all other columns (e.g., film_id, title, description, etc.).
film_special_features Table:

Create a new table with two columns: film_id (foreign key) and special_feature.
Each row will store a single special feature for each film.
Example:

film_id	special_feature
1	Trailers
1	Commentaries
Remove actors and create a film_actor table (if not already in place):

film Table:

Remove any list of actors stored within a single column.
film_actor Table:

Use an existing or new film_actor table that relates each actor to films properly, typically with film_id and actor_id columns.
Example:

film_id	actor_id
1	5
1	7
Summary
To achieve 1NF, multi-valued attributes need to be stored in separate tables with proper foreign key references. This restructuring eliminates repeating groups and ensures each field holds only atomic values, complying with the First Normal Form.



-- 2.Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF,
explain the steps to normalize ita

To determine whether a table in the Sakila database is in Second Normal Form (2NF), we need to understand the requirements of 2NF and identify a table that might violate it.

Understanding 2NF
A table is in 2NF if:

It is already in 1NF (i.e., it has no repeating groups, and each field contains atomic values).
Every non-key attribute is fully functionally dependent on the entire primary key, not just a part of it. This primarily applies to tables with composite primary keys.
A table violates 2NF if it has partial dependencies, where a non-key attribute depends on only part of a composite key rather than the whole key.

Example: rental Table
Let's consider the rental table in the Sakila database, which has the following structure:

Columns:
rental_id (Primary Key)
rental_date
inventory_id (Foreign Key)
customer_id (Foreign Key)
return_date
staff_id (Foreign Key)
last_update
Checking 2NF
Identify the primary key:

In this case, the primary key is rental_id, which is a single attribute. Since there's no composite key, this table does not inherently violate 2NF based on partial dependencies.
Examine dependencies:

If the table had a composite key, say rental_date and inventory_id, we would check if any non-key attributes depend on only part of this composite key.
Potential 2NF violation:

In this example, if rental had columns like customer_name or film_title directly associated with rental_date or inventory_id, these attributes would violate 2NF as they don't depend on the full composite key but only parts of it.
Normalizing to Achieve 2NF
If the rental table had partial dependencies, the steps to normalize it would involve:

Remove Partial Dependencies:

Identify the attributes that depend on only part of the key and move them to a new table.
Create New Tables:

Split the original table to separate out partial dependencies, ensuring that each table now has attributes that depend on the full primary key.
Example Normalization:
Suppose the original table had the following structure:

rental_id	rental_date	inventory_id	customer_name	film_title
Here, customer_name and film_title do not fully depend on rental_id but are more related to customer_id and inventory_id, respectively.

Create a customer table:

Move customer_name to this table, linked by customer_id.
customer_id	customer_name
1	John Doe
Create a film_inventory table:

Move film_title to this table, linked by inventory_id.
inventory_id	film_title
1	Jurassic Park
Modify the rental table:

Keep only attributes that are fully dependent on the primary key rental_id.
rental_id	rental_date	inventory_id	customer_id
Summary
To achieve 2NF, we ensure all non-key attributes are fully functionally dependent on the entire primary key. For tables with partial dependencies, normalization involves splitting the table into smaller ones that each satisfy 2NF criteria.



-- 3.Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the
-- steps to normalize the table to 3NFa


o determine if a table violates Third Normal Form (3NF), we need to understand the requirements of 3NF:

The table must be in 2NF.
It must have no transitive dependencies, which means no non-key attribute depends on another non-key attribute.
A transitive dependency occurs when a non-key attribute depends on another non-key attribute rather than directly on the primary key.

Example: payment Table
Let’s examine the payment table in the Sakila database, which might violate 3NF due to transitive dependencies.

payment Table Structure:

Columns:
payment_id (Primary Key)
customer_id (Foreign Key)
staff_id (Foreign Key)
rental_id (Foreign Key)
amount
payment_date
customer_name (Hypothetical column for demonstration)
staff_name (Hypothetical column for demonstration)
Checking for 3NF Violations
Primary Key:

The primary key is payment_id.
Identify Non-Key Attributes:

customer_id, staff_id, rental_id, amount, payment_date, customer_name, and staff_name.
Identify Transitive Dependencies:

Suppose the table stores customer_name and staff_name, which depend on customer_id and staff_id, respectively, rather than directly on payment_id. This creates transitive dependencies:
customer_id → customer_name
staff_id → staff_name
These attributes (customer_name and staff_name) do not directly depend on the primary key (payment_id), which violates 3NF.

Steps to Normalize the payment Table to 3NF
To eliminate transitive dependencies, we need to separate the data into new tables where each non-key attribute is fully dependent on the primary key.

Remove Transitive Dependencies:

Move the attributes (customer_name and staff_name) that depend on non-key attributes to separate tables.
Create a customer Table:

This table will contain information specific to customers.
customer_id	customer_name
1	John Doe
Create a staff Table:

This table will contain information specific to staff.
staff_id	staff_name
1	Jane Smith
Modify the payment Table:

Remove customer_name and staff_name and keep only attributes directly dependent on payment_id.
Updated payment Table:

payment_id	customer_id	staff_id	rental_id	amount	payment_date
1	             1	        1	         101        9.99	   2024-01-01
Summary
To achieve 3NF, all transitive dependencies must be removed by splitting the table into smaller tables where each non-key attribute depends only on the primary key. In this example, normalizing the payment table involves separating customer_name and staff_name into their respective customer and staff tables, eliminating transitive dependencies and ensuring the table conforms to 3NF.


-- 4. Take a specific table in Sakila and guide through the process of normalizing it from the initial
 -- unnormalized form up to at least 2NFa
 
 Let's take the address table from the Sakila database as an example and guide you through the process of normalizing it from an unnormalized form (0NF) to at least Second Normal Form (2NF).

Step 1: Understand the Initial Unnormalized Form (0NF)
In an unnormalized form, a table might have repeating groups, multi-valued attributes, and no defined primary key. For the address table, let's imagine an unnormalized version with potential issues:

Unnormalized address Table Example:

address_id	address	address2	district	postal_code	phone	city_name	city_country	staff_names
1	47 MySakila Drive	Suite 100	Alberta	T2B 3P7	4035551234	Calgary	Canada	Mike Hillyer, Bob Ross
2	28 MySQL Blvd		QLD	4000	6175556789	Brisbane	Australia	Anna Smith
Problems in 0NF:
Repeating Groups: staff_names column contains multiple values (staff names) in a single cell.
Multi-Valued Attributes: City and country information are combined in city_country.
No Primary Key: The primary key (address_id) is assumed but not properly defined.
Step 2: Normalize to First Normal Form (1NF)
To achieve 1NF, we need to eliminate repeating groups and ensure all columns have atomic values.

Transformations:

Separate Multi-Valued Attributes:

Split the staff_names into separate entries in a new table.
Remove Composite Values:

Separate city_name and city_country into individual columns: city and country.
1NF address Table:

address_id	address	address2	district	postal_code	phone	city_name	country_name
1	47 MySakila Drive	Suite 100	Alberta	T2B 3P7	4035551234	Calgary	Canada
2	28 MySQL Blvd		QLD	4000	6175556789	Brisbane	Australia
New staff_address Table:

address_id	staff_name
1	Mike Hillyer
1	Bob Ross
2	Anna Smith
Step 3: Normalize to Second Normal Form (2NF)
To achieve 2NF, the table must first be in 1NF, and every non-key attribute should be fully functionally dependent on the entire primary key.

Identify the Primary Key:

In the address table, the primary key is address_id.
Check for Partial Dependencies:

If we look at city_name and country_name, they are functionally dependent on each other. This suggests that the city information is better suited to its own table.
Remove Partial Dependencies:

Create a separate city table for city_name and country_name.
2NF address Table:

address_id	address	address2	district	postal_code	phone	city_id
1	47 MySakila Drive	Suite 100	Alberta	T2B 3P7	4035551234	1
2	28 MySQL Blvd		QLD	4000	6175556789	2
New city Table:

city_id	city_name	country_name
1	Calgary	Canada
2	Brisbane	Australia
Summary of Normalization Steps:
0NF to 1NF: Remove repeating groups and ensure atomicity by separating multi-valued and composite attributes.
1NF to 2NF: Eliminate partial dependencies by creating new tables for attributes that don’t fully depend on the primary key, ensuring that every non-key attribute is dependent on the entire primary key.
This process results in a more organized database structure that reduces redundancy and dependency issues, achieving 2NF for the address table.





-- 5.Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have
-- acted in from the actor and film_actor tables.
WITH cte AS (
    SELECT 
        a.actor_id, 
        a.first_name, 
        a.last_name, 
        COUNT(fa.film_id) AS no_of_film
    FROM 
        actor AS a
    INNER JOIN 
        film_actor AS fa
    ON 
        a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, 
        a.first_name, 
        a.last_name
)
SELECT 
    CONCAT(first_name, ' ', last_name) AS actor_name, 
    no_of_film 
FROM 
    cte;


   
-- 6.Use a recursive CTE to generate a hierarchical list of categories and their subcategories from the category
table in Sakila


WITH RECURSIVE category_hierarchy AS (
    -- Anchor member: Select top-level categories (those with no parent)
    SELECT 
        category_id,
        name,
        parent_id,
        1 AS level -- Starting level
    FROM 
        category
    WHERE 
        parent_id IS NULL -- Assuming top-level categories have no parent
    
    UNION ALL
    
    -- Recursive member: Join categories with their parents
    SELECT 
        c.category_id,
        c.name,
        c.parent_id,
        ch.level + 1 AS level
    FROM 
        category AS c
    INNER JOIN 
        category_hierarchy AS ch
    ON 
        c.parent_id = ch.category_id
)
SELECT 
    category_id,
    name,
    parent_id,
    level
FROM 
    category_hierarchy
ORDER BY 
    level, -- Ordering by hierarchy level
    parent_id, -- Ordering by parent_id for better hierarchy visualization
    name; -- Ordering by category name




-- 7. Create a CTE that combines information from the film and  langugae tables to display the film title, language
-- name, and rental rate
    WITH cte AS (
    SELECT 
        f.title, 
        l.name AS language_name, 
        f.rental_rate
    FROM 
        film AS f
    INNER JOIN 
        language AS l
    ON 
        f.language_id = l.language_id
)
SELECT 
    * 
FROM 
    cte;


-- 8.Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from
-- the  customer and payment table


WITH cte AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_revenue
    FROM 
        customer AS c
    LEFT JOIN 
        payment AS p
    ON 
        c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, 
        c.first_name, 
        c.last_name
)
SELECT 
    * 
FROM 
    cte;


-- 9.Utilize a CTE with a window function to rank films based on their rental duration from the  film table

with cte as(
 select *,
 dense_rank() over(order by rental_duration desc) as rn
 from film)
  select * from cte;


-- 10. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the
 --  customer table to retrieve additional customer details.
 
  with cte as(
  select  customer_id , count(rental_id)as cnt
  from rental
   group by customer_id
   having count(rental_id)>2)
   
    select c1.* from cte as c 
    inner join customer as c1
    on c.customer_id=c1.customer_id;
    
-- 11 Write a query using a CTE to find the total number of rentals made each month, considering the rental_date
-- from the  rental table.

with cte as(
   select extract(month from rental_date) as " month" , count(*) as cnt
   from rental
    group by extract(month from rental_date)
    order by month asc)
     select * from cte;
    
-- 12. Use a CTE to pivot the data from the payment table to display the total payments made by each customer in
-- separate columns for different payment methods.


WITH payment_totals AS (
    SELECT 
        customer_id,
        payment_method,
        SUM(amount) AS total_amount
    FROM 
        payment
    JOIN 
        payment_method pm
    ON 
        payment.payment_method_id = pm.payment_method_id
    GROUP BY 
        customer_id, 
        payment_method
)
SELECT 
    customer_id,
    COALESCE(SUM(CASE WHEN payment_method = 'Credit Card' THEN total_amount ELSE 0 END), 0) AS credit_card_total,
    COALESCE(SUM(CASE WHEN payment_method = 'Debit Card' THEN total_amount ELSE 0 END), 0) AS debit_card_total,
    COALESCE(SUM(CASE WHEN payment_method = 'PayPal' THEN total_amount ELSE 0 END), 0) AS paypal_total
FROM 
    payment_totals
GROUP BY 
    customer_id;


-- 13. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together,
-- using the film_actor table
WITH actor_pairs AS (
    SELECT 
        f1.actor_id AS actor1_id,
        f2.actor_id AS actor2_id,
        f1.film_id
    FROM 
        film_actor AS f1
    INNER JOIN 
        film_actor AS f2
    ON 
        f1.film_id = f2.film_id
    AND 
        f1.actor_id < f2.actor_id  -- Ensures each pair is listed once and avoids self-pairs
)
SELECT 
    ap.actor1_id,
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    ap.actor2_id,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name,
    COUNT(*) AS number_of_films
FROM 
    actor_pairs AS ap
INNER JOIN 
    actor AS a1
ON 
    ap.actor1_id = a1.actor_id
INNER JOIN 
    actor AS a2
ON 
    ap.actor2_id = a2.actor_id
GROUP BY 
    ap.actor1_id, 
    a1.first_name, 
    a1.last_name,
    ap.actor2_id, 
    a2.first_name, 
    a2.last_name
ORDER BY 
    a1.last_name, 
    a1.first_name,
    a2.last_name, 
    a2.first_name;


