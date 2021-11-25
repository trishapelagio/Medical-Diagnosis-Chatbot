/*
Apollo Chatbot Expert System

Submitted by :
Marcelo, Jan Uriel A.
Pelagio, Trisha Gail P.
Ramirez, Bryce Anthony V.
Sison, Danielle Kirsten T.

*/

startdiagnose:- write('Hello, my name is Doc Apollo'), % The function serves as the preliminary process for introducing the bot and asking the patient name
  nl,
  write('What is your name ? '), nl,
  read(Patient), nl, write('Hello '), write(Patient).


% Disease Inquiry
% Provides the program portion for queries regarding various smptoms
ask(Symptom) :- have(Symptom, true), !.
ask(Symptom) :- have(Symptom, false), !, fail.
ask(Symptom) :- nl, write('Do you have '), write(Symptom), write('? (y or n)'), nl,
                read(Response), !, ((Response = 'y', assertz(have(Symptom, true))); (assertz(have(Symptom,false)), fail)).


% Symptom Identification
% The three variations of asks would determine if the sypmtom should be asked or if it is already true or false in the knowledge base.
asks(Symptoms) :- haves(Symptoms, true), !.
asks(Symptoms) :- haves(Symptoms, false), !, fail.
asks(Symptoms) :- nl, write('Do you have '), write(Symptoms), write('? (y or n)'), nl,
                read(Response), !, ((Response = 'y', assertz(haves(Symptoms, true))); (assertz(haves(Symptoms,false)), fail)).

diagnosesymptom :- nl, write('Symptom Diagnosis On-Going.'), nl, (symptomz(symptoms, Symptom), write('You have : '), write(Symptom); true), nl, (Symptom='nausea' -> ! ; fail).

% Disease Analysis
diagnose :- nl, write('Disease Diagnosis On-Going.'), nl, setof(Disease,illness(symptom, Disease), Result),
  write('That disease could be : '), write(Result).
% If there are no ilnesses that could be derived from the diagnosis
diagnose :- nl, write('We cannot diagnose this.').

% Chatbot start. After each diagnosis, the patient responses are retracted and abolished
start:- startdiagnose, abolish(have/2), abolish(haves/2), dynamic(have/2), retractall(have/2),abolish(haves/2), dynamic(haves/2), retractall(haves/2), diagnosesymptom, diagnose, nl,nl,
        write('Bye! Thanks for using this system'), abolish(have,2), abolish(haves,2).

symptoms(Patient, Symptom) :- asks(Symptom).

symptom(Patient, Symptom) :- ask(Symptom).

% Rules for symptoms that could be derived from other symptoms
symptomz(Patient, dehydration):-
  symptoms(Patient, less_frequent_urination),
  symptoms(Patient, extreme_thirst),
  symptoms(Patient, dry_mouth),
  symptoms(Patient, dry_skin),
  symptoms(Patient, dizziness).

symptomz(Patient, fever) :-
  symptoms(Patient, body_temp_greater378),
  symptoms(Patient, chills),
  symptoms(Patient, sweats),
  symptoms(Patient, flushing),
  symptoms(Patient, feeling_warm).

symptomz(Patient, malaise) :-
  symptoms(Patient, fatigue).

symptomz(Patient, nausea) :-
  symptoms(Patient, vomiting),
  symptomz(Patient, fever),
  symptoms(Patient, dizziness).

% Rules for ilnesses that could be derived from other illnesses or symptoms
illness(Patient, tuberculosis_100) :-
  symptom(Patient, coughing_blood),
  symptom(Patient, coughing_mucus),
  symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_70) :-
  \+ symptom(Patient, coughing_blood),
  symptom(Patient, coughing_mucus),
  symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_80) :-
  symptom(Patient, coughing_blood),
  \+ symptom(Patient, coughing_mucus),
  symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_75) :-
  symptom(Patient, coughing_blood),
  symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_60) :-
  \+ symptom(Patient, coughing_blood),
  \+ symptom(Patient, coughing_mucus),
  symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_70) :-
  symptom(Patient, coughing_blood),
  \+ symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_60) :-
  \+ symptom(Patient, coughing_blood),
  symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, tuberculosis_55) :-
  \+ symptom(Patient, coughing_blood),
  \+ symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_pain),
  symptomz(Patient, fever),
  symptoms(Patient, fatigue),
  symptom(Patient, appetite_loss),
  symptom(Patient, weight_loss),
  symptoms(Patient, chills),
  symptom(Patient, night_sweats).

illness(Patient, osteoarthritis_100) :-
  symptom(Patient, joint_pain),
  symptom(Patient, joint_stiffness),
  symptom(Patient, joint_swelling),
  symptom(Patient, joint_tenderness),
  symptom(Patient, joint_clicking_noise),
  symptom(Patient, joint_impairment).

illness(Patient, asthma_100) :-
  symptom(Patient, coughing),
  symptom(Patient, chest_tightness),
  symptom(Patient, wheezing),
  symptom(Patient, coughing_mucus).

