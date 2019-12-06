clear
cd"C:\Users\User\Desktop\사회정책지원센터_데이터분석\곰스\곰스dta"

set maxvar 32767

use "GP10_2011.dta", clear
append using "GP11_2012.dta", force 
append using "GP12_2013.dta", force 
append using "GP13_2014.dta", force 
append using "GP14_2015.dta", force 
append using "GP15_2016.dta", force 
append using "GP16_2017.dta", force 

save"goms_total.dta", replace 

gen year=.
forvalue j=10/16{
replace year=20`j' if g`j'1pid~=.
}


*재직자 샘플 
tab g161sq001 //지난 4주간 일하였나?
tab g161sq004 //지난 1주간 일하였나?
tab g161sq006 //임금, 비임금, 무급 
tab g161sq008 // 1주일간 일 안했지만 직장을 갖고 있나?

gen work=.
forvalue j=10/16{
replace work=1 if g`j'1sq001==1&g`j'1sq004==1
}

forvalue j=11/16{
replace work=0 if g`j'1sq006~=1
}
replace work=0 if work~=1

*기업규모(사업체)
tab  g161a011

gen size=.
forvalue j=10/16{
replace size=0 if g`j'1a011==1 |g`j'1a011==2 |g`j'1a011==3 |g`j'1a011==4|g`j'1a011==5|g`j'1a011==6 //300미만
replace size=1 if g`j'1a011==7 | g`j'1a011==8 | g`j'1a011==9 //300인이상 
}
label define size 0 "300인미만" 1 "300인이상"
label values size size

*종사상지위
gen sta=.
forvalue j=10/16{
	forvalue i=1/6{
	replace sta=`i' if g`j'1a021==`i'
	}
}

keep if sta>=1 &sta<=3
tab year sta, r

*정규직유무(자가응답)
tab g161a059
gen regu=.
forvalue j=12/16{
replace regu=0 if g`j'1a059==1
replace regu=1 if g`j'1a059==2
}
label define regu 0 "비정규" 1 "정규"
label values regu regu

*이직준비여부
tab g161a297
gen change=.
forvalue j=10/16{
replace change=1 if g`j'1a297==1
}
replace change=0 if change~=1
tab year change,r 

*이직준비이유
tab g161a298
gen c_reason=.
forvalue j=10/16{
	forvalue i=1/14{
	replace c_reason=`i' if g`j'1a298==`i'
	}
}

tab year c_reason, r

*이직 희망 사업체
gen c_firm=.
forvalue j=10/16{
	forvalue i=1/10{
	replace c_firm=`i' if g`j'1a303==`i'
	}
}

tab year c_firm,r

save "goms_append_1.dta", replace

