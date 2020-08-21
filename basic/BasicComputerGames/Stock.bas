10 PRINT TAB(30);"STOCK MARKET"
20 PRINT TAB(15);"CREATIVE COMPUTING  MORRISTOWN, NEW JERSEY"
30 PRINT: PRINT: PRINT
100 REM STOCK MARKET SIMULATION     -STOCK-
101 REM REVISED 8/18/70 (D. PESSEL, L. BRAUN, C. LOSIK)
102 REM IMP VRBLS: A-MRKT TRND SLP; B5-BRKRGE FEE; C-TTL CSH ASSTS;
103 REM C5-TTL CSH ASSTS (TEMP); C(I)-CHNG IN STK VAL; D-TTL ASSTS;
104 REM E1,E2-LRG CHNG MISC; I-STCK #; I1,I2-STCKS W LRG CHNG;
105 REM N1,N2-LRG CHNG DAY CNTS; P5-TTL DAYS PRCHSS; P(I)-PRTFL CNTNTS;
106 REM Q9-NEW CYCL?; S4-SGN OF A; S5-TTL DYS SLS; S(I)-VALUE/SHR;
107 REM T-TTL STCK ASSTS; T5-TTL VAL OF TRNSCTNS;
108 REM W3-LRG CHNG; X1-SMLL CHNG(<$1); Z4,Z5,Z6-NYSE AVE.; Z(I)-TRNSCT
110 DIM S(5),P(5),Z(5),C(5)
112 REM SLOPE OF MARKET TREND:A  (SAME FOR ALL STOCKS)
113 LET X=1
114 LET A=INT((RND(X)/10)*100+.5)/100
115 LET T5=0
116 LET X9=0
117 LET N1=0
118 LET N2=0
119 LET E1=0
120 LET E2=0
121 REM INTRODUCTION
122 PRINT "DO YOU WANT THE INSTRUCTIONS (YES-TYPE 1, NO-TYPE 0)";
123 INPUT Z9
124 PRINT
125 PRINT
126 IF Z9<1 THEN 200
130 PRINT "THIS PROGRAM PLAYS THE STOCK MARKET.  YOU WILL BE GIVEN"
132 PRINT "$10,000 AND MAY BUY OR SELL STOCKS.  THE STOCK PRICES WILL"
134 PRINT "BE GENERATED RANDOMLY AND THEREFORE THIS MODEL DOES NOT"
135 PRINT "REPRESENT EXACTLY WHAT HAPPENS ON THE EXCHANGE.  A TABLE"
136 PRINT "OF AVAILABLE STOCKS, THEIR PRICES, AND THE NUMBER OF SHARES"
137 PRINT "IN YOUR PORTFOLIO WILL BE PRINTED.  FOLLOWING THIS, THE"
138 PRINT "INITIALS OF EACH STOCK WILL BE PRINTED WITH A QUESTION"
139 PRINT "MARK.  HERE YOU INDICATE A TRANSACTION.  TO BUY A STOCK"
140 PRINT "TYPE +NNN, TO SELL A STOCK TYPE -NNN, WHERE NNN IS THE"
141 PRINT "NUMBER OF SHARES.  A BROKERAGE FEE OF 1% WILL BE CHARGED"
142 PRINT "ON ALL TRANSACTIONS.  NOTE THAT IF A STOCK'S VALUE DROPS"
143 PRINT "TO ZERO IT MAY REBOUND TO A POSITIVE VALUE AGAIN.  YOU"
144 PRINT "HAVE $10,000 TO INVEST.  USE INTEGERS FOR ALL YOUR INPUTS."
145 PRINT "(NOTE:  TO GET A 'FEEL' FOR THE MARKET RUN FOR AT LEAST"
146 PRINT "10 DAYS)"
147 PRINT "-----GOOD LUCK!-----"
200 REM GENERATION OF STOCK TABLE; INPUT REQUESTS
210 REM INITIAL STOCK VALUES
220 LET S(1)=100
230 LET S(2)=85
240 LET S(3)=150
250 LET S(4)=140
260 LET S(5)=110
265 REM INITIAL T8 - # DAYS FOR FIRST TREND SLOPE (A)
266 LET T8=INT(4.99*RND(X)+1)
267 REM RANDOMIZE SIGN OF FIRST TREND SLOPE (A)
268 IF RND(X)>.5 THEN 270
269 LET A=-A
270 REM RANDOMIZE INITIAL VALUES
280 GOSUB 830
285 REM INITIAL PORTFOLIO CONTENTS
290 FOR I=1 TO 5
300 LET P(I)=0
305 LET Z(I)=0
310 NEXT I
320 PRINT
330 PRINT
333 REM INITIALIZE CASH ASSETS:C
335 LET C=10000
338 REM PRINT INITIAL PORTFOLIO
340 PRINT "STOCK"," ","INITIALS","PRICE/SHARE"
350 PRINT "INT. BALLISTIC MISSILES","  IBM",S(1)
352 PRINT "RED CROSS OF AMERICA","  RCA",S(2)
354 PRINT "LICHTENSTEIN, BUMRAP & JOKE","  LBJ",S(3)
356 PRINT "AMERICAN BANKRUPT CO.","  ABC",S(4)
358 PRINT "CENSURED BOOKS STORE","  CBS",S(5)
360 PRINT
361 REM NYSE AVERAGE:Z5; TEMP. VALUE:Z4; NET CHANGE:Z6
363 LET Z4=Z5
364 LET Z5=0
365 LET T=0
370 FOR I=1 TO 5
375 LET Z5=Z5+S(I)
380 LET T=T+S(I)*P(I)
390 NEXT I
391 LET Z5=INT(100*(Z5/5)+.5)/100
392 LET Z6=INT((Z5-Z4)*100+.5)/100
393 REM TOTAL ASSETS:D
394 LET D=T+C
395 IF X9>0 THEN 398
396 PRINT "NEW YORK STOCK EXCHANGE AVERAGE: "Z5
397 GOTO 399
398 PRINT "NEW YORK STOCK EXCHANGE AVERAGE: "Z5"NET CHANGE"Z6
399 PRINT
400 LET T=INT(100*T+.5)/100
401 PRINT "TOTAL STOCK ASSETS ARE   $";T
403 LET C=INT(100*C+.5)/100
405 PRINT "TOTAL CASH ASSETS ARE    $";C
407 LET D=INT(100*D+.5)/100
408 PRINT "TOTAL ASSETS ARE         $";D
410 PRINT
411 IF X9=0 THEN 416
412 PRINT "DO YOU WISH TO CONTINUE (YES-TYPE 1, NO-TYPE 0)";
413 INPUT Q9
414 IF Q9<1 THEN 998
416 REM INPUT TRANSACTIONS
420 PRINT "WHAT IS YOUR TRANSACTION IN"
430 PRINT "IBM";
440 INPUT Z(1)
450 PRINT "RCA";
460 INPUT Z(2)
470 PRINT "LBJ";
480 INPUT Z(3)
490 PRINT "ABC";
500 INPUT Z(4)
510 PRINT "CBS";
520 INPUT Z(5)
525 PRINT
530 REM TOTAL DAY'S PURCHASES IN $:P5
540 LET P5=0
550 REM TOTAL DAY'S SALES IN $:S5
560 LET S5=0
570 FOR I=1 TO 5
575 LET Z(I)=INT(Z(I)+.5)
580 IF Z(I)<=0 THEN 610
590 LET P5=P5+Z(I)*S(I)
600 GOTO 620
610 LET S5=S5-Z(I)*S(I)
612 IF -Z(I)<=P(I) THEN 620
614 PRINT "YOU HAVE OVERSOLD A STOCK; TRY AGAIN."
616 GOTO 420
620 NEXT I
622 REM TOTAL VALUE OF TRANSACTIONS:T5
625 LET T5=P5+S5
630 REM BROKERAGE FEE:B5
640 LET B5=INT(.01*T5*100+.5)/100
650 REM CASH ASSETS=OLD CASH ASSETS-TOTAL PURCHASES
652 REM -BROKERAGE FEES+TOTAL SALES:C5
654 LET C5=C-P5-B5+S5
656 IF C5>=0 THEN 674
658 PRINT "YOU HAVE USED $";-C5;" MORE THAN YOU HAVE."
660 GOTO 420
674 LET C=C5
675 REM CALCULATE NEW PORTFOLIO
680 FOR I=1 TO 5
690 LET P(I)=P(I)+Z(I)
700 NEXT I
710 REM CALCULATE NEW STOCK VALUES
720 GOSUB 830
750 REM PRINT PORTFOLIO
751 REM BELL RINGING-DIFFERENT ON MANY COMPUTERS
755 PRINT
756 PRINT "**********     END OF DAY'S TRADING     **********"
757 PRINT
758 PRINT
759 IF X9<1 THEN 769
769 PRINT "STOCK","PRICE/SHARE","HOLDINGS", "VALUE", "NET PRICE CHANGE"
770 PRINT "IBM", S(1), P(1), S(1)*P(1), C(1)
771 PRINT "RCA", S(2), P(2), S(2)*P(2), C(2)
772 PRINT "LBJ", S(3), P(3), S(3)*P(3), C(3)
773 PRINT "ABC", S(4), P(4), S(4)*P(4), C(4)
774 PRINT "CBS", S(5), P(5), S(5)*P(5), C(5)
775 LET X9=1
780 PRINT
790 PRINT
810 GOTO 360
829 REM NEW STOCK VALUES - SUBROUTINE
830 REM RANDOMLY PRODUCE NEW STOCK VALUES BASED ON PREVIOUS
831 REM DAY'S VALUES
832 REM N1,N2 ARE RANDOM NUMBERS OF DAYS WHICH RESPECTIVELY
833 REM DETERMINE WHEN STOCK I1 WILL INCREASE 10 PTS. AND STOCK
834 REM I2 WILL DECREASE 10 PTS.
840 REM IF N1 DAYS HAVE PASSED, PICK AN I1, SET E1, DETERMINE NEW N1
841 IF N1>0 THEN 850
845 LET I1=INT(4.99*RND(X)+1)
846 LET N1=INT(4.99*RND(X)+1)
847 LET E1=1
850 REM IF N2 DAYS HAVE PASSED, PICK AN I2, SET E2, DETERMINE NEW N2
851 IF N2>0 THEN 860
855 LET I2=INT(4.99*RND(X)+1)
856 LET N2=INT(4.99*RND(X)+1)
857 LET E2=1
860 REM DEDUCT ONE DAY FROM N1 AND N2
861 LET N1=N1-1
862 LET N2=N2-1
890 REM LOOP THROUGH ALL STOCKS
900 FOR I=1 TO 5
910 LET X1=RND(X)
915 IF X1>.25 THEN 920
916 LET X1=.25
917 GOTO 935
920 IF X1>.5 THEN 925
921 LET X1=.5
922 GOTO 935
925 IF X1>.75 THEN 930
926 LET X1=.75
927 GOTO 935
930 LET X1=0.0
931 REM BIG CHANGE CONSTANT:W3  (SET TO ZERO INITIALLY)
935 LET W3=0
936 IF E1<1 THEN 945
937 IF INT(I1+.5)<>INT(I+.5) THEN 945
938 REM ADD 10 PTS. TO THIS STOCK;  RESET E1
939 LET W3=10
943 LET E1=0
945 IF E2<1 THEN 955
947 IF INT(I2+.5)<>INT(I+.5) THEN 955
948 REM SUBTRACT 10 PTS. FROM THIS STOCK;  RESET E2
949 LET W3=W3-10
953 LET E2=0
954 REM C(I) IS CHANGE IN STOCK VALUE
955 LET C(I)=INT(A*S(I))+X1+INT(3-6*RND(X)+.5)+W3
956 LET C(I)=INT(100*C(I)+.5)/100
957 LET S(I)=S(I)+C(I)
960 IF S(I)>0 THEN 967
964 LET C(I)=0
965 LET S(I)=0
966 GOTO 970
967 LET S(I)=INT(100*S(I)+.5)/100
970 NEXT I
972 REM AFTER T8 DAYS RANDOMLY CHANGE TREND SIGN AND SLOPE
973 LET T8=T8-1
974 IF T8<1 THEN 985
980 RETURN
985 REM RANDOMLY CHANGE TREND SIGN AND SLOPE (A), AND DURATION
986 REM OF TREND (T8)
990 LET T8=INT(4.99*RND(X)+1)
992 LET A=INT((RND(X)/10)*100+.5)/100
993 LET S4=RND(X)
994 IF S4<=.5 THEN 997
995 LET A=-A
997 RETURN
998 PRINT "HOPE YOU HAD FUN!!"
999 END
