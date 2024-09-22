package member.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import member.dto.MemberDTO;

public class MemberDAO {
	private static MemberDAO memberDAO = new MemberDAO();
	private SqlSessionFactory sessionFactory;
	
	public static MemberDAO getInstance() {
		return memberDAO;
	}
	
	public MemberDAO() {
		try {
			Reader reader = Resources.getResourceAsReader("mybatis-config.xml"); // - 문자 단위
			sessionFactory = new SqlSessionFactoryBuilder().build(reader);		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
    
    public boolean checkIdExists(String id) {
        boolean exists = false;
        
        SqlSession sqlSession = sessionFactory.openSession();
        List<MemberDTO> list = sqlSession.selectList("memberSQL.checkIdExists", id);
        sqlSession.close();
        if(!list.isEmpty()) {
        	exists = true;
        }        
        return exists;
    }
    
    public boolean checkPwdExists(Map<String, String> map) {
        boolean exists = false;
        List<MemberDTO> list = new ArrayList<MemberDTO>();
        SqlSession sqlSession = sessionFactory.openSession();
        list = sqlSession.selectList("memberSQL.checkPwdExists", map);
        if(!list.isEmpty()) {
        	System.out.println(list);
        	exists = true;
        }
        sqlSession.close();
        
        return exists;
    }
    
    public boolean joinMember(MemberDTO memberDTO) {
    	boolean result = false;
    	int su = 0;
    	SqlSession sqlSession = sessionFactory.openSession();
    	su = sqlSession.insert("memberSQL.joinMember", memberDTO);
    	sqlSession.commit();
    	sqlSession.close();
    	if(su > 0) {
    		result = true;
    	}
    	return result;
    }
    
    public List<MemberDTO> loginMember(Map<String, String> map) {
    	List<MemberDTO> list = new ArrayList<MemberDTO>();
    	
    	SqlSession sqlSession = sessionFactory.openSession();
    	list = sqlSession.selectList("memberSQL.loginMember", map);
    	sqlSession.close();
    	
        return list;
    }
    
    public List<MemberDTO> getInfo(String id) {
    	List<MemberDTO> list = new ArrayList<MemberDTO>();
    	
    	SqlSession sqlSession = sessionFactory.openSession();
    	list = sqlSession.selectList("memberSQL.getInfo", id);
    	sqlSession.close();
    	return list;
    }
    
    public boolean updateInfo(MemberDTO memberDTO) {
    	boolean result = false;
    	int su = 0;    	
		
    	SqlSession sqlSession = sessionFactory.openSession();
		su = sqlSession.update("memberSQL.updateInfo", memberDTO);
		if(su > 0) {
			result = true;
		}
		sqlSession.commit();
		sqlSession.close();
    	return result;
    }
    
    public String searchId(Map<String, String> map) {
    	List<MemberDTO> list = new ArrayList<MemberDTO>();
    	String id = null;
    	SqlSession sqlSession = sessionFactory.openSession();
    	list = sqlSession.selectList("memberSQL.searchId", map);
    	if(!list.isEmpty()) {
    		id = list.get(0).getId();
    	}
    	sqlSession.close();
    	return id;
    }
    
    public String searchPwd(Map<String, String> map) {
    	List<MemberDTO> list = new ArrayList<MemberDTO>();
    	String pwd = null;
    	SqlSession sqlSession = sessionFactory.openSession();
    	list = sqlSession.selectList("memberSQL.searchPwd", map);
    	if(!list.isEmpty()) {
    		pwd = list.get(0).getPwd();
    	}
    	sqlSession.close();
    	return pwd;
    }
    
    public int deleteInfo(Map<String, String> map) {
    	int result = 0;
    	
    	SqlSession sqlSession = sessionFactory.openSession();
    	result = sqlSession.delete("memberSQL.deleteInfo", map);
    	sqlSession.commit();
    	sqlSession.close();
    	
    	return result > 0 ? 1 : 0;
    }
}
