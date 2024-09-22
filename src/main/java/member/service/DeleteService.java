package member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.control.CommandProcess;

import member.dao.MemberDAO;

public class DeleteService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		int su = memberDAO.deleteInfo(map);
		
		System.out.println("나는 삭제 su : " + su);
		
		boolean result = false;
		
		if(su > 0) {
			session.invalidate();
			
			result = true;
		}
		
		request.setAttribute("result", result);
		return "/member/delete.jsp";
	}
}
