# v0.1 Referral Workflow Narrative and State Model

## Purpose and Scope

This page is informative implementation guidance for the v0.1 draft.

This page describes the minimum viable referral workflow for PH eReferral v0.1. It is intended for early implementation, validation, and connectathon-style testing so that implementers can exercise a shared baseline workflow while the broader clinical, operational, and policy decisions continue to mature.

This workflow is not a production policy implementation unless it is formally endorsed by the appropriate clinical, technical, and program owners. It is a testable implementation narrative for the current IG draft.

The minimum path on this page is separated from policy and background material. The workflow tables below are the concrete path expected to be usable for v0.1 authoring and testing; the policy references explain the context and should not, by themselves, be treated as additional v0.1 test steps.

For v0.1, the workflow focuses on:

- creating a referral request from an initiating facility;
- sending the referral request to an intended receiving facility or service;
- tracking that referral through receipt, review, outcome, and closure;
- demonstrating the workflow with the current [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html), [EReferral Task](StructureDefinition-ereferral-task.html), and example resources.

The following topics are deferred or not fully resolved in this v0.1 workflow narrative:

- final receiving-facility response terminology, including whether `accept` and `reject` should be used or replaced by policy-aligned wording;
- non-response and service-level agreement handling;
- full attachment and security handling;
- final facility and network identification rules;
- back-referral as a required end-to-end workflow.

## Policy and Narrative Basis

This workflow is grounded in the same national policy context summarized on the [WHO SMART Guidelines L1 Basis](who-smart-l1.html) page:

