# join은 db 속 서로다른 테이블을 서로 연결하는 것이다.
# inner join 내부 조인
-- select
-- 	[고객.고객 번호], [고객.고객 이름], [주문.주문 번호], [주문.고객 번호], [주문.주문 날짜]
-- from [고객]
-- 	inner join [주문] on [고객.고객 번호] = [주문.주문 번호]

use sakila;
select
	a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id
as a_address_id,
	b.address_id as b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
from customer as a # a로 간단하게 표현
	inner join address as b on a.address_id = b.address_id # b로 간단하게 표현
where a.first_name = 'ROSA';

select # 조인 조건 두개 이상 사용 - AND OR
	a.customer_id, a.store_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code
from customer as a
	inner join address as b on a.address_id = b.address_id and a.create_date = b.last_update  # 조인 조건에 열이 달라도 상관없다.!! 뒤에 AND 두번 째 조건을 보면 ㅇㅇ / 데이터의 유형은 같아야함!! 타입 ㅇㅇ
    where a.first_name = 'ROSA';
 
 select # 3개 이상의 테이블을 조인하는 경우
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code,
    c.city_id, c.city
from customer as a
	inner join address as b on a.address_id = b.address_id
    inner join city as c on b.city_id = c.city_id
where a.first_name = 'ROSA';
    
#외부조인  outer join
select
	a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	left outer join store as b on a.address_id = b.address_id;

select  # null만 조회하게끔 where 조건을 사용함.
		a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	left outer join store as b on a.address_id = b.address_id
where b.address_id is null;

select
	a.address, a.address_id as a_address_id,
    b.address_id as b_address_id, b.store_id
from address as a
	right outer join store as b on a.address_id = b.address_id;

select  # null만 조회하게끔 where 조건을 사용함.
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id
where a.address_id is null;

#full outer join
select
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	left outer join address as b  on a.address_id = b.address_id

union

select  # null만 조회하게끔 where 조건을 사용함.
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id;




select # 풀 조인으로 널 값만 표시하기 -> 교집합은 제외
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	left outer join address as b  on a.address_id = b.address_id

union

select  # null만 조회하게끔 where 조건을 사용함.
	a.address_id as a_address_id, a.store_id,
    b.address, b.address_id as b_address_id
from store as a
	right outer join address as b on a.address_id = b.address_id
where a.address_id is null;

# 교차 조인 - 조건 없이 무조건 싹 다 매칭 --> 테이블의 모든 행이 다른 테이블의 모든 행에 다 조인한다는 거 ㅇㅇ
create table doit_cross1(num int);
create table doit_cross2(name varchar(10));
insert into doit_cross1 values(1),(2),(3);
insert into doit_cross2 values('Do'),('It'),('SQL');

select
	a.num,b.name
from doit_cross1 as a
	cross join doit_cross2 as b
order by a.num;

select
	a.num,b.name
from doit_cross1 as a
	cross join doit_cross2 as b
where a.num = 1;

#셀프조인 - 동일한 테이블을 사용 자기 자신에게 조인한다는 소리 ㅇㅇ 테이블은 1개만 사용
# 테이블에 별칭을 사용해야 함.

select a.customer_id as a_customer_id, b.customer_id as b_customer_id
from customer as a
	inner join customer as b on a.customer_id=b.customer_id;
    
select
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount as profit_amount
from payment as a
		left outer join payment as b on a.payment_id = b.payment_id -1;
        
#t 서브 쿼리 - 쿼리 안에 또 쿼리 ㅇㅇ where절 뒤에 쿼리를 한번 더 작성함.
# 서브뤄키는 소괄호 안에 작성, 주 쿼리 실행 전 1번만 실행됨.
# 비교 연산자와 함께 쓸 시 서브쿼리를 연산자 오른쪽에 작성하고 order by 정렬문은 못 씀

select * from customer
where customer_id = (select customer_id from customer where first_name = 'ROSA');

-- select * FROM CUSTOMER
-- WHERE customer_id = (select customer_id from customer where first_name in ('ROSA','ANA')); 

select * from customer
where first_name in ('ROSA','ANA');

select * FROM CUSTOMER
WHERE customer_id in (select customer_id from customer where first_name in ('ROSA','ANA')); 

select
	a.film_id, a.title
from film as a
	inner join film_category as b on a.film_id = b.film_id
    inner join category as c on b.category_id = c.category_id
where c.name = 'Action';


select #IN은 서브 쿼리 결과에 동일한 값이 있어야 데이터를 조회함.
	film_id, title
from film 
where film_id in (
	select a.film_id
    from film_category as a
		inner join category as b on a.category_id = b.category_id
	where b.name = 'Action');

select
	film_id, title
from film 
where film_id not in (
	select a.film_id
    from film_category as a
		inner join category as b on a.category_id = b.category_id
	where b.name = 'Action');


select * from customer # =ANY는 둘 중 하나라도 만족하면 데이터 조회함.
where customer_id = any(select customer_id from customer where first_name in ('ROSA','ANA'));

