package net.changwoo.myapp.dao;

import net.changwoo.myapp.entity.User;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class UserDao extends GenericDaoImpl<User, Integer> {

	@Autowired
	UserDao(SessionFactory sf) {
		super(sf);
	}

	@Override
	protected Class<User> getEntityClass() {
		return User.class;
	}
	
}