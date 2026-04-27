**FREE
Ctl-Opt NOMAIN OPTION(*SRCSTMT:*NODEBUGIO:*NOUNREF)
        TEXT('Kölner Phonetik');

// Kölner Phonetik in SQLRPGLE

// https://github.com/AG1965/COLOGNEX

// siehe https://de.wikipedia.org/wiki/K%C3%B6lner_Phonetik

Dcl-Proc colognex EXPORT;
   Dcl-Pi *N  LIKE(rtn_string);
      p_input  VARCHAR(512) CONST;
   End-Pi;

   Dcl-S  rtn_string VARCHAR(512);

   Dcl-S  #i  Int(10);
   Dcl-S  lastChar          CHAR(1);
   Dcl-S  helpChar          CHAR(1);
   Dcl-S  lastCharWasSpace  Ind;

   Dcl-DS  BAD_CHARS QUALIFIED;
      A_ACUTE      CHAR(1) INZ('Á');
      C_ACUTE      CHAR(1) INZ('Ć');
      E_ACUTE      CHAR(1) INZ('É');
      I_ACUTE      CHAR(1) INZ('Í');
      L_ACUTE      CHAR(1) INZ('Ĺ');
      N_ACUTE      CHAR(1) INZ('Ń');
      O_ACUTE      CHAR(1) INZ('Ó');
      O_ACUTE2     CHAR(1) INZ('Ő');
      R_ACUTE      CHAR(1) INZ('Ŕ');
      S_ACUTE      CHAR(1) INZ('Ś');
      U_ACUTE      CHAR(1) INZ('Ú');
      U_ACUTE2     CHAR(1) INZ('Ű');
      Y_ACUTE      CHAR(1) INZ('Ý');
      Z_ACUTE      CHAR(1) INZ('Ź');
      A_BREVE      CHAR(1) INZ('Ă');
      E_BREVE      CHAR(1) INZ('Ĕ');
      G_BREVE      CHAR(1) INZ('Ğ');
      I_BREVE      CHAR(1) INZ('Ĭ');
      O_BREVE      CHAR(1) INZ('Ŏ');
      U_BREVE      CHAR(1) INZ('Ŭ');
      C_CARON      CHAR(1) INZ('Č');
      D_CARON      CHAR(1) INZ('Ď');
      E_CARON      CHAR(1) INZ('Ě');
      L_CARON      CHAR(1) INZ('Ľ');
      N_CARON      CHAR(1) INZ('Ň');
      R_CARON      CHAR(1) INZ('Ř');
      S_CARON      CHAR(1) INZ('Š');
      T_CARON      CHAR(1) INZ('Ť');
      Z_CARON      CHAR(1) INZ('Ž');
      C_CEDILLE    CHAR(1) INZ('Ç');
      G_CEDILLE    CHAR(1) INZ('Ģ');
      K_CEDILLE    CHAR(1) INZ('Ķ');
      L_CEDILLE    CHAR(1) INZ('Ļ');
      N_CEDILLE    CHAR(1) INZ('Ņ');
      R_CEDILLE    CHAR(1) INZ('Ŗ');
      S_CEDILLE    CHAR(1) INZ('Ş');
      T_CEDILLE    CHAR(1) INZ('Ţ');
      E_DIARESIS   CHAR(1) INZ('Ë');
      I_DIARESIS   CHAR(1) INZ('Ï');
      Y_DIARESIS   CHAR(1) INZ('Ÿ');
      A_GRAVE      CHAR(1) INZ('À');
      E_GRAVE      CHAR(1) INZ('È');
      I_GRAVE      CHAR(1) INZ('Ì');
      O_GRAVE      CHAR(1) INZ('Ò');
      U_GRAVE      CHAR(1) INZ('Ù');
      AE           CHAR(1) INZ('Æ');
      OE           CHAR(1) INZ('Œ');
      IJ           CHAR(1) INZ('Ĳ');
      A_MACRON     CHAR(1) INZ('Ā');
      E_MACRON     CHAR(1) INZ('Ē');
      I_MACRON     CHAR(1) INZ('Ī');
      O_MACRON     CHAR(1) INZ('Ō');
      U_MACRON     CHAR(1) INZ('Ū');
      L_DOT        CHAR(1) INZ('Ŀ');
      A_OGONEK     CHAR(1) INZ('Ą');
      E_OGONEK     CHAR(1) INZ('Ę');
      I_OGONEK     CHAR(1) INZ('Į');
      U_OGONEK     CHAR(1) INZ('Ų');
      D_STROKE     CHAR(1) INZ('Đ');
      H_STROKE     CHAR(1) INZ('Ħ');
      T_STROKE     CHAR(1) INZ('Ŧ');
   End-DS; 
   Dcl-DS GOOD_CHARS QUALIFIED;
      A_ACUTE      CHAR(1) INZ('A');
      C_ACUTE      CHAR(1) INZ('C');
      E_ACUTE      CHAR(1) INZ('E');
      I_ACUTE      CHAR(1) INZ('I');
      L_ACUTE      CHAR(1) INZ('L');
      N_ACUTE      CHAR(1) INZ('N');
      O_ACUTE      CHAR(1) INZ('O');
      O_ACUTE2     CHAR(1) INZ('O');
      R_ACUTE      CHAR(1) INZ('R');
      S_ACUTE      CHAR(1) INZ('S');
      U_ACUTE      CHAR(1) INZ('U');
      U_ACUTE2     CHAR(1) INZ('U');
      Y_ACUTE      CHAR(1) INZ('Y');
      Z_ACUTE      CHAR(1) INZ('Z');
      A_BREVE      CHAR(1) INZ('A');
      E_BREVE      CHAR(1) INZ('E');
      G_BREVE      CHAR(1) INZ('G');
      I_BREVE      CHAR(1) INZ('I');
      O_BREVE      CHAR(1) INZ('O');
      U_BREVE      CHAR(1) INZ('U');
      C_CARON      CHAR(1) INZ('C');
      D_CARON      CHAR(1) INZ('D');
      E_CARON      CHAR(1) INZ('E');
      L_CARON      CHAR(1) INZ('L');
      N_CARON      CHAR(1) INZ('N');
      R_CARON      CHAR(1) INZ('R');
      S_CARON      CHAR(1) INZ('S');
      T_CARON      CHAR(1) INZ('T');
      Z_CARON      CHAR(1) INZ('Z');
      C_CEDILLE    CHAR(1) INZ('C');
      G_CEDILLE    CHAR(1) INZ('G');
      K_CEDILLE    CHAR(1) INZ('K');
      L_CEDILLE    CHAR(1) INZ('L');
      N_CEDILLE    CHAR(1) INZ('N');
      R_CEDILLE    CHAR(1) INZ('R');
      S_CEDILLE    CHAR(1) INZ('S');
      T_CEDILLE    CHAR(1) INZ('T');
      E_DIARESIS   CHAR(1) INZ('E');
      I_DIARESIS   CHAR(1) INZ('I');
      Y_DIARESIS   CHAR(1) INZ('Y');
      A_GRAVE      CHAR(1) INZ('A');
      E_GRAVE      CHAR(1) INZ('E');
      I_GRAVE      CHAR(1) INZ('I');
      O_GRAVE      CHAR(1) INZ('O');
      U_GRAVE      CHAR(1) INZ('U');
      AE           CHAR(1) INZ('A');
      OE           CHAR(1) INZ('O');
      IJ           CHAR(1) INZ('I');
      A_MACRON     CHAR(1) INZ('A');
      E_MACRON     CHAR(1) INZ('E');
      I_MACRON     CHAR(1) INZ('I');
      O_MACRON     CHAR(1) INZ('O');
      U_MACRON     CHAR(1) INZ('U');
      L_DOT        CHAR(1) INZ('L');
      A_OGONEK     CHAR(1) INZ('A');
      E_OGONEK     CHAR(1) INZ('E');
      I_OGONEK     CHAR(1) INZ('I');
      U_OGONEK     CHAR(1) INZ('U');
      D_STROKE     CHAR(1) INZ('D');
      H_STROKE     CHAR(1) INZ('H');
      T_STROKE     CHAR(1) INZ('T');
   End-DS; 


   // in Grossbuchstaben umwandeln, trimmen und mit einem führenden Leerzeichen versehen,
   // damit die Wortanfangs-Prüfungen leichter sind
   rtn_string = ' ' + %UPPER(%TRIM(p_input));

   // Zeichen mit Akut etc. durch entsprechende "normale" Zeichen ersetzen
   rtn_string = %XLATE(BAD_CHARS:GOOD_CHARS:rtn_string);

   // Umlaute und das scharfe ß kommen in der Kölner Phonetik nicht vor
   rtn_string = %SCANRPL('Ä':'A':rtn_string);
   rtn_string = %SCANRPL('Ö':'O':rtn_string);
   rtn_string = %SCANRPL('Ü':'U':rtn_string);
   rtn_string = %SCANRPL('ß':'SZ':rtn_string);

   // Bindestriche komplett entfernen
   rtn_string = %SCANRPL('-':'':rtn_string);
   // Punkte durch Leerzeichen ersetzen
   rtn_string = %SCANRPL('.':' ':rtn_string);
   // Beistriche und Strichpunkte ebenso durch Leerzeichen ersetzen
   rtn_string = %SCANRPL('.':' ':rtn_string);
   rtn_string = %SCANRPL(';':' ':rtn_string);


   // alles ausser Leerzeichen und Buchstaben entfernen
   FOR #i = 1 TO %LEN(rtn_string);
      IF %SUBST(rtn_string:#i:1) <> ' ' AND
        (%SUBST(rtn_string:#i:1) < 'A' OR
         %SUBST(rtn_string:#i:1) > 'Z');
         
         %SUBST(rtn_string:#i:1) = ' ';
      
      ENDIF;
   ENDFOR;



   // C: außer nach S, Z - darum vorher
   rtn_string = %SCANRPL('SC' :'8'  :rtn_string);
   rtn_string = %SCANRPL('ZC' :'8'  :rtn_string);

   // " CA" am Wortanfang (im Anlaut) durch "KA" ersetzen, usw.
   rtn_string = %SCANRPL('CA' :'4A' :rtn_string);
   rtn_string = %SCANRPL('CH' :'4H' :rtn_string);
   rtn_string = %SCANRPL('CK' :'4K' :rtn_string);
   rtn_string = %SCANRPL(' CL':' 4L':rtn_string);
   rtn_string = %SCANRPL('CO' :'4O' :rtn_string);
   rtn_string = %SCANRPL('CQ' :'4Q' :rtn_string);
   rtn_string = %SCANRPL(' CR':' 4R':rtn_string);
   rtn_string = %SCANRPL('CU' :'4U' :rtn_string);
   rtn_string = %SCANRPL('CX' :'4X' :rtn_string);

   rtn_string = %SCANRPL('DC' :'8C' :rtn_string);
   rtn_string = %SCANRPL('DS' :'8S' :rtn_string);
   rtn_string = %SCANRPL('DZ' :'8Z' :rtn_string);
   rtn_string = %SCANRPL('TC' :'8C' :rtn_string);
   rtn_string = %SCANRPL('TS' :'8S' :rtn_string);
   rtn_string = %SCANRPL('TZ' :'8Z' :rtn_string);

   rtn_string = %SCANRPL('CX' :'8'  :rtn_string);
   rtn_string = %SCANRPL('KX' :'8'  :rtn_string);
   rtn_string = %SCANRPL('QX' :'8'  :rtn_string);



   rtn_string = %SCANRPL('A'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('E'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('I'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('J'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('O'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('U'  :'0'  :rtn_string);
   rtn_string = %SCANRPL('Y'  :'0'  :rtn_string);

   rtn_string = %SCANRPL('H'  :''   :rtn_string);

   rtn_string = %SCANRPL('B'  :'1'  :rtn_string);
   rtn_string = %SCANRPL('P'  :'1'  :rtn_string);

   rtn_string = %SCANRPL('D'  :'2'  :rtn_string);
   rtn_string = %SCANRPL('T'  :'2'  :rtn_string);

   rtn_string = %SCANRPL('F'  :'3'  :rtn_string);
   rtn_string = %SCANRPL('V'  :'3'  :rtn_string);
   rtn_string = %SCANRPL('W'  :'3'  :rtn_string);

   rtn_string = %SCANRPL('G'  :'4'  :rtn_string);
   rtn_string = %SCANRPL('K'  :'4'  :rtn_string);
   rtn_string = %SCANRPL('Q'  :'4'  :rtn_string);

   rtn_string = %SCANRPL('L'  :'5'  :rtn_string);

   rtn_string = %SCANRPL('M'  :'6'  :rtn_string);
   rtn_string = %SCANRPL('N'  :'6'  :rtn_string);

   rtn_string = %SCANRPL('R'  :'7'  :rtn_string);

   rtn_string = %SCANRPL('C'  :'8'  :rtn_string);
   rtn_string = %SCANRPL('S'  :'8'  :rtn_string);
   rtn_string = %SCANRPL('Z'  :'8'  :rtn_string);

   rtn_string = %SCANRPL('X'  :'48' :rtn_string);

   // alle mehrfach nebeneinander vorkommende Zeichen entfernen
   lastChar = x'FF';
   FOR #i = 2 TO %LEN(rtn_string);
      helpChar = %SUBST(rtn_string:#i:1);
      IF helpChar = lastChar;
         IF #i < %LEN(rtn_string);
            rtn_string = %SUBST(rtn_string:1:#i - 1) + %SUBST(rtn_string:#i + 1);
            #i -= 1;
            ITER;
         ELSE;
            rtn_string = %SUBST(rtn_string:1:#i - 1);
            LEAVE;
         ENDIF;
      ENDIF;
      lastChar = helpChar;
   ENDFOR;

   // alle 0er bis auf die am Wortanfang entfernen
   lastCharWasSpace = *ON;
   FOR #i = 2 TO %LEN(rtn_string);
      IF %SUBST(rtn_string:#i:1) = '0' AND NOT lastCharWasSpace;
         IF #i < %LEN(rtn_string);
            rtn_string = %SUBST(rtn_string:1:#i - 1) + %SUBST(rtn_string:#i + 1);
         ELSE;
            rtn_string = %SUBST(rtn_string:1:#i - 1);
            LEAVE;
         ENDIF;
      ENDIF;
      lastCharWasSpace = (%SUBST(rtn_string:#i:1) = ' ');
   ENDFOR;

   rtn_string = %TRIM(rtn_string);

   RETURN rtn_string;

End-Proc;
