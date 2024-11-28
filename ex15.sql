SELECT
    CalendarInfo.dateRep,
    CaseInfo.cases
FROM CaseInfo
INNER JOIN CalendarInfo ON CalendarInfo.intDate = CaseInfo.intDate
INNER JOIN CountryInfo ON CountryInfo.intCountry = CaseInfo.intCountry
WHERE CountryInfo.geoId = 'UK'
ORDER BY year, month, day;