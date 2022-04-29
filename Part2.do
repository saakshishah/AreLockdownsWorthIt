/* To start off, since we are limiting the data to be 4 countries, so we have decided
to reshape some of the data in Excel, we have copy pasted the desired 4 countries 
into a serperate Excel sheet, and then made independent label for each of the states
such as: the label "Cases" were individualized for Egypt to be "egyptCases" and so on 
for the rest of the countries. This is because we are provided with time series data
it would be easier to analyze them in paraelle to each other with the same period of time.*/

/* We have choose to not include Egypt and India in the Data project two it is because
those countries do not have any data for share price, unemployment rate nor inflation, so
it won't be providing us with a full analysis hence why we have decided to exlude them */

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

/* <<<PART ONE>>> TO FIND REGRESSION MODEL FOR DAILY MARGINAL DEATHS PER MILLION */

gen sweCasesMargin = sweCases[_n]-sweCases[_n-1]

gen espCasesMargin = espCases[_n]-espCases[_n-1]

/* This is to find the change of case per million of each countries of everyday */

regress sweDeathsNew  sweCasesMargin

regress espDeathsNew espCasesMargin

/* The daily marginal deaths per million is definitly related to daily marignal
cases contracted per million. Since the deaths are caused by contracting the COVID-19 disease */ 


regress sweDeathsNew sweCasesMargin sweStringency

regress espDeathsNew espCasesMargin espStringency

/* We then added the stringency in to our model to strengthen it, since 
being more strict does help to slow down the infections and as well as deaths */


regress sweDeathsNew sweCasesMargin sweStringency t
ovtest
estat hettest
rvfplot, yline(0)

regress espDeathsNew espCasesMargin espStringency t
ovtest
estat hettest
rvfplot, yline(0)

/* Finally we have added t in to our model, being time, since this is a time series data
we beilive adding the t as an independent varibale will help us to predict daily marginal
deaths per million better as well as helping us to find out if in the future lockdown 
is worth the cost. */ 

/* We have also did ovtest to see if our model has any ommitted varibles */
/*we did the estat hettest to see if we have constant variances */
/* we graphed residual plot to confirm our results from the heteroskedasity test */

/* <<<PART TWO>>> TO FIND REGRESSION MODEL FOR  THE INFLATION RATE */


regress sweINF sweStringency   

regress espINF espStringency  

/* Here we want to see if inflation will have a negative relationship with stringency
since being more strick would cause a retraction for the country's economy. Due to
economic activities being restricted */

regress sweINF sweStringency  sweCasesMargin 

regress espINF espStringency   espCasesMargin 

/* After we found our model to be quite strong, we then added daily marginal cases
in, since more cases would cause an inflation since, people would be out of work,
staying home or have less trust in going outside. So this way they will demonstrate
less purchase power so the inflation would increase */


regress sweINF sweStringency  sweCasesMargin sweUnemp 

regress espINF espStringency   espCasesMargin espUnemp 

/* Since we have previously mentioned unemployment, so we have included it now
to see that it indeed strengthes our model */

regress sweINF sweStringency  sweCasesMargin sweUnemp t
ovtest
estat hettest
rvfplot, yline(0)

regress espINF espStringency   espCasesMargin espUnemp t
ovtest
estat hettest
rvfplot, yline(0)

/* Finally we have added t in to our model, being time, since this is a time series data
we beilive adding the t as an independent varibale will help us to predict daily marginal
deaths per million better as well as helping us to find out if in the future lockdown 
is worth the cost. */ 

/* We have also did ovtest to see if our model has any ommitted varibles */
/*we did the estat hettest to see if we have constant variances */
/* we graphed residual plot to confirm our results from the heteroskedasity test */












