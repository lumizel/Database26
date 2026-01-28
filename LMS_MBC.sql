# LMS에 대한 테이블을 생성하고 더미데이터 입력 (CRUD)

SHOW databases; # LMS만 보인다.

USE LMS; # LMS를 사용

create TABLE members(   # members 테이블 생성
#필드명    타입   옵션
id		int auto_increment primary key,
#       정수   자동번호생성기       기본키(다른 테이블과 연결용)
uid		varchar(50) not null unique,
#       가변 문자(50자)  공백x   유일한 값
password varchar(255) not null,
name 	varchar(50) not null,
role enum('admin','manager','user') default 'user',
#    열거타입(괄호 안에 글자만 허용)        기본값은 유저
active boolean default true,
#      불린타입     기본값 트루
created_at datetime default current_timestamp
#생성일        날짜 시간         기본 값은 시스템 시간
);

# 더미 데이터 입력
insert	into members (uid,password,name,role,active)
values ('kkw','1234','김기원','admin',true);

# 더미데이터 출력
select * from members;
select * from members where uid = 'kkw' and password='1234' and active=true;
# 로그인 할 때 ㅇㅇ


# 더미데이터 수정
update members set password = '1111' where uid = 'kkw';
select * from members;

#회원 삭제
delete from members where uid = 'kkw';
update members set active = false where uid = 'kkw'; # 비활성화
select * from members;

insert	into members (uid,password,name,role,active)
values ('kkw','1234','김기원','admin',true);
insert	into members (uid,password,name,role,active)
values ('lhj','5678','임효정','manager',true);
insert	into members (uid,password,name,role,active)
values ('kdg','1111','김도균','user',true);
insert	into members (uid,password,name,role,active)
values ('ksb','2222','김수빈','user',true);
insert	into members (uid,password,name,role,active)
values ('kjy','3333','김지영','user',true);
insert	into members (uid,password,name,role,active)
values ('ymy','0807','여민엽','user',true);
select * from members;


