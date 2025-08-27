import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('❌ 请提供一个 Dart 文件路径');
    exit(1);
  }

  final code = File(args[0]).readAsStringSync();
  final result = parseString(content: code);

  if (result.errors.isNotEmpty) {
    print('❌ 解析错误:');
    for (var error in result.errors) {
      print('  ${error.message}');
    }
    exit(1);
  }

  final unit = result.unit;

  print("📦 完整 AST 语法树:");
  print("═" * 50);
  _printCompilationUnit(unit, 0);

  print("\n🎯 Widget 结构分析:");
  print("═" * 50);
  _analyzeWidgets(unit);
}

void _printCompilationUnit(CompilationUnit unit, int indent) {
  final prefix = "  " * indent;

  // 打印导入语句
  if (unit.directives.isNotEmpty) {
    print("${prefix}📋 导入声明:");
    for (var directive in unit.directives) {
      if (directive is ImportDirective) {
        print("${prefix}  📦 import: ${directive.uri}");
      }
    }
    print("");
  }

  // 打印类声明
  for (var declaration in unit.declarations) {
    _printDeclaration(declaration, indent);
  }
}

void _printDeclaration(Declaration declaration, int indent) {
  final prefix = "  " * indent;

  if (declaration is ClassDeclaration) {
    print("${prefix}🏛️  类声明: ${declaration.name.lexeme}");
    if (declaration.extendsClause != null) {
      print("${prefix}  📤 继承: ${declaration.extendsClause!.superclass}");
    }
    if (declaration.implementsClause != null) {
      print("${prefix}  🔌 实现: ${declaration.implementsClause!.interfaces}");
    }

    print("${prefix}  📋 成员:");
    for (var member in declaration.members) {
      _printClassMember(member, indent + 2);
    }
    print("");
  }
}

void _printClassMember(ClassMember member, int indent) {
  final prefix = "  " * indent;

  if (member is MethodDeclaration) {
    print("${prefix}⚙️  方法: ${member.name.lexeme}");
    print("${prefix}  📝 返回类型: ${member.returnType ?? 'void'}");

    if (member.parameters != null) {
      print("${prefix}  📥 参数:");
      for (var param in member.parameters!.parameters) {
        print(
            "${prefix}    🔸 ${param.name?.lexeme ?? 'unnamed'}: ${param.declaredElement?.type ?? 'dynamic'}");
      }
    }

    if (member.name.lexeme == "build") {
      print("${prefix}  🎯 Build方法体:");
      _printMethodBody(member.body, indent + 2);
    }
  } else if (member is ConstructorDeclaration) {
    print("${prefix}🏗️  构造函数: ${member.name?.lexeme ?? 'default'}");
  } else if (member is FieldDeclaration) {
    print(
        "${prefix}📊 字段: ${member.fields.variables.map((v) => v.name.lexeme).join(', ')}");
  }
}

void _printMethodBody(FunctionBody body, int indent) {
  final prefix = "  " * indent;

  if (body is ExpressionFunctionBody) {
    print("${prefix}🔄 表达式函数体:");
    _printExpression(body.expression, indent + 1);
  } else if (body is BlockFunctionBody) {
    print("${prefix}🔄 块函数体:");
    for (var statement in body.block.statements) {
      _printStatement(statement, indent + 1);
    }
  }
}

void _printStatement(Statement statement, int indent) {
  final prefix = "  " * indent;

  if (statement is ReturnStatement) {
    print("${prefix}↩️  返回语句:");
    if (statement.expression != null) {
      _printExpression(statement.expression!, indent + 1);
    }
  } else if (statement is VariableDeclarationStatement) {
    print("${prefix}📝 变量声明:");
    for (var variable in statement.variables.variables) {
      print("${prefix}  🔸 ${variable.name.lexeme}");
      if (variable.initializer != null) {
        print("${prefix}    初始值:");
        _printExpression(variable.initializer!, indent + 2);
      }
    }
  } else {
    print("${prefix}📄 其他语句: ${statement.runtimeType}");
  }
}

