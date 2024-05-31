import swaggerAutogen from 'swagger-autogen'

const doc = {
  info: {
    title: 'Sistema de Blogging FUNVAL',
    description: 'Proyecto Final Nivel 2'
  },
  host: 'pf-n2.onrender.com',
  ignore: ['origin', 'host']
  // host: 'pf-n2.onrender.com'
}

const outputFile = './swagger-output.json'
const routes = ['./src/app.js']

swaggerAutogen()(outputFile, routes, doc)
