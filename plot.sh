#!/bin/bash

# Set the database file
DATABASE="coronavirus.db"

# Create a temporary file to store the data for plotting
DATAFILE=$(mktemp)

# Extract the top 10 countries and their cumulative deaths by date from the SQLite database
sqlite3 -separator " " $DATABASE <<EOF
.mode csv
.output $DATAFILE
WITH TopCountries AS (
    SELECT intCountry, SUM(deaths) AS total_deaths
    FROM CaseInfo
    GROUP BY intCountry
    ORDER BY total_deaths DESC
    LIMIT 10
)
, CumulativeDeaths AS (
    SELECT
        CalendarInfo.dateRep,
        CountryInfo.countriesAndTerritories,
        SUM(CaseInfo.deaths) OVER (
            PARTITION BY CaseInfo.intCountry
            ORDER BY CalendarInfo.dateRep
        ) AS cumulative_deaths
    FROM CaseInfo
    INNER JOIN CalendarInfo ON CaseInfo.intDate = CalendarInfo.intDate
    INNER JOIN CountryInfo ON CaseInfo.intCountry = CountryInfo.intCountry
    WHERE CaseInfo.intCountry IN (SELECT intCountry FROM TopCountries)
)
SELECT dateRep || " " || countriesAndTerritories || " " || cumulative_deaths FROM CumulativeDeaths;
EOF

# Create a Gnuplot script to generate the graph
GNUPLOT_SCRIPT=$(mktemp)
cat > $GNUPLOT_SCRIPT <<EOF
set terminal pngcairo size 1280,720 enhanced font "Helvetica,12"
set output 'graph.png'
set title "Cumulative Deaths by Country (Top 10 Countries)"
set xlabel "Date"
set ylabel "Cumulative Deaths"
set grid
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m"
set key outside
plot for [col=2:11] '$DATAFILE' using 1:col with lines title columnheader(col)
EOF

# Execute the Gnuplot script to generate the graph
gnuplot $GNUPLOT_SCRIPT

# Clean up temporary files
rm $DATAFILE
rm $GNUPLOT_SCRIPT
