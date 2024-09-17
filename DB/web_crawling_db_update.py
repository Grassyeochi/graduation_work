from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import os
import re
import pymysql
import time

# MySQL 연결 설정
connection = pymysql.connect(
    host='inu-db.cvu6qqeoay36.ap-northeast-2.rds.amazonaws.com',  # 호스트
    user='admin',   # 사용자 이름
    password='adminpassword',  # 비밀번호
    database='inu_building_db'  # 데이터베이스 이름
)

building_dict = {   1 : "대학본부",
                    2 : "교수회관",
                    3 : "INU CUBE",
                    4 : "정보전산원 (BM컨텐츠관)",
                    5 : "자연과학",
                    6 : "학산도서관 (이룸관)",
                    7 : "정보기술대학",
                    8 : "공과대학",
                    9 : "공동실험실습관",
                    10 : "게스트하우스",
                    11 : "복지회관 (학생식당)",
                    12 : "컨밴션센터",
                    13 : "사회과학",
                    14 : "경영",
                    15 : "인문대학",
                    16 : "예술체육대학",
                    17 : "학생회관",
                    18 : "제1기숙사",
                    #18-2 : "제2기숙사",
                    #18-3 : "제3기숙사",
                    19 : "산학협력단",
                    20 : "스포츠센터 골프연습장",
                    21 : "체육관",
                    22 : "학군단",
                    23 : "강당",
                    24 : "전망타워",
                    25 : "어린이집",
                    26 : "온실",
                    27 : "제2공동실습관",
                    28 : "도시과학대학",
                    29 : "생명공학부",
                    30 : "팝업스토어"
                    }

for i in range(1, 30):
    print("{0}호관 데이터를 크롤링 합니다.".format(i))
    building_dict_select_num = i
    time.sleep(1)

    # Selenium을 사용하여 웹 드라이버를 초기화
    driver = webdriver.Chrome()

    # 웹 페이지로 이동
    driver.get("https://www.inu.ac.kr/inu/739/subview.do#this")

    # 버튼을 찾아 클릭
    button = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, "//ul[@class='left-list']//a[contains(text(), '{0}')]".format(building_dict_select_num)))
    )
    button.click()

    # 페이지가 로드될 때까지 기다림 (최대 10초)
    WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, "detailView")))

    # 새로고침된 페이지의 HTML 가져오기
    new_page_source = driver.page_source

    # BeautifulSoup을 사용하여 새로고침된 페이지의 HTML 파싱
    soup = BeautifulSoup(new_page_source, 'html.parser')

    # 원하는 정보가 있는 태그를 찾음
    target_tag = soup.find('div', class_='detail-plant')

    # 정보가 있는 태그에서 원하는 데이터를 추출
    if target_tag:
        # 원하는 데이터를 추출하는 방법에 따라서 적절한 코드를 작성
        dl_tags = target_tag.find_all('dl')
        if dl_tags:
            if os.path.exists("output.txt"):
                with open("output.txt", "r", encoding="utf-8") as file:
                    content = file.read().strip()

                # 내용이 있는 경우 삭제
                if content:
                    with open("output.txt", "w", encoding="utf-8") as file:
                        file.write("")

                with open("output.txt", "w", encoding="utf-8") as file:
                    for index, dl_tag in enumerate(dl_tags):
                        file.write(dl_tag.text.strip() + "\n")
                        # 현재 반복이 마지막이 아니면 추가 문자열을 파일에 작성
                        if index != len(dl_tags) - 1:
                            file.write("\n------------------------------------------------------\n\n")

            else:
                print("파일이 존재하지 않습니다.")
                driver.quit()
                exit()
        else:
            print("원하는 데이터가 없습니다.")
            driver.quit()
            exit()
    else:
        print("원하는 태그가 없습니다.")
        driver.quit()
        exit()


    # 웹 드라이버 종료
    driver.quit()
    print("크롤링이 완료되었습니다.")
    time.sleep(1)
    print("DB에 데이터를 반영합니다.")


    # SQL 쿼리 템플릿
    sql_template = "INSERT INTO building_info_detail_{0} (num, name) VALUES (%s, %s)".format(building_dict_select_num)

    # 데이터베이스 커서 생성
    cursor = connection.cursor()

    try:
        # "output.txt" 파일 열어서 데이터를 읽어옴
        with open("output.txt", "r", encoding="utf-8") as file:
            lines = file.readlines()

            lines = list(filter(None, lines))

        # 전처리 및 데이터 삽입
        for line in lines:

            # "FL", "BF", "----"로 시작하는 문구라면 DB에 반영하지 않음
            if (re.match(r'^FL', line) or (re.match(r'^BF.*', line)) or (re.match(r'^----.*', line))):
                continue

            # 빈 줄 이라면 DB에 반영하지 않음
            if not line.strip():
                continue

            # 첫 문자가 "B"로 시작하는 경우
            # 두 번째 문자부터 다섯 번째 문자까지 영문자가 포함된 경우
            if (re.search('B', line[0]) and re.search('[-]', line[:5])):
                num = line[:6]
            elif (re.search('B', line[0]) and re.search('[A-Za-z]', line[1:5])) or (re.search('[-]', line[:5])):
                num = line[:5]  # 앞의 5 문자를 추출
            elif re.search('S', line[:3]):
                num = line[:4]  # 앞의 4 문자를 추출
            else:
                num = line[:3]  # 앞의 3 문자를 추출

            # num 변수를 문자열로 형 변환
            num = str(num)

            # num을 제외한 나머지 문자열을 name 변수에 저장
            name = line[len(num):].strip()

            # SQL 쿼리 실행
            cursor.execute(sql_template, (num, name))
            # 커밋
            connection.commit()
        print("데이터가 성공적으로 삽입되었습니다.\n\n")
    except Exception as e:
        # 예외 발생 시 롤백
        print("데이터 삽입 중 오류가 발생했습니다:", e)
        connection.rollback()

if(connection.ping(reconnect=True)):
    connection.close()
