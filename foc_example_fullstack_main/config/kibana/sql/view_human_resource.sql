drop view human_resource_view;


drop view human_resource_academic_certificate_view;


drop view human_resource_occupation_view;


create view human_resource_occupation_view as
select human_resource_occupation.human_resource_ref,
       array_to_json(array_agg(row_to_json(human_resource_occupation))) as human_resource_occupation
from
  (select md."HumanResource_REF" as human_resource_ref,
          md."REF" as human_resource_occupation_ref,
          md."PublicSector" as human_resource_occupation_public_sector,
          md."PublicAdministration" as human_resource_occupation_public_administration,
          md."Unit" as human_resource_occupation_unit,
          md."PrivateCompany" as human_resource_occupation_private_company,
          md."JobDescription" as human_resource_occupation_job_description,
          md."StartDate" as human_resource_occupation_start_date,
          md."EndDate" as human_resource_occupation_end_date
   from "HumanResourceOccupation" md) as human_resource_occupation
group by human_resource_occupation.human_resource_ref;


create view human_resource_academic_certificate_view as
select human_resource_academic_certificate.human_resource_ref,
       array_to_json(array_agg(row_to_json(human_resource_academic_certificate))) as human_resource_academic_certificate
from
  (select md."HumanResource_REF" as human_resource_ref,
          md."REF" as human_resource_academic_certificate_ref,
          md."CertificationDate" as human_resource_academic_certificate_date,
          md."Major" as human_resource_academic_certificate_major,
          md."EducationalInstitution" as human_resource_academic_certificate_educational_institution,
          md."EducationalInstitutionAddress" as human_resource_academic_certificate_educational_institution_address,
          md."CertificationYear" as human_resource_academic_certificate_year,
          ac."NAME" as academic_certificate
   from "HumanResourceAcademicCertificate" md
   left join "AcademicCertificate" ac on ac."REF" = md."AcademicCertificate_REF") as human_resource_academic_certificate
group by human_resource_academic_certificate.human_resource_ref;


create VIEW human_resource_view as
select hr."REF" as human_resource_ref,
       hr."DATE" as human_resource_date,
       hr."FirstName" as human_resource_first_name,
       hr."LastName" as human_resource_last_name,
       hr."FatherName" as human_resource_father_name,
       hr."MotherName" as human_resource_mother_name,
       hr."RegistryNumber" as human_resource_registry_number,
       hr."MobileNumber" as human_resource_mobile_number,
       hr."DOB" as human_resource_dob,
       hr."Email" as human_resource_email,
       hr."Address" as human_resource_address,
       hr."HomeInternet" as human_resource_home_internet,
       hr."OccupationUnit" as human_resource_occupation_unit,
       hr."OccupationDescription" as human_resource_occupation_description,
       hr."OccupationStartDate" as human_resource_occupation_start_date,
       hr."OccupationEmploymentDate" as human_resource_occupation_employment_date,
       hr."CommunicationCapabilityGeneralMobilisation" as human_resource_communication_capability_general_mobilization,
       hr."WorkTime" as human_resource_work_time,
       hr."ExtraHours" as human_resource_extra_hours,
       hr."NightHours" as human_resource_night_hours,
       hr."OccupationTaskCardTasks" as human_resource_occupation_task_card_tasks,
       hr."OccupationActualTasks" as human_resource_occupation_actual_tasks,
       hr."HasGeneralInfo" as human_resource_has_general_info,
       hr."HasCurrentOccupationInfo" as human_resource_has_current_occupation_info,
       hr."HasTaskInfo" as human_resource_has_task_info,
       hr."MonetaryNumber" as human_resource_monetary_number,
       hr."OccupationPublicSectorName" as human_resource_occupation_public_sector_name,
       hr."OccupationSubUnit" as human_resource_occupation_sub_unit,
       hr."OccupationMandateDate" as human_resource_occupation_mandate_date,
       hr."OccupationAddress" as human_resource_occupation_address,
       hr."OccupationLegalStatusOther" as human_resource_occupation_legal_status_other,
       hr."AutoNumber" as human_resource_auto_number,
       hr."OccupationMandateNumber" as human_resource_occupation_mandate_number,
       hr."HasPreviousOccupationInfo" as human_resource_has_previous_occupation_info,
       hr."HasAcademicCertificateInfo" as human_resource_has_academic_certificate_info,
       hr."DataCertified" as human_resource_data_certified,
       hr."PenalRuling" as human_resource_penal_ruling,
       hr."OtherPaidOccupationExists" as human_resource_other_paid_occupation_exists,
       hr."OtherPaidOccupationCompanyName" as human_resource_other_paid_occupation_company_name,
       hr."OtherPaidOccupationJobDescription" as human_resource_other_paid_occupation_job_description,
       hr."OtherPaidOccupationStartDate" as human_resource_other_paid_occupation_start_date,
       hr."OccupationRequiresExtraHours" as human_resource_occupation_requires_extra_hours,
       hr."Idara" as human_resource_idara,
       g."NAME" as gender,
       oht."NAME" as occupation_handling_type,
       ols."NAME" as occupation_legal_status,
       otc."NAME" as occupation_task_card,
       wtt."NAME" as work_time_type,
       r."NAME" as religion,
       ss."NAME" as social_status,
       rg."NAME" as registry_kadaa,
       pst."NAME" as occupation_public_sector_type,
       ol."NAME" as occupation_line,
       oss."NAME" as occupation_special_situation,
       mt."NAME" as occupation_mandate_type,
       ok."NAME" as occupation_kaadaa,
       om."NAME" as occupation_municipality,
       oms."NAME" as occupation_mandate_source,
       oc."NAME" as occupation_category,
       re."NAME" as registry,
       qn."NAME" as dual_nationality,
       hcc."NAME" as health_care_coverage,
       ms."NAME" as occupation_monthly_salary,
       ps."NAME" as occupation_public_sector,
       pit."NAME" as public_institution_type,
       k."NAME" as kadaa,
       z."NAME" as mouhafaza,
       m."NAME" as municipality,
       usr."NAME" as user_name,
       usr."FULL_NAME" as user_full_name,
       usr."REF" as user_ref,
       grp."NAME" as user_group,
       ups."NAME" as user_public_sector,
       to_json(hrov.human_resource_occupation)::text as human_resource_occupation,
       to_json(hrac.human_resource_academic_certificate)::text as human_resource_academic_certificate
