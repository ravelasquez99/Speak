//
//  RecordView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import SwiftUI

struct RecordView: View {
    @State var isSaved: Bool = false
    @StateObject private var viewModel = RecordViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isSaved.toggle()
                }, label: {
                    Image("bookmark-icon-empty-final", bundle: nil)
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .tint(isSaved ? .green : .gray )
                })
            }

            Text(viewModel.receivedText)
                .font(.largeTitle)
                .padding(.top)
                .padding(.top)
                .padding(.top)

            Spacer()

            HStack {
                Button(
                    action: {
                        viewModel.disconnectWebSocket()
                    },
                    label: {
                        Image("back-arrow", bundle: nil)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .rotationEffect(.degrees(45))
                            .background(
                                Circle()
                                    .fill(circleColor)
                                    .frame(width: 40, height: 40)
                            )
                            
                    }
                ).padding()

                Button(
                    action: {
                        viewModel.connectToWebSocket()
                    },
                    label: {
                        Image("recording-icon", bundle: nil)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(circleColor)
                                    .frame(width: 60, height: 60)
                            )
                            
                    }
                ).disabled(viewModel.isProcessing)
                .padding(.horizontal)

                // invisible button to center the upload button
                Button(action: {}, label: {
                    Text("Retry")
                })
                .opacity(0)
                .disabled(true)
            }
        }.padding()
    }

    private var circleColor: Color {
        return SpeakColor.coursesImageCircleColor
    }
}

#Preview {
    RecordView()
}
