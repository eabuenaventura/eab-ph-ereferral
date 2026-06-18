// =============================================================================
// PH eReferral Initiating Facility Bundle — Ana Reyes Referral Journey
// Self-contained pattern (all instances inline, Bundle embeds full resources)
//
// Kalibo Health Center → Dr. Rafael S. Tumbokon Memorial Hospital
//
// TDG references per [CLEAN 20260605] Synchronous TDG FHIR Mapping.
// Elements: FHIR-required + TDG Required=Yes + TDG Linked By + profile ObligationRequired.
// =============================================================================

// =============================================================================
// STORY 1 — INSTANCES
// =============================================================================

/**
 * ============================================================================================
 * PATIENT PROFILE & CLINICAL ASSESSMENT: ANA LUISA REYES
 * 
 * SYSTEM EVENT: Patient registration & clinical intake completed at Kalibo Health Center (KHC).
 * PHIE STATUS: Successfully generated new Patient resource ID in the Philippine Health Information Exchange.
 * ============================================================================================
 * 
 * 1. PATIENT DEMOGRAPHICS & IDENTIFIERS
 * --------------------------------------------------------------------------------------------
 * Name:            Ana Luisa Reyes
 * Age / Gender:    38 years old / Female (DOB: 12 March 1988)
 * Address:         Area 4, Brgy. Mabuhay, Kalibo, Aklan
 * Contact:         +63-919-876-5432
 * Companion:       Roberto Reyes (Husband)
 * PhilHealth ID:   78-658064775-3
 * PhilSys ID:      7731-0812-4491-0326
 * 
 * 2. CLINICAL ASSESSMENT & VITALS
 * --------------------------------------------------------------------------------------------
 * Chief Complaint:  Severe headache, dizziness, blurring of vision, chest tightness, 
 *                   and epigastric pain persisting for two (2) days.
 * 
 * Pregnancy Status: Pregnant, 32 weeks AOG (G2P1)
 * Obstetric Dates:  LMP: Nov 13, 2025 | EDD: Aug 20, 2026
 * 
 * Objective Vitals:
 *   - Blood Pressure: 180/110 mmHg (Severe Hypertension)
 *   - Heart Rate:     112 bpm
 *   - Resp Rate:      24/min
 *   - SpO2:           96%
 *   - Temperature:    36.8°C
 *   - Weight:         72 kg
 * 
 * Laboratory:
 *   - Urinalysis:     Proteinuria 3+
 * 
 * Working Impression: G2P1(1001), Pregnancy Uterine, 32 weeks AOG, 
 *                    High-risk pregnancy: Severe Pre-eclampsia
 * 
 * 3. INITIAL MEDICATION LOG
 * --------------------------------------------------------------------------------------------
 * - Methyldopa 250mg BID
 * - Folic Acid 5mg OD
 * - FeSO4 300mg OD
 * - CaCO3 500mg TID
 * 
 * 4. PHeRef ELECTRONIC REFERRAL SYSTEM TRANSACTION
 * --------------------------------------------------------------------------------------------
 * Transaction Status: Confirmed & Transmitted (Electronic notification dispatched via EMR1)
 * Referral Category:  Emergency
 * Urgency Level:      Urgent (Required within 2 hours)
 * Reason Category:    Treatment/Procedure
 * Clinical Narrative: Severe Pre-eclampsia — requires IV antihypertensive, 
 *                     seizure prophylaxis, and continuous maternal-fetal monitoring.
 * 
 * Routing Node Details:
 *   - Origin (Referring): Kalibo Health Center 
 *                         (NHFR: 042-CHC-0087 | Tel: (043) 756-2233)
 *   - Provider:           Dr. Maria Villanueva, Primary Care Physician
 *   - Destination (To):   Dr. Rafael S. Tumbokon Memorial Hospital 
 *                         (NHFR: 042-DH-0012)
 */

