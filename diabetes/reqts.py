import requests
standardURL = 'https://diabetespredicxtion.herokuapp.com/predict'
testingURL = 'http://127.0.0.1:9696/predict'
url = standardURL
r = requests.post(url, json={"Glucose": 152,
                             "BloodPressure": 90,
                             "SkinThickness": 33,
                             "Insulin": 29,
                             "BMI": 26.8,
                             "DiabetesPedigreeFunction":  0.731,
                             "Age": 43
                             })
print(r.text)
