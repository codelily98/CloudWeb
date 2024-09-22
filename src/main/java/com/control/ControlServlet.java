package com.control;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
	urlPatterns = {"*.do"}, 
	initParams = {
		@WebInitParam(name="propertyConfig", value="command.properties")
	}
)
public class ControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, Object> map = new HashMap<String, Object>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		String propertyConfig = config.getInitParameter("propertyConfig");
		System.out.println("propertyConfig : " + propertyConfig);
		
		//@WebServlet으로 서블릿을 등록했을 때만 작성 (어노테이션)
		String realFolder = config.getServletContext().getRealPath("/WEB-INF");
		String realPath = realFolder + "/" + propertyConfig;
		System.out.println("realPath : " + realPath);
		
		//command.properties의 파일의 내용을 읽어서 Map에 보관
		FileInputStream fin = null;
		Properties properties = new Properties();
		
		try {
			//web.xml로 등록시
			//fin = new FileInputStream(propertyConfig);
			//@WebServlet으로 어노테이션 시
			fin = new FileInputStream(realPath);
			properties.load(fin); //읽어온 fin을 properties에 보관
			System.out.println("properties = "+ properties);

		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				fin.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println();
		
		//properties에 똑같은 내용이 들어왔다면 KeySet 중복된 것을 제거 -> set형식으로 바꾸고 -> iterator로 접근해서 
		//it.hasNext()로 Key값을 꺼내온다. 
		Iterator<Object> it = properties.keySet().iterator();
		while(it.hasNext()) {
			String key = (String)it.next();
			System.out.println("key = "+key);

			String className = properties.getProperty(key);
			System.out.println("className = "+className);

			try {
				Class<?> classType = Class.forName(className); //뭐가 들어왔음?
				Object ob = classType.getConstructor().newInstance(); //들어온거 Object로 바꿔라

				System.out.println("ob = "+ ob);

				map.put(key, ob);

			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
            } catch (IllegalArgumentException e) {
            	e.printStackTrace();
            } catch (InvocationTargetException e) {
            	e.printStackTrace();
            } catch (NoSuchMethodException e) {
            	e.printStackTrace();
            } catch (SecurityException e) {
                e.printStackTrace();
            }

            System.out.println();
		}//while
	}

	//GET방식 요청 execute로
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	
	//POST방식 요청 execute로
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println();
		
		if(request.getMethod().equals("POST")) { //POST방식 요청 한글 설정
			request.setCharacterEncoding("UTF-8");
		}
		
		//http:localhost:8080/memberMVC/member/joinForm.do
		//요청한 URL에서 "/member/joinForm.do" 뜯어오기
		String category = request.getServletPath();
		System.out.println(category);
		
		//Map<K, V>를 이용하여 Key에 해당하는 값(V)을 꺼내온다. member.service.joinFormService
		CommandProcess com = (CommandProcess) map.get(category); //자식 = (자식) 부모 -> 캐스팅
		
		String view = null;
		try {
			view = com.requestPro(request, response);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		//forward
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(view); //상대번지
		requestDispatcher.forward(request, response); //제어권 넘기기
	}
}
