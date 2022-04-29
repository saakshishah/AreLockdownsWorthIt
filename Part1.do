/* To start off, since we are limiting the data to be 4 countries, so we have decided
to reshape some of the data in Excel, we have copy pasted the desired 4 countries 
into a serperate Excel sheet, and then made independent label for each of the states
such as: the label "Cases" were individualized for Egypt to be "egyptCases" and so on 
for the rest of the countries. This is because we are provided with time series data
it would be easier to analyze them in paraelle to each other with the same period of time.*/


mean (egyptStringency)
mean (sweStringency)
mean (indStringency)
mean (espStringency)

/* This is to show that each of the countries' stringency is according to 
their articles' report*/

gen t = _n
tsset t

/* this is to transform the date as a string variable to a numerical variable, 
as t=1 means first day of the data set, and t=150 means last day of the variable, 
t=1 also means 2019-12-31 */

/* <<<PART ONE>>> TO FIND THE CORRELATION BETWEEN TIME AND CHANGE IN 
MARGINAL DAILY CASES PER MILLION */

gen egyptCasesMargin = egyptCases[_n]-egyptCases[_n-1]
gen sweCasesMargin = sweCases[_n]-sweCases[_n-1]
gen indCasesMargin = indCases[_n]-indCases[_n-1]
gen espCasesMargin = espCases[_n]-espCases[_n-1]

/* This is to find the change of case per million of each countries of everyday */

scatter sweCasesMargin espCasesMargin t, ///
	title("Marginal Daily Cases per Million between Sweden and Spain") ///
	ytitle("Cases per Million") xtitle("Time (days)")

scatter egyptCasesMargin indCasesMargin t, ///
	title("Marginal Daily Cases per Million between Egypt and India") ///
	ytitle("Cases per Million") xtitle("Time (days)")

/* so here we can see how each of nonstrict countries is comparing to
their counterparts (strict countries) of how marginally cases have changed over
the time, from t=1 first day of the data till t=150, the last day of the data */

scatter egyptCasesMargin indCasesMargin t if t>= 75, ///
	title("Trend of Marginal Cases for Egypt and India over Time") ///
	note("t>= 75 means only the data after March 14th are considered.") ///
	ytitle("Marginal Cases per million") xtitle("Time (days)")

scatter sweCasesMargin espCasesMargin t if t>= 75, ///
	title("Trend of Marginal Cases for Sweden and Spain over Time") ///
	note("t>= 75 means only the data after March 14th are considered.") ///
	ytitle("Marginal Cases per million") xtitle("Time (days)")

/* Here we have cropped half of data off to zoom in and better observe the 
rest of the data. The t=75 (march 14th) is where we deemed to be important, since This is where
Spain decided to start their lockdown, and only 10 days later India has decided
to have their lockdown. This information is found from 
https://en.wikipedia.org/wiki/National_responses_to_the_COVID-19_pandemic */

correlate egyptCasesMargin t
correlate sweCasesMargin t
correlate indCasesMargin t
correlate espCasesMargin t

/* Here we want to see if as the time increase, each next day would have more
cases per million than its previous day */

/* <<<PART TWO>>> USING SCATTERPLOT TO FIND HOW DOES THE MARGINAL DAILY
DEATHS PER MILLION VARY BETWEEN EACH SETS OF THE COUNTRY (EGYPT VS INDIA)
AND (SWEDEN VS SPAIN) */

scatter egyptDeathsNew indDeathsNew t, ///
	title("Marginal Daily Deaths per Million between Egypt and India") ///
	ytitle("Deaths per Million") xtitle("Time (days)")

scatter sweDeathsNew espDeathsNew t, ///
	title("Marginal Daily Deaths per Million between Sweden and Spain") ///
	ytitle("Deaths per Million") xtitle("Time (days)")
	
/* so here we can see how each of nonstrict countries is comparing to
their counterparts (strict countries) of how marginally deaths have changed over
the time, from t=1 first day of the data till t=150, the last day of the data */

correlate egyptDeathsNew t
correlate sweDeathsNew t
correlate indDeathsNew t
correlate espDeathsNew t

/* Here we want to see if as the time increase, each next day would have more
deaths per million than its previous day */

/* <<<PART THREE>>> USING BOX PLOT TO FIND AND COMPARE THE SPREAD AND FLUCTUATION OF THE
INFLATION RATE OF SWEDEN AND SPAIN*/

/* Since Egypt do not have the inflation rate so we have decided not to find 
the fluctuation for India since we would have not been able to compare it */

summarize sweINF, detail
graph hbox sweINF, title("Sweden's Inflation-rate (%)") ///
	ylabel(-0.361562 0.6389584 0.845957 1.296567 1.750685, alternate)

/*Has outlier and skwed to right, so we will need to address that */

summarize espINF, detail

graph hbox espINF, title("Spain's Inflation-rate (%)") ///
	ylabel(-0.716993 -0.0183224 0.356653 1.097302 1.097302, alternate)


	
gen rootsweINF = (sweINF)^(1/3)
summarize rootsweINF, detail
graph hbox rootsweINF, title("Sweden's Inflation-rate Cuberooted (%)") ///
	ylabel(.8613061 .8613061 1.013884 1.090431 1.205228 , alternate)

/*Since there were outliers and being skewed, we have decided to cuberoot
our data so that it would remove the skewness and remove the outliers.
Also only Sweden's data needed to be fixed.*/










