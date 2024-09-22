package community.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class CommunityDAO {
	private static CommunityDAO communityDAO = new CommunityDAO();
	private SqlSessionFactory sessionFactory;
	
	public static CommunityDAO getInstance() {
		return communityDAO;
	}
	
	public CommunityDAO() {
		try {
			Reader reader = Resources.getResourceAsReader("mybatis-config.xml"); // - 문자 단위
			sessionFactory = new SqlSessionFactoryBuilder().build(reader);		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
