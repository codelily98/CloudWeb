package member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.control.CommandProcess;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

public class JoinService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
	
        // 폼 데이터 가져오기
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String email1 = request.getParameter("email1");
        String email2 = request.getParameter("email2");
        String tel1 = request.getParameter("tel1");
        String tel2 = request.getParameter("tel2");
        String tel3 = request.getParameter("tel3");
        String zipcode = request.getParameter("zipcode");
        String addr1 = request.getParameter("addr1");
        String addr2 = request.getParameter("addr2");

        // DTO 객체 생성 및 데이터 설정
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(id);
        memberDTO.setPwd(pwd);
        memberDTO.setName(name);
        memberDTO.setGender(gender);
        memberDTO.setEmail1(email1);
        memberDTO.setEmail2(email2);
        memberDTO.setTel1(tel1);
        memberDTO.setTel2(tel2);
        memberDTO.setTel3(tel3);
        memberDTO.setZipcode(zipcode);
        memberDTO.setAddr1(addr1);
        memberDTO.setAddr2(addr2);

        // DAO 객체를 사용하여 회원가입 처리
        MemberDAO memberDAO = MemberDAO.getInstance();
        boolean result = memberDAO.joinMember(memberDTO);

	    request.setAttribute("result", result);
		return "/member/join.jsp";
	}
}
