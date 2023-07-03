% List of potential virus symptoms
symptoms([
    fever, 
    persistent_dry_cough, 
    tiredness, 
    aches_and_pains, 
    sore_throat, 
    diarrhea, 
    headache, 
    anosmia, 
    hyposmia,  
    difficulty_breathing, 
    chest_pain, 
    chest_pressure
]).

% Biodata of patients
patient(john, 25, male, [no_condition], [no_medication]).
patient(jane, 30, female, [diabetes], [insulin]).
patient(mike, 35, male, [crohns], [immunosuppressant]).
patient(emma, 40, female, [no_condition], [no_medication]).
patient(sarah, 45, female, [cancer], [chemotherapy]).
patient(bob, 50, male, [cardiovascular_disease, hypertension], [blood_thinner]).
patient(alice, 55, female, [hypertension, diabetes], [insulin]).
patient(charles, 60, male, [asthma, hypertension], [asthma_inhaler]).
patient(lucy, 65, female, [no_condition], [no_medication]).
patient(tom, 70, male, [rheumatoid_arthritis], [immunosuppressant]).
patient(adam, 75, male, [no_condition], [no_medication]).


% History of patients in the last few days
recent_history(john, [contact_with_infected, travel_abroad]).
recent_history(jane, [travel_abroad]).
recent_history(mike, [contact_with_infected]).
recent_history(emma, []).
recent_history(sarah, []).
recent_history(bob, []).
recent_history(alice, [contact_with_infected]).
recent_history(charles, []).
recent_history(lucy, []).
recent_history(tom, []).
recent_history(adam, []).

% List of symptoms for each patient
patient_symptoms(john, [fever, persistent_dry_cough]).
patient_symptoms(jane, [fever, persistent_dry_cough, tiredness, anosmia]).
patient_symptoms(mike, [tiredness, aches_and_pains]).
patient_symptoms(emma, [fever, persistent_dry_cough]).
patient_symptoms(sarah, [tiredness]).
patient_symptoms(bob, [fever, tiredness, running_nose, chest_pressure]).
patient_symptoms(alice, [persistent_dry_cough, loss_of_speech]).
patient_symptoms(charles, [fever, persistent_dry_cough, difficulty_breathing]).
patient_symptoms(lucy, [persistent_dry_cough, tiredness]).
patient_symptoms(tom, []).
patient_symptoms(adam, []).


% Rule to determine if a person is of high risk based on age, pre-existing condition
is_high_risk(Patient) :-
    patient(Patient, Age, _, Conditions, _),
    (Age >= 70; member(cancer, Conditions)).

% Rule to check if a person is taking immunosuppressant medication
takes_immunosuppressant(Patient) :-
    patient(Patient, _, _, _, Medications),
    member(immunosuppressant, Medications).

% Rule to consider recent history
has_risky_history(Patient) :-
    recent_history(Patient, History),
    (member(contact_with_infected, History) ; member(travel_abroad, History)).

% Rule to determine if a person potentially has the virus
has_potential_infection(Patient) :-
    patient_symptoms(Patient, PatientSymptoms),
    symptoms(PotentialSymptoms),
    intersection(PatientSymptoms, PotentialSymptoms, ActualSymptoms),
    length(ActualSymptoms, NumSymptoms),
    (is_high_risk(Patient) ; takes_immunosuppressant(Patient) ; has_risky_history(Patient) ; NumSymptoms >= 4).
