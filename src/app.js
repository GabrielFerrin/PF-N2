import express from 'express'
import morgan from 'morgan'
import { corsMiddleware, corsOptions } from './middlewares/cors.js'
// routes
import helperRoutes from './routes/helper.routes.js'
import userRoutes from './routes/user.routes.js'
import postRoutes from './routes/post.routes.js'
import commentRoutes from './routes/comment.routes.js'
import rolesRoutes from './routes/role.routes.js'
import categoryRoutes from './routes/category.routes.js'

// config
const app = express()
app.use(express.json())
app.use(morgan('dev'))
app.use(corsMiddleware)
app.options('*', corsOptions)

// users
app.use('/api/user', userRoutes)
// posts
app.use('/api/post', postRoutes)
// comments
app.use('/api/comment', commentRoutes)
// roles
app.use('/api/role', rolesRoutes)
// categories
app.use('/api/category', categoryRoutes)
// helpers
app.use('/api/helper', helperRoutes)

app.use((req, res) => {
  res.status(404).send({ success: false, message: 'Route not found' })
})

// error handler
app.use((err, req, res, next) => {
  console.log(err.stack)
  res.status(500).send({ success: false, message: err.message })
})

export default app
