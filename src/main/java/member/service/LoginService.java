package member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.control.CommandProcess;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

public class LoginService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setCharacterEncoding("UTF-8");
	    String id = request.getParameter("id");
	    String pwd = request.getParameter("pwd");
	    
	    MemberDAO memberDAO = MemberDAO.getInstance();
	    Map<String, String> map = new HashMap<String, String>();
	    map.put("id", id);
	    map.put("pwd", pwd);
	    List<MemberDTO> list = memberDAO.loginMember(map);
	    
	    System.out.println("나는야 로그인 정보 LSIT : " + list);
	    
	    if(list.isEmpty()) {
	    	return "./loginfail.jsp";
	    } else {
		    HttpSession session = request.getSession();
		    
	        String email = list.get(0).getEmail1() + "@" + list.get(0).getEmail2();
	        String name = list.get(0).getName();
	        
	        session.setAttribute("memId", id);
	        session.setAttribute("memName", name);
	        session.setAttribute("memEmail", email);
		    
	        session.setAttribute("list", list);
	        
			return "./login.jsp";
	    }
	}
}
