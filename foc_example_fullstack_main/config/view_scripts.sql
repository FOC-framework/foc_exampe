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
       q."Lat" as quarantine_lat,
       q."Lng" as quarantine_lng,
       q."PhoneNumber" as quarantine_phone_number,
       q."ResponsibleName" as quarantine_responsible_name,
       q."ResponsiblePhone" as quarantine_responsible_phone,
       q."ShowerAreaNbr" as quarantine_shower_area_nbr,
       q."ShowerAreas" as quarantine_shower_areas,
       q."WaterSinkNbr" as quarantine_water_sink_nbr,
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
       M."Lat" as quarantine_municipality_lat,
       M."Lng" as quarantine_municipality_lng,
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
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       I."DATE" + "IncidentTime" as incident_date_time
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
       T."NAME" as need_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       mi."NAME" as measure_importance,
       mt."NAME" as measure_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
       USR."NAME" as user_name,
       USR."FULL_NAME" as user_full_name,
       USR."REF" as user_ref,
       GRP."NAME" as user_group,
       cc."DATE" + cc."CovidCaseTime" as covid_case_date_time
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

drop view aid_change_tracking_view;


drop view aid_delivery_view;


drop view mosa_aid_view ;


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
       ma."PeopleInResidencyCount" as aid_people_in_residency_count,
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
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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


drop view hospital_view ;


create VIEW hospital_view as
select h."REF" as hospital_ref,
       h."NAME" as hospital_name,
       h."NAME_AR" as hospital_name_ar,
       h."NAME_EN" as hospital_name_eng,
       h."Email" as hospital_email,
       h."Phone" as hospital_phone,
       h."Fax" as hospital_fax,
       h."Director" as hospital_director,
       h."Address" as hospital_address,
       h."Ownership" as hospital_owner_ship,
       h."NbrMedicineBed" as hospital_nbr_medicine_bed,
       h."NbrSurgeryBed" as hospital_nbr_surgery_bed,
       h."NbrBGYNBed" as hospital_nbr_bgyn_bed,
       h."NbrPediatrics" as hospital_nbr_pediatrics,
       h."NbrICUCCUBed" as hospital_nbr_icuccu_bed,
       h."NbrDoctors" as hospital_nbr_doctors,
       h."NbrNurses" as hospital_nbr_nurses,
       h."Lab" as hospital_lab,
       h."BloodBank" as hospital_blood_bank,
       h."Radiology" as hospital_radiology,
       h."RadioTherapy" as hospital_radio_therapy,
       h."Label" as hospital_label,
       h."Facility" as hospital_facility,
       h."Lat" as hospital_lat,
       h."Lng" as hospital_lng,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza
from "Hospital" h
left join "Kadaa" K on K."REF" = h."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = h."Mouhafaza_REF";


drop view health_care_center_view ;


create VIEW health_care_center_view as
select hcc."REF" as health_care_center_ref,
       hcc."NAME" as health_care_center_name,
       hcc."NAME_AR" as health_care_center_name_ar,
       hcc."NAME_EN" as health_care_center_name_en,
       hcc."Label" as health_care_center_label,
       hcc."Facility" as health_care_center_facility,
       hcc."Lat" as health_care_center_lat,
       hcc."Lng" as health_care_center_lng,
       hcc."Cintid" as health_care_center_cintid,
       hcc."Fid" as health_care_center_fid,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza
from "HealthCareCenter" hcc
left join "Kadaa" K on K."REF" = hcc."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = hcc."Mouhafaza_REF";


drop view municipality_view ;


create VIEW municipality_view as
select m."REF" as municipality_ref,
       m."NAME" as municipality,
       m."NAME_EN" as municipality_name_en,
       m."Phone" as municipality_phone,
       m."Address" as municipality_address,
       case
           WHEN m."Lat" is not NULL THEN m."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN m."Lng" is not NULL THEN m."Lng"
           ELSE 0
       end as municipality_lng,
       m."Pcode" as municipality_pcode,
       m."Elev" as municipality_elev,
       m."Gov_Na" as municipality_gov_na,
       m."Gov_Naa" as municipality_gov_naa,
       m."UN_CODE" as municipality_un_code,
       m."UN_Ar_Ar" as municipality_un_ar_ar,
       m."UN_Area" as municipality_un_area,
       m."CAD_CODE" as municipality_cad_code,
       m."CAD_Type" as municipality_cad_type,
       m."CAS_CODE" as municipality_cas_code,
       m."CAS_N_Ar" as municipality_cas_n_ar,
       m."CAS_NAME" as municipality_cas_name,
       m."UNION_ID" as municipality_union_id,
       m."Union_Full" as municipality_union_full,
       m."UOM_Name" as municipality_uom_name,
       k."NAME" as kadaa,
       k."NAME_EN" as kadaa_en,
       z."NAME" as mouhafaza,
       z."NAME_EN" as mouhafaza_en
