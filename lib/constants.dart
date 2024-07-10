import 'package:flutter/material.dart';

const mainAccent = Color(0xFFED6A5A);

const secondaryAccent = Color(0xFF00A5CF);

const tertiaryAccent = Color(0xFF25A18E);

const darkColor = Color(0xFF292929);

const lightColor = Color(0xFFFFFFFF);

/// Symptom Lists
const Map<String, int> diabetesSymptomList = {
  "Pregnancies (Amount)": 2,
  "Glucose (mmol/L)": 1,
  "Blood Pressure (mmHg)": 1,
  "Insulin (Units)": 1,
  "BMI": 1,
  "Age (Years)": 1
};
const Map<String, int> cancerSymptomList = {
  "Male(1) Female(2)": 2,
  "Age (Years)": 1,
  "Smoking Yes(2) No(1)": 2,
  "Jaundiced Fingers Yes(2) No(1)": 2,
  "Anxiety Yes(2) No(1)": 2,
  "Peer Pressure Yes(2) No(1)": 2,
  "Chronic Disease Yes(2) No(1)": 2,
  "Fatigue Yes(2) No(1)": 2,
  "Allergy Yes(2) No(1)": 2,
  "Wheezing Yes(2) No(1)": 2,
  "Alcohol Consumption Yes(2) No(1)": 2,
  "Coughing Yes(2) No(1)": 2,
  "Shortness of Breath Yes(2) No(1)": 2,
  "Difficulty Swallowing Yes(2) No(1)": 2,
  "Chest Pain Yes(2) No(1)": 2
};
const Map<String, int> heartSymptomList = {
  "Age (in Years)": 1,
  "Sex Male(1) Female(0)": 1,
  "Chest Pain Type TA(0) AA(1) N-AP(2) A(3)": 2,
  "Resting BP (mmHg)": 1,
  "Cholesterol (mg/dl)": 1,
  "Fasted Blood Sugar [ > 120 mg/dl ] (1 = true; 0 = false)": 1,
  "Resting ECG Normal(0) ST-T(1) V Hypertrophy (2)": 1,
  "Max HR": 1,
  "Exang Yes(1) No(0)": 1,
  "Old Peak (ST Depression)": 1,
  "Slope Up(0) Flat(1) Down(2)": 1,
  "Num of Major Vessels (Fluoroscopy) (0-3)": 1,
  "Thal Normal(0) Fixed(1) Reversible (2)": 1,
};
