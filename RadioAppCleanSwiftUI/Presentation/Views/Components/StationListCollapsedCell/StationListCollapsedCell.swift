//
//  StationListCellCollapsed.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 1.09.2024.
//

import SwiftUI

struct StationListCellCollapsed: View {
    
    @State var loading: Bool = false
    var namespace: Namespace.ID
    var content: ChannelListCollapsedCellContent
    var playPauseButtonAction: () -> Void
    var idString: String {
        content.id.uuidString
    }

    var body: some View {
        container
            .padding()
            .background(background)
    }
}

extension StationListCellCollapsed {
    var container: some View {
        HStack(spacing: 16) {
            content.logo
                .resizable(capInsets: EdgeInsets())
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "\(idString)-logo", in: namespace, isSource: true)
                .frame(width: 50.0, height: 50.0)
                .scaledToFit()
                .mask(Rectangle())
                .matchedGeometryEffect(id: "\(idString)-logoMask", in: namespace)

            VStack {
                Text(content.name)
                    .font(.title)
                    .lineLimit(1)
                    .scaleEffect(0.9, anchor: .leading)
                    .matchedGeometryEffect(id: "\(idString)-name", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            Spacer()
            
            Button {
                loading = true
                playPauseButtonAction()
            } label: {
                content.buttonLabel
                .resizable()
                .frame(width: 44, height: 44)
                .if(awaitingToLoad && !content.isPlaying) { view in
                    view.blink()
                }
            }
            .buttonStyle(.borderless)
        }
        .frame(maxWidth: .infinity)
    }
}

extension StationListCellCollapsed {
    var background: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .background(
                    .ultraThinMaterial
            )
            .matchedGeometryEffect(id: "\(idString)-background", in: namespace)
            .mask {
                RoundedRectangle(cornerRadius: 16)
//                    .matchedGeometryEffect(id: "\(idString)-bgMask", in: namespace)
            }
//            .shadow(color: Color.gray.opacity(0.3), radius: 1)
    }
}

struct PVC: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        StationListCellCollapsed(namespace: namespace, content: .dummy) {
            
        }
        .padding()
    }
}
