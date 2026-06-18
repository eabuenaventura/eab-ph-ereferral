Instance: ExampleERefEncounter
InstanceOf: ERefEncounter
Usage: #example
Title: "Example eReferral Encounter"
Description: "An emergency encounter at RSTMH for Ana Reyes presenting with severe pre-eclampsia."

* status = #finished
* class = $v3-ActCode#EMER "emergency"
* subject = Reference(ExampleERefPatient)
* basedOn = Reference(ExampleERefServiceRequest)
* reasonReference = Reference(ExampleERefCondition)
