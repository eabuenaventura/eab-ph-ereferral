Instance: ExampleERefReceivingHospital
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Receiving Hospital"
Description: "Example tertiary hospital receiving facility"
* identifier[0].system = "https://nhfr.doh.gov.ph/facility"
* identifier[0].value = "HOSP-QC-001"
* identifier[+].system = "https://fhir.doh.gov.ph/pheref/Identifier/hcpn"
* identifier[=].value = "HCPN-NCR-001"
* active = true
* type = $organization-type#prov "Healthcare Provider"
* name = "Philippine Heart Center"
* address.use = #work
* address.line = "East Avenue"
* address.postalCode = "1100"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#1300000000 "National Capital Region (NCR)"
* address.extension[cityMunicipality].valueCoding = $PSGC#1381300000 "Quezon City"
* address.extension[barangay].valueCoding = $PSGC#1380100001 "Barangay 1"
