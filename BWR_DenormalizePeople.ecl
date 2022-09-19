IMPORT $;
Layout_PeopleVehicles := RECORD
  $.File_People.Layout;
  UNSIGNED1 ChildVCount;
  DATASET($.File_Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
 END;

Layout_PropTax := RECORD
  $.File_Property.Layout;
  UNSIGNED1 ChildTaxCount;
  DATASET($.File_Taxdata.Layout) TaxRecs{MAXCOUNT(20)};
END;

Layout_PeopleAll := RECORD
  $.File_People.Layout; 
  UNSIGNED1 ChildVcount;
  UNSIGNED1 ChildPcount;
  DATASET($.File_Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
  DATASET(Layout_PropTax) PropRecs{MAXCOUNT(20)};
 END;
 
Layout_PeopleVehicles ParentMove2($.File_People.Layout Le) := TRANSFORM
  SELF.ChildVCount := 0;
  SELF.VehicleRecs := [];
  SELF := Le;
 END;
PVOnly := PROJECT($.File_People.File, ParentMove2(LEFT));
Layout_PeopleVehicles ChildMove2(Layout_PeopleVehicles Le,
                                 $.File_Vehicle.Layout Ri,
                                 UNSIGNED1 Cnt):= TRANSFORM
  SELF.ChildVCount := Cnt;
  SELF.VehicleRecs := Le.VehicleRecs + Ri;
  SELF := Le;
END;
PVDenorm := DENORMALIZE(PVOnly, 
                        $.File_Vehicle.File,
                        LEFT.id = RIGHT.personid,
                        ChildMove2(LEFT,RIGHT,COUNTER))
                        :PERSIST('~CLASS::BMF::PERSIST::PeopleVehicles');
PV_DNOut := OUTPUT(PVDenorm);                        


 Layout_PropTax ParentMove($.File_Property.Layout Le) := TRANSFORM
  SELF.ChildTaxCount := 0;
  SELF.TaxRecs    := [];
  SELF := Le;
 END;
 PropTaxOnly := PROJECT($.File_Property.File, ParentMove(LEFT));
 Layout_PropTax ChildMove(Layout_PropTax Le, $.File_Taxdata.Layout Ri, INTEGER Cnt):=TRANSFORM
  SELF.ChildTaxCount := Cnt;
  SELF.TaxRecs       := Le.TaxRecs + Ri;
  SELF := Le;
 END;
 DenormProp := DENORMALIZE(PropTaxOnly,
                            $.File_TaxData.File,
                            LEFT.propertyid = RIGHT.propertyid,
                            ChildMove(LEFT,RIGHT,COUNTER))
                            :PERSIST('~CLASS::BMF::PERSIST::PropTax');
PT_DNOut := OUTPUT(DenormProp);

Layout_PeopleAll ParentMove3($.DenormPeopleVehicles.Layout_PeopleVehicles Le) := TRANSFORM
  SELF.ChildPcount := 0;
  SELF.PropRecs    := [];
  SELF := Le;
 END;
 ParentOnly := PROJECT($.DenormPeopleVehicles.File, ParentMove3(LEFT));
 Layout_PeopleAll ChildMove3(Layout_PeopleAll Le, 
                            $.DenormProp.Layout_Proptax Ri, 
                            INTEGER Cnt):=TRANSFORM
  SELF.ChildPcount := Cnt;
  SELF.PropRecs    := Le.PropRecs + Ri;
  SELF := Le;
 END;
 DeNorm_PeopleAll := DENORMALIZE(ParentOnly, 
                                 DenormProp,
                                 LEFT.id = RIGHT.personid,
                                 ChildMove3(LEFT,RIGHT,COUNTER));

OUTPUT(Denorm_PeopleAll,,'~CLASS::BMF::OUT::PeopleAll',OVERWRITE);                            
