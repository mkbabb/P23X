# Design Decisions

## Frontend Decisions

### UC6 Ophthalmology Appointment Request

No frontend decisions were made for this use-case. Existing user interface already
covers the needed functionality.

### UC15 Ophthalmology Office Visit

In order to fulfill the requirements of
[UC15](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/wiki/UC15-Ophthalmology-Office-Visit),
an additional panel was added to the "Document Office Visit" page outlined in
[UC7](https://github.ncsu.edu/engr-csc326-staff/iTrust2-v8/wiki/uc7) which allows the
HCP to enter patient eye information and select diagnosed diseases. This panel is only
shown to be available once the visit selected is of the ophthalmology appointment visit
type. The style of the panel will be in line with the others on the same page to allow
for visual continuity.

### UC16 Satisfaction Surveys

In light of new information regarding the required functionality,
[UC16](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/wiki/UC16-Satisfaction-Surveys)
was modified. Pursuant to this, two distinct views, or HTML templates, were created:

-   Browse Satisfaction Surveys View
-   Patient survey input & viewing

#### Browse Satisfaction Surveys View

Pursuant to
[UC16](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/wiki/UC16-Satisfaction-Surveys),
the search and aggregation functionality was implemented by way of a global drop-down
with search capability. In particular, UC16 stipulates that a user shall be provided
with two aggregation measures, grouping by:

-   HCP
-   global; all data

As access is different by role, the following business rules will apply to this shared
view:

-   If a user is a HCP, the drop-down is locked to their own surveys, and comments will
    not be shown
-   If a user is a patient, the drop-down is unlocked, and comments will not be shown
-   If a user is an admin, the drop-down is unlocked, and comments will be shown

#### Patient Survey Input

Pursuant to
[UC16](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/wiki/UC16-Satisfaction-Surveys),
patients will have the ability to submit satisfaction surveys for all of their visits,
as well as view their previous surveys. A drop-down will select survey by date and type,
sorted with unfilled surveys at the top and bolded. Submitted surveys will display when
they were submitted, and will not have a Submit button.

### UC17 Ophthalmology User

No frontend decisions were made for this use-case. Existing user interface already
covers the needed functionality.

## Backend Decisions

### UC6 Ophthalmology Appointment Request

No decisions were needed for implementing this in the backend, as it was already
implemented.

### UC15 Ophthalmology Office Visit

For implementing these types of Visits, an additional `OphthalmologyMetrics` model was
added to support the new data required. This is similar to the `BasicHealthMetrics`
model used in OfficeVisits to store similar, but more general information. This requires
few changes to our API layer, as Office Visits will function as they did previously,
just with additional `OphthalmologyMetrics` added to the `OfficeVisitForm`. For
supporting the additional Ophthalmology diseases, we chose to add a set of allowed
`Roles` that are permitted to access the ICD codes, and these roles are set by the Admin
when adding the ICD codes into iTrust2. When `getCodes` is called in the
`APIICDCodeController`, only codes that are allowed to be accessed by a role will be
returned to the requesting User.

### UC16 Satisfaction Surveys

For the backend of the Satisfaction Surveys feature, we chose a very similar design
pattern to the rest of the project. Surveys are represented by a `Survey` class, that
stores any information relevant to a survey. The survey class is the object that will be
stored within the database. It makes use of a custom enum called `SurveySatisfaction` to
represent different ratings that a user could select when filling out the survey for
their visit. The feature also has accompanying Service/Repository classes to assist with
storing/retrieving surveys from the database.

For the API for the Satisfaction Surveys feature, we chose to introduce two endpoints
with get mapping based on whether the user was a Patient or an HCP. These get mappings
would return all of the surveys that a Patient has done or has yet to do, or they would
return all of the surveys that have been filled out for a specific HCP. We also included
a put mapped endpoint for when a Patient finishes a survey, and submits it. The endpoint
uses put mapping since the Survey already exists, it just needs to be updated with the
input data given by a Patient.

### UC17 Ophthalmology User

This was already existing in the application, no design was needed.

## Frontend Design Elements

### UC16 Satisfaction Surveys

#### Patient Survey Input & View

[Link to PDF](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/feature/surveys/Design/Wireframe/Survey-Entry.pdf)

#### Browse Satisfaction Surveys (All User Types)

[Link to PDF](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/feature/surveys/Design/Wireframe/Survey-View.pdf)

### UC15 Ophthalmology Office Visit

#### Document Office Visit

![](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/feature/office-visit/Design/Wireframe/office_visit_clean.png)

#### Document Office Visit (With Errors)

![](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/feature/office-visit/Design/Wireframe/office_visit_error.png)

## Backend Design Elements

### Class Diagram

![](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/development/Design/UML/umletino_uml.png)

### Sequence Diagram

![](https://github.ncsu.edu/engr-csc326-spring2021/csc326-TP-214-1/blob/development/Design/SequenceDiagram/get_and_complete_survey.png)

### REST API

#### UC15 Ophthalmology Office Visit

##### `getCodes()` - (GET /icdcodes/)

_Modified from the original `getCodes()`_

This API endpoint will return `ICDCodes` objects housed within the `icd_codes` table.
Importantly, the API controller, `APIICDCodesController`, will dynamically dispatch the
requested information, only returning codes that a particular user is authorized to
view.

Example for a user with access to the `ICD` code, "code1":

```json
[
    {
        "id": 0,
        "code": "code1",
        "description": "this is a desc.",
        "allowedRoles": ["role1", "role2"]
    }
]
```

##### createOfficeVisit(OfficeVisitForm) - (POST, PUT /officevisits)

_Modified from the original `createOfficeVisit(OfficeVisitForm)`_

This API endpoint is used to create or update an `OfficeVisit` object using information
provided by the received `OfficeVisitForm` object. We've modified the form object to
contain fields specific to Ophthalmologists, which shall be demonstrated below.

Example data (original fields elided for simplicity):

```json
{
    "visualAcuityOS": 10,
    "visualAcuityOD": 10,
    "sphereOD": 0.1,
    "sphereOS": 0.1,
    "axisOD": 1,
    "axisOS": 1,
    "cylinderOD": 0.1,
    "cylinderOS": 0.1
}
```

---

#### UC16 Satisfaction Surveys

```
Illustration Data:
Surveys: {
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '10', 'examTime': '30', 'visitRating': 'Very Satisfied', 'treatmentRating': 'Extremely Satisfied', 'comments': 'The visit and treatment went well.' ],
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'false', 'waitTime': 'null', 'examTime': 'null', 'visitRating': 'null', 'treatmentRating': 'null', 'comments': 'null' ],
[ 'patientUserName': 'Mark', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '8', 'examTime': '40', 'visitRating': 'Neutral', 'treatmentRating': 'Neutral', 'comments': 'Overall, the visit and treatment were average.' ]
}
```

---

##### `getSurveysByHCP(String)` - (GET /API/surveys/{HCP})

This API endpoint will return all Surveys that a specified HCP has received from their
Patients. This endpoint will be used by the 'Satisfaction Surveys' page to allow HCPs to
view the Surveys that their patients have filled out.

Example - using the illustrated data, if we used the API endpoint to retrieve `Jess'`
Surveys, it would return:

```
Surveys: {
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '10', 'examTime': '30', 'visitRating': 'Very Satisfied', 'treatmentRating': 'Extremely Satisfied', 'comments': 'The visit and treatment went well.' ],
[ 'patientUserName': 'Mark', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '8', 'examTime': '40', 'visitRating': 'Neutral', 'treatmentRating': 'Neutral', 'comments': 'Overall, the visit and treatment were average.' ]
}
```

---

##### `getSurveysByPatient(String)` - (GET /API/surveys/{patient})

This API endpoint will return all Surveys that a specified Patient has filled out, or
needs to fill out. This endpoint will be used by the 'Satisfaction Surveys' page to
allow Patients to view the Surveys they have done, or need to do.

Example - using the illustrated data, if we used the API endpoint to retrieve `Carl's`
Surveys, it would return:

```
Surveys: {
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '10', 'examTime': '30', 'visitRating': 'Very Satisfied', 'treatmentRating': 'Extremely Satisfied', 'comments': 'The visit and treatment went well.' ],
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'false', 'waitTime': 'null', 'examTime': 'null', 'visitRating': 'null', 'treatmentRating': 'null', 'comments': 'null' ]
}
```

---

##### `submitSurvey(Survey)` - (PUT /API/surveys/{survey})

This API endpoint will submit a Survey that a Patient has just filled out. This endpoint
will be used by the 'Satisfaction Surveys' page to allow Patients to submit their
finished Surveys.

Example - using the illustrated data, if we used the API endpoint to create `Carl's`
unfinished Survey, it could return:

```
Surveys: {
[ 'patientUserName': 'Carl', 'providerUserName': 'Jess', 'completed': 'true', 'waitTime': '8', 'examTime': '42', 'visitRating': 'Neutral', 'treatmentRating': 'Neutral', 'comments': 'The visit and treatment were average overall.' ]

}
```
