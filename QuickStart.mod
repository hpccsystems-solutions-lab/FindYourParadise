//Import:ecl:ParadiseHackathon.BWR_BrowseInputData
IMPORT $;
OUTPUT($.File_PublicSchools.File,NAMED('PublicSchools'));
OUTPUT(COUNT($.File_PublicSchools.File),NAMED('Cnt_Public'));

OUTPUT($.File_PrivateSchools.File,NAMED('PrivateSchools'));
OUTPUT(COUNT($.File_PrivateSchools.File),NAMED('CntPrivate'));

OUTPUT($.File_Crimes.File,NAMED('Crimes'));
OUTPUT(COUNT($.File_Crimes.File),NAMED('Cnt_AllCrimes'));

OUTPUT($.File_Crimes.File2,NAMED('VCrimes'));
OUTPUT(COUNT($.File_Crimes.File2),NAMED('Cnt_VCrimes'));

OUTPUT($.File_Mortality.File,NAMED('Mortality'));
OUTPUT(COUNT($.File_Mortality.File),NAMED('Cnt_Mortality'));

OUTPUT($.File_Weather.File,NAMED('Storms'));
OUTPUT(COUNT($.File_Weather.File),NAMED('Cnt_Storms'));

OUTPUT($.File_StateFIPS.File,NAMED('FIPSLookup'));
OUTPUT(COUNT($.File_StateFIPS.File),NAMED('Cnt_FIPS'));




//Import:ecl:ParadiseHackathon.File_AllSchools
EXPORT File_AllSchools := MODULE
EXPORT Layout := RECORD
    UNSIGNED8 RecID;
    BOOLEAN   Public;
    REAL8     x;
    REAL8     y;
    STRING6   fid;
    UNSIGNED4 districtid;
    UNSIGNED3 objectid;
    STRING12  ncesid;
    STRING60  name;
    STRING56  address;
    STRING26  city;
    STRING2   state;
    STRING5   zip;
    STRING13  zip4;
    STRING14  telephone;
    UNSIGNED1 type;
    UNSIGNED1 status;
    INTEGER3  population;
    STRING21  county;
    STRING5   countyfips;
    STRING3   country;
    REAL8     latitude;
    REAL8     longitude;
    UNSIGNED3 naics_code;
    STRING32  naics_desc;
    STRING79  source;
    STRING19  sourcedate;
    STRING13  val_method;
    STRING19  val_date;
    STRING80  website;
    STRING15  level;
    INTEGER3  enrollment;
    STRING2   start_grad;
    STRING2   end_grade;
    INTEGER2  ft_teacher;
    STRING13  shelter_id;
END;

EXPORT File := DATASET('~BMF::OUT::AllUSSchools',Layout,THOR);

END;
//Import:ecl:ParadiseHackathon.File_Composite
//THE HIGHER THE SCORE, THE BETTER THE PARADISE!
EXPORT File_Composite := MODULE
//Crime
 EXPORT CrimeScoreRec := RECORD
  STRING2   State;
  REAL4     ViolentCompRat;
  REAL4     PropCompRat;
  UNSIGNED1 ViolentScore;
  UNSIGNED1 PropCrimeScore;
 END;
 
 EXPORT CrimeScoreDS := DATASET('~BMF::hackathon::CrimeScores',CrimeScoreRec,FLAT);

//Education
 EXPORT EduScoreRec := RECORD
  STRING2   State;
  integer8  PubCnt;
  integer8  PrvCnt;
  real8     AveSTratio;
  UNSIGNED1 StudentTeacherScore;
  UNSIGNED1 PrvSchoolScore;
  UNSIGNED1 PublicSchoolScore;
 END;

 EXPORT EduScoreDS := DATASET('~bmf::hackathon::educationscores',EduScoreRec,FLAT);
 
 //Health
 EXPORT MortScoreRec := RECORD
  STRING2    State;
  DECIMAL5_2 Sumcum;
  DECIMAL5_2 Maxcum;
  DECIMAL5_2 Mincum;
  UNSIGNED1  Mortalityscore;
 END;

 EXPORT MortScoreDS := DATASET('~bmf::hackathon::lifescore',MortScoreRec,FLAT);
 
