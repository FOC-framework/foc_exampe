package com.siren.impact.main.service;

import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.HttpConfiguration;
import org.eclipse.jetty.server.HttpConnectionFactory;
import org.eclipse.jetty.server.NCSARequestLog;
import org.eclipse.jetty.server.SecureRequestCustomizer;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.SslConnectionFactory;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.server.handler.RequestLogHandler;
import org.eclipse.jetty.server.session.SessionHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import org.eclipse.jetty.util.thread.QueuedThreadPool;

import com.foc.Globals;
import com.foc.shared.json.B01JsonBuilder;
import com.foc.shared.json.JSONFieldFilter;
import com.foc.util.Utils;

import siren.fenix.covid.agriculturalProperty.AgriculturalProperty;
import siren.fenix.covid.agriculturalProperty.PropertyAnimalExploitation;
import siren.fenix.covid.agriculturalProperty.PropertyVegeterianExploitation;
import siren.fenix.covid.aids.MosaAid;
import siren.fenix.covid.beirutAids.BeirutAid;
import siren.fenix.covid.beirutAids.BeirutAidFoodService;
import siren.fenix.covid.beirutAids.BeirutAidHealthService;
import siren.fenix.covid.beirutAids.BeirutAidHousingService;
import siren.fenix.covid.beirutAids.BeirutAidRepairService;
import siren.fenix.covid.beirutAids.BeirutAidServiceType;
import siren.fenix.covid.comon.GeoRegion;
import siren.fenix.covid.comon.Kadaa;
import siren.fenix.covid.comon.Mouhafaza;
import siren.fenix.covid.comon.Municipality;
import siren.fenix.covid.comon.MunicipalityVacancy;
import siren.fenix.covid.covidCase.SuspectedPeople;
import siren.fenix.covid.damageAssessment.DamageAssessment;
import siren.fenix.covid.expAffectedHousehold.ExpAffectedHousehold;
import siren.fenix.covid.expAffectedHousehold.ExpHHDrinkingWaterSourceList;
import siren.fenix.covid.expAffectedHousehold.ExpHHFollowup;
import siren.fenix.covid.expAffectedHousehold.ExpHHStructureConditionList;
import siren.fenix.covid.expAffectedHousehold.ExpHHWashingWaterSourceList;
import siren.fenix.covid.expAffectedHousehold.ExpHHWindowConditionList;
import siren.fenix.covid.forestFire.ForestFire;
import siren.fenix.covid.forestFire.ForestFireFightingTool;
import siren.fenix.covid.forestFire.ForestFireSupportingParty;
import siren.fenix.covid.forestFire.ForestPersonalProtectionTool;
import siren.fenix.covid.forestFire.ForestWaterSource;
import siren.fenix.covid.humanResource.HumanResourceAcademicCertificate;
import siren.fenix.covid.humanResource.HumanResourceNationality;
import siren.fenix.covid.humanResource.HumanResourceOccupation;
import siren.fenix.covid.images.EntityImagePage;
import siren.fenix.covid.industryFactory.IndustryFactoryClientNationality;
import siren.fenix.covid.industryFactory.IndustryFactoryProductType;
import siren.fenix.covid.ministerialMeasure.MinisterialMeasureStakeholder;
import siren.fenix.covid.municipalityDevelopment.MunDevAgriProductDistribution;
import siren.fenix.covid.municipalityDevelopment.MunDevAgriculturalProject;
import siren.fenix.covid.municipalityDevelopment.MunDevAgriculturalResource;
import siren.fenix.covid.municipalityDevelopment.MunDevAlternateEnergyType;
import siren.fenix.covid.municipalityDevelopment.MunDevAnnualCelebration;
import siren.fenix.covid.municipalityDevelopment.MunDevArchaeologicalMonument;
import siren.fenix.covid.municipalityDevelopment.MunDevBakeryShopType;
import siren.fenix.covid.municipalityDevelopment.MunDevChronicDisease;
import siren.fenix.covid.municipalityDevelopment.MunDevClothingType;
import siren.fenix.covid.municipalityDevelopment.MunDevCommerceType;
import siren.fenix.covid.municipalityDevelopment.MunDevCommercialProject;
import siren.fenix.covid.municipalityDevelopment.MunDevCulturalAssociation;
import siren.fenix.covid.municipalityDevelopment.MunDevCulturalProject;
import siren.fenix.covid.municipalityDevelopment.MunDevDrinkWaterSource;
import siren.fenix.covid.municipalityDevelopment.MunDevEducationalProject;
import siren.fenix.covid.municipalityDevelopment.MunDevEducationalResource;
import siren.fenix.covid.municipalityDevelopment.MunDevExpatsDestinationContinent;
import siren.fenix.covid.municipalityDevelopment.MunDevFinancialInstitution;
import siren.fenix.covid.municipalityDevelopment.MunDevGarbageDestination;
import siren.fenix.covid.municipalityDevelopment.MunDevHealthProject;
import siren.fenix.covid.municipalityDevelopment.MunDevHealthResource;
import siren.fenix.covid.municipalityDevelopment.MunDevIndProductDistribution;
import siren.fenix.covid.municipalityDevelopment.MunDevIndustrialProject;
import siren.fenix.covid.municipalityDevelopment.MunDevInfraStructureProject;
import siren.fenix.covid.municipalityDevelopment.MunDevInstitute;
import siren.fenix.covid.municipalityDevelopment.MunDevIrrigationWaterSource;
import siren.fenix.covid.municipalityDevelopment.MunDevNaturalMonument;
import siren.fenix.covid.municipalityDevelopment.MunDevOtherIndustryType;
import siren.fenix.covid.municipalityDevelopment.MunDevPublicTransportation;
import siren.fenix.covid.municipalityDevelopment.MunDevSecurityProject;
import siren.fenix.covid.municipalityDevelopment.MunDevSewageNetwork;
import siren.fenix.covid.municipalityDevelopment.MunDevSoilThreat;
import siren.fenix.covid.municipalityDevelopment.MunDevSolarEnergyUsage;
import siren.fenix.covid.municipalityDevelopment.MunDevSportFieldType;
import siren.fenix.covid.municipalityDevelopment.MunDevTouristicProject;
import siren.fenix.covid.municipalityDevelopment.MunDevWasteCollectingAgency;
import siren.fenix.covid.municipalityDevelopment.MunicipalityDevelopment;
import siren.fenix.covid.notification.services.UserNotificationServlet;
import siren.fenix.covid.quarantine.healthfollowup.QTFollowupSymptom;
import siren.fenix.covid.quarantine.healthfollowup.QTHealthFollowup;
import siren.fenix.covid.quarantine.person.QTBreak;
import siren.fenix.covid.quarantine.person.QTPerson;
import siren.fenix.covid.quarantine.person.QTPersonCovidTest;
import siren.fenix.covid.quarantine.person.QTPersonCovidTestReason;
import siren.fenix.covid.quarantine.person.QTPersonFlow;
import siren.fenix.covid.quarantine.person.QTPersonFollowup;
import siren.fenix.covid.quarantine.person.QTPersonLabSymptom;
import siren.fenix.covid.quarantine.person.QTPreviousCovidExam;
import siren.fenix.covid.quarantine.serviceFollowup.QTServiceFollowup;
import siren.fenix.covid.quarantineReport.QuarantineFloor;
import siren.fenix.covid.residentialAssessment.QTResidentialAssessment;
import siren.fenix.covid.residentialAssessment.QTResidentialAssessmentFamily;
import siren.fenix.covid.services.ChartsServlet;
import siren.fenix.covid.services.CitizenReportServlet;
import siren.fenix.covid.services.ComplianceReportServlet;
import siren.fenix.covid.services.CovidCaseServlet;
import siren.fenix.covid.services.CovidCaseServlet_Old;
import siren.fenix.covid.services.DashboardServlet;
import siren.fenix.covid.services.GCCallServlet;
import siren.fenix.covid.services.GenderServlet;
import siren.fenix.covid.services.GenerateGuestTokenServlet;
import siren.fenix.covid.services.GuestLoginServlet;
import siren.fenix.covid.services.IncidentPlaceServlet;
import siren.fenix.covid.services.IncidentServlet;
import siren.fenix.covid.services.IncidentTypeServlet;
import siren.fenix.covid.services.LivingSituationReportServlet;
import siren.fenix.covid.services.LoginServlet;
import siren.fenix.covid.services.LogoutServlet;
import siren.fenix.covid.services.MeasureImportanceServlet;
import siren.fenix.covid.services.MeasureServlet;
import siren.fenix.covid.services.MeasureTypeServlet;
import siren.fenix.covid.services.MobileAppVersionServlet;
import siren.fenix.covid.services.NeedServlet;
import siren.fenix.covid.services.NeedTypeServlet;
import siren.fenix.covid.services.PAIncidentServlet;
import siren.fenix.covid.services.PAMeasureServlet;
import siren.fenix.covid.services.PANeedServlet;
import siren.fenix.covid.services.PingServlet;
import siren.fenix.covid.services.ProcedureReportServlet;
import siren.fenix.covid.services.QTPersonContactedPersonsServlet;
import siren.fenix.covid.services.QTPersonLocationsServlet;
import siren.fenix.covid.services.QTPersonLoginServlet;
import siren.fenix.covid.services.QTPersonQuarantineLocationServlet;
import siren.fenix.covid.services.QTPersonVerificationCodeServlet;
import siren.fenix.covid.services.QTTokenGenerateServlet;
import siren.fenix.covid.services.RefugeeReportServlet;
import siren.fenix.covid.services.ReloadServlet;
import siren.fenix.covid.services.ResetPasswordRequestServlet;
import siren.fenix.covid.services.ResetPasswordServlet;
import siren.fenix.covid.services.StartupServlet;
import siren.fenix.covid.services.UploadImageServlet;
import siren.fenix.covid.services.UserProfileApproveLegalTermsServlet;
import siren.fenix.covid.services.UserProfileServlet;
import siren.fenix.covid.services.PublicAdministration.PAChartsServlet;
import siren.fenix.covid.services.PublicAdministration.PADashboardServlet;
import siren.fenix.covid.services.PublicAdministration.PAMinisterialMeasuresServlet;
import siren.fenix.covid.services.agriculturalProperty.AgriculturalPropertyServlet;
import siren.fenix.covid.services.beirutAid.BeirutAidServlet;
import siren.fenix.covid.services.blob.BlobServlet;
import siren.fenix.covid.services.blob.PhotoAlbumServlet;
import siren.fenix.covid.services.common.EntityImageServlet;
import siren.fenix.covid.services.common.KadaaServlet;
import siren.fenix.covid.services.common.MouhafazaServlet;
import siren.fenix.covid.services.common.MunicipalityServlet;
import siren.fenix.covid.services.common.MunicipalityVacancyServlet;
import siren.fenix.covid.services.damageAssessment.DamageAssessmentServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdAccessToHealthcareServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdAccessToWaterServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdAssetsServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdDetailsServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdFollowupServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdServlet;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdServletGeneralInfo;
import siren.fenix.covid.services.expAffectedHousehold.ExpAffectedHouseholdShelterServlet;
import siren.fenix.covid.services.forestFire.ForestFireServlet;
import siren.fenix.covid.services.forestFire.ForestFire_EquipmentInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_ForestInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_LocationInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_RoadsInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_SupportInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_ToolsInfo_Servlet;
import siren.fenix.covid.services.forestFire.ForestFire_WaterSourceInfo_Servlet;
import siren.fenix.covid.services.humanResources.AdministrationLegalMandateServlet;
import siren.fenix.covid.services.humanResources.HumanResourceAcademicCertificateServlet;
import siren.fenix.covid.services.humanResources.HumanResourceCurrentOccupationServlet;
import siren.fenix.covid.services.humanResources.HumanResourceOccupationServlet;
import siren.fenix.covid.services.humanResources.HumanResourcePercentageServlet;
import siren.fenix.covid.services.humanResources.HumanResourceServlet;
import siren.fenix.covid.services.humanResources.HumanResourceSignUpServlet;
import siren.fenix.covid.services.humanResources.HumanResourceTaskServlet;
import siren.fenix.covid.services.humanResources.HumanResourceVerificationServlet;
import siren.fenix.covid.services.humanResources.PublicUnitServlet;
import siren.fenix.covid.services.industryFactory.IndustryFactoryServlet;
import siren.fenix.covid.services.lookups.LookupServlet;
import siren.fenix.covid.services.lookups.PALookupServlet;
import siren.fenix.covid.services.ministerialMeasure.MinisterialMeasureServlet;
import siren.fenix.covid.services.mosa.AidDeliveryServlet;
import siren.fenix.covid.services.mosa.EducationLevelServlet;
import siren.fenix.covid.services.mosa.FamilyRelationServlet;
import siren.fenix.covid.services.mosa.IllnessTypeServlet;
import siren.fenix.covid.services.mosa.MobilityTypeServlet;
import siren.fenix.covid.services.mosa.MosaAidServlet;
import siren.fenix.covid.services.mosa.MosaCitizenVerificationServlet;
import siren.fenix.covid.services.mosa.OwnershipTypeServlet;
import siren.fenix.covid.services.mosa.PropertyTypeServlet;
import siren.fenix.covid.services.mosa.SocialStatusServlet;
import siren.fenix.covid.services.mosa.WorkTypeServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentAgriculturalServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentCommercialServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentCulturalServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentDemographyServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentEducationServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentElectricityServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentGarbageServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentGeneralServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentHealthServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentIndustrialServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentInfrastructureDetailsServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentSecurityServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentTourismServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentTransportationServlet;
import siren.fenix.covid.services.municipalityDevelopment.MunicipalityDevelopmentWaterServlet;
import siren.fenix.covid.services.quarantine.PersonTrackingLocationServlet;
import siren.fenix.covid.services.quarantine.QTBreakServlet;
import siren.fenix.covid.services.quarantine.QTHealthFollowupServlet;
import siren.fenix.covid.services.quarantine.QTMunicipalityApproveServlet;
import siren.fenix.covid.services.quarantine.QTMunicipalityCancelServlet;
import siren.fenix.covid.services.quarantine.QTMunicipalityPullServlet;
import siren.fenix.covid.services.quarantine.QTMunicipalityRejectServlet;
import siren.fenix.covid.services.quarantine.QTMunicipalityRequestServlet;
import siren.fenix.covid.services.quarantine.QTPersonApprovalServlet;
import siren.fenix.covid.services.quarantine.QTPersonFollowupServlet;
import siren.fenix.covid.services.quarantine.QTPersonLocationServlet;
import siren.fenix.covid.services.quarantine.QTPersonServlet;
import siren.fenix.covid.services.quarantine.QTPerson_Duplicate_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_HealthFollowup_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_Lab_CovidResults_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_Lab_Details_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_Lab_Followup_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_Lab_Servlet;
import siren.fenix.covid.services.quarantine.QTPerson_Lab_Validation_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessmentServlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_FamilyInfo_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_GeneralInfo_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_Header_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_ResidenceInfo_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_RoomInfo_Servlet;
import siren.fenix.covid.services.quarantine.QTResidentialAssessment_SelfService_Servlet;
import siren.fenix.covid.services.quarantine.QTServiceFollowupServlet;
import siren.fenix.covid.services.quarantine.QuarantineEssentialInfrastructureServlet;
import siren.fenix.covid.services.quarantine.QuarantineFloorServlet;
import siren.fenix.covid.services.quarantine.QuarantineGeneralInfoServlet;
import siren.fenix.covid.services.quarantine.QuarantineHeaderServlet;
import siren.fenix.covid.services.quarantine.QuarantineOtherServicesServlet;
import siren.fenix.covid.services.quarantine.QuarantineServlet;
import siren.fenix.covid.services.quarantine.QuarantineStaffRoomsServlet;
import siren.fenix.covid.services.quarantine.QuarantineWaterAndSanitationServlet;
import siren.fenix.covid.services.sponsor.SponsorServlet;
import siren.fenix.covid.services.syndicate.SyndicateDeliveryServlet;
import siren.fenix.covid.services.syndicate.SyndicateServlet;
import siren.fenix.covid.sponsor.SponsorMunicipality;

