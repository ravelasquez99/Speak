//
//  EmojiBlastView.swift
//  Speak
//
//  Created by Richard Velasquez on 4/11/24.
//

import UIKit
import SwiftUI

struct EmojiBlastView: View {
    var body: some View {
        ZStack {
            EmojiContainerView()
                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Spacer()
//                Text("😂")
//                    .font(.system(size: pressed ? 100 :  80))
//                    .frame(
//                        width: pressed ? 100 :  80,
//                        height: pressed ? 100 : 80
//                    )
//                    .gesture(DragGesture(minimumDistance: 0.0)
//                        .onChanged { _ in self.pressed = true }
//                        .onEnded { _ in self.pressed = false })
//            }
        }
    }
}

struct EmojiContainerView: UIViewRepresentable {
    let containerView = EmojiContainerUIView()

    func makeUIView(context: Context) -> UIView {
        containerView.frame = .init(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

class EmojiContainerUIView: UIView {
    var isPressed: Bool = false {
        didSet {
            if isPressed {
                kickoffBlasting()
            } else {
                clear()
            }
        }
    }

    var isBlasting = false
    var timer: Timer?
    var button: UIButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        button.setTitle("😂", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 80)
        addSubview(button)

        // Add long press gesture recognizer to the button
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self, 
            action: #selector(handleLongPress)
        )

        button.addGestureRecognizer(longPressRecognizer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = buttonFrame(isBlasting: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            kickoffBlasting()
        case .ended:
            clear()
        default:
            break
        }
    }
    
    func buttonFrame(isBlasting: Bool) -> CGRect {
        let widthHeight = isBlasting ? 80 : 100
        return CGRect(
            x: Int(bounds.width) / 2 - (widthHeight / 2),
            y: Int(bounds.height) - 120,
            width: widthHeight,
            height: widthHeight
        )
    }

    func kickoffBlasting() {
        guard isBlasting == false && isPressed == false else { return }
        isPressed = true
        isBlasting = true

        button.frame = buttonFrame(isBlasting: true)

        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(addAndAnimateBlast),
            userInfo: nil,
            repeats: true
        )
    }

    func animateBlast(blast: UIView) {
        let randomX = Int.random(in: 0...Int(bounds.width))
        UIView.animate(withDuration: 1.0, animations: {
            blast.frame = CGRect(
                x: CGFloat(randomX),
                y: -100,
                width: blast.bounds.width,
                height: blast.bounds.height
            )
        })
    }

    func clear() {
        guard isBlasting == true else { return }
        isBlasting = false
        isPressed = false
        button.frame = buttonFrame(isBlasting: false)

        for s in subviews {
            if s is UILabel {
                s.removeFromSuperview()
            }
        }

        timer = nil
    }
    
    @objc func addAndAnimateBlast() {
        guard isPressed else { return }
        let blast = buildBlast()
        insertSubview(blast, belowSubview: button)
        animateBlast(blast: blast)
    }

    func buildBlast() -> UIView {
        let buttonPosition = buttonFrame(isBlasting: true)
        let widthHeight: CGFloat = 40

        let label = UILabel(
            frame: .init(
                x: buttonPosition.midX - (widthHeight / 2.0),
                y: buttonPosition.midY - (widthHeight / 2.0),
                width: widthHeight,
                height: widthHeight
            )
        )

        label.text = "😂"
        label.font = .systemFont(ofSize: 40)

        return label
    }
}

private struct CustomButtonStyle: ButtonStyle {
    let isEnabled: Bool

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = isEnabled ? Color.purple : Color(UIColor.lightGray)
        let pressedColor = Color.red
        let background = configuration.isPressed ? pressedColor : backgroundColor

        configuration.label
            .foregroundColor(.white)
            .background(background)
            .cornerRadius(8)
    }
}

#Preview {
    EmojiBlastView()
}
