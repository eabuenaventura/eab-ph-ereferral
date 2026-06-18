// =============================================================================
// PH eReferral Receiving Facility Bundle
// Story 2: RSTMH receives Ana Reyes, creates onward referral to WVMC
//
// Receiving physician Dr. Carlos Lim at RSTMH determines Ana needs
// nephrology and cardiology specialists available only at WVMC.
// This demonstrates the onward referral (REF-18 referred/forwarded) pattern.
//
// References instances from ERefInitiatingFacilityBundle.fsh:
//   - ExampleERefPatient, ExampleERefConditionChestPain, ExampleERefOrganizationRSTMH
// =============================================================================

// --- PRACTITIONER — Dr. Carlos Lim (receiving physician at RSTMH) -------------
Instance: ExampleERefPractitionerLim
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Receiving Practitioner — Dr. Carlos Lim"
Description: "Dr. Carlos Lim, duty physician at Dr. Rafael S. Tumbokon Memorial Hospital."

* name.use = #official
* name.family = "Lim"
* name.given[0] = "Carlos"
* name.prefix = "Dr."


// --- PRACTITIONERROLE — Dr. Lim at RSTMH --------------------------------------
Instance: ExampleERefPractitionerRoleRSTMH
InstanceOf: ERefPractitionerRole
Usage: #example
Title: "Example PractitionerRole — Dr. Lim at RSTMH"
Description: "Links Dr. Carlos Lim to RSTMH as duty physician."

* practitioner = Reference(ExampleERefPractitionerLim)
* organization = Reference(ExampleERefOrganizationRSTMH)
* code = $sct#158965000 "Medical practitioner"


// --- ORGANIZATION — Western Visayas Medical Center (onward receiving) ---------
Instance: ExampleERefOrganizationWVMC
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Onward Receiving Facility — Western Visayas Medical Center"
Description: "Western Visayas Medical Center (WVMC), the tertiary hospital receiving the onward referral."

* name = "Western Visayas Medical Center"
* identifier[0].system = "https://nhfr.doh.gov.ph/facility"
* identifier[0].value = "06-WVMC-0001"
* identifier[+].system = "https://fhir.doh.gov.ph/pheref/Identifier/hcpn"
* identifier[=].value = "HCPN-WV-001"
* address.use = #work
* address.line = "Q. Abeto Street, Mandurriao"
* address.postalCode = "5000"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#0600000000 "Region VI (Western Visayas)"
* address.extension[province].valueCoding = $PSGC#0603000000 "Iloilo"
* address.extension[cityMunicipality].valueCoding = $PSGC#0631000000 "City of Iloilo"
* address.extension[barangay].valueCoding = $PSGC#0631000001 "Santa Cruz"


// --- PRACTITIONERROLE — Receiving Facility at WVMC -----------------------------
Instance: ExampleERefPractitionerRoleWVMC
InstanceOf: ERefPractitionerRole
Usage: #example
Title: "Example PractitionerRole — Receiving Facility at WVMC"
Description: "PractitionerRole representing the onward receiving facility at WVMC for Task.owner linkage."

* organization = Reference(ExampleERefOrganizationWVMC)
* code = $sct#158965000 "Medical practitioner"


// --- SERVICE REQUEST — Onward (RSTMH → WVMC) -----------------------------------
// --- REF-18: replaces chain ----------------------------------------------------
Instance: ExampleERefServiceRequestOnward
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example Onward eReferral — Ana Reyes to WVMC"
Description: "Onward referral from RSTMH to Western Visayas Medical Center for nephrology and cardiology specialist evaluation."

* status = #active
* intent = #order
* priority = #urgent
* category = $sct#3457005 "Patient referral"

// REF-18: replaces prior referral
* replaces = Reference(ExampleERefServiceRequest)

