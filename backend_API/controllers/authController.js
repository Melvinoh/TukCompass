import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import bycrypt from 'bcrypt';
import { User } from '../modules/Users.js';

dotenv.config();
const secretKey = process.env.JWT_SECRET;

export const login = async (req, res) =>  {

    
   const { userID, password } = req.body;
    if (!userID || !password) {
        return res.status(400).json({ message: 'UserID and password are required' });
    }
    try {

        const user = await User.findOne({ where: { userID } });

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const checkpassword = await bycrypt.compare(password, user.password);

        if (!checkpassword) {
            return res.status(401).json({ message: 'Invalid password' });
        }

        const token = jwt.sign({ userID: user.userID }, secretKey, { expiresIn: '10d' });

        return res.status(200).json({
            message: 'Login successful',
            token,
            user: user
        });

    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ message: 'Internal server error' });
        
    }
   
}