select * from customer # <ANY는 둘 중 하나라도 만족하면 데이터 조회함. customer_id가 퍼스트 네임에 로사랑 아나 보다 낮은 사람들을 쫙 출력하는데
# 112 181이라 둘 중 하나라도 맞으면 출력하는 any라서 181 아래를 쭈우우욱 조회함 ㅇㅇ
where customer_id < any(select customer_id from customer where first_name in ('ROSA','ANA'));

select * from customer # >ANY는 둘 중 하나라도 만족하면 데이터 조회함. 반대로 112 181 중 둘 중 하나라도 크면 출력하는거니 112보다 큰 수에 181이 들어가니
# 112보다 큰 customer_id를 쭈우우욱 출력함.ㅇㅇ
where customer_id > any(select customer_id from customer where first_name in ('ROSA','ANA'));

select * from customer # exists는 뒤에 select에서 보면 in 조건이 테이블에 값이 하나라도 존재하면 데이터를 조회함.
where exists(select customer_id from customer where first_name in ('ROSA','ANA'));
# any랑 다른 점은 any는 비교 연산자와 함께 작성해야함

-- /* [주석 메모]
-- 1. EXISTS는 서브쿼리에 데이터가 '한 줄이라도' 있으면 참(True)이 됨.
-- 2. 현재 로사/아나가 테이블에 있으므로 이 조건은 무조건 참 -> 결국 전체 고객이 다 나옴.
-- 3. ANY와 달리 EXISTS는 비교 연산자(>, <, =) 없이 단독으로 사용함.

select * from customer # 강이라는 고객 아이디가 없느니 펄스 처리되서 널 값이 나옴.
where exists(select customer_id from customer where first_name in ('KANG'));

select * from customer # NOT을 써서 강이라는 고객 아디가 없는게 참이 됐으니 즉 트루 ㅇㅇ 그래서 모든 고객 테이블 데이터를 출력함.
where NOT exists(select customer_id from customer where first_name in ('KANG'));

select * FROM CUSTOMER # 일단 로사 아나가 112 181 인데 all은 112 181을 다 가져야 트루인데, 고객 번호는 하나 이상은 못 갖아서 폴스가 됌.
# 그래서 데이터 조회 시 널 값이 출력되는 거임.
where customer_id = all(select customer_id from customer where first_name in ('ROSA','ANA'));

select
a.film_id,a.title,a.special_features,c.name
from film as a
inner join film_category as b on a.film_id = b.film_id
inner join category as c on b.category_id = c.category_id
where a.film_id>10 and a.film_id <20;
# [핵심 요약]
# 1. 조인 방식: 영화(a) - 연결고리(b) - 장르(c)를 순서대로 다 붙여서 '큰 표'를 만듦.
# 2. 데이터 필터: 영화 번호가 11번부터 19번 사이인 것만 쏙 골라냄.
# 3. 특징: 서브쿼리 없이 정석적인 JOIN만 사용함. 결과에 장르 이름(name)까지 한 줄에 나옴.

select
a.film_id, a.title,a.special_features,x.name
from film as a
inner join(
select
b.film_id, c.name
from film_category as b
inner join category as c on b.category_id = c.category_id
where b.film_id>10 and b.film_id <20) as x on a.film_id = x.film_id;
# [핵심 요약]
# 1. 서브쿼리(x): 11~19번 영화의 '장르 이름'만 먼저 뽑아서 임시 테이블 x를 만듦.
# 2. 조인: 영화 정보(a)와 방금 만든 임시 테이블(x)을 ID 기준으로 합침.
# 3. 특징: FROM 절에 서브쿼리를 쓴 '인라인 뷰'. 불필요한 영화는 조인하기 전부터 미리 빼버림!


select
a.film_id,a.title,a.special_features,c.name
from film as a
inner join film_category as b on a.film_id = b.film_id
inner join category as c on b.category_id = c.category_id
where a.film_id>10 and a.film_id <20;
# [핵심 요약]
# 1. 조인 구조: 영화(a) - 연결테이블(b) - 장르(c) 세 테이블을 기차처럼 하나로 길게 이어 붙임.
# 2. 필터링: 다 합쳐진 커다란 표에서 영화 번호가 11~19번 사이인 줄만 남기고 다 버림.
# 3. 장점: 쿼리가 직관적이라 읽기 쉽고, 대부분의 상황에서 SQL 엔진이 가장 빠르게 처리함.


select
a.film_id,a.title,a.special_features,(select c.name from film_category as b 
inner join category as c on b.category_id = c.category_id where a.film_id = b.film_id) as name
from film as a
where a.film_id>10 and a.film_id<20;
# [핵심 요약]
# 1. 스칼라 방식: 결과창의 'name' 컬럼을 채우기 위해, 행마다 서브쿼리를 매번 실행함.
# 2. 작동 원리: 11번 영화 제목 뽑고 -> 그에 맞는 장르 찾아오고 -> 12번 뽑고 -> 또 찾아오고... (반복)
# 3. 주의점: 영화 제목 한 줄 뽑을 때마다 장르를 '한 땀 한 땀' 새로 검색하느라 데이터가 많으면 느려짐.