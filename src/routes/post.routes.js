import { Router } from 'express'
import {
  createPost, deletePost, getAllPosts, getPostsByCategory,
  getPostsByTitle,
  updatePost
} from '../controllers/post.controller.js'

const router = Router()

// CREATE
router.post('/post', createPost)
// READ
router.get('/all', getAllPosts)
router.get('/by-category', getPostsByCategory)
router.get('/by-title', getPostsByTitle)
// UPDATE
router.patch('/post', updatePost)
// DELETE
router.delete('/post', deletePost)

export default router
