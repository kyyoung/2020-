clear
set maxvar 32767
set more off

cd"C:\Users\user\Desktop\곰스"
use "goms_append_1.dta", clear

*연도
gen year=.
forvalue j=10/16{
replace year=20`j' if g`j'1pid~=.
}

*나이
forvalue j=10/16{
drop if g`j'1age==-1
replace g`j'1age=0 if g`j'1age==.
keep if g`j'1age<35
}

*첫직장 구직기간
gen termy=.
gen termm=.
forvalue j=10/16{
replace termy=g`j'1d002-g`j'1graduy if g`j'1d006==2
replace termm=g`j'1d003-g`j'1gradum if g`j'1d006==2
replace termy=. if g`j'1d002==-1
}

gen termy2=termy*12
gen term= termm+termy2

bys year: sum term
bys year: tab term

*첫직장 사업체 규모
gen first_firm=.
forvalue j=10/16{
replace first_firm=0 if g`j'1d017>=1&g`j'1d017<=6
replace first_firm=1 if g`j'1d017>=7&g`j'1d017<=9
}

tab year first_firm, r

*자기선언 첫 직장 종사상 지위
gen first_sta=.
forvalue j=10/16{
replace first_sta=1 if g`j'1d023==1
replace first_sta=2 if g`j'1d023==2
replace first_sta=3 if g`j'1d023==3
}

tab year first_sta, r

*자기선언 첫 직장 정규직 여부 
gen first_regu=.

forvalue j=12/16{
replace first_regu=0 if g`j'1d062==1
replace first_regu=1 if g`j'1d062==2
}

tab year first_regu, r

*첫직장 그만둔 이유
forvalue j=10/16{
tab g`j'1d249
}

*첫직장에서 현재일자리까지 구직기간
gen p_termy=.
gen p_termm=.

forvalue j=10/16{
replace p_termy=g`j'1a001-g`j'1d002 if g`j'1d006==2
replace p_termm=g`j'1a002-g`j'1d003 if g`j'1d006==2
replace p_termy=. if g`j'1a001==-1 | g`j'1d002==-1
}

gen p_termy2=p_termy*12
gen p_term= p_termm+p_termy2

bys year: sum p_term
bys year: tab p_term

*현재일자리에서 이직활동 
forvalue j=10/16{
sum g`j'1a300
}

*현직장이 첫 직장 여부
forvalue j=10/16{
tab g`j'1a388
}
*졸업 후 일자리 갯수
forvalue j=10/16{
sum g`j'1a389
}

save goms_append_2.dta, replace
