IMPORT $,STD;
Crime    := $.File_Crimes.File;
CrimeRec := $.File_Crimes.Layout;

// bestrecord := STD.DataPatterns.BestRecordStructure(Crime);
// OUTPUT(bestrecord,ALL);

// Use this code to profile the Crime dataset:
// profileResults := STD.DataPatterns.Profile(Crime):PERSIST('~BMF::UGA::Persist::CrimeProfile');
// OUTPUT(profileResults, ALL, NAMED('profileResults'));


// Cross-Tab by State
CTRec := RECORD
  Crime.state_abbr;
  PopAvg          := ROUND(AVE(GROUP,Crime.population));
  ViolentCrimeAvg := ROUND(AVE(GROUP,Crime.violent_crime));
  HomicideAvg     := ROUND(AVE(GROUP,Crime.homicide));
  RapeAvg         := ROUND(AVE(GROUP,Crime.rape_legacy));
  RobberyAvg      := ROUND(AVE(GROUP,Crime.Robbery));
  agg_assaultAvg  := ROUND(AVE(GROUP,Crime.aggravated_assault));
  prop_crimeAvg   := ROUND(AVE(GROUP,Crime.property_crime));
  burglaryAvg     := ROUND(AVE(GROUP,Crime.burglary));
  larcenyAvg      := ROUND(AVE(GROUP,Crime.larceny));
  veh_theftAvg    := ROUND(AVE(GROUP,Crime.motor_vehicle_theft));
END;

AveCrimeTBL := TABLE(Crime(state_abbr <> ''),CtRec,State_abbr);
OUTPUT(SORT(AveCrimeTBL,state_abbr));


//Generate ratios for Paradise Service

RatioRec := RECORD
 STRING2 State;
 REAL4   ViolentCrimeRatio;
 REAL4   HomicideRat;
 REAL4   RapeRat;
 REAL4   Agg_AssaultRat;       
 REAL4   ViolentCompRat; //Average of Homicide and Rape
 REAL4   RobberyRat;    
 REAL4   Prop_CrimeRat; 
 REAL4   BurglaryRat;   
 REAL4   LarcenyRat;    
 REAL4   Veh_TheftRat;  
 REAL4   PropCompRat;    //Average of all Property Crimes
END;

RatioRec CalcRatios(AveCrimeTBL Le) := TRANSFORM
 SELF.State             := Le.State_Abbr;
 SELF.ViolentCrimeRatio := (Le.ViolentCrimeAvg/Le.PopAvg)*100;
 SELF.HomicideRat       := (Le.HomicideAvg/Le.PopAvg)*100;
 SELF.RapeRat           := (Le.RapeAvg/Le.PopAvg)*100;
 SELF.Agg_AssaultRat    := (Le.Agg_AssaultAvg/Le.PopAvg*100);
 SELF.ViolentCompRat    := (((Le.ViolentCrimeAvg+Le.HomicideAvg+Le.RapeAvg+Le.Agg_AssaultAvg)/4)/Le.PopAvg)*100;
 SELF.RobberyRat        := (Le.RobberyAvg/Le.PopAvg)*100;
 SELF.Prop_CrimeRat     := (Le.Prop_CrimeAvg/Le.PopAvg)*100;
 SELF.BurglaryRat       := (Le.BurglaryAvg/Le.PopAvg)*100;
 SELF.LarcenyRat        := (Le.LarcenyAvg/Le.PopAvg)*100;
 SELF.Veh_TheftRat      := (Le.Veh_TheftAvg/Le.PopAvg)*100;
 SELF.PropCompRat       := (((Le.RobberyAvg+Le.Prop_CrimeAvg+Le.BurglaryAvg+Le.LarcenyAvg+Le.Veh_TheftAvg)/5)/Le.PopAvg)*100;
END;

BuildRatios := PROJECT(AveCrimeTBL,CalcRatios(LEFT));
// OUTPUT(PROJECT(AveCrimeTBL,CalcRatios(LEFT)));
OUTPUT(BuildRatios,,'~BMF::Hackathon::CrimeRates',OVERWRITE);