* authoredOn = "2026-06-18T12:45:00+08:00"
* requester = Reference(ExampleERefPractitionerRoleRSTMH)
* performer = Reference(ExampleERefOrganizationWVMC)
* reasonCode = $sct#398254007 "Pre-eclampsia"
  * text = "Severe pre-eclampsia with severe-range hypertension, early end-organ damage (renal: creatinine 2.1 mg/dL). Requires nephrology and cardiology specialist evaluation."
* reasonReference = Reference(ExampleERefConditionChestPain)
* subject = Reference(ExampleERefPatient)
* note.text = "After 4 hours of IV Nicardipine and Magnesium Sulfate at RSTMH, BP improved to 160/98 mmHg. Lab results show creatinine 2.1 mg/dL, proteinuria 3+. Patient needs nephrology and cardiology care available only at WVMC."
* occurrenceDateTime = "2026-06-18T12:45:00+08:00"
* requisition.system = "urn:oid:1.2.840.113619.21.1.2"
* requisition.value = "REF-2026-001235"


// --- TASK — Onward (REF-18: Referred/Forwarded) ---------------------------------
Instance: ExampleERefTaskOnward
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task — Referred Onward"
Description: "Task representing the onward referral in 'rejected' status with 'referred-onward' business status."

// REF-18: Action Point — rejected (referred onward)
* status = #rejected
* intent = #order

* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for severe pre-eclampsia management — onward to WVMC"

* focus = Reference(ExampleERefServiceRequestOnward)
* for = Reference(ExampleERefPatient)
* requester = Reference(ExampleERefPractitionerRoleRSTMH)
* owner = Reference(ExampleERefPractitionerRoleWVMC)

// REF-18: businessStatus captures the referred-onward response
* businessStatus = EReferralWorkflowCS#referred-onward "Referred onward"
* statusReason.text = "RSTMH capacity full for nephrology/cardiology. Case redirected to WVMC."

* authoredOn = "2026-06-18T12:45:00+08:00"
* lastModified = "2026-06-18T12:45:00+08:00"
* note.text = "RSTMH created onward referral to WVMC for nephrology and cardiology specialist evaluation."


// =============================================================================
// SUBMISSION BUNDLE: Receiving Facility (RSTMH → WVMC)
// =============================================================================
Instance: ExampleERefReceivingFacilityBundle
InstanceOf: Bundle
Usage: #example
Title: "Example Submission Bundle — Receiving Facility Onward Referral"
Description: "Transaction bundle for the onward referral from Dr. Rafael S. Tumbokon Memorial Hospital to Western Visayas Medical Center."
* type = #transaction
* timestamp = "2026-06-18T12:45:00+08:00"

// Practitioner — Dr. Lim
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Practitioner/ExampleERefPractitionerLim"
* entry[=].resource = ExampleERefPractitionerLim
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// PractitionerRole — Dr. Lim at RSTMH
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/PractitionerRole/ExampleERefPractitionerRoleRSTMH"
* entry[=].resource = ExampleERefPractitionerRoleRSTMH
* entry[=].request.method = #POST
* entry[=].request.url = "PractitionerRole"

// Organization — WVMC
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Organization/ExampleERefOrganizationWVMC"
* entry[=].resource = ExampleERefOrganizationWVMC
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// PractitionerRole — Receiving at WVMC
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/PractitionerRole/ExampleERefPractitionerRoleWVMC"
* entry[=].resource = ExampleERefPractitionerRoleWVMC
* entry[=].request.method = #POST
* entry[=].request.url = "PractitionerRole"

// ServiceRequest — Onward
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/ServiceRequest/ExampleERefServiceRequestOnward"
* entry[=].resource = ExampleERefServiceRequestOnward
* entry[=].request.method = #POST
* entry[=].request.url = "ServiceRequest"

// Task — Onward
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Task/ExampleERefTaskOnward"
* entry[=].resource = ExampleERefTaskOnward
* entry[=].request.method = #POST
* entry[=].request.url = "Task"
