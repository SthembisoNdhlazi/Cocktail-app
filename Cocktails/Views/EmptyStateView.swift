//
//  EmptyStateView.swift
//  Cocktails
//
//  Created by Sthembiso Ndhlazi on 2023/12/23.
//

import SwiftUI

struct EmptyStateView: View {
    let systemImage: String
    let emptyStateText: String
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .resizable()
                .frame(width: 150, height: 170, alignment: .center)
            Text(emptyStateText)
                .multilineTextAlignment(.center)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(systemImage: "wineglass",
                       emptyStateText: "Looks like you don't have any favorite drinks... \n\nTry adding some from the other categories")
    }
}
