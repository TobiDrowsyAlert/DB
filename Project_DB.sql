use AWS_test;

# 개인 테이블
create table tbl_personal (
	user_id varchar(45),   # 사용자 아이디   프라이머리키
    blink_avg int,         # 눈 깜빡임 평균횟수
    yawn_num int,          # 하품 횟수
    eye_ear double,        # 눈 비율
    mouth_ear double,      # 입 비율
    constraint user_id primary key (user_id)
    # foreign key(user_id) references statistic_table(user_id)
    );
    
# 통계 테이블
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
    
# 회원 테이블 
create table tbl_member (
	user_id varchar(45),                      # 사용자 아이디
    user_pw varchar(45),                      # 사용자 비밀번호
    name varchar(45),                         # 이름
    email varchar(45),                        # 이메일
    Session_k varchar(45),                    # 세션 키
    constraint user_id primary key (user_id)
);

    
################################ 테스트용 데이터
    
desc tbl_static;   
select * from tbl_static;   
select user_id, stage, blink from tbl_static;

select distinct user_id from tbl_static; # 중복된 값 출력x

select * from tbl_static where user_id = 'rlgus';   # tbl_static 테이블에서 user_id가 rlgus 인것만 출력

insert into tbl_static values('1','10','5','rlgus','1','1','2020-01-12','00:42:00','12','1','21.972','14.2453','29.243','눈');
insert into tbl_static values('2','15','3','thdrl','3','2','2020-01-01','00:30:00','2','1','11.462','18.2863','19.276','하품');
insert into tbl_static values('3','6','8','thdrl','0','1','2020-01-06','00:28:00','5','0','15.532','21.2476','3.276','고개');
insert into tbl_static values('4','3','6','sgere','0','1','2020-02-02','00:55:00','7','0','13.232','32.2753','9.243','눈');
insert into tbl_static values('5','13','7','gdfwd','1','1','2020-01-30','01:02:00','9','1','12.872','34.2453','37.243','');

insert into tbl_static values('6','12','2','rlgus','2','2','2020-02-06','00:24:00','16','1','9.762','15.2573','9.243','고개');

################################ 테스트용 데이터
desc tbl_personal;
select * from tbl_personal;

insert into tbl_personal values('rlgus','10','5','12.643','42.586');
insert into tbl_personal values('thdrl','4','6','46.634','27.465');
insert into tbl_personal values('sgere','5','2','18.768','17.535');
insert into tbl_personal values('gdfwd','8','3','13.867','12.684');

desc tbl_member;
select * from tbl_member;

select concat(name , '님의 아이디는', user_id , '입니다.') from tbl_member;

################################ 테스트용 데이터

insert into tbl_member values('rlgus','1245','기현','rlgus@naver.com','4');
insert into tbl_member values('thdrl','5536','송기','thdrl@naver.com','2');
insert into tbl_member values('sgere','3462','동수','ehdtn@naver.com','6');
insert into tbl_member values('gdfwd','2435','영이','duddl@naver.com','5');

insert into tbl_member values('test','5321','테스트용','gdfge@naver.com','1');



select count(*) from tbl_static where user_id = 'rlgus';

select avg(blink) from tbl_static where user_id = 'rlgus';
select avg(blink) from tbl_static where user_id = 'thdrl';







################   porcedure 프로시져 ################


#####################   테이블 마다 삽입 함수
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

call tbl_member_insert()


delimiter //
create procedure tbl_static_insert(
in u_static_no int,
in u_blind int,
in u_blink int,
in u_id varchar(45),
in u_driver_miss int,
in u_stage int,
in u_time datetime,
in u_griving_time time,
in u_yawn_num int,
in u_feedback boolean,
in u_pitch double,
in u_roll double,
in u_yaw double,
in reason varchar(45)
)
	begin
    insert into tbl_static values(u_static_no, u_blind, u_blink, u_id, u_driver_miss ,
    u_stage, u_time, u_griving_time, u_yawn_num, u_feedback, u_pitch, u_roll, u_yaw, reason);
    end //
