package member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.control.CommandProcess;

import member.dao.MemberDAO;

public class SearchPwdService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        Map<String, String> map = new HashMap<String, String>();
    	map.put("id", id);
    	map.put("name", name);	
    	String[] emailSP = email.split("@");
        
        if (emailSP.length == 2) {
            String email1 = emailSP[0];
            String email2 = emailSP[1];
            
            System.out.println("email1 : " + email1);
            System.out.println("email2 : " + email2);
            
            map.put("email1", email1);
            map.put("email2", email2);
        } else {
            // 이메일 형식이 잘못된 경우 처리
            request.setAttribute("error", "유효하지 않은 이메일 형식입니다.");
            return "/member/searchPwd.jsp";  // 에러 메시지와 함께 JSP로 이동
        }
        
        MemberDAO memberDAO = MemberDAO.getInstance();
        String pwd = memberDAO.searchPwd(map);
        
        if (pwd != null) {
            request.setAttribute("pwd", pwd);  // 찾은 아이디를 request 객체에 저장
        } else {
            request.setAttribute("error", "가입 정보가 없습니다.");  // 오류 메시지 저장
        }
		
		return "/member/searchPwd.jsp";
	}
}
