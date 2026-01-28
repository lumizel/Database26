USE sakila;
#문자열 함수
# concat concat_ws()
select concat(first_name, ',', last_name) as customer_name from customer; # concat 함수로 열 이름과 문자열 연결
select concat_ws(',',first_name, last_name,email) as customer_name from customer; # 컨캣ws는 구분자 기호를 앞에 입력해서 분할하여 나열한다...
select concat(null,first_name, last_name) as customer_name from customer; #null이 있으면 전부 null 처리 된다...
select concat_ws(',',first_name, last_name) as customer_name from customer; #컨캣ws는 null이 있으면 패싱하고 다음 데이터로 계속 진행한다.

#데이터 형 변환 함수 - cast convert --> 명시적 변환 (내가 바꿔여함 / 반대는 암시적 -> 자동으로 바꿔줌.)
select
4/'2', # 암시적
4/2,
4/ cast('2' as unsigned); # 명시적

select now();

select cast(now() as signed);

-- CAST(값 AS SIGNED): "부호가 있는 정수"로 바꿔라. (음수, 0, 양수 모두 가능)
-- CAST(값 AS UNSIGNED): "부호가 없는 정수"로 바꿔라. (0과 양수만 가능) - 음수 불가 ㅇㅇ

select cast(20260128 as date); # date 함수를 써서 숫자를 날짜형으로 변환함.
select cast(20260128 as char); # 변화는 없어보이지만 타입이 숫자에서 문자로 바뀜!

select convert(now(),signed);
select convert(20260128,date);
select convert(20260128,char(5)); # 문자를 5로 지정했기때문에 6부터는 짤림.
select cast(9223372036854775807 as unsigned)+1; # 오버플로는 cast, convert로 대처 가능
select convert(92232458446341854, unsigned)+1;

#NULL 대처 함수 IFNULL COALESCE

CREATE TABLE doit_null (
    col_1 INT,
    col_2 VARCHAR(10),
    col_3 VARCHAR(10),
    col_4 VARCHAR(10),
    col_5 VARCHAR(10)
);

INSERT INTO doit_null VALUES (1, NULL, 'col_3', 'col_4', 'col_5');
INSERT INTO doit_null VALUES (2, NULL, 'col_3', 'col_4', 'col_5');
INSERT INTO doit_null VALUES (2, NULL, NULL, NULL, 'col_5');
INSERT INTO doit_null VALUES (3, NULL, NULL, NULL, NULL);

SELECT * FROM doit_null;

select col_1, ifnull(col_2,'') as col_2,col_3,col_4,col_5
from doit_null  where col_1= 1; #ifnull 사용해 col_2 널이라면?!! 공백으로 채워넣기를 한거임.

select col_1, ifnull(col_2,col_3) as col_2,col_3,col_4,col_5
from doit_null where col_1 = 1; #ifnull로 col2 값이 널이어서 col3 값으로 대체했음.

select col_1, coalesce(col_2,col_3,col_4,col_5)
from doit_null where col_1 =2;

select col_1, coalesce(col_2,col_3,col_4,col_5)
from doit_null where col_1 =3; # col_1 =3 행을 보면 다 null이라 null로 반환함.

select 'Do it! SQL', lower('Do it! SQL'), upper('Do it! SQL');
select email, lower(email),upper(email) from customer;

select '    do it sql', ltrim('    do it sql');
select 'do it sql     ', rtrim('do it sql     ');

select '   do it    ', trim('   do it    ');
select trim(both '#' from '#      do  it     #');

select length('do it sql!'), length('집 가고 싶다아아아아아아'); #영어 1바이트 한글 한자는 3바이트
select length('A'),length('강'),length('姜'),length('☆'),length(' ');
select char_length('do it mysql!'), char_length('두잇 마이에스큐앨'); # 띄어쓰기도 문자열 개수에 포함해서 출력함.

select first_name, length(first_name), char_length(first_name) from customer; # 문자열 대신 열의 이름을 넣는 것도 가능
select 'do it sql!!', position('!' in 'do it mysql!!');