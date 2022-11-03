//
//  HorizontalTabView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct HorizontalTabView: View {
    
    var menuItems: [String]
    @Binding var selected: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<menuItems.count, id:\.self) { index in
                    HorizontalTabViewElement(title: menuItems[index],
                                             trailingPadding: index == menuItems.count-1,
                                             isSelected: selected == index)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.25)) {
                            selected = index
                        }
                    }
                }
            }
        }
        .frame(height: 50)
        .background(Color.appPrimary)
    }
}

fileprivate struct HorizontalTabViewElement: View {
    
    var title: String
    
    var leadingPadding = true
    var trailingPadding = false
    
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(title)
                .padding(.horizontal, 5)
                .font(.appFont(weight: .semibold, size: Constants.UI.horizontalTabViewFontSize))
            Spacer()
            Rectangle()
                .frame(height: 4)
                .foregroundColor(isSelected ? .white : .clear)
        }
        .padding(.leading, leadingPadding ? 15 : 0)
        .padding(.trailing, trailingPadding ? 15 : 0)
        .foregroundColor(Color.appPrimaryTextColor)
    }
}

// MARK: Previews

/// We need a wrapper in order to preview as close as possible
/// to a real device via canvas (State management)
struct HorinzontalTabView_Previews_Wrapper: View {
    
    @State var menuItems = [
        "Now Playing",
        "Popular",
        "Top Rated",
        "Upcoming"
    ]
    @State var selectedItem = 0
    
    var body: some View {
        VStack {
            Button {
                selectedItem = Int.random(in: 0...3)
            } label: {
                Text("Change Selection")
            }
            HorizontalTabView(menuItems: menuItems, selected: $selectedItem)
        }
    }
}

struct HorizontalTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        HorinzontalTabView_Previews_Wrapper()
    }
}
