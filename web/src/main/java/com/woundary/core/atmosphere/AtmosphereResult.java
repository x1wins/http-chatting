/*
 * User : pak1627
 * Date : 2013.
 */

package com.woundary.core.atmosphere;

/**
 * Created with IntelliJ IDEA.
 * User: pak1627
 * Date: 6/6/13
 * Time: 12:38 PM
 * To change this template use File | Settings | File Templates.
 */
public class AtmosphereResult {

    private Object resultValue;
    private String callbackFunc;

    public Object getResultValue() {
        return resultValue;
    }

    public void setResultValue(Object resultValue) {
        this.resultValue = resultValue;
    }

    public String getCallbackFunc() {
        return callbackFunc;
    }

    public void setCallbackFunc(String callbackFunc) {
        this.callbackFunc = callbackFunc;
    }
}
