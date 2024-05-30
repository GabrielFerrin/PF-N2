import { Router } from 'express'
import {
  createUser, deleteUser, getAllUsers, getUser, updateUser
} from '../controllers/user.controller.js'

const router = Router()

// CREATE
router.post('/user', createUser)
// READ
router.get('/all', getAllUsers)
router.get('/user', getUser)
// UPDATE
router.patch('/user', updateUser)
// DELETE
router.delete('/user', deleteUser)

export default router
