//
//  DetalhesEdicaoViewController.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 15/11/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import UIKit

class DetalhesEdicaoViewController: UIViewController {
    
    
    @IBOutlet weak var tarefaCampo: UITextField!
    
    
    @IBOutlet weak var switchConcluida: UISwitch!
    
    @IBOutlet weak var labelConcluida: UILabel!
    
    @IBOutlet weak var botaoSalvar: UIButton!
    
    var tarefa = Tarefa()
    
    
    @IBAction func botaoSalvar(_ sender: Any) {
        
        print ("Clicou no salvar")
       
        if let textoDigitado = tarefaCampo.text {
            
            var valorSwitch = false
            if switchConcluida.isOn{
                valorSwitch = true
                print ("Valor do valorSwitch = true")
            } else {
                valorSwitch  = false
                print ("Valor do valorSwitch = false")
            }
            
            self.tarefa.descricaoTarefa = textoDigitado
            self.tarefa.concluido = valorSwitch
            
            
            let tarefaFb = TarefaFirebase()
            tarefaFb.atualizar(uidTarefa: self.tarefa.uid, descTarefa: self.tarefa.descricaoTarefa, concluido: self.tarefa.concluido)
            
            //self.performSegue(withIdentifier: "telaListarTarefasSegue", sender: nil)
            self.performSegue(withIdentifier: "telaInicialSegue", sender: nil)
            
            
            //dismiss(animated: true, completion: nil)
            //self.navigationController?.popToRootViewController(animated: true)
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostrar o teclado
        //tarefaCampo.becomeFirstResponder()

        // Do any additional setup after loading the view.
        tarefaCampo.text = tarefa.descricaoTarefa
        
        
        var concluido = tarefa.concluido
        var concluidoTexto = "Nao concluido"
        if concluido {
            concluidoTexto = "Concluido"
        }

        self.labelConcluida.text = concluidoTexto
        
        switchConcluida.isOn = concluido
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
