* LOAD THE DATASET/;
*Health Insurance Premium ayment prediction whether the customer would pay the next premium or not/;
PROC IMPORT OUT= Amare3.test
            DATAFILE= "C:\Toronto\Statestics\Project\test.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
GuessinGrows=10000;
	
RUN;
PROC CONTENTS DATA=Amare3.test ;
RUN;
 * To get the copy of data;
DATA Amare3.df;
 SET  Amare3.test ;
RUN;
********************************************
*EDA (EXPLORATORY DATA ANALYSIS)*/
********************************************

* BROWSING THE DESCRIPTION PORTION ;
PROC CONTENTS DATA=Amare3.df;
RUN; 
*Head: BROWSING THE Data PORTION ;

proc print data=Amare3.df (obs=10);run;

*Tail: The last 10 obs;
proc print data=Amare3.df (obs=34224  firstobs=34215);run;
*Tail: The last 10 obs;
proc print data=Amare3.df (obs=34224  firstobs=34215);run;
* Tail: The last 224 obs;
proc print data=Amare3.df (obs=34224  firstobs=34001);run;
*From the last 224 obs we have, there is no missing values for all variables so no need of drop any values;

*CHECK and DROP DUPLICATE OBSERVATION IF EXIST IN THE DATA SET;
PROC SORT DATA=Amare3.df OUT=Amare3.df2 NODUPKEY;
 BY _ALL_;
RUN;


************************************************************************************************;
*UNIVARIATE ANALYSIS;
************************************************************************************************;
 *FOR ALL CONTINUOUS VARIABLES: summarization;
TITLE "DESCRIPTIVE ANALYSIS OF ALL CONTINUOUS VARIABLES";
FOOTNOTE "CREATE BY Amare";
PROC MEANS DATA=Amare3.df2 N NMISS MIN Q1 MEDIAN  Q3 MAX qrange mean std cv clm maxdec=2  ;
RUN;
 
title;
footnote;
*After understanding the whole picture  for continuous variable We should better to do univariate analysis 
one by one by using proc univarialte;

*CONTINOUSE DATA : VISUALIZE METHODS;
*A. perc_premium_paid_by_cash_credit;

* The data set normality Test;
proc univariate data=Amare3.df2 plot normal;
var age_in_days; 
run;  
title "Univariate analysis for perc_premium_paid_by_credit";
proc univariate data = Amare3.df2 plot normal;
var perc_premium_paid_by_cash_credit;
run;
* Create a graph Using prodc sgplot;

title "This is hisogram for perc_premium_paid_by_cash_credit";

Proc sgplot data=Amare3.df2; 
 histogram perc_premium_paid_by_cash_credit;
 density perc_premium_paid_by_cash_credit;
 density perc_premium_paid_by_cash_credit/type=kernel;
Run;
Quit;

title "This is horizontal box plot for perc_premium_paid_by_cash_credit";
Proc sgplot data=Amare3.df2;
hbox perc_premium_paid_by_cash_credit; *hbox   Horizontal box plot ;
run;
title "This is vertical box plot for perc_premium_paid_by_cash_credit";
Proc sgplot data=Amare3.df2;
vbox perc_premium_paid_by_cash_credit; *  vbox vertical box plot;
run;

title "This is hisogram for perc_premium_paid_by_cash_credit";
*Using proc univarite to draw   qqplot  and to check normality ;

proc univariate data=Amare3.df2 normal ;
var perc_premium_paid_by_cash_credit ;
qqplot /normal (mu=est sigma=est);
run;
*CONTINOUSE DATA : VISUALIZE METHODS;
*B. Income;
title "Univariate analysis for premium holders income ";
proc univariate data = Amare3.df2 plot normal;
var income;
run;
title "This is hisogram for Income  ";
Proc sgplot data=Amare3.df2; 
 histogram Income;
 density Income;
 density Income/type=kernel;
Run;
Quit;
title "This is horizontal box plot for Income";
proc univariate data=Amare3.df2 normal ;
var Income ;
qqplot /normal (mu=est sigma=est);
run;
title "This is vertical box plot for income";
Proc sgplot data=Amare3.df2;
vbox income; *vbox   box plot and for Income;
run;

* Income Segmentation;
PROC FORMAT;
VALUE CS
    24030-<100000='Low'
	100000-<250000='Fair'
	250000-<500000='Good'
	500000-<1000000='Very Good'
	1000000-<22914550='Excellent'
; 
run;

PROC FREQ DATA=Amare3.df2;
 TABLE  Income/MISSING;
  FORMAT  Income CS.   ;
