import pickle
from flask import Flask, jsonify, request

from ml_model import level


app = Flask("Diabetes")

model = pickle.load(open('diabetes_model.pkl', 'rb'))
print('model loaded')


@app.route("/", methods=["GET"])
def ping():
    return "pong"


@app.route("/predict", methods=["POST"])
def predict_api():
    data = request.get_json()
    prediction = model.predict_proba([[data['Glucose'], data['BloodPressure'],
                                       data['SkinThickness'], data['Insulin'], data['BMI'], data['DiabetesPedigreeFunction'], data['Age']]])
    result = {"Diagnosis": str(level(prediction[0][1]))}
    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9696)
