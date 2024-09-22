--[ORACLE TABLE] CLOUDMEMBER
CREATE TABLE CLOUDMEMBER (
    id VARCHAR2(15) PRIMARY KEY,    -- 아이디, 필수, 기본키
    pwd VARCHAR2(255) NOT NULL,     -- 비밀번호, 필수
    name VARCHAR2(50) NOT NULL,     -- 이름, 필수
    gender CHAR(1) NOT NULL,        -- 성별, 필수
    email1 VARCHAR2(100),           -- 이메일 아이디
    email2 VARCHAR2(100),           -- 이메일 주소
    tel1 VARCHAR2(3),               -- 전화번호 앞자리
    tel2 VARCHAR2(4),               -- 전화번호 중간자리
    tel3 VARCHAR2(4),               -- 전화번호 뒷자리
    zipcode VARCHAR2(20),           -- 우편번호
    addr1 VARCHAR2(255),            -- 주소
    addr2 VARCHAR2(255),            -- 상세주소
    logtime DATE					-- 가입일
);

--[커뮤니티 테이블]
CREATE TABLE CLOUDCOMMUNITY (
    seq NUMBER NOT NULL, 				-- 글번호 (시퀀스 객체 이용)
    id VARCHAR2(20) NOT NULL, 			-- 아이디
    name VARCHAR2(40) NOT NULL, 		-- 이름
    email VARCHAR2(40), 				-- 이메일
    subject VARCHAR2(255) NOT NULL, 	-- 제목
    content VARCHAR2(4000) NOT NULL,	-- 내용 
    file_path VARCHAR2(500),                -- 사진 경로 저장
    ref NUMBER NOT NULL, 				-- 그룹번호
    lev NUMBER DEFAULT 0 NOT NULL, 		-- 단계
    step NUMBER DEFAULT 0 NOT NULL,		-- 글순서
    pseq NUMBER DEFAULT 0 NOT NULL, 	-- 원글번호
    reply NUMBER DEFAULT 0 NOT NULL, 	-- 답변수
    hit NUMBER DEFAULT 0, 				-- 조회수
    logtime DATE DEFAULT SYSDATE		-- 작성일
);

--[커뮤니티 시퀀스]
CREATE SEQUENCE seq_community
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

--커뮤니티 페이징
SELECT * FROM (SELECT ROWNUM RN, TT.* FROM (SELECT * FROM CLOUDCOMMUNITY ORDER BY seq DESC) TT) WHERE RN >= 1 AND RN <= 5;
--a태그를 위한 count
select count(*) from CLOUDCOMMUNITY;
--게시판 답글
-- 원글의 정보를 가져옵니다
SELECT ref, lev, step 
INTO :ref, :lev, :step
FROM board
WHERE seq = :parentSeq; -- 원글의 seq 값을 입력

-- 답글의 step 값을 조정합니다
UPDATE board
SET step = step + 1
WHERE ref = :ref AND step > :step;

-- 답글을 삽입합니다
INSERT INTO CLOUDCOMMUNITY (
    seq, id, name, email, subject, content, ref, lev, step, pseq, reply, hit, logtime
) VALUES (
    board_seq.NEXTVAL, -- 시퀀스 객체를 사용하여 새로운 seq 생성
    :id, 
    :name, 
    :email, 
    :subject, 
    :content, 
    :ref,  -- 원글의 ref 값
    :lev,  -- 원글의 lev + 1
    :step + 1, -- 원글의 step + 1
    :parentSeq, -- 원글의 seq 값
    0, -- 답변수 초기값
    0, -- 조회수 초기값
    SYSDATE -- 작성일
);




--게시판 작성
INSERT INTO BOARD (SEQ, ID, NAME, EMAIL, REF, SUBJECT, CONTENT) VALUES (seq_board.NEXTVAL, 'CODELILY', '코드', 'email@naver.com', seq_board.NEXTVAL, 'TT', 'EE');
--회원 목록 선택
select * from cloudmember;
delete from cloudmember where id = 'soso';
commit;
SELECT ID FROM CLOUDMEMBER WHERE NAME = '김태훈' AND EMAIL1 = 'codelily' AND EMAIL2 = 'naver';

