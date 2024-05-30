import { Router } from 'express'

const router = Router()

router.get('/helper', (req, res) => {
  res.json({ success: true, message: 'Get helper' })
})

export default router
