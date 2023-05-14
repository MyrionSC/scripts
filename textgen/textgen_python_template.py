
input_list = ["world"]

def template(inp):
    return f"""
        Hello {inp}
    """

for inp in input_list:
  print(template(inp))

