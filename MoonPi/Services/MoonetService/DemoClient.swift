//
//  DemoClient.swift
//  MoonPi
//
//  Created by Gabriel Santos on 11/11/25.
//

final class DemoClient {
    static func request<RES: Decodable>() -> ApiResponse<RES>? {
        var json: String =
            """
            {"ok": true}
            """
        if RES.self == VideoItem.self {
            json =
                """
                {"ok":true,"data":{"title":"Música Para Bebê Dormir com Relaxante Som de Água ♫ ❤ Animação com Peixes","url":"https://www.youtube.com/watch?v=QtJBuTm97ss","duration":16119,"meta":{"thumbnail":"https://i.ytimg.com/vi/QtJBuTm97ss/hqdefault.jpg","id":"QtJBuTm97ss","channel":"Cassio Toledo - Relaxing Music","url":"https://www.youtube.com/watch?v=QtJBuTm97ss"},"played_at":1757415636017}}
                """
        } else if RES.self == VideoListResponse.self {
            json =
                """
                {"ok":true,"data":{"page":0,"limit":4,"total":5,"has_next":true,"items":[{"title":"Música Para Bebê Dormir com Relaxante Som de Água ♫ ❤ Animação com Peixes","url":"https://www.youtube.com/watch?v=QtJBuTm97ss","duration":16119,"meta":{"thumbnail":"https://i.ytimg.com/vi/QtJBuTm97ss/hqdefault.jpg","id":"QtJBuTm97ss","channel":"Cassio Toledo - Relaxing Music","url":"https://www.youtube.com/watch?v=QtJBuTm97ss"},"played_at":1757415423140},{"title":"JAW-DROPPING 4K HDR 60fps | Dolby Vision (8K / 4K Video TV TEST)","url":"https://www.youtube.com/watch?v=jk6cXcQ3T-k","duration":5647,"meta":{"thumbnail":"https://i.ytimg.com/vi/jk6cXcQ3T-k/hqdefault.jpg","id":"jk6cXcQ3T-k","channel":"4K Video ULTRA HD","url":"https://www.youtube.com/watch?v=jk6cXcQ3T-k"},"played_at":1757415376774},{"title":"Música Para Bebê Dormir com Relaxante Som de Água ♫ ❤ Animação com Peixes","url":"https://www.youtube.com/watch?v=QtJBuTm97ss","duration":16119,"meta":{"thumbnail":"https://i.ytimg.com/vi/QtJBuTm97ss/hqdefault.jpg","id":"QtJBuTm97ss","channel":"Cassio Toledo - Relaxing Music","url":"https://www.youtube.com/watch?v=QtJBuTm97ss"},"played_at":1757415335489},{"title":"Interpol - All The Rage Back Home","url":"https://www.youtube.com/watch?v=-u6DvRyyKGU","duration":264,"meta":{"thumbnail":"https://i.ytimg.com/vi/-u6DvRyyKGU/hqdefault.jpg","id":"-u6DvRyyKGU","channel":"Interpol","url":"https://www.youtube.com/watch?v=-u6DvRyyKGU"},"played_at":1757414303394}]}}
                """
        } else if RES.self == StatusResponse.self {
            json =
                """
                {"ok":true,"data":{"pause":true,"volume":72,"time_pos":5.362874,"duration":16119.083152,"media_title":"Música Para Bebê Dormir com Relaxante Som de Água ♫ ❤ Animação com Peixes","idle_active":false,"playing":false,"meta":{"thumbnail":"https://i.ytimg.com/vi/QtJBuTm97ss/hqdefault.jpg","id":"QtJBuTm97ss","channel":"Cassio Toledo - Relaxing Music","url":"https://www.youtube.com/watch?v=QtJBuTm97ss"}}}
                """
        } else if RES.self == Bool.self {
            json =
                """
                {"ok": true, "data": true}
                """
        } else if RES.self == [String].self {
            json =
                """
                {"ok":true,"data":["Mudica para bebe dormir","Mundo bita","Chr0m1ng"]}
                """
        }
        return ApiResponse<RES>.from(json: json)
    }
}