// --- PATIENT — REF-21 (name), REF-22 (gender), REF-23 (birthDate) -----------
// ---            REF-27 (address), REF-29 (contact/Next of Kin) --------------
Instance: ExampleERefPatient
InstanceOf: ERefPatient
Usage: #example
Title: "Example eReferral Patient — Ana Reyes"
Description: "Ana Luisa Reyes, 38-year-old female, G2P1, 32 weeks AOG, from Barangay Mabuhay, Kalibo, Aklan. Referred for severe pre-eclampsia management."

// Name (REF-21, Required=Yes)
* name.use = #official
* name.family = "Reyes"
* name.given[0] = "Ana"
* name.given[+] = "Luisa"

// Gender (REF-22, Required=Yes)
* gender = #female

// Birth date (REF-23, Required=Yes)
* birthDate = "1988-03-12"

* active = true

// PhilHealth ID (REF-26)
* identifier[PHCorePhilHealthID].system = $PhilHealthID
* identifier[PHCorePhilHealthID].value = "78-658064775-3"

// PhilSys ID (REF-25)
* identifier[PHCorePhilSysID].system = $PhilSysID
* identifier[PHCorePhilSysID].value = "7731-0812-4491-0326"

// Contact Number (REF-28)
* telecom.system = #phone
* telecom.value = "+63-919-876-5432"
* telecom.use = #mobile

// Address (REF-27, Required=Yes)
* address.use = #home
* address.line[0] = "Area 4, Barangay Mabuhay"
* address.postalCode = "5600"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#0600000000 "Region VI (Western Visayas)"
* address.extension[province].valueCoding = $PSGC#0600400000 "Aklan"
* address.extension[cityMunicipality].valueCoding = $PSGC#0600407000 "Kalibo"
* address.extension[barangay].valueCoding = $PSGC#0600407013 "Poblacion"

// Next of Kin — Husband (REF-29, profile requires contact.relationship + contact.name)
* contact.relationship[0] = http://terminology.hl7.org/CodeSystem/v3-RoleCode#HUSB "Husband"
* contact.name.use = #official
* contact.name.family = "Reyes"
* contact.name.given[0] = "Roberto"


// --- ENCOUNTER — Bridge for Condition, Observation, Procedure linkage ----------
Instance: ExampleERefSubmissionEncounter
InstanceOf: ERefEncounter
Usage: #example
Title: "Example eReferral Encounter — Ana Reyes PCF Visit"
Description: "Ambulatory encounter at Kalibo Health Center where Ana Reyes was assessed and referred."

* status = #finished
* class = $v3-ActCode#AMB "ambulatory"
* subject = Reference(ExampleERefPatient)


// --- PRACTITIONER — REF-1 Name of Referring Practitioner (Required=Yes) ------
Instance: ExampleERefPractitionerSubmission
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Referring Practitioner — Dr. Maria Villanueva"
Description: "Dr. Maria Villanueva, primary care physician at Kalibo Health Center."

* name.use = #official
* name.family = "Villanueva"
* name.given[0] = "Maria"
* name.prefix = "Dr."


// --- ORGANIZATION (Referring) — REF-5 Name (Yes), REF-6 NHFR (Yes) -----------
Instance: ExampleERefOrganizationKaliboHC
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Referring Facility — Kalibo Health Center"
Description: "Kalibo Health Center, the initiating/referring facility for Ana Reyes."

* name = "Kalibo Health Center"
* identifier[0].system = "https://nhfr.doh.gov.ph/facility"
* identifier[0].value = "042-CHC-0087"
* identifier[+].system = "https://fhir.doh.gov.ph/pheref/Identifier/hcpn"
* identifier[=].value = "HCPN-WV-001"

// REF-8: Initiating Facility Contact Number
* telecom.system = #phone
* telecom.value = "(043) 756-2233"
* telecom.use = #work

* address.use = #work
* address.line = "Mabini Street"
* address.postalCode = "5600"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#0600000000 "Region VI (Western Visayas)"
* address.extension[province].valueCoding = $PSGC#0600400000 "Aklan"
* address.extension[cityMunicipality].valueCoding = $PSGC#0600407000 "Kalibo"
* address.extension[barangay].valueCoding = $PSGC#0600407013 "Poblacion"