illness(Patient, diabetes_100) :-
  symptom(Patient, extreme_hunger),
  symptoms(Patient, extreme_thirst),
  symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_75) :-
  \+ symptom(Patient, extreme_hunger),
  symptoms(Patient, extreme_thirst),
  symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_75) :-
  symptom(Patient, extreme_hunger),
  \+ symptoms(Patient, extreme_thirst),
  symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_90) :-
  symptom(Patient, extreme_hunger),
  symptoms(Patient, extreme_thirst),
  \+ symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_50) :-
  \+ symptom(Patient, extreme_hunger),
  \+ symptoms(Patient, extreme_thirst),
  symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_65) :-
  symptom(Patient, extreme_hunger),
  \+ symptoms(Patient, extreme_thirst),
  \+ symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_65) :-
  \+ symptom(Patient, extreme_hunger),
  symptoms(Patient, extreme_thirst),
  \+ symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diabetes_40) :-
  \+ symptom(Patient, extreme_hunger),
  \+ symptoms(Patient, extreme_thirst),
  \+ symptom(Patient, frequent_urination),
  symptom(Patient, weight_loss),
  (symptoms(Patient, fatigue); symptom(Patient, drowsiness)),
  symptom(Patient, blurry_vision),
  symptom(Patient, slow_healing),
  symptoms(Patient, dry_skin),
  symptom(Patient, itchy_skin),
  (symptom(Patient, hand_tingling); symptom(Patient, hand_numbness); symptom(Patient, feet_tingling); symptom(Patient, feet_numbness)),
  (symptom(Patient, skin_infection); symptom(Patient, gum_infection); symptom(Patient, bladder_infection); symptom(Patient, vaginal_yeast_infection)).

illness(Patient, diarrhea_100) :-
  symptom(Patient, blood_in_stool),
  symptomz(Patient, dehydration),
  symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_70) :-
  \+ symptom(Patient, blood_in_stool),
  symptomz(Patient, dehydration),
  symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_80) :-
  symptom(Patient, blood_in_stool),
  \+ symptomz(Patient, dehydration),
  symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_85) :-
  symptom(Patient, blood_in_stool),
  symptomz(Patient, dehydration),
  \+ symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_50) :-
  \+ symptom(Patient, blood_in_stool),
  \+ symptomz(Patient, dehydration),
  symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_65) :-
  symptom(Patient, blood_in_stool),
  \+ symptomz(Patient, dehydration),
  \+ symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_55) :-
  \+ symptom(Patient, blood_in_stool),
  symptomz(Patient, dehydration),
  \+ symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, diarrhea_35) :-
  \+ symptom(Patient, blood_in_stool),
  \+ symptomz(Patient, dehydration),
  \+ symptom(Patient, weight_loss),
  symptomz(Patient, fever),
  symptom(Patient, joint_pain),
  symptom(Patient, abdominal_pain).

illness(Patient, helminthiasis_100) :-
  illness(Patient, diarrhea_100),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_85) :-
  illness(Patient, diarrhea_85),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_80) :-
  illness(Patient, diarrhea_80),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_70) :-
  illness(Patient, diarrhea_70),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_65) :-
  illness(Patient, diarrhea_65),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_55) :-
  illness(Patient, diarrhea_55),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_50) :-
  illness(Patient, diarrhea_50),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, helminthiasis_35) :-
  illness(Patient, diarrhea_35),
  symptom(Patient, abdominal_pain),
  symptomz(Patient, malaise),
  symptom(Patient, weakness),
  symptom(Patient, cognitive_development_impairment),
  symptom(Patient, physical_development_impairment).

illness(Patient, hypothyroidism_100) :-
  symptom(Patient, cold_intolerance),
  symptom(Patient, weight_gain),
  symptom(Patient, hypothermia),
  symptom(Patient, forgetfulness),
  symptom(Patient, personality_changes),
  symptom(Patient, facial_puffness),
  symptom(Patient, sparse_hair),
  symptom(Patient, coarse_hair),
  symptom(Patient, dry_hair),
  symptoms(Patient, dry_skin),
  symptom(Patient, scaly_skin),
  symptom(Patient, constipation),
  symptom(Patient, slow_heart_rate),
  symptom(Patient, coarse_voice).

illness(Patient, hypothyroidism_85) :-
  symptom(Patient, cold_intolerance),
  symptom(Patient, weight_gain),
  \+ symptom(Patient, hypothermia),
  symptom(Patient, forgetfulness),
  symptom(Patient, personality_changes),
  symptom(Patient, facial_puffness),
  symptom(Patient, sparse_hair),
  symptom(Patient, coarse_hair),
  symptom(Patient, dry_hair),
  symptoms(Patient, dry_skin),
  symptom(Patient, scaly_skin),
  symptom(Patient, constipation),
  symptom(Patient, slow_heart_rate),
  symptom(Patient, coarse_voice).

