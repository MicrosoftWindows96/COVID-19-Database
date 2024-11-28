CREATE TABLE IF NOT EXISTS CountryInfo (
    intCountry INTEGER PRIMARY KEY,
    countriesAndTerritories TEXT NOT NULL UNIQUE,
    geoId TEXT UNIQUE,
    countryterritoryCode TEXT UNIQUE,
    popData2020 INTEGER NOT NULL,
    continentExp TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS CalendarInfo (
    intDate INTEGER PRIMARY KEY,
    dateRep TEXT NOT NULL UNIQUE,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS CaseInfo (
    intDate INTEGER,
    intCountry INTEGER,
    cases INTEGER,
    deaths INTEGER,
    PRIMARY KEY (intDate, intCountry),
    FOREIGN KEY (intDate) REFERENCES CalendarInfo(intDate)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (intCountry) REFERENCES CountryInfo(intCountry)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);
