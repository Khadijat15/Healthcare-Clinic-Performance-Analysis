/* 
  AUTHOR: LAMIDI KHADIJAT
  PROJECT: Healthcare Clinic Performance Analytics
*/

/*

  Overview: 
  This script evaluates how revenue is generated across the healthcare system by examining 
  contributions from different treatment types, clinics, and specialities. 
  The goal is to understand revenue distribution patterns.

  Key Findings
  -  Surgery generated the highest revenue, however the difference between other treatment type 
  was minimal.
  -  Revenue is evenly distributed across clinics
  -  The dermatology department generated the highest revenue across the healthcare system.
  - A small group of doctors consistently contributed higher revenue compared to the rest, although
   the differences were not extreme.

*/


--- 4.1 Revenue by Treatment Type

SELECT
     ts.treatment_type, 
	 SUM(py.payment_amount) AS Total_revenue
FROM 
    payments py
JOIN 
    appointments aps
ON 
  py.appointment_id = aps.appointment_id
JOIN 
   treatments ts
ON 
  ts.appointment_id = aps.appointment_id
GROUP BY 
       ts.treatment_type
ORDER BY 
       Total_revenue DESC;

--- 4.2 Revenue Contribution per Clinic

SELECT
    clinic_name,SUM(py.payment_amount) AS total_revenue,
	SUM(py.payment_amount) *100 / (SELECT SUM(payment_amount) FROM payments) AS
	Revenue_contribution
FROM payments py
JOIN appointments aps
ON py.appointment_id = aps.appointment_id
JOIN clinics cs
ON cs.clinic_id = aps.clinic_id
GROUP BY cs.clinic_name
ORDER BY Revenue_contribution DESC;


--- 4.3 Revenue by Specialty

SELECT 
     dr.speciality,
	 SUM(py.payment_amount) AS Total_revenue
FROM 
    payments py
JOIN
    appointments aps
ON 
   py.appointment_id = aps.appointment_id
JOIN 
    clinics cs
ON 
  cs.clinic_id = aps.clinic_id
JOIN 
    doctors dr
ON 
  dr.clinic_id = cs.clinic_id
GROUP BY
       dr.speciality
ORDER BY
       Total_revenue DESC;


--- 4.4 Average Revenue Contribution per Doctor

SELECT
     dr.doctor_id,dr.full_name, 
	 SUM(py.payment_amount), 
	 COUNT(aps.appointment_id),
     (SUM(py.payment_amount)/COUNT(aps.appointment_id)) AS Avg_revenue_per_doctor
FROM 
    doctors dr
 JOIN 
     clinics cs
 ON
   dr.clinic_id = cs.clinic_id
 JOIN 
     appointments aps
 ON 
   aps.clinic_id = cs.clinic_id
 JOIN
     payments py
 ON
   py.appointment_id = aps.appointment_id
 GROUP BY 
        dr.doctor_id, dr.full_name
 ORDER BY
        Avg_revenue_per_doctor DESC;