from "Municipality" m
left join "Kadaa" K on K."REF" = m."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = k."Mouhafaza_REF" ;


drop view user_view ;


drop view user_activity_view ;


drop view user_multi_municipalities ;


create VIEW user_multi_municipalities as
select UM."FUSER_REF" as user_m_ref,
       array_agg(MU."NAME") as multi_municipalities,
       array_agg(KU."NAME") as multi_kadaa,
       array_agg(ZU."NAME") as multi_mouhafaza
from "UserMunicipality" UM
left join "Municipality" MU on MU."REF"=UM."Municipality_REF"
left Join "Kadaa" KU on KU."REF"= UM."Kadaa_REF"
left join "Mouhafaza" ZU ON ZU."REF"=UM."Mouhafaza_REF"
GROUP BY UM."FUSER_REF";


create VIEW user_view as
select U."REF" as user_ref,
       U."FULL_NAME" as user_full_name,
       U."Phone" as user_phone,
       U."SUSPENDED" as user_suspended,
       U."LegalTermsApproved" as user_legal_terms_approved,
       GRP."NAME" as user_group,
       umm.multi_municipalities,
       umm.multi_mouhafaza,
       umm.multi_kadaa,
       case
           when ZU."NAME" is not null then ZU."NAME"
           when ZM."NAME" is not null then ZM."NAME"
           when ZK."NAME" is not null then ZK."NAME"
           else 'MOI'
       end as "mouhafaza",
       case
           when KU."NAME" is not null then KU."NAME"
           when ZM."NAME" is not null then KM."NAME"
           ELSE 'MOI'
       end as "kadaa",
       MU."NAME" as municipality,
       MU."Lat" as municipality_lat,
       MU."Lng" as municipality_lng
from "FUSER" U
left join user_multi_municipalities umm on umm.user_m_ref = U."REF"
left join "Municipality" MU on MU."REF"=U."Municipality_REF"
left Join "Kadaa" KU on KU."REF"= U."Kadaa_REF"
left join "Mouhafaza" ZU ON ZU."REF"=U."Mouhafaza_REF"
left Join "Kadaa" KM on KM."REF"= MU."Kadaa_REF"
left join "Mouhafaza" ZM ON ZM."REF"=KM."Mouhafaza_REF"
left join "Mouhafaza" ZK ON ZK."REF"=KU."Mouhafaza_REF"
left join "FGROUP" GRP ON GRP."REF"=U."GRP_REF";


create VIEW user_activity_view as
select UA."REF" as activity_ref,
       UA."Activity" as activity,
       case
           WHEN UA."Activity" = 0 THEN 'Login'
           WHEN UA."Activity" = 1 THEN 'Logout'
           WHEN UA."Activity" = 2 THEN 'Creation'
           WHEN UA."Activity" = 3 THEN 'Modification'
           ELSE 'Other'
       END as activity_label,
       UA."Description" as activity_description,
       UA."FormType" as activity_form,
       U."REF" as user_ref,
       U."FULL_NAME" as user_full_name,
       U."Phone" as user_phone,
       U."SUSPENDED" as user_suspended,
       FG."NAME" as group_name,
       umm.multi_municipalities,
       umm.multi_mouhafaza,
       umm.multi_kadaa,
       case
           WHEN ZU."NAME" is not null THEN ZU."NAME"
           WHEN ZM."NAME" is not null THEN ZM."NAME"
           WHEN ZK."NAME" is not null THEN ZK."NAME"
           ELSE 'MOI'
       END as "mouhafaza",
       case
           WHEN KU."NAME" is not null THEN KU."NAME"
           WHEN ZM."NAME" is not null THEN KM."NAME"
           ELSE 'MOI'
       END as "kadaa",
       MU."NAME" as municipality,
       MU."Lat" as municipality_lat,
       MU."Lng" as municipality_lng,
       UA."DateTime" as activity_date_time