public class FenixCovidAPIServer {
	
	public static boolean noJWT = false;
	private static FenixCovidAPIServer fenixServer = null;

	private Server jettyServer = null; 
	
	public static FenixCovidAPIServer getInstance() {
		return fenixServer;
	}
			
	public static void main(String[] args) throws Exception {
		String sslAlias = null; 
		String logDir = null;
		int    port = 2500;
		int    maxThread = 10000;		
		
		if(args != null) {
			for(int i=0; i<args.length; i++) {
				String token = args[i];
				if(token.startsWith("https:")) {
					sslAlias = token.substring("https:".length());
				}
				
				if(token.startsWith("maxThread:")) {
					String maxThreadStr = token.substring("maxThread:".length());
					if(maxThreadStr != null) {
						maxThread = Utils.parseInteger(maxThreadStr, 10000);
					}
				}
				
				if(token.startsWith("port:")) {
					String portStr = token.substring("port:".length());
					if (portStr != null) {
						port = Utils.parseInteger(portStr, 2500);
					}
				}
				
				if(token.startsWith("logdir:")) {
					logDir = token.substring("logdir:".length());
				}
			}
			
			if(args.length > 0) {
				String value = args[0];
				if(value.startsWith("https:")) {
					sslAlias = value.substring("https:".length());
				}
			}
			if(args.length > 1) {
				noJWT = Boolean.valueOf(args[1]);
			}
		}
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Beirut"));
		fenixServer = new FenixCovidAPIServer();
		fenixServer.setCertificateAlias(sslAlias);
		fenixServer.setPort(port);
		fenixServer.setLogDir(logDir);
		fenixServer.setMaxThread(maxThread);
		fenixServer.start();
	}

