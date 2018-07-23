/*
import delimited C:\Users\delamb\Documents\Skull\^econ420\debt\omb_interest.csv, varnames(1) case(preserve) 
tostring year, g(date)
replace date = "01jan" + date
gen dateStata = date(date, "DMY")
format dateStata %td
tsset dateStata
gen intBillions = intMillions/1000
save interest_payments.dta
*/

use interest_payments.dta, clear

// define light & dark blues
local light `" "0 190 242" "'
local dark `" "37 81 108" "'
local orange `" "255 104 13" "'

// locals for begin/end dates of NBER-defined recessions
local b70: disp td(01dec1969)
local e70: disp td(30nov1970)
local b73: disp td(01nov1973)
local e73: disp td(31mar1975)
local b80: disp td(01jan1980)
local e80: disp td(31jul1980)
local b81: disp td(01jul1981)
local e81: disp td(30nov1982)
local b90: disp td(01jul1990)
local e90: disp td(31mar1991)
local b01: disp td(01mar2001)
local e01: disp td(30nov2001)
local b07: disp td(01dec2007)
local e07: disp td(30jun2009)

// the (function ...) lines are for shading the recession periods.
// reset "y= ...." to y-max if reusing!
twoway ///
    (function y=26.5, range(`b70' `e70') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b73' `e73') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b80' `e80') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b81' `e81') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b90' `e90') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b01' `e01') color(gs12%60) lcolor(%0) recast(area)) ///
    (function y=26.5, range(`b07' `e07') color(gs12%60) lcolor(%0) recast(area)) ///
    (tsline pctGDP, lcolor(`dark') lwidth(thick)) ///
    (tsline pctOutlay, lcolor(`light') lwidth(thick)) ///
    (tsline intBillions, yaxis(2) lcolor(`orange') lwidth(thick)) in 29/78, ///
    ytitle("Percent", size(medsmall)) yscale(noline) ///
    ylabel(0(5)26.5, labsize(small) angle(horizontal) labgap(small) noticks gmin) ///
    ytitle("Billions of Dollars", size(medsmall) margin(medium) axis(2)) yscale(noline axis(2)) ///
    ylabel(0(50)265, labsize(small) angle(horizontal) labgap(small) noticks grid glwidth(vthin) glcolor(gs6) axis(2)) ///  
    ymtick(##2, nolabels noticks grid glwidth(vthin) glcolor(gs6) glpattern(dot) nogmax axis(2)) ///
    ttitle(" ", size(zero)) tscale(noline) ///
    tlabel(01jan1965 "1965" 01jan1970 "1970" 01jan1975 "1975" 01jan1980 "1980" 01jan1985 "1985" 01jan1990 "1990" ///
           01jan1995 "1995" 01jan2000 "2000" 01jan2005 "2005" 01jan2010 "2010" 01jan2015 "2015", ///
           labels labsize(vsmall) angle(forty_five) format(%td) noticks grid glwidth(vthin) glcolor(gs6) gmin gmax) ///
    legend(order(10 "Nominal Payments" 8 "% of GDP" 9 "% of Federal Budget Outlay" 1 "Recessions") ///
        rows(1) size(small) nobox region(fcolor(none) lcolor(none)) position(7)) ///
    caption("Source: Office of Management and Budget, Historical Tables", size(vsmall) color(gs6)) ///
    graphregion(fcolor(white) lcolor(none) lwidth(none)) ///
    plotregion(fcolor(none) lcolor(none) lwidth(none)) ///
    xsize(10.875) ysize(4.25) ///
    name(interest, replace) 

graph export interest.png, as(png) replace
