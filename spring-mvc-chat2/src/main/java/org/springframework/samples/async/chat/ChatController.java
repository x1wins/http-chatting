package org.springframework.samples.async.chat;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;

@Controller
@RequestMapping("/mvc/chat")
public class ChatController {

	private final ChatRepository chatRepository;

	private final Map<DeferredResult<List<String>>, Integer> chatRequests =
			new ConcurrentHashMap<DeferredResult<List<String>>, Integer>();

	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

	@Autowired
	public ChatController(ChatRepository chatRepository) {
		this.chatRepository = chatRepository;
	}
	
	/*
	 * http://localhost:8080/spring-mvc-chat/mvc/chat?userId=0
	 * http://localhost:8080/spring-mvc-chat/mvc/chat?userId=1
	 * http://localhost:8080/spring-mvc-chat/mvc/chat?userId=2
	 * http://localhost:8080/spring-mvc-chat/mvc/chat?userId=3
	 */
	@RequestMapping(method=RequestMethod.GET)
	@ResponseBody
	public DeferredResult<List<String>> getMessages(@RequestParam int userId) {

		final DeferredResult<List<String>> deferredResult = new DeferredResult<List<String>>(null, Collections.emptyList());
		this.chatRequests.put(deferredResult, userId);
		
		logger.info("userId : " + userId);

		deferredResult.onCompletion(new Runnable() {
			@Override
			public void run() {
				chatRequests.remove(deferredResult);
				logger.info("deferredResult.onCompletion(new Runnable())");
			}
		});
		
		deferredResult.onTimeout(new Runnable() {
			@Override
			public void run() {
				logger.info("deferredResult.onTimeout(new Runnable())");
			}
		});
		
		return deferredResult;
	}

	/*
	 * http://localhost:8080/spring-mvc-chat/mvc/chat?message=tsssssssssssssssssest2&userId=1&userId=2
	 */
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public void postMessage(@RequestParam String message, @RequestParam(value="userId", required=true) List<Integer> userIds) {

		this.chatRepository.addMessage(message);
		
		// Update all chat requests as part of the POST request
		// See Redis branch for a more sophisticated, non-blocking approach

		for (Entry<DeferredResult<List<String>>, Integer> entry : this.chatRequests.entrySet()) {
			
			List<String> messages = this.chatRepository.getLastMessages();
			logger.info("entry.getValue() : "+entry.getValue() + "entry.getKey() : "+entry.getKey());
			
			for(int userId : userIds) {
				if(userId == entry.getValue()) {				
					entry.getKey().setResult(messages);
					logger.info("success - entry.getValue() : "+entry.getValue() + "entry.getKey() : "+entry.getKey() + " messages : " + messages);
				}
			}
			
		}		
	}

}