	public void addServlets(ServletContextHandler contextHandler) {
		contextHandler.addServlet(LookupServlet.class, "/lookups");
		
		contextHandler.addServlet(ResetPasswordRequestServlet.class, "/reset_password_request");
		contextHandler.addServlet(ResetPasswordServlet.class, "/reset_password");
		
		contextHandler.addServlet(IncidentServlet.class, "/incidents");
		contextHandler.addServlet(IncidentTypeServlet.class, "/incidents/type");
		contextHandler.addServlet(IncidentPlaceServlet.class, "/incidents/place");
		
		contextHandler.addServlet(UploadImageServlet.class, "/upload");
		
		contextHandler.addServlet(MeasureTypeServlet.class, "/measures/type");
		contextHandler.addServlet(MeasureImportanceServlet.class, "/measures/importance");
		contextHandler.addServlet(MeasureServlet.class, "/measures");
		
		contextHandler.addServlet(NeedServlet.class, "/needs");
		contextHandler.addServlet(NeedTypeServlet.class, "/needs/type");		
		
		contextHandler.addServlet(LoginServlet.class, "/login");
		contextHandler.addServlet(LogoutServlet.class, "/logout");
		contextHandler.addServlet(UserProfileServlet.class, "/profile");
		//contextHandler.addServlet(ValidateTokenServlet.class, "/validate_token");
//		contextHandler.addServlet(MosaAidDeliveryServlet.class, "/mosa_aids/delivery");
		contextHandler.addServlet(UserProfileApproveLegalTermsServlet.class, "/approve_legal_terms"); 
		contextHandler.addServlet(GenerateGuestTokenServlet.class, "/generate_guest_token");
		contextHandler.addServlet(GuestLoginServlet.class, "/guest_login");
		
		contextHandler.addServlet(CitizenReportServlet.class, "/report/citizens");
		contextHandler.addServlet(ComplianceReportServlet.class, "/report/compliances");
		contextHandler.addServlet(RefugeeReportServlet.class, "/report/refugees");
		contextHandler.addServlet(LivingSituationReportServlet.class, "/report/situations");
		contextHandler.addServlet(ProcedureReportServlet.class, "/report/procedures");
		
		contextHandler.addServlet(CovidCaseServlet.class, "/covid_cases");
		contextHandler.addServlet(CovidCaseServlet_Old.class, "/covid_cases_old");
		
		contextHandler.addServlet(MosaAidServlet.class, "/mosa_aids");
		contextHandler.addServlet(MosaCitizenVerificationServlet.class, "/mosa_aids/verification");
		contextHandler.addServlet(FamilyRelationServlet.class, "/mosa_aids/family_relations");
		contextHandler.addServlet(IllnessTypeServlet.class, "/mosa_aids/illness_types");
		contextHandler.addServlet(MobilityTypeServlet.class, "/mosa_aids/mobility_types");
		contextHandler.addServlet(OwnershipTypeServlet.class, "/mosa_aids/ownership_types");
		contextHandler.addServlet(PropertyTypeServlet.class, "/mosa_aids/property_types");
		contextHandler.addServlet(SocialStatusServlet.class, "/mosa_aids/social_status");
		contextHandler.addServlet(EducationLevelServlet.class, "/mosa_aids/education_levels");
		contextHandler.addServlet(WorkTypeServlet.class, "/mosa_aids/work_types");
		contextHandler.addServlet(AidDeliveryServlet.class, "/mosa_aids/deliveries");
		contextHandler.addServlet(AidDeliveryServlet.class, "/deliveries");
		contextHandler.addServlet(EntityImageServlet.class, "/entity_images");
		
		contextHandler.addServlet(MunicipalityServlet.class, "/municipalities");
		contextHandler.addServlet(KadaaServlet.class, "/kadaa");
		contextHandler.addServlet(MouhafazaServlet.class, "/mouhafaza");
		
		contextHandler.addServlet(GenderServlet.class, "/genders");
		//contextHandler.addServlet(UserServlet.class, "/users");
		contextHandler.addServlet(GCCallServlet.class, "/gc");
		contextHandler.addServlet(ReloadServlet.class, "/reload");
		contextHandler.addServlet(StartupServlet.class, "/startup");
		contextHandler.addServlet(MobileAppVersionServlet.class, "/mobile_app_version");
		
		contextHandler.addServlet(SyndicateServlet.class, "/syndicate_members");
		contextHandler.addServlet(SyndicateDeliveryServlet.class, "/syndicate_delivery");
		
		
		contextHandler.addServlet(UserNotificationServlet.class, "/notifications");
		contextHandler.addServlet(PingServlet.class, "/ping");
		
		contextHandler.addServlet(QuarantineServlet.class, "/quarantine");
		contextHandler.addServlet(QuarantineHeaderServlet.class, "/quarantine/header");
		contextHandler.addServlet(QuarantineGeneralInfoServlet.class, "/quarantine/general_info");
		contextHandler.addServlet(QuarantineEssentialInfrastructureServlet.class, "/quarantine/essential_infrastructure");
		contextHandler.addServlet(QuarantineStaffRoomsServlet.class, "/quarantine/staff_rooms");
		contextHandler.addServlet(QuarantineWaterAndSanitationServlet.class, "/quarantine/water_sanitation");
		contextHandler.addServlet(QuarantineOtherServicesServlet.class, "/quarantine/other_services");
		contextHandler.addServlet(QuarantineFloorServlet.class, "/quarantine/floors");
		
		contextHandler.addServlet(QTPersonServlet.class, "/quarantine/persons");
		contextHandler.addServlet(QTPersonApprovalServlet.class, "/quarantine/persons/municipality_approval");

		//contextHandler.addServlet(QTPersonListServlet.class, "/quarantine/persons");
		contextHandler.addServlet(QTBreakServlet.class, "/quarantine/break");
		contextHandler.addServlet(QTPersonFollowupServlet.class, "/quarantine/break/followup");
		contextHandler.addServlet(QTHealthFollowupServlet.class, "/quarantine/health_followup");
		contextHandler.addServlet(QTPerson_HealthFollowup_Servlet.class, "/quarantine/health_followup/person");		
		contextHandler.addServlet(QTServiceFollowupServlet.class, "/quarantine/service_followup");
		contextHandler.addServlet(QTPersonLocationServlet.class, "/quarantine/person_location");
		contextHandler.addServlet(PersonTrackingLocationServlet.class, "/quarantine/person_tracking_location");
		
		contextHandler.addServlet(QTPerson_Lab_Servlet.class, "/quarantine/person_lab");
		contextHandler.addServlet(QTPerson_Lab_Details_Servlet.class, "/quarantine/person_lab/details");
		contextHandler.addServlet(QTPerson_Lab_Followup_Servlet.class, "/quarantine/person_lab/followup");
		contextHandler.addServlet(QTPerson_Lab_CovidResults_Servlet.class, "/quarantine/person_lab/tests");
		contextHandler.addServlet(QTPerson_Lab_Validation_Servlet.class, "/quarantine/person_lab/validation");		
		
		contextHandler.addServlet(QTResidentialAssessmentServlet.class, "/quarantine/residential_assessment");
		contextHandler.addServlet(QTResidentialAssessment_ResidenceInfo_Servlet.class, "/quarantine/residential_assessment/residence_info");
		contextHandler.addServlet(QTResidentialAssessment_Header_Servlet.class, "/quarantine/residential_assessment/header");
		contextHandler.addServlet(QTResidentialAssessment_GeneralInfo_Servlet.class, "/quarantine/residential_assessment/general_info");		
		contextHandler.addServlet(QTResidentialAssessment_RoomInfo_Servlet.class, "/quarantine/residential_assessment/room_info");
		contextHandler.addServlet(QTResidentialAssessment_SelfService_Servlet.class, "/quarantine/residential_assessment/self_service");
		contextHandler.addServlet(QTResidentialAssessment_FamilyInfo_Servlet.class, "/quarantine/residential_assessment/family_info");
		
		contextHandler.addServlet(QTMunicipalityRequestServlet.class, "/quarantine/residential_assessment/residence_info/change_municipality");
		contextHandler.addServlet(QTMunicipalityApproveServlet.class, "/quarantine/residential_assessment/residence_info/change_municipality/approve");
		contextHandler.addServlet(QTMunicipalityRejectServlet.class, "/quarantine/residential_assessment/residence_info/change_municipality/reject");
		contextHandler.addServlet(QTMunicipalityCancelServlet.class, "/quarantine/residential_assessment/residence_info/change_municipality/cancel");
		contextHandler.addServlet(QTMunicipalityPullServlet.class, "/quarantine/residential_assessment/residence_info/pull_municipality");
		contextHandler.addServlet(QTPerson_Duplicate_Servlet.class, "/quarantine/person/duplicates");
		
		contextHandler.addServlet(QTTokenGenerateServlet.class, "/quarantine/person/generate_token");
		contextHandler.addServlet(QTPersonLoginServlet.class, "/quarantine/person/login");
		contextHandler.addServlet(QTPersonQuarantineLocationServlet.class, "/quarantine/person/quarantine_location");
		contextHandler.addServlet(QTPersonLocationsServlet.class, "/quarantine/person/locations");
		contextHandler.addServlet(QTPersonContactedPersonsServlet.class, "/quarantine/person/contacted_persons");
		contextHandler.addServlet(QTPersonVerificationCodeServlet.class, "/quarantine/person/otp");
		
		contextHandler.addServlet(HumanResourceServlet.class, "/human_resource");
		contextHandler.addServlet(HumanResourceAcademicCertificateServlet.class, "/human_resource/academic_certificates");
		contextHandler.addServlet(HumanResourceOccupationServlet.class, "/human_resource/occupations");
		contextHandler.addServlet(HumanResourceCurrentOccupationServlet.class, "/human_resource/current_occupation");
		contextHandler.addServlet(HumanResourceTaskServlet.class, "/human_resource/task");
		contextHandler.addServlet(HumanResourceSignUpServlet.class, "/human_resource/sign_up");
		contextHandler.addServlet(HumanResourceVerificationServlet.class, "/human_resource/sign_up/verification");
		contextHandler.addServlet(HumanResourcePercentageServlet.class, "/human_resource/percentage");		
		contextHandler.addServlet(AdministrationLegalMandateServlet.class, "/human_resource/administration/legal_mandate");
		contextHandler.addServlet(PublicUnitServlet.class, "/human_resource/administration/public_unit");
		
		contextHandler.addServlet(DashboardServlet.class, "/dashboard");
		contextHandler.addServlet(ChartsServlet.class, "/charts");

		contextHandler.addServlet(MunicipalityVacancyServlet.class, "/municipality_vacancy");
		
		contextHandler.addServlet(ForestFireServlet.class, "/forest_fire");
		contextHandler.addServlet(ForestFire_LocationInfo_Servlet.class, "/forest_fire/location_info");
		contextHandler.addServlet(ForestFire_EquipmentInfo_Servlet.class, "/forest_fire/equipment_info");
		contextHandler.addServlet(ForestFire_RoadsInfo_Servlet.class, "/forest_fire/road_info");
		contextHandler.addServlet(ForestFire_ForestInfo_Servlet.class, "/forest_fire/forest_info");
		contextHandler.addServlet(ForestFire_SupportInfo_Servlet.class, "/forest_fire/support_info");
		contextHandler.addServlet(ForestFire_ToolsInfo_Servlet.class, "/forest_fire/tool_info");
		contextHandler.addServlet(ForestFire_WaterSourceInfo_Servlet.class, "/forest_fire/water_source_info");
		
		contextHandler.addServlet(AgriculturalPropertyServlet.class, "/agricultural_property");
		
		contextHandler.addServlet(BeirutAidServlet.class, "/beirut_aid");
		
		contextHandler.addServlet(DamageAssessmentServlet.class, "/damage_assessment");
		
		contextHandler.addServlet(ExpAffectedHouseholdServlet.class, "/explosion_affected_household");
		contextHandler.addServlet(ExpAffectedHouseholdServletGeneralInfo.class, "/explosion_affected_household/general_info");
		contextHandler.addServlet(ExpAffectedHouseholdAccessToHealthcareServlet.class, "/explosion_affected_household/healthcare_access");
		contextHandler.addServlet(ExpAffectedHouseholdAccessToWaterServlet.class, "/explosion_affected_household/water_access");
		contextHandler.addServlet(ExpAffectedHouseholdAssetsServlet.class, "/explosion_affected_household/assets");
		contextHandler.addServlet(ExpAffectedHouseholdDetailsServlet.class, "/explosion_affected_household/details");
		contextHandler.addServlet(ExpAffectedHouseholdShelterServlet.class, "/explosion_affected_household/shelter");
		contextHandler.addServlet(ExpAffectedHouseholdFollowupServlet.class, "/explosion_affected_household/followup");
		
		// MunicipalityDevelopment
		contextHandler.addServlet(MunicipalityDevelopmentServlet.class, "/municipality_development");
		contextHandler.addServlet(MunicipalityDevelopmentGeneralServlet.class, "/municipality_development/general_info");
		contextHandler.addServlet(MunicipalityDevelopmentDemographyServlet.class, "/municipality_development/demography_info");
		contextHandler.addServlet(MunicipalityDevelopmentElectricityServlet.class, "/municipality_development/electricity_info");
		contextHandler.addServlet(MunicipalityDevelopmentWaterServlet.class, "/municipality_development/water_info");
		contextHandler.addServlet(MunicipalityDevelopmentGarbageServlet.class, "/municipality_development/garbage_info");
		contextHandler.addServlet(MunicipalityDevelopmentTransportationServlet.class, "/municipality_development/transportation_info");
		contextHandler.addServlet(MunicipalityDevelopmentEducationServlet.class, "/municipality_development/education_info");
		contextHandler.addServlet(MunicipalityDevelopmentHealthServlet.class, "/municipality_development/health_info");
		contextHandler.addServlet(MunicipalityDevelopmentTourismServlet.class, "/municipality_development/tourism_info");
		contextHandler.addServlet(MunicipalityDevelopmentAgriculturalServlet.class, "/municipality_development/agriculture_info");
		contextHandler.addServlet(MunicipalityDevelopmentIndustrialServlet.class, "/municipality_development/industrial_info");		
		contextHandler.addServlet(MunicipalityDevelopmentCommercialServlet.class, "/municipality_development/commercial_info");
		contextHandler.addServlet(MunicipalityDevelopmentCulturalServlet.class, "/municipality_development/cultural_info");
		contextHandler.addServlet(MunicipalityDevelopmentSecurityServlet.class, "/municipality_development/security_info");
		contextHandler.addServlet(MunicipalityDevelopmentInfrastructureDetailsServlet.class, "/municipality_development/infrastructure_details_info");

		//Public App
		contextHandler.addServlet(PADashboardServlet.class, "/padashboard");
		contextHandler.addServlet(PAChartsServlet.class, "/pacharts");
		contextHandler.addServlet(PALookupServlet.class, "/palookups");
		contextHandler.addServlet(PAIncidentServlet.class, "/public_administration/incidents");
		contextHandler.addServlet(PANeedServlet.class, "/public_administration/needs");
		contextHandler.addServlet(PAMeasureServlet.class, "/public_administration/measures");		
		contextHandler.addServlet(PAChartsServlet.class, "/public_administration/charts");
		contextHandler.addServlet(PAMinisterialMeasuresServlet.class, "/public_administration/ministerial_measures");		

		// Blob upload download		
		contextHandler.addServlet(BlobServlet.class, "/blobs");
		contextHandler.addServlet(PhotoAlbumServlet.class, "/photos");
		
		//Miniterial Measures
		contextHandler.addServlet(MinisterialMeasureServlet.class, "/ministerial_measure");
		
		contextHandler.addServlet(IndustryFactoryServlet.class, "/industry_factory");
		
		//Sponsors
		contextHandler.addServlet(SponsorServlet.class, "/sponsor");
	}

