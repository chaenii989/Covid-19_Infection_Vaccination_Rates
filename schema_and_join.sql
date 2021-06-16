-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Death_Infections" (
    "Fips" INT   NOT NULL,
    "Deaths" INT   NOT NULL,
    "Infection_Rate" decimal(7,6)
     
);

CREATE TABLE "Test_Case_Ratios" (
    "Fips" INT   NOT NULL,
    "Test_Positive_Ratio" decimal,
    "Case_Density" decimal   NOT NULL
);


CREATE TABLE "April_2020_2021" (
    "County" VARCHAR   NOT NULL,
    "Cases" INT   NOT NULL,
    "Month_Year" VARCHAR   NOT NULL
);

CREATE TABLE "vaccination" (
    "state" VARCHAR   NOT NULL,
    "fips" INT   NOT NULL,
    "county" VARCHAR   NOT NULL,
    "population" INT   NOT NULL,
    "total_current_cases" INT   NOT NULL,
    "vaccination_completed" INT   NOT NULL,
    "vaccination_initiated" INT   NOT NULL,
    "vaccination_administered" INT   NOT NULL,
    "completion" decimal(5,2)   NOT NULL,
    CONSTRAINT "pk_vaccination" PRIMARY KEY (
        "fips"
     )
);

SELECT "County" FROM vaccination;


SELECT va."County", va."Total_Current_Cases", ap."Cases"
FROM vaccination as va 
JOIN april_2020_2021 as ap
ON (ap."County" = va."County");
