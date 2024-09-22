package member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.control.CommandProcess;

import member.dao.MemberDAO;

public class CheckPwdService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
	    boolean exists = false;
	    
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
	    
	    if (pwd != null && !pwd.trim().isEmpty()) {
	        MemberDAO memberdao = MemberDAO.getInstance();
	        exists = memberdao.checkPwdExists(map);
	        
	        System.out.println("나는 비번 체크 : " + exists);
	    }
		
	    request.setAttribute("exists", exists);		
		return "/member/checkPwd.jsp";
	}
}
