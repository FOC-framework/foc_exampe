drop view development_municipality_view;


drop view chronic_disease_view;


drop view drink_water_source_view;


drop view solar_energy_usage_view;


drop view alternative_energy_type_view;


drop view sport_field_type_view;


drop view health_resource_view;


drop view irrigation_water_source_view;


drop view public_transportation_type_view;


drop view sewage_network_type_view;


drop view agricultural_resource_view;


drop view garbage_destination_view;


drop view bakery_shop_type_view;


drop view cultural_association_view;


drop view soil_threat_view;


drop view education_resource_view;


drop view agriculture_product_distribution_view;


drop view waste_collecting_agency_view;


drop view commerce_type_view;


drop view clothing_type_view;


drop view financial_institution_view;


drop view other_industry_type_view;


drop view ind_product_distribution_view;


drop view institute_view;


drop view agricultural_project_view;


drop view commercial_project_view;


drop view cultural_project_view;


drop view educational_project_view;


drop view health_project_view;


drop view industrial_project_view;


drop view infrastructure_project_view;


drop view security_project_view;


drop view touristic_project_view;


drop view natural_monument_view;


drop view archaeological_monument_view;


drop view annual_celebration_view;


drop view expats_destination_continent_view;


create VIEW chronic_disease_view as
select mdcd."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(cd."NAME") as chronic_disease
from "MunDevChronicDisease" mdcd
left join "ChronicDisease" cd on cd."REF" = mdcd."ChronicDisease_REF"
GROUP BY mdcd."MunicipalityDevelopment_REF";


create VIEW drink_water_source_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(dws."NAME") as drink_water_source
from "MunDevDrinkWaterSource" md
left join "DrinkingWaterSource" dws on dws."REF" = md."DrinkingWaterSource_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW solar_energy_usage_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(isu."NAME") as solar_energy_usage
from "MunDevSolarEnergyUsage" md
left join "InfraStructureUsage" isu on isu."REF" = md."SolarEnergyUsage_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW alternative_energy_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(aet."NAME") as alternative_energy_type
from "MunDevAlternateEnergyType" md
left join "AlternativeEnergyType" aet on aet."REF" = md."AlternativeEnergyType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW sport_field_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(sft."NAME") as sport_field_type
from "MunDevSportFieldType" md
left join "SportFieldType" sft on sft."REF" = md."SportFieldType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW health_resource_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as health_resource
from "MunDevHealthResource" md
left join "HealthResource" hr on hr."REF" = md."HealthResource_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW irrigation_water_source_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as irrigation_water_source
from "MunDevIrrigationWaterSource" md
left join "IrrigationWaterSource" hr on hr."REF" = md."IrrigationWaterSource_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW public_transportation_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as public_transportation_type
from "MunDevPublicTransportation" md
left join "PublicTransportationType" hr on hr."REF" = md."PublicTransportationType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW sewage_network_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as sewage_network_type
from "MunDevSewageNetwork" md
left join "SewageNetworkType" hr on hr."REF" = md."SewageNetworkType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW agricultural_resource_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as agricultural_resource
from "MunDevAgriculturalResource" md
left join "AgriculturalResource" hr on hr."REF" = md."AgriculturalResource_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW garbage_destination_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as garbage_destination
from "MunDevGarbageDestination" md
left join "GarbageDestination" hr on hr."REF" = md."GarbageDestination_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW bakery_shop_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as bakery_shop_type
from "MunDevBakeryShopType" md
left join "ShopType" hr on hr."REF" = md."ShopType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW cultural_association_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as cultural_association
from "MunDevCulturalAssociation" md
left join "CulturalAssociation" hr on hr."REF" = md."CulturalAssociation_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW soil_threat_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as soil_threat
from "MunDevSoilThreat" md
left join "SoilThreat" hr on hr."REF" = md."SoilThreat_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW education_resource_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as education_resource
from "MunDevEducationalResource" md
left join "EducationResource" hr on hr."REF" = md."EducationResource_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW agriculture_product_distribution_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as agriculture_product_distribution
from "MunDevAgriProductDistribution" md
left join "ProductDistribution" hr on hr."REF" = md."ProductDistribution_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW waste_collecting_agency_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as waste_collecting_agency
from "MunDevWasteCollectingAgency" md
left join "WasteCollectingAgency" hr on hr."REF" = md."WasteCollectingAgency_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW commerce_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as commerce_type
from "MunDevCommerceType" md
left join "CommerceType" hr on hr."REF" = md."CommerceType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW clothing_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as clothing_type
from "MunDevClothingType" md
left join "ClothingType" hr on hr."REF" = md."ClothingType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW financial_institution_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as financial_institution
from "MunDevFinancialInstitution" md
left join "FinancialInstitution" hr on hr."REF" = md."FinancialInstitution_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW other_industry_type_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as other_industry_type
from "MunDevOtherIndustryType" md
left join "IndustryType" hr on hr."REF" = md."IndustryType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW ind_product_distribution_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(hr."NAME") as ind_product_distribution
from "MunDevIndProductDistribution" md
left join "ProductDistribution" hr on hr."REF" = md."ProductDistribution_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW institute_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(md."InstituteProgram") as institute_program,
       array_agg(md."InstituteName") as institute_name