delimiter ;




delimiter //
create procedure tbl_personal_insert(
in u_user_id varchar(45), 
in u_blink_avg int,
in u_yawn_num int,
in u_eye_ear double,
in u_mouth_ear double
)
	begin
    insert into tbl_member values(u_user_id, u_blink_avg, u_yawn_num, u_eye_ear, u_mouth_ear);
	end //
delimiter ;





########################### 테이블 마다 삭제 함수 
delimiter //
create procedure tbl_personal_delete(in u_user_id varchar(45))
	begin
    delete from tbl_personal where user_id = u_user_id;   
    end //
delimiter ;

delimiter //
create procedure tbl_static_delete(in u_user_id varchar(45))
	begin
    delete from tbl_static where user_id = u_user_id;   
    end //
delimiter ;

delimiter //
create procedure tbl_member_delete(in u_user_id varchar(45))
	begin
    delete from tbl_member where user_id = u_user_id;   
    end //
delimiter ;



################## 테이블 마다 읽기 
delimiter //
create procedure tbl_member_read()
	begin
    select * from tbl_member;  
    end //
delimiter ;


delimiter //
create procedure tbl_static_read()
	begin
    select * from tbl_static;  
    end //
delimiter ;


delimiter //
create procedure tbl_personal_read()
	begin
    select * from tbl_personal;  
    end //
delimiter ;


################## 테이블 마다 업데이트

delimiter //
create procedure tbl_personal_update(
in u_user_id varchar(45),           # 사용자 아이디
in u_blink_avg int,                 # 사용자 눈깜빡임 평균 횟수 순으로 변수를 받는다.
in u_yawn_num int,
in u_eye_ear double,
in u_mouth_ear double 
)
	begin
    # 업데이트를 한다. 유저아이디가 같은 행을 입력받은 데이트 값으로 변경한다. 업데이트
    update tbl_personal set blink_avg = u_blink_avg , yawn_num = u_yawn_num,
    eye_ear = u_eye_ear, mouth_ear = u_mouth_ear where user_id = u_user_id;
    end //
delimiter ;

call tbl_personal_read();

call tbl_personal_update('rlgus','77','77','77.77','77.77');



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

call tbl_member_read();

call tbl_member_update('rlgus','1111','쏭기','rrrrr@naver.com','1');





#######################  tbl_static_insert 함수 매개변수 지정하여 삽입하기

call tbl_static_insert('17','56','56','tnduslds','7','7','2222-11-11','00:11:11',
'7','0','77.77','77.77','77.77','눈');

###################### tbl_static_read   스테틱 테이블 읽기
call tbl_static_read();


################################ 스테틱 테이블에 user_id가 thdrlslds 인 사람의 정보를 지운다.
call tbl_static_delete('tnduslds');




################################ 테스트용 데이터 업데이트  
update tbl_static set blind = '27' where static_no = '2';
select * from tbl_static;

################################ 테스트용 데이터 딜리트
select * from tbl_member;
delete from tbl_member where user_id = 'test';   # 유저아디가 test인것을 삭제 회원정보삭제
select * from tbl_member;



    # declare test_num1 int default 0;  # 변수 선언
	# set test_num1 = 11;               # 변수 값 변경
    



#########################      로그인(login), 회원가입(sign Up) 함수
delimiter //
create procedure login(
in u_user_id varchar(45), 
in u_user_pw varchar(45),
out u_check int
)
begin
	# select * from tbl_member where user_id = u_user_id and user_pw = u_user_pw;
	# set u_check = '1';
    select user_id
    from tbl_member
    where user_id = u_user_id and user_pw = u_user_pw;
    set @u_check = 1;
end//
delimiter ;

set @u_check = 0;
select @counter;

call login('rlgus', '1111','0');
select @u_check;

drop procedure login;

call tbl_member_read();




