drop view incident_view;


drop view quarantine_view;


create VIEW quarantine_view as
select q."REF" as quarantine_ref,
       q."AreaName" as quarantine_area_name,
       q."AreaSize" as quarantine_area_size,
       q."ElectricityHours" as quarantine_electricity_hours,
       q."HasAirVentilation" as quarantine_has_air_ventilation,
       q."HasBreakRoom" as quarantine_has_break_room,
       q."HasCleaningServices" as quarantine_has_cleaning_service,
       q."HasElectricity" as quarantine_has_electricity,
       q."HasEntertainment" as quarantine_has_entertainment,
       q."HasExamRoom" as quarantine_has_exam_room,
       q."HasFloors" as quarantine_has_floor,
       q."HasFoodService" as quarantine_has_food_service,
       q."HasGarbage" as quarantine_has_garbage,
       q."HasGeneralInfo" as quarantine_has_general_info,
       q."HasHeating" as quarantine_has_heating,
       q."HasInfrastructure" as quarantine_has_infrastructure,
       q."HasInternetService" as quarantine_has_internet_service,
       q."HasLaundryServices" as quarantine_has_laundry_service,
       q."HasLighting" as quarantine_has_lighting,
       q."HasLogisticsMedicine" as quarantine_has_logistic_medicine,
       q."HasMedicalGarbage" as quarantine_has_medical_garbage,
       q."HasMedicalTrashSpace" as quarantine_has_medical_trash_space,
       q."HasOtherServices" as quarantine_has_other_services,
       q."HasPhoneSystem" as quarantine_has_phone_system,
       q."HasRegistrationRoom" as quarantine_has_registration_room,
       q."HasStaffBathroom" as quarantine_has_staff_bathroom,
       q."HasStaffRooms" as quarantine_has_staff_rooms,
       q."HasWaterSanitation" as quarantine_has_water_sanitation,
       q."IsWaterDrinkable" as quarantine_is_water_drinkable,
       case
           WHEN q."Lat" is not NULL THEN q."Lat"
           ELSE 0
       END as quarantine_lat,
       case
           WHEN q."Lng" is not NULL THEN q."Lng"
           ELSE 0
       END as quarantine_lng,
       q."PhoneNumber" as quarantine_phone_number,
       q."ResponsibleName" as quarantine_responsible_name,
       q."ResponsiblePhone" as quarantine_responsible_phone,
       q."ShowerAreaNbr" as quarantine_shower_area_nbr,
       q."ShowerAreas" as quarantine_shower_areas,
       q."WaterSinkNbr" as quarantine_water_sink_nbr,
       q."CREATTION_DATE" as quarantine_creation_date_time,
       q."LAST_MODIF_DATE" as quarantine_last_modify_date_time,
       q."VALIDATION_DATE" as quarantine_validation_date_time,
       et."NAME" as electricity_type_name,
       et."Type" as electricity_type,
       ent."NAME" as entertainment_type_name,
       ent."Type" as entertainment_type,
       vt."NAME" as ventilation_type_name,
       vt."Type" as ventilation_type,
       qws."NAME" as water_source_name,
       qws."Type" as water_source_type,
       qt."NAME" as quarantine_type_name,
       qt."Type" as quarantine_type,
       qst."NAME" as quarantine_sub_type_name,
       qst."Type" as quarantine_sub_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as quarantine_municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as quarantine_municipality_lng,
       USR."NAME" as quarantine_user_name,
       USR."FULL_NAME" as quarantine_user_full_name,
       USR."REF" as quarantine_user_ref,
       GRP."NAME" as quarantine_user_group,
       q."LAST_MODIF_DATE" as quarantine_date_time
from "Quarantine" q
left join "QTElectricityType" et on et."REF" = q."QTElectricityType_REF"
left join "QTEntertainmentType" ent on ent."REF" = q."QTEntertainmentType_REF"
left join "QTVentilationType" vt on vt."REF" = q."QTVentilationType_REF"
left join "QuarantineSubType" qst on qst."REF" = q."QuarantineSubType_REF"
left join "QuarantineType" qt on qt."REF" =q."QuarantineType_REF"
left join "QTWaterSource" qws on qws."REF" = q."WaterSrc_REF"
left join "Kadaa" K on K."REF" = q."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = q."Mouhafaza_REF"
left join "Municipality" M on M."REF" = q."Municipality_REF"
left join "FUSER" USR on USR."REF" = q."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


