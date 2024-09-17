DROP DATABASE IF EXISTS  inu_building_db;
create database inu_building_db default character set utf8mb3;
commit;

use inu_building_db;

set FOREIGN_KEY_CHECKS = 0;
drop table if exists building_info;
drop table if exists department;
drop table if exists building_info_detail;
drop table if exists building_info_detail_1;
drop table if exists building_info_detail_2;
drop table if exists building_info_detail_3;
drop table if exists building_info_detail_4;
drop table if exists building_info_detail_5;
drop table if exists building_info_detail_6;
drop table if exists building_info_detail_7;
drop table if exists building_info_detail_8;
drop table if exists building_info_detail_9;
drop table if exists building_info_detail_10;
drop table if exists building_info_detail_11;
drop table if exists building_info_detail_12;
drop table if exists building_info_detail_13;
drop table if exists building_info_detail_14;
drop table if exists building_info_detail_15;
drop table if exists building_info_detail_16;
drop table if exists building_info_detail_17;
drop table if exists building_info_detail_18;
drop table if exists building_info_detail_19;
drop table if exists building_info_detail_20;
drop table if exists building_info_detail_21;
drop table if exists building_info_detail_22;
drop table if exists building_info_detail_23;
drop table if exists building_info_detail_24;
drop table if exists building_info_detail_25;
drop table if exists building_info_detail_26;
drop table if exists building_info_detail_27;
drop table if exists building_info_detail_28;
drop table if exists building_info_detail_29;
drop table if exists building_info_detail_30;
set FOREIGN_KEY_CHECKS = 1;

create table building_info(
	id integer primary key,
    name varchar(30) not null,
    description varchar(500)
) default character set utf8mb3 collate utf8mb3_general_ci;

create table building_info_detail(
	num varchar(7),
    name varchar(30)
) default character set utf8mb3 collate utf8mb3_general_ci;

create table building_info_detail_1 like inu_building_db.building_info_detail;
create table building_info_detail_2 like inu_building_db.building_info_detail;
create table building_info_detail_3 like inu_building_db.building_info_detail;
create table building_info_detail_4 like inu_building_db.building_info_detail;
create table building_info_detail_5 like inu_building_db.building_info_detail;
create table building_info_detail_6 like inu_building_db.building_info_detail;
create table building_info_detail_7 like inu_building_db.building_info_detail;
create table building_info_detail_8 like inu_building_db.building_info_detail;
create table building_info_detail_9 like inu_building_db.building_info_detail;
create table building_info_detail_10 like inu_building_db.building_info_detail;
create table building_info_detail_11 like inu_building_db.building_info_detail;
create table building_info_detail_12 like inu_building_db.building_info_detail;
create table building_info_detail_13 like inu_building_db.building_info_detail;
create table building_info_detail_14 like inu_building_db.building_info_detail;
create table building_info_detail_15 like inu_building_db.building_info_detail;
create table building_info_detail_16 like inu_building_db.building_info_detail;
create table building_info_detail_17 like inu_building_db.building_info_detail;
create table building_info_detail_18 like inu_building_db.building_info_detail;
create table building_info_detail_19 like inu_building_db.building_info_detail;
create table building_info_detail_20 like inu_building_db.building_info_detail;
create table building_info_detail_21 like inu_building_db.building_info_detail;
create table building_info_detail_22 like inu_building_db.building_info_detail;
create table building_info_detail_23 like inu_building_db.building_info_detail;
create table building_info_detail_24 like inu_building_db.building_info_detail;
create table building_info_detail_25 like inu_building_db.building_info_detail;
create table building_info_detail_26 like inu_building_db.building_info_detail;
create table building_info_detail_27 like inu_building_db.building_info_detail;
create table building_info_detail_28 like inu_building_db.building_info_detail;
create table building_info_detail_29 like inu_building_db.building_info_detail;
create table building_info_detail_30 like inu_building_db.building_info_detail;

create table department(
	name varchar(30) primary key,
    description varchar(500),
    num_phone varchar(15),
    num_fax varchar(15),
    build_num integer,
    
    foreign key (build_num) references building_info(id)
) default character set utf8 collate utf8_general_ci;

create table building_info_detail_short(
	num varchar(5) primary key,
    description varchar(100)
) default character set utf8mb3 collate utf8_general_ci;

create table building_info_detail_major(
	name varchar(50)
)default character set utf8mb3 collate utf8_general_ci;

