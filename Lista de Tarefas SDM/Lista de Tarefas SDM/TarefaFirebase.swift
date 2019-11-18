//
//  TarefaFirebase.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 09/11/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class TarefaFirebase{
    
    let chave = "listaTarefas"
    var tarefas: [String] = []
    
    let firebase = Database.database().reference()
    var arrayTarefas: [Tarefa] = []
    
    
    func salvar(tarefa: String){
        
        //Salvar
        let descTarefa = tarefa
        let concluido = "false"
        
        let refTarefas = firebase.child("tarefas")
        let keyValue = firebase.child("tarefas").childByAutoId().key
        let novaRef = firebase.child("tarefas").child(keyValue!)
        let tarefaEspecifica = ["tarefa" : descTarefa, "concluido" : concluido]
        
        //Salva a tarefa no firebase
        novaRef.setValue(tarefaEspecifica)
        
        print("Tarefa salva: " + descTarefa)
    }
    
    
    
    func remover(uidElemento: String){
        
        //Remove o elemento
        let refTarefas = firebase.child("tarefas")
        let keyValue = uidElemento
        let novaRef = firebase.child("tarefas").child(keyValue)
        
        //Salva a REMOCAO da tarefa no firebase
        novaRef.removeValue()
    }
    
    
    func atualizar(uidTarefa: String, descTarefa: String, concluido: Bool){
        
        var concluidoTexto = "false"
        if concluido {
            concluidoTexto = "true"
        }
        
        //Atualizar a tarefa/Salvar
        let refTarefas = firebase.child("tarefas")
        let novaRef = firebase.child("tarefas").child(uidTarefa) //onde [e feita a atualizacao
        let tarefaEspecificaAtualizacao = ["tarefa" : descTarefa, "concluido" : concluidoTexto]
        
        //Salva a tarefa no firebase
        novaRef.updateChildValues(tarefaEspecificaAtualizacao)
        //novaRef.updateChildren(tarefaEspecificaAtualizacao)
        
        print("Tarefa atualizada: " + uidTarefa + " " + descTarefa)
    }
    
    
    
    
    func listarTarefasRegistrarListener() -> Array<Tarefa>{
        
        self.arrayTarefas.removeAll()
        self.arrayTarefas = [Tarefa]()
        
        
        let noTarefas = firebase.child("tarefas")
        
        //Cria o listener do firebase
        noTarefas.observe(DataEventType.childAdded, with: {(DataSnapshot) in
            //print (DataSnapshot)
            let dados = DataSnapshot.value as? NSDictionary
            var concluido = false
            
            //Recuperando os dados
            let keyItem = DataSnapshot.key
            let descricaoTarefa = dados?["tarefa"] as! String
            let concluidoTexto = dados?["concluido"] as! String
            
            if concluidoTexto.elementsEqual("true"){
                concluido = true
            }
            
            /*
             print ("Dados")
             print (descricaoTarefa)
             print(concluidoTexto)
             print (keyItem)
             */
            
            
            let tarefa = Tarefa(descricaoTarefa: descricaoTarefa, concluido: concluido, uid: keyItem)
            //self.arrayTarefas.append( tarefa )
          

        })
        
        
        return self.arrayTarefas
        
    }
    
    
    
}
