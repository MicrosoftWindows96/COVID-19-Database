SELECT
    CountryInfo.countriesAndTerritories,
    (SUM(CaseInfo.deaths) * 100.0 / SUM(CaseInfo.cases)) AS death_rate
FROM CaseInfo
INNER JOIN CountryInfo ON CountryInfo.intCountry = CaseInfo.intCountry
GROUP BY CountryInfo.countriesAndTerritories
ORDER BY death_rate DESC
LIMIT 10;