http://blog.springsource.org/2012/05/16/spring-mvc-3-2-preview-chat-sample/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+SpringSourceTeamBlog+%28SpringSource_Team_Blog%29

### Overview

A chat sample using Spring MVC 3.2, Servlet-based, async request processing. Also see the [redis](https://github.com/rstoyanchev/spring-mvc-chat/tree/redis) branch for a distributed chat. 

### Note

There is a bug in Tomcat that affects this sample. Please, use Tomcat 7.0.32 or higher.

### Instructions

Eclipse users run `mvn eclipse:eclipse` and then import the project. Or just import the code as a Maven project into IntelliJ, NetBeans, or Eclipse.

### I have been Custom for ChatController

http://changwoo.net/bbs/bbsDetail.do?&num=626&bbs_name=spring&searchType=all&search=&nowPage=1

특정 userId에게만 메세지를 보내도록 수정하였다 

http://localhost:8080/spring-mvc-chat/mvc/chat?userId=0 
http://localhost:8080/spring-mvc-chat/mvc/chat?userId=1 
http://localhost:8080/spring-mvc-chat/mvc/chat?userId=2 
http://localhost:8080/spring-mvc-chat/mvc/chat?userId=3 

위와 같이 0~3까지의 userId가 get 요청하여 대기중일때 


http://localhost:8080/spring-mvc-chat/mvc/chat?message=tsssssssssssssssssest2&userId=1&userId=2 

위의 post 요청으로 userId가 1,2 request에게 tsssssssssssssssssest2라는 메세지를 전송하게 된다
get요청중인 userId가 1,2인 요청은 response를 받고 통신을 종료한다. 
하지만 userId가 1,2가 아닌 요청은 timeout 될때까지 response를 대기한다.
