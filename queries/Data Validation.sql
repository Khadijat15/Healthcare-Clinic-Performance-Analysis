/* 
   Author : LAMIDI KHADIJAT 
   Project: Healthcare Clinic Performance Analysis
 */

 /*
    Overview: 
	This section performs data quality validation checks to ensure the dataset is suitable for
	analysis.
	The objective is to identify issues that could affect accuracy of analytical results and SQL 
	queries.

	The data validation focuses on:
	- Verifying key identifiers are present and do not contain missing values.
	- Detecting duplicates records.
	- Validating record consistency across related tables.
	- Identifying negative payment values that could indicate data entry errors.


	Key Findings:
	- No missing key identifier were detected
	- No duplicate records
	- No invalid negative payment amount
	- Table relationships were maintained
	- The dataset is suitable for analysis
*/

--- 1.1 Missing Identifier check

SELECT 
     COUNT(*) 
FROM 
    patients 
WHERE 
     patient_id IS NULL;
	 
------

SELECT 
     COUNT(*) 
FROM 
    payments
WHERE 
    payment_id IS NULL;
	
-------

SELECT 
      COUNT(*) 
FROM 
    staff
WHERE 
     staff_id IS NULL;
----

SELECT 
      COUNT(*) 
FROM 
    treatments 
WHERE 
     treatment_id IS NULL;

-----

SELECT
     COUNT(*) 
FROM
    clinics 
WHERE 
    clinic_id IS NULL;
----

SELECT
     COUNT(*) 
FROM 
    doctors 
WHERE 
     doctor_id IS NULL;

-----

SELECT 
     COUNT(*) 
FROM
    prescriptions 
WHERE 
     prescription_id IS NULL;
	 
-----

SELECT 
     COUNT(*) 
FROM 
    appointments
WHERE 
     appointment_id IS NULL;


--- 1.2 Duplicate Record Chck
	
SELECT 
     patient_id, COUNT(*)
FROM 
    patients
GROUP BY 
        patient_id
HAVING COUNT (*) > 1;

-----

SELECT 
      staff_id, COUNT(*)
FROM 
    staff
GROUP BY
      staff_id
HAVING COUNT (*) > 1;

-----

SELECT
     payment_id, COUNT(*)
FROM 
     payments
GROUP BY 
       payment_id
HAVING COUNT (*) > 1;

-----


SELECT 
     clinic_id, COUNT(*)
FROM 
    clinics
GROUP BY 
       clinic_id
HAVING COUNT (*) > 1;

-----

SELECT 
      treatment_id, COUNT(*)
FROM 
    treatments
GROUP BY 
       treatment_id
HAVING COUNT (*) > 1;

-----

SELECT 
      prescription_id, COUNT(*)
FROM 
    prescriptions
GROUP BY 
       prescription_id
HAVING COUNT (*) > 1;

-----

SELECT
     doctor_id, COUNT(*)
FROM 
    doctors
GROUP BY  
       doctor_id
HAVING COUNT (*) > 1;

----

SELECT 
      appointment_id, COUNT(*)
FROM
    appointments
GROUP BY 
      appointment_id
HAVING COUNT (*) > 1;


--- 1.3 Record Consistency Validation

SELECT* 
FROM
    appointments AS aps
LEFT JOIN 
       patients AS pt
ON 
   aps.patient_id = pt.patient_id
WHERE 
     pt.patient_id IS NULL;


--- 1.4 Negative Amount Validation

SELECT*
FROM 
    payments
WHERE 
     payment_amount < 0

