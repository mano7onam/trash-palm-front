//
//  CreateGarbageTagView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import struct CoreLocation.CLLocationCoordinate2D
import SwiftUI


struct CreateGarbageTagView: View {
	let place: Place
	
	@State private var comment = ""
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Spacer()
				Circle()
					.fill(Color(hue: 0, saturation: 0, brightness: 0.85))
					.frame(width: 38, height: 38)
					.padding(.trailing, 21)
				
			}
			.overlay(alignment: .bottom) {
				Text("Add new trash")
					.font(.custom("Alata-Regular", fixedSize: 24))
			}
			
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.fill(Color(hue: 0.283, saturation: 0.04, brightness: 1))
				.overlay(alignment: .bottom) {
					Text("Add Photo")
						.foregroundStyle(Color(hue: 0, saturation: 0, brightness: 0.13))
						.font(.custom("Khula-Regular", fixedSize: 16))
						.padding(.bottom, 24)
				}
				.overlay {
					Image("Camera")
						.resizable()
						.scaledToFit()
						.padding(EdgeInsets(top: 28, leading: 29, bottom: 66, trailing: 48))
				}
				.frame(height: 310)
				.padding(.horizontal, 45)
				.padding(.vertical, 44)
			
			
			//				TextField(text: $comment, prompt: Text("Comment"), axis: .vertical) {
			//					EmptyView()
			//				}
			//				.frame(maxHeight: 165)
			//				.padding(10)
			//				.background(
			//					Color(hue: 0, saturation: 0, brightness: 0.85),
			//					in: RoundedRectangle(cornerRadius: 20)
			//				)
			TextView(text: $comment)
				.padding(10)
				.frame(height: 165)
				.background(
					Color(hue: 0, saturation: 0, brightness: 0.85),
					in: RoundedRectangle(cornerRadius: 20)
				)
				.padding(.horizontal, 23)
				.padding(.bottom, 14)
			
			
			Spacer()
		}
		.padding(.top, 18)
	}
}

struct TextView: UIViewRepresentable {
	@Binding var text: String
	
	func makeUIView(context: Context) -> UITextView {
		let view = UITextView(frame: .zero)
		view.backgroundColor = .clear
		view.text = text
		view.font = .systemFont(ofSize: 17)
		view.delegate = context.coordinator
		return view
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}
	
	final class Coordinator: NSObject, UITextViewDelegate {
		let parent: TextView
		
		init(parent: TextView) {
			self.parent = parent
		}
		
		func textViewDidChange(_ textView: UITextView) {
			if let text = textView.text {
				parent.text = text
			} else {
				parent.text = ""
			}
		}
	}
}


#Preview {
	CreateGarbageTagView(place: Place(name: "Preview", coordinate: CLLocationCoordinate2D(latitude: 57, longitude: 35)))
}