// --- PRACTITIONERROLE — REF-1 link, REF-2 code (Yes), REF-5/6 link ----------
Instance: ExampleERefPractitionerRoleSubmission
InstanceOf: ERefPractitionerRole
Usage: #example
Title: "Example PractitionerRole — Dr. Villanueva at Kalibo Health Center"
Description: "Links Dr. Maria Villanueva to Kalibo Health Center as a primary care physician."

* practitioner = Reference(ExampleERefPractitionerSubmission)
* organization = Reference(ExampleERefOrganizationKaliboHC)
* code = $sct#158965000 "Medical practitioner"


// --- PRACTITIONERROLE (Receiving) — REF-9/10/11 Care Navigator + Facility -----
// Practitioner not yet assigned; organization carries the receiving facility
Instance: ExampleERefPractitionerRoleReceiving
InstanceOf: ERefPractitionerRole
Usage: #example
Title: "Example PractitionerRole — Receiving Facility at RSTMH"
Description: "PractitionerRole representing the receiving facility at RSTMH for Task.owner linkage. Practitioner not yet assigned at initial submission."

* organization = Reference(ExampleERefOrganizationRSTMH)
* code = $sct#158965000 "Medical practitioner"


// --- ORGANIZATION (Receiving) — REF-10 Name (Yes), REF-11 NHFR (Yes) ---------
Instance: ExampleERefOrganizationRSTMH
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Receiving Facility — Dr. Rafael S. Tumbokon Memorial Hospital"
Description: "Dr. Rafael S. Tumbokon Memorial Hospital (RSTMH), the receiving facility for Ana Reyes' referral."

* name = "Dr. Rafael S. Tumbokon Memorial Hospital"
* identifier[0].system = "https://nhfr.doh.gov.ph/facility"
* identifier[0].value = "042-DH-0012"
* identifier[+].system = "https://fhir.doh.gov.ph/pheref/Identifier/hcpn"
* identifier[=].value = "HCPN-WV-001"

* telecom.system = #phone
* telecom.value = "(043) 756-3124"
* telecom.use = #work

* address.use = #work
* address.line = "National Highway"
* address.postalCode = "5600"
* address.country = "PH"
* address.extension[region].valueCoding = $PSGC#0600000000 "Region VI (Western Visayas)"
* address.extension[province].valueCoding = $PSGC#0600400000 "Aklan"
* address.extension[cityMunicipality].valueCoding = $PSGC#0600407000 "Kalibo"
* address.extension[barangay].valueCoding = $PSGC#0600407013 "Poblacion"


// --- CONDITION — REF-31 Chief Complaint (problem-list-item) -----------------
Instance: ExampleERefConditionChiefComplaint
InstanceOf: ERefCondition
Usage: #example
Title: "Example Condition — Chief Complaint"
Description: "Chief complaint recorded at Kalibo Health Center: severe headache, dizziness, blurring of vision, epigastric pain."

* clinicalStatus = $condition-clinical#active
* category = $condition-category#problem-list-item "Problem List Item"
* code = $sct#25064002 "Headache"
  * text = "Severe headache, dizziness, blurring of vision and epigastric pain for 2 days"
* subject = Reference(ExampleERefPatient)
* encounter = Reference(ExampleERefSubmissionEncounter)
* note.text = "Chief complaint: severe headache, dizziness, blurring of vision and epigastric pain for 2 days. G2P1, 32 weeks AOG."


// --- CONDITION — REF-41 Working Impression (encounter-diagnosis) --------------
// ---            REF-32 Clinical History → Condition.note                       -
Instance: ExampleERefCondition
InstanceOf: ERefCondition
Usage: #example
Title: "Example Condition — Severe Pre-eclampsia"
Description: "Working impression of severe pre-eclampsia in a 38-year-old G2P1 at 32 weeks AOG."

* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#provisional "Provisional"
* category = $condition-category#encounter-diagnosis "Encounter Diagnosis"
* code = $sct#398254007 "Pre-eclampsia"
  * text = "Severe pre-eclampsia, 32 weeks AOG, G2P1"