from "WSUserActivity" UA
left join "FUSER" U on UA."User_REF" = U."REF"
left join user_multi_municipalities umm on umm.user_m_ref = U."REF"
left join "FGROUP" FG on FG."REF" = U."GRP_REF"
left join "Municipality" MU on MU."REF"=U."Municipality_REF"
left Join "Kadaa" KU on KU."REF"= U."Kadaa_REF"
left join "Mouhafaza" ZU ON ZU."REF"=U."Mouhafaza_REF"
left Join "Kadaa" KM on KM."REF"= MU."Kadaa_REF"
left join "Mouhafaza" ZM ON ZM."REF"=KM."Mouhafaza_REF"
left join "Mouhafaza" ZK ON ZK."REF"=KU."Mouhafaza_REF";


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
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       bp."NAME" as situation_report_benefited_party_name,
       ast."NAME" as situation_report_assistant_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as municipality_lat,
       M."Lng" as municipality_lng,
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
       mah."PeopleInResidencyCount" as aid_history_people_in_registry_count,
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
           when mav.aid_people_in_registry_count != mahv.aid_history_people_in_registry_count then true
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

----------------------QT---------------------------------------------------------

drop view qt_residential_assessment_view ;


drop view qt_person_view ;


drop view qt_break_view;


drop view qt_health_followup_view;


drop view qt_health_followup_symptom_view;


create VIEW qt_health_followup_symptom_view as
select qhf."REF" as qt_health_followup_ref,
       array_agg(qs."NAME") as qt_health_followup_symptom
from "QTHealthFollowup" qhf
left join "QTFollowupSymptom" qfs on qfs."QTHealthFollowup_REF" = qhf."REF"
left join "QTSymptom" qs on qs."REF" = qfs."QTSymptom_REF"
group by qhf."REF";


create VIEW qt_health_followup_view as
select qthfu.qt_health_followup_person_ref,
       array_to_json(array_agg(row_to_json(row(qthfu)))) as qt_health_followup
from
    (select qhf."QTPerson_REF" as qt_health_followup_person_ref,
            qhf."Temprature" as qt_health_followup_temperature,
            qhf."Comment" as qt_health_followup_comment,
            qhf."DateTime" as qt_health_followup_date_time,
            qhfsv.qt_health_followup_symptom,
            USR."NAME" as qt_health_followup_user_name,
            USR."FULL_NAME" as qt_health_followup_user_full_name,
            GRP."NAME" as qt_health_followup_user_group
     from "QTHealthFollowup" qhf
     left join qt_health_followup_symptom_view qhfsv on qhfsv.qt_health_followup_ref = qhf."REF"
     left join "FUSER" USR on USR."REF" = qhf."User_REF"
     left join "FGROUP" GRP on GRP."REF" = USr."GRP_REF") as qthfu
group by qthfu.qt_health_followup_person_ref;


create VIEW qt_break_view as
select qt_break.qt_break_person_ref,
       array_to_json(array_agg(row_to_json(row(qt_break)))) as qt_break
from
    (select qb."REF" as qt_break_ref,
            qb."QTPerson_REF" as qt_break_person_ref,
            qb."DATE" as qt_break_date,
            qb."Comment" as qt_break_comment,
            USR."NAME" as qt_break_user_name,
            USR."FULL_NAME" as qt_break_user_full_name,
            GRP."NAME" as qt_break_user_group
     from "QTBreak" qb
     left join "FUSER" USR on USR."REF" = qb."User_REF"
     left join "FGROUP" GRP on GRP."REF" = USr."GRP_REF") as qt_break
group by qt_break.qt_break_person_ref;


