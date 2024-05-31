import { Router } from 'express'

const router = Router()

router.get('/server-active', (req, res) => {
  /* #swagger.tags = ['Otras']
    #swagger.description = 'Verifica si el servidor está activo.' */
  res.json({ success: true, message: 'Server is running' })
})

export default router
