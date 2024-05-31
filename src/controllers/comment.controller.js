import sql from '../db-config.js'

export const createComment = (req, res) => {
  /* #swagger.tags = ['Comentarios']
    #swagger.description = 'Crea un nuevo comentario.' */
  /*  #swagger.parameters['body'] = {
            in: 'body',
            schema: {
                $user_id: 14,
                $post_id: 14,
                $content: 'I dont agree. Its the easiest thing!'
            }
    } */
  let message = 'Missing information'
  try {
    // validate fields
    const errorList = []
    validateFields(req.body, errorList)
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(400).json({ success: false, message, errorList })
    }
    // create comment
    const query = 'INSERT INTO comment SET ?'
    sql.query(query, [req.body])
    res.json({ success: true, message: 'Comment created' })
  } catch (error) {
    message = 'Error creating comment'
    return res.status(500).json({ success: false, message, error })
  }
}

const validateFields = async (body, errorList) => {
  if (!body.user_id) errorList.push('User id is required')
  if (!body.post_id) errorList.push('Post id required')
  if (!body.content) errorList.push('Content is required')
}

// READ
export const getComments = async (req, res) => {
  /* #swagger.tags = ['Comentarios']
    #swagger.description = 'Devuelve los comentarios de una publicación.' */
  let message = 'Missing information'
  try {
    const { postId } = req.query
    if (!postId) {
      return res.status(400).json({ success: false, message })
    }
    const query = 'SELECT * FROM v_comment WHERE post_id = ?'
    const [result] = await sql.query(query, [postId])
    message = 'Comments retrieved'
    return res.json({ success: true, message, comments: result })
  } catch (error) {
    message = 'Error retrieving comments'
    return res.status(500).json({ success: false, message, error })
  }
}

// UPDATE
export const updateComment = async (req, res) => {
  /* #swagger.tags = ['Comentarios']
    #swagger.description = 'Actualiza un comentario.' */
  /*  #swagger.parameters['userId'] = {
            in: 'query',
            description: 'User id',
            type: 'number'
    } */
  /*  #swagger.parameters['commentId'] = {
            in: 'query',
            description: 'Comment id',
            type: 'number'
    } */
  /*  #swagger.parameters['body'] = {
            in: 'body',
            schema: {
                $content: 'I agree. Its the easiest thing!'
            }
    } */
  try {
    const { userId, commentId } = req.query
    if (!userId || !commentId || !req.body.content) {
      const message = 'Missing information'
      return res.status(404).json({ success: false, message })
    }
    // verify if user is the comment owner
    const ouwnership = await verifyOwnership(userId, commentId)
    if (!ouwnership.success) {
      return res.status(404).json(ouwnership)
    }
    // update comment
    const query = 'UPDATE comment SET ? WHERE comment_id = ? and user_id = ?'
    await sql.query(query, [req.body, commentId, userId])
    const message = 'Comment updated'
    return res.json({ success: true, message })
  } catch (error) {
    const message = 'Error updating comment'
    return res.status(500).json({ success: false, message, error })
  }
}

const verifyOwnership = async (userId, commentId) => {
  const query = 'SELECT user_id FROM comment WHERE comment_id = ?'
  const [result] = await sql.query(query, [commentId])
  if (result[0]?.user_id.toString() !== userId || result.length === 0) {
    const message = 'The user is not the owner of this comment'
    return { success: false, message }
  } else {
    return { success: true }
  }
}

// DELETE
export const deleteComment = async (req, res) => {
  /* #swagger.tags = ['Comentarios']
    #swagger.description = 'Elimina un comentario.' */
  try {
    const { userId, commentId } = req.query
    if (!userId || !commentId) {
      const message = 'Missing information'
      return res.status(404).json({ success: false, message })
    }
    // verify if user is the comment owner
    const ouwnership = await verifyOwnership(userId, commentId)
    if (!ouwnership.success) {
      return res.status(401).json(ouwnership)
    }
    // delete comment
    const query = 'DELETE FROM comment WHERE comment_id = ?'
    await sql.query(query, [commentId])
    const message = 'Comment deleted'
    return res.json({ success: true, message })
  } catch (error) {
    const message = 'Error deleting comment'
    return res.status(500).json({ success: false, message, error })
  }
}
