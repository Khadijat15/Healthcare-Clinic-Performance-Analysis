/*
   Author: LAMIDI KHADIJAT
   PROJECT: Healthcare Clinic Data Analysis
*/

/*
  Overview: 
  This section evaluates how patients progress through the care process across the clinic network.
  The analysis examines appointment volume, treatment status distribution, and progression patterns
  across clinics and treatment categories.

  The objective is to understand patient demand, assess how patients move through the treatment 
  pathway, and identify potential variations in treatment progression across different clinics and 
  service areas. This analysis provides context for evaluating patient flow and determining whether patient progression patterns differ across the healthcare system.




  Key Findings:
  -  A total of 100,000 appointments were recorded across the clinic network.
  - Appointment volumes varied across clinics, indicating differences in patient demand between
  locations.
  - Treatment statuses were evenly distributed across completed, ongoing, and pending categories.
  - Treatment completion, ongoing, and pending rates showed relatively little variation across clinics
    and treatment types.
  - Pending treatment rates remained relatively consistent across treatment categories, 
    suggesting no clear evidence of localized patient flow bottlenecks within the available data.
  - Overall, patient progression patterns appeared broadly consistent across the clinic.

 */

--- 2.1 Total Appointment Volume

SELECT COUNT(*) 
FROM appointments

--- 2.2 Appointment Volume by Clinic

SELECT 
      cs.clinic_id, cs.clinic_name,cs.clinic_type, 
	  COUNT(aps.appointment_id) AS Total_appointment
FROM 
    appointments AS aps
JOIN 
    clinics AS cs
ON 
   cs.clinic_id = aps.clinic_id
GROUP BY
       cs.clinic_id, cs.clinic_name
ORDER BY
       Total_appointment DESC;


--- 2.3 Treatment Status Distribution

SELECT 
     cs.clinic_id,cs.clinic_name, cs.clinic_type,
     COUNT(aps.appointment_id) AS total_appointment,
     SUM
     (CASE WHEN t.treatment_status = 'Completed' THEN 1 ELSE 0 END) *100 / COUNT(*) 
     AS treatment_completion_rate,
     SUM
     (CASE WHEN t.treatment_status = 'Ongoing' THEN 1 ELSE 0 END) *100 / COUNT(*) 
     AS treatment_Ongoing_rate,
     SUM
    (CASE WHEN t.treatment_status = 'Pending' THEN 1 ELSE 0 END) *100 / COUNT(*) 
     AS treatment_Pending_rate
FROM 
    clinics AS cs
JOIN 
    appointments AS aps
ON  
  cs.clinic_id = aps.clinic_id
JOIN 
    treatments AS t
ON 
   t.appointment_id = aps.appointment_id
GROUP BY 
       cs.clinic_id, cs.clinic_name;

--- 2.4 Progression Analysis by treatment type and specialty

SELECT treatment_type,
SUM
(CASE WHEN treatment_status = 'Ongoing' THEN 1 ELSE 0 END) *100 / COUNT(*) 
AS treatment_ongoing_rate,
SUM
(CASE WHEN treatment_status = 'Pending' THEN 1 ELSE 0 END) *100 / COUNT(*) 
AS treatment_pending_rate
FROM treatments
GROUP BY treatment_type
ORDER BY treatment_pending_rate;  

---------------------

SELECT dr.speciality,
SUM
(CASE WHEN t.treatment_status = 'Ongoing' THEN 1 ELSE 0 END) *100 / COUNT(*) 
AS treatment_ongoing_rate,
SUM
(CASE WHEN t.treatment_status = 'Pending' THEN 1 ELSE 0 END) *100 / COUNT(*) 
AS treatment_pending_rate
FROM treatments t
JOIN appointments aps
ON t.appointment_id = aps.appointment_id
JOIN clinics cs
ON cs.clinic_id = aps.clinic_id
JOIN doctors dr
ON cs.clinic_id = dr.clinic_id
GROUP BY dr.speciality
ORDER BY treatment_pending_rate;  


