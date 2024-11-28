WITH UK_Data AS (
    SELECT
        CalendarInfo.dateRep,
        CaseInfo.deaths,
        CaseInfo.cases
    FROM CaseInfo
    INNER JOIN CountryInfo ON CaseInfo.intCountry = CountryInfo.intCountry
    INNER JOIN CalendarInfo ON CaseInfo.intDate = CalendarInfo.intDate
    WHERE CountryInfo.geoId = 'UK'
)
SELECT
    dateRep,
    SUM(deaths) OVER (ORDER BY dateRep) AS cumulative_deaths,
    SUM(cases) OVER (ORDER BY dateRep) AS cumulative_cases
FROM UK_Data;