create table building_info_detail_short_1 like building_info_detail_short;
create table building_info_detail_short_6 like building_info_detail_short;
create table building_info_detail_short_7 like building_info_detail_short;
create table building_info_detail_major_7 like building_info_detail_major;

use inu_building_db;

#set FOREIGN_KEY_CHECKS = 0;
#truncate table building_info;
#truncate table department;
#set FOREIGN_KEY_CHECKS = 1;

insert into building_info values(1, "대학본부", "국립인천대학교는 국내 10위권 대학, 세계 100위권 대학으로 진입을 목표로 다양하고 특화된 사업을 계획하고 있습니다.\n 교육, 연구•산학협력, 사회공헌, 국제화, 경영•인프라, 특성화 등\n6가지 전력목표를 체계적이고 차별화된 방식으로 운영하여 대학 경쟁력을 키워나갈 것입니다.");
insert into building_info values(6, "학산도서관", "인천대학교 학산도서관은 연구·학습 자료의 체계적인 관리로\n대학구성원의 효과적인 학술 연구 및 학습 활동의 중추적 역할을 담당하며 필요한 자료를 수집·정리하고 제공하여\n다양하고 전문화된 도서관 이용자의 요구에 부응하기 위해 노력하고 있으며,\n빠르게 변화하는 지식정보사회에 적극적으로 대응하기 위해 국내 ·해외 전자정보(전자저널, Web DB), 학술잡지 등\n다양한 정보서비스를 신속히 제공하는 등 명실상부 대학의 심장부 역할을 하고 있다.");
insert into building_info values(7, "정보기술대학", "정보기술대학은 1988년 공과대학으로 출범하여 2002년 단과대학으로 분리 설립되었으며,\n컴퓨터공학부, 정보통신공학과, 임베디드시스템공학과의 세 개 학과에 특화된 교육과정을 제공하고 있습니다");
insert into building_info values(8, "공과대학", "공과대학은 창의력을 갖춘 전문 기술인 양성 이라는 교육목표를 가지고 국제적 경쟁력과 미래지향적인 전문 지식을 갖춘 \n인재양성을 위해 다양한 노력을 경주하고 있다");
insert into building_info values(11, "복지회관(학생식당)", "복지회관 입니다.");

insert into department values("컴퓨터공학부", "끊임없이 변화가 예상되는 세계의 흐름 속에서 컴퓨터공학부는 정보기술의 이론적인 발전을 선도함은 물론 산업체의 요구에 부응하는 기술개발 인력양성을 목적으로 컴퓨터 하드웨어, 소프트웨어를 포함하여 경영정보시스템, 컴퓨터비젼, 멀티미디어, 컴퓨터그래픽스, 게임프로그램, 임베디드시스템과 같은 여러 응용 분야의 기본이론을 체계적으로 공부하고 있습니다. 그리고 학문적으로 우수하고 다각적인 산학협력을 수행하고 있는 교수진의 교육을 바탕으로 여러 프로그래밍 언어를 공부한 후 수준 높은 응용프로그램을 실제로 개발해 봄으로써 미래의 IT를 이끌어 대한민국의 성장동력을 선도할 전문 기술 인재를 발굴육성 하고 있습니다", "032-835-8490", "032-835-0780", 7);
insert into department values("정보통신공학부", "정보의 생성과 가공, 전달을 위한 정보처리, 네트워크 및 통신기술에 관한 전반적인 이론 습득은 물론 소프트웨어․하드웨어 설계능력 및 실험능력을 배양하며, 유․무선 통신망을 활용한 다양한 정보통신 실습으로 다가오는 유비쿼터스 사회에 능동적으로 대처할 수 있는 창의성과 기술개발 및 의사전달 능력, 정보윤리 의식을 겸비하고 지도자의 자질을 갖춘 고급 인력을 육성하고자 한다", "032-835-8280", "032-835-0781", 7);
insert into department values("임베디드시스템공학과", "임베디드 기술이란 우리를 둘러싸고 각종 사물(Objects)에 지능 소프트웨어(Intelligent Software)을 부여하는 기술이다. 스마트 기기, 자동차, 무인 항공기(드론, Drone), 사물인터넷(IoT) 등, 언제 어디서나 컴퓨팅을 사용할 수 있도록 하는, 연결된 세상을 구축하기 위한 핵심 기술이다. 에너지를 적게 쓰면서도 원하는 동작을 빠르고 아주 정밀하고 정확하게 처리하게 하는, 소프트웨어와 하드웨어가 밀접하게 결합된 첨단 전자 시스템을 임베디드 시스템이라고 말한다. 우리 학과에서는 임베디드 시스템을 위한 융합 소프트웨어 설계 및 개발 능력을 갖춘 글로벌 인재양성을 목표로 충분한 이론적 지식과 산업체의 수요 중심의 실무 기술을 융합한 특화된 교육 과정을 운영하고 있다.", "032-835-8760", "032-835-0782", 7);

