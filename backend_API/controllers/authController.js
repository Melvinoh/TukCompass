import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import bycrypt from 'bcrypt';
import { User } from '../modules/Users.js';

dotenv.config();
const secretKey = process.env.JWT_SECRET;

export const login = async (req, res) =>  {

    
   const { username, password } = req.body;
    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }
    try {
        
        const user = await User.findOne({ where: { username } });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const checkpassword = await bycrypt.compare(password, user.password);

        if (!checkpassword) {
            return res.status(401).json({ message: 'Invalid password' });
        }

        const token = jwt.sign({ userID: user.userID }, secretKey, { expiresIn: '1d' });

        return res.status(200).json({
            message: 'Login successful',
            token,
            user: {
                userID: user.userID,
                username: user.username,
                email: user.email
            }
        });

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ message: 'Internal server error' });
        
    }
   
}

