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


drop view user_multi_municipalities_view;


create VIEW user_multi_municipalities_view as
select um."REF" as user_municipality_ref,
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
       usr."REF" as user_ref,
       usr."FULL_NAME" as user_full_name,
       usr."NAME" as user_name,
       usr."Phone" as user_phone,
       usr."SUSPENDED" as user_suspended,
       usr."LegalTermsApproved" as user_legal_terms_approved,
       grp."NAME" as user_group
from "UserMunicipality" um
left join "Municipality" MU on MU."REF"=um."Municipality_REF"
left Join "Kadaa" KU on KU."REF"= um."Kadaa_REF"
left join "Mouhafaza" ZU ON ZU."REF"=um."Mouhafaza_REF"
left Join "Kadaa" KM on KM."REF"= MU."Kadaa_REF"
left join "Mouhafaza" ZM ON ZM."REF"=KM."Mouhafaza_REF"
left join "Mouhafaza" ZK on ZK."REF"=KU."Mouhafaza_REF"
left join "FUSER" usr on usr."REF" = um."FUSER_REF"
left join "FGROUP" grp on grp."REF" = usr."GRP_REF";


drop view user_view ;


drop view user_activity_view ;


create VIEW user_view as
select U."REF" as user_ref,
       U."FULL_NAME" as user_full_name,
       U."NAME" as user_name,
       U."Phone" as user_phone,
       U."SUSPENDED" as user_suspended,
       U."LegalTermsApproved" as user_legal_terms_approved,
       GRP."NAME" as user_group,
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
       UA."FormRef" as activity_form_ref,
       U."REF" as user_ref,
       U."NAME" as user_name,
       U."FULL_NAME" as user_full_name,
       U."Phone" as user_phone,
       U."SUSPENDED" as user_suspended,
       FG."NAME" as user_group,
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
       case
           WHEN MU."Lat" is not NULL THEN MU."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN MU."Lng" is not NULL THEN MU."Lng"
           ELSE 0
       end as municipality_lng,
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


drop view town_view ;


create VIEW town_view as
select town."REF" as town_ref,
       town."NAME" as town_name,
       town."CAS_CODE" as town_cas_code,
       town."CAD_CODE" as town_cad_code,
       town."NAME_EN" as town_name_en,
       K."NAME" as kadaa,
       M."NAME" as municipality
from "Town" town
left join "Municipality" M on M."REF"= town."Municipality_REF"
left Join "Kadaa" K on K."REF"= town."Kadaa_REF" ;


select ug."REF" as user_group_ref,
       ug."NAME" as user_group,
       mr."MENU_CUSTOM_TITLE" as menu_rights_title,
       mr."ALLOW" as menu_rights_allow,
       gvr."VIEW_CONTEXT" as group_view_rights,
       gvr."ALLOW" as group_view_rights_allow,
       iag."ACCESS_MAIN_LISTS",
       iag."ACCESS_PRIVATE_ONLY"
from "FGROUP" ug
left join "MENU_RIGHTS" mr on mr."FOC_GROUP_REF" = ug."REF"
left join "GROUP_VIEW_RIGHTS" gvr on gvr."FOC_GROUP_REF" = ug."REF"
left join "IncidentAppGroup" iag on iag."FGRP_REF" = ug."REF" ;

