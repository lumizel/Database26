use sakila;
select first_name from customer;#고객 테이블에서 퍼스트 네임 열을 조회
select first_name,last_name from customer; # 퍼스트,라스트 네임 열 조회
select * from customer; # 모두 조회
show columns from sakila.customer; # 사킬라의 고객 테이블에서 열 정보만 조회 - 퍼스트네임,라스트네임,고객아이디 등....
select * from customer where first_name = 'MARIA';#퍼스트 네임 마리아인 사람 조회
select * from customer where address_id = 200;# 주소아이디 200 조회
select * from customer where address_id < 200; # 200보다 낮은 조회 (비교 연산자)
select * from customer where first_name = 'MARIA';
select * from customer where first_name < 'MARIA';# 알파벳 순으로 M보다 앞에있는 사람들 조회
select * from payment where payment_date < '2025-07-09 13:24:07'; # 구매날짜 보다 이전에 날짜들을 조회 (날짜,시간도 비교 연산 가능)
select * from customer where address_id between 5 and 10 ;# 사이 연산자를 활용해 5와 10 사이에 주소 아이디를 조회
select * from payment where payment_date between '2005-06-17' and '2005-07-19';# 날짜 사이로도 조회 가능
select * from payment where payment_date = '2005-07-08 07:33:56';# 해당 정확한 날짜도 조회 가능
select * from customer where first_name between 'M' and 'O';# 퍼스트 네임이 M과 O 사이 사람들을 조회함
select * from customer where first_name not between 'M' and 'O';# 반대로 NOT이기 때문에 아닌 사람들을 조회
select * from city where city='Sunnyvale' and country_id = 103; # and 를 사용해 둘 다 조건이 맞아야 조회됨.
select * from payment where payment_date >= '2005-06-01' and payment_date <='2005-07-05';# and 사용해 비교 연산식 만족하는 데이터를 조회
select * from customer where first_name = 'MARIA' OR first_name = 'LINDA';#둘 중 하나라도 만족할 때 조회함.
select * from customer where first_name = 'MARIA' OR first_name = 'LINDA' or first_name = 'NANCY'; # OR 두 개 이상 사용 가능
select * from customer where first_name in ('MARIA','NANCY','LINDA');#OR을 많이 사용할 땐 IN을 활용하여 간편하게 작성한다.
select * FROM city where country_id = 103 or country_id = 86 and city in ('Cheju','Sunnyvale','Dasllas');
select * from city where country_id = 103;
select * from city where country_id = 86 and city in('Cheju','Sunnyvale','Dasllas'); 
select * from city where country_id = 86 or country_id = 103 and city in('Cheju','Sunnyvale','Dasllas'); # 쿼리 순서 변경
select * from city where (country_id = 103 or country_id = 86) and city in('Cheju','Sunnyvale','Dallas'); # 소괄호를 사용해 우선순위 지정
select * from city where country_id in (103,86) and city in('Cheju','Sunnyvale','Dallas'); # in을 써서 간략화
select * from address;
select * from address where address2 = null; # null 조회
select * from address where address2 is null; # 어드레스2 null 조회
select * from address where address2 is not null;# not 반대 조회
select * from address where address2 = '';# 공백은 null이 아님.
select * from customer order by first_name;
select * from customer order by last_name;
select * from customer order by store_id,first_name;
select * from customer order by first_name,store_id;
select * from customer order by first_name asc; #오름차순은 asc 사용
select * from customer order by first_name desc; #내림차순은 desc 사용
select * from customer order by store_id desc, first_name asc;
select * from customer order by store_id desc, first_name asc limit 10; # 상위 10개만 조회
select * from customer order by customer_id asc limit 100,10;  # 101 부터 10개 출력
select * from customer order by customer_id asc limit 10 offset 100; # 100개 건너뛰고 그 이후부터 10개 출력 / offset은 limit랑 같이 사용해야함!!
select * from customer where first_name like 'A%'; # A로 시작하는 데이터 조회
select * from customer where first_name like 'AA%'; # AA로 시작하는 데이터 조회
select * from customer where first_name like '%A'; # A로 끝나는 데이터 조회
select * from customer where first_name like '%RA'; # RA로 끝나는 데이터 조회
select * from customer where first_name like '%A%'; # A를 포함하는 데이터 조회
select * from customer where first_name NOT like 'A%'; # A로 시작하지 않는 데이터 조회
WITH CTE (col_1) as (
select 'A%BC' union ALL
select 'A_BC' union ALL
select 'ABC'
)
select * FROM CTE;

