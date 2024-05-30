import sql from '../db-config.js'

export const isRunning = (req, res) => {
  res.json({ success: true, message: 'Is running' })
}

// CREATE ROLE TABLE
export const createRoleTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS role (
      role_id INT NOT NULL AUTO_INCREMENT,
      name VARCHAR(50) NOT NULL,
      description VARCHAR(255) NOT NULL,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (role_id)
    );`
    await sql.execute(query)
    console.log({ message: 'Role table created' })
  } catch (error) {
    console.log({ message: 'Error creating role table', error })
  }
}

// CREATE COUNTRY TABLE
export const createCountryTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS country (
      country_id INT NOT NULL AUTO_INCREMENT,
      name VARCHAR(50) NOT NULL,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (country_id)
    );`
    await sql.execute(query)
    console.log({ message: 'Country table created' })
  } catch (error) {
    console.log({ message: 'Error creating country table', error })
  }
}

// CREATE USER TABLE
export const createUserTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS user (
      user_id INT NOT NULL AUTO_INCREMENT,
      name VARCHAR(50) NOT NULL,
      email VARCHAR(50) NOT NULL,
      password VARCHAR(255) NOT NULL,
      role_id INT NOT NULL,
      country_id INT NOT NULL,
      bio TEXT NOT NULL,
      image VARCHAR(255),
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (user_id),
      FOREIGN KEY (role_id) REFERENCES role(role_id) ON UPDATE CASCADE ON DELETE RESTRICT,
      FOREIGN KEY (country_id) REFERENCES country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );`
    await sql.execute(query)
    console.log({ message: 'User table created' })
  } catch (error) {
    console.log({ message: 'Error creating user table', error })
  }
}

// CREATE POST TABLE
export const createPostTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS post (
      post_id INT NOT NULL AUTO_INCREMENT,
      title VARCHAR(50) NOT NULL,
      content TEXT NOT NULL,
      user_id INT NOT NULL,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (post_id),
      FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );`
    await sql.execute(query)
    console.log({ message: 'Post table created' })
  } catch (error) {
    console.log({ message: 'Error creating post table', error })
  }
}

// CREATE POST IMAGE TABLE
export const createPostImageTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS post_image (
      post_image_id INT NOT NULL AUTO_INCREMENT,
      post_id INT NOT NULL,
      image VARCHAR(255) NOT NULL,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (post_image_id),
      FOREIGN KEY (post_id) REFERENCES post(post_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );`
    await sql.execute(query)
    console.log({ message: 'Post image table created' })
  } catch (error) {
    console.log({ message: 'Error creating post image table', error })
  }
}

// CREATE COMMENT TABLE
export const createCommentTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS comment (
      comment_id INT NOT NULL AUTO_INCREMENT,
      post_id INT NOT NULL,
      user_id INT NOT NULL,
      content TEXT NOT NULL,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (comment_id),
      FOREIGN KEY (post_id) REFERENCES post(post_id) ON UPDATE CASCADE ON DELETE RESTRICT,
      FOREIGN KEY (user_id) REFERENCES user(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );`
    await sql.execute(query)
    console.log({ message: 'Comment table created' })
  } catch (error) {
    console.log({ message: 'Error creating comment table', error })
  }
}

