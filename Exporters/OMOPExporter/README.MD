<!-----
NEW: Your output is on the clipboard!

NEW: Check the "Supress top comment" to remove this info from the output.

Conversion time: 0.423 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0?23
* Tue May 12 2020 10:08:49 GMT-0700 (PDT)
* Source doc: Untitled document
----->


**OMOP Data Exporter**

The OMOP Data Exporer is a `R` library designed to build the N3C phenotype and assemble extract files from your OMOP CDM. This R package uses [SQLRender](https://cran.r-project.org/web/packages/SqlRender/index.html) to translate between suppoted RDBMS including: 'Microsoft Sql Server', 'Oracle', 'PostgreSql', 'Amazon RedShift', 'Apache Impala', 'IBM Netezza', 'Google BigQuery', 'Microsoft PDW', and 'SQLite'.


**System Prerequisites**

- A database in [Common Data Model version 5](https://github.com/OHDSI/CommonDataModel) in one of these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache Impala, Amazon RedShift, Google BigQuery or Microsoft APS.
- Incorporation of [OMOP Vocabulary release v20200331,v20200403, v20200428, v20200430, v20200512, v20200519](https://github.com/OHDSI/Vocabulary-v5.0/releases) in your local ETL. It is also suggested to follow [OHDSI Community Guidance for Mapping](https://github.com/OHDSI/Covid-19/wiki/Release)
- R version 3.5.0 or newer
- On Windows: [RTools](http://cran.r-project.org/bin/windows/Rtools/)
- [Java](http://java.com)
- Suggested: 25 GB of free disk space

**Running the Exporter**

To utilize the Exporter, in `R` use the following code to install the dependencies:
```r
	install.packages("devtools")
	library(devtools)
	install_github("ohdsi/DatabaseConnector", ref = "v2.4.1")
	install_github("ohdsi/OhdsiSharing", ref = "v0.1.3")
	install.packages("SqlRender", ref = "v1.6.6")
	
	library("devtools")
	install_github("National-COVID-Cohort-Collaborative/Phenotype_Data_Acquisition/Exporters/OMOPExporter")

	library(DatabaseConnector)
	library(SqlRender)
	library(OhdsiSharing)
	library(N3cOhdsi)

	connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "redshift",  # options: oracle, postgressql, redshift, sql server, pdw, netezza, bigquery, sqlite
                                                          server = "", # name of the server
                                                          user="", # username to access server
                                                          password = "" #password for that user)
	cdmDatabaseSchema <- "" # schema for your CDM instance -- e.g. full_201911_omop_v5
	resultsDatabaseSchema <- "study_reference" # schema with write privileges
	vocabularyDatabaseSchema <- "" #schema where your Vocabulary tables are stored
	targetCohortTable <- "n3c_cohort" #name of your cohortTable
	outputFolder <-  paste0(getwd(), "/output/")

	N3cOhdsi::createCohort(connectionDetails = connectionDetails,
                        cdmDatabaseSchema = cdmDatabaseSchema,
                        resultsDatabaseSchema = resultsDatabaseSchema,
                        vocabularyDatabaseSchema = cdmDatabaseSchema,
                        targetCohortTable = targetCohortTable
                        )

	# Extract data to pipe delimited files
	N3cOhdsi::runExtraction(connectionDetails = connectionDetails,
                        cdmDatabaseSchema = cdmDatabaseSchema,
                        resultsDatabaseSchema = resultsDatabaseSchema,
                        outputFolder = outputFolder
                        )


	# Compress into single file
	OhdsiSharing::compressFolder(outputFolder, paste0("YourInstitution_OMOP_SiteNumber_", Sys.Date(),".zip") )

```

Note: if you cannot call out to the internet from R, you may download the [TAR here](https://github.com/National-COVID-Cohort-Collaborative/Phenotype_Data_Acquisition/archive/master.zip). 

When you download this, you'll need to `Upload` the package into your RStudio environment (if in the cloud) or simply find the file pathway (if local RStudio). Once uploaded, you will need to open the `N3cOhdsi.Rprog` and the `Build` tab will show up in the upper right windows (next to Environment, History, Connections, Build). Proceed to `Install and Restart` to build the `N3cOhdsi` library. You may access the file `example_execution.R` to retrieve the code referenced above.


**Bug Reports/Enhancement Requests/Contributions**

We would love to hear from you about this script, as we hope to continue to improve and enhance it. We also welcome contributions, if there's a cool feature you've added locally. Please feel free to open an issue or create a pull request as needed!