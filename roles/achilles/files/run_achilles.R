#!/usr/bin/env Rscript

# TODO make template w/ parameter for schema, db etc
library(Achilles)
connectionDetails <- createConnectionDetails(dbms = "postgresql",
                                             server = "127.0.0.1/ohdsi",
                                             user = "ohdsi_admin_user",
                                             password = "admin1",
                                             schema = "synpuf1k")
achillesResults<-achilles(connectionDetails,
                          cdmDatabaseSchema="synpuf1k",
                          resultsDatabaseSchema="webapi",
                          sourceName="SYNPUF 1k",
                          cdmVersion="5",
                          vocabDatabaseSchema="synpuf1k")