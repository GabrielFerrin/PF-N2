import { Router } from 'express'
import {
  createCategory, deleteCategory, getAllCategories,
  updateCategory
} from '../controllers/category.controller.js'

const router = Router()

// CREATE
router.post('/category', createCategory)
// READ
router.get('/all', getAllCategories)
// UPDATE
router.patch('/category', updateCategory)
// DELETE
router.delete('/category', deleteCategory)

export default router
