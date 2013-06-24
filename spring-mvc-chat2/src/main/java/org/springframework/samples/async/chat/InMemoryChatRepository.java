/*
 * Copyright 2002-2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.samples.async.chat;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

@Repository
public class InMemoryChatRepository implements ChatRepository {

	private final List<String> messages = new CopyOnWriteArrayList<String>();
	
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

	public int getListSize() {
		return this.messages.size();
	}
	
	public List<String> getLastMessages() {
		if (this.messages.isEmpty()) {
			logger.info("this.messages.isEmpty()");
			return Collections.<String> emptyList();
		}
		logger.info("this.messages.subList(index, this.messages.size()");
		int lastNum = getListSize()-1;
		
		if(lastNum<0) lastNum = 0;
		
		return this.messages.subList(lastNum, this.messages.size());
	}
	
	public List<String> getMessages(int index) {
		if (this.messages.isEmpty()) {
			logger.info("this.messages.isEmpty()");
			return Collections.<String> emptyList();
		}
		Assert.isTrue((index >= 0) && (index <= this.messages.size()), "Invalid message index");
		logger.info("this.messages.subList(index, this.messages.size()");
		return this.messages.subList(index, this.messages.size());
	}

	public void addMessage(String message) {
		this.messages.add(message);
	}

}
