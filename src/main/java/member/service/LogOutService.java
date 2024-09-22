package member.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.control.CommandProcess;

public class LogOutService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		HttpSession session = request.getSession();
		session.removeAttribute("memName");
		session.removeAttribute("memId");
		session.removeAttribute("memEmail");
		
		return "/member/logout.jsp";
	}
}