* subject = Reference(ExampleERefPatient)

// Linked By: Condition.encounter Reference(PHeRefEncounter) — REF-31, REF-32
* encounter = Reference(ExampleERefSubmissionEncounter)

// REF-32: Clinical History → Condition.note
* note.text = "G2P1, 32 weeks AOG. EDD: Aug 20 2026. LMP: Nov 13 2025."


// --- OBSERVATION — REF-33 Vital Signs BP --------------------------------------
// ---              Linked By: Observation.encounter Reference(PHeRefEncounter)  -
Instance: ExampleERefObservationBP
InstanceOf: ERefObservation
Usage: #example
Title: "Example Blood Pressure — Ana Reyes"
Description: "Blood pressure taken at Kalibo Health Center: 180/110 mmHg."

// FHIR Observation BP profile requires LOINC 85354-9 as magic code.
// SNOMED 75367002 is co-coded per TDG REF-33 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#85354-9 "Blood pressure panel with all children optional"
* code.coding[+] = $sct#75367002 "Blood pressure"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"

// Linked By: Observation.encounter Reference(PHeRefEncounter)
* encounter = Reference(ExampleERefSubmissionEncounter)

// BP profile requires LOINC component codes for SystolicBP (8480-6) and DiastolicBP (8462-4) slices.
// SNOMED component codes are co-coded per TDG REF-33.
* component[0].code.coding[0] = $loinc#8480-6 "Systolic blood pressure"
* component[=].code.coding[+] = $sct#271649006 "Systolic blood pressure"
* component[=].valueQuantity = 180 'mm[Hg]' "mmHg"
* component[+].code.coding[0] = $loinc#8462-4 "Diastolic blood pressure"
* component[=].code.coding[+] = $sct#271650006 "Diastolic blood pressure"
* component[=].valueQuantity = 110 'mm[Hg]' "mmHg"


// --- OBSERVATION — REF-34 Vital Signs Heart Rate -------------------------------
Instance: ExampleERefObservationHR
InstanceOf: ERefObservation
Usage: #example
Title: "Example Heart Rate — Ana Reyes"
Description: "Heart rate taken at Kalibo Health Center: 112 bpm."

// FHIR Observation heartrate profile requires LOINC 8867-4 as magic code.
// SNOMED 78564009 is co-coded per TDG REF-34 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#8867-4 "Heart rate"
* code.coding[+] = $sct#78564009 "Pulse rate"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"
* encounter = Reference(ExampleERefSubmissionEncounter)
* valueQuantity = 112 '/min' "beats/minute"


// --- OBSERVATION — REF-35 Vital Signs Respiratory Rate --------------------------
Instance: ExampleERefObservationRR
InstanceOf: ERefObservation
Usage: #example
Title: "Example Respiratory Rate — Ana Reyes"
Description: "Respiratory rate taken at Kalibo Health Center: 24/min."

// FHIR Observation resprate profile requires LOINC 9279-1 as magic code.
// SNOMED 86290005 is co-coded per TDG REF-35 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#9279-1 "Respiratory rate"
* code.coding[+] = $sct#86290005 "Respiratory rate"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"
* encounter = Reference(ExampleERefSubmissionEncounter)
* valueQuantity = 24 '/min' "breaths/minute"


// --- OBSERVATION — REF-36 Vital Signs Oxygen Saturation -------------------------
Instance: ExampleERefObservationSpO2
InstanceOf: ERefObservation
Usage: #example
Title: "Example Oxygen Saturation — Ana Reyes"
Description: "Oxygen saturation taken at Kalibo Health Center: 96%."

// FHIR Observation oxygensat profile requires LOINC 2708-6 as magic code.
// SNOMED 103228002 is co-coded per TDG REF-36 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#2708-6 "Oxygen saturation in Arterial blood"
* code.coding[+] = $sct#103228002 "Hemoglobin saturation with oxygen"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"
* encounter = Reference(ExampleERefSubmissionEncounter)
* valueQuantity = 96 '%' "%"


