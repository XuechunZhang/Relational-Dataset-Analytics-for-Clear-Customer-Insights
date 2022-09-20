IMPORT $;
// Calculate the number of Ford Vehicles purchased within 90 days of purchasing a Chevrolet Vehicle. 
// If no Vehicles exist , output a –9 value.
IsWithinDays(STRING8 ldate,STRING8 rdate,INTEGER days) := ABS($.Z2JD(ldate)-$.Z2JD(rdate)) <= days;
Chev := 'Chevrolet';
Ford := 'Ford';
CFVehicles  := $.File_PeopleAll.Vehicle(make_description IN [Chev,Ford]);
DedupedCars := DEDUP(CFVehicles,LEFT.Make_description = Chev AND
                                RIGHT.Make_description = Ford AND
                                IsWithinDays(LEFT.Purch_date,RIGHT.Purch_date,90),
                     ALL);
EXPORT FordChevWithin90 := IF(~EXISTS(CFVehicles),
                              -9,
                              COUNT(CFVehicles) - COUNT(DedupedCars));
