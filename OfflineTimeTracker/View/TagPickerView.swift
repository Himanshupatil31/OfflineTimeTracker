//
//  TagPickerView.swift
//  OfflineTimeTracker
//
//  Created by Himanshu on 02/02/26.
//

import SwiftUI

struct TagPickerView: View {
    let tags: [Tag]
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags) { tag in
                    let isSelected = selectedTags.contains(tag)
                    
                    Text(tag.name)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            isSelected ? Color.blue.opacity(0.25) : Color.gray.opacity(0.15)
                        )
                        .clipShape(Capsule())
                        .onTapGesture {
                            toggle(tag)
                        }
                }
            }
        }
    }
    
    private func toggle(_ tag: Tag) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
}
