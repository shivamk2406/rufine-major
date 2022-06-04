from cgi import test
import requests
standardURL = 'https://diabetespredicxtion.herokuapp.com/predict1'
testingURL = 'http://127.0.0.1:5000/predict'
testingURL1 = 'http://127.0.0.1:9696/predict1'
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
    url, json={"Symptoms": "Loss Of Balance,Unsteadiness,Weakness Of One Body Side"})
print(r.text)