insert into department values("기계공학과", "인천대학교 기계공학과는 4차 산업혁명 시대에 요구되는 창의, 혁신, 소통형 공학인을 인재상으로 가지며, 다양한 기업, 연구소, 학계의 분야에서 주도적 역할을 수행하는 우수 엔지니어 양성을 교육 목표로 하고 있습니다. 이러한 목표 달성을 위해 인천대학교 기계공학과는 반도체 및 배터리, 모빌리티 및 로보틱스, 신재생 에너지 발전 등의 다양한 교육트랙을 운영하고 있으며 관련하여 우수한 연구실적과 산학역량을 보유한 교수진들의 지도 아래 기초 이론부터 실습까지 폭 넓은 교육을 제공하고 있습니다.", "032-835-8410", "032-835-0793", 8);
insert into department values("전기공학과", "전기공학은 국가산업과 국민복지의 원동력인 전기에너지에 관련된 모든 분야와 정보기술, 가전, 제조업 분야 등의 기반기술을 담당하는 학문분야로서 어느 시대에서나 산업, 문화, 예술에서 첨단 기술에 이르기까지 실로 지대한 영향을 미치게 된다. 오늘날 정보혁명을 일으켜 지구촌을 하나의 정보문화권으로 만든 이른바 첨단 정보기술도 모든 분야에 전기의 이용을 용이하게 하는 전기공학의 발전을 바탕으로 하고 있는 것이다. 그 만큼, 전기 기술인의 사회적 역할과 사명은 중차대하며 성실한 책무이행이 사회로부터 엄중히 요구되는 것이다. 본 전기공학과는 이러한 사회적 명제 구현을 지향목표로 삼아, 국가 산업 발전과 국민 복지 향상에 봉사할 미래 첨단사회의 신기술인의 배출을 최우선의 목표로 정하고 있다.", "032-835-8430", "032-835-0773", 8);
insert into department values("전자공학과", "인천대학교 전자공학과는 1979년 인천대학교 개교 당시 설립된 학과로 그동안 많은 졸업생을 배출하면서 꾸준히 성장해 왔습니다. 1994년 인천대학의 시립화와 더불어 전자공학과는 우수교원 초빙과 우수학생 유치 등 명문 학과로의 발전을 위한 발판을 마련하였습니다. 그 후 전문 전자공학인력양성과 지역사회 봉사 및 발전에 이바지하면서 꾸준히 발전해 왔습니다.", "032-835-8440", "032-835-0774", 8);
insert into department values("산업경영공학과", "산업경영공학은 기업시스템이 고도화 복잡화되어 가는 추세에서 인간, 재료, 설비로 구성된 종합적인 시스템을 설계 · 개선 · 설치 운영하는 분야에 대해 공학적인 분석과 설계의 원리 및 방법의 전문적인 지식과 기술을 결합하여 시스템에서 얻어지는 결과를 파악하고 예측하며 평가할 수 있는 능력을 갖추어 시스템 Output 의 최적화를 목표로 하고 있다", "032-835-8926", "032-835-0777", 8);
insert into department values("신소재공학과", "신소재공학과의 교육은 공학 재료의 전반에 대하여 물리ㆍ화학의 기초 이론을 바탕으로 하여 재료의 특성을 이해, 규명하고 우수한 물성과 특성을 갖는 물질 및 효과적인 제조방법을 연구하는 것에 목적을 두고 있다. 신소재공학과의 연구영역은 금속, 세라믹, 에너지, 반도체 재료 등 다양한 공학재료들의 기본 물성에 대한 체계적이며 효율적인 교육을 통하여 재료 전반에 걸친 광범위한 지식을 습득하게 하는 동시에 각 재료의 특성에 따른 전공분야 연구를 심도 있게 수행하는 국제화된 창의적인 역량을 갖춘 인재 양성을 목표로 한다.", "032-835-8270", "032-835-0778", 8);
insert into department values("안전공학과", "안전공학(Safety Engineering)은 다양하고 대형화 되어가고 있는 각종 산업재해에 대비할 수 있는 학재적인 종합공학을 바탕으로 유해 작업 환경 요인 및 위험에 대한 분석ㆍ평가능력을 배양하고 공학적인 재해방지ㆍ예방 대책을 제시할 수 있는 전문적인 안전ㆍ보건 기술 인력의 양성과 더불어 지식기반 사회를 선도 할 수 있는 유능하고 창의적이며 자주적, 민주적 인격을 갖춘 지도적 인재를 양성하여 지역 사회 발전 및 안전의 선도를 목적으로 하고 있다", "032-835-8290", "032-835-0779", 8);
insert into department values("에너지화학공학과", "세기내 화석에너지의 고갈이 예상되는 상황에서 신·재생에너지의 개발은 인류생존의 문제와 직결되는 범세계적 문제로 부각되고 있다. 차세대 신 에너지원으로 주목받고 있는 수소에너지, 태양열, 연료전지, 바이오에너지 등을 포함한 신·재생에너지의 이용을 위한 핵심요소 기술개발과 새로운 개념의 기술 인력이 절실히 요구되고 있지만, 기존학과 중심의 교육과정으로는 이러한 수요를 충족시키지 못하고 있다. 에너지화학공학과는 차세대 에너지 신기술 산업을 담당할 창의적인 인력 양성을 그 목적으로 하고 있다.", "032-835-8670", "032-835-0797", 8);
insert into department values("바이오-로봇 시스템 공학과", "급속도로 발전하고 있는 4차 산업핵심분야의 핵심역량을 갖춘 전문가의 수요가 점차 커지고 있는데, 우리 바이오-로봇 시스템 공학과는 졸업생들의 취업을 지원하기 위한 산학협력중심의 연구프로젝트를 활발히 수행하고 있으며, 지속적으로 연구자의 진로를 희망하는 학생들에게는 대학원 졸업 후 박사후연구원, 국책기관 연구원 및 대학 교수 등의 학자로서 성장하기 위한 구체적인 로드맵을 제시해주고 있습니다.", "032-835-8690", "032-835-0718", 8);

