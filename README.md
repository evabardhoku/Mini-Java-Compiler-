# MiniJava Compiler Project (JFlex + CUP)

This repository contains a course project for the **Compilers** subject.  
It implements a MiniJava front-end in multiple steps:

- **Assignment 1:** Lexical analysis with **JFlex**
- **Assignment 2:** Syntax analysis (parser) with **Java CUP**
- **Assignment 3:** Semantic actions to build an **Abstract Syntax Tree (AST)**
- **Assignment 4:** **Type checking** using Visitors and a Symbol Table

## Features

- Tokenization of MiniJava source programs using JFlex specifications
- Parsing MiniJava grammar using CUP specifications
- Error reporting with line/column information (CUP `report_error`)
- AST construction via semantic actions (CUP)
- Symbol table building (classes, methods, fields, locals)
- Type checking rules for expressions and statements (Visitors)

## Tech Stack

- Java
- JFlex (lexer generator)
- Java CUP (parser generator)
- Visitor pattern (AST traversal)

## Requirements

- Java JDK (8+ recommended)
- JFlex installed (CLI available)
- Java CUP jar available in your classpath

## Build & Run

### 1) Generate the Lexer (JFlex)
If your lexer spec is called `miniJavaLexer.flex`:

```bash
jflex miniJavaLexer.flex
```

# Mini Java Compiler

2) Generate the Parser (CUP)

Replace `miniJava.cup` with your actual `.cup` filename.

```bash
java java_cup.Main miniJava.cup
```

This typically generates:

- `parser.java`
- `sym.java`

3) Compile the Project

If everything is in the same folder:

```bash
javac *.java
```

If you have subfolders (example: `symtab/`):

```bash
javac Scanner.java sym.java parser.java JavaSymbol.java symtab/*.java
```

4) Run on a Test Program

Example using a test file such as `test/Factorial.java`:

```bash
java parser test/Factorial.java > test/output_factorial.txt
```

Notes

- Some files (AST/Visitor jars or skeleton code) may be provided by the course. Include them on the classpath when compiling/running if needed.
- Make sure the generated JFlex/CUP class names match what you compile/run (e.g. `scanner` vs `Scanner`, `parser` vs `Parser`).
- If you get classpath errors, ensure the CUP jar is included when compiling/running. Example when `java-cup.jar` is required:

```bash
# compilation with CUP jar on classpath (Unix/macOS)
javac -cp .:java-cup.jar *.java
# running with CUP jar on classpath (Unix/macOS)
java -cp .:java-cup.jar parser test/Factorial.java
```


Author: Eva Bardhoku
