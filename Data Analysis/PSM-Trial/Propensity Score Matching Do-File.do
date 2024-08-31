//Dependent
income

//Independent
age sex maritalstat edu

//Treatment Variable
credit

//breps 5-100

//Defining Variable
global treatment credit
global ylist income
global xlist age sex maritalstat edu
global breps 100

//Describing
des $treatment $ylist $xlist
sum $treatment $ylist $xlist

bysort $treatment: sum $ylist $xlist

//Regression for treatment (t-test)
reg $ylist $treatment

//Regression for treatment controlling for the indeoendent variables
reg $ylist $treatment $xlist

//Propensity Score
pscore $treatment $xlist, pscore(outscore) blockid (outblock) comsup

//Matching Methods
attnd $ylist $treatment $xlist, pscore(outscore) comsup boot reps ($breps) dots //Near Neigbor

attr $ylist $treatment $xlist, pscore(outscore) comsup boot reps ($breps) dots radius (0.1) //Radius

attk $ylist $treatment $xlist, pscore(outscore) comsup boot reps ($breps) dots //Kernel

atts $ylist $treatment $xlist, pscore(outscore) blockid(outblock) comsup boot reps ($breps) //Stratification

psmatch2 credit age sex maritalstat fert farmrange, out (income) kernel ate
psgraph

psmatch2 credit age sex maritalstat fert farmrange, out (income) n(1) ate
psgraph

eregress income age sex maritalstat fert farmrange , endogenous(yield = pesticide herbicide mechanization)

log close

global drive C:\Users\hp\Documents\Winnie\
use ${drive}Winnie_PSM_Dataset.dta

rdrobust income yield, c(5)
rdplot income yield, c(6)