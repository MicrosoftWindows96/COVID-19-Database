SELECT
    CountryInfo.countriesAndTerritories,
    (SUM(CaseInfo.cases) * 100.0 / CountryInfo.popData2020) AS cases_percentage,
    (SUM(CaseInfo.deaths) * 100.0 / CountryInfo.popData2020) AS deaths_percentage
FROM CaseInfo
INNER JOIN CountryInfo ON CountryInfo.intCountry = CaseInfo.intCountry
GROUP BY CountryInfo.countriesAndTerritories, CountryInfo.popData2020
ORDER BY CountryInfo.countriesAndTerritories;