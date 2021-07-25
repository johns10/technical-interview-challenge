function search(term, data) {
  console.log(term)
  const result = data.filter(item => item.name.toLowerCase().includes(term.toLowerCase()));
  console.log(result)
  return result
}

function navigate(imageDir) {
  console.log(imageDir)
}