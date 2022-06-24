import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix
from sklearn import metrics

df = pd.read_csv('diabetes.csv')

top_age = df.Age.value_counts().head(15)
outcome_counts = df.Outcome.value_counts()

y = df.drop(df.iloc[:, 0:-1], axis=1)
x = df.iloc[:, :-1]
x = x.drop('Pregnancies', 1)
xtrain, xtest, ytrain, ytest = train_test_split(
    x, y, test_size=0.25, random_state=7)

model = LogisticRegression()
model.fit(xtrain, ytrain)
pred1 = model.predict(xtest)
pred2 = model.predict_proba(xtest)


def level(p):
    if(p > 0 and p <= 0.4):
        return"Level = 0 No Risk"
    if(p > 0.4 and p <= 0.6):
        return "Level = 1 Normal"
    if(p > 0.6 and p <= 0.8):
        return "Level = 2 Boundary Line (Need Care)"
    if(p > 0.8 and p <= 1):
        return "Level = 3 High Risk"


print("Running File: diabetes\ml_model.py")
