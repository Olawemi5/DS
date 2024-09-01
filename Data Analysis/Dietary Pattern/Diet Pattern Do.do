//Recode
recode AGEHHH (min/24 = 1 "18 - 24") (25/34 = 2 "25 - 34") (35/49 = 3 "35 - 49") (50/max = 4 "50+"), gen (age_cat)

gen mar_grp = .
replace mar_grp = 1 if MARITALSTATUS == "Single"
replace mar_grp = 2 if MARITALSTATUS == "MoMarried" | MARITALSTATUS == "PoMarried" | MARITALSTATUS == "Cohabitation"
replace mar_grp = 3 if MARITALSTATUS == "Widow/widower"

encode LevelofFormalEducation, generate(leveledu)
recode leveledu (6 9 1 5 . = 1 "None") (3 7 = 2 "Primary") (4 8 = 3 "Secondary") (2 10 = 4 "Higher"), gen (edu_cat)

rename INCOM1 (petty_trade)
rename INCOME2 (transport)
rename INCOME3 (manufac)
rename INCOME4 (electric)
rename INCOME5 (teaching)
rename INCOME6 (health_worker)
rename INCOME7 (construct)
rename INCOME8 (paid_job)
rename INCOME9 (process_agric)
rename INCOME10 (crop_farm)
rename INCOME11 (off_farmproc)
rename INCOME12 (livestock_farming)

replace petty_trade = 0 if petty_trade == .
replace transport = 0 if transport == .
replace manufac = 0 if manufac == .
replace electric = 0 if electric == .
replace teaching = 0 if teaching == .
replace health_worker = 0 if health_worker == .
replace construct = 0 if construct == .
replace paid_job = 0 if paid_job == .
replace process_agric = 0 if process_agric == .
replace crop_farm = 0 if crop_farm == .
replace off_farmproc = 0 if off_farmproc == .
replace livestock_farming = 0 if livestock_farming == .

gen income = petty_trade + transport + manufac + electric + teaching + health_worker + construct + paid_job + process_agric + crop_farm + off_farmproc + livestock_farming

replace petty_trade = 0 in 206
replace process_agric = 0 in 206
replace income = 0 in 206
replace livestock_farming = 0 in 403
replace income = 0 in 403
replace livestock_farming = 0 in 407
replace income = 0 in 407
replace livestock_farming = 0 in 412
replace income = 0 in 412
replace off_farmproc = 0 in 485
replace income = 0 in 485
replace process_agric = 0 in 615
replace income = 0 in 615
replace income = 0 in 627
replace petty_trade = 0 in 627
replace petty_trade = 0 in 955
replace income = 0 in 955
replace income = 0 in 596
replace process_agric = 0 in 596

recode income (0 = 1 "Unemployed") (else = 2 "Employed"), gen (working_sts)

recode income (0/30000 = 1 "<=30000") (30001/100000 = 2 "30001 - 100000") (100001/200000 = 3 "100001 - 200000") (200001/600000 = 4 "200001 - 600000") (600001/5000000 = 5 "Above 600000"), gen (income_grp)


//Descriptive
sum AGEHHH, d
ta age_cat // Age
ta GenderHHH // Gender
ta RELIGIONOFRESPOND //Religion
ta mar_grp // Marital Status
ta LGA // LGA
ta numsps,m // Number of spouse
ta edu_cat // Formal Education
ta working_sts // Working Status
ta income_grp
ta SAVINGCULTURE //Saving Culture

ta EXCLUBREASTFEED //Are you aware of exclusive breastfeeding
ta IMMUNIZATION //Has child been properly immunized
//ta DIARRHEA //Do you take child to clinic for diarrhea
//ta MALARIA // Do you have access to mosquito net for prevention of malaria
ta COMPLEMEMNTARYFEED //Do you know what complimentary feeding is
ta FOODDEMENSTRATION //Are there 0 demonstrations at the clinic to promote supplementary feeding at the clinics?

//Food Security
ta majorsource

ta WORRYOFFOOD //worry that you would not have enough food or that it will run out before you had money to buy more?
ta foodsecurityattfoodsecurityatt4 //How often?

ta NOTABLEPREFERED //not able to eat the kinds of foods you preferred(low cost) because of a lack of resources in the last 30 days
ta foodsecurityattfoodsecurityatt6 //How often?

