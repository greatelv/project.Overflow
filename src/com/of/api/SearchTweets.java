/*
 * Copyright 2007 Yusuke Yamamoto
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

package com.of.api;

import twitter4j.*;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;

/**
 * @author Yusuke Yamamoto - yusuke at mac.com
 * @since Twitter4J 2.1.7
 */
@Path("/search")
public class SearchTweets {
    /**
     * Usage: java twitter4j.examples.search.SearchTweets [query]
     *
     * @param args search query
     */
	@GET
	@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
	@Path("/{keyword}")
    public String getSearch(@PathParam("keyword")final String keyword) {
        if (keyword == null) {
            System.out.println("java twitter4j.examples.search.SearchTweets [query]");
            System.exit(-1);
        }
        Twitter twitter = new TwitterFactory().getInstance();
        String json = "";
        try {
            Query query = new Query(keyword);
            QueryResult result;
            
            //Gson json = new Gson();
            
            //do {
                result = twitter.search(query);
                List<Status> tweets = result.getTweets();
                json = new Gson().toJson(tweets);
                /*for (Status tweet : tweets) {
                   System.out.println("@" + tweet.getUser().getScreenName() + " - " + tweet.getText());
                }*/
                
                System.out.println(json);
            //} while ((query = result.nextQuery()) != null);
            //System.exit(0);
        } catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to search tweets: " + te.getMessage());
            //System.exit(-1);
        }
		return json;
    }
}
