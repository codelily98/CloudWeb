package community.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.control.CommandProcess;

public class CommunityWriteFormService implements CommandProcess {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		return "/community/communityWriteForm.jsp";
	}
}
