import numpy as np
import pandas as pd
from time import time
import pickle
from perceptron import Perceptron

# 데이터 전처리
def step1_get_data():
    # iris.data 파일 읽어오기
    df = pd.read_csv("./3. irisPerceptron/iris.data", header = None)
    # print(df.shape)
    # 꽃잎 데이터를 추출
    X = df.iloc[:100, [2, 3]].values
    # print(X)
    # 꽃 종류 데이터를 추출
    y = df.iloc[:100, [4]].values
    y = np.where(y == 'Iris-setosa',1,-1)
    # print(y)
    return X, y


# 학습
def step2_learning():
    ppn = Perceptron(eta = 0.1)
    data = step1_get_data()
    X = data[0]
    y = data[1]
    # 학습
    ppn.fit(X, y)
    print(ppn.errors_)
    print(ppn.w_)
    # 학습된 모델을 저장
    with open('./3. irisPerceptron/perceptron.pickle', 'wb') as fp:
        pickle.dump(ppn, fp)
    print('학습완료')

# 예측
def step3_using():
    with open('./3. irisPerceptron/perceptron.pickle','rb') as fp:
        ppn = pickle.load(fp)
    while True : 
        a1 = input('길이를 입력해주세요 : ')
        a2 = input('넓이를 입력해주세요 : ')
        X = np.array([float(a1), float(a2)])
        result = ppn.predict(X)
        if result == 1:
            print('결과 : Iris-setosa')
        else :
            print('결과 : Iris-versicolor') 


# step1_get_data()
# step2_learning()
step3_using()