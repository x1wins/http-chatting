/*
 * User : pak1627
 * Date : 2013.
 */

package net.changwoo.myapp.service;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import org.atmosphere.cpr.AtmosphereResource;
import org.atmosphere.cpr.AtmosphereRequest;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.woundary.core.atmosphere.AtmosphereUtil;


/**
 * User: pak1627
 * Date: 6/7/13
 * Time: 9:06 AM
 */
public class PushService {
    protected ObjectMapper objectMapper = new ObjectMapper();

//    protected long getTargetUserId(HttpServletRequest request) {
//        UserDetailsImpl currentUser = UserDetailsUtils.getCurrentUser(request);
//        return currentUser == null ? -1 : currentUser.getId();
//    }
//
//    protected String getJsonString(Object obj, String callbackFunc) {
//        Gson gson = new Gson();
//
//        AtmosphereResult result = new AtmosphereResult();
//        result.setResultValue(obj);
//        result.setCallbackFunc(callbackFunc);
//
//        String json = gson.toJson(result);
//
//        return json;
//    }
//
    protected Collection<AtmosphereResource> getAtmosphereResource() {
        ServletRequestAttributes sra =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest req = sra.getRequest();
        AtmosphereResource resource = AtmosphereUtil.getAtmosphereResource(req);
        Collection<AtmosphereResource> atmosphereResources = resource.getBroadcaster()
                .getAtmosphereResources();

        return atmosphereResources;
    }
//    
//    public void prepare(HashMap<String, Object> pushData) {
//
//        String callbackFunc = (String) pushData.get("callbackFunc");
//        Long currentUser = Long.parseLong(pushData.get("currentUser")
//                .toString());
//
//        List<Participant> participants =
//                (List<Participant>) pushData.get("participants");
//        List<Participant> participantList = new ArrayList<Participant>();
//
//        for(int i = 0; i < participants.size(); i++) {
//            participantList.add(objectMapper.convertValue(participants.get
//                    (i), Participant.class));
//        }
//
//        this.talkPush.setClientFunctionName(callbackFunc);
//        this.talkPush.setCurrentMemberId(currentUser);
//        this.talkPush.setParticipants(participantList);
//
//        Integer notiType = (Integer) pushData.get(NotificationType.THIS);
//
//        switch(notiType.intValue()) {
//            case NotificationType.TALK.SEND_MEDIA:
//                List<Talk> talks = (List<Talk>) pushData.get("talkList");
//                List<Talk> talkList = new ArrayList<Talk>();
//                for( int i = 0; i < talks.size(); i++) {
//                    Talk talk = objectMapper.convertValue(talks.get(i), Talk.class);
//
//                    if(talk.getRegistrationDate() == null) {
//                        talk.setRegistrationDate(new Date());
//                    }
//
//                    talkList.add(talk);
//                }
//
//                this.talkPush.setTalkOrRoom(talkList);
//
//                break;
//            case NotificationType.TALK.REGIST_NOTICE :
//                TalkRoom room = objectMapper.convertValue(pushData.get("room"),
//                        TalkRoom.class);
//
//                this.talkPush.setTalkOrRoom(room);
//                break;
//            default:
//                Talk talk =  objectMapper.convertValue(pushData.get("talk"),
//                        Talk.class);
//
//                this.talkPush.setTalkOrRoom(talk);
//                break;
//        }
//    }
//
    public void push() {
        ServletRequestAttributes sra =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest req = sra.getRequest();
        AtmosphereResource resource = AtmosphereUtil.getAtmosphereResource(req);
        resource.getBroadcaster().getAtmosphereResources().size();

//        final List<Participant> participants = this.talkPush.getParticipants();
//        final String clientFunctionName = this.talkPush.getClientFunctionName();
//        final Object obj = this.talkPush.getTalkOrRoom();
//        final long currentMemberId = this.talkPush.getCurrentMemberId();

        Collection<AtmosphereResource> atmosphereResources = resource.getBroadcaster()
                .getAtmosphereResources();
        for (AtmosphereResource r : atmosphereResources) {

            if (null != r.getRequest()) {
                AtmosphereRequest request = r.getRequest();

//                    if (member.getId() == opponentId) {
//                        String json = this.getJsonString(obj, clientFunctionName);
//                        r.getBroadcaster().broadcast(json, r);
//                    }
			}
		}
	}
}
