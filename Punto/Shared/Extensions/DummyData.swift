//
//  DummyData.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//

import Foundation

extension Array where Element == Task {
    mutating func dummyData() {
        self.append(contentsOf: [
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
                date: Date().addingTimeInterval(86400), // Mañana
                importance: .medium,
                status: .pending
            ),
            Task(
                title: "Actualizar Ruta Norte",
                description: "Optimizar los puntos de entrega basados en el nuevo tráfico.",
                date: Date().addingTimeInterval(-86400), // Ayer
                importance: .low,
                status: .done
            ),
            Task(
                title: "Firma de Contratos",
                description: "Reunión con los nuevos proveedores logísticos.",
                date: Date().addingTimeInterval(172800), // En 2 días
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
        ])
    }
}

extension Array where Element == Expense {
    mutating func dummyData() {
        self.append(contentsOf: [
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
        ])
    }
}

extension Array where Element == VehicleProtocol {
    mutating func dummyData() {
        self.append(contentsOf: [
            // 1. Protocolo de Inicio de Jornada (Crítico)
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
            
            // 2. Protocolo de Seguridad (Semanal)
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
            
            // 3. Protocolo de Limpieza (Diario)
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
            
            // 4. Protocolo de Cierre (Fin de jornada)
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
        ])
    }
}

extension Array where Element == MaintainableComponent {
    mutating func dumyData() {
        self.append(contentsOf: [
            // 1. Aceite de Motor (Ciclo corto: 5,000 - 8,000 km)
            MaintainableComponent(
                componentName: "Aceite de Motor (Sintético)",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -4, to: Date())!, 45000),
                rangeOfUsefulLife: 5000...8000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .month, value: 6, to: Date())!
            ),
            
            // 2. Llantas (Ciclo largo: 40,000 - 50,000 km)
            MaintainableComponent(
                componentName: "Llantas Delanteras",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .year, value: -1, to: Date())!, 30000),
                rangeOfUsefulLife: 40000...50000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 2, to: Date())!
            ),
            
            // 3. Pastillas de Frenos (Ciclo medio: 20,000 - 30,000 km)
            MaintainableComponent(
                componentName: "Pastillas de Frenos",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -8, to: Date())!, 40000),
                rangeOfUsefulLife: 20000...30000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 1, to: Date())!
            ),
            
            // 4. Líquido Refrigerante (Basado más en tiempo)
            MaintainableComponent(
                componentName: "Líquido Refrigerante",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -18, to: Date())!, 25000),
                rangeOfUsefulLife: 30000...40000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .year, value: 2, to: Date())!
            ),
            
            // 5. Filtro de Aire
            MaintainableComponent(
                componentName: "Filtro de Aire",
                lastTimeMaintainedInformation: (Calendar.current.date(byAdding: .month, value: -2, to: Date())!, 48000),
                rangeOfUsefulLife: 10000...15000,
                rangeDateOfUsefulLife: Date()...Calendar.current.date(byAdding: .month, value: 12, to: Date())!
            )
        ])
    }
}