create VIEW incident_view as
select I."REF" as incident_ref,
       I."Action" as incident_action,
       I."Address" as incident_address,
       I."DOB" as incident_dob,
       I."EmergencyNumber" as incident_emergency_number,
       I."FatherName" as incident_father_name,
       I."FullName" as incident_full_name,
       I."MotherName" as incident_mother_name,
       I."Nationality" as incident_nationality,
       I."People" as incident_people,
       I."PhoneNumber" as incident_phone_number,
       I."Registry" as incident_registry,
       I."RegistryNumber" as incident_registry_number,
       I."SIMULATION" as incident_simulation,
       I."CREATTION_DATE" as incident_creation_date_time,
       I."LAST_MODIF_DATE" as incident_last_modify_date_time,
       I."VALIDATION_DATE" as incident_validation_date_time,
       QT."NAME" as incident_quarantine_type_name,
       QT."Type" as incident_quarantine_type,
       I."QTLocationOther" as incident_quarantine_location,
       I."QTStartDate" as incident_quarantine_start_date,
       I."QTEndDate" as incident_quarantine_end_date,
       H."NAME" as hospital_name,
       H."NAME_AR" as hospital_name_ar,
       H."NAME_EN" as hospital_name_en,
       H."Lat" as hospital_lat,
       H."Lng" as hospital_lng,
       I."Details" as incident_details,
       P."NAME" as incident_place,
       T."NAME" as Incident_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       qv.quarantine_ref,
       qv.quarantine_area_name,
       qv.quarantine_lat,
       qv.quarantine_lng,
       qv.quarantine_responsible_name,
       qv.quarantine_type_name,
       qv.quarantine_type,
       qv.quarantine_sub_type_name,
       qv.quarantine_sub_type,
       qv.kadaa as quarantine_kadaa,
       qv.mouhafaza as quarantine_mouhafaza,
       qv.municipality as quarantine_municipality,
       qv.quarantine_municipality_lat,
       qv.quarantine_municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       I."DATE" as incident_date_time
from "Incident" I
left join "IncidentType" T on T."REF" = I."IncidentType_REF"
left join "IncidentPlace" P on P."REF" = I."IncidentPlace_REF"
left join "Hospital" H on H."REF" = I."Hospital_REF"
left join "QuarantineType" QT on QT."REF" = I."QuarantineType_REF"
left join quarantine_view qv on qv.quarantine_ref = I."Quarantine_REF"
left join "Kadaa" K on K."REF" = I."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = I."Mouhafaza_REF"
left join "Municipality" M on M."REF" = I."Municipality_REF"
left join "FUSER" USR on USR."REF" = I."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view need_view;


create VIEW need_view as
select n."REF" as need_ref,
       n."Details" as need_details,
       n."People" as need_people,
       n."CREATTION_DATE" as need_creation_date_time,
       n."LAST_MODIF_DATE" as need_last_modify_date_time,
       n."VALIDATION_DATE" as need_validation_date_time,
       T."NAME" as need_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       n."DATE" +"NeedTime" as need_date_time
from "Need" n
left join "NeedType" T on T."REF" = n."NeedType_REF"
left join "Kadaa" K on K."REF" = n."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = n."Mouhafaza_REF"
left join "Municipality" M on M."REF" = n."Municipality_REF"
left join "FUSER" USR on USR."REF" = n."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view measure_view ;


create VIEW measure_view as
select me."REF" as measure_ref,
       me."Details" as measure_details,
       me."People" as measure_people,
       me."CREATTION_DATE" as measure_creation_date_time,
       me."LAST_MODIF_DATE" as measure_last_modify_date_time,
       me."VALIDATION_DATE" as measure_validation_date_time,
       mi."NAME" as measure_importance,
       mt."NAME" as measure_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       me."DATE" + me."MeasureTime" as measure_date_time
from "Measure" me
left join "MeasureImportance" mi on me."MeasureImportance_REF" = mi."REF"
left join "MeasureType" mt on me."MeasureType_REF" = mt."REF"
left join "Kadaa" K on K."REF" = me."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = me."Mouhafaza_REF"
left join "Municipality" M on M."REF" = me."Municipality_REF"
left join "FUSER" USR on USR."REF" = me."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view covid_case_view ;


create VIEW covid_case_view as
select cc."REF" as case_ref,
       cc."FullName" as case_full_name,
       cc."Nationality" as case_nationality,
       cc."FatherName" as case_father_name,
       cc."MotherName" as case_mother_name,
       cc."RegistryNumber" as case_registry_number,
       cc."Address" as case_address,
       cc."Address2" as case_second_address,
       cc."MobileNumber" as case_mobile_number,
       cc."HealthSituation" as case_health_situation,
       cc."CaseCurrentAddress" as case_current_address,
       cc."CaseCurrentPlace" as case_current_place,
       cc."CREATTION_DATE" as case_creation_date_time,
       cc."LAST_MODIF_DATE" as case_last_modify_date_time,
       cc."VALIDATION_DATE" as case_validation_date_time,
       cc."Incident_REF" as incident_ref,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       cc."DATE" as covid_case_date_time
