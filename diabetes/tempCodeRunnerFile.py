@app.route("/predict1", methods=["POST"])
def predict_api1():
    data = request.get_json()
    prediction = predictDisease(data['Symptoms'])
    print(prediction)
    return jsonify(prediction)