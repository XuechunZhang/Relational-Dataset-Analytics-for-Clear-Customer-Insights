#option('validateFileType', false);
//BWR_ParseXML
rec := RECORD
 INTEGER2  seq;
 STRING   line;
END;

ds := DATASET('~CLASS::bmf::IN::EmbeddedXMLtimezones',rec,THOR);
OUTPUT(ds);
outrec := RECORD
 STRING code        := XMLTEXT('@code');
 STRING description := XMLTEXT('@description');
 STRING zone        := XMLTEXT('@zone');
END;
/* outrec ParseIt(rec L) := TRANSFORM
    SELF.code        := XMLTEXT('@code');
    SELF.description := XMLTEXT('@description');
    SELF.zone        := XMLTEXT('@zone');
   END;
*/

x := PARSE(ds,line,outrec,XML('area'));
OUTPUT(x);