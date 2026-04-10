// Value Set for PWD Disability Types
// Based on Philippine government disability classifications

CodeSystem: PWDDisabilityTypeCS
Id: pwd-disability-type-cs
Title: "PWD Disability Type Code System"
Description: "Code system for types of disability as defined by the Philippine government for PWD registration."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete

* #visual "Visual Disability" "Complete or partial loss of sight/visual function."
* #hearing "Hearing Disability" "Complete or partial loss of hearing/hearing function."
* #speech "Speech Impairment" "Complete or partial loss of speech or communication function."
* #physical "Physical/Orthopedic Disability" "Impairment in physical/orthopedic function including locomotor disabilities."
* #intellectual "Intellectual Disability" "Significant limitations in intellectual functioning and adaptive behavior."
* #learning "Learning Disability" "Neurological disorders affecting acquisition and use of listening, speaking, reading, writing, reasoning, or mathematical abilities."
* #psychosocial "Psychosocial Disability" "Mental health conditions and psychosocial impairments."
* #visual-low-vision "Low Vision" "Significant visual impairment not correctable by standard glasses/contact lenses."
* #visual-blindness "Blindness" "Complete loss of vision or light perception."

ValueSet: PWDDisabilityTypeVS
Id: pwd-disability-type-vs
Title: "PWD Disability Type Value Set"
Description: "Value set for types of disability as defined by the Philippine government for PWD registration."
* ^status = #draft
* ^experimental = true
* include codes from system PWDDisabilityTypeCS
