//
//  DummyData.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//

import Foundation

// MARK: - Task Extensions
extension Array where Element == Task {
    static func dummyData() -> [Task] {
        return [
            Task(
                title: "Revisión de Inventario",
                description: "Contar las existencias en el almacén central y reportar faltantes.",
                date: Date(),
                importance: .high,
                status: .inProgress
            ),
            Task(
                title: "Mantenimiento Vehículo 04",
                description: "Cambio de aceite y revisión de frenos de la unidad de reparto.",
                date: Date().addingTimeInterval(86400),
                importance: .medium,
                status: .pending
            ),
            Task(
                title: "Actualizar Ruta Norte",
                description: "Optimizar los puntos de entrega basados en el nuevo tráfico.",
                date: Date().addingTimeInterval(-86400),
                importance: .low,
                status: .done
            ),
            Task(
                title: "Firma de Contratos",
                description: "Reunión con los nuevos proveedores logísticos.",
                date: Date().addingTimeInterval(172800),
                importance: .high,
                status: .pending
            ),
            Task(
                title: "Limpieza de Terminales",
                description: "Desinfectar y organizar las estaciones de escaneo.",
                date: Date(),
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

// MARK: - MaintainableComponent Extensions
extension Array where Element == MaintainableComponent {
    static func dummyData() -> [MaintainableComponent] {
        return [
            MaintainableComponent(
                componentName: "Aceite de Motor (Sintético)",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -4, to: Date())!, 45000),
                rangeOfUsefulLife: 5000...8000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .month, value: 6, to: Date())!
            ),
            MaintainableComponent(
                componentName: "Llantas Delanteras",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .year, value: -1, to: Date())!, 30000),
                rangeOfUsefulLife: 40000...50000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 2, to: Date())!
            ),
            MaintainableComponent(
                componentName: "Pastillas de Frenos",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -8, to: Date())!, 40000),
                rangeOfUsefulLife: 20000...30000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!
            ),
            MaintainableComponent(
                componentName: "Líquido Refrigerante",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -18, to: Date())!, 25000),
                rangeOfUsefulLife: 30000...40000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 2, to: Date())!
            ),
            MaintainableComponent(
                componentName: "Filtro de Aire",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -2, to: Date())!, 48000),
                rangeOfUsefulLife: 10000...15000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .month, value: 12, to: Date())!
            )
        ]
    }
}
