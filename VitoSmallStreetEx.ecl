IMPORT $;
Property  := $.File_PeopleAll.Property;

SetSmallStreets := ['CT','LN','WAY','CIR', 'PL', 'TRL'];

IsSmallStreet := Property.StreetType IN SetSmallStreets;

PropVal       := MAP($.IsValidAmount(Property.Total_Value) AND (Property.Total_Value > Property.Assessed_Value)  => Property.Total_Value,
                     $.IsValidAmount(Property.Assessed_Value) AND NOT $.IsValidAmount(Property.Total_Value)      => Property.Assessed_Value,
                     // $.IsValidAmount(Property.Total_Value)           => Property.Total_Value,
                     // $.IsValidAmount(Property.Assessed_Value)        => Property.Assessed_Value,
                     -9);

// PropVal       := IF($.IsValidAmount(Property.Total_Value) AND $.IsValidAmount(Property.Assessed_Value), 
                    // IF(Property.Total_Value > Property.Assessed_Value,Property.Total_Value,Property.Assessed_Value),
                    // IF($.IsValidAmount(Property.Total_Value), Property.Total_Value, Property.Assessed_Value));

SmallStreetProp := Property(IsSmallStreet, $.IsValidAmount(PropVal));
// SmallStreetProp := Property(IsSmallStreet, PropVal <> -9);



EXPORT VitoSmallStreetEx := IF(EXISTS(SmallStreetProp),SUM(SmallStreetProp,PropVal), -9);