	// -----------------------------------------------------
	// -----------------------------------------------------
	// -----------------------------------------------------

	private int    port = 0;
	private int    maxThread = 0;
	private String certificateAlias = null;
	private String firstCallService = "startup";//"gc";
	private String logDir = null;
	
	public void start() throws Exception {
		initJsonFieldFilter();
		
		ServletContextHandler contextHandler = new ServletContextHandler(ServletContextHandler.SESSIONS);
		contextHandler.setSessionHandler(new SessionHandler());
		addServlets(contextHandler);
		
		// contextHandler.setInitParameter("allowedOrigins", "*");
		// contextHandler.setInitParameter("allowedMethods", "GET, POST");


		//With Log
		//-------- 
		HandlerCollection handlers = new HandlerCollection();
				
		// log using NCSA (common log format)
		// http://en.wikipedia.org/wiki/Common_Log_Format
		NCSARequestLog requestLog = new NCSARequestLog();
		requestLog.setFilename(getLogDir()+"/yyyy_mm_dd.request.log");//"/tmp/jetty/yyyy_mm_dd.request.log"
		requestLog.setFilenameDateFormat("yyyy_MM_dd");
		requestLog.setRetainDays(90);
		requestLog.setAppend(true);
		requestLog.setExtended(true);
		requestLog.setLogCookies(false);
		requestLog.setLogTimeZone(TimeZone.getDefault().getID());
		RequestLogHandler requestLogHandler = new RequestLogHandler();
		requestLogHandler.setRequestLog(requestLog);
		
		handlers.addHandler(contextHandler);
		handlers.addHandler(requestLogHandler);

		jettyServer = new Server(port);
		jettyServer.setHandler(handlers);

//		QueuedThreadPool threadPool = new QueuedThreadPool();
//		threadPool.setMaxThreads(getMaxThread());
//		threadPool.setMinThreads(8);
//		jettyServer.setThreadPool(threadPool);
//		jettyServer = new Server(threadPool);
		
//		jettyServer.set

		//--------
		
//		Server server = new Server(port);
//		server.setHandler(contextHandler);
		
		if(!Utils.isStringEmpty(certificateAlias)) configureSSL(jettyServer);

		jettyServer.start();
		Thread th = new Thread(new Runnable() {
			@Override
			public void run() {
				try{
					Thread.sleep(1000);
					firstCall();
				}catch (InterruptedException e){
					e.printStackTrace();
				}
			}
		});
		th.start();
		jettyServer.join();
	}
	
