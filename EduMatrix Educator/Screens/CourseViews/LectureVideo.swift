//
//  LectureVideo.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 14/07/24.
//

import SwiftUI
import AVKit

struct LectureVideo: View {
    var video : Video
    @Binding var lectureTitle : String
    var body: some View {
        TextField("Enter Lecture Title", text: $lectureTitle)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom)
        
        VideoPlayer(player: AVPlayer(url: video.videoURL))
            .frame(height: 300)
            .padding()
        
    }
}
