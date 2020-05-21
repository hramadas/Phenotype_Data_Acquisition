
--CONDITION_ERA
--OUTPUT_FILE: CONDITION_ERA.csv
SELECT
   CONDITION_ERA_ID,
   n.PERSON_ID,
   CONDITION_CONCEPT_ID,
   CONVERT(VARCHAR(20),CONDITION_ERA_START_DATE, 120) as CONDITION_ERA_START_DATE,
   CONVERT(VARCHAR(20),CONDITION_ERA_END_DATE, 120) as CONDITION_ERA_END_DATE,
   CONDITION_OCCURRENCE_COUNT
FROM @cdmDatabaseSchema.CONDITION_ERA ce JOIN @cohortDatabaseSchema.N3C_COHORT n ON CE.PERSON_ID = N.PERSON_ID
WHERE CONDITION_ERA_START_DATE >= '1/1/2018';