	public String getHtml() {
		//String threadPool = jettyServer != null && jettyServer.getThreadPool() != null ? jettyServer.getThreadPool().toString() : null;
		QueuedThreadPool threadPool = jettyServer != null ? (QueuedThreadPool) jettyServer.getThreadPool() : null;
		
		String str = "";
		if (threadPool != null) {
			str = "<h3>";
			str += " State: "+threadPool.getState()+"<br>";
			str += " Threads: "+threadPool.getMinThreads()+" &lt; "+ threadPool.getThreads()+" &lt; "+threadPool.getMaxThreads()+"<br>";
			str += " Idle thread: "+threadPool.getIdleThreads()+" / "+threadPool.getThreads()+"<br>";
			str += "</h3><br>";
			str += threadPool.toString();
		}
//		(_jobs == null ? -1 : _jobs.size()));
		
		return str;
	}
	
	private void configureSSL(Server server) {
		Globals.logString("checking : configureSSLIfRequired()");
			
		Globals.logString("https configuring");
		
		HttpConfiguration http_config = new HttpConfiguration();
		http_config.setSecureScheme("https");
		http_config.setSecurePort(port);
		
		HttpConfiguration https_config = new HttpConfiguration(http_config);
		https_config.addCustomizer(new SecureRequestCustomizer());	      
		
		SslContextFactory sslContextFactory = new SslContextFactory("/home/carole/.keystore");
		sslContextFactory.setKeyStorePassword("changeit");
		sslContextFactory.setCertAlias(certificateAlias);
		//sslContextFactory.setKeyStoreType("RSA");
		
		ServerConnector httpsConnector = new ServerConnector(server, 
				new SslConnectionFactory(sslContextFactory, "http/1.1"),
				new HttpConnectionFactory(https_config));
		httpsConnector.setPort(port);
//				httpsConnector.setIdleTimeout(50000);	  			
		
		server.setConnectors(new Connector[]{ httpsConnector });
		Globals.logString("https setting server connector successfully");
	}

