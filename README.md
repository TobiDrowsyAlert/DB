# DB 

## table
### 개인 테이블
<pre>
<code>
create table tbl_personal (
	user_id varchar(45),   # 사용자 아이디   프라이머리키
    blink_avg int,         # 눈 깜빡임 평균횟수
    yawn_num int,          # 하품 횟수
    eye_ear double,        # 눈 비율
    mouth_ear double,      # 입 비율
    constraint user_id primary key (user_id)
    
    );
  </code>
  </pre>
    
   
### 통계 테이블
<pre>
<code>
create table tbl_static (
	static_no int not null primary key,           # 통계 인덱스
    blind int,                            # 장 시간 눈감은 횟수
    blink int,                            # 눈 깜빡임
    user_id varchar(45) not null,         # 사용자 아이디
    driver_miss int,                      # 운전자 이탈 횟수
    stage int,                            # 졸음 단계
    time datetime,                        # 현재 시간 ( 졸음 발생 시간)
    driving_time time,                    # 주행시간
    yawn_num int,                         # 하품 횟수
    feedback boolean,                     # 졸음 여부
    pitch double,                         # pitch
    roll double,                          # roll
    yaw double,                           # yaw
    reason varchar(45)                    # 졸음 발생 원인
	);
  </code>
  </pre>
   
### 회원 테이블
<pre>
<code>
create table tbl_member (
	user_id varchar(45),                      # 사용자 아이디
    user_pw varchar(45),                      # 사용자 비밀번호
    name varchar(45),                         # 이름
    email varchar(45),                        # 이메일
    Session_k varchar(45),                    # 세션 키
    m_check int,                                # 체크용
    constraint user_id primary key (user_id)
);
</code>
</pre>


## procedure 
### 테이블 데이터 삽입

<pre>
<code>
delimiter //
create procedure tbl_member_insert(
in u_user_id varchar(45), 
in u_user_pw varchar(45),
in u_name varchar(45), 
in u_email varchar(45), 
in u_session_k varchar(45))
	begin
    insert into tbl_member values(u_user_id, u_user_pw, u_name, u_email, u_session_k);
	end //
delimiter ;
</code>
</pre>

###### 사용 방법 
<pre>
<code>
call tbl_member_insert()
</code>
</pre>
###### 매개변수에 사용자 id, 비밀번호, 이름, 이메일, 세션키 순으로 입력하면 된다. 
###### ★각 테이블 마다 INSERT 존재★
###### 예시 
<pre>
<code>
call tbl_member_insert('hongki','1234','홍기','hongki@naver.com','3');
</code>
</pre>


### 테이블 데이터 삭제

<pre>
<code>
delimiter //
create procedure tbl_member_delete(in u_user_id varchar(45))
	begin
    delete from tbl_member where user_id = u_user_id;   
    end //
delimiter ;
</code>
</pre>

###### 사용 방법

<pre>
<code>
call tbl_member_delete()
</code>
</pre>

###### 예시
<pre>
<code>
call tbl_member_delete('hongki')
</code>
</pre>

###### hongki 라는 사용자 아이디를 가진 회원의 정보를 삭제한다.


### 테이블 데이터 읽기

<pre>
<code>
delimiter //
create procedure tbl_member_read()
	begin
    select * from tbl_member;  
    end //
delimiter ;
</code>
</pre>

##### 사용 방법
<pre>
<code>
call tbl_member_read()
</code>
</pre>


### 테이블 데이터 업데이트

<pre>
<code>
delimiter //
create procedure tbl_member_update(
in u_user_id varchar(45),
in u_user_pw varchar(45),
in u_name varchar(45),
in u_email varchar(45),
in u_session_k varchar(45)
)
	begin
    update tbl_member set user_pw = u_user_pw, name = u_name, email = u_email, 
    session_k = u_session_k where user_id = u_user_id;
    end //
delimiter ;
</code>
</pre>

##### 사용 방법

<pre>
<code>
call tbl_member_update('hongki','1234','홍기','hongki@naver.com','3')
</code>
</pre>

###### hongki 라는 사용자 정보를 비밀번호, 이름, 이메일, 세션을 모두 변경, 업데이트 한다.


## 로그인
<pre>
<code>
delimiter //
create procedure login(
in u_user_id varchar(45), 
in u_user_pw varchar(45),
out m_massage varchar(20)
)
begin
    select m_check
    into m_massage
    from tbl_member
    where user_id = u_user_id and user_pw = u_user_pw;
    
	if m_massage = 1 then 
		set m_massage = '로그인 성공';
	else
		set m_massage = '로그인 실패';
	end if;    
end//
delimiter ;
</code>
</pre>

##### 사용 방법
<pre>
<code>
call login('rlgus', '1245',@m_massage);    #  성공
select @m_massage; 	                       #  체크


call login('rlgussss','12121',@m_massage);  # 실패
select @m_massage;                          # 체크
</code>
</pre>

###### 설명 : member 테이블에 회원의 정보가 있을 시 m_massage에 성공이라 뜬다.
######        테이블에 회원의 정보가 없을 시 m_massage에 실패라 뜬다.

## 개인화 테이블 통계치 계산 프로시저

<pre>
<code>
delimiter //
create procedure test(
in blink int,                      # 눈 깜빡 이유일 때 값
in n int,                          # 통계 n
in u_user_id varchar(45),
in average int
)
	begin
    set average = 21 * 10 +  blink*(1/n);      # 계산식???
    # 업데이트하기
    update tbl_personal set blink_avg = average where user_id = u_user_id;
    end //
delimiter ;
</code>
</pre>

###### 사용 방법
<pre>
<code>
select * from tbl_personal;                # 변경 전 데이터
call test('1000','1','rlgus','0');         # 개인화 테이블 통계치 계산 중...
select * from tbl_personal;                # 변경 후 데이터

</code>
</pre>

###### 아직 미완성 최대한 빠르게 수정할 예정
