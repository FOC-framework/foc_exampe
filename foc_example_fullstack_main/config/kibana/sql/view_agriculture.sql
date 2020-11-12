drop view agricultural_property_view ;


drop view agricultural_property_exploitation_view ;


drop view property_animal_exploitation_view ;


drop view property_vegetarian_exploitation_view ;


drop view public_institution_view ;


create VIEW public_institution_view as
select pinst."REF" as public_institution_ref,
       pinst."NAME" as public_institution_name,
       pit."Type" as public_institution_type,
       pip."NAME" as public_institution_father_name
from "PublicInstitution" pinst
left join "PublicInstitutionType" pit ON pit."REF" = pinst."PublicInstitutionType_REF"
left join "PublicInstitution" pip on pip."REF" = pinst."FATHERNODE_REF" ;


create VIEW agricultural_property_exploitation_view as
select ape."AgriculturalProperty_REF" as agricultural_property_ref,
       array_agg(pe."NAME") as agricultural_property_exploitation
from "AgriculturalPropertyExploitation" ape
left join "PropertyExploitation" pe ON pe."REF" = ape."PropertyExploitation_REF"
GROUP BY ape."AgriculturalProperty_REF" ;


create VIEW property_animal_exploitation_view as
select pae."AgriculturalProperty_REF" as agricultural_property_ref,
       array_agg(ae."NAME") as animal_exploitation
from "PropertyAnimalExploitation" pae
left join "AnimalExploitation" ae ON ae."REF" = pae."AnimalExploitation_REF"
GROUP BY pae."AgriculturalProperty_REF" ;


create VIEW property_vegetarian_exploitation_view as
select pve."AgriculturalProperty_REF" as agricultural_property_ref,
       array_agg(ve."NAME") as vegetarian_exploitation
from "PropertyVegeterianExploitation" pve
left join "VegeterianExploitation" ve ON ve."REF" = pve."VegeterianExploitation_REF"
GROUP BY pve."AgriculturalProperty_REF" ;


create VIEW agricultural_property_view as
select ap."REF" as agricultural_property_ref,
       ap."PropertyNumber" as agricultural_property_number,
       ap."PropertyArea" as agricultural_property_area,
       ap."UnExploitationReason" as agricultural_property_un_exploitation_reason,
       ap."PropertyApproximateArea" as agricultural_property_approximate_area,
       ap."IndividualOwner" as agricultural_property_individual_owner,
       ap."PaternershipName" as agricultural_property_partnership_name,
       ap."CompanyName" as agricultural_property_company_name,
       ap."CooperativeName" as agricultural_property_cooperative_name,
       ap."CollectiveName" as agricultural_property_collective_name,
       ap."OtherOwnership" as agricultural_property_other_owner_ship,
       ap."MunicipalityName" as agricultural_property_municipality_name,
       ap."OtherAnimalExploitation" as agricultural_property_other_animal_exploitation,
       ap."OtherPropertyUtilization" as agricultural_property_other_property_utilization,
       ap."DATE" as agricultural_property_date,
       ap."CreationDateTime" as agricultural_property_creation_date_time,
       pu."NAME" as property_utilization,
       pu."Type" as property_utilization_type,
       po."NAME" as property_ownership,
       po."Type" as property_ownership_type,
       pc."NAME" as property_commons,
       pc."Type" as property_commons_type,
       ps."NAME" as property_survey,
       ps."Type" as property_survey_type,
       pcl."NAME" as property_classification,
       pcl."Type" as property_classification_type,
       pe."NAME" as property_exploitation,
       pe."Type" as property_exploitation_type,
       aep."NAME" as agricultural_exploitation_percent,
       aep."Type" as agricultural_exploitation_percent_type,
       anep."NAME" as animal_exploitation_percent,
       anep."Type" as animal_exploitation_percent_type,
       pwa."NAME" as property_water_availability,
       pwa."Type" as property_water_availability_type,
       piv.public_institution_name,
       mv.public_institution_name as ministry_name,
       apev.agricultural_property_exploitation,
       pvev.vegetarian_exploitation,
       paev.animal_exploitation,
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
       GRP."NAME" as user_group
from "AgriculturalProperty" ap
left join "PropertyUtilization" pu on pu."REF" = ap."PropertyUtilization_REF"
left join "PropertyOwnership" po on po."REF" = ap."PropertyOwnership_REF"
left join "PropertyCommons" pc on pc."REF" = ap."PropertyCommons_REF"
left join "PropertySurvey" ps ON ps."REF" = ap."PropertySurvey_REF"
left join "PropertyClassification" pcl on pcl."REF" = ap."PropertyClassification_REF"
left join "PropertyExploitation" pe on pe."REF" = ap."PropertyExploitation_REF"
left join "ExploitationPercentage" aep on aep."REF" = ap."AgriculturalExploitationPercent_REF"
left join "ExploitationPercentage" anep on anep."REF" = ap."AnimalExploitationPercent_REF"
left join "PropertyWaterAvailability" pwa on pwa."REF" = ap."PropertyWaterAvailability_REF"
left join public_institution_view piv on piv.public_institution_ref = ap."Institution_REF"
left join public_institution_view mv on mv.public_institution_ref = ap."Ministry_REF"
left join agricultural_property_exploitation_view apev on apev.agricultural_property_ref = ap."REF"
left join property_vegetarian_exploitation_view pvev on pvev.agricultural_property_ref = ap."REF"
left join property_animal_exploitation_view paev on paev.agricultural_property_ref = ap."REF"
left join "Kadaa" K on K."REF" = ap."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = ap."Mouhafaza_REF"
left join "Municipality" M on M."REF" = ap."Municipality_REF"
left join "FUSER" USR on USR."REF" = ap."CreationUser_REF"
left join "FGROUP" GRP on GRP."REF" = USR."GRP_REF";

