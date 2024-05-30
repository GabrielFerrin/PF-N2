import sql from '../db-config.js'

// CREATE
export const createPost = async (req, res) => {
  let message = 'Missing user id'
  try {
    const { userId } = req.query // credentials
    if (!userId) {
      return res.status(400).json({ success: false, message })
    }
    // validate categories
    const errorList = []
    const { categories } = req.body
    await validateCategories(categories, errorList)
    // validate body
    await validateFields(req.body, userId, errorList)
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(400).json({ success: false, message, errorList })
    }
    delete req.body.categories
    console.log(categories)
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

const validateFields = async (body, userId, errorList) => {
  try {
    // validate required fields
    if (!body.title) errorList.push('Title is required')
    if (!body.content) errorList.push('Content is required')
    if (!body.user_id) errorList.push('User id is required')
    const message = 'Aunothorized procedure. Id conflict.'
    if (body.user_id !== userId) errorList.push(message)
    // validate user id
    const query = 'SELECT * FROM user WHERE user_id = ?'
    const [user] = await sql.execute(query, [userId])
    if (user.length === 0) errorList.push('Invalid user id')
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
  try {
    let query = 'SELECT * FROM v_post'
    const [results] = await sql.execute(query)
    if (results.length > 0) {
      await Promise.all(results.map(async (post) => {
        query = 'SELECT * FROM v_post_category WHERE post_id = ?'
        const [categories] = await sql.execute(query, [post.post_id])
        const categoryNames = []
        categories.forEach(category => categoryNames.push(category.name))
        post.categories = categoryNames
      }))
    }
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting posts'
    res.status(500).json({ success: false, message, error: error.message })
  }
}

export const getPostsByCategory = async (req, res) => {
  try {
    const { category } = req.query
    const query = 'SELECT * FROM post WHERE category LIKE (%?%)'
    const [results] = await sql.execute(query, [category])
    if (results.length > 0) {
      await Promise.all(results.map(async (post, index) => {
        const [user] = await sql.execute(query, [post.user_id])
        post.user = user[0].name
      }))
    }
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting posts'
    res.status(500).json({ success: false, message, error: error.message })
  }
}

export const getPostsByTitle = async (req, res) => {
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
  try {
    const { userId, postId } = req.query // credentials
    if (!userId || !postId) {
      const message = 'Missing information'
      return res.status(404).json({ success: false, message })
    }
    // update post
    const query = 'UPDATE post SET ? WHERE user_id = ? AND post_id'
    await sql.query(query, [req.body, userId, postId])
    const message = 'Post updated'
    return res.json({ success: true, message })
  } catch (error) {
    const message = 'Error updating post'
    return res.status(500).json({ success: false, message, error })
  }
}

// DELETE
export const deletePost = async (req, res) => {
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