from "MunDevInstitute" md
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW expats_destination_continent_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(c."NAME") as expats_destination_continent
from "MunDevExpatsDestinationContinent" md
left join "Continent" c on c."REF" = md."ExpatsDestinationContinent_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW annual_celebration_view as
select md."MunicipalityDevelopment_REF" as municipality_development_ref,
       array_agg(act."NAME") as annual_celebration
from "MunDevAnnualCelebration" md
left join "AnnualCelebrationType" act on act."REF" = md."AnnualCelebrationType_REF"
GROUP BY md."MunicipalityDevelopment_REF";


create VIEW agricultural_project_view as
select agricultural_project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(agricultural_project))) as agricultural_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as agricultural_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevAgriculturalProject" md) as agricultural_project
group by agricultural_project.municipality_development_ref;


create VIEW commercial_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as commercial_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as commercial_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevCommercialProject" md) as project
group by project.municipality_development_ref;


create VIEW cultural_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as cultural_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as cultural_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevCulturalProject" md) as project
group by project.municipality_development_ref;


create VIEW educational_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as educational_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as educational_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevEducationalProject" md) as project
group by project.municipality_development_ref;


create VIEW health_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as health_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as health_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevHealthProject" md) as project
group by project.municipality_development_ref;


create VIEW industrial_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as industrial_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as industrial_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevIndustrialProject" md) as project
group by project.municipality_development_ref;


create VIEW infrastructure_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as infrastructure_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as infrastructure_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevInfraStructureProject" md) as project
group by project.municipality_development_ref;


create VIEW security_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as security_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as security_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevSecurityProject" md) as project
group by project.municipality_development_ref;


create VIEW touristic_project_view as
select project.municipality_development_ref,
       array_to_json(array_agg(row_to_json(project))) as touristic_project
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as touristic_project_ref,
            md."ProjectName" as project_name,
            md."ImplementedBy" as project_implemented_by,
            md."FundedBy" as project_funded_by,
            md."StartYear" as project_start_date,
            md."EndYear" as project_end_date
     from "MunDevTouristicProject" md) as project
group by project.municipality_development_ref;


create VIEW natural_monument_view as
select monument.municipality_development_ref,
       array_to_json(array_agg(row_to_json(monument))) as natural_monument
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as natural_monument_ref,
            md."Monument" as monument_name,
            iss."NAME" as reality
     from "MunDevNaturalMonument" md
     left join "InfraStructureState" iss on iss."REF" = md."State_REF") as monument
group by monument.municipality_development_ref;


create VIEW archaeological_monument_view as
select monument.municipality_development_ref,
       array_to_json(array_agg(row_to_json(monument))) as archaeological_monument
from
    (select md."MunicipalityDevelopment_REF" as municipality_development_ref,
            md."REF" as archaeological_monument_ref,
            md."Monument" as monument_name,
            iss."NAME" as reality
     from "MunDevArchaeologicalMonument" md
     left join "InfraStructureState" iss on iss."REF" = md."State_REF") as monument
group by monument.municipality_development_ref;


