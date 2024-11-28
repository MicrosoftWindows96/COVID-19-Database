-- Populate the DateInfo table
INSERT OR IGNORE INTO CalendarInfo (dateRep, day, month, year)
SELECT
    filteredDataset.dateRep,
    filteredDataset.day,
    filteredDataset.month,
    filteredDataset.year
FROM (
    SELECT * FROM dataset
    WHERE cases IS NOT NULL AND deaths IS NOT NULL AND cases >= 0 AND deaths >= 0
) AS filteredDataset;

-- Populate the Country table
INSERT OR IGNORE INTO CountryInfo (countriesAndTerritories, geoId, countryterritoryCode, popData2020, continentExp)
SELECT
    filteredDataset.countriesAndTerritories,
    filteredDataset.geoId,
    filteredDataset.countryterritoryCode,
    filteredDataset.popData2020,
    filteredDataset.continentExp
FROM (
    SELECT * FROM dataset
    WHERE cases IS NOT NULL AND deaths IS NOT NULL AND cases >= 0 AND deaths >= 0
) AS filteredDataset;

-- Populate the CaseInfo table
INSERT INTO CaseInfo (intDate, intCountry, cases, deaths)
SELECT
    CalendarInfo.intDate AS intDate,
    CountryInfo.intCountry AS intCountry,
    filteredDataset.cases,
    filteredDataset.deaths
FROM (
    SELECT * FROM dataset
    WHERE cases IS NOT NULL AND deaths IS NOT NULL AND cases >= 0 AND deaths >= 0
) AS filteredDataset
INNER JOIN CalendarInfo ON CalendarInfo.dateRep = filteredDataset.dateRep
INNER JOIN CountryInfo ON CountryInfo.countriesAndTerritories = filteredDataset.countriesAndTerritories;
