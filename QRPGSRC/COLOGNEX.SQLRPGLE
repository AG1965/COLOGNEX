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

   // in Grossbuchstaben umwandeln, trimmen und mit einem führenden Leerzeichen versehen,
   // damit die Wortanfangs-Prüfungen leichter sind
   rtn_string = ' ' + %UPPER(%TRIM(p_input));

   // Umlaute und das scharfe ß kommen in der Kölner Phonetik nicht vor
   rtn_string = %SCANRPL('Ä':'A':rtn_string);
   rtn_string = %SCANRPL('Ö':'O':rtn_string);
   rtn_string = %SCANRPL('Ü':'U':rtn_string);
   rtn_string = %SCANRPL('ß':'SZ':rtn_string);

   // Bindestriche entfernen
   rtn_string = %SCANRPL('-' :'' :rtn_string);

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
