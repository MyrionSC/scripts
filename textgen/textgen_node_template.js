
input_list = ["world"]

function template(inp) {
    return `
        Hello ${inp}
    `
}

for (const inp of input_list) {
  console.log(template(inp))
}

