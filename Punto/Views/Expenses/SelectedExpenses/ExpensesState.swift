//
//  ExpensesState.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//
import Foundation

@Observable
class ExpensesState {
    var selectedIndex: Int = 0
    var search: String = ""
}
