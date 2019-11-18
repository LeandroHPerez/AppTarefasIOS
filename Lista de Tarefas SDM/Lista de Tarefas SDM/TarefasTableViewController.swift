//
//  TarefasTableViewController.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 27/10/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import UIKit
import Firebase

class TarefasTableViewController: UITableViewController {
    
    @IBOutlet weak var labelPontuacao: UILabel!
    
    let firebase = Database.database().reference()
    var arrayTarefas: [Tarefa] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    //Toda vez que a tela e exibida
    override func viewDidAppear(_ animated: Bool) {
        atualizarListaTarefas()
    }
    
    
    
    
    
    
    func listarTarefasRegistrarListener() -> Void{
        
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
            self.arrayTarefas.append( tarefa )
            
            /* Prints para dev
            print ("tamanho arrayTarefas apos append " + String(self.arrayTarefas.count))
            print("printando o array")
            print(self.arrayTarefas)
             */
            
            self.tableView.reloadData() //avisa a tabela para atualizar as infos na tela
        })

    }
    
    
    
    func atualizarListaTarefas(){
        
        atualizarListaTarefasFirebase()
        
        //atualizarListaTarefasUserDefaults() //Incialmente desenvolvido com userDefaults e depois foi alterado para Firebase (lembra professor? Perguntei e voce me disse que userdefaults era armazenamento em arquivo... entao mudei para firebase - sim, meu teclado nao esta configurado

    }
    

    
    func atualizarListaTarefasFirebase(){
        
        //Deveria funcionar, mas gera problemas no meu emulador e nao deu certo debugar na virtual machine
        /*
        let tarefaFb = TarefaFirebase()
        self.arrayTarefas = tarefaFb.listarTarefasRegistrarListener()
        tableView.reloadData() //avisa a tabela para atualizar as infos na tela
        */
        
        //print ("Printando array de tarefas")
        //print(self.arrayTarefas)
        listarTarefasRegistrarListener()
        
        tableView.reloadData() //avisa a tabela para atualizar as infos na tela
    }

    
  


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        //print ("tamanho arrayTarefas " + String(arrayTarefas.count))
        return self.arrayTarefas.count
        
    }

    
    //Monta a tabela com os dados
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        celula.textLabel?.text = arrayTarefas[ indexPath.row ].descricaoTarefa
        
        var concluido = arrayTarefas[ indexPath.row ].concluido
        var concluidoTexto = "Nao concluido"
        if concluido {
            concluidoTexto = "Concluido"
        }
        celula.detailTextLabel?.text = concluidoTexto

        return celula
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    //Habilita o clique e arrastar da direita para a esquerda
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete { //se clicou no delete
            // Delete the row from the data source
            
            let tarefaFb = TarefaFirebase()
            let keyValue = arrayTarefas[indexPath.row].uid //pega o uid do elemento na linha do clique
            tarefaFb.remover(uidElemento: keyValue)
 
            //Remove do array interno
            self.arrayTarefas.remove(at: indexPath.row) //linha do clique
            
            atualizarListaTarefas()
            
            
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    */
    }
    
    
    //Trata os cliques na linha
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.arrayTarefas.count > 0 {
            let tarefa = self.arrayTarefas[indexPath.row]
            
            self.performSegue(withIdentifier: "detalhesEdicaoTarefaSegue", sender: tarefa)
            
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalhesEdicaoTarefaSegue"{
            let detalhesEdicaoController = segue.destination as! DetalhesEdicaoViewController
            
            detalhesEdicaoController.tarefa = sender as! Tarefa
        }
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