from "HumanResource" hr
left join "Gender" g on g."REF" = hr."Gender_REF"
left join "Kadaa" k on k."REF" = hr."Kadaa_REF"
left join "Mouhafaza" z on z."REF" = hr."Mouhafaza_REF"
left join "Municipality" m on m."REF" = hr."Municipality_REF"
left join "OccupationLegalStatus" ols on ols."REF" = hr."OccupationLegalStatus_REF"
left join "OccupationHandlingType" oht on oht."REF" = hr."OccupationHandlingType_REF"
left join "OccupationTaskCard" otc on otc."REF" = hr."OccupationTaskCard_REF"
left join "WorkTimeType" wtt on wtt."REF" = hr."WorkTimeType_REF"
left join "Religion" r on r."REF" = hr."Religion_REF"
left join "SocialStatus" ss on ss."REF" = hr."SocialeStatus_REF"
left join "Kadaa" rg on rg."REF" = hr."RegistryKadaa_REF"
left join "PublicSectorType" pst on pst."REF" = hr."OccupationPublicSectorType_REF"
left join "OccupationLine" ol on ol."REF" = hr."OccupationLine_REF"
left join "OccupationSpecialSituation" oss on oss."REF" = hr."OccupationSpecialSituation_REF"
left join "MandateType" mt on mt."REF" = hr."OccupationMandateType_REF"
left join "Kadaa" ok on ok."REF" = hr."OccupationKadaa_REF"
left join "Municipality" om on om."REF" = hr."OccupationMunicipality_REF"
left join "MandateSource" oms on oms."REF" = hr."OccupationMandateSource_REF"
left join "OccupationCategory" oc on oc."REF" = hr."OccupationCategory_REF"
left join "Municipality" re on re."REF" = hr."Registry_REF"
left join "QTNationality" qn on qn."REF" = hr."DualNationality_REF"
left join "HealthCareCoverage" hcc on hcc."REF" = hr."HealthCareCoverage_REF"
left join "MonthlySalary" ms on ms."REF" = hr."OccupationMonthlySalary_REF"
left join "PublicSector" ps on ps."REF" = hr."OccupationPublicSector_REF"
left join "PublicInstitutionType" pit on pit."REF" = hr."PublicInstitutionType_REF"
left join human_resource_academic_certificate_view hrac on hrac.human_resource_ref = hr."REF"
left join human_resource_occupation_view hrov on hrov.human_resource_ref = hr."REF"
left join "FUSER" usr on usr."REF" = hr."User_REF"
left join "FGROUP" grp on grp."REF" = usr."GRP_REF"
left join "PublicSector" ups on ups."REF" = usr."PublicSector_REF" ;