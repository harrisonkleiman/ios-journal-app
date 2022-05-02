//
//  File.swift
//  Journal
//
//  Created by Harrison Kleiman on 5/2/22.
//

import Foundation

class JournalController {
    static let shared = JournalController()
    var journals: [Journal] = []
    
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    private func fileURL() -> URL {
        var urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendPathComponent("Journal.json")
        
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
}