- [DOH Administrative Order No. 2020-0019](https://drive.google.com/file/d/1Uri9Iov3YPw3rc3AidV6dXjv8y_W7ydr/view), *Guidelines on the Service Delivery Design of Health Care Provider Networks*, describes the HCPN context in which referral coordination and service delivery operate.
- [DOH Administrative Order No. 2020-0024](https://law.upd.edu.ph/wp-content/uploads/2020/06/DOH-AO-No-2020-0024.pdf), *Primary Care Policy Framework and Sectoral Strategies*, clarifies the primary care role as navigator, coordinator, and continuing point of contact, and emphasizes continuity and coordination of care.
- [DOH Administrative Order No. 2020-0021](https://law.upd.edu.ph/wp-content/uploads/2020/05/DOH-AO-No_2020-0021.pdf), *Guidelines on Integration of the Local Health Systems into Province-wide and City-wide Health Systems (P/CWHS)*, situates HCPNs and PCPNs within integrated local health-system delivery and includes two-way referrals, patient navigation, records access, and digital technologies for health.

These references inform the workflow scope, especially the emphasis on coordinated care, patient navigation, and records exchange. The v0.1 workflow still remains a draft implementation path until formally endorsed.

## Minimum Viable Workflow Diagram

The following diagram reflects the latest minimum viable workflow discussed by the Clinical Design Group for the v0.1 baseline.

![Minimum viable referral workflow](minimum-viable-workflow.png)

The diagram uses the lanes `Initiator`, `Receiving Service`, and `Recipient`. The `Accept` and `Reject` labels shown in the decision point should be read as working workflow labels only. Final receiving-facility response wording remains pending [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47).

## Actors and Systems

The minimum v0.1 workflow involves the following actors and systems.

| Actor or system | Minimum v0.1 role |
| --- | --- |
| Referring facility / initiating facility | Assesses the patient, creates the referral request, and sends it to a receiving facility or service. |
| Referring practitioner | Acts as the requester for the referral and provides the clinical reason and supporting information. |
| Receiving facility / receiving service | Receives and evaluates the referral, then records the receiving-facility outcome or update. |
| Recipient / receiving clinician or team | Performs clinical triage or clinical review after the receiving service has accepted or otherwise routed the referral for review. |
| Care navigator | May be assigned to coordinate the referral when the local workflow includes this role. In FHIR this may be represented through `ServiceRequest.performer` or `Task.owner`, depending on the implementation pattern. |
| Referral management system / FHIR server / exchange layer | Stores, exchanges, and updates the FHIR resources used to represent the referral request and workflow state. |

## Minimum Workflow Steps

| Step | Workflow activity | FHIR traceability |
| --- | --- | --- |
| 1 | Patient arrives and presents with a complaint or problem. | Patient demographics are represented by the patient resource referenced from `ServiceRequest.subject`. |
| 2 | Initiator assesses the patient condition and determines whether referral criteria are satisfied. | Relevant clinical context may be represented with supporting resources such as `Condition` and `Observation`, then referenced from `ServiceRequest.reasonReference` or `ServiceRequest.supportingInfo`. |
| 3 | If referral criteria are not satisfied, the minimum referral workflow ends. | No eReferral ServiceRequest is required for the v0.1 referral test path. |
| 4 | If referral criteria are satisfied, initiator discusses referral and next steps with the patient, including consent where applicable. | Consent capture is not fully profiled in v0.1. Any consent-related detail should be handled by local policy or a future profile decision. |
| 5 | Initiator creates the referral request and attaches clinical summary or notes. | Create an [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html) with `status`, `intent`, `subject`, `requester`, `performer`, `authoredOn`, `priority`, `reasonCode`, `reasonReference`, `supportingInfo`, and `note` as applicable. |
| 6 | Initiator reviews candidate receiving facilities and sends the referral. | `ServiceRequest.performer` identifies the intended receiving facility, service, practitioner role, or navigator pattern used by the implementation. |
| 7 | Receiving service receives, registers, or logs the referral and performs referral evaluation. | If workflow tracking is used, create or update an [EReferral Task](StructureDefinition-ereferral-task.html) with `Task.focus` referencing the ServiceRequest and `Task.status` representing the current workflow state. |
| 8 | Receiving service records the receiving-facility decision or outcome. | Record the receiving-facility outcome using the agreed v0.1 terminology. Until [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) is resolved, examples should avoid treating `accept` or `reject` as final policy terminology. |
| 9 | If the referral can proceed, route for clinical triage or review by the recipient and send updates to the sender. | `Task.owner`, `Task.lastModified`, `Task.note`, and `Task.output` may be used to show assignment, updates, and resulting information. |
| 10 | Next steps after the referral decision are outside the v0.1 minimum path unless explicitly included in a test scenario. | Close the workflow when the referral outcome is known. In the current examples, closure is demonstrated with `Task.status = #completed`, `Task.executionPeriod.end`, and `Task.output`. |

## Request and Workflow Responsibilities

The v0.1 workflow follows the FHIR workflow pattern used by other ServiceRequest-based implementation guides: the request details are kept on `ServiceRequest`, while fulfilment and coordination state are tracked with `Task` when workflow tracking is needed.

| Resource or element | v0.1 responsibility |
| --- | --- |
| `ServiceRequest` | Represents the referral request: patient, requester, intended performer, requested service, priority, reason, and supporting clinical information. |
| `ServiceRequest.status` | Represents the initiating side's overall request lifecycle. In the current v0.1 examples, the referral request is `active` once it has been created and sent. |
| `Task` | Represents workflow tracking for the referral request, especially receipt, review, assignment, response/update, and closure. |
| `Task.focus` | References the `ERefServiceRequest` being tracked. |
| `Task.requester` | Identifies the initiating side that created or requested the workflow action. |
| `Task.owner` | Identifies the receiving facility, receiving practitioner role, care navigator, or organization currently responsible for acting on the referral task. |
| `Task.status` | Represents the current workflow state. Implementers should not assume that changing `Task.status` automatically changes `ServiceRequest.status`; any synchronization rule must be agreed by the implementation. |
| `Task.statusReason` | May carry human-readable context for a status such as rejected, cancelled, on-hold, or another non-happy-path state, if those states are approved for use. |
| `Task.businessStatus` | May carry local business substates when `Task.status` is too broad, but no v0.1 business-status code system is defined by this page. |
| `Task.output` | May carry the receiving-side update, result, or closure summary when the referral workflow outcome is known. |

## State Model

The table below describes the minimum state model for v0.1. Implementers should distinguish the request lifecycle on `ServiceRequest.status` from workflow coordination state on `Task.status` when Task is used.

| State | Meaning in v0.1 | Suggested FHIR representation | Expected transition |
| --- | --- | --- | --- |
| Draft / prepared referral | The referral is being prepared and has not yet been sent. | `ServiceRequest.status = #draft`; optionally `Task.status = #draft` if a Task is created before sending. | Moves to active / sent when the referral is ready for exchange. |
| Active or sent referral | The referral request has been created and sent or made available to the receiving side. | `ServiceRequest.status = #active`; current task examples use `Task.status = #requested`. | Moves to received / under review when the receiving side records receipt or starts review. |
| Received / under review | The receiving facility has received the referral and is reviewing whether it can take the case. | `Task.status = #received` or another agreed status/update pattern; the exact receiving response terminology remains subject to [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47). | Moves to accepted, redirected, declined if approved, or another agreed outcome state. |
| Accepted / receiving facility can take the case | The receiving facility can take the case under the agreed workflow. | Current examples demonstrate `Task.status = #accepted` in [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html). | Moves toward transfer, service delivery, and eventual closure. |
| Redirected / referred elsewhere / capacity full | The receiving facility cannot take the case and directs the patient or referring facility to another facility or service. | Terminology and coding are not final. This should be represented only using the CDG/TDG/PO-approved wording and FHIR pattern. | Moves to a redirected or closed outcome once final scope is agreed. |
| Declined / rejected | A negative receiving-facility outcome, if explicitly approved for v0.1 wording. | Do not treat `reject` as final policy terminology until [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) is resolved. If approved, `Task.statusReason` should explain the reason when available. | If approved, moves to closure or rerouting according to the agreed policy wording. |
| Closed / completed | The referral workflow outcome is known and no further v0.1 workflow action is expected. | `Task.status = #completed`; optionally align `ServiceRequest.status` with the final request lifecycle state used by the implementation. | Terminal state for the v0.1 workflow. |
| Not arrived / did not proceed | The patient did not proceed to the receiving service after referral. | Not defined as a required v0.1 state. Include only if explicitly added to the agreed scope. | Deferred unless adopted for v0.1 testing. |

## Referral Response Semantics

The receiving-facility response terminology is still an open design decision. [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47) asks the CDG to confirm whether the workflow should use `accept/reject` or policy-aligned alternatives such as `received`, `referred`, `capacity full / refer elsewhere`, or other agreed terms. [Issue #41](https://github.com/ph-ereferral-organization/ph-ereferral/issues/41) also remains open for Hypertensive Emergency Referral terminology sync.

Until that decision is resolved:

- this page treats `accepted` as an existing FHIR Task workflow status demonstrated by current examples, not as final receiving-facility policy wording;
- this page treats the CDG workflow diagram's `Accept` and `Reject` labels as working labels, not approved response terminology;
- this page does not define `reject` as a final approved business response;
- redirect, capacity-full, and refer-elsewhere outcomes should be documented using the final agreed wording before they are made normative;
- non-response and SLA handling are explicitly deferred for v0.1 unless a later decision adds them to scope.

## FHIR Artifact Traceability

The primary request resource is [EReferral ServiceRequest](StructureDefinition-ereferral-service-request.html). When workflow tracking is needed, [EReferral Task](StructureDefinition-ereferral-task.html) tracks state transitions and references the ServiceRequest through `Task.focus`.

Current official examples that demonstrate the v0.1 workflow pattern include:

- [Example eReferral Service Request](ServiceRequest-ExampleERefServiceRequest.html)
- [Example eReferral Task - Requested State](Task-ExampleERefTaskRequested.html)
- [Example eReferral Task - Accepted State](Task-ExampleERefTaskAccepted.html)
- [Example eReferral Task - Completed State](Task-ExampleERefTaskCompleted.html)

The traceability table below is intentionally limited to current v0.1 examples and profiles. It should be updated if Issue #47 adds new response terminology, if new redirect examples are added, or if a separate referral-feedback artifact is introduced.

| Workflow information | Current example field(s) |
| --- | --- |
| Request status | `ServiceRequest.status`; `Task.status` when workflow tracking is used |
| Request intent | `ServiceRequest.intent`; `Task.intent` |
| Patient | `ServiceRequest.subject`; `Task.for` |
| Requester / referring side | `ServiceRequest.requester`; `Task.requester` |
| Receiving facility, practitioner, or navigator | `ServiceRequest.performer`; `Task.owner` |
| Supporting clinical information and notes | `ServiceRequest.reasonCode`, `ServiceRequest.reasonReference`, `ServiceRequest.supportingInfo`, and `ServiceRequest.note` |
| Response or update | `Task.status`, `Task.note`, `Task.lastModified`, and, where applicable, `Task.output` |
| Closure | `Task.status = #completed`, `Task.executionPeriod.end`, and `Task.output` in the completed Task example |

## Known Limitations

This v0.1 workflow page intentionally documents unresolved areas rather than silently making them normative.

- Back-referral is not modeled as a required end-to-end workflow in this MVP page.
- Attachment and security handling are not fully resolved in the current workflow narrative.
- Facility and network identification rules are not finalized here. See [Issue #4](https://github.com/ph-ereferral-organization/ph-ereferral/issues/4) for the facility identification discussion.
- Transport behavior is not defined by this page; implementations may use a referral management system, FHIR server, or exchange layer pattern agreed for the test event.
- Receiving-facility response terms are pending the decision in [Issue #47](https://github.com/ph-ereferral-organization/ph-ereferral/issues/47).
- Hypertensive Emergency Referral wording is pending terminology sync in [Issue #41](https://github.com/ph-ereferral-organization/ph-ereferral/issues/41).
- Consent, candidate receiving-facility selection rules, and the detailed post-decision recipient workflow are not fully specified in this v0.1 page.
- Non-response and SLA handling are deferred unless explicitly included by a later v0.1 decision.
- Implementers should not infer production policy requirements from this page without formal endorsement.