create VIEW qt_residential_assessment_view as
select qa."REF" as qt_residential_assessment_ref,
       qa."HasFamilyMembers" as qt_residential_assessment_has_family_members,
       qa."FamilyMembersNumber" as qt_residential_assessment_family_members_number,
       qa."HasResidenceInfo" as qt_residential_assessment_has_residence_info,
       qa."HasSelfServiceInfo" as qt_residential_assessment_has_self_service_info,
       qa."AlternativeRoomDisinfecting" as qt_residential_assessment_alternative_room_disinfecting,
       qa."AlternativeRoomComments" as qt_residential_assessment_alternative_room_comments,
       qa."AlternativeRoomArrangement" as qt_residential_assessment_alternative_room_arrangements,
       qa."AlternativeRoomHasBalcony" as qt_residential_assessment_alternative_room_has_balcony,
       qa."AlternativeRoomHasBed" as qt_residential_assessment_alternative_room_has_bed,
       qa."AlternativeRoomHasWindow" as qt_residential_assessment_alternative_room_has_window,
       qa."AlternativeRoomHasToilet" as qt_residential_assessment_alternative_room_has_toilet,
       qa."AlternativePhone2" as qt_residential_assessment_alternative_phone_2,
       qa."AlternativePhone1" as qt_residential_assessment_alternative_phone_1,
       qa."RoomDisinfecting" as qt_residential_assessment_room_disinfecting,
       qa."RoomArrangement" as qt_residential_assessment_room_arrangement,
       qa."RoomComments" as qt_residential_assessment_room_comments,
       qa."RoomHasBalcony" as qt_residential_assessment_room_has_balcony,
       qa."RoomHasBed" as qt_residential_assessment_room_has_bed,
       qa."RoomHasWindow" as qt_residential_assessment_room_has_window,
       qa."RoomHasToilet" as qt_residential_assessment_room_has_toilet,
       qa."HasIsotlatedRoom" as qt_residential_assessment_has_isolated_room,
       qa."HasRoomInfo" as qt_residential_assessment_has_room_info,
       qa."ApartmentFloor" as qt_residential_assessment_apartment_floor,
       qa."CanSelfServe" as qt_residential_assessment_can_self_serve,
       qa."SelfServiceAffirmativeComments" as qt_residential_assessment_self_service_affirmative_comments,
       qa."SelfServiceNegationComments" as qt_residential_assessment_self_service_negation_comments,
       qa."HasDailySupport" as qt_residential_assessment_has_daily_support,
       qa."SupporterFullName" as qt_residential_assessment_supporter_full_name,
       qa."SupporterPhoneNumber" as qt_residential_assessment_supporter_phone_number,
       qa."SupporterAddress" as qt_residential_assessment_supporter_address,
       qa."NoSupportComments" as qt_residential_assessment_no_support_comments,
       qa."MinistryApprovalDate" as qt_residential_assessment_ministry_approval_date,
       qa."SocialWorkerApprovalDate" as qt_residential_assessment_social_worker_approval_date,
       qa."AlternativeAddress" as qt_residential_assessment_alternative_address,
       qa."HasAlternativeIsolation" as qt_residential_assessment_has_alternative_isolation,
       qa."HasElevator" as qt_residential_assessment_has_elevator,
       qa."RoomsNumber" as qt_residential_assessment_rooms_number,
       qa."EntranceNumber" as qt_residential_assessment_entrance_number,
       qa."AdditionalRemarks" as qt_residential_assessment_additional_remarks,
       qa."HasGeneralInfo" as qt_residential_assessment_has_general_info,
       qa."QTPerson_REF" as qt_residential_assessment_person_ref,
       fm."NAME" as qt_residential_assessment_support_family_member_name,
       fm."Type" as qt_residential_assessment_support_family_member_type,
       ht."NAME" as qt_residential_assessment_house_type_name,
       ht."Type" as qt_residential_assessment_house_type,
       swa."NAME" as qt_residential_assessment_social_worker_approval_name,
       swa."Type" as qt_residential_assessment_social_worker_approval_type,
       ma."NAME" as qt_residential_assessment_ministry_approval_name,
       ma."Type" as qt_residential_assessment_ministry_approval_type,
       qtat."NAME" as qt_residential_assessment_accommodation_type_name,
       qtat."Type" as qt_residential_assessment_accommodation_type,
       K."NAME" as qt_residential_assessment_alternative_kadaa,
       Z."NAME" as qt_residential_assessment_alternative_mouhafaza,
       M."NAME" as qt_residential_assessment_alternative_municipality,
       M."Lat" as qt_residential_assessment_alternative_municipality_lat,
       M."Lng" as qt_residential_assessment_alternative_municipality_lng,
       USR."NAME" as qt_residential_assessment_user_name,
       USR."FULL_NAME" as qt_residential_assessment_user_full_name,
       USR."REF" as qt_residential_assessment_user_ref,
       GRP."NAME" as qt_residential_assessment_user_group,
       MUSR."NAME" as qt_residential_assessment_ministry_user_name,
       MUSR."FULL_NAME" as qt_residential_assessment_ministry_user_full_name,
       MUSR."REF" as qt_residential_assessment_ministry_user_ref,
       MGRP."NAME" as qt_residential_assessment_ministry_user_group,
       SWUSR."NAME" as qt_residential_assessment_social_worker_user_name,
       SWUSR."FULL_NAME" as qt_residential_assessment_social_worker_user_full_name,
       SWUSR."REF" as qt_residential_assessment_social_worker_user_ref,
       SWGRP."NAME" as qt_residential_assessment_social_worker_user_group
