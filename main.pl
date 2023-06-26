% List of potential virus symptoms
symptoms([
    fever, 
    persistent_dry_cough, 
    tiredness, 
    aches_and_pains, 
    sore_throat, 
    diarrhoea, 
    conjunctivitis, 
    headache, 
    anosmia, 
    hyposmia, 
    running_nose, 
    difficulty_breathing, 
    chest_pain, 
    chest_pressure, 
    loss_of_speech, 
    loss_of_movement
]).

% Biodata of patients
patient(john, 35, male, [no_condition], no_medication).
patient(jane, 55, female, [diabetes, copd], immunosuppressant).
patient(mike, 50, male, [hypertension], no_medication).
patient(emma, 25, female, [asthma], no_medication).
patient(sarah, 70, female, [cancer, hypertension, diabetes], immunosuppressant).
patient(bob, 80, male, [cardiovascular_disease, hypertension], no_medication).
patient(alice, 40, female, [hypertension, diabetes], immunosuppressant).
patient(charles, 60, male, [asthma, hypertension], no_medication).
patient(lucy, 75, female, [no_condition], no_medication).
patient(tom, 45, male, [no_condition], no_medication).

% History of patients in the last few days
recent_history(john, [contact_with_infected, travel_abroad]).
recent_history(jane, [travel_abroad]).
recent_history(mike, [contact_with_infected]).
recent_history(emma, []).
recent_history(sarah, [contact_with_infected]).
recent_history(bob, [travel_abroad]).
recent_history(alice, [contact_with_infected]).
recent_history(charles, []).
recent_history(lucy, [contact_with_infected]).
recent_history(tom, []).

% List of symptoms for each patient
patient_symptoms(john, [fever, persistent_dry_cough]).
patient_symptoms(jane, [fever, persistent_dry_cough, tiredness, anosmia]).
patient_symptoms(mike, [fever, persistent_dry_cough, tiredness, aches_and_pains, sore_throat]).
patient_symptoms(emma, [fever, persistent_dry_cough, diarrhoea]).
patient_symptoms(sarah, [persistent_dry_cough, tiredness, headache, hyposmia]).
patient_symptoms(bob, [fever, tiredness, running_nose, chest_pressure]).
patient_symptoms(alice, [persistent_dry_cough, diarrhoea, loss_of_speech]).
patient_symptoms(charles, [fever, persistent_dry_cough, tiredness, difficulty_breathing]).
patient_symptoms(lucy, [persistent_dry_cough, tiredness, chest_pain]).
patient_symptoms(tom, [fever]).

% Rule to check if a patient has a specific symptom
has_symptom(Patient, Symptom) :-
    patient_symptoms(Patient, Symptoms),
    symptoms(PotentialSymptoms),
    member(Symptom, Symptoms),
    member(Symptom, PotentialSymptoms).

% Rule to determine if a person is of high risk based on age, gender, and pre-existing condition
is_high_risk(Patient) :-
    patient(Patient, Age, _, Conditions, Medication),
    length(Conditions, NumConditions),
    (   Age > 65 ;
    	NumConditions >= 3 ;
        Medication = immunosuppressant
    ).


% Rule to consider recent history
has_risky_history(Patient) :-
    recent_history(Patient, History),
    (   member(contact_with_infected, History) ;
        member(travel_abroad, History)
    ).

% Rule to determine if a person potentially has the virus
has_potential_infection(Patient) :-
    findall(Symptom, (member(Symptom, [fever, persistent_dry_cough, tiredness, aches_and_pains, sore_throat, diarrhoea, conjunctivitis, headache, anosmia, hyposmia, running_nose, difficulty_breathing, chest_pain, chest_pressure, loss_of_speech, loss_of_movement]), has_symptom(Patient, Symptom)), Symptoms),
    length(Symptoms, NumSymptoms),
    NumSymptoms >= 5,
    (is_high_risk(Patient) ; has_risky_history(Patient)).

