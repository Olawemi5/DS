****	Recodes	 ****
recode sec1_q2 (18/34 = 1 "18-34") (35/44 = 2 "35-44") (45/54 = 3 "45-54") (55/64 = 4 "55-64") (65/max = 5 ">=65"), gen (age_grp)
recode sec1_q3 (1 = 1 "Hausa") (2 = 2 "Igbo") (3 = 3 "Yoruba") (else = 4 "Others"), gen (ethnic_rec)
recode sec1_q5 (1 = 1 "No formal education") (2 = 2 "Primary School") (3 4 = 3 "Secondary School") (5 6 = 4 "Tertiary"), gen (edu_rec)
recode sec1_q8 (1 2 = 1 "Civil servants") (5 = 2 "Petty trading") (3 = 3 "Farming") (6 = 4 "Business") (4 = 5 "Artisanry") (7 = 6 "professional") (8 11 = 7 "Student") (9 = 8 "Retired") (10 = 9 "Unemployed"), gen (occupation_rec) // I have categorized Apprenticeship with Students
recode sec1_q7 (2 = 1 "Single") (1 = 2 "Married") (3 4 = 3 "Divorced/separated/widowed"), gen (marital_rec)
recode sc3_q58 (0 9 = 2 "No") (1 = 1 "Yes"), gen (hx_htn)
recode sec6_q116 (1 = 1 "Electronic Media") (3 4 5 = 2 "Social Media/Internet") (6 2 = 3 "Campaign") (7 = 7 "Others"), gen (source)
recode sec1_q4 (1 = 1 "Christianity") (2 = 2 "Islam") (else = .), gen (religion)


*** Derivation of community variables **
** community-level education*

gen secd=sec1_q5>=4 // indicator variable for at least senior secondary education
bysort community_id:egen comm_edu=mean(secd) // obtain proptn with at least secd education in the community
xtile edu_com_level= comm_edu,nq(3) // create tertiles for comm education: 1-low, 2-medium, 3- high
tab edu_com_level

** community public health education***
recode sec6_q115 (0 2 =0 No) (1=1 Yes), gen(com_ph_edu)

****	Table 1 	****

asdoc ta age_grp
asdoc ta sec1_q1, append //Sex
asdoc ta ethnic_rec, append //Ethnic
asdoc ta religion, append // Religion
asdoc ta edu_rec, append //Education
asdoc ta occupation_rec, append //Occupation
asdoc ta marital_rec, append //Marital Status
asdoc ta sec5_q70, append //Smoking
asdoc ta sec5_q80, append //Alcohol
asdoc ta phy_actx, append //Physical Activity
asdoc ta sec5_q96, append //Salt Use
asdoc ta bmig, append //BMI
//ta hx_htn //Family History
asdoc ta sec1_q13, append // Born in community

asdoc ta ward_type, append // Residence
asdoc ta edu_com_level, append //Community education Level
asdoc ta com_ph_edu, append // Community Public Health Education
asdoc ta source, append //Common Source


*****	Table 2		****
putdocx clear
putdocx begin
putdocx table Table1=etable
putdocx save result

asdoc ta age_grp hbp, col chi append
asdoc ta sec1_q1 hbp, col chi append
asdoc ta ethnic_rec hbp, col chi append
asdoc ta religion hbp, col chi append
asdoc ta edu_rec hbp, col chi append
asdoc ta occupation_rec hbp, col chi append
asdoc ta marital_rec hbp, col chi append
asdoc ta sec5_q70 hbp, col chi append
asdoc ta sec5_q80 hbp, col chi append
asdoc ta phy_actx hbp, col chi append
asdoc ta sec5_q96 hbp, col chi append
asdoc ta bmig hbp, col chi append
//ta hx_htn hbp, col chi
asdoc ta sec1_q13 hbp, col chi append

asdoc ta ward_type hbp, col chi append
asdoc ta edu_com_level hbp, col chi append
asdoc ta com_ph_edu hbp, col chi append
asdoc ta source hbp, col chi append


****	Table 3 (ALL)	****

melogit hbp i.age_grp || community_id: , or nolog
putdocx table Table1=etable
melogit hbp i.sec1_q1 || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.ethnic_rec || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.religion || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.edu_rec || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.occupation_rec || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.marital_rec || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.sec5_q70 || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.sec5_q80 || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.phy_actx || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.sec5_q96 || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.bmig || community_id: ,or nolog
putdocx table Table1=etable
//melogit hbp i.hx_htn || community_id: ,or nolog
melogit hbp i.sec1_q13 || community_id: ,or nolog
putdocx table Table1=etable

melogit hbp i.ward_type || community_id: ,or nolog
putdocx table Table1=etable 
melogit hbp i.edu_com_level || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.com_ph_edu || community_id: ,or nolog
putdocx table Table1=etable
melogit hbp i.source || community_id: ,or nolog 
putdocx table Table1=etable


**Model 2: All**
melogit hbp i.age_grp i.sec1_q1 i.ethnic_rec i.religion i.edu_rec i.occupation_rec i.marital_rec i.sec5_q70 i.sec5_q80 i.phy_actx i.sec5_q96 i.bmig i.sec1_q13 || community_id: ,or nolog //Individual
putdocx table Table1=etable

**Model 3: All**
melogit hbp i.ward_type i.edu_com_level i.com_ph_edu i.source || community_id: ,or nolog //Community
putdocx table Table1=etable

**** Table 4 - 5 - 6 | Model By States ****
bysort state: melogit hbp i.age_grp || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.sec1_q1 || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.ethnic_rec || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.religion || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.edu_rec || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.occupation_rec || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.marital_rec || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.sec5_q70 || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.sec5_q80 || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.phy_actx || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.sec5_q96 || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.bmig || community_id: ,or nolog
putdocx table Table1=etable
//bysort state: melogit hbp i.hx_htn || community_id: ,or nolog
bysort state: melogit hbp i.sec1_q13 || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.ward_type || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.edu_com_level || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.com_ph_edu || community_id: ,or nolog
putdocx table Table1=etable
bysort state: melogit hbp i.source || community_id: ,or nolog 
putdocx table Table1=etable

**Model 2: By State**
bysort state: melogit hbp i.age_grp i.sec1_q1 i.ethnic_rec i.religion i.edu_rec i.occupation_rec  i.marital_rec i.sec5_q70 i.sec5_q80 i.phy_actx i.sec5_q96 i.bmig i.sec1_q13 || community_id: ,or nolog //Individual
putdocx table Table1=etable

**Model 3: By State**
bysort state: melogit hbp i.ward_type i.edu_com_level i.com_ph_edu i.source || community_id: ,or nolog //Community
putdocx table Table1=etable
putdocx save result

**Model 4**
melogit hbp i.age_grp i.ethnic_rec i.religion i.edu_rec i.bmig i.state i.edu_com_level i.com_ph_edu i.source || community_id: ,or nolog

**Model 4: By State**
bysort state: melogit hbp i.age_grp i.ethnic_rec i.religion i.edu_rec i.bmig i.edu_com_level i.com_ph_edu i.source || community_id: ,or nolog