ta EATSAMEFOOD //eat the same food/ limited variety of foods due to a lack of money in the last 30 days? 
ta foodsecurityattfoodsecurityatt8 

ta EATFOODNOTWANT //eat some foods that you really did not want to eat because of a lack of resources to obtain other types of food in the last 30 days? 
ta HZ //How Often

ta EATSMALLERFOOD //eat less/ a smaller meal than you felt you needed because there was not enough food?
ta IB //How often?

ta SKIPMEAL //skip meal because there was not enough food?
ta ID //How often?

ta NOFOODTOEATATALL //was there ever no food to eat of any kind in your household because of lack of resources to get food?
ta IF //How often?

ta SLEEPNOFOOD //did you or any household member go to sleep at night hungry because there was not enough food?
ta IH //How often?

ta NOFOODDAYNIGHT //did you or any household member go a whole day and night without eating anything because food was not enough or it lacked completely?
ta IJ //How often?


//Children Dataset
///////RESHAPING///////////
gen data_id = _n
reshape long AGEINMONTHS SEX WEIGHT HEIGHT, i(data_id) j(data_tri)

drop if SEX == "" //1842

replace AGEINMONTHS = 0 if AGEINMONTHS == .
drop if AGEINMONTHS == .
count //1805

drop if ageyrs > 5

count

generate ageyrs = AGEINMONTHS/12, before(SEX)

replace ageyrs = round(ageyrs)

gen agekids = .
replace agekids = ageyrs if ageyrs > 1 
recode agekids (. = 1 "less than 1 year") (1/max = 2 "Between 12 - 59 Months"), gen (kidsagecat)

recode data_tri (1 =1 "First Birth") (2 3 =2 "2nd - 3rd") (4 5 = 3 ">=4"), gen (birthorder)

//BMI
replace WEIGHT = 0 if WEIGHT == .
replace HEIGHT = 0 if HEIGHT == .

gen weightbmi = ((WEIGHT * 2.205)*703), after(WEIGHT) //Converted the weight from kg to pounds then converted to the appropriate weight for children bmi
gen heightbmi = (HEIGHT * HEIGHT), after(HEIGHT)
gen bmiscore = (weightbmi/heightbmi), after(heightbmi)
replace bmiscore = . if bmiscore == 0

replace bmiscore = round(bmiscore, 0.1)
sum bmiscore, d
//5th Percentile = 1.6
//85th Percentile = 4.8
//95th Percentile = 23.5

recode bmiscore (0.001/1.59 = 1 "Underweight") (1.6/4.79 = 2 "Healthy Weight") (4.8/23.4 = 3 "Overweight") (23.5/max = 4 "Obese"), gen (bmi_cat)

recode bmi_cat (2 = 1 "Normal Weight") (else = 0 "Abnormal Weight"), gen (bmi_catt)

gen source = .
replace source = 1 if MAJORSOURCFOOD == "Borrowed" | MAJORSOURCFOOD == "Gift" | MAJORSOURCFOOD == "OthersSpecify"
replace source = 2 if MAJORSOURCFOOD == "OwnFarm" 
replace source = 3 if MAJORSOURCFOOD == "Purchased" | MAJORSOURCFOOD == "Farm&Purchased"

recode source (1 = 1 "From others") (3 =2 "Purchased") (2 = 3 "Own Farm"), gen (foodsource)

sum AGEINMONTHS, d
ta kidsagecat bmi_catt, row chi
ta SEX bmi_catt, row chi
ta birthorder bmi_catt, row chi

//Food Security
ta majorsource bmi_catt, chi row m // Source Of Food

ta WORRYOFFOOD bmi_catt, chi row m // Worry for enough food
ta NOTABLEPREFERED bmi_catt, chi row m // Unavailability of preferred food
ta EATSAMEFOOD bmi_catt, chi row m // eat same food 
ta EATFOODNOTWANT bmi_catt, chi row
ta EATSMALLERFOOD bmi_catt, chi row
ta SKIPMEAL bmi_catt, chi row m
ta NOFOODTOEATATALL bmi_catt, chi row
ta SLEEPNOFOOD bmi_catt, chi row
ta NOFOODDAYNIGHT bmi_catt, chi row

//Dietary Pattern
gen timee = .
replace timee = 1 if TIMEEATDAILY == "Once"
replace timee = 2 if TIMEEATDAILY == "Twice"
replace timee = 3 if TIMEEATDAILY == "Thrice"
replace timee = 4 if TIMEEATDAILY == "MoreThanThrice"