from "CovidCase" cc
left join "Kadaa" K on K."REF" = cc."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = cc."Mouhafaza_REF"
left join "Municipality" M on M."REF" = cc."Municipality_REF"
left join "FUSER" USR on USR."REF" = cc."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";

-- sp."Address" as suspect_address,
-- sp."FullName" as suspect_full_name,
-- sp."MobileNumber" as suspect_mobile_number,
-- left join "SuspectedPeople" SP on SP."CovidCase_REF" = cc."REF"

drop view suspected_people_view;


create VIEW suspected_people_view as
select sp."REF" as suspected_people_ref,
       sp."FullName" as suspected_people_full_name,
       sp."MobileNumber" as suspected_people_mobile_number,
       sp."Address" as suspected_people_address,
       cc."FullName" as covid_case_name,
       cc."MobileNumber" as covid_case_mobile_number,
       cc."Address" as covid_case_address,
       m."NAME" as municipality,
       mz."NAME" as mouhafaza,
       k."NAME" as kadaa
from "SuspectedPeople" sp
left join "CovidCase" cc on cc."REF" = sp."CovidCase_REF"
left join "Municipality" m on m."REF" = sp."Municipality_REF"
left join "Kadaa" k on k."REF" = m."Kadaa_REF"
left join "Mouhafaza" mz on mz."REF" = k."Mouhafaza_REF" ;


drop view sponsor_municipality_view;


drop view sponsor_view;


create VIEW sponsor_municipality_view as
select sm."Sponsor_REF" as sponsor_ref,
       array_agg(m."NAME") as municipality
from "SponsorMunicipality" sm
left join "Municipality" m on m."REF" = sm."Municipality_REF"
GROUP BY sm."Sponsor_REF";


create VIEW sponsor_view as
select s."REF" as sponsor_ref,
       s."SponsorName" as sponsor_name,
       s."PhoneNumber" as sponsor_phone_number,
       s."Email" as sponsor_email,
       s."Institution" as sponsor_institution,
       s."FocalPointName" as sponsor_focal_point,
       s."FocalPointPhoneNumber" as sponsor_focal_point_phone_number,
       s."DATE" as sponsor_date,
       l."NAME" laboratory_name,
       smv.municipality
from "Sponsor" s
left join "Laboratory" l on l."REF" = s."Laboratory_REF"
left join sponsor_municipality_view smv on smv.sponsor_ref = s."REF" ;


drop view aid_change_tracking_view;


drop view aid_delivery_view;


drop view mosa_aid_view ;


drop view taxi_driver_view ;


create VIEW taxi_driver_view as
select td."REF" as taxi_driver_ref,
       td."FirstName" as taxi_driver_first_name,
       td."LastName" as taxi_driver_last_name,
       td."FatherName" as taxi_driver_father_name,
       td."MotherName" as taxi_driver_mother_name,
       td."DOB" as taxi_driver_dob,
       td."BirthPlace" as taxi_driver_birth_place,
       td."IdentificationNumber" as taxi_driver_identification_number,
       td."DriverNumber" as taxi_driver_number,
       td."Address" as taxi_driver_address,
       td."MobileNumber" as taxi_driver_mobile_number,
       td."LandlineNumber" as taxi_driver_landline_number,
       td."Registry" as taxi_driver_registry,
       td."RegistryNumber" as taxi_driver_registry_number,
       td."NbrChildren" as taxi_driver_nbr_children,
       td."SocSecNumber" as taxi_driver_soc_sec_number,
       td."LicensePlateNumber" as taxi_driver_license_plate_number,
       td."VehiculeType" as taxi_driver_vehicle_type,
       td."FullName" as taxi_driver_full_name,
       td."VehiculeManufactureDate" as taxi_driver_vehicle_manufacture_date,
       td."LicensePlatePrefix" as taxi_driver_license_plate_prefix,
       td."CREATTION_DATE" as taxi_driver_creation_date_time,
       td."VALIDATION_DATE" as taxi_driver_validation_date_time,
       td."LAST_MODIF_DATE" as taxi_driver_last_modify_date_time,
       s."NAME" as taxi_driver_sector,
       ss."NAME" as taxi_driver_social_status,
       wt."NAME" as taxi_driver_spouse_work_type,
       K."NAME" as taxi_driver_kadaa,
       Z."NAME" as taxi_driver_mouhafaza,
       USR."NAME" as taxi_driver_user_name,
       USR."FULL_NAME" as taxi_driver_user_full_name,
       USR."REF" as taxi_driver_user_ref,
       GRP."NAME" as taxi_driver_user_group
