const allowedOrigins = new Set([
  'http://127.0.0.1:3011',
  'https://pf-n2.onrender.com'
])

export const corsMiddleware = (req, res, next) => {
  const origin = req.headers.origin || req.headers.host
  const isAllowed = allowedOrigins.has(origin)

  res.setHeader('Access-Control-Allow-Origin', isAllowed ? origin : '')
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,PATCH')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type')
  res.removeHeader('X-Powered-By')

  console.log('Origin:', origin)

  next()
}

export const corsOptions = (req, res) => {
  const origin = req.headers.origin || req.headers.host
  const isAllowed = allowedOrigins.has(origin)

  res.setHeader('Access-Control-Allow-Origin', isAllowed ? origin : '')
  res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,PATCH')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type')

  res.status(204).end()
}