// --- OBSERVATION — REF-37 Vital Signs Temperature -------------------------------
Instance: ExampleERefObservationTemp
InstanceOf: ERefObservation
Usage: #example
Title: "Example Body Temperature — Ana Reyes"
Description: "Body temperature taken at Kalibo Health Center: 36.8 C."

// FHIR Observation bodytemp profile requires LOINC 8310-5 as magic code.
// SNOMED 386725007 is co-coded per TDG REF-37 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#8310-5 "Body temperature"
* code.coding[+] = $sct#386725007 "Body temperature"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"
* encounter = Reference(ExampleERefSubmissionEncounter)
* valueQuantity = 36.8 'Cel' "Celsius"


// --- OBSERVATION — REF-38 Vital Signs Weight ------------------------------------
Instance: ExampleERefObservationWeight
InstanceOf: ERefObservation
Usage: #example
Title: "Example Body Weight — Ana Reyes"
Description: "Body weight taken at Kalibo Health Center: 72 kg."

// FHIR Observation bodyweight profile requires LOINC 29463-7 as magic code.
// SNOMED 27113001 is co-coded per TDG REF-38 and SNOMED International Edition compatibility.
* status = #final
* category = $observation-category#vital-signs "Vital Signs"
* code.coding[0] = $loinc#29463-7 "Body weight"
* code.coding[+] = $sct#27113001 "Body weight"
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2026-06-18T08:15:00+08:00"
* encounter = Reference(ExampleERefSubmissionEncounter)
* valueQuantity = 72 'kg' "kg"


// --- PROCEDURE — REF-39 Treatment Given ---------------------------------------
// ---           Linked By: Procedure.encounter Reference(PHeRefEncounter)       -
Instance: ExampleERefProcedureTreatment
InstanceOf: ERefProcedure
Usage: #example
Title: "Example Procedure — Pre-referral Treatment"
Description: "Medications administered at Kalibo Health Center prior to referral (documented in note per REF-39)."

* status = #completed
* code = $sct#416608005 "Drug therapy"
* subject = Reference(ExampleERefPatient)

// Linked By: Procedure.encounter Reference(PHeRefEncounter)
* encounter = Reference(ExampleERefSubmissionEncounter)

// REF-39: Treatment Given → Procedure.note
* note.text = "Pre-referral treatment given: Methyldopa 250mg BID, Folic Acid 5mg OD, FeSO4 300mg OD, CaCO3 500mg TID."


// --- DIAGNOSTIC REPORT — REF-40 Laboratory Results ----------------------------
Instance: ExampleERefDiagnosticReport
InstanceOf: DiagnosticReport
Usage: #example
Title: "Example Diagnostic Report — Urinalysis"
Description: "Urinalysis results showing proteinuria 3+, supporting the pre-eclampsia diagnosis."

* status = #final
* code = $loinc#24356-8 "Urinalysis complete panel - Urine"
* subject = Reference(ExampleERefPatient)
* encounter = Reference(ExampleERefSubmissionEncounter)
* conclusion = "Proteinuria 3+. Findings consistent with severe pre-eclampsia."
* presentedForm.title = "Urinalysis Results — Kalibo Health Center"


// --- SERVICE REQUEST — REF-1 through REF-16 -----------------------------------
Instance: ExampleERefServiceRequest
InstanceOf: ERefServiceRequest
Usage: #example
Title: "Example eReferral — Ana Reyes to RSTMH"
Description: "Referral request from Kalibo Health Center to Dr. Rafael S. Tumbokon Memorial Hospital for severe pre-eclampsia management."

// Status and intent
* status = #active
* intent = #order

// REF-14: Referral Category — category (Required=Yes)
* category = $sct#73770003 "Emergency"

// REF-13: Date of Referral (Required=Yes)
* authoredOn = "2026-06-18T08:30:00+08:00"

// REF-1, REF-2, REF-5–REF-8: Requester via PractitionerRole
* requester = Reference(ExampleERefPractitionerRoleSubmission)

// REF-10, REF-11: Performer (Receiving Facility via PractitionerRole)
* performer = Reference(ExampleERefPractitionerRoleReceiving)