illness(Patient, glaucoma_100) :-
  symptom(Patient, lose_peripheral_vision),
  symptom(Patient, gradually_decreasing_vision),
  symptom(Patient, red_eyes),
  symptom(Patient, painful_eyes),
  symptomz(Patient, nausea),
  symptoms(Patient, vomiting),
  symptom(Patient, blurred_vision).

illness(Patient, emphysema_100) :-
  symptom(Patient, coughing_mucus),
  symptom(Patient, chest_tightness),
  symptom(Patient, short_breath),
  symptom(Patient, smoking_history).

illness(Patient, emphysema_60) :-
  symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_tightness),
  symptom(Patient, short_breath),
  symptom(Patient, smoking_history).

illness(Patient, emphysema_60) :-
  symptom(Patient, coughing_mucus),
  symptom(Patient, chest_tightness),
  \+ symptom(Patient, short_breath),
  symptom(Patient, smoking_history).

illness(Patient, emphysema_20) :-
  symptom(Patient, coughing_mucus),
  \+ symptom(Patient, chest_tightness),
  \+ symptom(Patient, short_breath),
  symptom(Patient, smoking_history).

illness(Patient, dengue_100) :-
  symptomz(Patient, fever),
  symptoms(Patient, body_temp_greater40),
  symptom(Patient, headache),
  symptom(Patient, retroorbital_pain),
  symptom(Patient, back_pain),
  symptom(Patient, severe_prostation),
  symptom(Patient, joint_pain),
  symptom(Patient, pharyngitis),
  symptomz(Patient, nausea).

illness(Patient, dengue_50) :-
  \+ symptomz(Patient, fever),
  symptom(Patient, headache),
  symptom(Patient, retroorbital_pain),
  symptom(Patient, back_pain),
  symptom(Patient, severe_prostation),
  symptom(Patient, joint_pain),
  symptoms(Patient, body_temp_greater40),
  symptom(Patient, pharyngitis),
  symptomz(Patient, nausea).

illness(Patient, dengue_70) :-
  symptomz(Patient, fever),
  symptom(Patient, headache),
  symptom(Patient, retroorbital_pain),
  symptom(Patient, back_pain),
  symptom(Patient, severe_prostation),
  symptom(Patient, joint_pain),
  \+ symptoms(Patient, body_temp_greater40),
  symptom(Patient, pharyngitis),
  symptomz(Patient, nausea).

illness(Patient, dengue_20) :-
  \+ symptomz(Patient, fever),
  symptom(Patient, headache),
  symptom(Patient, retroorbital_pain),
  symptom(Patient, back_pain),
  symptom(Patient, severe_prostation),
  symptom(Patient, joint_pain),
  \+ symptoms(Patient, body_temp_greater40),
  symptom(Patient, pharyngitis),
  symptomz(Patient, nausea).

illness(Patient, osteoporosis_100) :-
  (symptom(Patient, frequent_broken_bone); symptom(Patient, frequent_fracture)),
  symptom(Patient, back_pain),
  symptom(Patient, hunched_back),
  symptom(Patient, short_breath).

illness(Patient, osteoporosis_85) :-
  (symptom(Patient, frequent_broken_bone); symptom(Patient, frequent_fracture)),
  symptom(Patient, back_pain),
  symptom(Patient, hunched_back),
  \+ symptom(Patient, short_breath).

illness(Patient, leptospirosis_100) :-
  symptom(Patient, headache),
  symptom(Patient, muscular_ache),
  symptomz(Patient, fever),
  symptom(Patient, coughing),
  symptom(Patient, pharyngitis),
  symptom(Patient, chest_pain),
  symptom(Patient, coughing_blood),
  symptom(Patient, conjunctival_stuffusion).

illness(Patient, leptospirosis_80) :-
  symptom(Patient, headache),
  symptom(Patient, muscular_ache),
  symptomz(Patient, fever),
  symptom(Patient, coughing),
  symptom(Patient, pharyngitis),
  \+ symptom(Patient, chest_pain),
  symptom(Patient, coughing_blood),
  symptom(Patient, conjunctival_stuffusion).

illness(Patient, acne_vulgaris_100) :-
  symptom(Patient, skin_lesions),
  symptom(Patient, skin_scarring),
  symptom(Patient, development_nodules),
  symptom(Patient, coughing_cysts),
  symptom(Patient, comendones),
  (symptom(Patient, papules); symptom(Patient, pustules)).

illness(Patient, amoebiasis_100) :-
  illness(Patient, diarrhea_100),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_85) :-
  illness(Patient, diarrhea_85),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_80) :-
  illness(Patient, diarrhea_80),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_70) :-
  illness(Patient, diarrhea_70),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_65) :-
  illness(Patient, diarrhea_65),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_55) :-
  illness(Patient, diarrhea_55),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_50) :-
  illness(Patient, diarrhea_50),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).

illness(Patient, amoebiasis_35) :-
  illness(Patient, diarrhea_35),
  symptom(Patient, constipation),
  symptom(Patient, flatulence),
  symptom(Patient, abdominal_pain).