recode timee (1 2 = 1 "Below Three Meal daily") (3 4 = 2 "Three and More"), gen(timeeat)

gen bedtime = .
replace bedtime = 1 if BEEDTIMEMEALPREFERENCE == "Alcoholic" | BEEDTIMEMEALPREFERENCE == "Biscuits" | BEEDTIMEMEALPREFERENCE == "Fast-food"
replace bedtime = 2 if BEEDTIMEMEALPREFERENCE == "Cereals"
replace bedtime = 3 if BEEDTIMEMEALPREFERENCE == "Food"
replace bedtime = 4 if BEEDTIMEMEALPREFERENCE == "None"

recode bedtime (1 = 1 "Biscuit/Alcohol/Fast-Food") (2 = 2 "Cereals") (3 = 3 "Food") (4 = 4 "Npne"), gen (bedtimepref)

ta timeeat bmi_catt, chi row
ta TIMEFORBREAKFAST 
ta TIMEFORLUNCH 
ta TIMEFORDINNER 
ta TIMEMISSMEAL bmi_catt, chi row
ta WHYMISSMEAL
ta CONSUMEFASTFOOD bmi_catt, chi row
ta bedtimepref bmi_catt, chi row
ta WHYBEDTIMEMEAL bmi_catt, chi row


ta income_grp bmi_catt, chi row

encode WORRYOFFOOD, generate(worry)
encode NOTABLEPREFERED, generate(notable)
encode EATFOODNOTWANT, generate(eatfdnw)
encode NOFOODTOEATATALL, generate(nofoodeatat)
encode SLEEPNOFOOD, generate(sleepnofood)
encode NOFOODDAYNIGHT, generate(nofooddl)
encode EATSAMEFOOD, gen (eatsamefd)
encode EATSMALLERFOOD, gen (earsmallfd)
encode SKIPMEAL, gen (skmeal)

gen foodsec = .
replace foodsec = 3 if worry == 2 & notable == 2 & eatfdnw == 2 & nofoodeatat == 2 & sleepnofood == 2 & nofooddl == 2
replace foodsec = 1 if worry == 1 & notable == 1 & eatfdnw == 1 & nofoodeatat == 1 & sleepnofood == 1 & nofooddl == 1

recode foodsec (1 = 1 "High Food Security") (. = 2 "Average") (3 = 3 "Poor Food Security"), gen(food_sec)


//Bivariate, Logistic Regression
/*logistic bmi_catt i.kidsagecat
logistic bmi_catt i.SEX
logistic bmi_catt i.birthorder
logistic bmi_catt i.income_grp
logistic bmi_catt i.majorsource
logistic bmi_catt i.worry
logistic bmi_catt i.notable
logistic bmi_catt i.eatfdnw
logistic bmi_catt i.nofoodeatat
logistic bmi_catt i.sleepnofood
logistic bmi_catt i.nofooddl
logistic bmi_catt i.eatsamefd
logistic bmi_catt i.earsmallfd
logistic bmi_catt i.skmeal

logistic bmi_catt timeeat
logistic bmi_catt TIMEFORBREAKFAST 
logistic bmi_catt TIMEFORLUNCH 
logistic bmi_catt TIMEFORDINNER 
logistic bmi_catt TIMEMISSMEAL
logistic bmi_catt WHYMISSMEAL
logistic bmi_catt CONSUMEFASTFOOD
logistic bmi_catt bedtimepref */

logistic bmi_catt i.kidsagecat, nolog
logistic bmi_catt i.birthorder, nolog
logistic bmi_catt i.foodsource, nolog
logistic bmi_catt i.income_grp, nolog
logistic bmi_catt i.worry, nolog
logistic bmi_catt i.notable, nolog
logistic bmi_catt i.eatfdnw, nolog
logistic bmi_catt i.nofoodeatat, nolog
logistic bmi_catt i.sleepnofood, nolog
logistic bmi_catt i.nofooddl, nolog
logistic bmi_catt i.timeeat, nolog
logistic bmi_catt i.bedtimepref, nolog

//Multivariate
logistic bmi_catt i.kidsagecat i.birthorder i.foodsource i.income_grp i.worry i.notable i.eatfdnw i.nofoodeatat i.sleepnofood i.nofooddl i.timeeat i.bedtimepref, nolog