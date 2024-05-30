import sql from '../db-config.js'
import { isAdmin } from './user.controller.js'

// CREATE
export const createCategory = async (req, res) => {
  let message = 'Missing user id'
  try {
    const { userId } = req.query
    if (!userId) {
      return res.status(400).json({ success: false, message })
    }
    if (!await isAdmin(userId)) {
      const message = 'Unauthorized'
      return res.status(401).json({ success: false, message })
    }
    // validate body
    const errorList = []
    await validateFields(req.body, errorList)
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(400).json({ success: false, message, errorList })
    }
    // create category
    const query = 'INSERT INTO category SET ?'
    const [result] = await sql.query(query, [req.body])
    const categoryId = result.insertId
    message = 'Category created'
    return res.json({ success: true, message, id: categoryId })
  } catch (error) {
    let message = 'Category name already exists'
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(404).json({ success: false, message })
    }
    message = 'Error creating category'
    return res.status(500).json({ success: false, message, error })
  }
}

const validateFields = async (body, errorList) => {
  // validate required fields
  if (!body.name || body.name === '') errorList.push('Name is required')
}

// READ
export const getAllCategories = async (req, res) => {
  try {
    const query = 'SELECT * FROM category'
    const [result] = await sql.query(query)
    return res.json({ success: true, categories: result })
  } catch (error) {
    const message = 'Error getting categories'
    return res.status(500).json({ success: false, message, error })
  }
}

// UPDATE
export const updateCategory = async (req, res) => {
  let message = 'Missing information'
  try {
    const { userId, categoryId } = req.query
    if (!userId || !categoryId) {
      return res.status(400).json({ success: false, message })
    }
    if (!await isAdmin(userId)) {
      const message = 'Unauthorized'
      return res.status(401).json({ success: false, message })
    }
    // validate body
    const errorList = []
    await validateFields(req.body, errorList)
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(400).json({ success: false, message, errorList })
    }
    // update category
    const query = 'UPDATE category SET ? WHERE category_id = ?'
    const [result] = await sql.query(query, [req.body, categoryId])
    message = 'Category updated'
    return res.json({ success: true, message, id: result.insertId })
  } catch (error) {
    const message = 'Error updating category'
    return res.status(500).json({ success: false, message, error })
  }
}

// DELETE
export const deleteCategory = async (req, res) => {
  let message = 'Missing information'
  try {
    const { userId, categoryId } = req.query
    if (!userId || !categoryId) {
      return res.status(400).json({ success: false, message })
    }
    if (!await isAdmin(userId)) {
      const message = 'Unauthorized'
      return res.status(401).json({ success: false, message })
    }
    // delete category
    const query = 'DELETE FROM category WHERE category_id = ?'
    const [result] = await sql.query(query, [categoryId])
    message = 'Category deleted'
    return res.json({ success: true, message, id: result.insertId })
  } catch (error) {
    let message = 'Foreign key constraint failed. The category has posts.'
    if (error.code === 'ER_ROW_IS_REFERENCED_2') {
      return res.status(404).json({ success: false, message })
    }
    message = 'Error deleting category'
    return res.status(500).json({
      success: false,
      message,
      error: error.stack
    })
  }
}
