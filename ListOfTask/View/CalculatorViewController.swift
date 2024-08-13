//
//  CalculatorViewController.swift
//  ListOfTask
//
//  Created by Belkis Arufe on 12/08/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var descuento: UILabel!
    @IBOutlet weak var cantidadtxt: UITextField!
    @IBOutlet weak var porcentajetxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func calcular(_ sender: UIButton) {
        guard let cantidad = cantidadtxt.text else {return}
        guard let porcentaje = porcentajetxt.text else {return}
        
        let cant = (cantidad as NSString).floatValue
        let porciento = (porcentaje as NSString).floatValue
        
        let desc = cant * porciento/100
        let res = cant - desc
        
        resultado.text = "$\(res)"
        descuento.text = "$\(desc)"
        self.view.endEditing(true)
    }
    
    @IBAction func limpiar(_ sender: UIButton) {
        cantidadtxt.text = ""
        porcentajetxt.text = ""
        resultado.text = "$0.00"
        descuento.text = "$0.00"
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
