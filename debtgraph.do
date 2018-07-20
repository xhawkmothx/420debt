/*  The following is just the Stata import of sheets from FRED.
    Saved in Stata dataset, so not necessary.
    Here for clarity & a reminder when I inevitably forget how to import
    and format dates from Excel.

import excel "C:\Users\delamb\Documents\Skull\^econ420\debt\debt_and_gdp_ratio_fred_serialDate.xlsx", sheet("debt_and_gdp_ratio_fred") firstrow
gen dateStata = dateExcel1900 + td(30dec1899)
format dateStata %td
tsset dateStata
gen  debtTrillions = debtMillions/1000000

*/

* use debt_and_gdp_ratio.dta

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
    (function y=110, range(`b70' `e70') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b73' `e73') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b80' `e80') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b81' `e81') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b90' `e90') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b01' `e01') color(gs14%60) lcolor(%0) recast(area)) ///
    (function y=110, range(`b07' `e07') color(gs14%60) lcolor(%0) recast(area)) ///
    (tsline debtTrillions, yaxis(2) lcolor("0 190 242") lwidth(medium)) ///
    (tsline pctGDP, lcolor("37 81 108") lwidth(medium)), ///
    ytitle("Percent", size(small) margin(medium)) yscale(range(0 110)) yscale(noline) ///
    ylabel(#11, labsize(vsmall) noticks nogrid) ///
    ytitle("Trillions of Dollars", size(small) margin(medium) axis(2)) yscale(noline axis(2)) ///
    ylabel(0(2)22, labsize(vsmall) noticks grid glwidth(vthin) glcolor(gs8) axis(2)) ///
    ymtick(##2, nolabels noticks grid glwidth(vthin) glcolor(gs8%60) glpattern(shortdash_dot_dot) axis(2)) ///
    ttitle(" ")  tscale(noline) ///
    tlabel(01jan1965 "1965" 01jan1970 "1970" 01jan1975 "1975" 01jan1980 "1980" 01jan1985 "1985" 01jan1990 "1990" ///
           01jan1995 "1995" 01jan2000 "2000" 01jan2005 "2005" 01jan2010 "2010" 01jan2015 "2015", ///
           labels labsize(vsmall) angle(forty_five) format(%td) noticks grid glwidth(vthin) glcolor(gs8) gmin gmax) ///
    title(U.S. National Debt, size(medium) margin(medium)) ///
    legend(order(9 "Nominal Debt" 8 "Percent of GDP" 1 "Recessions") ///
        rows(1) size(vsmall) nobox region(fcolor(none) lcolor(none)) position(7)) ///
    caption("Sources: US Dept. of the Treasury, Fiscal Service; Federal Reserve Bank of St. Louis", size(vsmall) color(gs6)) ///
    graphregion(fcolor(white) lcolor(none) lwidth(none)) ///
    plotregion(fcolor(none) lcolor(none) lwidth(none)) ///
    name(debt, replace) 
