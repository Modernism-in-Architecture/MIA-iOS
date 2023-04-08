//
//  MIAappWidget.swift
//  MIAappWidget
//
//  Created by Sören Kirchner on 25.07.22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func getBuildings() async -> [Building] {
        let result =  await MIAClient.fetchData(for: API.request(for: API.buildings), of: Buildings.self)
        switch result {
        case .success(let data):
            return data.data
        default:
            return []
        }
    }
    
    func downloadImage(url: URL) async -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else { return nil }
            return image
        } catch  {
            return nil
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
        
        guard buildings.count > 0 else { return [SimpleEntry.placeholder] }
        for (index, building) in buildings.prefix(amount).enumerated() {
            guard let image = await downloadImage(url: building.feedImage) else { continue }
            let offset = 6 * index
            let loadAfterDate = Calendar.current.date(byAdding: .hour, value: offset, to: now)!
            entries.append(SimpleEntry(date: loadAfterDate, image: image, name: building.name, cityCountry: "\(building.city), \(building.country)"))
            debugPrint(entries)
        }
        if entries.isEmpty { return [.placeholder] }
        return entries
    }

    // MARK: Protokoll Methods

    func placeholder(in context: Context) -> SimpleEntry {
        return .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            let entry = await getNextSnapshots(lastAmount: 1, randomAmount: 0).first!
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage?
    let name: String
    let cityCountry: String
}

extension SimpleEntry {
    static let placeholder = SimpleEntry(date: Date.now, image: UIImage(named: "petershof"), name: "Petershof", cityCountry: "Leipzig, Germany")
}

struct MIAappWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Image(uiImage: entry.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                MIAToolBarLogo()
                    .padding()
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Spacer()
                    HStack() {
                        VStack(alignment: .leading) {
                            Text(entry.name)
                                .font(.callout)
                                .lineLimit(1)
                            Text(entry.cityCountry)
                                .font(.footnote)
                                .lineLimit(1)
                        }
                        .padding([.leading, .trailing], 8)
                        .padding(8)
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    .background(.ultraThinMaterial)
                }
            }
        }
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
    }
}

struct MIAappWidget_Previews: PreviewProvider {
    static var previews: some View {
        MIAappWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        MIAappWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        MIAappWidgetEntryView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
