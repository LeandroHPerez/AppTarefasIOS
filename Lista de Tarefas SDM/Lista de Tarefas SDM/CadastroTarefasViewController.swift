//
//  CadastroTarefasViewController.swift
//  Lista de Tarefas SDM
//
//  Created by Leandro Perez on 27/10/19.
//  Copyright © 2019 Leandro Perez. All rights reserved.
//

import UIKit

class CadastroTarefasViewController: UIViewController {

    
    @IBOutlet weak var tarefaCampo: UITextField!
    
    
    @IBAction func botaoAdicionarTarefa(_ sender: Any) {
        
        if let textoDigitado = tarefaCampo.text {
            
            let tarefaFb = TarefaFirebase()
            tarefaFb.salvar(tarefa: textoDigitado)
            tarefaCampo.text = ""
            
            //let dados = tarefa.listar()
            //print(dados)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