WITH CTE (col_1) as (
select 'A%BC' union ALL
select 'A_BC' union ALL
select 'ABC'
)
select * FROM CTE WHERE col_1 like '%';

WITH CTE (col_1) as (
select 'A%BC' union ALL
select 'A_BC' union ALL
select 'ABC'
)
select * from CTE WHERE col_1 like '%#%%' escape '#';

WITH CTE (col_1) as (
select 'A%BC' union ALL
select 'A_BC' union ALL
select 'ABC'
)
select * from CTE WHERE col_1 like '%!%%' escape '!';
select * from customer where first_name like 'A_';
select * from customer where first_name like 'A__';
select * from customer where first_name like '__A';
select * from customer where first_name like 'A__A';
select * from customer where first_name like '_____';
select * from customer where first_name like 'A_R%';
select * from customer where first_name like '__R%';
select * from customer where first_name like 'A%R_';
select * from customer where first_name regexp '^K|N$';
select * from customer where first_name regexp 'K[L-N]';
select * from customer where first_name regexp 'K[^L-N]';
select * FROM customer where first_name like 'S%' AND first_name regexp 'A[L-N]';
select * from customer where first_name like '_______' and first_name regexp 'A[L-N]' AND first_name regexp 'O$';
select special_features from film group by special_features;
select rating from film group by rating;
select special_features, rating from film group by special_features, rating;
select rating,special_features from film group by rating,special_features;
select special_features,count(*) as cnt from film group by special_features;

select special_features,rating, count(*) as cnt from film
group by special_features, rating order by special_features,rating,cnt desc;

select special_features,rating from film
group by special_features,rating
having rating = 'G';

select special_features, count(*) as cnt from film
group by special_features
having cnt > 70;

select special_features,rating, count(*) as cnt from film
group by special_features, rating
having rating = 'R' and cnt >8;

select distinct special_features,rating from film;

select special_features,rating from film
group by special_features,rating;

#테이블 생성 조작하기
use doitsql;
create table doit_increment(
col_1 int auto_increment primary key,
col_2 varchar(50),
col_3 int);

insert into doit_increment (col_2,col_3) values('1 자동 입력',1);
insert into doit_increment (col_2,col_3) values('2 자동 입력',2);

select * from doit_increment;

insert into doit_increment (col_1,col_2,col_3) values(3,'3 자동 입력',3);
select * from doit_increment;

insert into doit_increment (col_1,col_2,col_3) values(5,'4 건너뛰고 5 자동 입력',5);
select * from doit_increment;

insert into doit_increment (col_2,col_3) values('어디까지 입력되었니?',0);
select * from doit_increment;

select last_insert_id();

alter table doit_increment auto_increment=100;
insert into doit_increment (col_2,col_3) values('시작 값이 변경되었을까?',0);
select * from doit_increment;

set @@auto_increment_increment=5;
insert into doit_increment (col_2,col_3) values('5씩 증가할까?(1)',0);
insert into doit_increment (col_2,col_3) values('5씩 증가할까?(2)',0);
select * from doit_increment;

create table doit_insert_select_from(
col_1 int,
col_2 varchar(10)
);

create table doit_insert_select_to(
col_1 int,
col_2 varchar(10)
);

insert into doit_insert_select_from values(1,'DO');
insert into doit_insert_select_from values(2,'IT');
insert into doit_insert_select_from values(3,'MYSQL');

