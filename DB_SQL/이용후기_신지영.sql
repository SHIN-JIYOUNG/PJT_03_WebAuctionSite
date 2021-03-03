/*
       화면 설계서에 검색이나 어떤 버튼 눌렀을때 어떤 테이블에 쿼리가 작동한다
       화면 설계서 작게 띄우고 옆에 글로 표시하기~!
*/


/*이용 후기 테이블 만들기 */

create table REVIEW_TB(
REVIEW_NO number(4) constraint PK_REVIEW_NO primary key,
REVIEW_TIME DATE not null,
REVIEW_IMAGE varchar2(50),
REVIEW_LIKE number(4),
REVIEW_TEXT varchar2(2000) not null,
MEM_NO number(4) constraint fk_mem_no references MEMBER_TB_TEST(MEM_NO) on delete cascade,
ART_NO number(4) constraint fk_art_no references art_info_tb_TEST(ART_NO) /*작품은 품절되거나 해도 작품테이블에서 삭제 안되고 그대로 남아있는 거*/
);


insert into REVIEW_TB values(
1,
sysdate,
'image01.jpg',
1,
'벽에 걸어놓으니 예쁘다',
6,/*회원번호 */
1 /*작품번호 */
);

insert into REVIEW_TB values(
2,
sysdate,
'asdf.jpg',
null,
'정말 자유로운 느낌이다',
5,/*회원번호 */
2 /*작품번호 */
);

insert into REVIEW_TB values(
3,
sysdate,
'reviewphoto.jpg',
3,
'화려하다',
4,/*회원번호 */
3 /*작품번호 */
);


select * from REVIEW_TB;

/*후기 작성자의 이름 가져오기 (fk: mem_no)*/
select m.MEM_NAME
from MEMBER_TB_TEST m
join REVIEW_TB r
on m.MEM_NO=r.MEM_NO;

/*후기의 작품정보 가져오기 (fk: art_no)*/
select a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3
from art_info_tb_TEST a
join REVIEW_TB r
on a.art_no = r.art_no;

/*후기의 작품의-> 작가명 가져오기*/
select at.ARTIST_NAME
from ARTIST_INFO_TB_TEST at
where (
select a.mem_no
from art_info_tb_TEST a
join REVIEW_TB r
on a.art_no=r.art_no)=at.mem_no;
















/*회원정보 테이블 테스트용 만들기*/
create table MEMBER_TB_TEST(
MEM_NO number(4) constraint PK_MEMBER_NO primary key,
MEM_NAME varchar2(20) not null
);

insert into    MEMBER_TB_TEST values(
6,
'박호수'
);

insert into    MEMBER_TB_TEST values(
5,
'김덕배'
);

insert into    MEMBER_TB_TEST values(
4,
'이영희'
);

select * from MEMBER_TB_TEST;


/*결제 테이블 테스트용 만들기*/
create table PAYMENT_TB(
art_no number references art_info_tb_TEST(ART_NO),
pay_amount number);

select * from payment_tb;

insert into payment_tb values(
1 ,
530000);

insert into payment_tb values(
2 ,
170000);

insert into payment_tb values(
3 ,
300000);



/*작품정보 테이블 테스트용 만들기*/

create table art_info_tb_TEST (
 art_no number constraint pk_art_no primary key,
 art_name varchar2(50) not null,
 art_theme varchar2(50) not null,
 art_tag1 varchar2(20),
 art_tag2 varchar2(20),
 art_tag3 varchar2(20)
 );

 alter table art_info_tb_TEST add MEM_NO number; /*작가의 회원번호 */
 update art_info_tb_TEST
 set mem_no=7
 where art_no=1;

 insert into art_info_tb_TEST values(
   1,
   '바다',
   '풍경',
   '자연',
   null,
   null
 );

  insert into art_info_tb_TEST values(
   2,
   '자유',
   '추상화',
   '상상',
   '분위기',
   null ,
    8
 );

  insert into art_info_tb_TEST values(
   3,
   '점',
   '추상화',
   '분위기',
   null,
   null  ,
    9
 );

 select * from  art_info_tb_TEST;


/*작가정보 테이블 테스트용 만들기, 테스트용이니까 우선 IS_ARTIST 물어보는 조건 컬럼은 빼고 테스트해보기! */
create table ARTIST_INFO_TB_TEST(
	MEM_NO number,
	ARTIST_NAME varchar2(13) not null
 );

 insert into ARTIST_INFO_TB_TEST values(
 7,
 '이순신'
 );

  insert into ARTIST_INFO_TB_TEST values(
 8,
 '홍장미'
 );


  insert into ARTIST_INFO_TB_TEST values(
 9,
 '홍길동'
 );


 select * from ARTIST_INFO_TB_TEST;