from "TaxiDriver" td
left join "Sector" s on s."REF" = td."Sector_REF"
left join "SocialStatus" ss on ss."REF" = td."SocialeStatus_REF"
left join "WorkType" wt on wt."REF" = td."SpouseWorkType_REF"
left join "Kadaa" K on K."REF" = td."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = td."Mouhafaza_REF"
left join "FUSER" USR on USR."REF" = td."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


create VIEW mosa_aid_view as
select ma."REF" as aid_ref,
       ma."FullName" as aid_full_name,
       ma."FirstName" as aid_first_name,
       ma."LastName" as aid_last_name,
       ma."FatherName" as aid_father_name,
       ma."MotherName" as aid_mother_name,
       ma."DOB" as aid_dob,
       ma."MobileNumber" as aid_mobile_number,
       ma."LandlineNumber" as aid_line_number,
       ma."Address" as aid_address,
       ma."Registry" as aid_registry,
       ma."RegistryNumber" as aid_registry_number,
       ma."HeadOfHouse" as aid_head_of_house,
       ma."PeopleInResidencyCount" as aid_people_in_registry_count,
       ma."NbrChildrenUnder5" as aid_children_nbr_under_5,
       ma."NbrChildrenUnder15" as aid_children_nbr_under_15,
       ma."NbrChildrenUnder18" as aid_children_nbr_under_18,
       ma."Above64" as aid_above_64,
       ma."Above75" as aid_above_75,
       ma."SpecialNeedsNumber" as aid_special_need_nbr,
       ma."FamilyInPublicSector" as aid_family_in_public_sector,
       ma."HouseSpace" as aid_house_space,
       ma."RoomCount" as aid_room_count,
       ma."HasPregnantWoman" as aid_has_pregnant_woman,
       ma."Lng" as aid_longitude,
       ma."Lat" as aid_latitude,
       ma."Multiplication" as rating_multiplication,
       ma."GeoMean" as rating_geo_mean,
       ma."GeoMean100" as rating_geo_mean100,
       ma."Cancelled" as aid_canceled,
       ma."CREATTION_DATE" as aid_creation_date_time,
       ma."LAST_MODIF_DATE" as aid_last_modify_date_time,
       ma."VALIDATION_DATE" as aid_validation_date_time,
       gender."NAME" as aid_gender,
       fr."NAME" as aid_family_relation,
       pt."NAME" as aid_property_type,
       ot."NAME" as aid_ownership_type,
       ss."NAME" as aid_social_status,
       el."NAME" as aid_head_education_level,
       wt."NAME" as aid_work_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       KE."NAME" as kadaa_of_household,
       ZE."NAME" as mouhafaza_of_household,
       ME."NAME" as municipality_of_household,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       it.aid_illness as aid_illness,
       mt.aid_mobility_type as aid_mobility_type,
       ma."DATE" + ma."AidTime" as aid_date_time
from "MosaAid" ma
left join "EducationLevel" el on el."REF" = ma."HeadEducationLevel_REF"
left join "FamilyRelation" fr on fr."REF" = ma."FamilyRelation_REF"
left join "Gender" gender on gender."REF" = ma."Gender_REF"
left join "WorkType" wt on wt."REF" = ma."HeadWorkType_REF"
left join "OwnershipType" ot on ot."REF" = ma."OwnershipType_REF"
left join "PropertyType" pt on pt."REF" = ma."PropertyType_REF"
left join "SocialStatus" ss on ss."REF" = ma."SocialeStatus_REF"
left join "Kadaa" K on K."REF" = ma."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = ma."Mouhafaza_REF"
left join "Municipality" M on M."REF" = ma."Municipality_REF"
left join "Kadaa" KE on KE."REF" = ma."KadaaEntry_REF"
left join "Mouhafaza" ZE on ZE."REF" = ma."MouhafazaEntry_REF"
left join "Municipality" ME on ME."REF" = ma."MunicipalityEntry_REF"
left join "FUSER" USR on USR."REF" = ma."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF"
left join
    (select ma."REF",
            array_agg(mt."NAME") as aid_mobility_type
     from "MosaAid" ma
     left join "Mobility" mb on mb."MosaAid_REF" = ma."REF"
     left join "MobilityType" mt on mt."REF" = mb."MobilityType_REF"
     GROUP BY ma."REF") mt on mt."REF" = ma."REF"
