from cgi import test
import requests
standardURL = 'https://diabetespredicxtion.herokuapp.com/predict2'
testingURL = 'http://127.0.0.1:5000/predict'
testingURL1 = 'http://127.0.0.1:9696/predict1'
testingURL2 = "http://127.0.0.1:9696/predict2"
url = standardURL
# r = requests.post(url, json={"Glucose": 152,
#                              "BloodPressure": 90,
#                              "SkinThickness": 33,
#                              "Insulin": 29,
#                              "BMI": 26.8,
#                              "DiabetesPedigreeFunction":  0.731,
#                              "Age": 43
#                              })
r = requests.post(
    url, json={"HeartDisease": 1,
               "BMI": 16.60,
               "Smoking": 0,
               "AlcoholDrinking": 0,
               "Stroke": 0,
               "PhysicalHealth": 3.0,
               "MentalHealth": 30.0,
               "DiffWalking": 0,
               "Sex": 0,
               "AgeCategory": 4,
               "Diabetic": 0,
               "PhysicalActivity": 1,
               "GenHealth": 2,
               "Race": "White",
               "SleepTime": 5.0,
               "Asthma": 0,
               "KidneyDisease": 0,
               "SkinCancer": 1, })
print(r.text)
