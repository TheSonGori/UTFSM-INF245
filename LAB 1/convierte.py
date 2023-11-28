# LAB 1 - INF245 - ARQUITECTURA Y ORGANIZACION DE COMPUTADORES

#FILENAMES
Numbers = "numeros.txt"
Results = "resultados.txt"

#LISTS
Letters = [("A","10"),("B","11"),("C","12"),("D","13"),("E","14"),("F","15")]
NotLetters = ['G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

#FUNCTIONS
def AnalyzeNumber(Base, Number):
    '''
    Analiza si el numero (siendo este numero reducido: Por ejemplo de 'B1A3' esta funcion recibe -> '11', luego '1' y asi...)
    que se entrega como parametro corresponde a la base.
        Parametros:
            Base (str): Posible base de Number
            Number (str): Numero a analizar

        Returns:
            True (bool): Si el numero corresponde a la base retorna True
            False (bool): Si el numero no corresponde a la base retorna False
    '''
    if int(Number) >= int(Base):
        return False
    else:
        return True
    
def IterateThroughaWord(Number,Base):
    '''
    Analiza si el numero que se entrega como parametro corresponde a la base. (Aqui Number es por ejemplo: 'B1A3')
        Parametros:
            Number (str): Numero a analizar
            Base (str): Posible base de Number

        Returns:
            1 (int): Si el numero tiene error en la representacion numerica
            0 (int): Si el numero no tiene error en la representacion numerica
    '''
    for x in Number:
        for TupleLetters in Letters:
            Letter, NumberLetter = TupleLetters
            if x == Letter:
                x = NumberLetter
                Answer = AnalyzeNumber(Base, x)
                        
                if Answer == False:
                    return 1
                    
        Answer = AnalyzeNumber(Base,x)
        if Answer == False:
            return 1
    
    for x in Number:
        for y in NotLetters:
            if x == y:
                return 1
            
    return 0

def Exponential(ListNumber,Base,Exponencial):
    '''
    Multiplica el numero por su base de la forma: 'NUMERO' en base x = N*10^5 + U**10^4 + M*10^3 + E*10^2 + R*10^1 + O*10^0
    Si esto no es posible porque algunos de los numeros no puede ser representado por la base retorna False
        Parametros: 
            ListNumber (list): Lista del numero a analizar
            Base (str): Posible base de Number
            Exponencial (int): len(ListNumber)
        
        Returns:
            False (bool): Si el numero no corresponde a la base retorna False
            NewNumber (int): Si el numero si puede ser representado retorna el NewNumero
    '''
    Flag = False
    NewNumber = 0
    Base = int(Base)
    
    for x in ListNumber:
        Exponencial -= 1
        
        for y in NotLetters:
            if x == y:
                return False
        
        for TupleLetters in Letters:
            Letter, NumberLetter = TupleLetters
            if x == Letter:
                Flag = True
                NumberLetter = int(NumberLetter)
                
                Answer = AnalyzeNumber(Base, NumberLetter)     
                if Answer == False:
                    return False
                
                NewNumber += NumberLetter*Base**Exponencial
        
        if Flag != True:
            Answer = AnalyzeNumber(Base, x)     
            if Answer == False:
                return False
            
            NewNumber += int(x)*Base**Exponencial
        Flag = False
            
    return NewNumber

def BinForm(Number,Base):
    '''
    Transforma un numero de base x a numero binario, si esto no es posible retorna False
        Parametros:
            Number(str): Numero a analizar
            Base(str): Posible base de Number

        Returns:
            ''.join(Binario) (str): Retorna el Binario en forma de String
            False (bool): Si no se puede convertir a binario retornara False
    '''
    Exponencial = len(Number)
    ListNumber = list(Number)
    
    Answer = Exponential(ListNumber,Base,Exponencial)
    if Answer == False:
        return False
    
    else:
        NewNumber = int(Answer)
        Binario = []
        
        while NewNumber > 0:
            Cociente, Resto = divmod(NewNumber,2)
            Binario.append(str(Resto))
            NewNumber = Cociente
        
        Binario.reverse()
        return ''.join(Binario)

def SumBin(ListNumber1,ListNumber2):
    '''
    Suma dos numeros binarios y comprueba si existe overflow.
        Parametros:
            ListNumber1 (list): Lista de la representacion binaria de numero1 al reves
            ListNumber2 (list): Lista de la representacion binaria de numero2 al reves

        Returns:
            1 (int): Si la suma no provoca Overflow retorna 1
            0 (int): Si la suma no provoca Overflow retorna 0
    '''
    NewList = []
    Carry = False

    for x in range(len(ListNumber1)):
        if Carry == True:
            if (ListNumber1[x] == "0") and (ListNumber2[x] == "0"):
                NewList.append(1)
                Carry = False
            elif (ListNumber1[x] == "1") and (ListNumber2[x] == "0"):
                NewList.append(0)
            elif (ListNumber1[x] == "0") and (ListNumber2[x] == "1"):
                NewList.append(0)
            elif (ListNumber1[x] == "1") and (ListNumber2[x] == "1"):
                NewList.append(1)
        else:
            if (ListNumber1[x] == "0") and (ListNumber2[x] == "0"):
                NewList.append(0)
            elif (ListNumber1[x] == "1") and (ListNumber2[x] == "0"):
                NewList.append(1)
            elif (ListNumber1[x] == "0") and (ListNumber2[x] == "1"):
                NewList.append(1)
            elif (ListNumber1[x] == "1") and (ListNumber2[x] == "1"):
                NewList.append(0)
                Carry = True
                
    ListNumber1.reverse()
    ListNumber2.reverse()
    NewList.reverse()
    
    if (NewList[0] != int(ListNumber1[0])) :
        return 1
    else:
        return 0
  
def CalculateAandB():
    '''
    Calcula la letra A y B del (A;B;C;D // Formato resultados.txt)
    A -> Igual numeros en el archivo | B -> Total numeros con error en la representacion numerica
        Parametros:
            No hay parametros 

        Returns:
            (A,B) (tuple): Retorna el valor de A y B en forma de tupla
    '''
    A = 0
    B = 0
    
    try:
        with open(Numbers, 'r', encoding="utf-8") as Text:
            for Line in Text:
                #DIVISION (-)
                SplitLine = Line.split('-')
                
                #DIVISION (;)
                DivisionOne = SplitLine[0].split(';')
                DivisionTwo = SplitLine[1].split(';')
                
                
                #BASES AND NUMBERS
                BaseOne = int(DivisionOne[0])
                NumberOne = DivisionOne[1]
                
                BaseTwo = int(DivisionTwo[0])
                NumberTwo = DivisionTwo[1]
                
                #ELIMINATE \n
                NumberOne = NumberOne.replace("\n","")
                NumberTwo = NumberTwo.replace("\n","")
                
                A += 2
                
                B += IterateThroughaWord(NumberOne,BaseOne)
                B += IterateThroughaWord(NumberTwo,BaseTwo)
                               
    except FileNotFoundError:
        print("Error en la apertura del archivo: numeros.txt")
    
    return (A,B)      

def CalculateCandD(BitUser):
    '''
    Calcula la letra C y D del (A;B;C;D // Formato resultados.txt)
    C -> Total numeros que no pueden ser representados con el valor ingresado 
    D -> Total sumas realizadas en complemento 2 que provocan overflow en registros con el tamano ingresado por el usario
        Parametros:
            No hay parametros 

        Returns:
            (C,D) (tuple): Retorna el valor de C y D en forma de tupla
    '''
    C = 0
    D = 0
    
    try:
        with open(Numbers, 'r', encoding="utf-8") as Text:
            for Line in Text:
                #DIVISION (-)
                SplitLine = Line.split('-')
                
                #DIVISION (;)
                DivisionOne = SplitLine[0].split(';')
                DivisionTwo = SplitLine[1].split(';')
                
                #BASES AND NUMBERS
                BaseOne = int(DivisionOne[0])
                NumberOne = DivisionOne[1]
                
                BaseTwo = int(DivisionTwo[0])
                NumberTwo = DivisionTwo[1]
                
                #ELIMINATE \n
                NumberOne = NumberOne.replace("\n","")
                NumberTwo = NumberTwo.replace("\n","")
                
                Answer1 = BinForm(NumberOne,BaseOne)
                Answer2 = BinForm(NumberTwo,BaseTwo)     
                
                
                if Answer1 != False: 
                    if len(Answer1) > BitUser: 
                        C += 1
                                
                if Answer2 != False: 
                    if len(Answer2) > BitUser: 
                        C += 1
                
                if (Answer1 != False) and (Answer2 != False) and (len(Answer1) <= BitUser) and (len(Answer2) <= BitUser):
                    ListNumber1 = list(Answer1)
                    ListNumber2 = list(Answer2)

                    FirstBinNumber1 = ListNumber1[0]
                    FirstBinNumber2 = ListNumber2[0]

                    ListNumber1.reverse()
                    ListNumber2.reverse()
                    
                    if (len(Answer1) <= BitUser):
                        for x in range(BitUser):
                            if x > (len(ListNumber1) - 1):
                                ListNumber1.append(FirstBinNumber1)

                    if (len(Answer2) <= BitUser):
                        for x in range(BitUser):
                            if x > (len(ListNumber2) - 1):
                                ListNumber2.append(FirstBinNumber2)
                    
                    if ListNumber1[-1:] == ListNumber2[-1:]:
                            D += SumBin(ListNumber1,ListNumber2)
                                         
    except FileNotFoundError:
        print("Error en la apertura del archivo: numeros.txt")
        
    return (C,D)

def WriteInResultados(A,B,C,D):
    '''
    Escribe en el archivo "resultados.txt"
        Parametros:
            A (int): Igual numeros en el archivo 
            B (int): Total numeros con error en la representacion numerica
            C (int): Total numeros que no pueden ser representados con el valor ingresado
            D (int): Total sumas realizadas en complemento 2 que provocan overflow en registros con el tamano ingresado por el usario

        Returns:
            No hay retorno
    '''
    Formato = str(A) + ";" + str(B) + ";" + str(C) + ";" + str(D) + "\n"
    ArchiveResults = open(Results,"a")
    ArchiveResults.write(Formato)
    ArchiveResults.close()

def OpenResultados():
    '''
    Abre el archivo resultados.txt para validar si la cantidad de errores es mayor que la cantidad de numeros en el archivo
        Parametros:
            No hay parametros

        Returns:
            Count (int): Suma de B + C + D de cada linea en el archivo.txt 
    '''
    Count = 0
    try:
        with open(Results, 'r', encoding="utf-8") as Text:
            for Line in Text:
                #DIVISION (;)
                SplitLine = Line.split(';')
                
                #DIVISION (A;B;C;D"\n")
                B = int(SplitLine[1])
                C = int(SplitLine[2])
                D = int(SplitLine[3].replace("\n",""))
                
                Count += B + C + D
            
            return Count
                             
    except FileNotFoundError:
        print("Error en la apertura del archivo: resultados.txt")

#MAIN
A,B = CalculateAandB()

while True:
    C = 0
    D = 0
    
    BitUser = int(input("Ingrese un numero: "))
    
    if BitUser == 0:
        Answer = OpenResultados()
        if Answer > A:
            exit()
    
    else:
        C,D = CalculateCandD(BitUser)
        WriteInResultados(A,B,C,D)