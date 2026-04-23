//
//  DummyData.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//

import Foundation

// MARK: - Task Extensions
extension Array where Element == VTask {
    static func dummyData() -> [VTask] {
        return [
            VTask(
                id: .init(),
                title: "Revisión de Inventario",
                description: "Contar las existencias en el almacén central y reportar faltantes.",
                deadLine: Date(),
                importance: .high,
                status: .inProgress
            ),
            VTask(
                id: .init(),
                title: "Mantenimiento Vehículo 04",
                description: "Cambio de aceite y revisión de frenos de la unidad de reparto.",
                deadLine: Date().addingTimeInterval(86400),
                importance: .medium,
                status: .pending
            ),
            VTask(
                id: .init(),
                title: "Actualizar Ruta Norte",
                description: "Optimizar los puntos de entrega basados en el nuevo tráfico.",
                deadLine: Date().addingTimeInterval(-86400),
                importance: .low,
                status: .done
            ),
            VTask(
                id: .init(),
                title: "Firma de Contratos",
                description: "Reunión con los nuevos proveedores logísticos.",
                deadLine: Date().addingTimeInterval(172800),
                importance: .high,
                status: .pending
            ),
            VTask(
                id: .init(),
                title: "Limpieza de Terminales",
                description: "Desinfectar y organizar las estaciones de escaneo.",
                deadLine: Date(),
                importance: .low,
                status: .inProgress
            )
        ]
    }
}

// MARK: - Expense Extensions
extension Array where Element == Expense {
    static func dummyData() -> [Expense] {
        return [
            Expense(name: "Gasolina Extra", description: "Tanqueada completa camión 01", amount: -185000.0, date: Date(), type: "Combustible"),
            Expense(name: "Peaje Andes", description: "Salida norte de la ciudad", amount: 12400.0, date: Date(), type: "Peaje"),
            Expense(name: "Cambio de Aceite", description: "Mantenimiento preventivo 10k km", amount: 250000.0, date: Date().addingTimeInterval(-86400), type: "Mantenimiento"),
            Expense(name: "Parqueadero Nocturno", description: nil, amount: 45000.0, date: Date().addingTimeInterval(-86400 * 2), type: "Otros"),
            Expense(name: "Almuerzo Ruta", description: "Restaurante El Camionero", amount: -22000.0, date: Date(), type: "Alimentación"),
            Expense(name: "Peaje Fusagasugá", description: "Ruta sur", amount: 11800.0, date: Date().addingTimeInterval(-3600), type: "Peaje"),
            Expense(name: "Reparación Llanta", description: "Despinchada rueda trasera izquierda", amount: 35000.0, date: Date().addingTimeInterval(-86400 * 3), type: "Mantenimiento"),
            Expense(name: "Gasolina Corriente", description: "Van de reparto urbana", amount: -95000.0, date: Date().addingTimeInterval(-1800), type: "Combustible"),
            Expense(name: "Seguro Obligatorio", description: "Renovación SOAT", amount: -640000.0, date: Date().addingTimeInterval(-86400 * 5), type: "Seguros"),
            Expense(name: "Lavado General", description: "Limpieza externa e interna", amount: 55000.0, date: Date().addingTimeInterval(-86400 * 4), type: "Limpieza"),
            Expense(name: "Bombillo LED", description: "Repuesto luz frontal derecha", amount: -15000.0, date: Date(), type: "Repuestos"),
            Expense(name: "Café y Snacks", description: "Parada técnica en vía", amount: 8500.0, date: Date().addingTimeInterval(-7200), type: "Alimentación")
        ]
    }
}

// MARK: - VehicleProtocol Extensions
extension Array where Element == VehicleProtocol {
    static func dummyData() -> [VehicleProtocol] {
        return [
            VehicleProtocol(
                id: UUID(),
                name: "Inspección Pre-Operacional",
                description: "Chequeo obligatorio antes de salir de la base.",
                tasks: [
                    ProtocolTask(taskName: "Nivel de Aceite", description: "Verificar varilla en frío", isCompleted: true, isActive: true),
                    ProtocolTask(taskName: "Presión de Llantas", description: "Incluyendo la de repuesto", isCompleted: false, isActive: true),
                    ProtocolTask(taskName: "Líquido de Frenos", isCompleted: false, isActive: false)
                ],
                importance: .high,
                time: .startingWork
            ),
            VehicleProtocol(
                id: UUID(),
                name: "Revisión de Kit de Carretera",
                description: "Verificar fechas de vencimiento y estado de herramientas.",
                tasks: [
                    ProtocolTask(taskName: "Extintor Vigente", isCompleted: true, isActive: true),
                    ProtocolTask(taskName: "Botiquín Completo", isCompleted: true, isActive: true),
                    ProtocolTask(taskName: "Triángulos y Tacos", isCompleted: true, isActive: true)
                ],
                importance: .high,
                time: .weekly
            ),
            VehicleProtocol(
                id: UUID(),
                name: "Aseo de Cabina",
                description: "Mantener el espacio de trabajo limpio.",
                tasks: [
                    ProtocolTask(taskName: "Retirar Basura", isCompleted: false, isActive: true),
                    ProtocolTask(taskName: "Desinfectar Volante", isCompleted: false, isActive: false)
                ],
                importance: .low,
                time: .daily
            ),
            VehicleProtocol(
                id: UUID(),
                name: "Entrega de Turno",
                description: "Reporte final del estado del vehículo.",
                tasks: [
                    ProtocolTask(taskName: "Reportar Kilometraje", isCompleted: false, isActive: true),
                    ProtocolTask(taskName: "Asegurar Puertas/Bodega", isCompleted: false, isActive: false),
                    ProtocolTask(taskName: "Entrega de Llaves", isCompleted: false, isActive: false)
                ],
                importance: .medium,
                time: .finishingWork
            )
        ]
    }
}