create VIEW development_municipality_view as
select md."REF" as municipality_development_ref,
       md."DATE" as municipality_development_date,
       md."CreationDateTime" as municipality_development_creation_date_time,
       md."SeaLevelElevation" as municipality_development_sea_level_elevation,
       md."Population" as municipality_development_population,
       md."PopulationLebanese" as municipality_development_population_lebanese,
       md."PopulationSyrian" as municipality_development_population_syrian,
       md."PopulationPalestinian" as municipality_development_population_palestinian,
       md."PopulationOther" as municipality_development_population_other,
       md."ResidentsSeasonal" as municipality_development_residents_seasonal,
       md."Expatriates" as municipality_development_expatriates,
       md."AverageFamilySize" as municipality_development_average_family_size,
       md."Youth24To25Percentage" as municipality_development_youth_24_to_25_percentage,
       md."ElderlyAbove65Percentage" as municipality_development_elderly_above_65_percentage,
       md."DrinkWaterSourceOther" as municipality_development_drink_water_source_other,
       md."DistributionWaterTanksNbr" as municipality_development_distribution_water_tanks_nbr,
       md."IrrigationWaterSourceOther" as municipality_development_irrigation_water_source_other,
       md."IrrigationChannelExistence" as municipality_development_irrigation_channel_existence,
       md."WaterSpringExistence" as municipality_development_water_spring_existence,
       md."WaterSpringSeasonalNbr" as municipality_development_water_spring_seasonal_nbr,
       md."WaterSpringPermanentNbr" as municipality_development_water_spring_permanent_nbr,
       md."WaterPointsExistence" as municipality_development_water_points_existence,
       md."WaterPointsSeasonalNbr" as municipality_development_water_points_seasonal_nbr,
       md."WaterPointsPermanentNbr" as municipality_development_water_points_permanent_nbr,
       md."ElectricityNetworkComment" as municipality_development_electricity_network_comment,
       md."LightingNetworkComment" as municipality_development_lighting_network_comment,
       md."PhoneNetworkComment" as municipality_development_phone_network_comment,
       md."InternetComment" as municipality_development_internet_comment,
       md."SolarEnergyUsed" as municipality_development_solar_energy_used,
       md."SolarEnergyComment" as municipality_development_solar_energy_comment,
       md."GarbageInLandfillLocation" as municipality_development_garbage_in_landfill_location,
       md."GarbageInLandfillLongitude" as municipality_development_garbage_in_landfill_longitude,
       md."GarbageInLandfillLatitude" as municipality_development_garbage_in_landfill_latitude,
       md."GarbageOutLandfillLocation" as municipality_development_garbage_out_landfill_location,
       md."GarbageOutLandfillLongitude" as municipality_development_garbage_out_landfill_longitude,
       md."GarbageOutLandfillLatitude" as municipality_development_garbage_out_landfill_latitude,
       md."GarbageOutLandfillArea" as municipality_development_garbage_out_landfill_area,
       md."SanitaryLandLocation" as municipality_development_sanitary_land_location,
       md."SanitaryLandfillLongitude" as municipality_development_sanitary_landfill_longitude,
       md."SanitaryLandfilllatitude" as municipality_development_sanitary_landfill_latitude,
       md."GarbageTransporterCompany" as municipality_development_garbage_transporter_company,
       md."GarbageTransporterInstitution" as municipality_development_garbage_transporter_institution,
       md."GarbageRecycled" as municipality_development_garbage_recycled,
       md."GarbageSortingOutside" as municipality_development_garbage_sorting_outside,
       md."WasteTreatmentPlanned" as municipality_development_waste_treatment_planned,
       md."WasteTreatmentComment" as municipality_development_waste_treatment_comment,
       md."SewageNetworkComment" as municipality_development_sewage_network_comment,
       md."SewageTreatmentPlant" as municipality_development_sewage_treatment_plant,
       md."SewageTreatmentPlantComment" as municipality_development_sewage_treatment_plant_comment,
       md."BusStops" as municipality_development_bus_stops,
       md."InfraStructureProject5Years" as municipality_development_infra_structure_project_5_years,
       md."InfraStructureProjectSuggestion" as municipality_development_infra_structure_project_suggestion,
       md."EducationIlliteratePercentage" as municipality_development_education_illiterate_percentage,
       md."EducationElementaryPercentage" as municipality_development_education_elementary_percentage,
       md."EducationIntermediatePercentage" as municipality_development_education_intermediate_percentage,
       md."EducationSecondaryPercentage" as municipality_development_education_secondary_percentage,
       md."EducationTechnicalPercentage" as municipality_development_education_technical_percentage,
       md."EducationUniversityPercentage" as municipality_development_education_university_percentage,
       md."EducationPostGraduatePercentage" as municipality_development_education_post_graduate_percentage,
       md."SchoolDropoutPercentage" as municipality_development_school_dropout_percentage,
       md."PublicSchoolNumber" as municipality_development_public_school_number,
       md."PrivateSchoolNumber" as municipality_development_private_school_number,
       md."TechnicalSchoolNumber" as municipality_development_technical_school_number,
       md."UniversityNumber" as municipality_development_university_number,
       md."LebaneseUniversityMajor" as municipality_development_lebanese_university_major,
       md."PrivateUniversityMajor" as municipality_development_private_university_major,
       md."NonFormalInstitutes" as municipality_development_non_formal_institutes,
       md."EducationalProject5Years" as municipality_development_educational_project_5_years,
       md."EducationalProjectSuggestion" as municipality_development_educational_project_suggestion,
       md."FirstAidCenterExistence" as municipality_development_first_aid_center_existence,
       md."CareServicesExistence" as municipality_development_care_services_existence,
       md."AgingDiseasesExist" as municipality_development_aging_diseases_exist,
       md."PediatricDiseasesExist" as municipality_development_pediatric_diseases_exist,
       md."OtherDiseasesExist" as municipality_development_other_diseases_exist,
       md."OtherDiseasesNames" as municipality_development_other_diseases_names,
       md."SpecialNeedsIndividualsExist" as municipality_development_special_needs_individuals_exist,
       md."SpecialNeedsIndividualsNbr" as municipality_development_special_needs_individuals_nbr,
       md."SpecialNeedsInstitutionExist" as municipality_development_special_needs_institution_exist,
       md."HealthProject5Years" as municipality_development_health_project_5_years,
       md."HealthProjectSuggestion" as municipality_development_health_project_suggestion,
       md."HasGeneralInfo" as municipality_development_has_general_info,
       md."HasDemographyInfo" as municipality_development_has_demography_info,
       md."OtherMonuments" as municipality_development_other_monuments,
       md."RestaurantsExist" as municipality_development_restaurants_exist,
       md."RestaurantsNbr" as municipality_development_restaurants_nbr,
       md."HotelsExist" as municipality_development_hotels_exist,
       md."HotelsNumber" as municipality_development_hotels_number,
       md."GuestHousesExist" as municipality_development_guest_houses_exist,
       md."GuestHousesNbr" as municipality_development_guest_houses_nbr,
       md."CafesExist" as municipality_development_cafes_exist,
       md."CafesNbr" as municipality_development_cafes_nbr,
       md."HasWaterInfo" as municipality_development_has_water_info,
       md."HasElectricityInfo" as municipality_development_has_electricity_info,
       md."TouristicProject5Years" as municipality_development_touristic_project_5_years,
       md."TouristicProjectSuggestion" as municipality_development_touristic_project_suggestion,
       md."HasGarbageInfo" as municipality_development_has_garbage_info,
       md."HasTransportationInfo" as municipality_development_has_transportation_info,
       md."AgriculturalArea" as municipality_development_agricultural_area,
       md."SpecificCorps" as municipality_development_specific_corps,
       md."SpecificCorpsNames" as municipality_development_specific_corps_names,
       md."HasEducationInfo" as municipality_development_has_education_info,
       md."AgriProductsOther" as municipality_development_agri_products_other,
       md."AgriCoopExist" as municipality_development_agri_coop_exist,
       md."AgriProductiveCoopNbr" as municipality_development_agri_productive_coop_nbr,
       md."AgriMarketingCoopNbr" as municipality_development_agri_marketing_coop_nbr,
       md."AgriWomenCoopExist" as municipality_development_agri_women_coop_exist,
       md."AgriProductiveWomenCoopNbr" as municipality_development_agri_productive_women_coop_nbr,
       md."AgriMarketingWomenCoopNbr" as municipality_development_agri_marketing_women_coop_nbr,
       md."FarmsExist" as municipality_development_farms_exist,
       md."CowFarmNbr" as municipality_development_cow_farm_nbr,
       md."CowFarmHeadsNbr" as municipality_development_cow_farm_heads_nbr,
       md."SheepFarmNbr" as municipality_development_sheep_farm_nbr,
       md."SheepFarmHeadsNbr" as municipality_development_sheep_farm_heads_nbr,
       md."GoatFarmNbr" as municipality_development_goat_farm_nbr,
       md."GoatFarmHeadsNbr" as municipality_development_goat_farm_heads_nbr,
       md."ChickenFarmNbr" as municipality_development_chicken_farm_nbr,
       md."ChickenFarmHeadsNbr" as municipality_development_chicken_farm_heads_nbr,
       md."BeeApiariesExist" as municipality_development_bee_apiaries_exist,
       md."BeeApiariesNbr" as municipality_development_bee_apiaries_nbr,
       md."FishFarmExist" as municipality_development_fish_farm_exist,
       md."FishFarmNbr" as municipality_development_fish_farm_nbr,
       md."OtherFarms" as municipality_development_other_farms,
       md."PrivateForestArea" as municipality_development_private_forest_area,
       md."PublicForestArea" as municipality_development_public_forest_area,
       md."FireControlExternal" as municipality_development_fire_control_external,
       md."AfforestedAreaExist" as municipality_development_afforested_area_exist,
       md."AfforestedArea" as municipality_development_afforested_area,
       md."SoilThreatExist" as municipality_development_soil_threat_exist,
       md."AgriObstaclesExist" as municipality_development_agri_obstacles_exist,
       md."AgriObstaclesDescription" as municipality_development_agri_obstacles_description,
       md."AgriculturalProject5Years" as municipality_development_agricultural_project_5_years,
       md."AgriculturalProjectSuggestion" as municipality_development_agricultural_project_suggestion,
       md."HasHealthInfo" as municipality_development_has_health_info,
       md."HasTouristicInfo" as municipality_development_has_touristic_info,
       md."HasAgriculturalInfo" as municipality_development_has_agricultural_info,
       md."HasIndustrialInfo" as municipality_development_has_industrial_info,
       md."IndustrialZone" as municipality_development_industrial_zone,
       md."IndustrialFoodFactory" as municipality_development_industrial_food_factory,
       md."IndustrialManufacturedFood" as municipality_development_industrial_manufactured_food,
       md."IndustryWorkerLebanese" as municipality_development_industry_worker_lebanese,
       md."IndustryWorkerOther" as municipality_development_industry_worker_other,
       md."IndustryWorkerWomen" as municipality_development_industry_worker_women,
       md."IndustrialDistributionOther" as municipality_development_industrial_distribution_other,
       md."BakeryWorkerLebanese" as municipality_development_bakery_worker_lebanese,
       md."BakeryWorkerOther" as municipality_development_bakery_worker_other,
       md."BakeryWorkerWomen" as municipality_development_bakery_worker_women,
       md."IndustrialCoopExist" as municipality_development_industrial_coop_exist,
       md."IndustrialProductiveCoopNbr" as municipality_development_industrial_productive_coop_nbr,
       md."IndustrialMarketingCoopNbr" as municipality_development_industrial_marketing_coop_nbr,
       md."IndustrialWomenCoopExist" as municipality_development_industrial_women_coop_exist,
       md."IndustrialProductiveWomenCoopNbr" as municipality_development_industrial_productive_women_coop_nbr,
       md."IndustrialMarketingWomenCoopNbr" as municipality_development_industrial_marketing_women_coop_nbr,
       md."IndustrialObstaclesExist" as municipality_development_industrial_obstacles_exist,
       md."IndustrialObstaclesDescription" as municipality_development_industrial_obstacles_description,
       md."IndustrialProject5Years" as municipality_development_industrial_project_5_years,
       md."IndustrialProjectSuggestion" as municipality_development_industrial_project_suggestion,
       md."CommercialProject5Years" as municipality_development_commercial_project_5_years,
       md."CommercialProjectSuggestion" as municipality_development_commercial_project_suggestion,
       md."PublicPark" as municipality_development_public_park,
       md."PublicParkSuggestion" as municipality_development_public_park_suggestion,
       md."PublicSpace" as municipality_development_public_space,
       md."YouthAssociationsNbr" as municipality_development_youth_associations_nbr,
       md."YouthSportTournament" as municipality_development_youth_sport_tournament,
       md."SocialServiceCenters" as municipality_development_social_service_centers,
       md."SocialServiceCenterPrograms" as municipality_development_social_service_center_programs,
       md."CulturalCenters" as municipality_development_cultural_centers,
       md."PublicLibrary" as municipality_development_public_library,
       md."CulturalProject5Years" as municipality_development_cultural_project_5_years,
       md."CulturalProjectSuggestion" as municipality_development_cultural_project_suggestion,
       md."PoliceStationExist" as municipality_development_police_station_exist,
       md."PoliceStationsNbr" as municipality_development_police_stations_nbr,
       md."NearbyPoliceStation" as municipality_development_nearby_police_station,
       md."MunicipalPoliceExist" as municipality_development_municipal_police_exist,
       md."SecuritySurveillanceExist" as municipality_development_security_surveillance_exist,
       md."SecuritySurveillanceParty" as municipality_development_security_surveillance_party,
       md."SecurityProject5Years" as municipality_development_security_project_5_years,
       md."SecurityProjectSuggestion" as municipality_development_security_project_suggestion,
       md."HasCommercialInfo" as municipality_development_has_commercial_info,
       md."HasCulturalInfo" as municipality_development_has_cultural_info,
       md."HasSecurityInfo" as municipality_development_has_security_info,
       md."CowFarm" as municipality_development_cow_farm,
       md."SheepFarm" as municipality_development_sheep_farm,
       md."GoatFarm" as municipality_development_goat_farm,
       md."ChickenFarm" as municipality_development_chicken_farm,
       md."AgriculturalResourceOther" as municipality_development_agricultural_resource_other,
       md."OtherIndustryTypeOther" as municipality_development_other_industry_type_other,
       md."IndustrialCoopNbr" as municipality_development_industrial_coop_nbr,
       md."IndustrialWomenCoopNbr" as municipality_development_industrial_women_coop_nbr,
       md."PublicParkQualifiedPlace" as municipality_development_public_park_qualified_place,
       md."HospitalsNbr" as municipality_development_hospitals_nbr,
       md."HospitalBedsNbr" as municipality_development_hospital_beds_nbr,
       md."HospitalServices" as municipality_development_hospital_services,
       md."ClinicsNbr" as municipality_development_clinics_nbr,
       md."ClinicServices" as municipality_development_clinic_services,
       md."PharmacyNbr" as municipality_development_pharmacy_nbr,
       md."PharmacyServices" as municipality_development_pharmacy_services,
       md."LabsNbr" as municipality_development_labs_nbr,
       md."LabServices" as municipality_development_lab_services,
       md."MalePercentage" as municipality_development_male_percentage,
       md."FemalePercentage" as municipality_development_female_percentage,
       md."WorkingWomenPercentage" as municipality_development_working_women_percentage,
       md."AlternativeEnergyTypeOther" as municipality_development_alternative_energy_type_other,
       md."WasteCollectingAgencyOther" as municipality_development_waste_collecting_agency_other,
       md."LebaneseUniversityNbr" as municipality_development_lebanese_university_nbr,
       md."PrivateUniversityNbr" as municipality_development_private_university_nbr,
       md."FirstAidCentersNbr" as municipality_development_first_aid_centers_nbr,
       md."CareServicesNbr" as municipality_development_care_services_nbr,
       md."OtherMonumentsExist" as municipality_development_other_monuments_exist,
       md."AgriWorkersPercent" as municipality_development_agri_workers_percent,
       md."AgriWorkersLebanesePercent" as municipality_development_agri_workers_lebanese_percent,
       md."AgriWorkersForeignPercent" as municipality_development_agri_workers_foreign_percent,
       md."AgriWorkersWomenPercent" as municipality_development_agri_workers_women_percent,
       md."IndustryWorkersPercent" as municipality_development_industry_workers_percent,
       md."BakeryWorkersPercent" as municipality_development_bakery_workers_percent,
       md."ClothingWorkersPercent" as municipality_development_clothing_workers_percent,
       md."ClothingLebanesePercent" as municipality_development_clothing_lebanese_percent,
       md."ClothingForeignPercent" as municipality_development_clothing_foreign_percent,
       md."ClothingWomenPercent" as municipality_development_clothing_women_percent,
       md."CommerceInstitutionSmallNbr" as municipality_development_commerce_institution_small_nbr,
       md."CommerceInstitutionMediumNbr" as municipality_development_commerce_institution_medium_nbr,
       md."CommerceInstitutionBigNbr" as municipality_development_commerce_institution_big_nbr,
       md."BankingInstitutionsNbr" as municipality_development_banking_institutions_nbr,
       md."FinancialInstitutionsNbr" as municipality_development_financial_institutions_nbr,
       md."FinancialInstitutionOther" as municipality_development_financial_institution_other,
       md."ServiceInstitutionsNbr" as municipality_development_service_institutions_nbr,
       md."FreeBusinessInstitutionsNbr" as municipality_development_free_business_institutions_nbr,
       md."PublicSectorInstitutionsNbr" as municipality_development_public_sector_institutions_nbr,
       md."SportFieldsNbr" as municipality_development_sport_fields_nbr,
       md."YouthSportTourDescription" as municipality_development_youth_sport_tour_description,
       md."MedicalCenterNbr" as municipality_development_medical_center_nbr,
       md."MedicalCenterServices" as municipality_development_medical_center_services,
       md."IndustrialDistributionIndv" as municipality_development_industrial_distribution_indv,
       md."TownDistanceToBeirut" as municipality_development_town_distance_to_beirut,
       md."HasInfrastructureDetailsInfo" as municipality_development_has_infrastructure_details_info,
       md."CompletedGeneralInfo" as municipality_development_completed_general_info,
       md."CompletedDemographyInfo" as municipality_development_completed_demography_info,
       md."CompletedWaterInfo" as municipality_development_completed_water_info,
       md."CompletedElectricityInfo" as municipality_development_completed_electricity_info,
       md."CompletedEducationInfo" as municipality_development_completed_education_info,
       md."CompletedHealthInfo" as municipality_development_completed_health_info,
       md."CompletedTouristicInfo" as municipality_development_completed_touristic_info,
       md."CompletedAgriculturalInfo" as municipality_development_completed_agricultural_info,
       md."CompletedIndustrialInfo" as municipality_development_completed_industrial_info,
       md."CompletedGarbageInfo" as municipality_development_completed_garbage_info,
       md."CompletedTransportationInfo" as municipality_development_completed_transportation_info,
       md."CompletedCommercialInfo" as municipality_development_completed_commercial_info,
       md."CompletedCulturalInfo" as municipality_development_completed_cultural_info,
       md."CompletedSecurityInfo" as municipality_development_completed_security_info,
       md."CompletedInfrastructureDetailsInfo" as municipality_development_completed_infrastructure_details_info,
       md."PigFarm" as municipality_development_pig_farm,
       md."PigFarmNbr" as municipality_development_pig_farm_nbr,
       md."PigFarmHeadsNbr" as municipality_development_pig_farm_heads_nbr,
       md."HealthResourcesExist" as municipality_development_health_resources_exist,
       case
           WHEN md."GeoLatitude" is not NULL THEN m."Lat"
           ELSE 0
       END as municipality_development_geo_latitude,
       case
           WHEN md."GeoLongitude" is not NULL THEN md."GeoLongitude"
           ELSE 0
       end as municipality_development_geo_longitude,
       fc."NAME" as fire_control,
       fc."Type" as fire_control_type,
       ide."NAME" as industrial_distribution_exhibit,
       ide."Type" as industrial_distribution_exhibit_type,
       ipp."NAME" as industrial_product_packing,
       ipp."Type" as industrial_product_packing_type,
       gt."NAME" as garbage_transporter,
       gt."Type" as garbage_transporter_type,
       isa."NAME" as internet_availability,
       isa."Type" as internet_availability_type,
       nla."NAME" as night_light_availability,
       nla."Type" as night_light_availability_type,
       fff."NAME" as forest_fire_frequency,
       fff."Type" as forest_fire_frequency_type,
       apmt."NAME" as agri_products_market_type,
       idm."NAME" as industrial_distribution_market,
       idm."Type" as industrial_distribution_market_type,
       snil."NAME" as special_needs_institution_location,
       snil."Type" as special_need_institution_location_type,
       gfl."NAME" as garbage_factory_location,
       gfl."Type" as garbage_factory_location_type,
       gsl."NAME" as garbage_sorting_location,
       gsl."Type" as garbage_sorting_location_type,
       srs."NAME" as sub_road_state,
       srs."Type" as sub_road_state_type,
       wts."NAME" as water_tank_state,
       wts."Type" as water_tank_state_type,
       css."NAME" as citizen_security_satisfaction,
       css."Type" as citizen_security_satisfaction_type,
       mrs."NAME" as main_road_state,
       mrs."Type" as main_road_state_type,
       wns."NAME" as water_network_state,
       wns."Type" as water_network_state_type,
       ens."NAME" as electricity_network_state,
       ens."Type" as electricity_network_state_type,
       ics."NAME" as irrigation_chanel_state,
       ics."Type" as irrigation_chanel_state_type,
       lns."NAME" as lighting_network_state,
       lns."Type" as lighting_network_state_type,
       ars."NAME" as agricultural_road_state,
       ars."Type" as agricultural_road_state_type,
       pns."NAME" as phone_network_state,
       pns."Type" as phone_network_state_type,
       fs2."NAME" as family_size,
       fs2."Type" as family_size_type,
       rt."NAME" as region_type,
       apet."NAME" as agri_product_exhibit_type,
       pps."NAME" as public_park_state,
       pss."Type" as public_park_state_type,
       pss."NAME" as public_space_state,
       pss."Type" as public_space_type,
       k."NAME" as kadaa,
       z."NAME" as mouhafaza,
       m."NAME" as municipality,
       m."IsTown" as municipality_is_town,
       er."NAME" as east_region,
       wr."NAME" as west_region,
       nr."NAME" as north_region,
       sr."NAME" as south_region,
       golfk."NAME" as garbage_out_land_fill_kaddaa,
       golfm."NAME" as garbage_out_land_fill_mouhafaza,
       izst."NAME" as industrial_zone_state,
       cdv.chronic_disease,
       dwsv.drink_water_source,
       seuv.solar_energy_usage,
       aetv.alternative_energy_type,
       sftv.sport_field_type,
       hrv.health_resource,
       iwv.irrigation_water_source,
       pttv.public_transportation_type,
       sntv.sewage_network_type,
       arv.agricultural_resource,
       gdv.garbage_destination,
       bstv.bakery_shop_type,
       cav.cultural_association,
       stv.soil_threat,
       erv.education_resource,
       apdv.agriculture_product_distribution,
       wcav.waste_collecting_agency,
       ctv.commerce_type,
       cltv.clothing_type,
       fiv.financial_institution,
       oitv.other_industry_type,
       ipdv.ind_product_distribution,
       insv.institute_program,
       insv.institute_name,
       acv.annual_celebration,
       edcv.expats_destination_continent,
       to_json(agricultural_project.agricultural_project)::text as agricultural_project,
       to_json(commercial_project.commercial_project)::text as commercial_project,
       to_json(cultural_project.cultural_project)::text as cultural_project,
       to_json(educational_project.educational_project)::text as educational_project,
       to_json(health_project.health_project)::text as health_project,
       to_json(industrial_project.industrial_project)::text as industrial_project,
       to_json(infrastructure_project.infrastructure_project)::text as infrastructure_project,
       to_json(security_project.security_project)::text as security_project,
       to_json(touristic_project.touristic_project)::text as touristic_project,
       to_json(natural_monument.natural_monument)::text as natural_monument,
       to_json(archaeological_monument.archaeological_monument)::text as archaeological_monument,
       case
           WHEN m."Lat" is not NULL THEN m."Lat"
           ELSE 0
       END as municipality_lat,
       case
           WHEN m."Lng" is not NULL THEN m."Lng"
           ELSE 0
       end as municipality_lng,
       u."NAME" as user_name,
       u."FULL_NAME" as user_full_name,
       u."Phone" as user_phone,
       u."FirstName" as user_first_name,
       u."LastName" as user_last_name,
       u."REF" as user_ref,
       grp."NAME" as user_group
