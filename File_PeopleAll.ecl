IMPORT $;
EXPORT File_PeopleAll := MODULE //'~CLASS::BMF::OUT::PeopleAll'
  EXPORT People   := DATASET('~CLASS::BMF::OUT::PeopleAll',$.DeNorm_PeopleAll.Layout_PeopleAll,FLAT);
  EXPORT Vehicle  := People.Vehiclerecs; //3A
  EXPORT Property := People.PropRecs;    //3C
  EXPORT Taxdata  := People.PropRecs.TaxRecs; //3B
END;