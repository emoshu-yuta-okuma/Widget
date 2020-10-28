//
//  MyWidget.swift
//  MyWidget
//
//  Created by Yuta Okuma on 2020/10/28.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //this is a placeholder string
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), myString: "...")
    }

    //and this is a placeholder string
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), myString: "...")
        completion(entry)
    }

    //this is the main logic
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            //change time from one hour to 10 seconds
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset * 10, to: currentDate)!
            //here we can get random string from our provider
            let entry = SimpleEntry(date: entryDate, myString: MyProvider.getRandomString())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let myString: String
}

//this is the widget look
struct TestWidgetModuleEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            //set background
            Color.black.edgesIgnoringSafeArea(.all)
            
            //display text
            Text(entry.myString)
                .foregroundColor(.orange)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
        }
    }
}

@main
struct TestWidgetModule: Widget {
    let kind: String = "SampleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TestWidgetModuleEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//this is a preview
struct TestWidgetModule_Previews: PreviewProvider {
    static var previews: some View {
        TestWidgetModuleEntryView(entry: SimpleEntry(date: Date(), myString: "Random String"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
