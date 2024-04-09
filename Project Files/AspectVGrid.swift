
import SwiftUI
import ReplayKit
import ARKit

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat = 2/3
    var content: (Item) -> ItemView
    
    var body: some View{
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: items.count, size: geometry.size, aspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, aspectRatio: CGFloat ) -> CGFloat { // Calculate card size
        let count = CGFloat(count)
        var columCount = 1.0
        repeat {
            let width = size.width / columCount
            let height = width / aspectRatio
            
            let rowCount = (count / columCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columCount).rounded(.down)
            }
            columCount += 1
        } while columCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