//Weather
 EXPORT WeatScoreRec := RECORD
  string2 state;
  unsigned2 evtsum;
  unsigned2 injsum;
  unsigned2 fatsum;
  unsigned1 evtscore;
  unsigned1 injscore;
  unsigned1 fatscore;
 END;
 
 EXPORT WeatherScoreDS := DATASET('~bmf::hackathon::weatherscores',WeatScoreRec,FLAT);
 
EXPORT Layout := RECORD
  string2  state;
  string20 StateName;
  //ParadiseAggregate
  UNSIGNED2 ParadiseScore;
  //Education Data
  // integer8 stcnt;
  integer8 pubcnt;
  integer8 prvcnt;
  // decimal5_2 prpubrat;
  real8 avestratio;
  UNSIGNED1 StudentTeacherScore;
  UNSIGNED1 PrvSchoolScore;
  UNSIGNED1 PublicSchoolScore;
  //Crime Data
  // real4 violentcrimeratio;
  // real4 homiciderat;
  // real4 raperat;
  // real4 agg_assaultrat;
  real4 violentcomprat; //aggregate of the above 
  // real4 robberyrat;
  // real4 prop_crimerat;
  // real4 burglaryrat;
  // real4 larcenyrat;
  // real4 veh_theftrat;
  real4 propcomprat; //aggregate of the above
  UNSIGNED1 ViolentScore;
  UNSIGNED1 PropCrimeScore;
  //Mortality (Health) Data
  DECIMAL5_2 sumcum;
  DECIMAL5_2 maxcum;
  DECIMAL5_2 mincum;
  UNSIGNED1 MortalityScore;
  //Weather Data
  // UNSIGNED1 sevcode;
  UNSIGNED2 evtsum;
  UNSIGNED2 injsum;
  UNSIGNED2 fatsum;
  UNSIGNED1 EvtScore;
  UNSIGNED1 InjScore;
  UNSIGNED1 FatScore;
 END;
 EXPORT File    := DATASET('~BMF::Hackathon::ParadiseScores',Layout,THOR);
 EXPORT IDX     := INDEX(File,{ParadiseScore},{File},'~BMF::Hackathoin::ParadiseIndex');
 EXPORT BLD_IDX := BUILD(IDX,OVERWRITE);
END;


//Import:ecl:ParadiseHackathon.File_Crimes
EXPORT File_Crimes := MODULE
/* This dataset contains estimated data at the state and national level and was derived from the Summary Reporting System (SRS). 
   These data reflect the estimates the FBI has traditionally included in its annual publications. 
   Download this dataset to see the FBI's estimated crime totals for the nation and all 50 states, 1979 to current year available.
   Source: https://crime-data-explorer.app.cloud.gov/pages/downloads
*/
 EXPORT Layout := RECORD
  UNSIGNED2 year;
  STRING2   state_abbr;
  STRING20  state_name;
  UNSIGNED5 population;
  UNSIGNED4 violent_crime;
  UNSIGNED3 homicide;
  UNSIGNED3 rape_legacy;
  UNSIGNED3 rape_revised;
  UNSIGNED3 robbery;
  UNSIGNED4 aggravated_assault;
  UNSIGNED4 property_crime;
  UNSIGNED4 burglary;
  UNSIGNED4 larceny;
  UNSIGNED4 motor_vehicle_theft;
  STRING577 caveats;
 END;

EXPORT File := DATASET('~bmf::uga::estimated_crimes_1979_2020',Layout,CSV(HEADING(1)));


/* This optional data set contains statistics, in arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas.
   A data frame with 50 observations on 4 variables.
   
   Murder is numeric and Murder arrests (per 100,000)
   Assault is numeric and Assault arrests (per 100,000)
   UrbanPop is numeric and UrbanPop arrests (per 100,000)
   Rape is numeric and Rape arrests (per 100,000)
*/
 EXPORT Layout2 := RECORD
    STRING State;
    STRING Murder;
    STRING Assault;
    STRING UrbanPop;
    STRING Rape;
 END;
 EXPORT File2 := DATASET('~bmf::kaggle::us_violent_crime_summary_by_state',layout2,CSV(HEADING(1)));

