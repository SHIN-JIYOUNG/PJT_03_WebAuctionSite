/*좋아요가 null이라면 0으로 채우기*/
select nvl(r.review_like,0)
from review_tb r;



/*검색 옵션에 따르는 쿼리문 작성*/

/*상품명, 예를들어 검색어: '바'*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
where a.art_name like '%바%'
order by r.review_time desc;


/*작가명, 예를들어 검색어: '홍'*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
where at.artist_name like '%홍%'
order by r.review_time desc;

/*태그명, 예를들어 검색어: '분위기'*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
where a.art_tag1 like '%분위기%' or a.art_tag2 like '%분위기%' or a.art_tag3 like '%분위기%'
order by r.review_time desc;

/*테마별 검색, 예를들어 테마: 추상화 선택*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
where a.art_theme = '추상화'
order by r.review_time desc;


/*정렬하기, 좋아요 높은 순서로 정렬*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
order by r.review_like desc;

/*정렬하기, 사진 있는 리뷰만 노출*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no
where (a.art_tag1 like '%분위기%' or a.art_tag2 like '%분위기%' or a.art_tag3 like '%분위기%')
and r.review_image IS NOT NULL;

/*정렬하기, 가격 높은 순서로 정렬 ------------- 미완성, 결제테이블과 협의 필요 */
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no;

/*정렬하기, 가격 낮은 순서로 정렬 ------------- 미완성, 결제테이블과 협의 필요*/
select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, r.review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
from review_tb r
inner join art_info_tb_test a
on r.art_no=a.art_no
inner join member_tb_test m
on r.mem_no=m.mem_no
inner join artist_info_tb_test at
on at.mem_no=a.mem_no;



 /*실시간 후기 중, 하루동안 좋아요 높은 3개 후기 선노출*/
 select * from (
 select r.mem_no, m.mem_name, r.review_no, r.review_time, r.review_image, nvl(r.review_like,0) review_like, r.review_text, a.art_name, a.art_theme , a.art_tag1 , a.art_tag2 ,a.art_tag3, at.ARTIST_NAME
 from review_tb r
 inner join art_info_tb_test a
 on r.art_no=a.art_no
 inner join member_tb_test m
 on r.mem_no=m.mem_no
 inner join artist_info_tb_test at
 on at.mem_no=a.mem_no
 where TO_CHAR(r.review_time) = TO_CHAR(sysdate)
 order by review_like desc
 )
 where rownum<=3;
 
 /*해결 완료!*/