left join
    (select ma."REF",
            array_agg(it."NAME") as aid_illness
     from "MosaAid" ma
     left join "Illness" i on i."MosaAid_REF" = ma."REF"
     left join "IllnessType" it on it."REF" = i."IllnessType_REF"
     GROUP BY ma."REF") it on it."REF" = ma."REF";


drop view mosa_aid_history_view ;


create VIEW mosa_aid_history_view as
select mah."MosaAid_REF" as mosa_aid_ref,
       mah."REF" as aid_history_ref,
       mah."FullName" as aid_history_full_name,
       mah."FirstName" as aid_history_first_name,
       mah."LastName" as aid_history_last_name,
       mah."FatherName" as aid_history_father_name,
       mah."MotherName" as aid_history_mother_name,
       mah."DOB" as aid_history_dob,
       mah."MobileNumber" as aid_history_mobile_number,
       mah."LandlineNumber" as aid_history_line_number,
       mah."Address" as aid_history_address,
       mah."Registry" as aid_history_registry,
       mah."RegistryNumber" as aid_history_registry_number,
       mah."HeadOfHouse" as aid_history_head_of_house,
       mah."PeopleInResidencyCount" as aid_history_people_in_residency_count,
       mah."NbrChildrenUnder5" as aid_history_children_nbr_under_5,
       mah."NbrChildrenUnder18" as aid_history_children_nbr_under_18,
       mah."Above64" as aid_history_above_64,
       mah."Above75" as aid_history_above_75,
       mah."SpecialNeedsNumber" as aid_history_special_need_nbr,
       mah."FamilyInPublicSector" as aid_history_family_in_public_sector,
       mah."HouseSpace" as aid_history_house_space,
       mah."RoomCount" as aid_history_room_count,
       mah."HasPregnantWoman" as aid_history_has_pregnant_woman,
       mah."Lng" as aid_history_longitude,
       mah."Lat" as aid_history_latitude,
       case
           WHEN mah."HistoryStatus" = 0 THEN 'PENDING'
           WHEN mah."HistoryStatus" = 1 THEN 'ACCEPTED'
           WHEN mah."HistoryStatus" = 2 THEN 'REFUSED'
       END as aid_history_status,
       mah."ApprovalDateTime" as approval_date_time,
       gender."NAME" as aid_history_gender,
       fr."NAME" as aid_history_family_relation,
       pt."NAME" as aid_history_property_type,
       ot."NAME" as aid_history_ownership_type,
       ss."NAME" as aid_history_social_status,
       el."NAME" as aid_history_head_education_level,
       wt."NAME" as aid_history_work_type,
       K."NAME" as aid_history_kadaa,
       Z."NAME" as aid_history_mouhafaza,
       M."NAME" as aid_history_municipality,
       KE."NAME" as aid_history_kadaa_of_household,
       ZE."NAME" as aid_history_mouhafaza_of_household,
       ME."NAME" as aid_history_municipality_of_household,
       AUSR."NAME" as approval_user_name,
       AUSR."FULL_NAME" as approval_user_full_name,
       AUSR."REF" as approval_user_ref,
       AGRP."NAME" as approval_user_group,
       MUSR."NAME" as modification_user_name,
       MUSR."FULL_NAME" as modification_user_full_name,
       MUSR."Phone" as modification_user_phone,
       MUSR."REF" as modification_user_ref,
       MGRP."NAME" as modification_user_group,
       it.aid_history_illness as aid_history_illness,
       mt.aid_history_mobility_type as aid_history_mobility_type,
       mah."AidDate" + mah."AidTime" as aid_history_date_time
from "MosaAidHistory" mah
left join "EducationLevel" el on el."REF" = mah."HeadEducationLevel_REF"
left join "FamilyRelation" fr on fr."REF" = mah."FamilyRelation_REF"
left join "Gender" gender on gender."REF" = mah."Gender_REF"
left join "WorkType" wt on wt."REF" = mah."HeadWorkType_REF"
left join "OwnershipType" ot on ot."REF" = mah."OwnershipType_REF"
left join "PropertyType" pt on pt."REF" = mah."PropertyType_REF"
left join "SocialStatus" ss on ss."REF" = mah."SocialeStatus_REF"
left join "Kadaa" K on K."REF" = mah."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = mah."Mouhafaza_REF"
left join "Municipality" M on M."REF" = mah."Municipality_REF"
left join "Kadaa" KE on KE."REF" = mah."KadaaEntry_REF"
left join "Mouhafaza" ZE on ZE."REF" = mah."MouhafazaEntry_REF"
left join "Municipality" ME on ME."REF" = mah."MunicipalityEntry_REF"
left join "FUSER" AUSR on AUSR."REF" = mah."ApprovalUser_REF"
left join "FGROUP" AGRP on AGRP."REF" = AUSR."GRP_REF"
left join "FUSER" MUSR on MUSR."REF" = mah."ModificationUser_REF"
left join "FGROUP" MGRP on MGRP."REF" = MUSR."GRP_REF"
left join
    (select mah."REF",
            array_agg(mt."NAME") as aid_history_mobility_type
     from "MosaAidHistory" mah
     left join "Mobility" mb on mb."MosaAid_REF" = mah."REF"
     left join "MobilityType" mt on mt."REF" = mb."MobilityType_REF"
     GROUP BY mah."REF") mt on mt."REF" = mah."REF"
