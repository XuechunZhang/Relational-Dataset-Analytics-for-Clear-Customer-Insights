IMPORT $;
PeopleRec  := $.Denorm_PeopleAll.Layout_PeopleAll;
PropTaxRec := $.DenormProp.Layout_PropTax;
//Restore parent record (people) 
ParentOut := PROJECT($.File_PeopleAll.People, $.File_People.Layout);


// $.File_Vehicle.Layout ChildMove(PeopleRec Le, INTEGER Cnt):=TRANSFORM
  // SELF := L.VehicleRecs[Cnt];
// END;
// ReNormedVRecs := NORMALIZE($.File_PeopleAll.People,
                           // LEFT.childvcount,
                           // ChildMove(LEFT,COUNTER));
// ReNormedVRecs := NORMALIZE($.File_PeopleAll.People,
                           // LEFT.VehicleRecs,
                           // TRANSFORM(RIGHT));
ReNormedVRecs := PROJECT($.File_PeopleAll.Vehicle,$.File_Vehicle.Layout);
// $.File_Property.Layout ChildPropMove(PeopleRec L, INTEGER C):=TRANSFORM
  // SELF := L.PropRecs[C];
// END;
// ReNormedPRecs := NORMALIZE($.File_PeopleAll.People,
                           // LEFT.childPcount,
                           // ChildPropMove(LEFT,COUNTER));
// ReNormedPRecs := NORMALIZE($.File_PeopleAll.People,
                           // LEFT.PropRecs,
                           // TRANSFORM($.File_Property.Layout,SELF := RIGHT));
ReNormedPRecs := PROJECT($.File_PeopleAll.Property,$.File_Property.Layout);
// $.File_Taxdata.Layout ChildTaxMove(PropTaxRec Le, INTEGER Cnt):=TRANSFORM
  // SELF := L.TaxRecs[Cnt];
// END;
// ReNormedTRecs := NORMALIZE($.File_PeopleAll.Property,
                           // LEFT.childcount,
                           // ChildTaxMove(LEFT,COUNTER));
// ReNormedTRecs := NORMALIZE($.File_PeopleAll.Property,
                           // LEFT.TaxRecs,
                           // TRANSFORM(RIGHT));
ReNormedTRecs := PROJECT($.File_PeopleAll.Taxdata,$.File_Taxdata.Layout);
OUTPUT(ParentOut);//,,'~CLASS::BMF::OUT::PeopleReExpanded',OVERWRITE);
OUTPUT(ReNormedVRecs);//,,'~CLASS::BMF::OUT::VehicleReExpanded',OVERWRITE);
OUTPUT(ReNormedPRecs);//,,'~CLASS::BMF::OUT::PropertyReExpanded',OVERWRITE);
OUTPUT(ReNormedTRecs);//,,'~CLASS::BMF::OUT::TaxdataReExpanded',OVERWRITE);
// OUTPUT($.File_PeopleAll.Vehicle,,'~CLASS::BMF::OUT::VehicleReExpanded',OVERWRITE);
// OUTPUT($.File_PeopleAll.Taxdata,,'~CLASS::BMF::OUT::TaxdataReExpanded',OVERWRITE);
