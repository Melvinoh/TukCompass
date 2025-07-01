import jwt from 'jsonwebtoken';
import { User } from '../modules/Users.js';

const secretKey = process.env.JWT_SECRET;

export const authenticate = async (req, res, next) => {
  const authHeader = req.headers.authorization

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Unauthorized: No token provided' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, secretKey);
    req.user = await User.findByPk(decoded.userID);
    if (!req.user) {
      return res.status(401).json({ message: 'Unauthorized: User not found' });
    }
    next();
  } catch (error) {
    console.error('Error during token verification:', error);
    return res.status(401).json({ message: 'Unauthorized: Invalid token' });
  }
};