from "MunicipalityDevelopment" md
left join "FireControl" fc on fc."REF" = md."FireControl_REF"
left join "ExhibitType" ide on ide."REF" = md."IndustrialDistributionExhibit_REF"
left join "ExhibitType" apet on apet."REF" = md."AgriProductsExhibitType_REF"
left join "IndustrialProductPacking" ipp on ipp."REF" = md."IndustrialProductPacking_REF"
left join "GarbageTransporter" gt on gt."REF" = md."GarbageTransporter_REF"
left join "InfraStructureAvailability" isa on isa."REF" = md."InternetAvailability_REF"
left join "InfraStructureFrequency" nla on nla."REF" = md."NightLightAvailability_REF"
left join "InfraStructureFrequency" fff on fff."REF" = md."ForestFireFrequency_REF"
left join "MarketType" apmt on apmt."REF" = md."AgriProductsMarketType_REF"
left join "MarketType" idm on idm."REF" = md."IndustrialDistributionMarket_REF"
left join "InfraStructureLocation" snil on snil."REF" = md."SpecialNeedsInstitutionLocation_REF"
left join "InfraStructureLocation" gfl on gfl."REF" = md."GarbageFactoryLocation_REF"
left join "InfraStructureLocation" gsl on gsl."REF" = md."GarbageSortingLocation_REF"
left join "InfraStructureState" srs on srs."REF" = md."SubRoadsState_REF"
left join "InfraStructureState" wts on wts."REF" = md."WaterTankState_REF"
left join "InfraStructureState" css on css."REF" = md."CitizenSecuritySatisfication_REF"
left join "InfraStructureState" mrs on mrs."REF" = md."MainRoadsState_REF"
left join "InfraStructureState" wns on wns."REF" = md."WaterNetworkState_REF"
left join "InfraStructureState" ens on ens."REF" = md."ElectricityNetworkState_REF"
left join "InfraStructureState" ics on ics."REF" = md."IrrigationChannelState_REF"
left join "InfraStructureState" lns on lns."REF" = md."LightingNetworkState_REF"
left join "InfraStructureState" ars on ars."REF" = md."AgriculturalRoadsState_REF"
left join "InfraStructureState" pns on pns."REF" = md."PhoneNetworkState_REF"
left join "InfraStructureState" pps on pps."REF" = md."PublicParkState_REF"
left join "InfraStructureState" pss on pss."REF" = md."PublicSpaceState_REF"
left join "FamilySize" fs2 on fs2."REF" = md."FamilySize_REF"
left join "RegionType" rt on rt."REF" = md."RegionType_REF"
left join "Municipality" er on er."REF" = md."EastRegion_REF"
left join "Municipality" wr on wr."REF" = md."WestRegion_REF"
left join "Municipality" nr on nr."REF" = md."NorthRegion_REF"
left join "Municipality" sr on sr."REF" = md."SouthRegion_REF"
left join "IndustrialZoneStateType" izst on izst."REF" = md."IndustrialZoneState_REF"
left join chronic_disease_view cdv on cdv.municipality_development_ref = md."REF"
left join drink_water_source_view dwsv on dwsv.municipality_development_ref = md."REF"
left join solar_energy_usage_view seuv on seuv.municipality_development_ref = md."REF"
left join alternative_energy_type_view aetv on aetv.municipality_development_ref = md."REF"
left join sport_field_type_view sftv on sftv.municipality_development_ref = md."REF"
left join health_resource_view hrv on hrv.municipality_development_ref = md."REF"
left join irrigation_water_source_view iwv on iwv.municipality_development_ref = md."REF"
left join public_transportation_type_view pttv on pttv.municipality_development_ref = md."REF"
left join sewage_network_type_view sntv on sntv.municipality_development_ref = md."REF"
left join agricultural_resource_view arv on arv.municipality_development_ref = md."REF"
left join garbage_destination_view gdv on gdv.municipality_development_ref = md."REF"
left join bakery_shop_type_view bstv on bstv.municipality_development_ref = md."REF"
left join cultural_association_view cav on cav.municipality_development_ref = md."REF"
left join soil_threat_view stv on stv.municipality_development_ref = md."REF"
left join education_resource_view erv on erv.municipality_development_ref = md."REF"
left join agriculture_product_distribution_view apdv on apdv.municipality_development_ref = md."REF"
left join waste_collecting_agency_view wcav on wcav.municipality_development_ref = md."REF"
left join annual_celebration_view acv on acv.municipality_development_ref = md."REF"
left join expats_destination_continent_view edcv on edcv.municipality_development_ref = md."REF"
left join commerce_type_view ctv on ctv.municipality_development_ref = md."REF"
left join clothing_type_view cltv on cltv.municipality_development_ref = md."REF"
left join financial_institution_view fiv on fiv.municipality_development_ref = md."REF"
left join other_industry_type_view oitv on oitv.municipality_development_ref = md."REF"
left join ind_product_distribution_view ipdv on ipdv.municipality_development_ref = md."REF"
left join institute_view insv on insv.municipality_development_ref = md."REF"
left join agricultural_project_view agricultural_project on agricultural_project.municipality_development_ref = md."REF"
left join commercial_project_view commercial_project on commercial_project.municipality_development_ref = md."REF"
left join cultural_project_view cultural_project on cultural_project.municipality_development_ref = md."REF"
left join educational_project_view educational_project on educational_project.municipality_development_ref = md."REF"
left join health_project_view health_project on health_project.municipality_development_ref = md."REF"
left join industrial_project_view industrial_project on industrial_project.municipality_development_ref = md."REF"
left join infrastructure_project_view infrastructure_project on infrastructure_project.municipality_development_ref = md."REF"
left join security_project_view security_project on security_project.municipality_development_ref = md."REF"
left join touristic_project_view touristic_project on touristic_project.municipality_development_ref = md."REF"
left join natural_monument_view natural_monument on natural_monument.municipality_development_ref = md."REF"
left join archaeological_monument_view archaeological_monument on archaeological_monument.municipality_development_ref = md."REF"
left join "Kadaa" golfk on golfk."REF" = md."GarbageOutLandfillKadaa_REF"
left join "Mouhafaza" golfm on golfm."REF" = md."GarbageOutLandfillMouhafaza_REF"
left join "Kadaa" k on K."REF" = md."Kadaa_REF"
left join "Mouhafaza" z on Z."REF" = md."Mouhafaza_REF"
left join "Municipality" m on M."REF" = md."Municipality_REF"
left join "FUSER" u on u."REF" = md."CreationUser_REF"
left join "FGROUP" grp on grp."REF" = u."GRP_REF";

