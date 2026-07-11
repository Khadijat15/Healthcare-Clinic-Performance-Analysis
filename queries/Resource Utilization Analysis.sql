/*
  Author: LAMIDI KHADIJAT
  PROJECT: Healthcare Clinic Performance Analysis 
*/

/*
  Overview:
  This script evaluate how healthcare resources are distributed across the clinic network by examining 
  patient demand, provider workload, and clinic level workload distribution. This analysis helps to 
  identify areas where patient demand and service delivery may be concentrated and provides insights 
  into operational inefficiency.


  Key Findings:
  -   Family Health Clinic Andrew served the highest number of patients while Medical Group 
   Williamton served the least.
   - Appointment volume varied considerably among service providers, with samll number of
  doctors handling a high share of appointments.
  - Family Health Clinic West Kurt has a higher appointment to doctor ratio indicating a higher 
   workoad concentration per doctor compared to other clinics.
  - Family Health Clinic West Rosalesville has a higher appointment to staff ratio indicating a 
  higher workoad concentration per doctor compared to other clinics.
 */



--- 3.1 Patient Count by Clinic

 SELECT 
       cs.clinic_id, cs.clinic_name, 
	   COUNT(aps.patient_id) AS patient_counts
 FROM 
     appointments aps
 JOIN 
    clinics cs
 ON 
   aps.clinic_id = cs.clinic_id
 GROUP BY
       cs.clinic_id, cs.clinic_name
 ORDER BY 
        patient_counts DESC;

--- 3.2 Appointment Volume by Doctor

SELECT 
      dr.doctor_id, dr.full_name, 
	  COUNT(aps.patient_id) AS patient_counts
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
 GROUP BY 
        dr.doctor_id, dr.full_name
 ORDER BY
        patient_counts DESC;

--- 3.3 Clinic Workforce and Appointment Volume Analysis

SELECT cs.clinic_id, cs.clinic_name, COUNT(DISTINCT dr.doctor_id) AS doctor_count,
 COUNT(DISTINCT aps.appointment_id) AS Total_appointment, (COUNT(DISTINCT aps.appointment_id) /
 COUNT(DISTINCT dr.doctor_id)) AS Appointment_per_doctor
 FROM doctors dr
 JOIN clinics cs
 ON cs.clinic_id = dr.clinic_id
 JOIN appointments aps
 ON aps.clinic_id = cs.clinic_id
 GROUP BY cs.clinic_id, cs.clinic_name
 ORDER BY appointment_per_doctor DESC;

-----

SELECT cs.clinic_id, cs.clinic_name, COUNT(DISTINCT sf.staff_id) AS staff_count,
 COUNT(DISTINCT aps.appointment_id) AS Total_appointment, (COUNT(DISTINCT aps.appointment_id) /
COUNT(DISTINCT sf.staff_id)) AS appointment_per_staff
 FROM staff sf
 JOIN clinics cs
 ON cs.clinic_id = sf.clinic_id
 JOIN appointments aps
 ON aps.clinic_id = cs.clinic_id
 GROUP BY cs.clinic_id, cs.clinic_name
 ORDER BY appointment_per_staff DESC;



