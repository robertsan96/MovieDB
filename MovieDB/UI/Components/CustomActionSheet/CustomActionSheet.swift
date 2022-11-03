//
//  CustomActionSheet.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct CustomActionSheet: View {
    
    @Binding var backgroundTapSignal: Bool
    
    var actions: [CustomActionSheetAction]
    
    private var regularActions: [CustomActionSheetAction] {
        return actions.filter({ $0.type == .regular })
    }
    
    private var cancelAction: CustomActionSheetAction? {
        return actions.first(where: { $0.type == .cancel })
    }
    
    var body: some View {
        ZStack {
            Color
                .appPrimary
                .opacity(Constants.UI.customActionSheetBackgroundAlpha)
                .ignoresSafeArea()
                .onTapGesture {
                    backgroundTapSignal.toggle()
                }
            VStack(spacing: 15) {
                Spacer()
                actionViewGroup(for: regularActions)
                if cancelAction != nil {
                    actionViewGroup(for: [cancelAction!])
                }
            }
            .padding(Constants.UI.customActionSheetPadding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func actionView(for action: CustomActionSheetAction, border: Bool = true) -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Text(action.title)
                    .font(.appFont(weight: action.type == .cancel ? .bold : .semibold,
                                   size: Constants.UI.customActionSheetFontSize))
                    .foregroundColor(Color.appSecondaryTextColor)
            }
            Spacer()
            Rectangle()
                .foregroundColor(border ? Color.appPrimary.opacity(0.1) : .clear)
                .frame(height: 1)
        }
        .frame(height: 45)
        .background(Color.white.opacity(0.0001)) // needed for tap gesture to work
        .onTapGesture {
            action.action()
        }
    }
    
    private func actionViewGroup(for actions: [CustomActionSheetAction]) -> some View {
        VStack {
            ForEach(actions.indices, id:\.self) { index in
                actionView(for: actions[index], border: index != actions.count-1)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(Constants.UI.customActionSheetCornerRadius)
    }
    
}

struct CustomActionSheetAction: Identifiable {

    enum ActionType {
        case regular
        case destructive
        case cancel
    }
    
    let id = UUID()
    let title: String
    let type: ActionType
    let action: () -> Void
    
    static func cancel(title: String = "Cancel", action: @escaping () -> Void) -> CustomActionSheetAction {
        CustomActionSheetAction(title: title, type: .cancel, action: action)
    }
    
    static func regular(title: String, action: @escaping () -> Void) -> CustomActionSheetAction {
        CustomActionSheetAction(title: title, type: .regular, action: action)
    }
}

struct CustomActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomActionSheet(backgroundTapSignal: .constant(true), actions: [
            .regular(title: "Rating Ascending", action: {}),
            .regular(title: "Rating Descending", action: {}),
            .regular(title: "Release Date Ascending", action: {}),
            .regular(title: "Release Date Descending", action: {}),
            .cancel(action: {})
        ])
    }
}