// REF-16: Reason for Referral — reasonCode (Required=Yes)
* reasonCode = $sct#71388002 "Procedure"
  * text = "Severe pre-eclampsia requiring IV antihypertensive, seizure prophylaxis, and maternal-fetal monitoring"

// REF-41: Working Impression supporting the referral
* reasonReference = Reference(ExampleERefCondition)

// Clinical information (REF-31, REF-33-41) linked via Encounter

// REF-21: Subject (patient)
* subject = Reference(ExampleERefPatient)

// Encounter: the clinical event this referral is associated with
* encounter = Reference(ExampleERefSubmissionEncounter)

// Free-text referral notes
* note.text = "Ana Reyes, 38-year-old G2P1, 32 weeks AOG. BP 180/110 mmHg with severe headache, dizziness, and blurring of vision. Proteinuria 3+. Referred for urgent management of severe pre-eclampsia."

// REF-15: When service is needed
* occurrenceDateTime = "2026-06-18T08:30:00+08:00"

// Requisition tracking
* requisition.system = "urn:oid:1.2.840.113619.21.1.2"
* requisition.value = "REF-2026-001234"


// --- TASK — REF-17 Action Point: Received -------------------------------------
// ---       REF-9/10/11 Care Navigator + Receiving Facility → Task.owner --------
Instance: ExampleERefTaskRequested
InstanceOf: ERefTask
Usage: #example
Title: "Example eReferral Task — Requested"
Description: "Task representing the referral for Ana Reyes in 'requested' status."

// REF-17: Action Point — requested
* status = #requested
* intent = #order

* code = $sct#3457005 "Patient referral"
* code.text = "eReferral for severe pre-eclampsia management"

// REF-15: Task tracks ServiceRequest
* focus = Reference(ExampleERefServiceRequest)

* for = Reference(ExampleERefPatient)

// Referring side
* requester = Reference(ExampleERefPractitionerRoleSubmission)

// REF-9, REF-10, REF-11: Receiving facility / Care Navigator (via PractitionerRole)
* owner = Reference(ExampleERefPractitionerRoleReceiving)

* authoredOn = "2026-06-18T08:30:00+08:00"
* lastModified = "2026-06-18T08:30:00+08:00"
* note.text = "New referral for Ana Reyes with severe pre-eclampsia. Awaiting RSTMH response."

// Task.status = #requested captures the initial state.
// businessStatus is populated by the receiving facility on response."


// --- PROVENANCE — REF-3 Date & Time of Signature ------------------------------
// ---              REF-4 Professional Signature --------------------------------
Instance: ExampleERefProvenanceSubmission
InstanceOf: ERefProvenance
Usage: #example
Title: "Example Provenance — Referral Signature Attestation"
Description: "Provenance record with professional signature for Ana Reyes' referral."

// REF-3: Date & Time of Signature
* recorded = "2026-06-18T08:30:00+08:00"

// Target: the referral it attests to
* target = Reference(ExampleERefServiceRequest)

* activity = $v3-DataOperation#CREATE "create"

// Agent who created the referral
* agent[0].type = $provenance-participant-type#author "Author"
* agent[=].who = Reference(ExampleERefPractitionerRoleSubmission)
* agent[=].onBehalfOf = Reference(ExampleERefOrganizationKaliboHC)

// REF-4: Professional Signature
// Sub-elements required by ERefProvenance: type (1..*), when (1..1), who (1..1), data (1..1)
* signature[0].type = $signature-type#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature[=].when = "2026-06-18T08:30:00+08:00"
* signature[=].who = Reference(ExampleERefPractitionerRoleSubmission)
* signature[=].data = "dGVzdHNpZ25hdHVyZWJhc2U2NA=="
* signature[=].sigFormat = #application/signature+xml


// =============================================================================
// SUBMISSION BUNDLE: Initiating Facility (KHC → RSTMH)
// =============================================================================