insert into building_info_detail_short_1 values("BF1", "종합상황실"); 
insert into building_info_detail_short_1 values("F1", "학사팀, 입학관리과");
insert into building_info_detail_short_1 values("F2", "교무과, 시설관리팀, 감사팀");
insert into building_info_detail_short_1 values("F3", "총무과, 재무회계팀, 국제교류팀"); 
insert into building_info_detail_short_1 values("F4", "홍보팀, 회의실"); 
insert into building_info_detail_short_1 values("F5", "총장실, 법률팀");

insert into building_info_detail_short_6 values("BF1", "자유열람실, 세미나실, 휴게실, 안내데스크, 편의점•복사실"); 
insert into building_info_detail_short_6 values("F1", "멀티미디어실, 멀티미디어Lab실, 학술정보팀 사무실"); 
insert into building_info_detail_short_6 values("F2", "연속간행물실, 스터디룸, JobLibaray 코너"); 
insert into building_info_detail_short_6 values("F3", "제1자료실(총류, 철학, 종교, 사회과학, 순수과학), 스터디룸, 중앙정원");
insert into building_info_detail_short_6 values("F4", "제2자료실(기술과학, 예술, 언어, 문학, 역사)");

insert into building_info_detail_short_7 values("BF1", "주치장"); 
insert into building_info_detail_short_7 values("F1", "정보기술대학생회실, 휴게실"); 
insert into building_info_detail_short_7 values("F2", "정보통신공학과 사무실, 교수실"); 
insert into building_info_detail_short_7 values("F3", "정보기술대학장실, 정보기술대교학실, 임베디드시스템공학과사무실");
insert into building_info_detail_short_7 values("F4", "컴퓨터공학과사무실, 교수실");
insert into building_info_detail_short_7 values("F5", "교수실");
 
insert into building_info_detail_major_7 values("컴퓨터공학부");
insert into building_info_detail_major_7 values("정보통신공학과");
insert into building_info_detail_major_7 values("임베디드시스템공학과");

commit;
