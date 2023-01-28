CrimeRec := RECORD
  string2 state;
  real4 violentcrimeratio;
  real4 homiciderat;
  real4 raperat;
  real4 agg_assaultrat;
  real4 violentcomprat; //Sum of above ratios
  real4 robberyrat;
  real4 prop_crimerat;
  real4 burglaryrat;
  real4 larcenyrat;
  real4 veh_theftrat;
  real4 propcomprat;    //Sum of above ratios Property Composite Ratio
END;

Crime_DS := DATASET('~UGA::Main::Hacks::CrimeRates',CrimeRec,FLAT);
Crime_DS;

//Build Scores (higher score, better rating)
RankTbl := RECORD
 Crime_DS.State;
 Crime_DS.violentcomprat;
 Crime_DS.propcomprat;
 UNSIGNED1 ViolentScore := 0;
 UNSIGNED1 PropCrimeScore := 0;
END;


TempTbl := TABLE(Crime_DS,RankTbl);

AddViolentScore := ITERATE(SORT(TempTbl,-violentcomprat),TRANSFORM(RankTbl,SELF.ViolentScore := IF(LEFT.violentcomprat=RIGHT.violentcomprat,LEFT.ViolentScore,LEFT.ViolentScore+1),SELF := RIGHT));
AddPropScore    := ITERATE(SORT(AddViolentScore,-propcomprat),TRANSFORM(RankTbl,SELF.PropCrimeScore := IF(LEFT.propcomprat=RIGHT.propcomprat,LEFT.PropCrimeScore,LEFT.PropCrimeScore+1),SELF := RIGHT));

OUTPUT(AddPropScore,,'~UGA::Main::Hacks::CrimeScores',NAMED('TopCrime'),OVERWRITE);
