def evaluate_expression(expression: str) -> str:
    """
    Evaluates an algebraic expression recursively.

    Args:
    expression: A string representing the algebraic expression.

    Returns:
    A string representing the result of the algebraic expression.
    """
    # Remove all whitespaces from the expression
    expression = expression.replace(" ", "")

    # Check if the expression is valid
    if not is_valid_expression(expression):
        return "Invalid Expression"

    # Evaluate the expression recursively
    return str(evaluate_expression_helper(expression))


def evaluate_expression_helper(expression: str) -> float:
    """
    Evaluates an algebraic expression recursively.

    Args:
    expression: A string representing the algebraic expression.

    Returns:
    A float representing the result of the algebraic expression.
    """
    # Base case: If the expression is a single number, return it
    if is_number(expression):
        return float(expression)

    # Find the index of the rightmost operator that is not inside a grouping
    index = find_rightmost_operator(expression)

    # Split the expression into two parts: left and right of the operator
    left_expression = expression[:index]
    right_expression = expression[index + 1:]

    # Evaluate the left and right expressions recursively
    left_value = evaluate_expression_helper(left_expression)
    right_value = evaluate_expression_helper(right_expression)

    # Apply the operator to the left and right values
    operator = expression[index]
    if operator == "+":
        return left_value + right_value
    elif operator == "-":
        return left_value - right_value
    elif operator == "*":
        return left_value * right_value
    elif operator == "/":
        return left_value / right_value


def is_valid_expression(expression: str) -> bool:
    """
    Checks if an algebraic expression is valid.

    Args:
    expression: A string representing the algebraic expression.

    Returns:
    True if the expression is valid, False otherwise.
    """
    # Check if the expression contains only valid characters
    for char in expression:
        if not (char.isdigit() or char in "+-*/.()"):
            return False

    # Check if the expression has balanced parentheses
    stack = []
    for char in expression:
        if char == "(":
            stack.append(char)
        elif char == ")":
            if not stack:
                return False
            stack.pop()
    if stack:
        return False

    # Check if the expression has consecutive operators
    for i in range(len(expression) - 1):
        if expression[i] in "+-*/" and expression[i + 1] in "+-*/":
            return False

    # Check if the expression starts or ends with an operator
    if expression[0] in "+-*/" or expression[-1] in "+-*/":
        return False

    return True


def is_number(expression: str) -> bool:
    """
    Checks if a string is a valid number.

    Args:
    expression: A string representing the expression.

    Returns:
    True if the string is a valid number, False otherwise.
    """
    try:
        float(expression)
        return True
    except ValueError:
        return False


def find_rightmost_operator(expression: str) -> int:
    """
    Finds the index of the rightmost operator that is not inside a grouping.

    Args:
    expression: A string representing the expression.

    Returns:
    An integer representing the index of the rightmost operator.
    """
    # Start from the right end of the expression
    index = len(expression) - 1
    depth = 0
    while index >= 0:
        char = expression[index]
        if char == ")":
            depth += 1
        elif char == "(":
            depth -= 1
        elif depth == 0 and char in "+-*/":
            return index
        index -= 1
    return -1


result = evaluate_expression("3 + 4 * (2 - 1)")
print(result)
