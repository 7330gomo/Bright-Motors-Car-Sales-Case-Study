SELECT
YEAR AS Manufacturing_Year,

CASE 
    WHEN YEAR BETWEEN 1982 AND 1990 THEN 'Classic / Vintage'
    WHEN YEAR BETWEEN 1991 AND 2000 THEN 'Old'
    WHEN YEAR BETWEEN 2001 AND 2010 THEN 'Mid-Age'
    WHEN YEAR BETWEEN 2011 AND 2015 THEN 'Recent'
    ELSE 'Unknown'
  END AS year_category,
  
COUNT(*) AS total_cars,

MAKE AS Brand,
  CASE
    WHEN MAKE IN ('Toyota', 'Hyundai', 'Nissan', 'Honda', 'Ford', 'Chevrolet', 'Dodge', 'Subaru', 'Kia', 'Volkswagen', 'Vw', 'Mazda', 'Buick', 'Pontiac', 'Saturn', 'Mitsubishi', 'Daewoo') 
      THEN 'Mainstream / Mass Market'
    WHEN MAKE IN ('Mercedes-benz', 'Mercedes-Benz', 'Mercedes', 'BMW', 'Lexus', 'Cadillac', 'Land Rover', 'Landrover', 'Jaguar', 'Audi', 'Infiniti', 'Lincoln', 'Volvo', 'Acura') 
      THEN 'Luxury / Premium'
    WHEN MAKE IN ('Ferrari', 'Lamborghini', 'Maserati', 'Eston martin', 'Rolls-royce', 'Lotus', 'Porsche') 
      THEN 'Exotic / Sports'
    WHEN MAKE IN ('Ford truck', 'GMC truck', 'Dodge tk', 'Mazda tk', 'Hummer', 'Airstream') 
      THEN 'Trucks / Specialty' 
    WHEN MAKE IN ('Fiat', 'Scion', 'Smart', 'Geo', 'Dot') 
      THEN 'Miscellaneous'   
    ELSE 'Others'
  END AS Brand_Category,

MODEL AS Model_Type,
CASE 
    WHEN model_type IN ('Accord','Camry','Civic','Altima','Malibu','Fusion','A4','A6') THEN 'Sedan'
    WHEN model_type IN ('Forester','RAV4','X5','CR-V','Patriot','Grand Cherokee','Tucson') THEN 'SUV'
    WHEN model_type IN ('F-150','Silverado','Ram 2500','Tacoma','Ranger','Sierra 1500') THEN 'Pickup Truck'
    WHEN model_type IN ('Odyssey','Sienna','Town and Country','Caravan','Transit','Express Cargo') THEN 'Minivan/Van'
    WHEN model_type IN ('7 Series','S-Class','A8','GS 350','Q7','Cayenne','X6','Ghibli') THEN 'Luxury'
    WHEN model_type IN ('Prius','Volt','Leaf','Model S','Fusion Energi','C-Max Hybrid') THEN 'Electric/Hybrid'
    WHEN model_type IN ('Corvette','Mustang','GT-R','911','Boxster','M3','RS 5','Viper') THEN 'Sports'
    ELSE 'Others'
END AS model_category,

TRIM,
BODY AS Body_Type,
TRANSMISSION,
VIN,
State,

CASE
 WHEN STATE IN ('mo','in','fl','az','hi','nm','ok','ms','pa','tn','ne','wi',
                   'al','ga','va','wa','md','ut','tx','il','ma','ca','la','oh',
                   'nj','nc','mn','mi','or','nv','sc','ny','co')
         THEN 'U.S. State'
         
    WHEN state IN ('qc','on','ns','ab')
         THEN 'Canadian Province'
         
    WHEN state = 'pr'
         THEN 'U.S. Territory'  
    ELSE 'Others'
  END AS state_type,
  
   CASE 
    WHEN STATE IN ('pa','nj','ny','ma') THEN 'U.S. Northeast'
    WHEN STATE IN ('mo','in','ne','wi','mn','oh','il') THEN 'U.S. Midwest'
    WHEN STATE IN ('fl','ok','ms','tn','al','ga','va','tx','nc','sc','la') THEN 'U.S. South'
    WHEN STATE IN ('az','nm','ut','wa','or','nv','co','ca') THEN 'U.S. West'
    WHEN STATE IN ('hi','pr') THEN 'Territory'
    WHEN STATE IN ('qc','on','ns','ab') THEN 'Canada'
    ELSE 'Others'
END AS Region,

Condition,

