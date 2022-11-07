/*
 ViewController
 Created by Sylvia Graham
 November 2022
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    var firstNumber = 0
    var resultNumber = 0
    
    var currentOperations: Operation?
    enum Operation{
        case add, subtract, multiply, divide
    }
    
    
    private var resultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "arial", size: 24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawNumberPad()
    }
    
    private func drawNumberPad()
    {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize,  width: buttonSize * 3, height: buttonSize))
        
        zeroButton.backgroundColor = .orange
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.setTitle("0", for: .normal)
        zeroButton.titleLabel?.font = UIFont(name: "arial", size: 50)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(zeroTapped),
            for: .touchUpInside)
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        
        
        for x in 0..<3{
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y:holder.frame.size.height - buttonSize * 2,  width: buttonSize, height: buttonSize))
            
            button1.backgroundColor = .orange
            button1.setTitleColor(.black, for: .normal)
            button1.setTitle("\(x+1)", for: .normal)
            button1.titleLabel?.font = UIFont(name: "arial", size: 50)
            button1.tag = x + 2
            button1.addTarget(self, action: #selector(numberPressed(_: )),
                for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        for x in 0..<3{
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - buttonSize * 3,  width: buttonSize, height: buttonSize))
            
            button2.backgroundColor = .orange
            button2.setTitleColor(.black, for: .normal)
            button2.setTitle("\(x+4)", for: .normal)
            button2.titleLabel?.font = UIFont(name: "arial", size: 50)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_: )),
                for: .touchUpInside)
            holder.addSubview(button2)
        }
        
        for x in 0..<3{
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - buttonSize * 4,  width: buttonSize, height: buttonSize ))
            
            button3.backgroundColor = .orange
            button3.setTitleColor(.black, for: .normal)
            button3.setTitle("\(x+7)", for: .normal)
            button3.titleLabel?.font = UIFont(name: "arial", size: 50)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_: )),
                for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize * 5,
            width: buttonSize * 4, height: buttonSize))
        
        clearButton.backgroundColor = .orange
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.setTitle("AC", for: .normal)
        clearButton.titleLabel?.font = UIFont(name: "arial", size: 50)
        holder.addSubview(clearButton)
        
        
        
        
        let operations =
        ["=", "+", "-", "*", "/"]
        
        for x in 0..<5{
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y:holder.frame.size.height - buttonSize * CGFloat(x+1),  width: buttonSize, height: buttonSize))
            button4.setTitleColor (.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitleColor(.black, for: .normal)
            button4.setTitle(operations[x], for: .normal)
            button4.titleLabel?.font = UIFont(name: "arial", size: 50)
            button4.tag = x + 1
            holder.addSubview(button4)
            button4.addTarget(self,
                                  action:#selector(operationPressed),
                                  for : .touchUpInside)
        }
        
        resultLabel.frame=CGRect(x: 0, y:clearButton.frame.origin.y-120,
            width: view.frame.size.width,
                                 height:100)
        
        resultLabel.textColor  = .black
        resultLabel.backgroundColor = .white
        resultLabel.font = UIFont(name: "Helvetica-Bold", size: 100)
        holder.addSubview(resultLabel)
        
        //Button Actions
        clearButton.addTarget(self,
                              action:#selector(clearResult),
                              for : .touchUpInside)
    }//DrawNumberPad
    @objc func clearResult(){
           print("Clear")
           resultLabel.text="0"
           currentOperations = nil
           firstNumber=0
       }
    @objc func zeroTapped(_ sender: UIButton){
        let tag = sender.tag - 1
        print ("Zero button tag \(tag)")
        
        if resultLabel.text != "0"
        {
            resultLabel.text = "\resultLabel.text \(tag)"
        }
        else if let text = resultLabel.text
        {
                resultLabel.text = "\(String(text))\(0)"
        }
    }
    
    @objc func numberPressed(_ sender: UIButton){
        print ("number")
        let tag = sender.tag - 1
        print("tag \(tag)")
        if resultLabel.text == "0"
        {
            print ("replacing zero with number")
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text
        {
            print ("appending value with number")
            resultLabel.text = "\(String(text))\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        print("operation button pressed")
        print("tag \(tag)")
        print(resultLabel.text)
        if let text = resultLabel.text, let value=Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }

        //enum "Operations"
        //case add, subtract, multiply, divide, equal
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value=Int(text){
                    secondNumber = value
                }
                print("first number \(firstNumber)")
                print("second number \(secondNumber)")
                switch operation {
                case .add:
                    print("operation add")
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    print("operation subtract")
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    print("operation multiply")
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    print("operation divide")
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                }
            }
        }
        else if tag == 2 {
            print("tag, op add \(tag)")
            currentOperations = .add
        }
        else if tag == 3 {
            print("tag, op subtract \(tag)")
            currentOperations = .subtract
        }
        else if tag == 4 {
            print("tag, op multiply \(tag)")
            currentOperations = .multiply
        }
        else if tag == 5 {
            print("tag, op divide \(tag)")
            currentOperations = .divide
        }
    }
}

