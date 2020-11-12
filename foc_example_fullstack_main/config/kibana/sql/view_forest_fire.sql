drop view forest_fire_view;


drop view forest_fire_fighting_tool_view;


drop view forest_water_source_view;


drop view forest_fire_supporting_party_view;


drop view forest_personal_protection_tool_view;


create VIEW forest_fire_view as
select ff."REF" as forest_fire_ref,
       ff."HasForestInfo" as forest_fire_has_info,
       ff."WalkWaysLength" as forest_fire_walk_ways_length,
       ff."HasLocationInfo" as forest_fire_has_location_info,
       ff."HasSupportInfo" as forest_fire_has_support_info,
       ff."HasToolsInfo" as forest_fire_has_tools_info,
       ff."HasRoadsInfo" as forest_fire_has_road_info,
       ff."HasEquipmentInfo" as forest_fire_has_equipment_info,
       ff."HasWaterSourcesInfo" as forest_fire_has_water_sources_info,
       ff."TrainedVolunteersNumber" as forest_fire_trained_volunteers_number,
       ff."VolunteersNumber" as forest_fire_volunteers_number,
       ff."TrainedOfficersNumber" as forest_fire_trained_officers_number,
       ff."OfficersNumber" as forest_fire_offices_number,
       ff."WaterHosesLength" as forest_fire_water_hoses_length,
       ff."WaterHoesNumber" as forest_fire_water_hoses_number,
       ff."VehicleWaterCapacity" as forest_fire_vehicle_water_capacity,
       ff."FourByFourVehicle" as forest_fire_four_by_four_vehicle,
       ff."RoadMachineryType" as forest_fire_road_machinery_type,
       ff."RoadsMachineryNumber" as forest_fire_roads_machinery_number,
       ff."WaterTanksCapacity" as forest_fire_water_tanks_capacity,
       ff."WaterTanksNumber" as forest_fire_water_tanks_number,
       ff."RiversNumber" as forest_fire_rivers_number,
       ff."OtherForestActivity" as forest_fire_other_forest_activity,
       ff."OtherForestType" as forest_fire_other_forest_type,
       ff."ForestsArea" as forest_fire_forest_area,
       ff."AdjacentAgriculturalRoadsLength" as forest_fire_adjacent_agricultural_roads_length,
       ff."AdjacentSubRoadsLength" as forest_fire_adjacent_sub_roads_length,
       ff."AdjacentMainRoadsLength" as forest_fire_adjacent_main_roads_length,
       ff."DATE" + ff."ForestFireTime" as forest_fire_date_time,
       ft."NAME" as forest_type_name,
       ft."Type" as forest_type,
       rt."NAME" as river_type_name,
       rt."Type" as river_type,
       rmo."Type" as road_machinery_ownership_type,
       rmo."NAME" as road_machinery_ownership_name,
       fa."NAME" as forest_activity_name,
       fa."Type" as forest_activity_type,
       eo."NAME" as water_tanks_ownership_name,
       eo."Type" as water_tanks_ownership_type,
       ud."NAME" as urban_distribution_name,
       ud."Type" as urban_distribution_type,
       als."NAME" as agricultural_land_site_name,
       als."Type" as agricultural_land_site_type,
       wwc."NAME" as walk_ways_cleaning_name,
       wwc."Type" as walk_ways_cleaning_type,
       aarc."NAME" as adjacent_agricultural_road_cleaning_name,
       aarc."Type" as adjacent_agricultural_road_cleaning_type,
       asrc."NAME" as adjacent_sub_road_cleaning_name,
       asrc."Type" as adjacent_sub_road_cleaning_type,
       amrc."NAME" as adjacent_main_road_cleaning_name,
       amrc."Type" as adjacent_main_road_cleaning_type,
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
       end as municipality_lng
from "ForestFire" ff
left join "ForestType" ft on ft."REF" = ff."ForestType_REF"
left join "RiverType" rt on rt."REF" = ff."RiverType_REF"
left join "RoadMachineryOwnership" rmo on rmo."REF" = ff."RoadMachineryOwnership_REF"
left join "ForestActivity" fa on fa."REF" = ff."ForestActivity_REF"
left join "EquipmentOwnership" eo on eo."REF" = ff."WaterTanksOwnership_REF"
left join "ForestAdjacency" ud on ud."REF" = ff."UrbanDistribution_REF"
left join "ForestAdjacency" als on als."REF" = ff."AgriculturalLandSite_REF"
left join "CleaningFrequency" wwc on wwc."REF" = ff."WalkWaysCleaning_REF"
left join "CleaningFrequency" aarc on aarc."REF" = ff."AdjacentAgriculturalRoadsCleaning_REF"
left join "CleaningFrequency" asrc on asrc."REF" = ff."AdjacentSubRoadsCleaning_REF"
left join "CleaningFrequency" amrc on amrc."REF" = ff."AdjacentMainRoadsCleaning_REF"
left join "Kadaa" K on K."REF" = ff."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = ff."Mouhafaza_REF"
left join "Municipality" M on M."REF" = ff."Municipality_REF" ;


