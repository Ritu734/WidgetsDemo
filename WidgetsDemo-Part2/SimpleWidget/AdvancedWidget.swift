//
//  AdvancedWidget.swift
//  SimpleWidgetExtension
//
//  Created by Ritu Bala on 18/08/20.
//

import Foundation
import SwiftUI
import WidgetKit

struct AdvancedProvider: IntentTimelineProvider {
    typealias Intent = UserCategoriesIntent
    typealias Entry = AdvancedEntry
    
//    func user(for configuration: UserCategoriesIntent) -> String {
//        switch configuration.users {
//            case .dravid:
//                return "Rahul Dravid"
//            case .msd:
//                return "Mahendra Singh Dhoni"
//            case .ganguly:
//                return "Saurav Ganguly"
//            case .kohli:
//                return "Virat Kohli"
//            default:
//                return "Rahul Dravid"
//        }
//    }
    
    func getSnapshot(for configuration: UserCategoriesIntent, in context: Context, completion: @escaping (AdvancedEntry) -> Void) {
        let entry = AdvancedEntry(date: Date(), advancedString: "This is advanced preview context")
        completion(entry)
    }
    
    func getTimeline(for configuration: UserCategoriesIntent, in context: Context, completion: @escaping (Timeline<AdvancedEntry>) -> Void) {
        let selectedUser = configuration.users?.displayString
        let entry = AdvancedEntry(date: Date(), advancedString: "I am \(selectedUser ?? "Sachin Tendulkar") and I love Cricket")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> AdvancedEntry {
        let placeholder = AdvancedEntry(date: Date(), advancedString: "-")
        return placeholder
    }
}

struct AdvancedEntry: TimelineEntry {
    var date: Date
    var advancedString: String
}

struct AdvancedView: View {
    var entry: AdvancedProvider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        switch family {
            case .systemSmall:
                
                Text(entry.advancedString).padding()
                    .widgetURL(URL(string: "WidgetsDemo://relativeText"))
                
            case .systemMedium:
                
                VStack(alignment: .leading) {
                    Link(destination: URL(string: "WidgetsDemo://relativeText")!) {
                        Text(entry.advancedString)
                        Text("This is medium widget, just in case you wanted to know! ;)")
                        Text("\(Date(), style: .relative) ago").frame(width: 100, height: 30)
                    }
                }.padding()
                .background(ContainerRelativeShape().fill(Color.yellow))
                
            default:
                VStack(alignment: .leading) {
                    Text(entry.advancedString)
                    Text("This is large widget!")
                }.padding()
        }
    }
}

struct AdvancedWidget: Widget {
    let kind = "AdvancedWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: UserCategoriesIntent.self, provider: AdvancedProvider()) { (entry) in
            AdvancedView(entry: entry)
        }.configurationDisplayName("My Advanced Widget")
        .description("Some advanced description that makes sense.")
    }
}

@main
struct WidgetsDemoBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        SimpleWidget()
        AdvancedWidget()
    }
}