left join
    (select mah."REF",
            array_agg(it."NAME") as aid_history_illness
     from "MosaAidHistory" mah
     left join "Illness" i on i."MosaAid_REF" = mah."REF"
     left join "IllnessType" it on it."REF" = i."IllnessType_REF"
     GROUP BY mah."REF") it on it."REF" = mah."REF";

--drop view aid_change_tracking_view;
--create VIEW aid_change_tracking_view as
--select *
--5alas to latfrom mosa_aid_view mav
--left join mosa_aid_history_view mahv on mav.aid_ref = mahv.aid_ref;

create VIEW aid_change_tracking_view as
Select *,
       case
           when mav.aid_full_name != mahv.aid_history_full_name then true
       end as changed_aid_full_name,
       case
           when mav.aid_first_name != mahv.aid_history_first_name then true
       end as changed_aid_first_name,
       case
           when mav.aid_last_name != mahv.aid_history_last_name then true
       end as changed_aid_last_name,
       case
           when mav.aid_father_name != mahv.aid_history_father_name then true
       end as changed_aid_father_name,
       case
           when mav.aid_mother_name != mahv.aid_history_mother_name then true
       end as changed_aid_mother_name,
       case
           when mav.aid_dob != mahv.aid_history_dob then true
       end as changed_aid_dob,
       case
           when mav.aid_mobile_number != mahv.aid_history_mobile_number then true
       end as changed_aid_mobile_number,
       case
           when mav.aid_line_number != mahv.aid_history_line_number then true
       end as changed_aid_line_number,
       case
           when mav.aid_address != mahv.aid_history_address then true
       end as changed_aid_address,
       case
           when mav.aid_registry != mahv.aid_history_registry then true
       end as changed_aid_registry,
       case
           when mav.aid_registry_number != mahv.aid_history_registry_number then true
       end as changed_aid_registry_number,
       case
           when mav.aid_head_of_house != mahv.aid_history_head_of_house then true
       end as changed_aid_head_of_house,
       case
           when mav.aid_people_in_registry_count != mahv.aid_history_people_in_residency_count then true
       end as changed_aid_people_in_registry_count,
       case
           when mav.aid_children_nbr_under_5 != mahv.aid_history_children_nbr_under_5 then true
       end as changed_aid_children_nbr_under_5,
       case
           when mav.aid_children_nbr_under_18 != mahv.aid_history_children_nbr_under_18 then true
       end as changed_aid_children_nbr_under_18,
       case
           when mav.aid_above_64 != mahv.aid_history_above_64 then true
       end as changed_aid_above_64,
       case
           when mav.aid_special_need_nbr != mahv.aid_history_special_need_nbr then true
       end as changed_aid_special_need_nbr,
       case
           when mav.aid_family_in_public_sector != mahv.aid_history_family_in_public_sector then true
       end as changed_aid_family_in_public_sector,
       case
           when mav.aid_house_space != mahv.aid_history_house_space then true
       end as changed_aid_house_space,
       case
           when mav.aid_room_count != mahv.aid_history_room_count then true
       end as changed_aid_room_count,
       case
           when mav.aid_has_pregnant_woman != mahv.aid_history_has_pregnant_woman then true
       end as changed_aid_has_pregnant_woman,
       case
           when mav.aid_longitude != mahv.aid_history_longitude then true
       end as changed_aid_longitude,
       case
           when mav.aid_latitude != mahv.aid_history_latitude then true
       end as changed_aid_latitude,
       case
           when mav.aid_gender != mahv.aid_history_gender then true
       end as changed_aid_gender,
       case
           when mav.aid_family_relation != mahv.aid_history_family_relation then true
       end as changed_aid_family_relation,
       case
           when mav.aid_property_type != mahv.aid_history_property_type then true
       end as changed_aid_property_type,
       case
           when mav.aid_ownership_type != mahv.aid_history_ownership_type then true
       end as changed_aid_ownership_type,
       case
           when mav.aid_social_status != mahv.aid_history_social_status then true
       end as changed_aid_social_status,
       case
           when mav.aid_head_education_level != mahv.aid_history_head_education_level then true
       end as changed_aid_head_education_level,
       case
           when mav.aid_work_type != mahv.aid_history_work_type then true
       end as changed_aid_work_type,
       case
           when mav.kadaa != mahv.aid_history_kadaa then true
       end as changed_kadaa,
       case
           when mav.mouhafaza != mahv.aid_history_mouhafaza then true
       end as changed_mouhafaza,
       case
           when mav.municipality != mahv.aid_history_municipality then true
       end as changed_municipality,
       case
           when mav.kadaa_of_household != mahv.aid_history_kadaa_of_household then true
       end as changed_kadaa_of_household,
       case
           when mav.mouhafaza_of_household != mahv.aid_history_mouhafaza_of_household then true
       end as changed_mouhafaza_of_household,
       case
           when mav.municipality_of_household != mahv.aid_history_municipality_of_household then true
       end as changed_municipality_of_household,
       case
           when mav.aid_illness != mahv.aid_history_illness then true
       end as changed_aid_illness,
       case
           when mav.aid_mobility_type != mahv.aid_history_mobility_type then true
       end as changed_aid_mobility_type
