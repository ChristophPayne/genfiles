/* Import dataset: simple_salesdata.csv */
PROC IMPORT datafile="/home/paynechristopher/EPG194/zTestFiles/simple_salesdata.csv"
	out=sastrain.simple_salesdata
	dbms=csv
	replace;
RUN;

/* Review whole item population */
PROC FREQ data=sastrain.simple_salesdata;
	table Item_: / norow nocol nopercent;
RUN;


/* ----- array examples ----- */

/* Initialize DATA step - creating columns from array */
/* Initialize DATA step - creating columns from array */
DATA sastrain.sales_variables;
set sastrain.simple_salesdata;

/* total_items_sold = 150; */


/* Setting all variables in all arrays to 0 */
array dummy $ 
bikecash furniturecash applicancecash mailboxcash pianocash

toasternowar toasterwar pianonowar pianowar;
do over dummy;
	dummy = 0;
end;

/* Capturing specific item groups where paymethod = cash */
array items $ Item_1-Item_3;

do over items;
	if items eq "Bike" and Payment_Method eq "Cash" then bikecash=1;
	if items in ("Chair", "Desk", "Table", "Shelf") and Payment_Method eq "Cash" then furniturecash=1;
	if items in ("Toaster", "Heater", "Lamp") and Payment_Method eq "Cash" then applicancecash=1;
	if items eq "Mailbox" and Payment_Method eq "Cash" then mailboxcash=1;
	if items eq "Piano" and Payment_Method eq "Cash" then pianocash=1;
end;

do over items;
	if items eq "Toaster" and Purchase_Warranty eq "No" then toasternowar=1;
	if items eq "Toaster" and Purchase_Warranty in ("Yes - 1 Year", "Yes - 2 Year", "Yes - 3 Year") then toasterwar=1;
	if items eq "Piano" and Purchase_Warranty eq "No" then pianonowar=1;
	if items eq "Piano" and Purchase_Warranty in ("Yes - 1 Year", "Yes - 2 Year", "Yes - 3 Year") then pianowar=1;
end;
	
	
label 
	bikecash="Bike - Paid Cash"
	furniturecash="Furniture - Paid Cash"
	applicancecash="Applicances - Paid Cash"
	mailboxcash="Mailbox - Paid Cash"
	pianocash="Piano - Paid Cash"
	
	toasternowar="Purchased Toaster - No Warranty"
	toasterwar="Purchased Toaster - Warranty"
	pianonowar="Purchased Piano - No Warranty"
	pianowar="Purchased Piano - Warranty"
;

RUN;


/* Running PROC CONTENTS and PROC MEANS to quickly review output */

PROC CONTENTS data=sastrain.sales_variables;
RUN;

PROC MEANS data=sastrain.sales_variables n mean min max median range stddev var;
	var Sale_Price_1 Sale_Price_2 Sale_Price_3;
RUN;
