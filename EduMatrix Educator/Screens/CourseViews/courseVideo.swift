//
//  courseVideo.swift
//  EduMatrix Educator
//
//  Created by Madhav Verma on 14/07/24.
//

import SwiftUI

struct courseVideo: View {
    @Binding var video: Video
    
    var body: some View {
        NavigationLink(destination: LectureVideo(video: video , lectureTitle: $video.title)) {
                HStack {
//                    if let videoURL = video?.videoURL , let image = UIImage(contentsOfFile: videoURL.) {
//                        Image(uiImage: image)
//                    }
//                    Spacer()
                    Text(video.title)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.vertical)
    }
        
}
