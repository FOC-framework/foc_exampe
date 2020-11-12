drop view qt_contacted_person_view;


drop view qt_person_view ;


drop view qt_health_followup_view;


drop view qt_health_followup_symptom_view;


drop view qt_residential_assessment_view ;


drop view qt_break_view;


drop view qt_person_flow_view;


drop view qt_person_municipality_state_view;


create VIEW qt_person_flow_view as
select qf."QTPerson_REF" as qt_person_flow_ref,
       qf."DATE" as qt_person_flow_date,
       q."NAME" as qt_person_flow_state,
       qr."NAME" as qt_person_flow_state_reason,
       m."NAME" as qt_person_flow_municipality,
       USR."NAME" as qt_person_flow_user_name,
       USR."FULL_NAME" as qt_person_flow_user_full_name,
       USR."REF" as qt_person_flow_user_ref,
       GRP."NAME" as qt_person_flow_user_group
from "QTPersonFlow" qf
join
    (select max(a."REF") as flow_ref
     from "QTPersonFlow" a
     group by a."QTPerson_REF") a on a.flow_ref =qf."REF"
left join "QTStateReason" qr on qr."REF" = qf."StateReason_REF"
left join "QTState" q on q."REF" = qf."State_REF"
left join "Municipality" m on m."REF" = qf."Municipality_REF"
left join "FUSER" USR on USR."REF" = qf."User_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF"
where qf."QTPerson_REF" is not null;


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
       q."QTEndDate" as qt_person_end_date,
       q."QTReason" as qt_person_reason,
       q."ContactedPeopleNumber" as qt_person_contacted_people_number,
       q."FirstSymptomDate" as qt_person_first_symptom_date,
       q."QTNoSymptomsStartDate" as qt_person_no_symptom_start_date,
       q."Device" as qt_person_device,
       q."DeviceOS" as qt_person_device_os,
       q."DeviceOSVersion" as qt_person_device_os_version,
       q."DeviceType" as qt_person_device_type,
       q."MobileAppLoginDateTime" as qt_person_mobile_login_date_time,
       q."ArrivingDate" + q."ArrivingTime" as qt_person_arriving_date_time,
       q."ArrivingFrom" as qt_person_arriving_from,
       q."LeftQuarantine" as qt_person_left_quarantine,
       q."LeftQuarantineDateTime" as qt_person_left_quarantine_date_time,
       q."EndQuarantine" as qt_person_end_quarantine,
       q."VerificationCode" as qt_person_verification_code,
       q."ShowLabCreatedPerson" as qt_person_show_lab_created_person,
       q."LabCode" as qt_person_lab_code,
       q."IsDuplicate" as qt_person_is_duplicated,
       q."LabCodeValidated" as qt_person_lab_code_validated,
       q."HasLabResultInfo" as qt_person_has_lab_result_info,
       q."HasLabDetailsInfo" as qt_person_has_lab_details_info,
       q."GeneratedCode" as qt_person_generated_code,
       q."ValidatedCode" as qt_person_validated_code,
       q."QuarantineLocation" as qt_person_quarantine_location,
       q."LabSpecialist" as qt_person_lab_specialist,
       q."SampleDate" as qt_person_sample_date,
       q."HasSpecificMedication" as qt_person_has_specific_medication,
       q."SpecificMedicationName" as qt_person_specific_medication_name,
       q."ChronicDiseaseName" as qt_person_chronic_disease_name,
       q."HasChronicDisease" as qt_person_has_chronic_disease,
       q."HomeQuarantineCommitment" as qt_person_home_quarantine_commitment,
       q."FamilyMembersNbr" as qt_person_family_members_nbr,
       q."PreviousCovidExam" as qt_person_previous_covid_exam,
       q."TokenGenerated" as qt_person_token_generated,
       q."KadaaText" as qt_person_kadaa_text,
       q."FlightNumber" as qt_person_flight_number,
       q."MunicipalityText" as qt_person_municipality_text,
       q."MinistryObjectId" as qt_person_ministry_object_id,
       q."FlightName" as qt_person_flight_name,
       q."ReturnedFromTravel" as qt_person_returned_from_travel,
       l."NAME" as laboratory_name,
       q."CreationDateTime" as qt_person_creation_date,
       q."Incident_REF" as incident_ref,
       q."ChangeMunicipalityRequested" as qt_person_change_municipality_requested,
       CASE
           when q."ExamDate" is not null then q."ExamDate"
           else q."QTStartDate"
       END as qt_person_exam_date,
       q."QTStartDate" as qt_person_start_date,
       ps."NAME" as qt_person_police_station,
       qtg."NAME" as qt_gender_name,
       qtg."Type" as qt_gender_type,
       qt."NAME" as qt_type_name,
       qt."Type" as qt_type,
       qtms."NAME" as qt_martial_status,
       qtctr."NAME" as qt_covid_test_result_name,
       qtctr."Type" as qt_covid_test_result_type,
       qK."NAME" as quarantine_kadaa,
       qM."NAME" as quarantine_municipality,
       K."NAME" as kadaa,
       Z."NAME" as mouhafaza,
       M."NAME" as municipality,
       M."CAS_CODE" as cas_code,
       newm."NAME" as pending_municipality,
       case
           WHEN M."Lat" is not NULL THEN M."Lat"
           ELSE 0
       END as qt_person_municipality_lat,
       case
           WHEN M."Lng" is not NULL THEN M."Lng"
           ELSE 0
       end as qt_person_municipality_lng,
       case
           WHEN q."QuarantineLat" is not NULL THEN q."QuarantineLat"
           ELSE 0
       END as qt_person_quarantine_lat,
       case
           WHEN q."QuarantineLng" is not NULL THEN q."QuarantineLng"
           ELSE 0
       end as qt_person_quarantine_lng,
       to_json(qbv.qt_break)::text as qt_break,
       to_json(qthfv.qt_health_followup)::text as qt_health_followup,
       USR."NAME" as qt_person_user_name,
       USR."FULL_NAME" as qt_person_user_full_name,
       USR."REF" as qt_person_user_ref,
       GRP."NAME" as qt_person_user_group,
       qrav.*,
       qpfv.*
