SELECT
    CountryInfo.countriesAndTerritories,
    CalendarInfo.dateRep,
    CaseInfo.cases,
    CaseInfo.deaths
FROM CaseInfo
INNER JOIN CalendarInfo ON CalendarInfo.intDate = CaseInfo.intDate
INNER JOIN CountryInfo ON CountryInfo.intCountry = CaseInfo.intCountry
ORDER BY CaseInfo.intCountry ASC, CaseInfo.intDate ASC;
