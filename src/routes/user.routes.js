import { Router } from 'express'
import {
  createUser, deleteUser, getAllUsers, getUser, updateUser
} from '../controllers/user.controller.js'

const router = Router()

router.post('/user', createUser)
router.get('/all', getAllUsers)
router.get('/user', getUser)
router.patch('/user', updateUser)
router.delete('/user', deleteUser)

export default router