from "QTPerson" q
left join qt_health_followup_view qthfv on qthfv.qt_health_followup_person_ref = q."REF"
left join qt_break_view qbv on qbv.qt_break_person_ref = q."REF"
left join qt_residential_assessment_view qrav on qrav.qt_residential_assessment_person_ref = q."REF"
left join qt_person_flow_view qpfv on qpfv.qt_person_flow_ref = q."REF"
left join "QTGender" qtg on qtg."REF" = q."QTGender_REF"
left join "QuarantineType" qt on qt."REF" = q."QuarantineType_REF"
left join "QTMaritalStatus" qtms on qtms."REF" = q."QTMaritalStatus_REF"
left join "QTCovidTestResult" qtctr ON qtctr."REF" =q."QTCovidTestResult_REF"
left join "PoliceStation" ps on ps."REF" = q."PoliceStation_REF"
left join "Laboratory" l on l."REF" = q."Laboratory_REF"
left join "Kadaa" K on K."REF" = q."Kadaa_REF"
left join "Kadaa" qK on qK."REF" = q."QuarantineKadaa_REF"
left join "Mouhafaza" Z on Z."REF" = q."Mouhafaza_REF"
left join "Municipality" M on M."REF" = q."Municipality_REF"
left join "Municipality" newM on newM."REF" = q."NewMunicipality_REF"
left join "Municipality" qM on qM."REF" = q."QuarantineMunicipality_REF"
left join "FUSER" USR on USR."REF" = q."CreationUser_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF"
order by q."REF" desc,
         qpfv.qt_person_flow_ref desc;


create VIEW qt_contacted_person_view as
select qp."REF" as qt_contacted_person_ref,
       qp."FullName" as qt_contacted_person_full_name,
       qp."Phone" as qt_contacted_person_phone,
       qpv.qt_person_ref,
       qpv.qt_person_first_name,
       qpv.qt_person_last_name,
       qpv.qt_person_nationality,
       qpv.qt_person_dob,
       qpv.qt_person_land_line_number,
       qpv.qt_person_mobile_number,
       qpv.qt_person_emergency_number
from "QTContactedPerson" qp
left join qt_person_view qpv on qpv.qt_person_ref = qp."QTPerson_REF";


create VIEW qt_person_municipality_state_view as
select s."REF" as municipality_change_state_ref,
       s."DATE" as municipality_change_state_date,
       s."State" as municipality_change_state,
       s."Type" as municipality_change_type,
       om."NAME" as municipality,
       om."CAS_CODE" as cas_code,
       nm."NAME" as new_municipality,
       nm."CAS_CODE" as new_municipality_cas_code,
       u."REF" as user_ref,
       u."NAME" as user_name,
       u."FULL_NAME" as user_full_name,
       u."Phone" as user_phone,
       u."HumanResource" as user_human_resource,
       um."NAME" as user_municipality,
       p."FirstName" as qt_person_first_name,
       p."LastName" as qt_person_last_name,
       p."FatherName" as qt_person_father_name,
       p."MotherName" as qt_person_mother_name,
       p."MobileNumber" as qt_person_mobile
from "QTPersonMunicipalityState" s
left join "QTPerson" p on p."REF" = s."QTPerson_REF"
left join "Municipality" om on om."REF" = s."Municipality_REF"
left join "Municipality" nm on nm."REF" = s."NewMunicipality_REF"
left join "FUSER" u on u."REF" = s."User_REF"
left join "FGROUP" g on g."REF" = u."GRP_REF"
left join "Municipality" um on um."REF" = u."Municipality_REF" ;