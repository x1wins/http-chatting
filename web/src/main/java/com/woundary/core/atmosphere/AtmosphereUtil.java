package com.woundary.core.atmosphere;

import org.atmosphere.cpr.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.concurrent.CountDownLatch;

/**
 * Created with IntelliJ IDEA.
 * User: devteam01
 * Date: 5/31/13
 * Time: 8:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class AtmosphereUtil {

    public static final Logger LOG = LoggerFactory.getLogger(AtmosphereUtil.class);

    public static AtmosphereResource getAtmosphereResource(HttpServletRequest request) {
        return getMeteor(request).getAtmosphereResource();
    }
    public static Meteor getMeteor(HttpServletRequest request) {
        return Meteor.build(request);
    }
    public static void suspend(final AtmosphereResource resource, String targetUrl) {

        final CountDownLatch countDownLatch = new CountDownLatch(1);
        resource.addEventListener(new AtmosphereResourceEventListenerAdapter() {
            @Override
            public void onSuspend(AtmosphereResourceEvent event) {
                countDownLatch.countDown();
                LOG.info("Suspending Client..." + resource.uuid());
                resource.removeEventListener(this);
            }

            @Override
            public void onDisconnect(AtmosphereResourceEvent event) {
                LOG.info("Disconnecting Client..." + resource.uuid());
                super.onDisconnect(event);
            }

            @Override
            public void onBroadcast(AtmosphereResourceEvent event) {
                LOG.info("Client is broadcasting..." + resource.uuid());
                super.onBroadcast(event);
            }

        });

        AtmosphereUtil.lookupBroadcaster(targetUrl).addAtmosphereResource(resource);
        //AtmosphereUtils.lookupBroadcaster().getAtmosphereResources().

        if (AtmosphereResource.TRANSPORT.LONG_POLLING.equals(resource.transport())) {
            resource.resumeOnBroadcast(true).suspend(-1, false);
        } else {
            resource.suspend(-1);
        }

        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            LOG.error("Interrupted while trying to suspend resource {}", resource);
        }
    }

    public static void suspend(final AtmosphereResource resource) {

        final CountDownLatch countDownLatch = new CountDownLatch(1);
        resource.addEventListener(new AtmosphereResourceEventListenerAdapter() {
            @Override
            public void onSuspend(AtmosphereResourceEvent event) {
                countDownLatch.countDown();
                LOG.info("Suspending Client..." + resource.uuid());
                resource.removeEventListener(this);
            }

            @Override
            public void onDisconnect(AtmosphereResourceEvent event) {
                LOG.info("Disconnecting Client..." + resource.uuid());
                super.onDisconnect(event);
            }

            @Override
            public void onBroadcast(AtmosphereResourceEvent event) {
                LOG.info("Client is broadcasting..." + resource.uuid());
                super.onBroadcast(event);
            }

        });

        AtmosphereUtil.lookupBroadcaster().addAtmosphereResource(resource);
        //AtmosphereUtils.lookupBroadcaster().getAtmosphereResources().

        if (AtmosphereResource.TRANSPORT.LONG_POLLING.equals(resource.transport())) {
            resource.resumeOnBroadcast(true).suspend(-1, false);
        } else {
            resource.suspend(-1);
        }

        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            LOG.error("Interrupted while trying to suspend resource {}", resource);
        }
    }

    public static Broadcaster lookupBroadcaster(String targetUrl) {
        Broadcaster b = BroadcasterFactory.getDefault().get(targetUrl);
        return b;
    }

    public static Broadcaster lookupBroadcaster() {
        Broadcaster b = BroadcasterFactory.getDefault().get();
        return b;
    }
}
