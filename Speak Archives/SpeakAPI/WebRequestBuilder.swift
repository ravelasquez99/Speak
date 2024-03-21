//
//  WebRequestBuilder.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import Foundation

public final class WebRequestBuilder {
    public static func buildRecordKickoffWebRequest() -> URLRequest {
        /**
        Normally I would do a request builder class, header builder, etc. But to save time I am doing this all in this function
         */
        let url = URL(
            string: "wss://speak-api--feature-mobile-websocket-interview.preview.usespeak.dev/v2/ws"
        )! //force unwrapping for convenience. Would normally have a URL builder class

        var request = URLRequest(url: url)
        
        //Build headers (normally in a request builder class)
        request.addValue(
            "DFKKEIO23DSAvsdf", // This should be in a config
            forHTTPHeaderField: "x-access-token"
        )

        request.addValue(
            "Speak Interview Test",
            forHTTPHeaderField: "x-client-info"
        )

        return request
    }
}
