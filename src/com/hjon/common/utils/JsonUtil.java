//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.hjon.common.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonUtil {
    public JsonUtil() {
    }

    public static Map<String, Object> jsonToMap(JSONObject jsonObj) throws JSONException {
        HashMap jsonMap = new HashMap();
        Iterator jsonKeys = jsonObj.keys();

        while(jsonKeys.hasNext()) {
            String jsonKey = (String)jsonKeys.next();
            Object jsonValObj = jsonObj.get(jsonKey);
            if(jsonValObj instanceof JSONArray) {
                jsonMap.put(jsonKey, jsonToList((JSONArray)jsonValObj));
            } else if(jsonValObj instanceof JSONObject) {
                jsonMap.put(jsonKey, jsonToMap((JSONObject)jsonValObj));
            } else {
                jsonMap.put(jsonKey, jsonValObj);
            }
        }

        return jsonMap;
    }

    public static List<?> jsonToList(JSONArray jsonArr) throws JSONException {
        ArrayList jsonToMapList = new ArrayList();

        for(int i = 0; i < jsonArr.length(); ++i) {
            Object object = jsonArr.get(i);
            if(object instanceof JSONArray) {
                jsonToMapList.add(jsonToList((JSONArray)object));
            } else if(object instanceof JSONObject) {
                jsonToMapList.add(jsonToMap((JSONObject)object));
            } else {
                jsonToMapList.add(object);
            }
        }

        return jsonToMapList;
    }
}
