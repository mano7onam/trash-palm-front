//
//  TrashListDetails.swift
//  clientApp
//
//  Created by Stanislav Zelikson on 26/11/2023.
//

import Foundation
import SwiftUI

struct TrashListDetails: View {
    let item: TrashListItem
    
    init(item: TrashListItem) {
        self.item = item
    }
    var body: some View {

        VStack{
            Image(item.detailsImageName)
            Text(item.text)
                .padding()
                .font(.palmTitle)
                .frame(width: 380)
                .background(Color.sunny)
                .clipShape(RoundedRectangle(cornerRadius: 100, style: .circular))
            List(item.list) { item in
                HStack {
                    Text(item.name)
                        .font(.palmRegular)
                    Spacer()
                    Text(String(item.amount))
                        .font(.palmRegular)
                }
            }
            .background(Color.oliveSecondary.opacity(0.3))
        }
    }
}

#Preview {
    TrashListDetails(item: .init(imageName: "", detailsImageName: "cameraboy", text: "123", list: [
        .init(name: "1235", amount: 5),
        .init(name: "54321", amount: 10),
    ]))
}
