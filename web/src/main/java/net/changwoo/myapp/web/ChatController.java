package net.changwoo.myapp.web;

import java.util.List;
import java.util.Locale;

import javax.validation.Valid;

import net.changwoo.myapp.common.Common;
import net.changwoo.myapp.entity.Join;
import net.changwoo.myapp.entity.JsonResponse;
import net.changwoo.myapp.entity.Message;
import net.changwoo.myapp.entity.Room;
import net.changwoo.myapp.service.ChatServiceImpl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/chat")
public class ChatController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
    private ChatServiceImpl chatService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	
//	@RequestMapping(value = "/processSendTalk", method = RequestMethod.POST)
//	public String processSendTalk(Long roomId, Long memberId,
//                                      String message) throws Exception {
//
//
//        HashMap<String,Object> notificationMap = new HashMap<String, Object>();
//        notificationMap.put("participants",talk.getTalkRoom().getParticipants());
//        notificationMap.put("talk",talk);
//        notificationMap.put("currentUser", getCurrentUser().getId());
//        notificationMap.put(NotificationType.THIS, NotificationType.TALK.SEND);
//
//        this.atmosphereBroadcaster.sendNotification(notificationMap);
//
//        JsonResponse res = new JsonResponse();
//		try{
//			int check = chatService.saveMessage(message);
//			if(!result.hasErrors() && check!=0){
//				res.setStatus(Common.SUCCESS);
//				res.setResult(message);
//			}else{
//				res.setStatus(Common.FAIL);
//				res.setResult(result.getAllErrors());
//			}
//		}catch(Exception e){
//			logger.debug(e.getMessage());
//			res.setStatus(Common.FAIL);
//			res.setResult(e.getMessage());
//		}
//		model.addAttribute("res",res);
//		return "jsonView";
//	}
	
	/*
	 * test url
	 * http://localhost:8080/ggaggao/chat/message/save?content=hihi&userid=34&roomid=4
	 */
	@RequestMapping(value = "/message/save", method = RequestMethod.POST)
	public String saveMessage(Locale locale, @Valid Message message, BindingResult result, Model model) {
		
		JsonResponse res = new JsonResponse();
		try{
			int check = chatService.saveMessage(message);
			if(!result.hasErrors() && check!=0){
				res.setStatus(Common.SUCCESS);
				res.setResult(message);
			}else{
				res.setStatus(Common.FAIL);
				res.setResult(result.getAllErrors());
			}
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * test url
	 * http://localhost:8080/ggaggao/chat/message/find/4
	 */
	@RequestMapping(value = "/message/find/{roomid}", method = RequestMethod.GET)
	public String findMessage(Locale locale, Model model, @PathVariable("roomid") int roomid) {
		
		logger.debug("roomid = "+roomid);
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			List messages = chatService.findMessage(roomid);
			res.setResult(messages);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/join/save?userid=33&roomid=4
	 */
	@RequestMapping(value = "/join/save", method = RequestMethod.POST)
	public String saveJoin(Locale locale, @Valid Join join, BindingResult result, Model model) {
		JsonResponse res = new JsonResponse();
		try{
			int check = chatService.saveJoin(join);
			if(!result.hasErrors() && check!=0){
				res.setStatus(Common.SUCCESS);
				res.setResult(join);
			}else{
				res.setStatus(Common.FAIL);
				res.setResult(result.getAllErrors());
			}
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	/*
	 * http://localhost:8080/ggaggao/chat/join/find/userid/33
	 */
	@RequestMapping(value = "/join/find/userid/{userid}", method = RequestMethod.GET)
	public String findUserJoins(Locale locale, Model model, @PathVariable("userid") int userid) {
		
		logger.debug("userid = "+userid);
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			List joins = chatService.findUserJoins(userid);
			res.setResult(joins);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/join/find/roomid/4
	 */
	@RequestMapping(value = "/join/find/roomid/{roomid}", method = RequestMethod.GET)
	public String findRoomJoins(Locale locale, Model model, @PathVariable("roomid") int roomid) {
		
		logger.debug("roomid = "+roomid);
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			List joins = chatService.findRoomJoins(roomid);
			res.setResult(joins);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/join/delete/51/4
	 */
	@RequestMapping(value = "/join/delete/{userid}/{roomid}", method = RequestMethod.POST)
	public String deleteJoin(Locale locale, Model model, @PathVariable("userid") int userid, @PathVariable("roomid") int roomid) {
		logger.debug("userid = "+userid);
		logger.debug("roomid = "+roomid);
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			chatService.deleteJoin(userid, roomid);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/room/save?subject=test room&masterUserid=12
	 */
	@RequestMapping(value = "/room/save", method = RequestMethod.POST)
	public String saveRoom(Locale locale, @Valid Room room, BindingResult result, Model model) {
		JsonResponse res = new JsonResponse();
		try{
			int check = chatService.saveRoom(room);
			if(!result.hasErrors() && check!=0){
				res.setStatus(Common.SUCCESS);
				res.setResult(room);
			}else{
				res.setStatus(Common.FAIL);
				res.setResult(result.getAllErrors());
			}
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/room/find
	 */
	@RequestMapping(value = "/room/find", method = RequestMethod.GET)
	public String findRoom(Locale locale, Model model) {
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			List rooms = chatService.findRooms();
			res.setResult(rooms);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/room/delete/12/1
	 */
	@RequestMapping(value = "/room/delete/{userid}/{roomid}", method = RequestMethod.POST)
	public String deleteRoom(Locale locale, Model model, @PathVariable("userid") int userid, @PathVariable("roomid") int roomid) {
		logger.debug("userid = "+userid);
		logger.debug("roomid = "+roomid);
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			chatService.deleteRoom(userid, roomid);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
	/*
	 * http://localhost:8080/ggaggao/chat/room/update?subject=qqqq&masterUserid=12&id=4
	 */
	@RequestMapping(value = "/room/update", method = RequestMethod.POST)
	public String updateRoom(Locale locale, @Valid Room room, BindingResult result, Model model) {
		logger.debug("room.getSubject() = "+room.getSubject());
		logger.debug("room.getMasterUserid = "+room.getMasterUserid());
		
		JsonResponse res = new JsonResponse();
		String status = Common.SUCCESS;
		
		try{
			chatService.updateRoom(room);
			res.setStatus(status);
		}catch(Exception e){
			logger.debug(e.getMessage());
			res.setStatus(Common.FAIL);
			res.setResult(e.getMessage());
		}
		model.addAttribute("res",res);
		return "jsonView";
	}
	
}
