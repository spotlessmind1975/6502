8 PRINT "YOU ARE A PILOT IN A WORLD WAR II BOMBER."
10 INPUT "WHAT SIDE -- ITALY(1), ALLIES(2), JAPAN(3), GERMANY(4)";A
20 IF A>0 AND A<5 THEN 25
22 PRINT "TRY AGAIN..." : GOTO 10
25 ON A GOTO 30, 110, 200, 220
30 INPUT "YOUR TARGET -- ALBANIA(1), GREECE(2), NORTH AFRICA(3)";B
40 IF B>0 AND B<4 THEN 45
42 PRINT "TRY AGAIN..." : GOTO 30
45 PRINT : ON B GOTO 50, 80,90
50 PRINT "SHOULD BE EASY -- YOU'RE FLYING A NAZI-MADE PLANE."
60 GOTO 280
80 PRINT "BE CAREFUL!!!" : GOTO 280
90 PRINT "YOU'RE GOING FOR THE OIL, EH?" : GOTO 280
110 INPUT "AIRCRAFT -- LIBERATOR(1), B-29(2), B-17(3), LANCASTER(4)";G
120 IF G>0 AND G<5 THEN 125
122 PRINT "TRY AGAIN..." : GOTO 110
125 PRINT : ON G GOTO 130, 150, 170, 190
130 PRINT "YOU'VE GOT 2 TONS OF BOMBS FLYING FOR PLOESTI." : GOTO 280
150 PRINT "YOU'RE DUMPING THE A-BOMB ON HIROSHIMA." : GOTO 280
170 PRINT "YOU'RE CHASING THE BISMARK IN THE NORTH SEA." : GOTO 280
190 PRINT "YOU'RE BUSTING A GERMAN HEAVY WATER PLANT IN THE RUHR."
195 GOTO 280
200 PRINT "YOU'RE FLYING A KAMIKAZE MISSION OVER THE USS LEXINGTON."
205 INPUT "YOUR FIRST KAMIKAZE MISSION(Y OR N)";F$
207 IF F$="N" THEN S=0 : GOTO 358
210 PRINT : IF RND(1)>.65 THEN 325
215 GOTO 380
220 PRINT "A NAZI, EH?  OH WELL.  ARE YOU GOING FOR RUSSIA(1),"
230 INPUT "ENGLAND(2), OR FRANCE(3)";M : IF M>0 AND M<4 THEN 235
232 PRINT "TRY AGAIN..." : GOTO 220
235 PRINT : ON M GOTO 250, 260, 270
250 PRINT "YOU'RE NEARING STALINGRAD." : GOTO 280
260 PRINT "NEARING LONDON.  BE CAREFUL, THEY'VE GOT RADAR." : GOTO 280
270 PRINT "NEARING VERSAILLES.  DUCK SOUP.  THEY'RE NEARLY DEFENSELESS."
280 PRINT
285 INPUT "HOW MANY MISSIONS HAVE YOU FLOWN";D
290 IF D<160 THEN 300
292 PRINT "MISSIONS, NOT MILES..."
295 PRINT "150 MISSIONS IS HIGH EVEN FOR OLD-TIMERS."
297 PRINT "NOW THEN, "; : GOTO 285
300 PRINT:IF D<100 THEN 310
305 PRINT "THAT'S PUSHING THE ODDS!" : GOTO 320
310 IF D<25 THEN PRINT "FRESH OUT OF TRAINING, EH?"
320 PRINT : IF D<160*RND(1) THEN 330
325 PRINT "DIRECT HIT!!!! "INT(100*RND(1))"KILLED."
327 PRINT "MISSION SUCCESSFUL." : GOTO 390
330 PRINT "MISSED TARGET BY"INT(2+30*RND(1))"MILES!"
335 PRINT "NOW YOU'RE REALLY IN FOR IT !!" : PRINT
340 INPUT "DOES THE ENEMY HAVE GUNS(1), MISSILES(2), OR BOTH(3)";R
345 IF R>0 AND R<4 THEN 350
347 PRINT "TRY AGAIN..." : GOTO 340
350 PRINT : T=0 : IF R=2 THEN 360
355 INPUT "WHAT'S THE PERCENT HIT RATE OF ENEMY GUNNERS (10 TO 50)";S
357 IF S<10 THEN PRINT "YOU LIE, BUT YOU'LL PAY...": GOTO 380
358 PRINT
360 PRINT : IF R>1 THEN T=35
365 IF S+T>100*RND(1) THEN 380
370 PRINT "YOU MADE IT THROUGH TREMENDOUS FLAK!!" : GOTO 390
380 PRINT "* * * * BOOM * * * *"
384 PRINT "YOU HAVE BEEN SHOT DOWN....."
386 PRINT "DEARLY BELOVED, WE ARE GATHERED HERE TODAY TO PAY OUR"
387 PRINT "LAST TRIBUTE..."
390 PRINT:PRINT:PRINT:INPUT "ANOTHER MISSION (Y OR N)";U$
395 IF U$="Y" THEN 8
400 PRINT "CHICKEN !!!" : PRINT : END
