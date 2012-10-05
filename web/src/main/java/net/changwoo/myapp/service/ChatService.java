package net.changwoo.myapp.service;

import java.util.List;

import net.changwoo.myapp.entity.Join;
import net.changwoo.myapp.entity.Message;
import net.changwoo.myapp.entity.Room;


public interface ChatService {

	public int saveMessage(Message message) throws Exception;
	public List findMessage(int roomid) throws Exception;
	public int saveJoin(Join join) throws Exception;
	public List findUserJoins(int userid) throws Exception;
	public List findRoomJoins(int roomid) throws Exception;
	public void deleteJoin(int userid, int roomid) throws Exception;
	public int saveRoom(Room room) throws Exception;
	public List findRooms() throws Exception;
	public void updateRoom(Room room) throws Exception;
	public void deleteRoom(int userid, int roomid) throws Exception;
	
}
