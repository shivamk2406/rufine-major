from statistics import mode
import numpy as np
import pandas as pd
import pickle
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

model1 = pickle.load(open('final_nb_model.pkl', 'rb'))
model2 = pickle.load(open('final_svm_model.pkl', 'rb'))
model3 = pickle.load(open('final_rf_model.pkl', 'rb'))

DATA_PATH = "datasets/Training.csv"
data = pd.read_csv(DATA_PATH).dropna(axis=1)
encoder = LabelEncoder()
data["prognosis"] = encoder.fit_transform(data["prognosis"])
X = data.iloc[:, :-1]
y = data.iloc[:, -1]
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=24)

X = data.iloc[:, :-1]
symptoms = X.columns.values

# Creating a symptom index dictionary to encode the
# input symptoms into numerical form
symptom_index = {}
for index, value in enumerate(symptoms):
    symptom = " ".join([i.capitalize() for i in value.split("_")])
    symptom_index[symptom] = index


data_dict = {
    "symptom_index": symptom_index,
    "predictions_classes": encoder.classes_
}

print(symptom_index.keys())


def predictDisease(symptoms):
    symptoms = symptoms.split(",")

    # creating input data for the models
    input_data = [0] * len(data_dict["symptom_index"])
    for symptom in symptoms:
        index = data_dict["symptom_index"][symptom]
        input_data[index] = 1

    # reshaping the input data and converting it
    # into suitable format for model predictions
    input_data = np.array(input_data).reshape(1, -1)

    # generating individual outputs
    rf_prediction = data_dict["predictions_classes"][model1.predict(input_data)[
        0]]
    nb_prediction = data_dict["predictions_classes"][model2.predict(input_data)[
        0]]
    svm_prediction = data_dict["predictions_classes"][model3.predict(input_data)[
        0]]
    final_prediction = mode(
        [rf_prediction, nb_prediction, svm_prediction])[0][0]
    predictions = {
        "rf_model_prediction": rf_prediction,
        "naive_bayes_prediction": nb_prediction,
        "svm_model_prediction": nb_prediction,
        "final_prediction": final_prediction
    }
    return predictions


print(predictDisease("Itching,Skin Rash,Nodal Skin Eruptions"))