from mosa_aid_view mav
Join mosa_aid_history_view mahv on mav.aid_ref = mahv.mosa_aid_ref;

--select *
--from mosa_aid_view
--full outer join mosa_aid_history_view
--    on row(mosa_aid_view) = row(mosa_aid_history_view)

create VIEW aid_delivery_view as
select ad."REF" as aid_delivery_ref,
       ad."ApprovalDate" as aid_delivery_approval_date,
       ad."Lat" as aid_delivery_lat,
       ad."Lng" as aid_delivery_lng,
       ad."RejectionReason" as aid_delivery_rejection_reason,
       dc."NAME" as delivery_campaign_name,
       dc."StartingDate" as delivery_campaign_starting_date,
       dc."ClosingDate" as delivery_campaign_closing_date,
       dc."Closed" as delivery_campaign_closed,
       dr."NAME" as delivery_result_name,
       dr."Acceptance" as delivery_result_acceptance,
       mav.*,
       tdv.*,
       DUSR."NAME" as aid_delivery_user_name,
       DUSR."FULL_NAME" as aid_delivery_user_full_name,
       DUSR."REF" as aid_delivery_user_ref,
       DGRP."NAME" as aid_delivery_user_group,
       USR."NAME" as aid_delivery_creation_user_name,
       USR."FULL_NAME" as aid_delivery_creation_user_full_name,
       USR."REF" as aid_delivery_creation_user_ref,
       GRP."NAME" as aid_delivery_creation_user_group,
       ad."DeliveryDateTime" as aid_delivery_date_time
from "AidDelivery" ad
left join mosa_aid_view mav on mav.aid_ref = ad."MosaAid_REF"
left join taxi_driver_view tdv on tdv.taxi_driver_ref = ad."TaxiDriver_REF"
left join "DeliveryCampaign" dc on dc."REF" = ad."DeliveryCampaign_REF"
left join "DeliveryResult" dr on dr."REF" = ad."DeliveryResult_REF"
left join "FUSER" DUSR on DUSR."REF" = ad."DeliveryUser_REF"
left join "FGROUP" DGRP on DGRP."REF" = DUSR."GRP_REF"
left join "FUSER" USR on USR."REF" = ad."User_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view displaced_report_view;


create VIEW displaced_report_view as
select rr."REF" as displaced_report_ref,
       rr."CampName" as displaced_report_camp_name,
       rr."TentCount" as displaced_report_tent_count,
       rr."TentSize" as displaced_report_tent_size,
       rr."RefugeePerTent" as displaced_report_per_tent,
       rr."Action" as displaced_report_action,
       rr."CasualtyCount" as displaced_report_casualty_count,
       rr."IsolationCount" as displaced_report_isolation_count,
       rr."CREATTION_DATE" as displaced_report_creation_date_time,
       rr."VALIDATION_DATE" as displaced_report_validation_date_time,
       rr."LAST_MODIF_DATE" as displaced_report_last_modify_date_time,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       rr."DATE" + rr."ReportTime" as displaced_report_date_time
from "RefugeeReport" rr
left join "Kadaa" K on K."REF" = rr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = rr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = rr."Municipality_REF"
left join "FUSER" USR on USR."REF" = rr."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view citizen_report_view;


