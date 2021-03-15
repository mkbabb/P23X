# 16.1 Preconditions

The user is registered within the iTrust2 system (UC1); withal, the user is
authenticated in the system (UC2).

# 16.2 Main Flow(s)

-   If the user is an HCP administrator, they can view **all** patient surveys
    **[E1.1]**, overall response rates per-HCP **[E1.2]**, aggregated numerical results,
    and anonymized user-comments **[E1.3]**. **[S1]**.

-   If the user is a patient, they can view surveys to be completed **[E2.1b]** - and
    therein complete a survey **[E2.1a]** - or surveys that have been completed by them
    **[E2.2]**. Patients can also view the aggregated numerical results per-HCP
    **[E2.3]**, but shall not have access to user-comments. _One survey hereof may be
    completed per office visit._ **[S2]**.

# 16.3 Sub-Flows

-   **[S1]**: The HCP admin navigates to the satisfaction survey section, wherein they
    can perform the following:

    -   **[E1.1]** View all patient surveys, and select an individual survey therein.
    -   **[E1.2]** View aggregated numerical data regarding an arbitrarily grouped-set
        of satisfaction surveys: grouped by HCP, patient type, & c.
    -   **[E1.3]** View the anonymized comments of patients, by HCP.

-   **[S2]**: A patient navigates to the satisfaction survey section, wherein they can
    perform the following:
    -   **[E2.1a-b]** View surveys to be completed, and therein complete the survey.
    -   **[E2.2]** View their completed surveys.
    -   **[E2.3]** View aggregated numerical data, similar to **[E1.2]**, though limited
        in scope **(TBD)**.

# 16.4 Logging

**TODO**

| Transaction Code | Verbose Description | Logged In MID | Secondary MID | Transaction Type | Patient Viewable |
| ---------------- | ------------------- | ------------- | ------------- | ---------------- | ---------------- |

# 16.5 Data Format

### For a given survey:

Herein, we define the type, **SURVEY_SATISFACTION_LIKERT**, as an enumeration,
representing a prototypical 5-point Likert scale with values defined as:

-   Extremely satisfied
-   Very satisfied
-   Neutral
-   Slightly satisfied
-   Extremely unsatisfied

Additionally, we shall follow the convention of _italicized_ variables demarcating
optionality, and **bolding** as requirement.

| Field                           | Format                       |
| ------------------------------- | ---------------------------- |
| **Minutes in waiting room**     | `UNSIGNED INT`               |
| **Minutes in examination room** | `UNSIGNED INT`               |
| **Office visit satisfaction**   | `SURVEY_SATISFACTION_LIKERT` |
| **Treatment satisfaction**      | `SURVEY_SATISFACTION_LIKERT` |
| _Comments_                      | `TEXT`                       |

# 16.6 Explication of Flows

Subflow **[E2.1a]** stipulates the point whereat a user completes a given survey.
Therein, the aforewritten `16.5` data format fields are filled.

**TODO**
