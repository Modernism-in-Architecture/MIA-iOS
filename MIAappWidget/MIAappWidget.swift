//
//  MIAappWidget.swift
//  MIAappWidget
//
//  Created by Sören Kirchner on 25.07.22.
//

import WidgetKit
import SwiftUI

struct Provider {
    
    // MARK: - Properties
    
    let manager = BuildingsManager()
}

// MARK: - Protocol Methods

extension Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        Task {
            
            let entry = await getNextSnapshots(lastAmount: 1, randomAmount: 0).first ?? .placeholder
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Task {
            
            let entries = await getNextSnapshots()
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

// MARK: - Private Methods

private extension Provider {
    
    func getBuildings() async -> [Building] {

        do {
            return try await manager.getBuildings()
        } catch {
            return []
        }
    }
    
    func getLastAndRandom(lastAmount: Int = 6, randomAmount: Int = 6) async -> [Building] {
        
        var selection: [Building] = []
        let buildings = await getBuildings()
        selection.append(contentsOf: buildings.prefix(lastAmount))
        selection.append(contentsOf: buildings[lastAmount...].shuffled().prefix(randomAmount))
        return selection.shuffled()
    }
    
    func getNextSnapshots(lastAmount: Int = 6, randomAmount: Int = 6) async -> [SimpleEntry] {
        
        let amount = lastAmount + randomAmount
        var entries: [SimpleEntry] = []
        let buildings = await getLastAndRandom(lastAmount: lastAmount, randomAmount: randomAmount)
        let now = Date.now
        
        guard buildings.count > 0 else {
            return [.placeholder]
        }
        
        for (index, building) in buildings.prefix(amount).enumerated() {
            
            guard let image = try? await MIAClient.downloadImage(from: building.feedImage).get() else {
                continue
            }
            
            let offset = 6 * index
            let loadAfterDate = Calendar.current.date(byAdding: .hour, value: offset, to: now)!
            entries.append(
                SimpleEntry(
                    date: loadAfterDate,
                    image: image,
                    name: building.name,
                    cityCountry: "\(building.city), \(building.country)"
                )
            )
        }
        
        if entries.isEmpty {
            return [.placeholder]
        }
        
        return entries
    }
}

struct SimpleEntry: TimelineEntry {
    
    let date: Date
    let image: UIImage?
    let name: String
    let cityCountry: String
}

extension SimpleEntry {
    static let placeholder = SimpleEntry(date: Date.now, image: UIImage(named: "petershof"), name: "Petershof", cityCountry: "Leipzig, Germany")
}

struct MIAappWidgetEntryView: View {
    
    @Environment(\.widgetFamily)
    var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {

        GeometryReader { geo in
            
            ZStack(alignment: .topLeading) {
                
                image
                    .frame(width: geo.size.width, height: geo.size.height)
                logo
                infoArea
            }
            .containerBackground(for: .widget) {}
        }
    }
}

private extension MIAappWidgetEntryView {
    
    var image: some View {
        
        Image(uiImage: entry.image!)
            .resizable()
            .scaledToFill()
    }
    
    var logo: some View {
        
        MIAToolBarLogo()
            .padding()
            .scaledToFit()
    }
    
    var infoArea: some View {
        
        VStack(alignment: .leading) {
            
            Spacer()
            HStack {
                
                infoFields
                Spacer()
            }
            .background(.ultraThinMaterial)
        }
    }
    
    var infoFields: some View {
        
        VStack(alignment: .leading) {
            
            if widgetFamily == .systemLarge {
                
                Text(entry.name)
                    .font(.callout)
                    .lineLimit(1)
            }
            Text(entry.cityCountry)
                .font(.footnote)
                .lineLimit(1)
        }
        .padding([.leading, .trailing], 8)
        .padding(8)
    }
}


@main
struct MIAappWidget: Widget {
    
    let kind: String = "MIAappWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MIAappWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("MIA App Widget")
        .description("Modernism in Architecture")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .contentMarginsDisabled()
    }
}

// MARK: - Preview

#Preview("Small", as: .systemSmall) {
    MIAappWidget()
} timelineProvider: {
    Provider()
}

#Preview("Medium", as: .systemMedium) {
    MIAappWidget()
} timelineProvider: {
    Provider()
}

#Preview("Large", as: .systemLarge) {
    MIAappWidget()
} timelineProvider: {
    Provider()
}
