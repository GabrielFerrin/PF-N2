import sql from '../db-config.js'

// CREATE
export const createPost = async (req, res) => {
  /* #swagger.tags = ['Publicaciones']
    #swagger.description = 'Crea una nueva categoria.' */
  /*  #swagger.parameters['body'] = {
            in: 'body',
            schema: {
                $title: 'La política es muy sucia',
                $content: 'Es solo mi manera de pensar',
                $user_id: 14,
                $categories: [
                  {
                    $category_id: 3,
                  }
                ]
            }
    } */
  let message = 'Missing user id'
  try {
    // validate categories
    const errorList = []
    const { categories } = req.body
    await validateCategories(categories, errorList)
    // validate body
    await validateFields(req.body, errorList)
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(400).json({ success: false, message, errorList })
    }
    delete req.body.categories
    // create post
    let query = 'INSERT INTO post SET ?'
    const [result] = await sql.query(query, [req.body])
    const postId = result.insertId
    message = 'Post created'
    // create post categories
    await Promise.all(categories.map(async (category) => {
      category.post_id = postId
    }))
    const keys = Object.keys(categories[0])
    const headers = `(${keys.join(',')})`
    const values = categories
      .map(category => `(${keys.map(key => `'${category[key]}'`)
        .join(', ')})`)
    query = `INSERT INTO post_category ${headers} VALUES ${values}`
    await sql.query(query, categories)
    return res.json({ success: true, message })
  } catch (error) {
    message = 'Error creating post'
    return res.status(500).json({
      success: false,
      message,
      error: error.stack
    })
  }
}

const validateFields = async (body, errorList) => {
  try {
    // validate required fields
    if (!body.title) errorList.push('Title is required')
    if (!body.content) errorList.push('Content is required')
    if (!body.user_id) errorList.push('User id is required')
    // validate user id
  } catch (error) {
    errorList.push(error.message)
  }
}

const validateCategories = async (categories, errorList) => {
  if (!categories || categories?.length === 0) {
    errorList.push('Categories are required')
    return
  }
  await Promise.all(categories.map(async (category) => {
    const query = 'SELECT * FROM category WHERE category_id = ?'
    const [result] = await sql.execute(query, [category.category_id])
    const message = 'Invalid category id: ' + category.category_id
    if (result.length === 0) errorList.push(message)
  }))
}

// READ
export const getAllPosts = async (req, res) => {
  /* #swagger.tags = ['Publicaciones']
    #swagger.description = 'Devuelve todas las publicaciones.' */
  try {
    let query = 'SELECT * FROM v_post'
    const [results] = await sql.execute(query)
    if (results.length > 0) {
      await Promise.all(results.map(async (post) => {
        query = 'SELECT * FROM v_post_category WHERE post_id = ?'
        const [categories] = await sql.execute(query, [post.post_id])
        const categoryNames = []
        categories.forEach(category => categoryNames
          .push(category.name))
        post.categories = categoryNames
        query = 'SELECT * FROM v_comment WHERE post_id = ?'
        const [commentsRes] = await sql.execute(query, [post.post_id])
        const comments = []
        commentsRes.forEach(comment => {
          comments.push(comment)
        })
        post.comments = comments
      }))
    }
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting posts'
    res.status(500).json({ success: false, message, error: error.message })
  }
}

export const getPostsByCategory = async (req, res) => {
  /* #swagger.tags = ['Publicaciones']
    #swagger.description = 'Devuelve las publicaciones de una categoria.' */
  try {
    const { categoryId } = req.query
    const query = 'SELECT * FROM v_post_by_cat WHERE category_id = ?'
    const [results] = await sql.execute(query, [categoryId])
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting posts'
    res.status(500).json({ success: false, message, error: error.message })
  }
}

export const getPostsByTitle = async (req, res) => {
  /* #swagger.tags = ['Publicaciones']
    #swagger.description = 'Devuelve las publicaciones que contengan la palabra clave.' */
  try {
    let { title } = req.query
    title = '%' + title.replace(/ /g, '%') + '%'
    const query = 'SELECT * FROM v_post WHERE title LIKE (?)'
    const [results] = await sql.execute(query, [title])
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting posts'
    res.status(500).json({ success: false, message, error: error.message })
  }
}

// UPDATE
export const updatePost = async (req, res) => {
  /* #swagger.tags = ['Publicaciones']
    #swagger.description = 'Actualiza una publicación.' */
  /*  #swagger.parameters['userId'] = {
      in: 'query',
      description: 'User id',
      type: 'number'
    } */
  /*  #swagger.parameters['postId'] = {
      in: 'query',
      description: 'Post id',
      type: 'number'
    } */
  /*  #swagger.parameters['body'] = {
              in: 'body',
              schema: {
                  $title: 'I love sports',
                  $content: 'Im retaking golf. I used to play a lot!'
              }
      } */
  let message = 'Missing information'
  try {
    const { userId, postId } = req.query // credentials
    if (!userId || !postId) {
      return res.status(404).json({ success: false, message })
    }
    const ouwnership = await verifyOwnership(userId, postId)
    if (!ouwnership.success) {
      return res.status(404).json(ouwnership)
    }
    if (!req.body.title && !req.body.content) {
      message = 'Iformation to update is missing'
      return res.status(404).json({ success: false, message })
    }
    // update post
    const query = 'UPDATE post SET ? WHERE user_id = ? AND post_id = ?'
    await sql.query(query, [req.body, parseInt(userId), parseInt(postId)])
    message = 'Post updated'
    return res.json({ success: true, message })
  } catch (error) {
    message = 'Error updating post'
    return res.status(500).json({
      success: false,
      message,
      error: error.stack
    })
  }
}

const verifyOwnership = async (userId, postId) => {
  const query = 'SELECT user_id FROM post WHERE post_id = ?'
  const [result] = await sql.query(query, [postId])
  if (result[0]?.user_id.toString() !== userId || result.length === 0) {
    const message = 'The user is not the owner of this post'
    return { success: false, message }
  } else {
    return { success: true }
  }
}

// DELETE
export const deletePost = async (req, res) => {
  /* #swagger.tags = ['Categorías']
    #swagger.description = 'Crea una nueva categoria.' */
  try {
    const { userId, postId } = req.query // credentials
    if (!userId || !postId) {
      const message = 'Missing information'
      return res.status(404).json({ success: false, message })
    }
    // delete post
    const query = 'DELETE FROM post WHERE user_id = ? AND post_id = ?'
    await sql.query(query, [userId, postId])
    const message = 'Post deleted'
    return res.json({ success: true, message })
  } catch (error) {
    const message = 'Error deleting post'
    return res.status(500).json({ success: false, message, error })
  }
}