RUN;
*CONTINOUSE DATA : VISUALIZE METHODS;
*C. Count_more_than_12_months_late ;
title "Univariate analysis for premium holders Count_more_than_12_months_late ";
proc univariate data = Amare3.df2 plot normal;
var Count_more_than_12_months_late;
run;
title "This is hisogram forCount_more_than_12_months_late  ";
Proc sgplot data=Amare3.df2; 
 histogram Count_more_than_12_months_late;
 density Count_more_than_12_months_late;
 density Count_more_than_12_months_late/type=kernel;
Run;
Quit;
title "This is horizontal box plot for Count_more_than_12_months_late";
proc univariate data=Amare3.df2 normal ;
var Count_more_than_12_months_late ;
qqplot /normal (mu=est sigma=est);
run;
title "This is vertical box plot for Count_more_than_12_months_late";
Proc sgplot data=Amare3.df2;
vbox Count_more_than_12_months_late; *vbox   box plot and for Income;
run;

*CONTINOUSE DATA : VISUALIZE METHODS;
*D. no_of_premiums_paid ;

 title "Univariate analysis for premium holders no_of_premiums_paid ";
proc univariate data = Amare3.df2 plot normal;
var  no_of_premiums_paid;
run;
title "univariate analysis for premium holders number of premiums paid";
proc univariate data = Amare3.df2 plot normal;
var no_of_premiums_paid;
run;
title "This is hisogram for no_of_premiums_paid ";
Proc sgplot data=Amare3.df2; 
 histogram  no_of_premiums_paid;
 density no_of_premiums_paid;
 density no_of_premiums_paid/type=kernel;
Run;
Quit;
proc univariate data=Amare3.df2 noprint;
var  no_of_premiums_paid;
histogram  no_of_premiums_paid / normal(color=big w=2) statref=mean cstatref=crimson wstatref=2; 
run;
title "This is horizontal box plot for no_of_premiums_paid";
proc univariate data=Amare3.df2 normal ;
var no_of_premiums_paid ;
qqplot /normal (mu=est sigma=est);
run;
title "This is vertical box plot no_of_premiums_paid";
Proc sgplot data=Amare3.df2;
vbox no_of_premiums_paid; *vbox   box plot and for no_of_premiums_paid;
run;

*no_of_premiums_paid Segmentation;
PROC FORMAT;
value CS
    1-<7='poor'
	7-<15='Fair'
	15-<25='Good'
	25-<35='Very Good'
	35-<61='Excellent'  
; 
VALUE deliq
   0-<0.196='small'
  0.196-0.396='Fair'
   0.396-0.596='medium'
   0.596-0.796='large'
   0.796-1.01='High'
 ;
run;
 

PROC FREQ DATA=Amare3.df2;
 table  no_of_premiums_paid/MISSING;
format no_of_premiums_paid CS.   ;
RUN;

*CONTINOUSE DATA : VISUALIZE METHODS;
*E. no_of_premiums_paid ;
title "Univariate analysis for premium holders application_underwriting_score ";
proc univariate data = Amare3.df2 plot normal;
var  application_underwriting_score;
run;
title "This is hisogram for application_underwriting_score ";
Proc sgplot data=Amare3.df2; 
 histogram  application_underwriting_score;
 density application_underwriting_score;
 density application_underwriting_score/type=kernel;
Run;
Quit;
proc univariate data=Amare3.df2 noprint;
var  application_underwriting_score;
histogram  application_underwriting_score / normal(color=big w=2) statref=mean cstatref=crimson wstatref=2; 
run;

*CONTINOUSE DATA : VISUALIZE METHODS;
*F. no_of_premiums_paid ;
title "This is horizontal box plot for application_underwriting_score";
proc univariate data=Amare3.df2 normal ;
var application_underwriting_score ;
qqplot /normal (mu=est sigma=est);
run;
title "This is horizontal box plot application_underwriting_score";
Proc sgplot data=Amare3.df2;
vbox application_underwriting_score; *vbox   box plot and for application_underwriting_score;
run;
*application_underwriting_score Segmentation;
PROC FORMAT;
VALUE CS
  
    91-<93='poor'
	93-<95='Fair'
	95-<97='Good'
	97-<99='Very Good'
	99-<100='Excellent'  
	;
	 

run;

PROC FREQ DATA=Amare3.df2;
 TABLE  application_underwriting_score/MISSING;
  FORMAT application_underwriting_score CS.   ;
RUN;
 