// CREATE CATEGORY TABLE
export const createCategoryTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS category (
      category_id INT NOT NULL AUTO_INCREMENT,
      name VARCHAR(50) NOT NULL UNIQUE,
      is_deleted TINYINT NOT NULL DEFAULT 0,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (category_id)
    );`
    await sql.execute(query)
    console.log({ message: 'Category table created' })
  } catch (error) {
    console.log({ message: 'Error creating category table', error })
  }
}

// CREATE CATEGORY POST TABLE
export const createPostCategoryTable = async () => {
  try {
    const query = `CREATE TABLE IF NOT EXISTS post_category (
      category_id INT NOT NULL,
      post_id INT NOT NULL,
      date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      date_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      FOREIGN KEY (post_id) REFERENCES post(post_id) ON UPDATE CASCADE ON DELETE RESTRICT,
      FOREIGN KEY (category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT
    );`
    await sql.execute(query)
    console.log({ message: 'Category post table created' })
  } catch (error) {
    console.log({ message: 'Error creating category post table', error })
  }
}
// SEED COUNTRY TABLE
export const seedCountryTable = async () => {
  try {
    const query = `INSERT IGNORE INTO country (country_id, name) VALUES
      ('1', 'Afghanistan'),('2', 'Albania'),('3', 'Algeria'),('4', 'Andorra'),
      ('5', 'Angola'),('6', 'Antigua and Barbuda'),('7', 'Argentina'),
      ('8', 'Armenia'),('9', 'Australia'),('10', 'Austria'),('11', 'Azerbaijan'),
      ('12', 'Bahamas'),('13', 'Bahrain'),('14', 'Bangladesh'),('15', 'Barbados'),
      ('16', 'Belarus'),('17', 'Belgium'),('18', 'Belize'),('19', 'Benin'),
      ('20', 'Bhutan'),('21', 'Bolivia'),('22', 'Bosnia and Herzegovina'),
      ('23', 'Botswana'),('24', 'Brazil'),('25', 'Brunei'),('26', 'Bulgaria'),
      ('27', 'Burkina Faso'),('28', 'Burundi'),('29', 'Cabo Verde'),
      ('30', 'Cambodia'),('31', 'Cameroon'),('32', 'Canada'),
      ('33', 'Central African Republic'),('34', 'Chad'),('35', 'Chile'),
      ('36', 'China'),('37', 'Colombia'),('38', 'Comoros'),('39', 'Congo'),
      ('40', 'Costa Rica'),('41', 'Cote dIvoire'),('42', 'Croatia'),('43', 'Cuba'),
      ('44', 'Cyprus'),('45', 'Czech Republic'),('46', 'Denmark'),
      ('47', 'Djibouti'),('48', 'Dominica'),('49', 'Dominican Republic'),
      ('50', 'East Timor'),('51', 'Ecuador'),('52', 'Egypt'),('53', 'El Salvador'),
      ('54', 'Equatorial Guinea'),('55', 'Eritrea'),('56', 'Estonia'),
      ('57', 'Ethiopia'),('58', 'Fiji'),('59', 'Finland'),('60', 'France'),
      ('61', 'Gabon'),('62', 'Gambia'),('63', 'Georgia'),('64', 'Germany'),
      ('65', 'Ghana'),('66', 'Greece'),('67', 'Grenada'),('68', 'Guatemala'),
      ('69', 'Guinea'),('70', 'Guinea-Bissau'),('71', 'Guyana'),('72', 'Haiti'),
      ('73', 'Honduras'),('74', 'Hong Kong'),('75', 'Hungary'),('76', 'Iceland'),
      ('77', 'India'),('78', 'Indonesia'),('79', 'Iran'),('80', 'Iraq'),
      ('81', 'Ireland'),('82', 'Israel'),('83', 'Italy'),('84', 'Jamaica'),
      ('85', 'Japan'),('86', 'Jordan'),('87', 'Kazakhstan'),('88', 'Kenya'),
      ('89', 'Kiribati'),('90', 'Korea, North'),('91', 'Korea, South'),
      ('92', 'Kuwait'),('93', 'Kyrgyzstan'),('94', 'Laos'),('95', 'Latvia'),
      ('96', 'Lebanon'),('97', 'Lesotho'),('98', 'Liberia'),('99', 'Libya'),
      ('100', 'Liechtenstein'),('101', 'Lithuania'),('102', 'Luxembourg'),
      ('103', 'Macedonia'),('104', 'Madagascar'),('105', 'Malawi'),
      ('106', 'Malaysia'),('107', 'Maldives'),('108', 'Mali'),('109', 'Malta'),
      ('110', 'Marshall Islands'),('111', 'Mauritania'),('112', 'Mauritius'),
      ('113', 'Mexico'),('114', 'Micronesia'),('115', 'Moldova'),
      ('116', 'Monaco'),('117', 'Mongolia'),('118', 'Morocco'),
      ('119', 'Mozambique'),('120', 'Myanmar'),('121', 'Namibia'),
      ('122', 'Nauru'),('123', 'Nepal'),('124', 'Netherlands'),
      ('125', 'New Zealand'),('126', 'Nicaragua'),('127', 'Niger'),
      ('128', 'Nigeria'),('129', 'Norway'),('130', 'Oman'),
      ('131', 'Pakistan'),('132', 'Palau'),('133', 'Panama'),
      ('134', 'Papua New Guinea'),('135', 'Paraguay'),('136', 'Peru'),
      ('137', 'Philippines'),('138', 'Poland'),('139', 'Portugal'),
      ('140', 'Qatar'),('141', 'Romania'),('142', 'Russia'),('143', 'Rwanda'),
      ('144', 'Samoa'),('145', 'San Marino'),('146', 'Sao Tome and Principe'),
      ('147', 'Saudi Arabia'),('148', 'Senegal'),
      ('149', 'Serbia and Montenegro'),('150', 'Seychelles'),
      ('151', 'Sierra Leone'),('152', 'Singapore'),('153', 'Slovakia'),
      ('154', 'Slovenia'),('155', 'Solomon Islands'),('156', 'Somalia'),
      ('157', 'South Africa'),('158', 'Spain'),('159', 'Sri Lanka'),
      ('160', 'Sudan'),('161', 'Suriname'),('162', 'Swaziland'),
      ('163', 'Sweden'),('164', 'Switzerland'),('165', 'Syria'),
      ('166', 'Taiwan'),('167', 'Tajikistan'),('168', 'Tanzania'),
      ('169', 'Thailand'),('170', 'Togo'),('171', 'Tonga'),
      ('172', 'Trinidad and Tobago'),('173', 'Tunisia'),('174', 'Turkey'),
      ('175', 'Turkmenistan'),('176', 'Tuvalu'),('177', 'Uganda'),
      ('178', 'Ukraine'),('179', 'United Arab Emirates'),('180', 'United Kingdom'),
      ('181', 'United States'),('182', 'Uruguay'),('183', 'Uzbekistan'),
      ('184', 'Vanuatu'),('185', 'Vatican City'),('186', 'Venezuela'),
      ('187', 'Vietnam'),('188', 'Yemen'),('189', 'Zambia'),('190', 'Zimbabwe')`
    await sql.execute(query)
    console.log({ message: 'Country table populated' })
  } catch (error) {
    console.log({ message: 'Error populating country table', error })
  }
}

// POPULATE ROLE TABLE
export const seedRoleTable = async () => {
  try {
    const query = `INSERT IGNORE INTO role (role_id, name, description) VALUES
      ('1', 'administrador', 'Posee todos los permisos'),
      ('2', 'usuario', 'Tiene permisos relacionados con sus propios datos')`
    await sql.execute(query)
    console.log({ message: 'Role table populated' })
  } catch (error) {
    console.log({ message: 'Error populating role table', error })
  }
}

// SEED CATEGORIES
export const seedCategories = async () => {
  try {
    const query = `INSERT IGNORE INTO category (category_id, name) VALUES
      ('1', 'Cuidado Personal'),('2', 'Tecnología'),('3', 'Nutrición'),
      ('4', 'Política'),('5', 'Deportes'),('6', 'Cultura'),('7', 'Economía'),
      ('8', 'Ciencia'),('8', 'Educación'),('10', 'Entretenimiento'),
      ('11', 'Salud'),('12', 'Estilo de Vida'),('13', 'Viajes'),
      ('14', 'Deporte')`
    await sql.execute(query)
    console.log({ message: 'Categories table populated' })
  } catch (error) {
    console.log({ message: 'Error populating categories table', error })
  }
}

// SEED USERS
const bioData = [
  'I was born and raised in a small town in the countryside. I studied computer science in college and have been working as a software engineer for the past 5 years. In my free time, I enjoy hiking and playing guitar.',
  'I am a passionate and dedicated learner who is always seeking out new challenges. I am always seeking out new ways to improve my coding skills and stay up-to-date with the latest technologies.',
  'I am a tech enthusiast and love to explore new technologies. I am always looking for new ways to improve my coding skills and stay up-to-date with the latest technologies.',
  'I was born and raised in a small town in the countryside. I studied computer science in college and have been working as a software engineer for the past 5 years. In my free time, I enjoy hiking and playing guitar.',
  'I grew up in a big city and always dreamed of traveling the world. After completing my degree in international relations, I started working for a non-profit organization focused on sustainable development. I love exploring new cultures and meeting people from different backgrounds.',
  'I was born and raised in a family of artists. I studied art history in college and have been working as a curator for a local art museum for the past 3 years. In my free time, I enjoy painting and playing the guitar.',
  'I was born and raised in a small town in the countryside. I studied chemistry in college and have been working as a researcher for a pharmaceutical company for the past 5 years. In my free time, I enjoy hiking and playing tennis.',
  'I grew up in a big city and always dreamed of exploring the world. After completing my degree in international business, I started working for a global consulting firm focused on sustainable development. I love traveling and meeting new people from different cultures.',
  'I was born and raised in a small town in the countryside. I studied biology in college and have been working as a scientist for the past 5 years. In my free time, I enjoy playing guitar and reading.',
  'I was born and raised in a family of artists. I studied architecture in college and have been working as an architect for a local architecture firm for the past 3 years. In my free time, I enjoy painting and playing the guitar.'
]

export const seedUserTable = async (req, res) => {
  try {
    const query = `INSERT IGNORE INTO user
      (user_id, name, email, password, role_id, country_id,  bio, image)
      VALUES
      ('1', 'John Doe', 'john.doe@example.com',
      '12341234', '2', '2', '${bioData[0]}', 'local'),
      ('2', 'Jane Smith', 'jane.smith@example.com',
      '12341234', '1', '1', '${bioData[1]}', 'local'),
      ('3', 'Bob Johnson', 'bob.johnson@example.com',
      '12341234', '2', '2', '${bioData[2]}', 'local'),
      ('4', 'Alice Brown', 'alice.brown@example.com',
      '12341234', '2', '2', '${bioData[3]}', 'local'),
      ('5', 'David Wilson', 'david.wilson@example.com',
      '12341234', '2', '2', '${bioData[4]}', 'local'),
      ('6', 'Emily Davis', 'emily.davis@example.com',
      '12341234', '2', '2', '${bioData[5]}', 'local'),
      ('7', 'Mike Thompson', 'mike.thompson@example.com',
      '12341234', '1', '1', '${bioData[6]}', 'local'),
      ('8', 'Sarah Garcia', 'sarah.garcia@example.com',
      '12341234', '2', '2', '${bioData[7]}', 'local'),
      ('9', 'Michael Smith', 'michael.smith@example.com',
      '12341234', '2', '2', '${bioData[8]}', 'local'),
      ('10', 'Emma Johnson', 'emma.johnson@example.com',
      '12341234', '2', '2', '${bioData[9]}', 'local')`
    await sql.execute(query)
    console.log({ message: 'Users table populated' })
  } catch (error) {
    console.log({ message: 'Error populating categories table', error })
  }
}

// SEED ALL TABLES
export const seedAllTables = async () => {
  try {
    await seedUserTable()
    await seedCountryTable()
    await seedRoleTable()
    await seedCategories()
  } catch (error) {
    console.log({ message: 'Error populating all tables', error })
  }
}

// CREATE ALL TABLES
export const createAllTables = async () => {
  try {
    await createRoleTable()
    await createCountryTable()
    await createUserTable()
    await createPostTable()
    await createCommentTable()
    await createCategoryTable()
    await createPostCategoryTable()
    await createPostImageTable()
  } catch (error) {
    console.log({ message: 'Error creating all tables', error })
  }
}

// CLEAR TABLES
export const eliminateAllTables = async () => {
  try {
    await eliminateTable('comment')
    await eliminateTable('post_category')
    await eliminateTable('post_image')
    await eliminateTable('post')
    await eliminateTable('country')
    await eliminateTable('user')
    await eliminateTable('role')
    await eliminateTable('category')
  } catch (error) {
    console.log({ message: 'Error eliminating all tables', error })
  }
}

export const emptyTable = async (tableName) => {
  try {
    const query = `TRUNCATE TABLE IF EXISTS ${tableName}`
    await sql.execute(query)
    console.log({ message: `${tableName} table cleared` })
  } catch (error) {
    console.log({ message: 'Error clearing table', error })
  }
}

export const eliminateTable = async (tableName) => {
  try {
    const query = `DROP TABLE IF EXISTS ${tableName}`
    await sql.execute(query)
    console.log({ message: `${tableName} table eliminated` })
  } catch (error) {
    console.log({ message: 'Error eliminating table', error })
  }
}
