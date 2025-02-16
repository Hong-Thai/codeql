/**
 * @name Comma before misleading indentation
 * @description If expressions before and after a comma operator use different indentation, it is easy to misread the purpose of the code.
 * @kind problem
 * @id cpp/comma-before-misleading-indentation
 * @problem.severity warning
 * @security-severity 7.8
 * @precision medium
 * @tags maintainability
 *       readability
 *       security
 *       external/cwe/cwe-1078
 *       external/cwe/cwe-670
 */

import cpp
import semmle.code.cpp.commons.Exclusions

/** Gets the sub-expression of 'e' with the earliest-starting Location */
Expr normalizeExpr(Expr e) {
  result =
    min(Expr child |
      child.getParentWithConversions*() = e.getFullyConverted() and
      not child.getParentWithConversions*() = any(Call c).getAnArgument()
    |
      child order by child.getLocation().getStartColumn(), count(child.getParentWithConversions*())
    )
}

predicate isParenthesized(CommaExpr ce) {
  ce.getParent*().(Expr).isParenthesised()
  or
  ce.isUnevaluated() // sizeof(), decltype(), alignof(), noexcept(), typeid()
  or
  ce.getParent*() = [any(IfStmt i).getCondition(), any(SwitchStmt s).getExpr()]
  or
  ce.getParent*() = [any(Loop l).getCondition(), any(ForStmt f).getUpdate()]
  or
  ce.getEnclosingStmt() = any(ForStmt f).getInitialization()
}

from CommaExpr ce, Expr left, Expr right, Location leftLoc, Location rightLoc
where
  ce.fromSource() and
  not isFromMacroDefinition(ce) and
  left = normalizeExpr(ce.getLeftOperand()) and
  right = normalizeExpr(ce.getRightOperand()) and
  leftLoc = left.getLocation() and
  rightLoc = right.getLocation() and
  not isParenthesized(ce) and
  leftLoc.getEndLine() < rightLoc.getStartLine() and
  leftLoc.getStartColumn() > rightLoc.getStartColumn()
select right, "The indentation level may be misleading for some tab sizes."
