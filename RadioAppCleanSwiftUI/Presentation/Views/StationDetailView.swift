//
//  StationDetailView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 24.08.2024.
//

import SwiftUI

struct StationDetailView: View {
    
    @Binding var showDetail: Bool
    var station: Station?
    var idString: String {
        station?.id.uuidString ?? ""
    }
    var namespace: Namespace.ID
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                withAnimation(.spring(.smooth, blendDuration: 0.3)) {
                    showDetail.toggle()
                }
            }, label: {
                Image(systemName: "xmark.circle")
            })
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .padding(20)
            
            station?.image
                .resizable()
                .scaledToFit()
                .frame(height: 124)
                .offset(x: 10, y: 2)
                .padding(-12)
                .mask(Circle())
                .matchedGeometryEffect(id: "\(idString)-logo", in: namespace)
                .padding(.horizontal, 24)
            
            Text(station?.name ?? "")
                .matchedGeometryEffect(id: "\(idString)-name", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)

            Spacer()
        }
        .background(
            Color.clear.background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )
            .matchedGeometryEffect(id: "\(idString)-background", in: namespace)
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    RadioPlayerMainView()
        .environmentObject(PlayerManager.shared)
}
