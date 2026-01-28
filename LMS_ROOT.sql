# 파이썬과 mysql 병합 작업을 위한 sql 페이지

# 절차 일반적으로 system(root)계정은 개발용으로 사용하지 않는다.
# mysql에 사용할 id와 pw와 권한을 부여하고 db를 생성한다.

create USER 'mbc'@'localhost' identified by '1234';
# 사용자계정생성한다.
#            아이디    접속pc                   암호
#            'lhj' @ '192.168.0.154'        '5678' -> 임효정씨가 154주소로 들어옴.
#            'lhj' @ '192.168.0.%'   -> '192.168.0.1' ~ '192.168.0.255' 까지 답이 들어옴.
#            'lhj' @ '%'             -> 전체 ip(외부에서도 접속 가능 -> 보안 취약)
# 사용자 계정 생성은 id가 중복되어도 됨, 대신 접속 pc를 다중처리 할 수 있음.
# create user 'mbc'@'192.168.0.%' identified by '5678';
# create user 'mbc'@'%' identified by 'Mbc320!!';

# 사용자를 삭제
drop user 'mbc'@'localhost';

# mbc 사용자에게 lms 권한 부여
# 1. db 생성 -> 2. 계정에 권한 부여
create database lms default character set utf8mb4 collate utf8mb4_general_ci;
# lms 데이터베이스 생성                        한국어 지원                       대소문자 구분 x
# collate : 문자 집합에 포함된 문자들을 어떻게 비교하고 정렬할지 정의하는 키워드
# 데이터 비교 시 대소문자 구별, 문자 간 정렬 순서, 언어 별 특수문자 처리 방식 지원
# utf8mb4 : 문자집합
# general : 비교 규칙(간단한 일반비교)
# ci : Case Insensitive(대소문자 구분 x)
# collate utf8mb4_bin (대소문자 구분 o)


# mbc라는 계정이 lms를 사용할 수 있게 권한 부여
grant all privileges on LMS.* to 'mbc'@'localhost';
#                      db명.테이블  아이디     접속pc

# all privileges - 모든 권한 부여
# grant select, insert on lms,* to 'mbc'@'localhost';
#       read    create


# 권한 즉시 반영
flush privileges;

use mysql; # mysql 촤고 db에 접속
select * from user; # mysql에 사용자의 목록을 볼 수 있다.


