//
//  StationDetailView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 24.08.2024.
//

import SwiftUI

struct StationListCellExpanded: View {
    
    @State var showDetail = false
    var namespace: Namespace.ID
    var station: Station?
    var collapseCell: () -> Void
    var idString: String {
        station?.id.uuidString ?? ""
    }

    var body: some View {
        
        container
            .padding(20)
            .overlay(overlay)
            .background(background)
        
        .onAppear {
            Task {
                
                try await Task.sleep(nanoseconds: 1_000_000_000)
                withAnimation {
                    showDetail = true
                }
            }
        }
    }
}


extension StationListCellExpanded {
    var container: some View {
        VStack(spacing: 16) {
            headerView
            
            Text(station?.name ?? "")
                .font(.title)
                .matchedGeometryEffect(id: "\(idString)-name", in: namespace, anchor: .top)
                .frame(maxWidth: .infinity, alignment: .leading)

            if showDetail {
                Group {
                    followUs
                    contactsContainer
                }
                .transition(.move(edge: .top))
            }
        }
    }
}

extension StationListCellExpanded {
    var headerView: some View {
        ZStack {
            station?.image
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(
                    id: "\(idString)-logo",
                    in: namespace,
                    isSource: false
                )
                .frame(height: 124)
                .offset(x: 10, y: 2)
                .padding(-12)
                .mask(Circle())
                .matchedGeometryEffect(id: "\(idString)-logoMask", in: namespace)
                .padding()
            
            if let url = station?.contact?.first(where: {$0.type == .web})?.url {
                Link(destination: url, label: {
                    Image(SocialNetworkType.web.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 36)
                })
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .allowsHitTesting(true)
    }
}

extension StationListCellExpanded {
    var overlay: some View {
        VStack {
            Button(action: {
                tapToDismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            })
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .padding(20)
            Spacer()
        }
    }
}

// MARK: background
extension StationListCellExpanded {
    var background: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .background(
                .ultraThinMaterial
            )
            .matchedGeometryEffect(id: "\(idString)-background", in: namespace)
            .mask {
                RoundedRectangle(cornerRadius: 20)
//                    .matchedGeometryEffect(id: "\(idString)-bgMask", in: namespace)
            }
            .shadow(color: Color.gray.opacity(0.5), radius: 15, x: 2, y: 5)
    }
}

extension StationListCellExpanded {
    var followUs: some View {
        VStack(alignment: .leading) {
            if let contacts = station?.toFollow {
                Text("Follow Us")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(contacts) { contact in
                            if let url = contact.url, let type = contact.type {
                                Link(destination: url, label: {
                                    Image(type.rawValue)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 58, height: 58)
                                })
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension StationListCellExpanded {
    var contactsContainer: some View {
        VStack(alignment: .leading) {
            if let contacts = station?.filteredContact {
                Text("Contact Us")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(contacts) { contact in
                            if let type = contact.type, let url = contact.url {
                                Link(
                                    destination: url,
                                    label: {
                                        Image(type.rawValue)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 58, height: 58)
                                    }
                                )
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


extension StationListCellExpanded {
    func contactAction(_ contactType: SocialNetworkType) {
        debugPrint(contactType)
    }
}

extension StationListCellExpanded {
    func tapToDismiss() {
        collapseCell()
    }
}

struct PV: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        StationListCellExpanded(namespace: namespace, station: Station(name: "test")) {
            
        }
        .padding()
    }
}
