/* 
   Author : LAMIDI KHADIJAT 
   Project: Healthcare Clinic Performance Analysis
   
   Description: 
  This script performs data validation checks to asses data quality before analysis
 */
 

/*
  Validation Check 1: NULL IDs

  Purpose: 
  ID columns are important columns used to uniquely identify records and establish relationships 
  between tables through primary and foreign keys. Missing ID values can break table relationships,
  prevent accurate joins, and lead to incomplete or misleading analytical results. Therefore
  checking null values in key identifier columns is an important step to ensure data quality
 */


SELECT COUNT(*) 
FROM patients 
WHERE patient_id IS NULL

SELECT COUNT(*) 
FROM payments
WHERE payment_id IS NULL

SELECT COUNT(*) 
FROM staff
WHERE staff_id IS NULL

SELECT COUNT(*) 
FROM treatments 
WHERE treatment_id IS NULL


SELECT COUNT(*) 
FROM clinics 
WHERE clinic_id IS NULL

SELECT COUNT(*) 
FROM doctors 
WHERE doctor_id IS NULL


SELECT COUNT(*) 
FROM prescriptions 
WHERE prescription_id IS NULL

SELECT COUNT(*) 
FROM appointments
WHERE appointment_id IS NULL

/* 
   Results:No null values found
  */

------------------------------------------------------------------------
 /* 
   Validation Check 2 : Duplicate Records

     Purpose: Duplicate records can change key metrics such as revenue calculations, patients
	 counts,and so on. Detecting and Investigating duplicates values helps to ensure accurate 
	 analytical results
*/

SELECT patient_id, COUNT(*)
FROM patients
GROUP BY patient_id
HAVING COUNT (*) > 1;


SELECT staff_id, COUNT(*)
FROM staff
GROUP BY staff_id
HAVING COUNT (*) > 1;

SELECT payment_id, COUNT(*)
FROM payments
GROUP BY payment_id
HAVING COUNT (*) > 1;

SELECT clinic_id, COUNT(*)
FROM clinics
GROUP BY clinic_id
HAVING COUNT (*) > 1;

SELECT treatment_id, COUNT(*)
FROM treatments
GROUP BY treatment_id
HAVING COUNT (*) > 1;

SELECT prescription_id, COUNT(*)
FROM prescriptions
GROUP BY prescription_id
HAVING COUNT (*) > 1;

SELECT doctor_id, COUNT(*)
FROM doctors
GROUP BY doctor_id
HAVING COUNT (*) > 1;


SELECT appointment_id, COUNT(*)
FROM appointments
GROUP BY appointment_id
HAVING COUNT (*) > 1;

/* 
   Results: No duplicate records
  */
  
------------------------------------------------------------
/* 
   Validation Check 3 : Record Matching Check

   Purpose: Each appointment record should be linked to a valid patient record. Appointment that 
   doesn't match an existing patient record may indicate data entry, broken relationship or missing
   records. Identifying this helps to maintain data reliability.
 */
 
SELECT* 
FROM appointments AS aps
LEFT JOIN patients AS pt
ON aps.patient_id = pt.patient_id
WHERE pt.patient_id IS NULL;

/* 
   Results: all appointment date has a valid patient id
  */
  
-------------------------------------------------------------

/* 
   Validation Check 4: 	Negative Amounts

   Purpose: Negative payment amounts may indicate data entry errors or records that requires further 
   investigation. If not properly addressed, these values can affect revenue calculations and
   lead to inaccurate business insights. Checking negative amount helps to improve data quality
   and analysis based on reliable information
*/
	
SELECT*
FROM payments
WHERE payment_amount < 0


/* 
   Results : No negative amount found 
*/
