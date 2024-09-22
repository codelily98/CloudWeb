package member.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberDTO {
	private String id;        // 아이디
    private String pwd;       // 비밀번호
    private String name;      // 이름
    private String gender;    // 성별
    private String email1;    // 이메일 아이디
    private String email2;    // 이메일 주소
    private String tel1;      // 전화번호 앞자리
    private String tel2;      // 전화번호 중간자리
    private String tel3;      // 전화번호 뒷자리
    private String zipcode;   // 우편번호
    private String addr1;     // 주소
    private String addr2;     // 상세주소
    private String logtime;
}