void _printExpression(Expression expression, int indent) {
  final prefix = "  " * indent;

  if (expression is InstanceCreationExpression) {
    print("${prefix}🏗️  创建实例: ${expression.constructorName.type}");

    if (expression.argumentList.arguments.isNotEmpty) {
      print("${prefix}  📥 参数:");
      for (var arg in expression.argumentList.arguments) {
        if (arg is NamedExpression) {
          print("${prefix}    🏷️  ${arg.name.label.name}:");
          _printExpression(arg.expression, indent + 3);
        } else {
          print("${prefix}    🔸 位置参数:");
          _printExpression(arg, indent + 3);
        }
      }
    }
  } else if (expression is MethodInvocation) {
    print("${prefix}📞 方法调用: ${expression.methodName.name}");
    if (expression.target != null) {
      print("${prefix}  🎯 调用目标:");
      _printExpression(expression.target!, indent + 2);
    }
    if (expression.argumentList.arguments.isNotEmpty) {
      print("${prefix}  📥 参数:");
      for (var arg in expression.argumentList.arguments) {
        if (arg is NamedExpression) {
          print("${prefix}    🏷️  ${arg.name.label.name}:");
          _printExpression(arg.expression, indent + 3);
        } else {
          print("${prefix}    🔸 位置参数:");
          _printExpression(arg, indent + 3);
        }
      }
    }
  } else if (expression is ListLiteral) {
    print("${prefix}📋 列表字面量: [${expression.elements.length} 个元素]");
    for (int i = 0; i < expression.elements.length; i++) {
      var element = expression.elements[i];
      print("${prefix}  [$i]:");
      if (element is Expression) {
        _printExpression(element, indent + 2);
      }
    }
  } else if (expression is SimpleStringLiteral) {
    print("${prefix}💬 字符串: \"${expression.value}\"");
  } else if (expression is SimpleIdentifier) {
    print("${prefix}🔤 标识符: ${expression.name}");
  } else if (expression is PropertyAccess) {
    print("${prefix}🔗 属性访问: ${expression.propertyName.name}");
    if (expression.target != null) {
      print("${prefix}  目标:");
      _printExpression(expression.target!, indent + 2);
    }
  } else if (expression is FunctionExpression) {
    print("${prefix}⚡ 函数表达式");
    if (expression.body is ExpressionFunctionBody) {
      print("${prefix}  表达式体:");
      _printExpression(
          (expression.body as ExpressionFunctionBody).expression, indent + 2);
    } else if (expression.body is BlockFunctionBody) {
      print("${prefix}  块体:");
      for (var stmt
          in (expression.body as BlockFunctionBody).block.statements) {
        _printStatement(stmt, indent + 2);
      }
    }
  } else {
    print("${prefix}❓ 其他表达式: ${expression.runtimeType}");
  }
}

void _analyzeWidgets(CompilationUnit unit) {
  for (var decl in unit.declarations) {
    if (decl is ClassDeclaration) {
      for (var member in decl.members) {
        if (member is MethodDeclaration && member.name.lexeme == "build") {
          print("🎯 在类 ${decl.name.lexeme} 中找到 build 方法");
          print("📱 Widget 层次结构:");
          final body = member.body;
          if (body is ExpressionFunctionBody) {
            _printWidget(body.expression, 0);
          } else if (body is BlockFunctionBody) {
            body.block.visitChildren(_WidgetVisitor());
          }
        }
      }
    }
  }
}

void _printWidget(Expression expr, int indent) {
  final prefix = "  " * indent;

  if (expr is InstanceCreationExpression) {
    print("${prefix}📱 Widget: ${expr.constructorName.type}");
    for (var arg in expr.argumentList.arguments) {
      if (arg is NamedExpression) {
        print("${prefix}  🏷️  属性: ${arg.name.label.name}");
        _printWidget(arg.expression, indent + 2);
      } else {
        print("${prefix}  🔸 位置参数:");
        _printWidget(arg, indent + 2);
      }
    }
  } else if (expr is MethodInvocation) {
    print("${prefix}📞 方法调用: ${expr.methodName.name}");
    if (expr.target != null) {
      print("${prefix}  🎯 调用目标:");
      _printWidget(expr.target!, indent + 2);
    }
    if (expr.argumentList.arguments.isNotEmpty) {
      print("${prefix}  📥 参数:");
      for (var arg in expr.argumentList.arguments) {
        if (arg is NamedExpression) {
          print("${prefix}    🏷️  ${arg.name.label.name}:");
          _printWidget(arg.expression, indent + 3);
        } else {
          print("${prefix}    🔸 位置参数:");
          _printWidget(arg, indent + 3);
        }
      }
    }
  } else if (expr is ListLiteral) {
    print("${prefix}📋 子组件列表: [${expr.elements.length} 个]");
    for (int i = 0; i < expr.elements.length; i++) {
      var elem = expr.elements[i];
      print("${prefix}  [$i]:");
      if (elem is Expression) {
        _printWidget(elem, indent + 2);
      }
    }
  } else if (expr is FunctionExpression) {
    print("${prefix}⚡ 函数表达式");
  } else if (expr is SimpleStringLiteral) {
    print("${prefix}💬 字符串: \"${expr.value}\"");
  } else if (expr is SimpleIdentifier) {
    print("${prefix}🔤 标识符: ${expr.name}");
  } else if (expr is PropertyAccess) {
    print("${prefix}🔗 属性访问: ${expr.propertyName.name}");
  } else {
    print("${prefix}❓ 其他: ${expr.runtimeType}");
  }
}

class _WidgetVisitor extends RecursiveAstVisitor<void> {
  @override
  void visitReturnStatement(ReturnStatement node) {
    if (node.expression != null) {
      _printWidget(node.expression!, 0);
    }
  }
}
