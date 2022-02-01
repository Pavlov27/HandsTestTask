//
//  CellBuilder.swift
//  HandsTestTask
//
//  Created by Nikita Pavlov on 27.01.2022.
//

import Foundation

enum UpadteType {
    case regular
    case killLife
    case makeLife
}

class CellBuilder {
    func buildCellModels(_ models: inout [SchrodingerCellModel]) -> ([SchrodingerCellModel], UpadteType) {
        var updateState: UpadteType = .regular
        
        models.append(appendNewCell())
        
        if models.count > 2 {
            let modelsToCompare = models.suffix(3)
            
            if modelsToCompare.allEqual(by: \.type) {
                switch modelsToCompare.first!.type {
                case .dead:
                    if models.count > 3 {
                        if models[models.count - 4].type == .life {
                            models[models.count - 4].type = .dead
                            updateState = .killLife
                        }
                    }
                case .alive:
                    models.append(SchrodingerCellModel(type: .life))
                    return (models, .makeLife)
                case .life:
                    break
                }
            }
        }
        
        return (models, updateState)
    }
    
    private func appendNewCell() -> SchrodingerCellModel {
        var newModel = SchrodingerCellModel(type: .dead)
        switch Int.random(in: 0...1) {
        case 0:
            break
        default:
            newModel.type = .alive
        }
        
        return newModel
    }
}
