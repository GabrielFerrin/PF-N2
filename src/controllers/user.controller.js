import sql from '../db-config.js'

// CREATE
export const createUser = async (req, res) => {
  try {
    // validate body
    const errorList = []
    await validateFields(req.body, errorList)
    await validateEmail(req.body.email, errorList)
    let message = 'Invalid body'
    if (errorList.length > 0) {
      return res.status(404).json({ success: false, message, errorList })
    }
    // create user
    const query = 'INSERT INTO user SET ?'
    const [resutl] = await sql.query(query, [req.body])
    message = 'User created'
    return resutl.json({ success: true, message, id: resutl.insertId })
  } catch (error) {
    const message = 'Error creating user'
    return res.status(500).json({ success: false, message, error })
  }
}

const validateFields = async (body, errorList) => {
  try {
    // validate required fields
    if (!body.name) errorList.push('Name is required')
    if (!body.email) errorList.push('Email is required')
    if (!body.password) errorList.push('Password is required')
    if (!body.role_id) errorList.push('Role id is required')
    if (!body.country_id) errorList.push('Country id is required')
    if (!body.bio) body.bio = ''
    // validate role id
    let query = 'SELECT * FROM role WHERE role_id = ?'
    const [role] = await sql.execute(query, [body.role_id])
    if (role.length === 0) errorList.push('Invalid role id')
    // validate country id
    query = 'SELECT * FROM country WHERE country_id = ?'
    const [country] = await sql.execute(query, [body.country_id])
    if (country.length === 0) errorList.push('Invalid country id')
  } catch (error) {
    errorList.push(error.message)
  }
}

const validateEmail = async (email, errorList) => {
  try {
    // validate email format
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    if (!re.test(email)) errorList.push('Invalid email')
    // validate email uniqueness
    const query = `SELECT * FROM user WHERE email = '${email}'`
    const [res] = await sql.execute(query)
    if (res.length > 0) errorList.push('Email already exists')
  } catch (error) {
    errorList.push(error.message)
  }
}

// READ
export const getUser = async (req, res) => {
  try {
    // credentials
    const { userId } = req.query
    if (!userId) {
      const message = 'User id is required'
      return res.status(404).json({ success: false, message })
    }
    // get user
    const query = 'SELECT * FROM v_users WHERE user_id = ?'
    const [results] = await sql.execute(query, [userId])
    if (results.length === 0) {
      const message = 'User not found'
      return res.status(400).json({ success: false, message })
    }
    delete results[0].password // hide password
    // response
    res.json({ success: true, message: 'Get user', results })
  } catch (error) {
    const message = 'Error getting user'
    res.status(500).json({ success: false, message, error })
  }
}

export const getAllUsers = async (req, res) => {
  try {
    // validate role
    const { userId } = req.query
    if (!(await isAdmin(userId))) {
      const message = 'Unauthorized'
      return res.status(401).json({ success: false, message })
    }
    const query = 'SELECT * FROM v_users'
    const [results] = await sql.execute(query)
    res.json({ success: true, results })
  } catch (error) {
    const message = 'Error getting users'
    res.status(500).json({ success: false, message, error })
  }
}

const isAdmin = async (userId) => {
  const query = 'SELECT role_id FROM user WHERE user_id = ?'
  const [results] = await sql.execute(query, [userId])
  if (results[0].role_id === 1) return true
  return false
}

// UPDATE
export const updateUser = async (req, res) => {
  let message = 'User id is required'
  try {
    const { userId } = req.query // credentials
    if (!userId) {
      return res.status(404).json({ success: false, message })
    }
    const errorList = []
    // validate fields
    await validateFieldsUpdate(req.body, errorList)
    // validate email uniqueness
    if (req.body.email) {
      await validateEmailUpdate(userId, req.body.email, errorList)
    }
    if (errorList.length > 0) {
      message = 'Invalid body'
      return res.status(404).json({ success: false, message, errorList })
    }
    // update user
    const queryParams = Object.keys(req.body)
      .map(key => `${key} = ?`).join(', ')
    const values = [...Object.values(req.body), userId]
    const query = `UPDATE user SET ${queryParams} WHERE user_id = ?`
    await sql.execute(query, values)
    message = 'User updated'
    return res.json({ success: true, message })
  } catch (error) {
    message = 'Error updating user'
    return res.status(500).json({ success: false, message, error })
  }
}

const validateFieldsUpdate = async (body, errorList) => {
  try {
    let query = ''
    // validate role id
    if (body.role_id) {
      query = 'SELECT * FROM role WHERE role_id = ?'
      const [role] = await sql.execute(query, [body.role_id])
      if (role.length === 0) errorList.push('Invalid role id')
    }
    // validate country id
    if (body.country_id) {
      query = 'SELECT * FROM country WHERE country_id = ?'
      const [country] = await sql.execute(query, [body.country_id])
      if (country.length === 0) errorList.push('Invalid country id')
    }
  } catch (error) {
    errorList.push(error.message)
  }
}

const validateEmailUpdate = async (userId, email, errorList) => {
  try {
    // validate email format
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    if (!re.test(email)) errorList.push('Invalid email')
    // validate email uniqueness
    const query = `SELECT * FROM user WHERE email = '${email}'`
    const [res] = await sql.execute(query)
    console.log('res', res[0].user_id)
    console.log('userId', userId)
    if (res.length > 0 && res[0].user_id.toString() !== userId) {
      errorList.push('Email already exists')
    }
  } catch (error) {
    errorList.push(error.message)
  }
}

// DELETE
export const deleteUser = async (req, res) => {
  // delete user's own acount
  try {
    const { userId } = req.query
    if (!userId) {
      const message = 'User id is required'
      return res.status(404).json({ success: false, message })
    }
    const query = 'DELETE FROM user WHERE user_id = ?'
    if (!(await userExists(userId))) {
      const message = 'User not found'
      return res.status(400).json({ success: false, message })
    }
    await sql.execute(query, [userId])
    const message = 'User deleted'
    return res.json({ success: true, message })
  } catch (error) {
    const message = 'Error deleting user'
    return res.status(500).json({ success: false, message, error })
  }
}

const userExists = async (userId) => {
  const query = 'SELECT * FROM user WHERE user_id = ?'
  const [results] = await sql.execute(query, [userId])
  if (results.length === 0) return false
  return true
}