create VIEW citizen_report_view as
select cr."REF" as citizen_report_ref,
       cr."CitizenCount" as citizen_report_count,
       cr."HostpitalisedPositiveCasualtyCount" as citizen_report_hospitalized_positive,
       cr."HomeConfinmentCasualtyCount" as citizen_report_home_confinement,
       cr."HomeTreatmentCasualtyCount" as citizen_report_home_treatment,
       cr."InContactWithCasualtyCount" as citizen_report_contact_with,
       cr."CREATTION_DATE" as citizen_report_creation_date_time,
       cr."LAST_MODIF_DATE" as citizen_report_last_modify_date_time,
       cr."VALIDATION_DATE" as citizen_report_validation_date_time,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       cr."DATE" + cr."ReportTime" as citizen_report_date_time
from "CitizenReport" cr
left join "Kadaa" K on K."REF" = cr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = cr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = cr."Municipality_REF"
left join "FUSER" USR on USR."REF" = cr."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view procedure_report_view;


create VIEW procedure_report_view as
select pr."REF" as procedure_report_ref,
       pr."Procedure" as procedure_report_Procedure,
       pr."SterilizationPlaces" as procedure_report_sterilization_places,
       pr."SterilizationMethods" as procedure_report_sterilization_methods,
       pr."SterilizationProductType" as procedure_report_sterilization_product_type,
       pr."SterilizationProductQuantity" as procedure_report_sterilization_product_quantity,
       pr."SterilizationRepetitionCount" as procedure_report_sterilization_repetition_count,
       pr."ExecutingAgency" as procedure_report_executing_agency,
       pr."CREATTION_DATE" as procedure_report_creation_date_time,
       pr."VALIDATION_DATE" as procedure_report_validation_date_time,
       pr."LAST_MODIF_DATE" as procedure_report_last_modify_date_time,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       pr."DATE" + pr."ReportTime" as procedure_report_date_time
from "ProcedureReport" pr
left join "Kadaa" K on K."REF" = pr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = pr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = pr."Municipality_REF"
left join "FUSER" USR on USR."REF" = pr."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view compliance_report_view;


create VIEW compliance_report_view as
select cr."REF" as compliance_report_ref,
       cr."CircularsReporting" as compliance_report_circulars_reporting,
       cr."HoldCompliance" as compliance_report_hold,
       cr."GroupingCompliance" as compliance_report_grouping,
       cr."SafetyProcedureCompliance" as compliance_report_safety_procedure,
       cr."DisobedientEntity" as compliance_report_disobedient_entity,
       cr."SafetyJeopardisingCases" as compliance_report_safety_jeopardizing_cases,
       cr."CREATTION_DATE" as compliance_report_creation_date_time,
       cr."VALIDATION_DATE" as compliance_report_validation_date_time,
       cr."LAST_MODIF_DATE" as compliance_report_last_modify_date_time,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       cr."DATE" + cr."ReportTime" as compliance_report_date_time
from "ComplianceReport" cr
left join "Kadaa" K on K."REF" = cr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = cr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = cr."Municipality_REF"
left join "FUSER" USR on USR."REF" = cr."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";


drop view situation_report_view;


create VIEW situation_report_view as
select lsr."REF" as situation_report_ref,
       lsr."BasicSupport" as situation_report_basic_support,
       lsr."SupportType" as situation_report_support_type,
       lsr."Receiver" as situation_report_receiver,
       lsr."Quantity" as situation_report_quantity,
       lsr."SupportedEntity" as situation_report_supported_entity,
       lsr."ForeignBenefitedPartyPercentage" as situation_report_foreign_benefited_party_percentage,
       lsr."BenefitedPartyDetails" as situation_report_benefited_party_details,
       lsr."BenefitedPartyCount" as situation_report_benefited_party_count,
       lsr."AssistanceDetails" as situation_report_assistance_details,
       lsr."AssistanceSource" as situation_report_assistance_source,
       lsr."CREATTION_DATE" as situation_report_creation_date_time,
       lsr."VALIDATION_DATE" as situation_report_validation_date_time,
       lsr."LAST_MODIF_DATE" as situation_report_last_modify_date_time,
       bp."NAME" as situation_report_benefited_party_name,
       ast."NAME" as situation_report_assistant_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       lsr."DATE" + lsr."ReportTime" as situation_report_date_time
from "LivingSituationReport" lsr
left join "BenefitedParty" bp on bp."REF" = lsr."BenefitedParty_REF"
left join "AssistanceType" ast on ast."REF" = lsr."AssistanceType_REF"
left join "Kadaa" K on K."REF" = lsr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = lsr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = lsr."Municipality_REF"
left join "FUSER" USR on USR."REF" = lsr."CREATION_USER_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";

