import { Router } from 'express'
import {
  createPost, deletePost, getAllPosts, getPostsByCategory,
  getPostsByTitle,
  updatePost
} from '../controllers/post.controller.js'

const router = Router()

router.post('/post', createPost)
router.get('/all', getAllPosts)
router.get('/by-category', getPostsByCategory)
router.get('/by-title', getPostsByTitle)
router.patch('/post', updatePost)
router.delete('/post', deletePost)

export default router