title "Univariate analysis for premium holders no_of_premiums_paid ";
proc univariate data = Amare3.df2 plot normal;
var  no_of_premiums_paid;
run;

title "This is hisogram for no_of_premiums_paid ";
Proc sgplot data=Amare3.df2; 
 histogram  no_of_premiums_paid;
 density no_of_premiums_paid;
 density no_of_premiums_paid/type=kernel;
Run;
Quit;
proc univariate data=Amare3.df2 noprint;
var  no_of_premiums_paid;
histogram  no_of_premiums_paid / normal(color=big w=3) statref=mean cstatref=crimson wstatref=2; 
run;
title "This is horizontal box plot for no_of_premiums_paid";
proc univariate data=Amare3.df2 normal ;
var no_of_premiums_paid ;
qqplot /normal (mu=est sigma=est);
run;

title "This is horizontal box plot no_of_premiums_paid";
Proc sgplot data=Amare3.df2;
vbox no_of_premiums_paid; *vbox   box plot and for no_of_premiums_paid;
run;


TITLE;
FOOTNOTE;

*categorical variabels: frequancy:(sourcing_channel residence_area_type);
PROC FREQ DATA=Amare3.df2;
 TABLE sourcing_channel residence_area_type/MISSING;
 * by adding Missing you specify that ypou want to consider missing values in percentage as well;
RUN;
************************************
Bivarite Analysis
********************************;
               *Question1: is there any assicoation between no_of_premiums_paid and perc_premium_paid_by_cash_credit?
                H0:there is no associtation between no_of_premiums_paid and perc_premium_paid_by_cash_credit
                H1: there is associtation between credit score status and Months_since_last_delinquent status ;

PROC FREQ DATA=Amare3.df2;
table no_of_premiums_paid  perc_premium_paid_by_cash_credit/missing;
  format  no_of_premiums_paid CS. perc_premium_paid_by_cash_credit deliq. ;
RUN;

PROC FREQ DATA=Amare3.df2;
 table  no_of_premiums_paid * perc_premium_paid_by_cash_credit/chisq;
  format  no_of_premiums_paid CS. perc_premium_paid_by_cash_credit deliq. ;
RUN;
*Since p-value is less than 5% we reject null hypothese and conclude that
there is statistically assicoation between no_of_premiums_paid and perc_premium_paid_by_cash_credit at 5% significant level;

             *Qusstion2. is there any assicoation between no_of_premiums_paid and sourcing_channel?
              H0:there is no associtation between no_of_premiums_paid and sourcing_channel
              H1: there is associtation between no_of_premiums_paid and sourcing_channel ;
PROC FREQ DATA=Amare3.df2;
 TABLE  no_of_premiums_paid * sourcing_channel/chisq;
  FORMAT   no_of_premiums_paid CS. ;
  run;
  *Since p-value is less than 5% we reject H0 and accept H1 and conclude that
there is statistically assicoation between no_of_premiums_paid and sourcing_channel ;
 
*Qusstion 3. is there any assicoation between no_of_premiums_paid and residence_area_type?
              H0:there is no associtation between no_of_premiums_paid and residence_area_type
              H1: there is associtation between no_of_premiums_paid and residence_area_type ;
PROC FREQ DATA=Amare3.df2;
 TABLE  no_of_premiums_paid * residence_area_type/chisq;
  FORMAT   no_of_premiums_paid CS. ;
  run;
*Since p-value is greater than 5% we accept H0 and conclude that
there is no statistically assicoation between no_of_premiums_paid and residence_area_type ;

* Question 4 is there any association between number of application_underwriting_score and residence_area_type?
              H0:there is no associtation between application_underwriting_score and residence_area_type
              H1: there is associtation between   application_underwriting_score and residence_area_type ;
PROC FREQ DATA=Amare3.df2;
 TABLE  application_underwriting_score *residence_area_type/chisq;
  FORMAT   application_underwriting_score CS. ;
  run;
*Since p-value is greater than 5% we accept H0 and conclude that
there is no enogh evidence to reject the HO


             *Question 5 : is there any assicoation between Income and sourcing_channel?
              H0:there is no associtation between Income and sourcing_channel
              H1: there is associtation between Income and sourcing_channel ;

PROC FREQ DATA=Amare3.df2;
 TABLE  Income * sourcing_channel/chisq;
  FORMAT   Income CS. ;
  run;
*Since p-value is lessthan 5% reject H0 and conclude that
there is statistically assicoation between Income and sourcing_channel ;

           *Question 6. is there any assicoation between Income and residence_area_type?
            H0:there is no associtation between Income and residence_area_type
            H1: there is associtation between Income and residence_area_type ;
