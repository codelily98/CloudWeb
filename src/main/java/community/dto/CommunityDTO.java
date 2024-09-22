package community.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommunityDTO {
    private int seq;              // 글번호
    private String id;            // 아이디
    private String name;          // 이름
    private String email;         // 이메일
    private String subject;       // 제목
    private String content;       // 내용
    private String filePath;      // 사진 경로 저장
    private int ref;              // 그룹번호
    private int lev;              // 단계
    private int step;             // 글순서
    private int pseq;             // 원글번호
    private int reply;            // 답변수
    private int hit;              // 조회수
    private String logtime;         // 작성일
}