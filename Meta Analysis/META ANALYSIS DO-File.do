import excel "C:\Users\HP\Documents\Project\4\Main Meta.xlsx", sheet("Sheet1") firstrow case(lower)
rename _all, lower()
metaprop n samplesize, random cimethod(exact) label(namevar=authorandyear, yearvar=publicationyear) xlab(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.40)xline(1, lcolor(black)) subti("Proportion of Low Birth Weight In Sub-Saharan Africa", size(2))

metaprop n samplesize, random cimethod(exact) label(namevar=authorandyear, yearvar=publicationyear) xlab(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5)xline(0, lcolor(black)) subti(" Proportion of Low Birth Weight In Sub-Saharan Africa", size(4)) by(country) 

//Declaring Meta dataset //
meta set _ES _seES, studylabel(authorandyear) studysize(samplesize) eslabel(0.19) nometashow

//By Size //
metaprop n samplesize, random cimethod(exact) label(namevar=authorandyear, yearvar=publicationyear) xlab(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.40)xline(1, lcolor(black)) subti("Proportion of Low Birth Weight In Sub-Saharan Africa", size(2)) by (size)
recode _meta_studysize (min/999 = 0 "Smaller Study Size") (1000/max = 1 "Huge Study Size"), gen(size)
meta summarize, subgroup(size)
meta regress size
meta regress publicationyear
meta regress size publicationyear

//EXPLORE and ADDRESS SMALL-STUDY EFFECTS//
meta trimfill, funnel(legend(off))
meta funnelplot, by( country)


meta bias, egger

//metaprop n samplesize, random cimethod(exact) label(namevar=authorandyear, yearvar=publicationyear) xlab(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4)xline(0, lcolor(black)) subti("Proportion of Low Birth Weight In Sub-Saharan Africa", size(2))