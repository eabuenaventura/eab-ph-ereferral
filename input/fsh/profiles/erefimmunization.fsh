// ERefImmunization Profile - Philippine eReferral Immunization
// Extends PHCoreImmunization with eReferral-specific mustSupport constraints

Profile: ERefImmunization
Parent: PHCoreImmunization
Id: ereferral-immunization
Title: "ERefImmunization"
Description: "Immunization profile for the Philippine eReferral system. Extends PHCoreImmunization to define must-support elements for referral clinical context. Immunization records are referenced via ServiceRequest.supportingInfo to provide supporting clinical information about a patient's vaccination history."

* ^status = #draft
* ^experimental = true
* ^purpose = "To standardize immunization records included as supporting clinical information in Philippine eReferrals, ensuring key vaccination details are consistently captured and exchanged between referring and receiving facilities."

// Business identifier
* identifier MS
* identifier ^short = "Immunization record business identifier"

// Status (MS)
* status MS
* status ^short = "completed | entered-in-error | not-done"

// Status reason - why not done
* statusReason MS
* statusReason ^short = "Reason vaccination was not performed"

// Vaccine code (MS) - ICD-11, CVX, or local PH codes
* vaccineCode MS
* vaccineCode ^short = "Vaccine product administered"
* vaccineCode ^definition = "Vaccine that was administered or was to be administered. Supports CVX, ICD-11, or locally defined Philippine vaccine codes."
* vaccineCode from ERefVaccineCodeVS (extensible)

// Patient (MS) - constrained to ERefPatient
* patient MS
* patient only Reference(ERefPatient)
* patient ^short = "Patient who was immunized"

// Encounter
* encounter MS
* encounter ^short = "Encounter during which immunization was administered"

// Occurrence (MS)
* occurrence[x] MS
* occurrence[x] ^short = "Vaccine administration date"

// Recorded
* recorded MS
* recorded ^short = "When immunization was recorded"

// Primary source
* primarySource MS
* primarySource ^short = "Indicates if record was captured at time of administration"

// Location
* location MS
* location ^short = "Facility where immunization occurred"

// Manufacturer
* manufacturer MS
* manufacturer ^short = "Vaccine manufacturer"

// Lot number
* lotNumber MS
* lotNumber ^short = "Vaccine lot number"

// Expiration date
* expirationDate MS
* expirationDate ^short = "Vaccine expiration date"

// Body site
* site MS
* site ^short = "Body site where vaccine was administered"

// Route
* route MS
* route ^short = "How vaccine entered the body"

// Dose quantity
* doseQuantity MS
* doseQuantity ^short = "Amount of vaccine administered"

// Performer (MS)
* performer MS
* performer ^short = "Who performed the vaccination"
* performer.function MS
* performer.actor MS

// Reason code
* reasonCode MS
* reasonCode ^short = "Why immunization occurred"

// Reason reference
* reasonReference MS
* reasonReference ^short = "Condition or observation that led to immunization"

// Subpotent dose flag
* isSubpotent MS
* isSubpotent ^short = "Indicates if dose was subpotent"

// Program eligibility (e.g., EPI)
* programEligibility MS
* programEligibility ^short = "Patient eligibility for a vaccination program (e.g., DOH EPI)"

// Funding source
* fundingSource MS
* fundingSource ^short = "Funding source for the vaccine (e.g., public/private)"

// Reaction details
* reaction MS
* reaction ^short = "Adverse reaction following immunization"
* reaction.date MS
* reaction.detail MS
* reaction.reported MS

// Protocol applied (MS) - tracks EPI schedule adherence
* protocolApplied MS
* protocolApplied ^short = "Immunization protocol followed (e.g., DOH EPI schedule)"
* protocolApplied.series MS
* protocolApplied.targetDisease MS
* protocolApplied.doseNumber[x] MS
* protocolApplied.seriesDoses[x] MS


// --- Value Set ---

ValueSet: ERefVaccineCodeVS
Id: ereferral-vaccine-code-vs
Title: "ERef Vaccine Code Value Set"
Description: "Vaccine codes for use in Philippine eReferral immunization records. Supports CVX, ICD-11, and locally defined Philippine vaccine codes."

* codes from system http://snomed.info/sct
* codes from system http://id.who.int/icd/release/11/mms
* codes from system http://hl7.org/fhir/sid/cvx
