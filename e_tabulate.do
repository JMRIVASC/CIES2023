capt prog drop e_tabulate
prog e_tabulate, eclass
syntax varname(numeric) [if] [in] [fw aw iw] [, noTOTal * ]
tempname count percent vals V
tab `varlist' `if' `in' [`weight'`exp'], ///
matcell(`count') matrow(`vals') `options'
local N = r(N)
mat `count' = `count''
forv r =1/`=rowsof(`vals')' {
local value: di `vals'[`r',1]
local label: label (`varlist') `value'
local values "`values' `value'"
local labels `"`labels' `value' `"`label'"'"'
}
if "`total'"=="" {
mat `count' = `count', `N'
local values "`values' total"
local labels `"`labels' total `"Total"'"'
}
mat colname `count' = `values'
mat `percent' = `count'/`N'*100
mat `V' = `count''*`count'*0
eret post `count' `V', depname(`varlist') obs(`N')
eret local cmd "e_tabulate"
eret local depvar "`varlist'"
eret local labels `"`labels'"'
eret mat percent = `percent'
end