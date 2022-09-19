//BWR_ParseText
d := DATASET('~CLASS::BMF::IN::imdb_movies',{STRING line},CSV(SEPARATOR(''),QUOTE('')));
OUTPUT(d);
PATTERN arb       := ANY+;
PATTERN alpha     := PATTERN('[a-zA-Z]')+;
PATTERN Numbers   := PATTERN('[-0-9?,]')+;
PATTERN fs        := PATTERN('[\t]')+; //field separator
PATTERN Year      := '(' Numbers OPT('/' arb) ')';
PATTERN Vidtype   := ' (' alpha ')';
PATTERN Title     := arb Year OPT(Vidtype);
PATTERN movieyr   := Numbers;
PATTERN comment   := '(' arb ')';
RULE    moviedata := Title fs movieyr OPT(fs comment);

Outrec := RECORD
 STRING MovieTitle    := MATCHTEXT(Title/arb);
 STRING Titleyear     := MATCHTEXT(Title/Year/Numbers);
 STRING MovieType     := MATCHTEXT(Title/Vidtype);
 STRING Releaseyear   := MATCHTEXT(movieyr);
 STRING AddedComments := MATCHTEXT(comment/arb);
END;

x := PARSE(d,line,moviedata,Outrec);
y := PARSE(d,line,moviedata,Outrec,FIRST);

OUTPUT(x);
OUTPUT(y);
OUTPUT(y(AddedComments <> ''));