END;
//Import:ecl:ParadiseHackathon.File_Mortality
/* IHME United States Mortality Rates by County 1980-2014: National - All. (Deaths per 100,000 population)
   https://www.kaggle.com/datasets/IHME/us-countylevel-mortality
   License: 
   This Dataset was provided by IHME
   Institute for Health Metrics and Evaluation
   Data made available for download on IHME Websites can be used, shared, modified or built upon by non-commercial users in accordance with the IHME FREE-OF-CHARGE
*/

EXPORT File_Mortality := MODULE
EXPORT Layout := RECORD
    STRING42 Location;
    STRING5 FIPS;
    STRING65 Category;
    REAL4 Mortality_Rate__1980_;
    REAL4 Mortality_Rate__1980___Min_;
    REAL4 Mortality_Rate__1980___Max_;
    REAL4 Mortality_Rate__1985_;
    REAL4 Mortality_Rate__1985___Min_;
    REAL4 Mortality_Rate__1985___Max_;
    REAL4 Mortality_Rate__1990_;
    REAL4 Mortality_Rate__1990___Min_;
    REAL4 Mortality_Rate__1990___Max_;
    REAL4 Mortality_Rate__1995_;
    REAL4 Mortality_Rate__1995___Min_;
    REAL4 Mortality_Rate__1995___Max_;
    REAL4 Mortality_Rate__2000_;
    REAL4 Mortality_Rate__2000___Min_;
    REAL4 Mortality_Rate__2000___Max_;
    REAL4 Mortality_Rate__2005_;
    REAL4 Mortality_Rate__2005___Min_;
    REAL4 Mortality_Rate__2005___Max_;
    REAL4 Mortality_Rate__2010_;
    REAL4 Mortality_Rate__2010___Min_;
    REAL4 Mortality_Rate__2010___Max_;
    REAL4 Mortality_Rate__2014_;
    REAL4 Mortality_Rate__2014___Min_;
    REAL4 Mortality_Rate__2014___Max_;
    REAL4 Change_in_Mortality_Rate__1980_2014;
    REAL4 Change_in_Mortality_Rate__1980_2014__Min_;
    REAL4 Change_in_Mortality_Rate__1980_2014__Max_;
END;

EXPORT File := DATASET('~bmf::kaggle::mortalitybyuscounty',layout,CSV(HEADING(1)));
END;
//Import:ecl:ParadiseHackathon.File_PrivateSchools
/* This dataset, taken from the US Department of Homeland Security, 
   contains information on all public and private schools with attributes regarding their geographical distribution.
   License: Public Domain
*/
EXPORT File_PrivateSchools := MODULE
EXPORT Layout := RECORD
    STRING X;
    STRING Y;
    STRING FID; //Unique to Private 
    STRING OBJECTID;
    STRING NCESID;
    STRING NAME;
    STRING ADDRESS;
    STRING CITY;
    STRING STATE;
    STRING ZIP;
    STRING ZIP4;
    STRING TELEPHONE;
    STRING TYPE;
    STRING STATUS;
    STRING POPULATION;
    STRING COUNTY;
    STRING COUNTYFIPS;
    STRING COUNTRY;
    STRING LATITUDE;
    STRING LONGITUDE;
    STRING NAICS_CODE;
    STRING NAICS_DESC;
    STRING SOURCE;
    STRING SOURCEDATE;
    STRING VAL_METHOD;
    STRING VAL_DATE;
    STRING WEBSITE;
    STRING LEVEL_;
    STRING ENROLLMENT;
    STRING START_GRAD;
    STRING END_GRADE;
    STRING FT_TEACHER;
    STRING SHELTER_ID;
END;

EXPORT File := DATASET('~bmf::kaggle::private_schoolsus',layout,CSV(HEADING(1)));