PROC FREQ DATA=Amare3.df2;
 TABLE   Income * residence_area_type/chisq ;
  FORMAT  Income CS.  ;
RUN;
proc freq data=Amare3.df2;
table sourcing_channel*residence_area_type chisq norow nocol nopct;
*Since p-value is greater  than 5% we accept H0 and hence there is no enough evidence to reject Ho;

proc freq data=Amare3.df2;
table sourcing_channel*residence_area_type/ chisq norow nocol nopct;
run;

 *Question 7. is there any assicoation between application_underwriting_score and sourcing_channel?;
 
ods graphics on;
proc glm data=Amare3.df2;
class sourcing_channel;
model application_underwriting_score = sourcing_channel; *in proc glm in model statement continuous varible is located on the left side
                                                          of equation and categorical variable is located on the right side of equal sign;
means sourcing_channel / hovtest=levene(type=abs) welch ;
run;
*since p-value of Levene's test is less than 5% I reject null hypothese and get conclusion that application_underwriting_score and sourcing_channel groups 
don't have equal variance so Satterthwaite (also known as Welch’s) t-test is appropriate;
*since p-value of Welch's ANOVA for application_underwriting_score is less than 5% we can reject null hypothese and conclude that there is statistically difference between mean 
of application_underwriting_score of peremium holders and their client sourcing_channel at 5% significant level;
 
*Question 8. is there any assicoation between no_of_premiums_paid and sourcing_channel?;
ods graphics on;

proc glm data=Amare3.df2;
class sourcing_channel;
model no_of_premiums_paid = sourcing_channel; *in proc glm in model statement continuous varible is located on the left side
                                                          of equation and categorical variable is located on the right side of equal sign;
means sourcing_channel / hovtest=levene(type=abs) welch ;
run;


*since p-value of Levene's test is less than 5% I reject null hypothese and get conclusion that no_of_premiums_paid and sourcing_channel groups 
don't have equal variance so Satterthwaite (also known as Welch’s) t-test is appropriate;
*since p-value of Welch's ANOVA for no_of_premiums_paid is less than 5% we can reject null hypothese and conclude that there is statistically difference between mean 
of application_underwriting_score of peremium holders and their client sourcing_channel at 5% significant level;
 
* Correlation analysis of the data set;
 *Question 9. is there any assicoation between application_underwriting_score and no_of_premiums_paid?;
proc corr data= Amare3.df2;
var no_of_premiums_paid ;
with application_underwriting_score;
run;
 *Since p-value is greater than 5% we accept H0  conclude that
there is  statistically assicoation between no_of_premiums_paid and application_underwriting_score ;


*Question 10. is there any assicoation between Count_more_than_12_months_late and no_of_premiums_paid?;
 proc corr data=Amare3.df2;
 var Count_more_than_12_months_late no_of_premiums_paid;
 run;
 *Since p-value is greater than 5% we accept H0  conclude that
there is  statistically assicoation between no_of_premiums_paid and Count_more_than_12_months_late ;

*Question 11. is there any assicoation between application_underwriting_score and income?;
 proc corr data=Amare3.df2;
 var income application_underwriting_score;
 run;
 *Since p-value is less than 5% we accept H0  conclude that
there is  statistically assicoation between application_underwriting_score and income ;
 
  proc sgplot data=Amare3.df2;
scatter x=no_of_premiums_paid y=Income / group=no_of_premiums_paid; run;
 proc sgplot data=Amare3.df2;
scatter x=no_of_premiums_paid y=Count_3_6_months_late;   run;

* Developing model using SLR just one variable;
proc reg data=Amare3.df2;
    model no_of_premiums_paid=Income ;
run;

 
proc reg data=Amare3.df2;
    model Count_more_than_12_months_late  = Income;
run;
proc reg data=Amare3.df2;
    model Count_more_than_12_months_late  = no_of_premiums_paid;
run;
proc sgplot data=Amare3.df2;
    scatter x=Income y=application_underwriting_score /
    markerattrs=(symbol=CircleFilled size=6 color=purple);
run;
 
proc reg data=Amare3.df2;
 model  perc_premium_paid_by_cash_credit= Income;
 run;

 TITLE "Computing Four Measures of Association";
PROC CORR DATA = Amare3.df2 pearson spearman kendall hoeffding
plots=matrix(histogram);
var perc_premium_paid_by_cash_credit Income Count_3_6_months_late Count_6_12_months_late Count_more_than_12_months_late
application_underwriting_score no_of_premiums_paid  ;
RUN;

 


