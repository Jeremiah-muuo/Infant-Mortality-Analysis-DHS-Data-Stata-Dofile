
****Categorization of variables**

* Step 1: Define Infant Mortality (1 = died before 12 months, 0 = survived)
gen infant_mortality = 0  
replace infant_mortality = 1 if b5 == 0 & b7 < 12
********************explanation**************************************
*b5 == 0 → Child is deceased, b5=1 for child alive           		*
*b7 < 12 → Child died before reaching 12 months            			*
* If both conditions are met, inf_mort = 1, otherwise, it remains 0 *
*********************************************************************
* DHS data must be weighted to obtain the correct estimates, so we apply the survey weights


* Step 2: Apply DHS survey weights
gen wt = v005 / 1000000  
svyset v021 [pweight=wt], strata(v023)


* Step 3: Restrict to births in the Last 5 Years :  
gen survey_year = v007  
gen birth_year = b2  
gen age_at_survey = survey_year - birth_year 
keep if age_at_survey <= 5
codebook infant_mortality
label define infant_mortality 0 "Alive" 1 "Dead"
label values infant_mortality infant_mortality
codebook infant_mortality


doedit "C:\Users\User\Desktop\Stata folder\Dofile_var_category.do"
keep v101 v024 infant_mortality v102 v106 v501 v136 v115 v113 v190 v013 v212 v716 v717 v238 b4 m15 v201 m4 v116 v131 v130 wt survey_year birth_year age_at_survey


//Categorising varibales
gen Source_of_drinking_water = ""
replace Source_of_drinking_water = "Piped Water" if ( v113>=10 ) & ( v113<=14)
replace Source_of_drinking_water = "Wells and Boreholes" if ( v113>=20 ) & ( v113<=32)
replace Source_of_drinking_water = "Natural Sources" if ( v113>=40 ) & ( v113<=51)
replace Source_of_drinking_water = "Containerised" if ( v113>=61 ) & ( v113<=71)
replace Source_of_drinking_water = "Others" if ( v113 ==96 ) & ( v113==97)
replace Source_of_drinking_water = "Others" if ( v113 ==96 )|( v113==97)


gen Religion = ""
replace Religion= "christian" if (v130 >=1) &( v130<=5 )
replace Religion= "Traditionists" if (v130 ==8) |( v130==9 )
replace Religion= "Islam" if (v130 ==7)
replace Religion= "Others" if (v130 ==96)
replace Religion= "No religion" if (v130 ==10)


gen Family_Size = ""
replace Family_Size = "1 - 5" if ( v136 >=1 ) &( v136 <=5 )
replace Family_Size = "6 - 10" if ( v136 >=6 ) &( v136 <=10 )
replace Family_Size = "More Than 10" if( v136 >10 )


gen Children_Ever_Born = ""
replace Children_Ever_Born = "1 - 3" if (v201>= 1)&( v201 <=3)
replace Children_Ever_Born = "4 - 7" if (v201>= 4)&( v201 <=7)
replace Children_Ever_Born = "More than 7" if( v201 >7)


gen Age_at_First_Birth = ""
replace Age_at_First_Birth = "<20 Yrs" if (v212 <20)
replace Age_at_First_Birth = "20-30 Yrs" if (v212 >=20) &( v212 <=30)
replace Age_at_First_Birth = ">30 Yrs" if (v212 >30)


gen Marital_Status =""
replace Marital_Status = "Single" if (v501 ==0)
replace Marital_Status = "Married" if v501 ==1| v501 ==2
replace Marital_Status = "Divorced" if v501 ==4| v501 ==5
replace Marital_Status = "Widowed" if v501 ==3
replace v716 = 996 if v716 == .a


gen Occupation = ""
replace Occupation = "Unemployed" if v716 == 0
replace Occupation = "Employed" if v716 >=110 & v716 <=934
replace Occupation = "Others" if v716 == 996
drop survey_year wt birth_year age_at_survey v131
codebook Source_of_drinking_water


gen Time_to_Water_Source = ""
replace Time_to_Water_Source = "Short Time" if (v115 >=0) & ( v115 <=30)
replace Time_to_Water_Source = "Medium Time" if (v115 >30) & ( v115 <=60)
replace Time_to_Water_Source = "Long Time" if (v115 >60) & ( v115 <=995)
replace Time_to_Water_Source = "Don't Know" if (v115 ==997)|( v115 ==998)
replace Time_to_Water_Source = "On Premises" if (v115 ==996)
codebook Time_to_Water_Source



gen Type_of_Toilet_facility = ""
replace Type_of_Toilet_facility = "Flush Toilet" if ( v116>=10)&( v116 <=15 )|( v116 ==41 )|( v116 ==43 )
replace Type_of_Toilet_facility = "Pit with Slab" if ( v116==21)|( v116 ==22 )
replace Type_of_Toilet_facility = "Pit without Slab" if ( v116==23)
replace Type_of_Toilet_facility = "No Toilet Facility" if ( v116==31)|( v116 ==42 )
replace Type_of_Toilet_facility = "Other" if ( v116==96)|( v116 ==97 )



//Descriptive statistics
tab infant_mortality v013,row chi2
tab infant_mortality Age_at_First_Birth ,row chi2
tab infant_mortality v238 ,row chi2
tab infant_mortality b4 ,row chi2
tab infant_mortality Children_Ever_Born ,row chi2

//Converting varibles to numeric
encode Source_of_drinking_water, gen (NUMSource_of_drinking_water)
encode Family_Size , gen (NUMFamily_Size)
encode Children_Ever_Born , gen (NUMChildren_Ever_Born)
encode Religion , gen (NUMReligion)
encode Age_at_First_Birth, gen (NUMAge_at_First_Birth)
encode Marital_Status , gen (NUMMarital_Status)
encode Occupation , gen (NUMOccupation)
encode Time_to_Water_Source , gen (NUMTime_to_Water_Source)
encode Type_of_Toilet_facility , gen (NUMType_of_Toilet_facility)

//Dropping origtinal variables after categorisation
drop v113 v115 v116 v136 v201 v212 v501 v716 v717
drop v101
drop v130
drop m4 m15

//Logistic regression
logit infant_mortality NUMSource_of_drinking_water NUMFamily_Size NUMChildren_Ever_Born NUMReligion NUMAge_at_First_Birth NUMMarital_Status NUMOccupation NUMTime_to_Water_Source NUMType_of_Toilet_facility v013 v024 v102 v106 v190 v238 b4
