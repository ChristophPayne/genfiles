/* Run PROC CONTENTS to verify var data types after each conv. step */

PROC CONTENTS data=sastrain.simple_salesdata_warranty;
RUN;


/* Convert var 'Purchase_Warranty' to numeric values then run corr. analysis */
/* IMPORTANT: Purchase_Warranty contains a special hyphen:
    Unicode U+2013 is the special hyphen and is in dataset and code
    Unicode U+002d is the "regular" hyphen from a standard U.S. QWERTY keyboard 
*/

DATA sastrain.simple_salesdata_warranty;
set sastrain.simple_salesdata;
RUN;


PROC SQL;
	UPDATE sastrain.simple_salesdata_warranty
	SET Purchase_Warranty = '0' WHERE Purchase_Warranty = 'No';
	UPDATE sastrain.simple_salesdata_warranty
	SET Purchase_Warranty = '1' WHERE Purchase_Warranty = 'Yes – 1 Year';
	UPDATE sastrain.simple_salesdata_warranty
	SET Purchase_Warranty = '2' WHERE Purchase_Warranty = 'Yes – 2 Year';
	UPDATE sastrain.simple_salesdata_warranty
	SET Purchase_Warranty = '3' WHERE Purchase_Warranty = 'Yes – 3 Year';
	;
QUIT;
	
	
/* Create new var as numeric - drop "old" character var */
	
DATA sastrain.simple_salesdata_warranty;
set sastrain.simple_salesdata_warranty;
purchase_wty = input(Purchase_Warranty, best1.);
drop Purchase_Warranty;
RUN;
	
	
/* Correlation analysis - sales price and warranty have small positive correlation */
	
PROC CORR data=sastrain.simple_salesdata_warranty plots=matrix;
	var Sale_Price_1 Sale_Price_2 Sale_Price_3 ;
	with purchase_wty;
RUN;