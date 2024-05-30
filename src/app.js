import express from 'express'
import morgan from 'morgan'
import { corsMiddleware, corsOptions } from './middlewares/cors.js'
// routes
import helperRoutes from './routes/helper.routes.js'
import userRoutes from './routes/user.routes.js'
import postRoutes from './routes/post.routes.js'
import commentRoutes from './routes/comment.routes.js'
import rolesRoutes from './routes/role.routes.js'

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
// helpers
app.use('/api/helper', helperRoutes)

export default app