from "QTResidentialAssessment" qa
left join "QTFamilyMember" fm on fm."REF" = qa."SupportFamilyMember_REF"
left join "QTHouseType" ht on ht."REF" =qa."QTHouseType_REF"
left join "QTAccomodationType" qtat on qtat."REF" = qa."QTAccomodationType_REF"
left join "QTResidenceApproval" swa on swa."REF" = qa."SocialWorkerApproval_REF"
left join "QTResidenceApproval" ma on ma."REF" = qa."MinistryApproval_REF"
left join "Kadaa" K on K."REF" = qa."AlternativeKadaa_REF"
left join "Mouhafaza" Z on Z."REF" = qa."AlternativeMouhafaza_REF"
left join "Municipality" M on M."REF" = qa."AlternativeMunicipality_REF"
left join "FUSER" USR on USR."REF" = qa."User_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF"
left join "FUSER" SWUSR on SWUSR."REF" = qa."SocialWorkerUser_REF"
left join "FGROUP" SWGRP on SwGRP."REF" = SWUSR."GRP_REF"
left join "FUSER" MUSR on MUSR."REF" = qa."MinistryUser_REF"
left join "FGROUP" MGRP on MGRP."REF" = MUSR."GRP_REF";


create VIEW qt_person_view as
select q."REF" as qt_person_ref,
       q."FirstName" as qt_person_first_name,
       q."FatherName" as qt_person_father_name,
       q."LastName" as qt_person_last_name,
       q."MotherName" as qt_person_mother_name,
       q."Nationality" as qt_person_nationality,
       q."DOB" as qt_person_dob,
       q."Registry" as qt_person_registry,
       q."RegistryNumber" as qt_person_registry_number,
       q."Address" as qt_person_address,
       q."LandlineNumber" as qt_person_land_line_number,
       q."MobileNumber" as qt_person_mobile_number,
       q."EmergencyNumber" as qt_person_emergency_number,
       q."QTStartDate" as qt_person_start_date,
       q."QTEndDate" as qt_person_end_date,
       q."QTReason" as qt_person_reason,
       q."ContactedPeopleNumber" as qt_person_contacted_people_number,
       q."FirstSymptomDate" as qt_person_first_symptom_date,
       q."QTNoSymptomsStartDate" as qt_person_no_symptom_start_date,
       q."ExamDate" as qt_person_exam_date,
       q."CreationDateTime" as qt_person_creation_date,
       qtg."NAME" as qt_gender_name,
       qtg."Type" as qt_gender_type,
       qt."NAME" as qt_type_name,
       qt."Type" as qt_type,
       qtms."NAME" as qt_martial_status,
       qtctr."NAME" as qt_covid_test_result_name,
       qtctr."Type" as qt_covid_test_result_type,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."Lat" as qt_person_municipality_lat,
       M."Lng" as qt_person_municipality_lng,
       to_json(qbv.qt_break)::text as qt_break,
       to_json(qthfv.qt_health_followup)::text as qt_health_followup,
       USR."NAME" as qt_person_user_name,
       USR."FULL_NAME" as qt_person_user_full_name,
       USR."REF" as qt_person_user_ref,
       GRP."NAME" as qt_person_user_group,
       qrav.*
from "QTPerson" q
left join qt_health_followup_view qthfv on qthfv.qt_health_followup_person_ref = q."REF"
left join qt_break_view qbv on qbv.qt_break_person_ref = q."REF"
left join qt_residential_assessment_view qrav on qrav.qt_residential_assessment_person_ref = q."REF"
left join "QTGender" qtg on qtg."REF" = q."QTGender_REF"
left join "QuarantineType" qt on qt."REF" = q."QuarantineType_REF"
left join "QTMaritalStatus" qtms on qtms."REF" = q."QTMaritalStatus_REF"
left join "QTCovidTestResult" qtctr ON qtctr."REF" =q."QTCovidTestResult_REF"
left join "Kadaa" K on K."REF" = q."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = q."Mouhafaza_REF"
left join "Municipality" M on M."REF" = q."Municipality_REF"
left join "FUSER" USR on USR."REF" = q."CreationUser_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";

