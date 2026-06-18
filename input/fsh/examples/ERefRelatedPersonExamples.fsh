Instance: ExampleERefRelatedPersonNextOfKin
InstanceOf: ERefRelatedPerson
Usage: #example
Title: "Example ERefRelatedPerson - Next of Kin"
Description: "Example next-of-kin RelatedPerson for an eReferral patient."
* active = true
* patient = Reference(ExampleERefPatient)
* relationship[0] = $v3-roleCode#NOK "next of kin"
* relationship[+] = $v3-roleCode#FTH "father"
* name.use = #official
* name.family = "Dela Cruz"
* name.given[0] = "Roberto"
* telecom[0].system = #phone
* telecom[0].value = "+639189876543"
* telecom[0].use = #mobile
* address.use = #home
* address.line[0] = "456 Mabini Street"
* address.city = "Quezon City"
* address.state = "Metro Manila"
* address.postalCode = "1100"
* address.country = "PH"
* gender = #male
* birthDate = "1958-04-12"
* period.start = "2025-03-15"

Instance: ExampleERefRelatedPersonAccompanying
InstanceOf: ERefRelatedPerson
Usage: #example
Title: "Example ERefRelatedPerson - Accompanying Person"
Description: "Example accompanying person for an eReferral patient."
* active = true
* patient = Reference(ExampleERefPatient)
* relationship[0] = $v3-roleCode#ECON "emergency contact"
* relationship[+] = $v3-roleCode#SPS "spouse"
* name.use = #official
* name.family = "Dela Cruz"
* name.given[0] = "Maria"
* telecom[0].system = #phone
* telecom[0].value = "+639171112222"
* telecom[0].use = #mobile
* gender = #female
* period.start = "2025-03-15"