	private void firstCall() {
		String url = "http://localhost:" + port + "/" + firstCallService;
		if (!Utils.isStringEmpty(certificateAlias)) {
			url = "https://localhost:" + port + "/" + firstCallService;	
		}
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet request = new HttpGet(url);

		try{
			HttpResponse response = client.execute(request);
		}catch (Exception e){
			Globals.logException(e);
		}
	}

	public static void setCORS(HttpServletResponse response) {
		if(response != null){
			// The following are CORS headers. Max age informs the
			// browser to keep the results of this call for 1 day.
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS,  DELETE");
			response.setHeader("Access-Control-Allow-Headers", "Content-Type, X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Date, X-Api-Version, X-File-Name, X-Pagination, Content-Disposition, showLoader");
			response.setHeader("Access-Control-Expose-Headers", "Content-Type, X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Date, X-Api-Version, X-File-Name, X-Pagination, Content-Disposition, showLoader");
			response.setHeader("Access-Control-Max-Age", "86400");
			// Tell the browser what requests we allow.
			response.setStatus(HttpServletResponse.SC_OK);
		}

		// setCORS(response); // required by angular framework; detailed CORS can be
		// set within the servlet
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getCertificateAlias() {
		return certificateAlias;
	}

	public void setCertificateAlias(String httpsAlias) {
		this.certificateAlias = httpsAlias;
	}

	public String getFirstCallService() {
		return firstCallService;
	}

	public void setFirstCallService(String firstCallService) {
		this.firstCallService = firstCallService;
	}
	
	public void initJsonFieldFilter() {
		JSONFieldFilter filter = new JSONFieldFilter();

		filter.putField(EntityImagePage.DBNAME, EntityImagePage.FIELD_EntityImage);
		
		filter.putField(MosaAid.DBNAME, MosaAid.FIELD_HistoryList);
		
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_City);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_Country);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_State);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_County);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_Road);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_Village);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_Lat);
		filter.putField(Municipality.DBNAME, GeoRegion.FIELD_Lng);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_PCODE);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_NAME_EN);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_ID);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Address);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Phone);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Elev);	
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Gov_Name);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Gov_Name_Ar);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_CAD_CODE);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_CAD_Type);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_CAS_CODE);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_CAS_Name);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_CAS_Name_Ar);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_UN_Area);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_UN_Area_Ar);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_UN_CODE);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_UNION_ID);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_Union_Name);
		filter.putField(Municipality.DBNAME, Municipality.FIELD_UOM_Name);
		
		filter.putField(MunicipalityVacancy.DBNAME, MunicipalityVacancy.FIELD_Municipality);
		
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_City);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_Country);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_State);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_County);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_Road);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_Village);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_Lat);
		filter.putField(Kadaa.DBNAME, GeoRegion.FIELD_Lng);
		filter.putField(Kadaa.DBNAME, Kadaa.FIELD_NAME_EN);

		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_City);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_Country);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_State);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_County);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_Road);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_Village);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_Lat);
		filter.putField(Mouhafaza.DBNAME, GeoRegion.FIELD_Lng);
		filter.putField(Mouhafaza.DBNAME, Mouhafaza.FIELD_NAME_EN);

		filter.putField(QTPerson.DBNAME, QTPerson.FIELD_CreationUser);
		filter.putField(QTResidentialAssessment.DBNAME, QTResidentialAssessment.FIELD_QTPerson);
		filter.putField(QTResidentialAssessmentFamily.DBNAME, QTResidentialAssessmentFamily.FIELD_QTResidentialAssessment);
		filter.putField(QTBreak.DBNAME, QTBreak.FIELD_QTPerson);
		filter.putField(QTPersonFollowup.DBNAME, QTPersonFollowup.FIELD_QTPerson);
		filter.putField(QTHealthFollowup.DBNAME, QTHealthFollowup.FIELD_QTPerson);
		filter.putField(QTHealthFollowup.DBNAME, QTHealthFollowup.FIELD_User);
		filter.putField(QTFollowupSymptom.DBNAME, QTFollowupSymptom.FIELD_QTHealthFollowup);
		filter.putField(QTServiceFollowup.DBNAME, QTServiceFollowup.FIELD_QTPerson);
		filter.putField(QTPersonCovidTest.DBNAME, QTPersonCovidTest.FIELD_QTPerson);
		filter.putField(QTPreviousCovidExam.DBNAME, QTPreviousCovidExam.FIELD_QTPerson);
		filter.putField(QTPersonLabSymptom.DBNAME, QTPersonLabSymptom.FIELD_QTPerson);
		filter.putField(QTPersonCovidTestReason.DBNAME, QTPersonCovidTestReason.FIELD_QTPerson);

		filter.putField(HumanResourceOccupation.DBNAME, HumanResourceOccupation.FIELD_HumanResource);
		filter.putField(HumanResourceAcademicCertificate.DBNAME, HumanResourceAcademicCertificate.FIELD_HumanResource);

		filter.putField(ForestFire.DBNAME, ForestFire.FIELD_CreationUser);
		filter.putField(ForestFireSupportingParty.DBNAME, ForestFireSupportingParty.FIELD_ForestFire);
		filter.putField(ForestFireFightingTool.DBNAME, ForestFireFightingTool.FIELD_ForestFire);
		filter.putField(ForestPersonalProtectionTool.DBNAME, ForestPersonalProtectionTool.FIELD_ForestFire);
		filter.putField(ForestWaterSource.DBNAME, ForestWaterSource.FIELD_ForestFire);

		filter.putField(AgriculturalProperty.DBNAME, AgriculturalProperty.FIELD_CreationUser);

		filter.putField(BeirutAid.DBNAME, BeirutAid.FIELD_CreationUser);
		filter.putField(BeirutAidServiceType.DBNAME, BeirutAidServiceType.FIELD_BeirutAid);
		filter.putField(BeirutAidHousingService.DBNAME, BeirutAidHousingService.FIELD_BeirutAid);
		filter.putField(BeirutAidFoodService.DBNAME, BeirutAidFoodService.FIELD_BeirutAid);
		filter.putField(BeirutAidHealthService.DBNAME, BeirutAidHealthService.FIELD_BeirutAid);
		filter.putField(BeirutAidRepairService.DBNAME, BeirutAidRepairService.FIELD_BeirutAid);

		filter.putField(DamageAssessment.DBNAME, DamageAssessment.FIELD_CreationUser);

		filter.putField(ExpAffectedHousehold.DBNAME, ExpAffectedHousehold.FIELD_CreationUser);
		filter.putField(ExpHHStructureConditionList.DBNAME, ExpHHStructureConditionList.FIELD_ExpAffectedHousehold);
		filter.putField(ExpHHWindowConditionList.DBNAME, ExpHHWindowConditionList.FIELD_ExpAffectedHousehold);
		filter.putField(ExpHHDrinkingWaterSourceList.DBNAME, ExpHHDrinkingWaterSourceList.FIELD_ExpAffectedHousehold);
		filter.putField(ExpHHWashingWaterSourceList.DBNAME, ExpHHWashingWaterSourceList.FIELD_ExpAffectedHousehold);

		filter.putField(MunicipalityDevelopment.DBNAME, MunicipalityDevelopment.FIELD_CreationUser);
		filter.putField(MunDevAgriculturalProject.DBNAME, MunDevAgriculturalProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevAgriculturalResource.DBNAME, MunDevAgriculturalResource.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevAgriProductDistribution.DBNAME, MunDevAgriProductDistribution.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevAlternateEnergyType.DBNAME, MunDevAlternateEnergyType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevArchaeologicalMonument.DBNAME, MunDevArchaeologicalMonument.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevBakeryShopType.DBNAME, MunDevBakeryShopType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevChronicDisease.DBNAME, MunDevChronicDisease.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevClothingType.DBNAME, MunDevClothingType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevCommerceType.DBNAME, MunDevCommerceType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevCommercialProject.DBNAME, MunDevCommercialProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevCulturalAssociation.DBNAME, MunDevCulturalAssociation.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevCulturalProject.DBNAME, MunDevCulturalProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevDrinkWaterSource.DBNAME, MunDevDrinkWaterSource.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevEducationalProject.DBNAME, MunDevEducationalProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevEducationalResource.DBNAME, MunDevEducationalResource.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevFinancialInstitution.DBNAME, MunDevFinancialInstitution.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevGarbageDestination.DBNAME, MunDevGarbageDestination.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevHealthProject.DBNAME, MunDevHealthProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevHealthResource.DBNAME, MunDevHealthResource.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevIndProductDistribution.DBNAME, MunDevIndProductDistribution.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevIndustrialProject.DBNAME, MunDevIndustrialProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevInfraStructureProject.DBNAME, MunDevInfraStructureProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevInstitute.DBNAME, MunDevInstitute.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevIrrigationWaterSource.DBNAME, MunDevIrrigationWaterSource.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevNaturalMonument.DBNAME, MunDevNaturalMonument.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevOtherIndustryType.DBNAME, MunDevOtherIndustryType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevPublicTransportation.DBNAME, MunDevPublicTransportation.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevSecurityProject.DBNAME, MunDevSecurityProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevSewageNetwork.DBNAME, MunDevSewageNetwork.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevSoilThreat.DBNAME, MunDevSoilThreat.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevSolarEnergyUsage.DBNAME, MunDevSolarEnergyUsage.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevSportFieldType.DBNAME, MunDevSportFieldType.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevTouristicProject.DBNAME, MunDevTouristicProject.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevWasteCollectingAgency.DBNAME, MunDevWasteCollectingAgency.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevAnnualCelebration.DBNAME, MunDevAnnualCelebration.FIELD_MunicipalityDevelopment);
		filter.putField(MunDevExpatsDestinationContinent.DBNAME, MunDevExpatsDestinationContinent.FIELD_MunicipalityDevelopment);

		filter.putField(ExpHHFollowup.DBNAME, ExpHHFollowup.FIELD_FollowupUser);
		filter.putField(ExpHHFollowup.DBNAME, ExpHHFollowup.FIELD_FollowupUser);

		filter.putField(MinisterialMeasureStakeholder.DBNAME, MinisterialMeasureStakeholder.FIELD_MinisterialMeasure);
		filter.putField(PropertyVegeterianExploitation.DBNAME, PropertyVegeterianExploitation.FIELD_AgriculturalProperty);
		filter.putField(PropertyAnimalExploitation.DBNAME, PropertyAnimalExploitation.FIELD_AgriculturalProperty);
		
		filter.putField(SponsorMunicipality.DBNAME, SponsorMunicipality.FIELD_Sponsor);
		//filter.putField(SponsorMunicipality.DBNAME, SponsorMunicipality.FIELD_Municipality);

		filter.putField(IndustryFactoryClientNationality.DBNAME, IndustryFactoryClientNationality.FIELD_IndustryFactory);
		filter.putField(IndustryFactoryProductType.DBNAME, IndustryFactoryClientNationality.FIELD_IndustryFactory);

		filter.putField(SuspectedPeople.DBNAME, SuspectedPeople.FIELD_QTPerson);
		filter.putField(SuspectedPeople.DBNAME, SuspectedPeople.FIELD_CovidCase);
		
		filter.putField(QTPersonFlow.DBNAME, QTPersonFlow.FIELD_User);
		filter.putField(QTPersonFlow.DBNAME, QTPersonFlow.FIELD_QTPerson);

		filter.putField(HumanResourceNationality.DBNAME, HumanResourceNationality.FIELD_HumanResource);

		filter.putField(QuarantineFloor.DBNAME, QuarantineFloor.FIELD_Quarantine);
		
		B01JsonBuilder.setFieldFilter(filter);
	}

	public String getLogDir() {
		return logDir;
	}

	public void setLogDir(String logDir) {
		this.logDir = logDir;
	}

	public int getMaxThread() {
		return maxThread;
	}

	public void setMaxThread(int maxThread) {
		this.maxThread = maxThread;
	}
}