//
//  Tarefa.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 09/11/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import Foundation

class Tarefa{
    
    var descricaoTarefa: String
    var concluido: Bool
    var uid: String
    
    
    init(){
        self.descricaoTarefa = ""
        self.concluido = false
        self.uid = ""
    }
    
    init(descricaoTarefa: String, uid: String) {
        self.descricaoTarefa = descricaoTarefa
        self.concluido = false
        self.uid = uid
    }
    
    init(descricaoTarefa: String, concluido: Bool, uid: String) {
        self.descricaoTarefa = descricaoTarefa
        self.concluido = concluido
        self.uid = uid
    }
}
