//
//  ToastView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/23.
//

//TODO: Delete this
import SwiftUI

struct ToastView: View {
    let image: String
    let message: String
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(image == "checkmark" ? .green : .red)
            Text(message)
                .foregroundColor(image == "checkmark" ? .green : .red)
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(image == "checkmark" ? .green : .red)
        )
        .background {
            Rectangle()
                .foregroundStyle(.secondary)
                .background(.thinMaterial)
        }
        .cornerRadius(20)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(image: "checkmark", message: "Your drink has been added to your favorites")
    }
}