END;
//Import:ecl:ParadiseHackathon.File_PublicSchools
/* This dataset was downloaded on March 23, 2019 from: https://hifld-geoplatform.opendata.arcgis.com/datasets/87376bdb0cb3490cbda39935626f6604_0
   
   This dataset is provided by the Homeland Infrastructure Foundation-Level Data (HIFLD) without a license and for Public Use.
   
   HIFLD Open GP - Education
   Shared By: jrayer_geoplatform
   Data Source: services1.arcgis.com
   
   Users are advised to read the data set's metadata thoroughly to understand appropriate use and data limitations.
*/
EXPORT File_PublicSchools := MODULE
EXPORT Layout := RECORD
    STRING X;
    STRING Y;
    STRING OBJECTID;
    STRING NCESID;
    STRING NAME;
    STRING ADDRESS;
    STRING CITY;
    STRING STATE;
    STRING ZIP;
    STRING ZIP4;
    STRING TELEPHONE;
    STRING TYPE;
    STRING STATUS;
    STRING POPULATION;
    STRING COUNTY;
    STRING COUNTYFIPS;
    STRING COUNTRY;
    STRING LATITUDE;
    STRING LONGITUDE;
    STRING NAICS_CODE;
    STRING NAICS_DESC;
    STRING SOURCE;
    STRING SOURCEDATE;
    STRING VAL_METHOD;
    STRING VAL_DATE;
    STRING WEBSITE;
    STRING LEVEL_;
    STRING ENROLLMENT;
    STRING START_GRAD;
    STRING END_GRADE;
    STRING DISTRICTID; //Unique to Public
    STRING FT_TEACHER;
    STRING SHELTER_ID;
END;

EXPORT File  := DATASET('~bmf::kaggle::public_schoolsus',layout,CSV(HEADING(1)));


END;
//Import:ecl:ParadiseHackathon.File_StateFIPS
EXPORT File_StateFIPS := MODULE
 EXPORT Layout := RECORD
    STRING2    STATE;
    UNSIGNED1  StateCode;
    STRING3    FIPS;
    STRING33   County;
    STRING2    Class;
END;

 EXPORT File := DATASET('~bmf::kaggle::statefips',Layout,CSV(Heading(1)));
END;

//Import:ecl:ParadiseHackathon.File_Weather
EXPORT File_Weather := MODULE
EXPORT Layout := RECORD //RECORD Optimized using BestRecord function (See BWR_AnalyzeWeather)
    UNSIGNED3 begin_yearmonth;
    UNSIGNED3 begin_day;
    UNSIGNED3 begin_time;
    UNSIGNED3 end_yearmonth;
    REAL4     end_day;
    STRING4   end_time;
    STRING45  episode_id;
    REAL8     event_id;
    STRING20  state;
    INTEGER4  state_fips;
    UNSIGNED4 year;
    STRING9   month_name;
    STRING    event_type;
    STRING1   cz_type;
    UNSIGNED2 cz_fips;
    STRING109 cz_name;
    STRING3   wfo;
    STRING18  begin_date_time;
    STRING6   cz_timezone;
    STRING18  end_date_time;
    UNSIGNED2 injuries_direct;
    UNSIGNED2 injuries_indirect;
    UNSIGNED1 deaths_direct;
    UNSIGNED1 deaths_indirect;
    STRING8   damage_property;
    STRING8   damage_crops;
    STRING25  source;
    REAL4     magnitude;
    STRING2   magnitude_type;
    STRING28  flood_cause;
    UNSIGNED1 category;
    STRING3   tor_f_scale;
    REAL4     tor_length;
    REAL4     tor_width;
    STRING3   tor_other_wfo;
    STRING2   tor_other_cz_state;
    STRING3   tor_other_cz_fips;
    STRING20  tor_other_cz_name;
    UNSIGNED2 begin_range;
    STRING3   begin_azimuth;
    STRING45  begin_location;
    UNSIGNED2 end_range;
    STRING3   end_azimuth;
    STRING45  end_location;
    REAL8     begin_lat;
    REAL8     begin_lon;
    REAL8     end_lat;
    REAL8     end_lon;
    STRING15323 episode_narrative;
    STRING8942  event_narrative;
    STRING3   data_source;
END;

EXPORT File := DATASET('~bmf::noaa::SF::StormEvents',layout,CSV(HEADING(1)));
END;
