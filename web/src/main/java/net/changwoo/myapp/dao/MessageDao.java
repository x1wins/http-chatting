package net.changwoo.myapp.dao;

import net.changwoo.myapp.entity.Message;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MessageDao extends GenericDaoImpl<Message, Integer> {

	@Autowired
	MessageDao(SessionFactory sf) {
		super(sf);
	}

	@Override
	protected Class<Message> getEntityClass() {
		return Message.class;
	}
	
}