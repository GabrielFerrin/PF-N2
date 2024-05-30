import { Router } from 'express'
import {
  createComment, deleteComment, getComments,
  updateComment
} from '../controllers/comment.controller.js'

const router = Router()

// CREATE
router.post('/comment', createComment)
// READ
router.get('/comments', getComments)
// UPDATE
router.patch('/comment', updateComment)
// DELETE
router.delete('/comment', deleteComment)

export default router
