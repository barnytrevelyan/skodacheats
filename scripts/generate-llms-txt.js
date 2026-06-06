const BRAND = require('../config/brand.config')
const fs = require('fs')
fs.writeFileSync('public/llms.txt', BRAND.llmsTxt)
console.log('public/llms.txt generated')