insert into doit_insert_select_to
select * from doit_insert_select_from;

select * from doit_insert_select_to;

create table doit_select_new as (select * from doit_insert_select_from);
select * from doit_select_new;

create table doit_parent (col_1 int primary key);
create table doit_child (col_1 int);

alter table doit_child
add foreign key (col_1) references doit_parent (col_1);

insert into doit_parent values(1);
insert into doit_child values(1);

select * from doit_parent;
select * from doit_child;

delete from doit_child where col_1 =1;
delete from doit_parent where col_1 = 1;

drop table doit_child;
drop table doit_parent;


create table doit_parent (col_1 int primary key);
create table doit_child (col_1 int);
alter table doit_child
add foreign key (col_1) references doit_parent (col_1);

select * from doit_child;
show create table doit_child;

alter table doit_child
drop constraint doit_child_ibfk_1;
drop table doit_parent;

#실수형 - 정확한 값이 아니기 때문에 값이 안 뜸
create table doit_float(col_1 float);
insert into doit_float values(0.7);
select * from doit_float where col_1 = 0.7;
# DEMICAL NUMERIC을 사용해 정확한 값을 표현 가능함.

#숫자형 변환 - 암시적/명시적
#암시적은 자동으로 변경 / 명시적은 CAST, CONVERT 함수를 사용
select 10/3; #암시적 - 자동으로 3.3333까지 출력

# 문자형 - CHAR VARCAHAR 있는데 전자는 공간낭비 발생, 후자는 X 단, 처리 속도는 CHAR이 더 빠름.

create TABLE doit_char_varchar(
col_1 char(5),
col_2 varchar(5)
);

insert into doit_char_varchar values('12345','12345');
insert into doit_char_varchar values('ABCDE','ABCDE');
insert into doit_char_varchar values('가나다라마','가나다라마');
insert into doit_char_varchar values('안녕하세요','HELLO');
insert into doit_char_varchar values('安寧安寧安','安寧安寧安');

select col_1, CHAR_LENGTH(col_1) as char_lengTh, lengTh(col_1) as char_byte,
col_2, CHAR_LENGTH(col_2) as char_lengTh, lengTh(col_2) as char_byte
from doit_char_varchar; # 숫자/영어 1바이트 | 한글/한문 3바이트

SHOW character set;

#콜레이션 따른 정렬 순서 비교
CREATE TABLE doit_collation (
    col_latin1_general_ci VARCHAR(10) COLLATE latin1_general_ci,
    col_latin1_general_cs VARCHAR(10) COLLATE latin1_general_cs,
    col_latin1_bin        VARCHAR(10) COLLATE latin1_bin,
    col_latin7_general_ci VARCHAR(10) COLLATE latin7_general_ci
);

#2. 데이터 입력
INSERT INTO doit_collation VALUES ('a', 'a', 'a', 'a');
INSERT INTO doit_collation VALUES ('b', 'b', 'b', 'b');
INSERT INTO doit_collation VALUES ('A', 'A', 'A', 'A');
INSERT INTO doit_collation VALUES ('B', 'B', 'B', 'B');
INSERT INTO doit_collation VALUES ('*', '*', '*', '*');
INSERT INTO doit_collation VALUES ('_', '_', '_', '_');
INSERT INTO doit_collation VALUES ('!', '!', '!', '!');
INSERT INTO doit_collation VALUES ('1', '1', '1', '1');
INSERT INTO doit_collation VALUES ('2', '2', '2', '2');

select col_latin1_general_ci from doit_collation order by col_latin1_general_ci;
select col_latin1_general_cs from doit_collation order by col_latin1_general_cs;
select col_latin1_bin from doit_collation order by col_latin1_bin;
select col_latin7_general_ci from doit_collation order by col_latin7_general_ci;
#현재 시간 조회
create table date_table(
justdaate date,
justtime time,
justdatetime datetime,
justtimestamp timestamp);

insert into date_table values(now(),now(),now(),now());
select * from date_table;