CASE
    WHEN CONDITION BETWEEN 1 AND 16 THEN 'Poor'
    WHEN CONDITION BETWEEN 17 AND 33 THEN 'Good'
    WHEN CONDITION BETWEEN 34 AND 49 THEN 'Best'
    ELSE 'Out of Range'
  END AS performance_category,
  
Odometer,
AVG(ODOMETER) AS AVG_ODOMETER,

 CASE
    WHEN odometer BETWEEN 1 AND 50000 THEN 'lightly used cars'
    WHEN odometer BETWEEN 50001 AND 150000 THEN 'moderately used cars'
    WHEN odometer BETWEEN 150001 AND 300000 THEN 'heavily used cars'
    WHEN odometer BETWEEN 300001 AND 999999 THEN 'extremely used cars'
    ELSE 'Out of Range'
  END AS odometer_category,
  
Color,
Interior,
Seller,
MMR,

CASE
    WHEN mmr BETWEEN 25 AND 50000 THEN 'Low-value cars'
    WHEN mmr BETWEEN 50001 AND 100000 THEN 'Mid-value cars'
    WHEN mmr BETWEEN 100001 AND 150000 THEN 'High-value cars'
    WHEN mmr BETWEEN 150001 AND 182000 THEN 'Luxury or exotic vehicles'
    ELSE 'Out of range'
  END AS mmr_category,

  AVG(MMR) AS Avg_MMR,
 (SELLINGPRICE - MMR) AS Profit_margin,
 
 CASE
 WHEN (SELLINGPRICE - MMR) <= 0 THEN 'No Profit'
 WHEN (SELLINGPRICE - MMR) BETWEEN 1 AND 2999 THEN 'Minimal Profit'
 WHEN (SELLINGPRICE - MMR)  BETWEEN 3000 AND 5999 THEN 'Acceptable Profit'
 ELSE 'Great profit'
 END AS Profit_margin_Classification,

 AVG(SELLINGPRICE) AS Avg_SELLINGPRICE,
 SUM(SELLINGPRICE) AS Total_Revenue,
SELLINGPRICE,

to_timestamp(saledate,'DY MON DD YYYY HH24:MI:SS') AS Sale_timestamp,
extract(Year from to_timestamp(saledate,'DY MON DD YYYY HH24:MI:SS')) AS Sale_Year,
MONTHNAME(to_timestamp(saledate,'DY MON DD YYYY HH24:MI:SS')) AS Sale_Month,
DAYNAME(to_timestamp(saledate,'DY MON DD YYYY HH24:MI:SS')) AS Sale_Day,
Time(to_timestamp(saledate,'DY MON DD YYYY HH24:MI:SS')) AS Sale_Time,

Case
WHEN Sale_Time between '06:00:00' AND '11:00:00'  THEN 'Morning' 
WHEN Sale_Time between '12:00:00' AND '15:59:59'  THEN 'Afternoon' 
ELSE 'Evening/Night'
END AS Sale_Day_Classification,

Case
WHEN Sale_Day IN ('Sat','Sun') THEN 'Weekend Sale' 
ELSE 'Weekday Sale'
END AS Sale_Week_Classification,

FROM CASE_STUDY2.CAR_SALES.DATA
WHERE saledate like '___ ___ __ ____ __:__:__'
AND VIN  LIKE '_________________' 
AND MAKE IS NOT NULL 
AND MODEL IS NOT NULL 
AND TRIM IS NOT NULL 
AND BODY IS NOT NULL 
AND TRANSMISSION IS NOT NULL 
AND VIN IS NOT NULL 
AND STATE IS NOT NULL 
AND CONDITION IS NOT NULL 
AND ODOMETER IS NOT NULL 
AND COLOR IS NOT NULL 
AND INTERIOR IS NOT NULL 
AND MMR IS NOT NULL 
AND SELLINGPRICE IS NOT NULL
AND (COLOR LIKE '%y' 
OR COLOR LIKE'%k' 
OR COLOR LIKE '%e'
OR COLOR LIKE '%n' 
OR COLOR LIKE '%l' 
OR COLOR LIKE '%r' 
OR COLOR LIKE '%w'
OR COLOR LIKE 'r__'
OR COLOR LIKE 'g___')
AND STATE NOT LIKE '_________________'
AND TRANSMISSION NOT IN ('Sedan', 'sedan')
AND (INTERIOR LIKE '%y' 
OR INTERIOR LIKE '%e' 
OR INTERIOR LIKE '%n' 
OR INTERIOR LIKE '%d' 
OR INTERIOR LIKE '%w' 
OR INTERIOR LIKE '%k' 
OR INTERIOR LIKE '%r')
GROUP BY ALL;
