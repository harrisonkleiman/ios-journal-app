//
//  EntryController.swift
//  Journal
//
//  Created by Harrison Kleiman on 5/2/22.
//

import Foundation

class EntryController {
    
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    static func deleteEntry(entry: Entry, journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }
    
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStorage()
    }
}