// --- SUBMISSION BUNDLE: Story 1 (KHC → RSTMH) ----------------------------------
Instance: ExampleERefSubmissionBundle
InstanceOf: Bundle
Usage: #example
Title: "Example Submission Bundle — Initial Referral (KHC → RSTMH)"
Description: "Transaction bundle for the initial referral submission from Kalibo Health Center to Dr. Rafael S. Tumbokon Memorial Hospital."
* type = #transaction
* timestamp = "2026-06-18T08:30:00+08:00"

// Patient
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Patient/ExampleERefPatient"
* entry[=].resource = ExampleERefPatient
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"

// Practitioner — Referring
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Practitioner/ExampleERefPractitionerSubmission"
* entry[=].resource = ExampleERefPractitionerSubmission
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Organization — Referring (KHC)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Organization/ExampleERefOrganizationKaliboHC"
* entry[=].resource = ExampleERefOrganizationKaliboHC
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// PractitionerRole — Referring (KHC)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/PractitionerRole/ExampleERefPractitionerRoleSubmission"
* entry[=].resource = ExampleERefPractitionerRoleSubmission
* entry[=].request.method = #POST
* entry[=].request.url = "PractitionerRole"

// Organization — Receiving (RSTMH)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Organization/ExampleERefOrganizationRSTMH"
* entry[=].resource = ExampleERefOrganizationRSTMH
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// PractitionerRole — Receiving (RSTMH)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/PractitionerRole/ExampleERefPractitionerRoleReceiving"
* entry[=].resource = ExampleERefPractitionerRoleReceiving
* entry[=].request.method = #POST
* entry[=].request.url = "PractitionerRole"

// ServiceRequest — MUST come before Encounter, Task, Provenance (they reference it)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/ServiceRequest/ExampleERefServiceRequest"
* entry[=].resource = ExampleERefServiceRequest
* entry[=].request.method = #POST
* entry[=].request.url = "ServiceRequest"

// Encounter — references ServiceRequest via basedOn
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Encounter/ExampleERefSubmissionEncounter"
* entry[=].resource = ExampleERefSubmissionEncounter
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

// Condition — Chief Complaint (REF-31)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Condition/ExampleERefConditionChiefComplaint"
* entry[=].resource = ExampleERefConditionChiefComplaint
* entry[=].request.method = #POST
* entry[=].request.url = "Condition"

// Condition — Working Impression (REF-41)
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Condition/ExampleERefCondition"
* entry[=].resource = ExampleERefCondition
* entry[=].request.method = #POST
* entry[=].request.url = "Condition"

// Observation — Blood Pressure
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationBP"
* entry[=].resource = ExampleERefObservationBP
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation — Heart Rate
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationHR"
* entry[=].resource = ExampleERefObservationHR
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation — Respiratory Rate
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationRR"
* entry[=].resource = ExampleERefObservationRR
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation — Oxygen Saturation
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationSpO2"
* entry[=].resource = ExampleERefObservationSpO2
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation — Temperature
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationTemp"
* entry[=].resource = ExampleERefObservationTemp
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Observation — Weight
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Observation/ExampleERefObservationWeight"
* entry[=].resource = ExampleERefObservationWeight
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Procedure
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Procedure/ExampleERefProcedureTreatment"
* entry[=].resource = ExampleERefProcedureTreatment
* entry[=].request.method = #POST
* entry[=].request.url = "Procedure"

// DiagnosticReport
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/DiagnosticReport/ExampleERefDiagnosticReport"
* entry[=].resource = ExampleERefDiagnosticReport
* entry[=].request.method = #POST
* entry[=].request.url = "DiagnosticReport"

// Task — references ServiceRequest via focus
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Task/ExampleERefTaskRequested"
* entry[=].resource = ExampleERefTaskRequested
* entry[=].request.method = #POST
* entry[=].request.url = "Task"

// Provenance — references ServiceRequest via target
* entry[+].fullUrl = "https://fhir.doh.gov.ph/pheref/Provenance/ExampleERefProvenanceSubmission"
* entry[=].resource = ExampleERefProvenanceSubmission
* entry[=].request.method = #POST
* entry[=].request.url = "Provenance"


