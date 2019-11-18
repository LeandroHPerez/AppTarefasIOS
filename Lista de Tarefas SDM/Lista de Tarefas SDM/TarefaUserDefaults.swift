//
//  TarefaUserDefaults.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 27/10/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import UIKit


class TarefaUSerDefaults{
    
    let chave = "listaTarefas"
    var tarefas: [String] = []
    

    func salvar(tarefa: String){
        //Recuperar dados ja existentes
        tarefas = listar()
        
        
        //Salvar
        tarefas.append(tarefa)
        UserDefaults.standard.set(tarefas, forKey: chave)
        
    }

    func listar() -> Array<String> {
        let dados = UserDefaults.standard.object(forKey: chave)
        
        if dados != nil {
            return dados as! Array<String>
        }
        else {
            return []
        }
    }
    
    func remover(indice: Int){
        
        tarefas = listar()
        tarefas.remove(at: indice)
        
        //Salva a alteracao
        UserDefaults.standard.set(tarefas, forKey: chave)
    }
}
