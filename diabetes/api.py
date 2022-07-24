from flask import Flask, request
from flask_restful import Api, Resource
import numpy as np
import pickle
from sklearn.preprocessing import StandardScaler

model = pickle.load(open('diabetes/diabetes_model.pkl', 'rb'))
print('model loaded')


class Records(Resource):
    def get(self):
        # get request that returns the JSON format for API request
        return {"JSON data format": {"Pregnancies": 5,
                                     "Glucose": 32,
                                     "BloodPressure": 43,
                                     "SkinThickness": 23,
                                     "Insulin": 22,
                                     "BMI": 54,
                                     "DiabetesPedigreeFunction":  43,
                                     "Age": 50
                                     }
                }, 200


def post(self):
    # post request
    # make model and X_train global variables
    global model
    global X_train
    # it gets patient's record and returns the ML model's prediction
    data = request.get_json()

    try:
        pregnancies = int(data["Pregnancies"])
        glucose = int(data["Glucose"])
        bp = int(data["BloodPressure"])
        st = int(data["SkinThickness"])
        insulin = int(data["Insulin"])
        bmi = float(data["BMI"])
        dpf = float(data["DiabetesPedigreeFunction"])
        age = int(data["Age"])

        # model expects a 2D array
        new_record = [[pregnancies, glucose, bp, st, insulin, bmi, dpf, age]]
        # feature scale the data
        # dictionary containing the diagnosis with the key as the model's prediction
        diagnosis = {0: 'Your Result is Normal',
                     1: 'Diabetes Detected'
                     }
        # pass scaled data to model for prediction
        new_pred = model.predict(new_record)[0]
        # get corresponding value from the diagnosis dictionary (using the model prediction as the key)
        result = diagnosis.get(new_pred)
        return {'Diagnosis': result}, 200
    except:
        # if client sends the wrong request or data type then return correct format
        return {'Error! Please use this JSON format': {"Pregnancies": 5,
                                                       "Glucose": 32,
                                                       "BloodPressure": 43,
                                                       "SkinThickness": 23,
                                                       "Insulin": 22,
                                                       "BMI": 33.6,
                                                       "DiabetesPedigreeFunction":  1.332,
                                                       "Age": 50
                                                       }}, 500


# instantiate Flask Rest Api
app = Flask(__name__)
api = Api(app)
api.add_resource(Records, '/')
app.run(port=5000, debug=True)
