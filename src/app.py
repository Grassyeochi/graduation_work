from flask import Flask, request, jsonify, url_for
import json
from keras.models import load_model
from keras.preprocessing import image
import numpy as np
import os
import pymysql


app = Flask(__name__)

# 모델 로드
model_path = '../model/newBuilding_model.h5'
model = load_model(model_path)

#db 정보
connection = {
    'host' : 'inu-db.cvu6qqeoay36.ap-northeast-2.rds.amazonaws.com',  # 호스트
    'user' : 'admin',   # 사용자 이름
    'password' : 'adminpassword',  # 비밀번호
    'database' : 'inu_building_db',  # 데이터베이스 이름
    'charset' : 'utf8'
}

class_mapping = {'0': '1', '1': '6', '2': '7'}

# 이미지 저장 디렉토리
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# 이미지 전처리 함수
def preprocess_image(img):
    img = img.resize((150, 150))  # 이미지 크기 조정
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array /= 255.0
    return img_array

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})

    file = request.files['file']

    if file.filename == '':
        return jsonify({'error': 'No selected file'})

    if file:
        # 이미지 저장
        filename = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(filename)

        # 이미지 전처리
        img = image.load_img(filename)
        img_array = preprocess_image(img)

        # 모델 예측
        result = model.predict(img_array)

        predicted_class = class_mapping[str(np.argmax(result))]

        if(max(float(result[0][0]), float(result[0][1]), float(result[0][2])) <= 0.5):
            # 에러. 판독할 수 없는 사진
            response_data = {"error"}

            response_json = json.dumps(response_data, ensure_ascii=False)

            # Response 객체 생성
            response = app.response_class(
                response=response_json,
                status=200,
                mimetype='application/json'
            )

            return response

        db = pymysql.connect(**connection)
        # 데이터에 접근
        cursor = db.cursor()

        # SQL query 실행
        cursor.execute("select name, description from building_info where id = {0}".format(int(predicted_class)))
        building_data = cursor.fetchone()

        cursor.execute("select num, name from building_info_detail_{0}".format(int(predicted_class)))

        building_data_detail = {}

        while (True):
            i = cursor.fetchone()
            if (i == None):
                break
            building_data_detail[i[0]] = i[1]

        if (int(predicted_class) == 7):
            cursor.execute("select name from building_info_detail_major_7")
            building_data_detail_major = []
            while (True):
                i = cursor.fetchone()
                if (i == None):
                    break
                building_data_detail_major.append(i)

        # 예측 결과 및 확률을 JSON 형태로 반환
        response_data = {
            'predicted_class': predicted_class,
            'class_probabilities': {
                class_mapping['0']: float(result[0][0]),
                class_mapping['1']: float(result[0][1]),
                class_mapping['2']: float(result[0][2])
            },
            'building_name': building_data[0],
            'building_description': building_data[1],
            'building_data_detail': building_data_detail
        }
        if (int(predicted_class) == 7):
            response_data['building_data_major'] = building_data_detail_major

        db.close()

        response_json = json.dumps(response_data, ensure_ascii=False)

        # Response 객체 생성
        response = app.response_class(
            response=response_json,
            status=200,
            mimetype='application/json'
        )

        return response

@app.route('/upload', methods=['GET','POST'])
def upload():
    test_image_path = ('../test/6_9.jpg')
    img = image.load_img(test_image_path)
    img_array = preprocess_image(img)
    result = model.predict(img_array)

    predicted_class = class_mapping[str(np.argmax(result))]

    if (max(float(result[0][0]), float(result[0][1]), float(result[0][2])) <= 0.5):
        # 에러. 판독할 수 없는 사진
        response_data = {"error"}

        response_json = json.dumps(response_data, ensure_ascii=False)

        # Response 객체 생성
        response = app.response_class(
            response=response_json,
            status=200,
            mimetype='application/json'
        )

        return response

    db = pymysql.connect(**connection)

    # 데이터에 접근
    cursor = db.cursor()

    # SQL query 실행
    cursor.execute("select name, description from building_info where id = {0}".format(int(predicted_class)))
    building_data = cursor.fetchone()

    cursor.execute("select num, description from building_info_detail_short_{0}".format(int(predicted_class)))

    building_data_detail = {}

    while(True):
        i = cursor.fetchone()
        if (i == None):
            break
        building_data_detail[i[0]] = i[1]

    if (int(predicted_class) == 7):
        cursor.execute("select name from building_info_detail_major_7")
        building_data_detail_major = []
        while(True):
            i = cursor.fetchone()
            if(i == None):
                break
            building_data_detail_major.append(i)

    image_path = url_for("static", filename = "../test/6_9.jpg")

    response_data = {
        'predicted_class': predicted_class,
        'class_probabilities': {
            class_mapping['0']: float(result[0][0]),
            class_mapping['1']: float(result[0][1]),
            class_mapping['2']: float(result[0][2])
        },
        'building_name' : building_data[0],
        'building_description' : building_data[1],
        'building_data_detail' : building_data_detail,
        'image_path' : image_path
    }
    if (int(predicted_class) == 7):
        response_data['building_data_major'] = building_data_detail_major

    db.close()

    response_json = json.dumps(response_data, ensure_ascii=False)

    # Response 객체 생성
    response = app.response_class(
        response=response_json,
        status=200,
        mimetype='application/json'
    )

    return response

if __name__ == '__main__':
    app.run(host = "0.0.0.0", port = "5000", debug=True)
