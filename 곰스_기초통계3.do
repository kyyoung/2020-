clear
set maxvar 32767
set more off

cd"C:\Users\user\Desktop\곰스"

use "goms_append_2.dta", clear

*졸업 후 경험한 일자리, 알바 아님 
gen job_exp=.
forvalue j=11/16{
replace job_exp=1 if g`j'1e001==1&g`j'1e007==2
replace job_exp=0 if  g`j'1e001==2
}
tab year job_exp, r

*졸업 후 경험한 일자리개수
forvalue j=10/16{
sum g`j'1e002
}


*첫직장에서 직장1까지 구직기간
gen p0_termy=.
gen p0_termm=.

forvalue j=11/16{
replace p0_termy=g`j'1e003-g`j'1e003 if g`j'1e007==2
replace p0_termm=g`j'1e004-g`j'1e004 if g`j'1e007==2
replace p0_termy=. if g`j'1e003==-1 | g`j'1e004==-1
}

gen p1_termy2=p1_termy*12
gen p1_term= p1_termm+p_termy2

bys year: sum p1_term
bys year: tab p1_term



*직장1에서 현재일자리까지 구직기간
gen p1_termy=.
gen p1_termm=.

forvalue j=11/16{
replace p1_termy=g`j'1e003-g`j'1d002 if g`j'1e007==2
replace p1_termm=g`j'1e004-g`j'1d003 if g`j'1e007==2
replace p1_termy=. if g`j'1e003==-1 | g`j'1e004==-1
}

gen p1_termy2=p1_termy*12
gen p1_term= p1_termm+p_termy2

bys year: sum p1_term
bys year: tab p1_term

*현재일자리에서 이직활동 
*졸업후 일자리 종사자 수
*졸업후 일자리 종사상 지위