extension Array where Element == VehiclePartWrapper {
    static func dummyData() -> [VehiclePartWrapper] {
        let calendar = Calendar.current
        let today = Date()
        
        return [
            // 1. ACEITE DE MOTOR: Caso de KM Fijo (Cerca del límite -> Warning)
            // km_fixed: 10,000 | Recorrido: 9,950 (está dentro del 1% de margen)
            VehiclePartWrapper(
                vehiclePart: VehiclePartDTO(
                    partName: "Aceite de Motor",
                    category: "fluids",
                    intervalType: "fixed",
                    kmFixed: 10_000,
                    kmMin: nil,
                    kmMax: nil,
                    months: 6
                ), id: .init(),
                lastMaintenanceDate: calendar.date(byAdding: .month, value: -5, to: today)!,
                lastMaintenanceUnity: 5_000,
                currentUnity: 7_950 // Traveled: 9,950
            ),
            
            // 2. PASTILLAS DE FRENO: Caso de Rango (Dentro del rango -> Warning)
            // km_min: 20,000, km_max: 30,000 | Recorrido: 25,000
            VehiclePartWrapper(
                vehiclePart: VehiclePartDTO(
                    partName: "Pastillas de Freno Delanteras",
                    category: "brakes",
                    intervalType: "range",
                    kmFixed: nil,
                    kmMin: 20_000,
                    kmMax: 30_000,
                    months: 24
                ), id: .init(),
                lastMaintenanceDate: calendar.date(byAdding: .year, value: -1, to: today)!,
                lastMaintenanceUnity: 40000,
                currentUnity: 65000 // Traveled: 25,000
            ),
            
            // 3. FILTRO DE AIRE: Caso de KM Fijo (Excedido -> Overdue)
            // km_fixed: 15,000 | Recorrido: 16,000
            VehiclePartWrapper(
                vehiclePart: VehiclePartDTO(
                    partName: "Filtro de Aire",
                    category: "filters",
                    intervalType: "fixed",
                    kmFixed: 15_000,
                    kmMin: nil,
                    kmMax: nil,
                    months: 12
                ), id: .init(),
                lastMaintenanceDate: calendar.date(byAdding: .month, value: -14, to: today)!,
                lastMaintenanceUnity: 30_000,
                currentUnity: 46000 // Traveled: 16,000
            ),
            
            // 4. BATERÍA: Caso de Rango (Por debajo del mínimo -> Good)
            // km_min: 40,000, km_max: 60,000 | Recorrido: 10,000
            VehiclePartWrapper(
                vehiclePart: VehiclePartDTO(
                    partName: "Batería",
                    category: "electrical",
                    intervalType: "range",
                    kmFixed: nil,
                    kmMin: 40_000,
                    kmMax: 60_000,
                    months: 48
                ), id: .init(),
                lastMaintenanceDate: calendar.date(byAdding: .month, value: -8, to: today)!,
                lastMaintenanceUnity: 55_000,
                currentUnity: 65_000 // Traveled: 10,000
            ),
            
            // 5. LLANTAS: Caso de KM Fijo (Muy por debajo -> Good)
            // km_fixed: 50,000 | Recorrido: 5,000
            VehiclePartWrapper(
                vehiclePart: VehiclePartDTO(
                    partName: "Rotación de Llantas",
                    category: "tires",
                    intervalType: "fixed",
                    kmFixed: 10_000,
                    kmMin: nil,
                    kmMax: nil,
                    months: 6
                ), id: .init(),
                lastMaintenanceDate: calendar.date(byAdding: .month, value: -2, to: today)!,
                lastMaintenanceUnity: 60_000,
                currentUnity: 65000 // Traveled: 5,000
            )
        ]
    }
}