create VIEW forest_fire_fighting_tool_view as
select ff."REF" as forest_fire_ref,
       ffft."REF" as forest_fire_fighting_tool_ref,
       ffft."ReadinessLevel" as forest_fire_fighting_tool_readiness_level,
       ffft."OtherFireFightingTool" as forest_fire_fighting_tool_other,
       ffft."Number" as forest_fire_fighting_tool_number,
       fft."NAME" as fire_fighting_tool_name,
       fft."Type" as fire_fighting_tool_type
from "ForestFireFightingTool" ffft
left join "FireFightingTool" fft on fft."REF" = ffft."FireFightingTool_REF"
left join "ForestFire" ff on ff."REF" = ffft."ForestFire_REF" ;


create VIEW forest_water_source_view as
select ff."REF" as forest_fire_ref,
       fws."REF" as forest_water_source_ref,
       fws."PrivateWaterOwner" as forest_water_source_private_water_owner,
       fws."WaterSourceAddress" as forest_water_source_water_source_address,
       fws."Latitude" as forest_water_source_latitude,
       fws."Longitude" as forest_water_source_longitude,
       fws."SummerWateringCapacity" as forest_water_source_summer_watering_capacity,
       fws."Location" as forest_water_source_location,
       ws."NAME" as water_source_name,
       ws."Type" as water_source_type,
       wo."NAME" as water_ownership_name,
       wo."Type" as water_ownership_type
from "ForestWaterSource" fws
left join "WaterSource" ws on ws."REF" = fws."WaterSource_REF"
left join "WaterOwnership" wo on wo."REF" = fws."WaterOwnership_REF"
left join "ForestFire" ff on ff."REF" = fws."ForestFire_REF" ;


create VIEW forest_fire_supporting_party_view as
select ff."REF" as forest_fire_ref,
       ffsp."REF" as forest_fire_supporting_party_ref,
       ffsp."PartyName" as forest_fire_supporting_party_name,
       ffsp."SupportType" as forest_fire_supporting_party_support_type,
       ffsp."Year" as forest_fire_supporting_party_year,
       ffsp."FocalPointName" as forest_fire_supporting_party_focal_point_name,
       ffsp."Position" as forest_fire_supporting_party_position,
       ffsp."PhoneNumber" as forest_fire_supporting_party_phone_number,
       ffsp."SupportAmount" as forest_fire_supporting_party_support_amount,
       ffsp."OtherSupportType" as forest_fire_supporting_party_other_support_type,
       spt."NAME" as party_type_name,
       spt."Type" as party_type
from "ForestFireSupportingParty" ffsp
left join "SupportingPartyType" spt on spt."REF" = ffsp."PartyType_REF"
left join "ForestFire" ff on ff."REF" = ffsp."ForestFire_REF" ;


create VIEW forest_personal_protection_tool_view as
select ff."REF" as forest_fire_ref,
       fppt."REF" as forest_personal_protection_tool_ref,
       fppt."OtherPersonalProtectionTool" as forest_personal_protection_tool_other,
       fppt."ReadinessLevel" as forest_personal_protection_tool_readiness_level,
       fppt."Number" as forest_personal_protection_tool_number,
       ppt."NAME" as personal_protection_tool_name,
       ppt."Type" as personal_protection_tool_type
from "ForestPersonalProtectionTool" fppt
left join "PersonalProtectionTool" ppt on ppt."REF" = fppt."PersonalProtectionTool_REF"
left join "ForestFire" ff on ff."REF" = fppt."ForestFire_REF" ;


drop view forest_fire_risk_view;


create VIEW forest_fire_risk_view as
select ffr."REF" as forest_fire_risk_ref,
       ffr."RiskToday" as forest_fire_risk_today,
       ffr."Risk24Hr" as forest_fire_risk_24_hr,
       ffr."Risk48Hr" as forest_fire_risk_48_hr,
       ffr."DateTime" as forest_fire_risk_date_time,
       ffr."MouhafazaText" as forest_fire_risk_mouhafaza_text,
       ffr."KadaaText" as forest_fire_risk_kadaa_text,
       ffr."TownText" as forest_fire_risk_town_text,
       ffr."TownCode" as forest_fire_risk_town_code,
       ffrr."CreationDateTime" as forest_fire_risk_report_creation_date_time,
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
       t."NAME" as town
from "ForestFireRisk" ffr
left join "ForestFireRiskReport" ffrr on ffrr."REF" = ffr."ForestFireRiskReport_REF"
left join "Kadaa" K on K."REF" = ffr."Kadaa_REF"
left join "Mouhafaza" Z on Z."REF" = ffr."Mouhafaza_REF"
left join "Municipality" M on M."REF" = ffr."Municipality_REF"
left join "Town" t on t."REF" = ffr."Town_REF" ;

