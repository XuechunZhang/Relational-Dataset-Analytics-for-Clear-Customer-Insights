IMPORT $;
People := $.File_PeopleAll.People;
OUTPUT(COUNT(People($.PropTaxBeds3 > 0)),NAMED('One_265988'));
OUTPUT(COUNT(People($.PropBath_3 > 0)),NAMED('Two_215947'));
OUTPUT(COUNT(People($.PropVehSumEx > 0)),NAMED('Three_82894'));
OUTPUT(COUNT(People($.PropValSmallStreet > 0)),NAMED('Four_205710'));
OUTPUT(COUNT(People($.PropTaxBedYearRange > 0)),NAMED('Five_208175'));
OUTPUT(COUNT(People($.PropTaxDataHomeAssess <> '')),NAMED('Six_256290'));

OUTPUT(COUNT(People($.VehicleNewTruckPrice <> '')),NAMED('Seven_64139'));
OUTPUT(COUNT(People($.CountUniqueMakeVehicles > 0)),NAMED('Eight_278981'));
OUTPUT(COUNT(People($.FordChevWithin90 > 0)),NAMED('Nine1_5481'));






























// OUTPUT(COUNT(People($.VitoSmallStreetEx > 0)),NAMED('FourA_205710'));





