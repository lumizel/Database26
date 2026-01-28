select @@hostname;

# 이창은 메모장처럼 사용됨
# 스크립트를 한줄씩 실행하는 것이 기본이다. (컨트롤 + 엔터)
# 만약 더미 데이터를 20개 입력한다 (블럭설정 컨트롤 + 쉬프트 + 엔터)actoraddress

use sakila; #sakila 라는 데이터베이스에 가서 사용할게!!
select * from actor; #actor 테이블에 모든 값 가져와
use world; # world 데이터베이스에 가서 사용할게!
select * from city;#city라는 테이블에 모든 값 가져와

create database doitsql; #데이터 베이스 doitsql 생성
drop database doitsql; # 삭제
create database doitsql; # 생성
use doitsql; # doitsql 사용
create table doit_create_table (
col_1 int,
col_2 varchar(50),
col_3 datetime
); # 테이블 생성하는데 정수,값,날짜 순으로 나열
drop table doit_create_table; # 테이블 삭제

create table doit_dml (
col_1 int,
col_2 varchar(50),
col_3 datetime
);

insert into doit_dml (col_1,col_2,col_3) values (1,'doitsql','2026-01-27'); # 테이블에 값 삽입.
select * from doit_dml; # 보기
insert into doit_dml(col_1) values('문자 입력'); # 열이름 생략
insert into doit_dml values(2,'열이름생략','2026.01.27');
select * from doit_dml;
insert into doit_dml values(3,'col_3','값 생략'); # 값 생략 - null 값으로 표현
insert into doit_dml(col_1,col_2) values(3,'col_3 값 생략');
select * from doit_dml;
insert into doit_dml(col_1,col_3,col_2) values(4,'2026.01.27','열 순서 변경'); # 열순서를 변경해도 값은 col에 따라 입력됨.
select * from doit_dml;
insert into doit_dml (col_1,col_2,col_3) values (5,'데이터입력','20260127'),(6,'데이터입력','20260127'),(7,'데이터입력','20260127'); # 한번에 여려개 입력 가능
select * from doit_dml;
UPDATE doit_dml SET col_2 = '데이터 수정' # 데이터 수정, 안전모드 해제해야 함.
WHERE col_1 = 4;
select * from doit_dml;

update doit_dml set col_1 = col_1 + 10; # int 정수에 숫자 10을 더해서 출력됨.
select * from doit_dml;
delete from doit_dml where col_1 = 14; # col_1이 14인 값의 정보만 삭제
select * from doit_dml;
delete from doit_dml;# 다 삭제
select * from doit_dml;# 다 삭제된걸 확인 함.