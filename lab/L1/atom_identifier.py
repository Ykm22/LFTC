# commands shortcuts
# py .\atom_identifier.py .\l1_p1\l1_p1.cpp
# py .\atom_identifier.py .\l1_p2\l1_p2.cpp
# py .\atom_identifier.py .\l1_p3\l1_p3.cpp
# py .\atom_identifier.py .\l1_p4\l1_p4.cpp


import os
import argparse

def read_cmd_line():
    parser = argparse.ArgumentParser(description="CLA parser")
    parser.add_argument('input_file')
    args = parser.parse_args()
    return args.input_file

punctuationMarks = [";", ",", " ", "(", ")", "{", "}", ""]
def isPunctuatonMark(ch):
    if(ch in punctuationMarks):
        return True
    return False

def endsInPunctuationMark(atom):
    if(isPunctuatonMark(atom[-1])):
        return True
    return False

def beginsWithPunctuationMark(atom):
    if(isPunctuatonMark(atom[0])):
        return True
    return False 

def clean_atom(atom):
    # if(isPunctuatonMark(atom)):
    #     return None
    # while endsInPunctuationMark(atom):
    #     atom = atom[0:-1]
    # while beginsWithPunctuationMark(atom):
    #     atom = atom[1:]
    if atom == "":
        return None
    return atom

def isInteger(atom):
    return atom.isdigit() or (atom[0] == '-' and atom[1:].isdigit())

def isFloat(atom):
    try:
        float(atom)
        return True
    except Exception:
        return False

def isOperator(atom):
    operators = ["+", "-", "/", "%", "=", "<<", ">>", "!=", "*"]
    return atom in operators

def isIdentifier(atom):
    return atom.isalpha()

def isKeyword(atom):
    keywords = ["while", "if", "for", "int", "float", "namespace", "using", "#include", "return", "else"]
    return atom in keywords or ( atom[0] == '<' and atom[-1] == '>')

def isHexa(atom):
    return atom[0] == "0" and atom[1] == "x" and isInteger(atom[2:])

def isSeparator(atom):
    return atom == "," or atom == ";" or atom == "(" or atom == ")" or atom == "{" or atom == "}"

def isBinary(atom):
    if atom[0] == "0" and atom[1] == "b":
        for i in range(2, len(atom)):
            if atom[i] != "0" and atom[i] != "1":
                return False
        return True
    return False

def save_atoms(atoms, output_file):
    for atom in atoms:
        if atom != None:
            output_file.write(atom + ",")
            if isInteger(atom):
                output_file.write("int")
            elif isFloat(atom):
                output_file.write("float")
            elif isHexa(atom):
                output_file.write("hexa")
            elif isBinary(atom):
                output_file.write("binary")
            elif isOperator(atom):
                output_file.write("operator")
            elif isKeyword(atom):
                output_file.write("keyword")
            elif isSeparator(atom):
                output_file.write("separator")
            elif isIdentifier(atom):
                output_file.write("ID")
            else:
                output_file.write("unknown symbol\n")
                quit()
            output_file.write("\n")

def delete_output_file(file, directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
    if os.path.exists(file):
        os.remove(file)

def main(input_file):
    try:
        with open(input_file, 'r') as file:
            directory = "atoms"
            output_file = os.path.join(directory, (file.name).split('\\')[-1] + ".txt")
            delete_output_file(output_file, directory)

            with open(output_file, 'w') as output_file:
                for line in file:
                    line = line.strip().split(' ')
                    atoms = [clean_atom(atom) for atom in line]
                    save_atoms(atoms, output_file)

    except FileNotFoundError:
        print("The file does not exist.")
    except Exception as e:
        print(f"Erorr: {e}")

if __name__ == "__main__":
    input_file = read_cmd_line()
    main(input_file)
